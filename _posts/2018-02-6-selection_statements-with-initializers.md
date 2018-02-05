---
layout: post
title: Write C++ code easier with initializers in selection statements 
thumbnail: images/logo_bbv_thumb.png
---

**C++ is hard!** Luckily the new standards brought some features and tools to make writing C++ easier. Selection statements with initializers are one of these small-but-nice features that make our coding-life easier. 

With the introduction of C++17 ```if``` and ```switch``` statements can be initialized inside the statement instead of as before only outside the statement. Variables that are only used in the condition or inside the body of the selection statement can be assigned a value similar to what we know from ```for``` loops. So in modern C++ we can write:
```
if (unsigned i = std::rand(); i % 2 == 0) {
	std::cout << "i is even" << std::endl;
} else {
	std::cout << "i is odd" << std::endl;
}
```

The most obvious benefit is that code becomes a tiny bit more compact the alternative we're using up to now. 
``` unsigned i = std::rand(); if(i % 2 == 0) ...```

Apart from a bit better readability, using the initializers helps with scoping temporary variables to the statement. In the second/old example ```i``` is in the scope *surrounding* the if-else block using a initializer in the second example ```i``` is de-scoped on the closing bracket of the if or else block. This is of course only useful if the conditional variable was a true temporary variable and not something to be reused a few times. Because of this scoping initializers in selection statements should usually only be used with functions returning data by value and not by reference. It is possible to manually delete a variable that was created like this inside the selection statement, but I do not consider this nice form, because the cleanup-code has to be duplicated for each case (if, else or each case in a switch-statement). 


Initializers in selection statements become even more fun if combined with *structured bindings* which is one of my favorite features of C++17. This allows for instance for easy and readable consistency checks in fixed size containers.  
``` 
 if(const auto [x,y,z] = func_returning_a_tuple(); x + y  < z)
 { // Do something } 
 ``` 

A word of warning is that each ```if``` opens it's own scope, so be careful when reinitializing variables in chained ```else if``` expressions.

All in all the initializers in selection statement are not the biggest change in C++, nor are they the feature which probably has the most impact on how code is written, but they are a very good example on the direction modern C++ is taking. 
 

(This article was originally [published at bbv.ch in german](http://blog.bbv.ch/2017/12/12/cpp17-was-bringt-der-neue-standard/))
![bbv software services logo]({{ site.baseurl }}/images/logo_bbv_thumb.png)
