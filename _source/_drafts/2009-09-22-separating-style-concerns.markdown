---
title: Separating Style Concerns
description: "Separate the Layout, Design and Typography of your site's styles for clarity and ease of maintenance."
category: blogging
---

The style properties of CSS fall into three major categories: Layout, Design, and Typography. In this post I'll highlight why keeping them separate makes your website easier to maintain. And I'll share some basic CSS and Sass strategies to help me separate these different concerns and then bring them back together. I'll also note that while I'll be using Sass to demonstrate my points, many of the strategies outlined here are applicable for users of CSS, Less, CSScafold, and other CSS meta-languages.

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

{% include code/concerns/layout_comparison.html %}

Typography Properties
---------------------

Most sites will have at least a couple of types of typography: Chrome and content -- maybe more depending on your needs. CSS provides 

