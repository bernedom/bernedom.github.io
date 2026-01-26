--- 
layout: post
title: "Encryption at rest for embedded Linux devices using LUKS"
description: "Encryption at rest for embedded Linux devices based on raspberry pi CM4 using the yocto project"
image: /images/secure-boot-yocto/secure-boot-yocto-thumb.jpg
hero_image: /images/secure-boot-yocto/secure-boot-yocto.jpg
hero_darken: true
tags: secure-boot yocto embedded-linux
lang: en
author: Dominik Berner
---

**As embedded devices store more and more sensitive data, encryption-at-rest becomes a critical requirement.** Especially for devices that are publicly accessible or deployed in untrusted environments, protecting data while the device is powered down is essential. Together with [secure boot](https://softwarecraft.ch/secure-boot-yocto/), encryption at rest ensures that data stored on the device remains confidential and tamper-proof, even if the device is physically compromised. This article describes how to implement LUKS encryption for embedded Linux devices based on the Raspberry Pi Compute Module 4 using the Yocto Project.

## Encryption at rest in embedded Linux in a nutshell

On a high level, encryption at rest means that all data stored on the device is encrypted when the device is powered off. This ensures that if an attacker gains physical access to the device, they cannot read the data without the encryption key. In practice, this is typically achieved by encrypting the root filesystem and any other sensitive partitions using a strong encryption algorithm such as AES. When the device boots up, the encryption key is retrieved from a secure location (e.g., One-Time Programmable memory) and used to unlock the encrypted partitions, allowing the operating system to access the data as needed. While this adds some complexity to the boot process and comes with a slight performance overhead for I/O operations, the security benefits far outweigh these drawbacks for most applications.

In practice for embedded Linux devices, encryption at rest can be implemented using LUKS (Linux Unified Key Setup), which is a widely used disk encryption specification for Linux. The tool to manage LUKS encrypted partitions is `cryptsetup` and is well supported in the Linux kernel. 

The general flow for implementing encryption at rest using LUKS on embedded Linux devices is as follows:

1. Instead of booting directly into the root filesystem, the bootloader first loads an initramfs image.
2. The initramfs image contains an init script that invokes `cryptsetup` to unlock the encrypted partitions.
3. The init script retrieves the encryption key from a secure location, such as One-Time Programmable (OTP) memory, and uses it to unlock the LUKS-encrypted root filesystem.
4. Once the root filesystem is unlocked, the init script switches to the unlocked root filesystem and continues the normal boot process.


## Creating a LUKS-encrypted root filesystem with Yocto

To implement encryption at rest using LUKS on embedded Linux devices based on the Raspberry Pi Compute Module 4 with the Yocto Project, the following steps are necessary:

* Create an initramfs image that includes the `cryptsetup` tool and any necessary dependencies.
* Modify the bootloader configuration to load the initramfs image during the boot process.
* Create an init script within the initramfs that handles the unlocking of the LUKS-encrypted root filesystem using the encryption key stored in OTP memory.

Since the encryption of the partitions is device specific and needs to be done only once, a provisioning process is required during the first boot of the device. As a consequence, device image created from yocto is unencrypted initially and will only be encrypted during the provisioning process. A convenient way to achieve this is to use an A/B partition scheme, where one partition is used for provisioning and the other for normal operation. During the first boot, the init script generates a unique encryption key for the device, creates the LUKS-encrypted root filesystem, copies the unencrypted root filesystem into the encrypted container, and stores the encryption key in OTP memory. On subsequent boots, the init script retrieves the encryption key from OTP memory and unlocks the LUKS-encrypted root filesystem for normal operation. So the init script needs to handle two scenarios: the first boot (provisioning) and subsequent boots (normal operation). But first of all, the initramfs image needs to be created and the bootloader configuration modified.


### Create initramfs with cryptsetup

Since the initramfs is just a minimal Linux image, we can create it using Yocto by defining a custom image recipe. The image recipe should include the `cryptsetup` package and any other necessary dependencies. Here is an example of how to create an initramfs image with `cryptsetup`. Let's call this recipe `initramfs-cryptsetup.bb`:

```bash
inherit core-image

PACKAGE_INSTALL = "provisioning-initramfs-init cryptsetup e2fsprogs rsync userland openssl rpi-eeprom"

IMAGE_FEATURES = ""

PACKAGE_EXCLUDE = "kernel-image-*"

IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"

INITRAMFS_MAXSIZE = "262144"

do_install_bootfiles() {
    
    install -m 644 ${IMGDEPLOYDIR}/${IMAGE_BASENAME}-${MACHINE}.cpio.gz ${DEPLOY_DIR_IMAGE}/bootfiles/initramfs.cpio.gz
    
}

addtask do_install_bootfiles after do_image_cpio before do_image_complete
```

If we look at this a bit closer, we can see that the image recipe inherits from `core-image`, which provides a basic image structure. The `PACKAGE_INSTALL` variable specifies the packages to be included in the initramfs image, including `cryptsetup` for LUKS support `provisioning-initramfs-init`, which is our custom package that contains the init script for handling the unlocking of the LUKS-encrypted root filesystem.  Additionally, other necessary packages such as `e2fsprogs`, `rsync`, `userland`, `openssl`, and `rpi-eeprom` are included to support various functionalities required for the provisioning process, create the encryption keys and store them in the OTP memory of the Raspberry Pi CM4.
Since the initramfs is intended to only run the provisioning and unlocking process, we exclude the kernel image packages by setting the `PACKAGE_EXCLUDE` variable to `kernel-image-*`. The `IMAGE_FSTYPES` variable is set to `${INITRAMFS_FSTYPES}` to specify the desired initramfs file types (e.g., cpio.gz). The `INITRAMFS_MAXSIZE` variable is set to `262144` (256MB) to define the maximum size of the initramfs image. `IMAGE_FEATURES` is deliberately left empty to avoid including unnecessary features in the initramfs image.
The `do_install_bootfiles` function installs the generated initramfs image to the appropriate location for the bootloader to access it during the boot process. Next let's look at the init script that handles the unlocking of the LUKS-encrypted root filesystem.

### Modify bootloader configuration to load initramfs

To modify the bootloader configuration to load the initramfs image during the boot process, we need to update the bootloader settings to include the initramfs image. For Raspberry Pi devices, this is typically done by modifying the `config.txt` file located in the boot partition. In the case of the Raspberry Pi recipes this can be achieved by modifying the `RPI_EXTRA_CONFIG` variable in the machine configuration file (e.g., `raspberrypi4.conf` or `raspberrypi-cm4.conf`). Here is an example of how to modify the bootloader configuration to load the initramfs image:   

```bash
RPI_EXTRA_CONFIG += "
...
initramfs initramfs.cpio.gz\n\
..."
```

This tells the bootloader to load the specified initramfs image (`initramfs.cpio.gz`) during the boot process, but it is only half the story. To make this accessible, we also need to make sure that the initramfs image is copied to the `boot.img` container during the image creation process. If your distribution is not yet using secure boot, I suggest to implement this first. Here is a [step by step guide for secure boot using yocto](https://softwarecraft.ch/secure-boot-yocto/). 

In the recipe creating the `boot.img` we need to add the dependency to our initramfs image and copy it into the boot image. Here is an example of how to do this:

```bash

inherit deploy nopackages

DEPENDS += "rpi-bootfiles rpi-cmdline rpi-config linux-raspberrypi dosfstools-native mtools-native initramfs-cryptsetup"

# The raspberry pi bootloader files are located in the following directories
BOOTFILES_DIR = "${WORKDIR}/bootfiles" 
DTBO_DIR = "${DEPLOY_DIR_IMAGE}"

S = "${WORKDIR}/boot-img-container"

do_compile() {
    ...
   # Create boot.img file cope, omitted for brevity here
   ...
}

do_compile[depends] += "initramfs-cryptsetup:do_install_bootfiles"

```

By adding the `initramfs-cryptsetup` dependency to the `DEPENDS` variable, we ensure that the initramfs image is built before the `boot.img` is created. The `do_compile[depends]` line ensures that the initramfs image is installed to the bootfiles directory before creating the `boot.img`. With these modifications and together with the modificaiton of the `RPI_EXTRA_CONFIG` variable, the initramfs will be included in the `boot.img` and loaded by the bootloader during the boot process. At this point we have everything in place to handle the unlocking of the LUKS-encrypted root filesystem during boot, except the logic to actually unlock the file systems.

### Init script for unlocking LUKS-encrypted root filesystem

The init script is responsible for handling both the provisioning process during the first boot and the normal unlocking process during subsequent boots. First we create a new recipe for our init script, let's call it `provisioning-initramfs-init.bb`:

```bash
SRC_URI = "file://provisioning-initramfs-init"

# Installs shell and binaries required for the initscript
RDEPENDS:${PN} += "${VIRTUAL-RUNTIME_base-utils}"

do_install() {
    # Install the init script itself
    install -m 0755 ${WORKDIR}/provisioning-initramfs-init ${D}/init
    # Kernel will panic if /dev doesn't exist
    install -d ${D}/dev
    # Required for logging to work
    mknod -m 622 ${D}/dev/console c 5 1

    # Add the mount points
    install -d ${D}/mnt
}

FILES:${PN} = "/init /dev/console /proc /sys /mnt"
```

This recipe is included in the initramfs image by adding it to the `PACKAGE_INSTALL` variable in the `initramfs-cryptsetup.bb` recipe as shown earlier. The actual init script (`provisioning-initramfs-init`) contains the logic for both the provisioning and normal unlocking processes. Additionally, it creates the `/dev` directory and the `/dev/console` device to allow for logging over uart, but this is manly for debug purposed. 

```bash


********** IMAGE with the two paths **********








- depend on secure-boot (link)
- create initramfs with cryptsetup (packed into boot.img)
- initscript
    - first time provisioning (generate key, encrypt rootfs, store key in OTP memory)
        - A/B boot & data partition
    - normal boot (load key from one time storage, unlock rootfs)

- provisioning is the critical part
    - key generation per device
    - create luks containers without deleting data (not possible, needs provisioning partition)
        - can be done by "cross-population" from A/B or defined external source (i.e. USB stick or similar)
    - store rootfs into luks container 
    - provisioning flow:
         - setup secure boot
        - use .wic with all partitions and unencrypted rootfs
        - first boot: generate key, create luks container, copy rootfs into luks container, store key in otp, mark provisioning done
        - reboot into encrypted rootfs
