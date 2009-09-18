---
title: Why Abstraction Matters in the Implementation of Design
description: "Whether you are a CSS expert or newbie, a programmer or a designer, you need abstractions to quickly and effectively build and maintain the design of your website."
category: blogging
---

I've seen a number of comments on blogs and twitter that amount to "You don't need a new stylesheet syntax, CSS is simple and you're a moron if you can't do it." I agree, CSS is simple. You assign style primitives to elements and some of those primitives cascade down to the elements contained within. I get it. It's simple _to implement_. But it's not simple to use. And its hight time for it to evolve so that we can take web design to the next level. 

If your job is to make a website that looks good in every common browser, then hands down, you have one of the hardest jobs on the internet. I've done just about every aspect of the job from database to front end and every layer in between. Front-end engineering is hard because it brings together three things for which you have no control: Browsers, Users and Opinions. Browsers are different; Users are going to find every one of your flaws; and since everyone has an opinion on the interface, you're going to be changing it -- probably just after you get it working.

Over the past few years in the world of JavaScript, we've seen numerous frameworks bring sanity to coding against the DOM. Optimizing common coding tasks through the creation of abstractions. As a result, it's a very nice time to be a front-end programmer. It's been a couple of years since I've bitched about DOM incompatibilities -- long enough to almost forget how much work it used to be. It's also a very nice time to be a user of the web, freed of the need to fuss with DOM primitives, developers have turned that spare time into much more sophisticated user interfaces.

Styling a website, however, is a total pain in the ass. I'm not talking about the lack of a decent layout module for CSS. I'm talking about the fact that CSS lacks the expressive nature required to create abstractions.  You cannot build a CSS framework. Yes, I'm very familiar with Blueprint and the plethora of similar "CSS Frameworks." These are not CSS frameworks, they are "Web Page Design Frameworks" because their scope encompasses both CSS and HTML. I'm talking about real stylesheet frameworks that raise the level of abstraction without moving presentation back into our documents. Don't get me wrong, those frameworks solve real problems and the creators have done an excellent job working through the intricacies of browser quirks and composable design elements. It's just that they had poor tools with which to express their concepts.

What is Abstraction?
--------------------

Abstraction is the ability to define a new concept in terms of other, more simple, concepts. When you define a CSS class, you are creating an abstraction. It's nothing to be scared of. The problem with CSS is that this is the _only_ mechanism of abstraction.

Why you should <strike>care about</strike> demand Abstraction
--------------------------------------------------

Coding *(and don't let anyone tell you that creating stylesheets isn't coding)* is an exercise in managing complexity. Programmers realized this quite some time ago and created "Object Oriented Programming" as a way of simplifying programs so that any portion of it could be understood in terms of interacting abstractions. We create objects like a "JobDispatchManager" that have no meaning in the the real world, their function is purely virtual.

When we start teaching OOP to students, we don't start there. We start by modeling things that they can touch and feel -- Real world objects like tables and chairs, cars, and a restaurant with queue of customers. We also teach them GUI programming because in a graphical UI, OOP is totally natural. We're building virtual objects that we can touch and interact with via our input devices. We build dialogs, drop downs, file browsers, etc. But the computer doesn't know what any of these things are. They are just as abstract as a "JobDispatchManager". They are built from primitives like lines, characters, boxes, etc. which are themselves just abstractions of lower level concepts like pixels, memory registers, and bits.

It is the designer's job to transform primitives like font-size, border, padding, images, etc. into real-world objects that users intuitively understand as concrete objects. Search boxes, articles, advertisements, navigation, and so on. In other words, it is the designer's job to build abstractions. They are not abstract to us, rather they are abstract to the browser. So when a language gives you the power of abstraction, it gives you the power to build **real things**. And that is your job. And that is why you should care about, nay, be demanding a stylesheet syntax that gives you the power to do your job.

New Mechanisms of Stylesheet Abstraction
----------------------------------------

Sass (Syntactically Awesome StyleSheets) is a stylesheet that has been gaining adoption first in the Ruby on Rails Community and is now growing in the wider web development community thanks to Compass. Sass is the first and only stylesheet syntax to offer all of the following types of abstractions:

<dl>
  <dt>Variables</dt>
  <dd>A variable is a simple but important abstraction, by creating a variable with a name that didn't exist before, you create a new concept. That concept is defined in terms of a simpler concept: a value.</dd>
  <dt>Functions</dt>
  <dd>CSS provides some functions for you to use. For example: rgb(), hsl(), url(). There is no mechanism for defining new CSS functions, but this doesn't mean there couldn't be. For example, in Sass, with a little ruby programming, you can define your own functions for use within your stylesheets.</dd>
  <dt>Expressions</dt>
  <dd>An expression creates a new value by combining other values with operators and functions. This is itself an abstraction because it expresses the concept of how to arrive at a new value from other values.</dd>
  <dt>Mixins</dt>
  <dd>A mixin is the contents of a selector without the selector. You can think of it as a class whose name is only visible to the stylesheet for use within that stylesheet for defining other selectors. Mixins can accept arguments to control their behavior.</dd>
  <dt>Macro Expansion</dt>
  <dd>Macro expansion is the generation of selectors and styles using variables, conditionals, looping, and the like. Macro expansion allows for very high level concepts to be created. For example, a single mixin can <a href="http://github.com/chriseppstein/compass-960-plugin/blob/master/sass/960/_grid.sass#L59">generate a whole grid system</a>.</dd>
