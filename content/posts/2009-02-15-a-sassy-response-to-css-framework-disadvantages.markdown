---
title: "Disadvantages of CSS Frameworks: A Sass-y Response"
description: My response to a post to Smashing Magazine from way back in 2007
category: blogging
---
A [post][1] from [Smashing Magazine][2] made a very thoughtful and balanced analysis of CSS Frameworks. I recognized the drawbacks of using CSS frameworks long ago and set out to keep the good parts and eliminate the bad parts, as much as is possible, by using Sass for the core technology behind Compass.

Let’s be honest, CSS frameworks, while meeting the technical definition of a “framework”, are not anything more than a collection of css classes that you can use in your HTML. They are not a framework for writing your stylesheets -- they are a framework for building webpages, and this is the fundamental difference when you use Compass & Sass.

So here’s the list of disadvantages of CSS frameworks from Smashing Magazine, and my response to each with respect to Sass and Compass.

<h2 id="you_need_time_to_fully_understand_the_framework">You need time to fully understand the framework.</h2>

> Using external CSS frameworks, you still need a profound understanding of your code. You need to know exactly how your framework is actually built. “By building a site from the ground up, you gain a knowledge of your site’s architecture that can’t be learned through any study or documentation.” [[Why I don’t use frameworks][3]]

Yes, you’ll need to know your how your framework works. For example, you’ll need to know that a grid is built using floats and how changes to the element’s box attributes (padding, margins, border) will affect the layout. Your framework should document this, and if it doesn’t you should go read the code and understand it. But why should you build your own framework and make it work in 5 browsers? It seems that taking an hour to understand another framework is a considerable time savings.

<h2 id="you_might_inherit_someones_bugs_or_mistakes">You might inherit someone’s bugs or mistakes.</h2>

> If you use external CSS Frameworks you might get in trouble fixing someone else’s bugs which is far more time-consuming than fixing your own bugs.

Absolutely. This is of course not unique to CSS frameworks, this is a risk you take any time you stand on the shoulders of someone else. Fixing someone else’s bug is slower than fixing your own. But let’s think about this. How many bugs will you make in your attempt to reproduce what the framework gives you? I’m guessing more. But it’s quite likely that you **won’t** encounter someone else’s bug. But let’s pretend that you do; what is so bad about this? If there’s a community of people sharing a common code-base, once one person finds that bug it’s fixed for everyone. Thanks! You’re a great team player who has been benefiting from the help of others and you’ve just contributed back a small portion of your time savings. As with any build vs. buy decision, you need to consider how widely used the project is, how engaged the maintainer is, etc.

That said, the cost of upgrading a traditional CSS framework is high. The installation is manual and unless you were careful to never make a change to the files provided by your CSS framework, you’ll be stuck trying to manually merge your changes. Worse, some CSS frameworks, in an attempt to make them more customizable, will generate CSS just for you that you can then put into your project. Upgrading will mean regenerating this CSS using the same inputs.

Compass was designed to be upgraded trivially and addresses this problem by making it easy to upgrade the compass codebase and then apply that upgrade to your stylesheets:

<pre class="console window"><span class="prompt">$</span> <span class="stdin">sudo gem update chriseppstein-compass</span>
<span class="prompt">$</span> <span class="stdin">cd myproject</span>
<span class="prompt">$</span> <span class="stdin">compass --force --update</span>
</pre>

<h2 id="you_develop_sites_upon_a_framework_not_upon_the_solid_knowledge_of_css">You develop sites upon a framework, not upon the solid knowledge of CSS.</h2>

> “A big problem with frameworks is when up and coming developers attach themselves to a framework as opposed to the underlying code itself. The knowledge gained in this case surrounds a specific framework, which severely limits the developer.” [[Please Do Not Use CSS Frameworks][4], by Jonathan Christopher]

This argument has been made every time a technology evolves a new layer of abstraction. There’s a certain amount of truth to this argument if you’re speaking about complex code frameworks like rails, MFC, etc. But in the case of CSS frameworks and Compass, I just don’t agree. As we said above you’re going to need to take the time to fully understand the framework. The output and construction of the framework is not hidden from you and you’re fundamentally working with same primitives that you have in CSS.

<h2 id="you_get_a_bloated_source_code">You get a bloated source code.</h2>

> “Whether it be in a server side language framework or JavaScript library, there is often a large percentage of code that will never be executed. While not a major issue server side, this can greatly degrade the performance of a client side framework such as a JavaScript library.” [[Please Do Not Use CSS Frameworks][4], by Jonathan Christopher]

