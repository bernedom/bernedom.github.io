--- 
layout: post
title: Robust code with design by contract
image: /images/design-by-contract/thumbnail.png
hero_image: /images/design-by-contract/thumbnail.png
hero_darken: true
tags: software-quality
--- 

**99.9% of software bugs are caused by programmer mistakes.** Testing and code reviews help, but are not enough. If bad code could be caught even earlier, that would be so much nicer. With *Design by contract* we software engineers get a tool that does exactly that. Design by Contract not just makes code more correct, it also makes it more readable and much more robust against regression bugs.

## Maintainable and robust code

Clean Code, [SOLID](https://en.wikipedia.org/wiki/SOLID) and paradigms like "[low coupling, strong cohesion](https://en.wikipedia.org/wiki/Coupling_(computer_programming))" are important for code-quality. But quality starts at a much lower level: at the readability of the code. Making **Understanding the intent behind written code** easy is a tremendous boost for software maintainability. If this intent can be formally verified code becomes also very robust against unintended side effects. 

On a technical level, robustness means that software can not fall into an undefined state. It also means that by changing something on one end there are no hidden regression bugs on another end.  If a software is not behaving correctly, frequent crashes, data loss, frozen displays, or worse are the result. 

With **Design by Contract** robustness of code can be enhanced quite easily and with great effect. 

## Design by contract - the background 

[Bertrand Meyer](https://en.wikipedia.org/wiki/Bertrand_Meyer) coined the term "Design by contract" in the late 80ies in the programming language Eiffel. *contract programming* or *programming by contract* are other, less frequently used names of the same concept. At the core, the concept describes the implementation of the [hoare triplet](https://en.wikipedia.org/wiki/Hoare_logic) for ensuring the correctness off software. 
Defined as `{P}C{Q}`, the triplet and says if the precondition `P` is true, then the post condition `Q` becomes true through the execution of the code `C`. As such `P` and `Q` are thus assertions and `C` is the program logic. 

The "contract" is a metaphor for the programmer as "consumer" and the software as "supplier" for code. The contract regulates the obligations and expected benefits between two parties. An example contract for a function for calculating the square root of a value could look like this:

|               | **Obligation**                                                  | **Benefit**                                                                       |
 | ------------- | ------------------------------------------------------------------ | -------------------------------------------------------------------------------- |
 | **Consumer** | *Must ensure precondition* <br>The input has to be positive | *May benefit from the post-condition*<br>Get the square root of the input value |
 | **Supplier**  | *Must ensure post-condition* <br>Calculate the square root | *May expect pre-condition*<br>No need to implement imaginary numbers  |

Typically the keywords `Require` and `Ensure` are used for the pre- and post-condition and the content of the contract is a boolean expression. 

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
(The [C++ library bertrand](https://github.com/bernedom/bertrand) provides a simple and easy to integrate implementation for the keywords.)



### Invariants and classes

A third keyword is `Invariant` which indicates that a condition is not to be violated at any point during runtime ant that this condition is considered an axiom in the relevant execution context. Invariants are often encountered in object-oriented programming as they help to kepp object consistency and give hints about the expected behavior of classes and functions. 

As an example let us assume a (badly implemented) list that contains each value only once, but the user is expected to check that outsdie. Without contracts, the coder looking at the code has no clue that checking for uniqueness falls into her/his responsibility.
By putting contracts in it these hints are there an implementation of it could look like this:

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

By decorating the class with contracts. It is explicitly stated that the user has to check the uniqueness of the values outside of the class. Of course the clean way would be to fix the list, but as a first step this allows us to find any misuse of the class in our code. 

### Polymorphism

The [Liskov substitution principle](https://en.wikipedia.org/wiki/Behavioral_subtyping) states that child-classes may work in a more loose context than their parents, but they have to ensure the same post-conditions. Formulated as Contracts the following rules apply:

* **Preconditions** for methods are allowed to be softer, but must not be strengthened
* **Post-conditions** are allowed to be stronger, but must not be weakened
* **Invariants** are kept as is


## Practical use

The first and most apparent use of contracts is that programming errors are detected earlier and with hints where they happen. Contracts also work as formal documentation that can be checked by running the program. 
This in itself helps the design process of software, as it allows defining interfaces and expected behavior early on. Often even before the actual implementation. Having the context of a method explicitly stated fosters constructive discussion on the design tremendously. 
Being able to define and verify this context explicitly reduces the complexity of a program as a whole as error and exception handling and can often be moved to a defined point and does not need to be repeated all over the place. So contracts help applying the [single responsibility principle](https://en.wikipedia.org/wiki/Single-responsibility_principle) of software design. 

Using design by contracts from the beginning is of course preferred, but even if the code is already there decorating it with contracts often reveals a few hidden bugs or possible failures.

## Contracts and unit testing. 

Design by contract does not replace testing, but supplements it. While unit- and integration testing cover the correct behavior of the software, contracts confirm correct usage by the programmer. As a consequence, if a contract fails even a positive test result is not to be trusted. By applying contracts software-wide, the number of test cases can be reduced as not every edge case has to be tested everywhere. 

![How "Design by Contract" relates testing. Showing design by contract as overlap between correct usage, correct behavior and semantic context of software]({{site.baseurl}}/images/design-by-contract/contract_testing_docu.png)

Checking the contracts influences the run-time and overall performance of the software, so they are usually removed from the deployed, tested software. The programmer also has to be aware of these influences, so a clear separation from non-functional testing like memory consumption or real-time behavior is necessary. 

## And now? 

Design by contract is a powerful tool to increase the quality of software. Unfortunately it is rarely used in programming, for the lack of support in programming languages and knowledge in programmers. The effort to get going and start with it is however not that big and the benefits are many. From more explicit discussions about intended design to faster feedback on quality through the fail-early-fail-hard mentality applied to coding. So why wait? Pick a [library](https://github.com/bernedom/bertrand) and start using it, wherever you are currently coding! 
