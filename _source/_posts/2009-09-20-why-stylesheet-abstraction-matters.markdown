---
title: Why Stylesheet Abstraction Matters
description: "Whether you are a CSS expert or newbie, a programmer or a designer, you need abstractions to quickly and effectively build and maintain the design of your website."
category: blogging
---

I've seen a number of comments on blogs and twitter that amount to "You don't need a new stylesheet syntax, CSS is simple and you're a moron if you can't do it." I agree, CSS is simple. You assign style primitives to elements and some of those primitives cascade down to the elements contained within. I get it. It's simple _to understand_. But CSS is not simple to use or maintain. It's time for stylesheets to evolve so that we can take web design to the next level.

If your job is to build and maintain a website that looks good in every common browser, then hands down, you have one of the hardest jobs on the internet. I've done just about every aspect of the job, from database to front-end, and every layer in between. Front-end engineering is hard. It's so hard because it brings together three things for which you have no control: Browsers, Users and Opinions. Browsers are different; Users are going to find every one of your flaws; and since everyone has an opinion on the interface, you're going to be changing it -- probably just after you get it working.

Over the past few years the development of JavaScript frameworks have brought sanity to coding against the DOM -- optimizing common coding tasks through the creation of abstractions than insulate us from the nitty-gritty details and providing a common platform for third-party libraries to rely on. As a result, it's a very nice time to be a front-end programmer. It's been a couple of years since I've bitched about DOM incompatibilities -- long enough to almost forget how much work it used to be. It's also a very nice time to be a user of the web, freed of the need to fuss with DOM primitives and JavaScript intricacies, developers have turned their spare time into much more sophisticated user interfaces.

