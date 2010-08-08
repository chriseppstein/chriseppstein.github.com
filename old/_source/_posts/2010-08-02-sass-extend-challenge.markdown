---
title: "Sass Challenge: Use selector inheritance this week."
browser_title: "Sass Challenge: Use selector inheritance this week"
description: "It's time to start using @extend."
category: blogging
featured: true
intro: "I challenge you to start using Sass's @extend directive. Find at least one place in your stylesheets where selector inheritance is appropriate and put it to use."
---
While the most talked about feature of Sass 3 has certainly been the new SCSS syntax, it is not the most interesting feature of that release. In fact, the goal of the new syntax was to remove a barrier to adoption so that more people could enjoy the powerful features that Sass has to offer. Without a doubt, the most powerful feature that Sass provides is selector inheritance.

## Do you `@extend`?

I don't think people are really using `@extend` yet. Maybe I'm wrong, but I don't see people talking about it much yet and I don't see code snippets using it very often. Why is this? I'm pretty sure it's because we haven't done a very good job explaining the feature. But also I think it's because most of us haven't tried to use it. Until we try it's hard to know when and where to use a new concept. But I think when you get it, you're going to wonder how you ever survived without it. And until you ask questions about it, we don't know how to describe it better.

## Why you should use inheritance

Inheritance makes an implicit relationship explicit. Like mathematical expressions or color transformations, it shows us, in our styles, that a relationship exists in the most concise way possible. Once you understand it, using inheritance will decrease the time it takes to write styles and understand them because the relationships are simple to understand and reason about. If you haven't seen my refactoring of Digg's stylesheets, please [check it out](/blog/2010/05/25/refactor-my-stylesheets-digg-edition/) because I think it's a great example of inheritance.

Oh and it's a really good way to reduce the size and increase the performance of your generated stylesheets.

## The Challenge

This week, take a little time to read up on `@extend` if you haven't done so yet and then seek out an opportunity to use it. Get familiar with how it works and where it's useful. Look at the output and make sure you understand it. If you do this, please post a link to the code in the comments so we can look at it. Maybe you'll come up with a clever use we didn't imagine or maybe you'll commit a horrible sin without knowing it. We can all learn together.

## The Basics

Here's some basic documentation on the `@extend` directive:

* [The Feature Announcement](http://nex-3.com/posts/99-selector-inheritance-the-easy-way-introducing-extend) that Nathan and I put together initially.
* [Reference Documentation](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#extend) for a nuts and bolts description about how it works.
* [Another Good Explaination](http://awardwinningfjords.com/2010/07/27/sass-extend-introduction.html) by Thomas Reynolds

## Some "Best Practices"

I use this term loosely because I think the best practices around selector inheritance are still forming. But here's some conceptual guidelines you might find useful to help you decide when and where to use selector inheritance:

* Use `@extend` to replace complex mixins that do not accept any arguments. This will result in less output in the CSS as long as the contents of the class are longer than the extending selector. Remember that you can still define that base class in terms of mixins from libraries like compass.
* Use `@extend` within a mixin to share base styles while still customizing the variable parts without breaking your existing API.
* Use `@extend` to share implementation with a class has complex behavior that spans many selectors.
* Use `@extend` to remove forced redundancy in your markup. Classes should be independent. If applying one class to an element assumes that some other class will also be applied, an implicit inheritance relationship exists -- make it explicit and clean up your markup.
* Use `@extend` within projects, less commonly in shared libraries between them -- in those cases create a mixin to share and define a project-specific base class using it.

## Some Interesting Uses

* Assuming you've got a reset in your stylesheet, you can extend basic elements. For instance, `div.code` could extend `pre`.
* [Enforce a Style Guide](http://awardwinningfjords.com/2010/07/30/style-guides-using-sass-extend.html) without putting presentational classes into your markup.
* Go [Object Oriented](http://wiki.github.com/stubbornella/oocss/) -- the inspiration for the `@extend` directive.
* Use a CSS framework without porting it. For instance [Iain Hecker has done this with jQuery UI](http://iain.nl/2010/07/using-sass-with-jquery-ui/).

## Some Gotchas

#### The Cascade

Because `@extend` rewrites selectors, you may encounter issues with the cascade. Consider the following stylesheet:

    .loud  { font-weight: bold; }
    .quiet { font-weight: lighter; }
    .angry { @extend .loud; color: red; }

In conjunction with the following markup:

    <div class="angry quiet">Can you hear me?</div>

Even though the `.angry` class is declared after the `.quiet` class in the source stylesheet, the .quiet class will win the font-weight property because when sass rewrites the selectors you get this:

    .loud, .angry { font-weight: bold; }
    .quiet { font-weight: lighter; }
    .angry { color: red; }

This is certainly a case where a browser-based implementation would be able to do a better job. But in this case, at least, I believe it's nonsensical to apply both of these classes to the same element. It's our belief that selector rewriting is safe under normal use cases and that failures like this will generally be due to mixed concerns. Please let us know if you find a counter-example.

#### Multiple Stylesheets

The Sass compiler only operates on one CSS file at a time. Using `@extend` in one sass stylesheet will not affect another sass stylesheet unless they are both imported into the same CSS file. This might be useful or it might be unexpected. If you're building a single output file, then you'll probably not notice this problem.

#### Overly Generic Classnames with Multiple Meanings

Consider a nested selector that extends a class that is similarly nested. If  that class is an overly generic class name that is reused for a different purpose, you might end up rewriting more selectors than you intended. Example:

    .clear { clear: both; }
    
    #context {
      .clear { background-color: transparent; }
      #see-thru { @extend .clear; }
    }

Becomes:

    .clear, #context #see-thru {
      clear: both;
    }
    
    #context .clear, #context #see-thru {
      background-color: transparent;
    }

Easy to catch in this situation, but with any reasonably complex stylesheet you can make this mistake if your classnames ever carry multiple meanings. Of course, this will cause problems in other ways so it's best to only ever give a single meaning to each class name and only use nesting to apply customizations to that meaning in different contexts.