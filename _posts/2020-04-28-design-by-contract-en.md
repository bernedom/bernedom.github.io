---
layout: post
title: Robust code with design by contract
thumbnail: images/design-by-contract/thumbnail.png
---

**99.9% of software bugs are caused by programmer mistakes.** Testing and code review helps, but are not enough. It would be so much nicer if bad code could be caught earlier. With *Design by contract* we software engineers get such a tool into our hands. Code becomes not just more correct by using design by contract, it also becomes more readable and much more robust against regression bugs. Unfortunately contracts did not make it into C++20 but having basic support for it is easy to achieve. 

## Maintainable and robust code

Clean Code, [SOLID](https://en.wikipedia.org/wiki/SOLID) and paradigms like "[low coupling, strong cohesion](https://en.wikipedia.org/wiki/Coupling_(computer_programming))" are important for code-quality. But quality starts at a much lower level at the readability of the code. At the core of this lies the ability to **understand the intent behind written code**. If this intent can be formally verified, code is not just maintainable but becomes robust and maintainable. 

Robustness in code means that software can not fall unexpectedly into an undefined state. It also means that by changing something on one end there are no regression bugs on another end. No matter what problem a piece of software solves, correct behavior of the software lies at the very core of software quality. If a software does not have this, frequent crashes, data loss, frozen displays are the result. 

With **Design by Contract** robustness of code can be enhanced quite easily and with great effect. 

## Design by contract - the background 

It was [Bertrand Meyer](https://en.wikipedia.org/wiki/Bertrand_Meyer) who coined the term "Design by contract" in the late 80ies in the programming language eiffel. It is also known as *contract programming* or *programming by contract* but they are less frequently used. At the core the concept describes the implementation of the [hoare triplet](https://en.wikipedia.org/wiki/Hoare_logic) for ensuring the correctness off software. 
The triplet is defined as `{P}C{Q}` and says if the precondition `P` is true, then the post condition `Q` becomes true through the execution of the code `C`. As such `P` and `Q` are assertions and `C` is the program logic. 

The "contract" is a metaphor for the programmer as "consumer" and the software as "supplier" for code. The contract regulates the obligations and expected benefits between two parties. An example for a function to calculate the square root of a value could look like this:

|               | **Obligation**                                                  | **Benefit**                                                                       |
 | ------------- | ------------------------------------------------------------------ | -------------------------------------------------------------------------------- |
 | **Consumer** | *Must ensure precondition* <br>The input has to be positive | *May benefit from the post-condition*<br>Get the square root of the input value |
 | **Supplier**  | *Must ensure postcondition* <br>Calculate the square root | *May expect pre-condition*<br>No need to implement imaginary numbers  |

Typically the keywords `Require` and `Ensure` are used for the pre- and post-condition and the content of the contract is a boolean expression. The [C++ library bertrand](https://github.com/bernedom/bertrand) provides a simple implementation for the keywords.

Or as code: 
```cpp

float square_root(float f)
{
    Require(f => 0); // precondition
    ... /// implementation

    // post condition
    Ensure((result * result) - f < std::numeric_limimts<float>::epsilon); 
    return result; 
}
```

A third keyword is `Invariant` which indicates that a condition is not to be violated at any point during runtime ant that this condition is considered an axiom in the relevant execution context. These invariants are most often enountered when doing object orientedd progamming and and using polymorphism. Invariants are very helpful in keeping object consistency and giving hints about expected behavior of classes and functions. 

### Invariants in classes

As an example let us assume a badly implemented list that contains each value only once, but the user is expected to check that outsie. When putting contracts in it an implementation of it could look like this. 

```cpp
class UniqueIntList {
public:
  void add(int element) {
    Require(!has_element(element));
    list_.emplace_back(element);
    Ensure(has_element(element));
    Invariant(count() <= capacity());
  }

  int get_element_at(size_t idx) const {
    Require(idx < count());
    return list_[idx];
  }

  bool has_element(int element) const {
    return std::find(list_.begin(), list_.end(), element) \
      != list_.end();
  }
  size_t capacity() const { return list_.capacity(); }
  size_t count() const { return list_.size(); }

private:
  vector<int> list_;
};
```

By decorating the class with contracts. It is explicitly stated that the user has to check the uniqueness of the values outside of the class. Of course the clean way would be to fix the list, but as a first step this allows us to find any misuse of the class in our code. Also on the other hand the complexity of the code inside the class is much reduced, as the discussion about how to handle duplicates is not handled. 

### Polymorphism

When inheriting from classes the following rules apply to contracts:

* **Invariants** are kept as is
* **Preconditions** for methods are allowed to be softer, but most not be strengthened
* **Postconditions** are allowed to be stronger, but must not be weakened

Subclasses work in a more loose context than their parents, but they have to ensure the same post-conditions as their.

## Practical use

The first and most apparent use of contracts is that programming errors are detected earlier and with hints where they happen. Contracts also work as formal documentation that can be checked by running the program. 
This in itself helps the design process of software, as it allows defining interfaces and expected behavior early on. Often even before an actual implementation. Having the context of a method explicitly stated helps fostering constructive discussion on the design tremendously. 
And having this context defines often helps with reducing the complexity of a program as a whole as error and exception handling and can often be moved to a defined point and does not need to be repeated all over the place. 

It is to be mentioned that contracts are a tool for the programmer, not an error message exposed to the end-user of the software

## Contracts and unit testing. 

Design by contract does not replace testing, but supplements it. While unit- and integration testing cover the correct behavior of the software, contracts confirm correct usage by the programmer. As a consequence, if a contract fails even a positive test result is not to be trusted. By applying contracts, the number of test cases can be reduced as not every edge case has to be tested everywhere. 

![Design by contract in relation to testing. Showing design by contract as overlap between correct usage, correct behavior and semantic context of software]({{site.baseurl}}/images/design-by-contract/contract_testing_docu.png)

Checking the contracts influences the runtime and overall performance of the software, so they are usually removed from the deployed, tested software. The programmer also has to be aware of these influences, so a clear separation from non-functional testing like memory consumption or real-time behavior is necessary. 

## And now? 

Design by contract is a powerful tool to increase the quality of software. Unfortunately it is rarely used in programming, for the lack of support in programming languages and knowledge in programmers. The effort to get going and start with it is however not that big and the benefits are many. From more explicit discussions about intended design to faster feedback on quality through the fail-early-fail-hard mentality applied to coding. So why wait? Start using it, wherever you are currently coding!
