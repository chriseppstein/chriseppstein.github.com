---
title: "Refactor My Stylesheets: The Negative Value Mixin"
browser_title: "The Negative Value Mixin"
description: "Sometimes a mixin adds negative value to your stylesheet."
category: blogging
featured: true
intro: "Sometimes a mixin adds negative value to your stylesheet."
---
I stumbled across [this tweet](http://twitter.com/bbttxu/statuses/18280591576) linking to a sass file that provides "semantic 3-column layouts for drupal and a configurable grid with #right, #left columns." Always pleased to see what people have made with Sass, I [took a look](http://gist.github.com/471642).

<%= render "code/refactorings/negative_value_mixin" %>

What I found was a Sass file that I could have written myself a year ago. Enamored with mixins, I sometimes used them where they weren't necessary. Now, with [@extend](http://nex-3.com/posts/99-selector-inheritance-the-easy-way-introducing-extend) in my arsenal, I find myself viewing sass files with new eyes. So as a fresh reader to this Sass file, I found it hard to understand what was going on. But [abstraction should add clarity](http://chriseppstein.github.com/blog/2009/09/20/why-stylesheet-abstraction-matters/), not remove it. So I put on my refactoring hat and got to work.

First, I [converted the file to use dashes](https://gist.github.com/472433/2aed4700958b4ddccc31e83ce944f3debf9118ca). I just find them more readable and I find that getting started with a relatively simple change gets my coding momentum going. Next I noticed that the #page selector was effectively creating a [blueprint container](http://compass-style.org/docs/reference/blueprint/grid/#mixin-container-scss) but not using the blueprint container mixin, so I changed it. Next, I noticed that the mixin was used four times -- it was clearly the core of this module. But what was it doing? Styling body columns. Yes it was appropriately named. But what concept or trait was shared between those body columns? (That reason would often make a better name.) But I could not find that trait. There were 10 different branch paths possible with the mixin but only four uses of the mixin. It seemed that the only convention the mixin provided was an enforcement of the selector names of #main, #left, and #right. That might be useful if I, the reader, don't need to know what those selectors are -- but I do and so the only value provided by this mixin only served to move information I needed to know when looking at the parent selector to another place. So I deleted the mixin and replaced it with the equivalent sass. Then I extracted the `last` mixin to a `.last` class and `@extend`ed it in those places where the mixin was in use.

When I was done, the [refactored version](http://gist.github.com/472433) had exactly the same number of lines but I find this version of the stylesheet to be much easier to understand. I hope you do as well. I know that [bbttxu did](https://twitter.com/bbttxu/status/18352062441) and I would like to thank him for [letting me](https://twitter.com/bbttxu/status/18447325658) pick on his stylesheet.

<%= render "code/refactorings/negative_value_mixin_refactored" %>
