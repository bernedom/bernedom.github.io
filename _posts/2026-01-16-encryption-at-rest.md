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