Creating and maintaining the styles of a website, by comparison, is a total pain in the ass. I'm not talking about the lack of a decent layout module for CSS. I'm talking about the fact that CSS lacks the expressive nature required to create abstractions. The simplicity of the CSS syntax creates complexity for the developer. Every time you have to copy and paste something within your stylesheet instead of reference that same information, you've missed an opportunity to make your stylesheets easier to maintain through abstraction. However, if you've ever tried to build a DRY *(**D**on't **R**epeat **Y**ourself)* stylesheet, you've found that the only tool at your disposal is the "class" construct. So the DRYest stylesheet will necessarily force you to put all kinds of presentation classes in your markup, thus making your website less maintainable. Case in point: shared html partials & includes may need to be styled differently in different contexts.

Let's be frank, your designs are going to change. New features will be added that make you reevaluate things. You'll decide you hate some color or font treatment. Your HTML is going to change. New browsers are going to come out with new quirks. Any every time something changes, **you** have to propagate that change across your stylesheets. If you're lucky, you can search and replace for the change. But what if you want to change the color `#000` to `#333`? You can't search and replace for `#000`. First you could have used `black` or `#000000` or `rgb(0,0,0)`. Second, it's likely that black is used for other things than what is changing. But what if you had _named_ that color? Now that black is different from all the other blacks. It's now the "article font color" and changing that abstraction can be done once and propagated for you by a smarter stylesheet syntax.

> CSS is the weakest link in the web developers toolbox. The problem goes deeper than CSS's lack of variables. Unlike the "function" in programming, CSS has no fundamental building block.

What is Abstraction?
--------------------

Abstraction is the ability to define a new concept in terms of other, more simple concepts. When you define a CSS class, you are creating an abstraction. It's nothing to be scared of. The problem with CSS is that this is the _only_ mechanism of abstraction.

Why you should <strike>care about</strike> demand Abstraction
--------------------------------------------------

Coding *(and don't let anyone tell you that creating stylesheets isn't coding)* is an exercise in managing complexity. Programmers realized this quite some time ago and created "Object Oriented Programming" as a way of simplifying programs so that any portion of it could be understood in terms of interacting abstractions. We create objects like a "JobDispatchManager" that have no meaning in the the real world, their function is purely virtual.

When we start teaching OOP to students, we don't start there. We start by modeling things that they can touch and feel -- Real world objects like tables and chairs, cars, and a restaurant with queue of customers. We also teach them GUI programming because in a graphical UI, OOP is totally natural. We're building virtual objects that we can touch and interact with via our input devices. We build dialogs, drop downs, file browsers, etc. But the computer doesn't know what any of these things are. They are just as abstract as a "JobDispatchManager". They are built from primitives like lines, characters, boxes, etc. which are themselves just abstractions of lower level concepts like pixels, memory registers, and bits.

It is the designer's job to transform primitives like font-size, border, padding, images, etc. into real-world objects that users intuitively understand as concrete objects. Search boxes, articles, advertisements, navigation, and so on. In other words, it is the designer's job to build abstractions. They are not abstract to us, rather they are abstract to the browser. So when a language gives you the power of abstraction, it gives you the power to build **real things**. And that is your job. And that is why you should care about, nay, demand a stylesheet syntax that gives you the power to do your job.

New Mechanisms of Stylesheet Abstraction
----------------------------------------

Sass (Syntactically Awesome StyleSheets) is a stylesheet syntax that has been gaining adoption first in the Ruby on Rails Community and is now growing in the wider web development community thanks to Compass. Sass is the first and only stylesheet syntax to offer all of the following types of abstractions:

<dl>
  <dt>Variables</dt>
  <dd>A variable is a simple but important abstraction, by creating a variable with a name that didn't exist before, you create a new concept. That concept is defined in terms of a simpler concept: a value.
<table class="comparison side-by-side">
  <tr>
    <th class="window-title">Sass</th>
    <th class="gap">&nbsp;</th>
    <th class="window-title">CSS</th>
  </tr>
  <tr>
    <td valign="top" class="window editor">
{% highlight sass %}
!article_font_color = #333
.article p
  color= !article_font_color
.widget .article-snippet
  color= !article_font_color
{% endhighlight %}
    </td>
    <td class="gap">&nbsp;</td>
    <td valign="top" class="window editor">
{% highlight css %}
.article p {
  color: #333;}
.widget .article-snippet {
  color: #333;}
{% endhighlight %}
    </td>
  </tr>
</table>
</dd>
  <dt>Functions</dt>
  <dd>CSS provides some functions for you to use. For example: rgb(), hsl(), url(). However, there is no mechanism for defining new CSS functions, but this doesn't mean there couldn't be. For example, in Sass, with a little ruby programming, you can define your own functions for use within your stylesheets. For example, the <a href="http://github.com/chriseppstein/compass-colors">compass-colors extension</a> provides a handful of very useful functions for manipulating colors.
<table class="comparison side-by-side">
  <tr>
    <th class="window-title">Sass</th>
    <th class="gap">&nbsp;</th>
    <th class="window-title">CSS</th>
  </tr>
  <tr>
    <td valign="top" class="window editor">
{% highlight sass %}
!base = #60A
!highlight = lighten(!base, 33%)
!shadow = darken(!base, 33%)
div.box
  background-color= !base
  border:
    width: 2px
    style: solid
    colors= !highlight !highlight !shadow !shadow
{% endhighlight %}
    </td>
    <td class="gap">&nbsp;</td>
    <td rowspan="4" valign="top" class="window editor">
{% highlight css %}
div.box {
  background-color: #6600aa;
  border-width: 2px;
  border-style: solid;
  border-color: #a41bff #a41bff #440072 #440072; }
{% endhighlight %}
    </td>
  </tr>
  <tr class="gap">
    <td>&nbsp;</td>
    <td class="gap">&nbsp;</td>
  </tr>
  <tr>
    <th class="window-title">Ruby Definition</th>
    <th class="gap">&nbsp;</th>
  </tr>
  <tr>
    <td valign="top" class="window editor">
{% highlight ruby %}
# Darken a color by 0-100%
def darken(color, amount)
  hsl = Compass::Colors::HSL.from_color(color)
  hsl.l *= 1.0 - (amount.value / 100.0)
  hsl.to_color
end
{% endhighlight %}
    </td>
    <td class="gap">&nbsp;</td>
  </tr>
</table>
</dd>
  <dt>Expressions</dt>
  <dd>An expression creates a new value by combining other values with operators and functions. This is itself an abstraction because it expresses the concept of how to arrive at a new value from other values. While expressions are more typing and reading than just specifying a value, they capture the process of creating the values you used so that later change is simple and others can understand why the value is what it is.
<table class="comparison side-by-side">
  <tr>
    <th class="window-title">Sass</th>
    <th class="gap">&nbsp;</th>
    <th class="window-title">CSS</th>
  </tr>
  <tr>
    <td valign="top" class="window editor">
{% highlight sass %}
!browser_default_size = 16px
!base_font_size = 12px
!base_line_height = 18px
body
  font-size= 100% * !base_font_size / !browser_default_size
  line-height= !base_line_height / !base_font_size
p.bigger
  /* Maintain the same line height. */
  !bigger_size = 16px
  font-size= 1em * !bigger_size / !base_font_size
  line-height= !base_line_height / !bigger_font_size
{% endhighlight %}
    </td>
    <td class="gap">&nbsp;</td>
    <td valign="top" class="window editor">
{% highlight css %}
body {
  font-size: 75%;
  line-height: 1.5; }

p.bigger {
  /* Maintain the same line height. */
  font-size: 1.333em;
  line-height: 1.125; }
{% endhighlight %}
    </td>
  </tr>
</table>
</dd>
  <dt>Mixins</dt>
  <dd>A mixin is the contents of a selector without the selector. You can think of it as a class whose name is only visible to the stylesheet for use within that stylesheet for defining other selectors. Mixins can accept arguments to control their behavior. Mixins can contain other mixins and they can nest selectors too. Mixins are the fundamental unit of abstraction in Sass. They are the building blocks of maintainable stylesheets.
<table class="comparison">
  <tr>
    <th class="window-title">Sass</th>
  </tr>
  <tr>
    <td valign="top" class="window editor">
{% highlight sass %}
// Cross Browser Transparency (Yuck!)
=opacity(!opacity)
  :opacity= !opacity
  :-moz-opacity= !opacity
  :-khtml-opacity= !opacity
  :-ms-filter= "progid:DXImageTransform.Microsoft.Alpha(Opacity=" + round(!opacity*100) + ")"
  :filter= "alpha(opacity=" + round(!opacity*100) + ")"

ul.nav
  li
    +opacity(0.75)
    &:hover
      +opacity(1)
{% endhighlight %}
    </td>
  </tr>
  <tr class="gap">
    <td>&nbsp;</td>
  </tr>
  <tr>
    <th class="window-title">CSS</th>
  </tr>
    <td valign="top" class="window editor">
{% highlight css %}
ul.nav li {
  opacity: 0.75;
  -moz-opacity: 0.75;
  -khtml-opacity: 0.75;
  -ms-filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75);
  filter: alpha(opacity=75); }
  ul.nav li:hover {
    opacity: 1;
    -moz-opacity: 1;
    -khtml-opacity: 1;
    -ms-filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=100);
    filter: alpha(opacity=100); }
{% endhighlight %}
    </td>
  </tr>
</table>
</dd>
  <dt>Macro Expansion</dt>
  <dd>Macro expansion is the generation of selectors and styles using variables, conditionals, looping, and the like. Macro expansion allows for very high level concepts to be created. For example, a single mixin can <a href="http://github.com/chriseppstein/compass-960-plugin/blob/master/sass/960/_grid.sass#L59">generate a whole grid system</a>.
<table class="comparison side-by-side">
  <tr>
    <th class="window-title">Sass</th>
    <th class="gap">&nbsp;</th>
    <th class="window-title">CSS</th>
  </tr>
  <tr>
    <td valign="top" class="window editor">
{% highlight sass %}
@for !level from 1 through 6
  h#{!level}
    font-size= 100% + (6 - !level) * 150% / 5
{% endhighlight %}
    </td>
    <td class="gap">&nbsp;</td>
    <td valign="top" class="window editor">
{% highlight css %}
h1 {
  font-size: 250%; }

h2 {
  font-size: 220%; }

h3 {
  font-size: 190%; }

h4 {
  font-size: 160%; }

h5 {
  font-size: 130%; }

h6 {
  font-size: 100%; }
{% endhighlight %}
    </td>
  </tr>
</table>
</dd>
</dl>

Each of these abstractions alone is very nice, but when you combine them, as we have done in Sass, something almost magical happens.

Abstraction in Action
---------------------

Compass is a stylesheet authoring framework and I'll let you in on a little secret: Compass is written in 100% Sass. There's nothing that compass does that you couldn't do yourself if you were willing to write the 175 mixins that compass currently provides yourself. But the magical part is that you don't have to. You can start working with the abstractions that have been discussed, tested, and iterated on by a community of designers and front-end engineers for over a year now. It's a huge time saver.

Now, if you have some styles and designs that you've made and spent a bunch of time perfecting, you can use the power of Sass to share that code with others. The members of the compass community are creating plugins and sharing them with each other. The open source ethos is finally alive and functioning in the design community. And that, my friends, is abstraction in action.

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