This is true. You _can_ degrade the performance of a browser. But did you? It's quite unlikely that the styles of your website will be so complex that they have a noticible performance import. If you're worried about it, you should read this writeup on [CSS performance characteristics](http://www.stevesouders.com/blog/2009/03/10/performance-impact-of-css-selectors/). But let’s make an aesthetic argument instead: **Having a bunch of CSS that is superfluous to your project is ugly**. I agree. Compass currently has a lot of styles that you can use. But this ridiculous "bloat" just doesn’t matter because *you* control what ends up in your stylesheets. You can select the non-semantic versions of these frameworks with simple commands like:

<div class="code-wrapper">
  <table class="comparison side-by-side">
    <tr>
      <th class="window-title">Sass</th>
    </tr>
    <tr>
      <td valign="top" class="window editor">
<div>
<pre><code class="sass">@import compass/reset.sass
@import blueprint.sass

+blueprint</code></pre>
</div>
      </td>
  </tr>
</table>
</div>

Or you can be more selective. For example, if you just want blueprint’s grid system:

<div class="code-wrapper">
  <table class="comparison side-by-side">
    <tr>
      <th class="window-title">Sass</th>
    </tr>
    <tr>
      <td valign="top" class="window editor">
<div>
<pre><code class="sass">@import compass/reset.sass
@import blueprint.sass

+blueprint-grid</code></pre>
</div>
      </td>
  </tr>
</table>
</div>
<h2 id="css_can_not_be_framed_semantically">CSS can not be framed semantically.</h2>

> “CSS and (X)HTML go hand in hand. (X)HTML is a language semantic in nature, which is impossible to wrap up in the style of a framework. Each and every project is unique in and of itself, right down to the document structure, classes, and ids. A CSS framework passively removes a great majority of semantic value from the markup of a document and, in my opinion, should be avoided.” [[Please Do Not Use CSS Frameworks][4], by Jonathan Christopher]

Bingo. This is, hands down, my #1 problem with CSS Frameworks. CSS based frameworks have to work within the limitations of the technology. As such, you have to make sure your markup conforms to the framework and violate the best practice of keeping your content and presentation separate. And this is the #1 reason Compass exists. I didn’t want to choose between using a framework and following best practices. I wanted to eat my cake too! Compass, together with the awesome concept in Sass called a “Mixin”, allows you to build semantic stylesheets!

{% include code/disadvantages/layout.html %}

As you can see, your `#page` element is a container that has been clear-fixed and set to the appropriate width. The `#sidebar` is an 8 unit grid column and your #content is a 16 unit grid column with no right margin because the “true” means it is the last column in a row. This is a simple example, but I hope it demonstrates how you can start to think about your stylesheets in a new way and why I say Compass is a real stylesheet framework, not just a collection of classes.

<h2 id="ignoring_the_uniqueness_of_your_projects">Ignoring the uniqueness of your projects.</h2>

> Designs should be based upon the content, not upon a standard template you use over and over again.

First, a grid framework is a highly customizable approach to website layout that is pleasing to read and work with. It's hardly a one size fits all approach. Second, your design can still flourish within some simple constraints -- most websites are not so unique. Lastly, if [Blueprint][6] doesn't suit your needs, perhaps one of these other frameworks will:

* [YUI][7]
* [960.gs][8]
* [Grid Coordinates](http://github.com/handcrafted/grid-coordinates) (based on Tyler Tate’s 1kb CSS Grid project)
* [Susy](http://www.oddbird.net/susy/)

Even if you don’t want grids, these frameworks can help you set up your typography and vertical rhythm, or just use the [compass core framework][10] to take care of common menial styling tasks like creating horizontal lists. You can even try combining parts of one framework with another.

## In conclusion

Using Sass instead of CSS let's you insulate yourself from the nitty gritty mechanics of CSS while keeping you close to the syntax and semantics of CSS. It provides the power to keep your stylesheets both DRY and semantic and let's you stand on the shoulders of others or even your yourself (reuse across projects, websites). Compass is the pointing they way to cleaner, more maintainable stylesheets. If you want to use it, I hope you get value out of it. But even if you don't, just sticking with Sass and building up your own framework will give you many of the benefits I've discussed here.


[1]: http://www.smashingmagazine.com/2007/09/21/css-frameworks-css-reset-design-from-scratch/
[2]: http://www.smashingmagazine.com/
[3]: http://warpspire.com/features/css-frameworks/
[4]: http://mondaybynoon.com/2007/08/27/please-do-not-use-css-frameworks/
[6]: http://wiki.github.com/chriseppstein/compass/blueprint-documentation
[7]: http://github.com/chriseppstein/yui-compass-plugin/
[8]: http://github.com/chriseppstein/compass-960-plugin/
[9]: http://www.eppsteins.net/compass/examples/compass/utilities.html
[10]: http://wiki.github.com/chriseppstein/compass/compass-core-documentation