</dl>

Each of these abstractions alone is very nice, but when you combine them, as we have done in Sass, something almost magical happens.

Abstraction in Action
---------------------

Compass is a stylesheet authoring framework and I'll let you in on a little secret: Compass is written in 100% Sass. There's nothing that compass does that you couldn't do yourself if you were willing to write the 175 mixins that compass currently provides yourself. But the magic part is that you don't have to. You can start working with the abstractions that have been discussed, tested, and iterated on by a community of designers and front-end engineers for over a year now. It's a huge time saver.

Now, if you have some styles and designs that you've made and spent a bunch of time perfecting, you can use the power of Sass to share that code with others. The members of the compass community are creating plugins and sharing them with each other. Open Source is finally alive and well in the design community.

Benefits of Abstraction
-----------------------

Whether or not you decide to use a framework like Compass, you will benefit from the capability to express abstraction. I'm going to summarize them here now and I will follow up with individual blog posts demonstrating these benefits.

XXX These need fleshing out.

<dl>
  <dt>Browser Compatibility</dt>
  <dd>compatibility issues are encapsulated by the abstraction</dd>

  <dt>Clarity of Intent</dt>
  <dd>Optimize for reading -- code is read many, many more times than it is changed.</dd>

  <dt>Change management</dt>
  <dd>Bug fixes, design changes</dd>

  <dt>Domain specific style vocabulary</dt>
  <dd>AKA Work how you think. design with the mindset of your site, not style primitives.</dd>

  <dt>Organization</dt>
  <dd>Easier to keep similar concepts close to each other in code to optimize coordinated changes</dd>

  <dt>Work Faster</dt>
  <dd>No need to revisit solved issues time and time again.</dd>

  <dt>Semantic HTML</dt>
  <dd>This is about avoiding dependency inversion and maintaining a separation of concerns. </dd>

  <dt>Ability to Refactor</dt>
  <dd>Refactoring (changing the implementation without changing the behavior) is easier. Nay a necessity.</dd>

  <dt>Reuse</dt>
  <dd>Both internal and across projects.</dd>
</dl>

Downsides to Abstraction
------------------------

XXX These need fleshing out.

<dl>
  <dt>Learning curves</dt>
  <dd>new concepts are new things to learn. Of course, a site full of legacy styles might be easier to comprehend once those concepts are well understood.</dd>

  <dt>Bug fixing</dt>
  <dd>often requires understanding the abstraction (encapsulation failure)</dd>

  <dt>Documentation</dt>
  <dd>Ok this is probably a benefit, since you likely needed it anyway, but I hate writing documentation. Once you define a new concept, you have a great place to document that concept now.</dd>

  <dt>The abstraction doesn't fit</dt>
  <dd>This is a tough one. There are a couple of choices: 1) don't use it. 2) change it. 3) complain. Once you learn the abstraction you may decide it doesn't fit. If you don't fully understand the abstraction, you may think you should use it when you shouldn't -- this is likely going to lead to complaining.</dd>

</dl>

______________________

Notes
-----

Everything below here is snippets on the cutting room floor.


What is Encapsulation?
----------------------

Encapsulation is the hiding of implementation details fundamental to the creation of an abstraction. In programming, we can instruct the compiler to prevent the improper manipulation of implementation details. I don't know of a stylesheet syntax that enforces encapsulation yet, so when I use it I am going to be talking about mental encapsulation. E.g. Whether or not you have to _care_ about the implementation details.










A real framework. , 960.gs, Baseline, etc. These are not frameworks. Look up the definition and see for yourself. But they are as close as we can get with pure CSS in its current state.


I'm talking about the cruel reality that browsers will _always_ be different from each other. The solution for this is not to bitch about a lack of "standards compliance." The solution is make our stylesheet syntax more expressive and allow stylesheet frameworks arise to deal with the incompatibilities. Yes it's true that CSS has graceful degradation, frameworks will certainly rely on this fact in their implementations. But there are some basic capabilities that CSS3 needs to support frameworks properly: conditional logic and feature detection.

The reason it is hard is because of browser incompatibilities. 

and the  are one of the biggest challenges facing website implementation and the reason it's hard is because CSS is inadequate.

and they have some of the most inadequate tools with which to deal with their technical challenges. They spend countless hours designing websites with tools that 
Designers live in a world of abstraction, but the tool support they need has been deliberately kept from them. Read on to understand why designers need abstraction and how they can use it effectively in the implementation of website design.

Whether you are a CSS expert or newbie, a programmer or a designer, you need abstractions to quickly and effectively build and maintain the design of your website.


and we've seen the browser makers respond by making javascript engines lighting fast.


 Order emerges from the chaos. Simplicity is found within the complexity. This doesn't mean that designing a website is easy -- 
  
<div class="window editor">
{% highlight sass %}
// transparency for everyone!
=opacity(!o = 1)
  :filter= "alpha(opacity=" + round(!o*100) + ")"
  :-moz-opacity= !o
  :-khtml-opacity= !o
  :opacity= !o

ul.nav
  li
    +opacity(0.75)
    &:hover
      +opacity(1)
{% endhighlight %}
</div>
  
