---
title: Separating Style Concerns
description: "Separate the Features, Layout, Design and Typography of your site's styles for clarity and ease of maintenance."
category: blogging
---
As with any creative work, sometimes, you just have to shoot some aspect of a design and do it over. As such, your goal should be to keep distinct aspects of your design isolated enough from each other that you're not afraid to wipe out something that's not working. In this post I'll share some basic CSS and Sass strategies I use to help me separate different concerns. It's important to note that while I'll be using Sass to demonstrate my points, many of the strategies outlined here are applicable for users of CSS, [Less](http://lesscss.org), [CSScafold](http://github.com/anthonyshort/csscaffold), and other CSS meta-languages.

Benefits
--------

Here are a few of the scenarios that will be made much simpler if you have followed this best practice:

* Theming
* A/B testing the impacts of design
* Experimenting with new designs
* Addressing accessibility (high contrast, larger fonts, etc.)
* Providing alternate stylesheets
* Removing features

Costs
-----

In the short term it's going to be cheaper and easier to have your styles all mixed up. Especially if you're designing in code, it's not at all feasible to start out with separation. Also, it's easier to assume a certain `font-size` when cutting background images than it is to imagine how to handle many font sizes. It's OK. This is a long term strategy, after you get the page built, you can refactor the styles -- maybe even after you launch the site.

General Strategy
----------------

The style properties of CSS fall into three major categories: Layout, Design, and Typography. We will use these groupings in conjunction with the site's natural divisions to create a clean separation of cross-cutting concerns as well as vertical (product feature) concerns.

Layout Properties
-----------------

Separating out layout properties is absolutely the biggest win to be had with this strategy:

1. Layout changes much less frequently than the design. Having your layout separated, allows you to easily chuck your design and start again.
2. Your site will probably have a number of distinct layouts and those layouts will likely have some common aspects between them like headers, footers, overall widths. Common aspects are coupled and having them centralized, makes it easier to keep them in sync.
3. Second, changes to an individual layout are coupled. If you add to your sidebar, you probably have to subtract from your main content body. It's very nice to be able to quickly and easily locate and change the layout related properties.
4. Coupled with layout mixins from a grid framework like Blueprint, it is very easy to visualize the layout in your head by just reading the styles.

Layout properties are those which affect the location of content on the page:

* `display`
* `position`, `left`, `top`, `bottom`, `right`
* `float` & `clear`
* `width` & `height`
* `margin`
* `border-width`, `padding`

It's unfortunate that I have to include border width and padding in this list, because I really think that these should be aspects of design, but the reality is that unless you have the luxury of relying on CSS3's `box-sizing` property, keeping borders and paddings separated requires you to nest elements in your content. If you have done this (or plan to), then you are in good shape in this respect.

<%= render "code/concerns/layout_comparison" %>

Typography Properties
---------------------

Most sites have at least two of types of typography: Chrome and content -- maybe more depending on your needs (for instance this blog has a lot of "code" typography). Many designers feel that typography and design are inextricably linked, so a strong separation between the two may not work for everyone. Nevertheless, since they are distinct concepts, I would encourage you to try separating them for the most part.

Typographic properties are those which affect the flow and look of text:

* `@font-face`
* `font-family`
* `font-size`
* `font-weight`
* `font-style`
* `line-height`
* `letter-spacing`
* `text-transform`
* `text-decoration`

This is not to say that every instance of these properties is automatically a typographic concern. Usually they will be. Also, I've left out some of the more "fancy" properties like `text-shadow` because I think they are usually more about design. But the main reason why the use of a particular property makes it typography or design is because you think it is. Don't worry, if you're thinking about it wrong, that will become clear eventually and when it does, you can refactor it.

Design Properties
-----------------

Just about everything else is design. The previous two sections will only account for 10%-20% of you total stylesheet contents. So a well organized project will have a lot more structure to it than just the three main categories of style properties.

How to Refactor Your File Structure
-----------------------------------

Once you get a feature built to your satisfaction, you can begin to refactor it by organizing your file into three sections. Copy and paste the whole set of styles for the feature and delete all the style properties leaving only the selectors. Copy those selectors and paste them twice and comment your three sets of selectors layout, typography, and design. Then move the styles from the original location to the appropriate section. Until you've sorted all your styles. Lastly delete an unused selectors. If each of those sections fits onto a screen without scrolling, you can probably stop here. If the sections are still quite long, you might consider whether there are actually two or three distinct features that could be separated. For instance, a sass file for the site chrome might need to be broken up by header, footer, sidebar, etc. 

Project Structure
-----------------

Since Sass will assemble completed stylesheets for consumption by the browser using the `@import` directive, we can use files to organize our stylesheets without any performance penalty in production. I like to organize my stylesheets according to the following structure. Note: files starting with an underscore are called "partials" and are not compiled to a css file, but are instead meant to be imported into other stylesheets. Once a stylesheet gets long enough to be cumbersome (that is, scrolling is more disorienting than switching files), I create a folder of the same name and I split up the stylesheet into partials within that folder and then import them.

    stylesheets/
      _library.sass
      library/
        _utilities.sass
        _some_other_mixins.sass
      application.sass
      application/
        _common.sass
        common/
          _header.sass
          _footer.sass
          _sidebar.sass
          _typography.sass
          _layouts.sass
          layouts/
            _two_column.sass
            _three_column.sass
            _full_width.sass
        _feature_1.sass
        feature_1/
          _design.sass
          _structure.sass
        _feature_2.sass
        feature_2/
          _design.sass
          _structure.sass

Project Library
---------------

Your project library is where you keep mixins and shared variable definitions. These files must never emit any styles, so that they can be included into your other files by simply importing the main library file.

Structuring Mixins
------------------

If you're building a mixin of any complexity, it's good to think about breaking it up into composable parts along these same lines. This allows a consumer of a mixin to peel back one layer of abstraction at a time and pick up the aspects of the mixin they want to use. It's much easier to never have applied some set of styles than it is to override them. Of course, this only applies to mixins that provide a finished design.

<div class="code-wrapper">
<table class="comparison side-by-side">
  <tr>
    <th class="window-title">stylesheets/library/_badges.sass</th>
  </tr>
  <tr>
    <td valign="top" class="window editor">
<pre><code class="sass">=user-badge
  +user-badge-layout
  +user-badge-typography
  +user-badge-design

=moderator-badge
  +user-badge-layout
  +user-badge-typography
  +moderator-badge-design</code></pre>
    </td>
  </tr>
</table>
</div>

Conclusion
----------

Of course, this is not the only approach, this blog follows a slightly different approach because I want to build some features around alternate themes -- so I have a top level separation of layout, typography and design that then breaks out into a finer structure. All the sass stylesheets for this blog can be browsed, so please [check them out](/highlighted/stylesheets/screen.sass.html). The most important consideration of how to structure a project is your knowledge of how things will change. Of course, you cannot predict the future and so there's a good chance you'll be wrong. When you realize you are, reorganize in a way that helps you manage change. 
