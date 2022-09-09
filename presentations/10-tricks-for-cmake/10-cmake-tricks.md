name: title
layout: true
class: center, middle, inverse

.footer[ [![twitter](twitter_icon.png) @BernerDominik](https://twitter.com/BernerDominik)]
---

10 hot tricks for beautiful CMake
===


### Dominik Berner

???

# Welcome

* ask about experience with CMake 

---

# Dominik Berner

### C++ Coder, Agilist & Rock Climber
.left-column[
 ![Me](profile_picture_presenting.jpg)
]
.right-column[
.left[
[![web](web_icon.png) dominikberner.me](http://dominikberner.ch)

[![twitter](twitter_icon.png) @BernerDominik](https://twitter.com/BernerDominik)

[![github](github_icon.png) bernedom](https://github.com/bernedom)

[![mail](mail_icon.png) dominik.berner@bbv.ch](mailto:dominik.berner@bbv.ch)
]
]
 

???

Brainstorm:

book plug 1 slide


* Presets - possible a bigger one by itself
  * CMakePresets.json and CMAkeUserPrestes.json
  * Presets and cross compiling using toolchains 
  * inheriting 
* Cmake in script mode for platform independent commands
* Test orchestration
  * test grouping/test parallization
  * test timeouts
  * test ressources 
  * defining fixtures 
  * Running tests in an emulator when cross compiling

* speeding up cmake   
  * cmake profiling 
  * unity builds
  * precompiled headers 
  * ccache
* CMake dependency graphs
* DLL Symbol visibility
  * SHARED STATIC defined by preset
* Dependency management
  find_package to rule them all
  * Upstream over find_package over FetchContent/ExternalProject

Small but useful
* export compile commands
* No ${PROJECT_NAME} targets - semantically different meaning - Kill the thing 

* Generator expressions - Explained

* custom commands / custom targets dependent on each other

* ccache
* sanitizers etc
  * Custom build types
  * Code coverage 
  * static code analysis (iwyu)

* Search order for sysroots (setting BOTH etc) - individual programs
* toolchain checks (very advanced)

* Packaging and installing
* Q&A 


* ccmake and cmake-gui (console yay)
  * Tweaking environment variables
* conan integration instead of fetch content

---

CMake Best Practices - The book
===

.left-column[
 ![CMake Best Practices Cover](book_cover.png)
]
.right-column[
.left[
Get it from [packt](https://www.packtpub.com/product/cmake-best-practices/9781803239729)
QR Code
10% voucher
]
]



