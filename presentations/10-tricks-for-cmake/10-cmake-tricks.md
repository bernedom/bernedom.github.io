name: title
layout: true
class: center, middle, inverse

.footer[ [![twitter](twitter_icon.png) @BernerDominik](https://twitter.com/BernerDominik)]
---

10 hot tricks for beautiful CMake
===


### Dominik Berner

???

# Begrüssung


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

* No ${PROJECT_NAME} targets - semantically different meaning - Kill the thing
* Presets - possible a bigger one by itself
* ccmake and cmake-gui (console yay)
  * Tweaking environment variables
* conan integration instead of fetch content
* Generator expressions 
* custom commands / custom targets dependent on each other
* Cmake in script mode for platform independent commands
* ccache
* sanitizers etc
  * Custom build types
  * Code coverage 
  * static code analysis (iwyu)
* Test orchestration
  * test grouping/test parallization
  * test timeouts
  * test ressources 
  * defining fixtures 
* Running tests in an emulator when cross compiling
* Search order for sysroots (setting BOTH etc) - individual programs
* toolchain checks (very advanced)
* cmake profiling 
* Packaging and installing
* Q&A 


---



