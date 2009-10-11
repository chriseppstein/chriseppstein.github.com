---
title: An Examination of CSS Class Inheritance
description: "A discussion of how CSS Class Inheritance would work and how it differs from style mixins."
intro: "CSS class inheritance is a relatively simple concept with some powerful ramifications. Read on for information on what it is, how it could work, and what the present and future hold."
category: blogging
stylesheet: "posts/class_inheritance"
---

[OOCSS](http://wiki.github.com/stubbornella/oocss) (Object Oriented CSS) is a CSS Framework by [Nicole Sullivan](http://www.stubbornella.org/content/). 
It is unique among the landscape of CSS frameworks -- it consists of some basic CSS to get you started and best practices to help you build out webpages by adhering to a very strict separation of concerns at both the html content and CSS style levels. Like other CSS Frameworks, OOCSS expects you to build your content on top of your stylesheets instead of the other way around and it is well suited for sites that churn out lots of custom html pages that need to adhere to a common look and feel. The object oriented aspect of the framework is built on the concept of CSS Class Inheritance -- a very powerful and natural concept. [LessCSS](http://lesscss.org) also attempts to provide this feature via precompilation. **Unfortunately, it doesn't really exist yet** in either case. In this post, I'll examine how css class inheritance would work, some possible syntaxes for it, and compare it to a very similar concept: the mixin. I'll also show you how some strategies that you can use today that build on this concept. Lastly, I'll pontificate a bit on the current state of OOCSS and LessCSS and give my educated guess on what the future holds for this novel concept.

What is CSS Class Inheritance?
------------------------------

Let's begin by describing what CSS class inheritance is.

When a CSS selector inherits a CSS Class it is as if that class is applied to all elements within the document that match the selector with slightly less specificity than the selector that applied it.

Or put another way: The selector inherits the properties that the elements that match the selector would have if that element had been assigned that class.

Nicole has proposed a new property for CSS called "extends". Let's look at a simple example:

{% include code/class_inheritance/simple_extends.html %}

In LessCSS the syntax is different, you simply place the class selector you wish to inherit within the definition of a selector. Example:

{% include code/class_inheritance/simple_selector.html %}

Both of these approaches are interesting, but I prefer the LessCSS-style syntax for two reasons:

1. The behavior of the `extends` property would is counter-intuitive. The natural behavior of "extend" or "inherit" is to accumulate, but there is no other style property that has that behavior. This would pose challenges for implementors and users alike who may assume that specifying `extends` overrides previous values. On the flip side, if the decision was made to have the `extends` property override previous values in the selector heirarchy, then we lose the concept of "encapsulation" which is core to the maintainability of stylesheets built using this technique. This is because a change to an `extends` property would have to be propagated manually to the inheriting selectors.
2. The selector-style of inheritance paves the way for allowing inheriting other types of selectors. I'm not sure that is a desirable thing yet because I've not fully thought through the ramifications, but I like that it keeps the option open.

The problem with the LessCSS approach is that it introduces a new syntax for CSS parsers to understand, for this reason, I propose a hybrid syntax that I will use for the remainder of this post: The `@extends` directive:

{% include code/class_inheritance/simple_directive.html %}

CSS Inheritance and Document Structure
--------------------------------------

Let's consider a more complex example where the css class in question has interactions with the document structure. CSS inheritance should work in a way that is logical, consistent, and expected within the context of a document.

Consider the following document fragment:

{% include code/class_inheritance/positional_document.html %}

We should now be able style this quite simply:

{% include code/class_inheritance/positional_styling.html %}

Why Is it Useful?
-----------------

At this point probably are thinking to yourself "Why not just put multiple classes on the html elements?" That's a good question and there are a couple of reasons this is not practical:

1. First and foremost, the answer is that this is more maintainable. The box [abstraction](/blog/2009/09/20/why-stylesheet-abstraction-matters/) should not be leaky and in practice it might be extending many classes that are purely presentational building blocks dealing with cross-browser concerns, clearfixing, etc. that you needn't concern yourself with everytime you want to use that abstraction. This concept is called "encapsulation" and is fundamental to object oriented programming and to keeping code maintainable.

2. Multiple classes have the same specificity on an element, which means that the document order of the CSS will determine the resolution of the same property's value. However, when you extend something, you are overriding the values of it, even if the document order says otherwise. That said, the chances that you'll bump into this limitation of exactly the same specificity is quite rare. The more likely scenario is that you'll have a more specific selector that is overriding both. If you do run into this issue, it's usually fairly simple to work around by reorganizing your stylesheets.

Simulating Inheritance
----------------------

CSS class inheritance can be approximated by a stylesheet compiler, but it cannot be truly implemented without knowledge of the DOM. In the examples above, the properties of base classes can be inserted into extending class definitions and the selectors referencing the extended classes can be rewritten to match all the known subclasses. For example:

{% include code/class_inheritance/compilation_example.html %}

However, it's possible to construct an example where the expected behavior of true inheritance cannot be simulated. I present one such example here:

{% include code/class_inheritance/compilation_fail.html %}

It should be noted at the time of this posting, that LessCSS compiler does not perform any form of selector re-writing of extended classes, it only augments the definitions of the classes. I assume this is a bug that no one has noticed yet and that it will be fixed eventually. The more fundamental flaw cannot be fixed, but I'm eager to hear from real-world users of LessCSS whether it has affected them in a meaningful way.

As much as I like the idea of class inheritance, because of confusing edge cases like this one, I'm leaning against having Sass introduce any such syntax. I feel that mixins form a much more predictable, and document agnostic, approach to abstraction. That said, an automatic selector rewriting capability is a very compelling feature in the most common use cases involving top-level defined CSS classes and I'm interested to hear your feedback.

Mixins are not Class Inheritance
--------------------------------

Mixins add implementation to a selector, but as we've seen, class inheritance also changes the meaning of selectors by allowing the selectors to match against a base class. As such, a mixin is a useful tool that you can use to build your own class "hierarchies" manually and when coupled with the ability to nest selectors and permute them as sass provides, it's much easier to maintain your class definitions and related selectors than it would be in pure CSS. Of course, mixins can take arguments, and that makes them very useful in their own right. If CSS magically changed tomorrow to allow CSS Class inheritance, I would still need the mixin as a [fundamental abstraction for creating stylesheets](/blog/2009/09/20/why-stylesheet-abstraction-matters/).

What does the future hold?
--------------------------

Let me get out my crystal ball. Ok. Sadly, I don't think we'll ever have support for CSS class inheritance. No one is discussing adding such a feature to CSS3, and so CSS4 would be the earliest. Even if it was made part of an official specification, you'd not be able to use it for years because there's no way to gracefully degrade. So maybe, if somehow we can convince the W3C to add support, you might be able to use this feature in 5 to 10 years from now -- that's roughly equivalent to forever in internet time.

Class Inheritance Today
-----------------------

I hope you don't think that you've wasted your time reading this post. Simply learning to *think* about CSS classes as extending other CSS classes is going to help you construct and manage your stylesheets and to keep a clean [separation of concerns](/blog/2009/09/25/separating-style-concerns/). Hopefully this post will also help you evaluate and understand the tools and frameworks that you have at your disposal, to understand their limitations, as well as their strengths.


