---
title: "Sass 3.2 makes authoring CSS3 as easy as it will be"
browser_title: "Sass 3.2 is released"
description: "After more than a year in the making, Sass 3.2 is released
and makes it easier than ever to wrangle CSS."
category: blog
intro: "After more than a year in the making, Sass 3.2 is released
and makes it easier than ever to wrangle CSS."
featured: true
---

**TL;DR** In sass 3.2 there's a new kind of selector called a
placeholder selector for use with `@extend`. Mixins and functions can
now take any number of arguments and be defined in nested contexts. You
can now pass a block of styles to a mixin for placement by the
`@content` directive. Numbers will have now 5 digits of precision
instead of 3. But that's not all. Read on for the details.

CSS3 keeps getting more powerful and the browser support for all the new
shiny toys keeps growing. In the last year we've even started to get a
glimpse of what CSS4 will have to offer. This release introduces a
number of new features that have been driven by the need to create
clean, simple abstractions that allow authors and frameworks like
[Compass][compass] to build support for CSS3 and beyond.

One of the driving principles of Sass is that, as a language, it is
largely agnostic of browsers and their myriad quirks. We endeavor to
find syntax and semantics that enable authors and framework developers
to be creative in the ways they keep their stylesheets clean and
maintainable. As such, these new features have benefits that go beyond
our primary use case. We always look forward to seeing how you will use
them creatively in ways that we could not have imagined.

The Sass 3.2 release introduces several new major features and a number of
lesser features that we will describe in this post. The full list of
changes can be read in the [CHANGELOG][changelog].

1. Placeholder Selectors
2. Selectors Subjects
3. Mixin Content Blocks
4. Variable Arguments
5. Improvements for working with @media and other directives

## Placeholder Selectors

We are on record that `@extend` is Sass's best feature and we are
finally seeing the community catch on to the wonders of what selector
inheritance can be used to accomplish. However, since it's inception,
one of the things that has bugged us about `@extend` is that often times
the selector being extended isn't useful to the compiled CSS output. A
common pattern is to introduce a base class so that several concrete
selectors could share common styles. And while this worked great, having
the useless base class in the output left everyone feeling like this was
a hack.

In 3.2, we've added a fundamentally new kind of selector component that
we're calling a **placeholder selector**. Syntactically, a placeholder
selector is exactly like a class selector except that you use a `%`
instead of a `.`. The behavior of a placeholder selector is to "hold the
place" for a real selector that might extend the placeholder. If nothing
does extend it, then the selector and the associated ruleset is
discarded from the output, if something does extend it then the
resulting selector or selectors would be in the output, but the
placeholder selector itself will not be output. You can even have
multiple placeholders in a selector, all of which much be extended to
produce output.

    %clearfix {
      overflow: none;
      *zoom: 1;
    }

    aside, footer {
      @extend %clearfix;
    }

    #grid-container {
      @extend %clearfix;
    }

Produces:

    aside, footer, #grid-container {
      overflow: none;
      *zoom: 1;
    }

You might ask how a placeholder is different from a mixin with no
arguments -- at first blush they appear very similar. But, of course,
the most obvious difference is that when you use selector inheritance,
you're moving the selectors to the properties to work with the
cascade instead of copying the properties into the selectors to work
around the cascade. Another key difference is that placeholders can be
used in any part of a selector, they aren't required to be used as the
root selector. For instance:

    #sidebar %link {
      text-decoration: underline;
    }
    p %link {
      color: blue;
    }

    a         { @extend %link; }
    span.link { @extend %link; }
    button    { @extend %link; }

Produces:

    #sidebar a, #sidebar span.link, #sidebar button {
      text-decoration: underline;
    }

    p a, p span.link, p button {
      color: blue;
    }

But placeholders are not the only change in 3.2 regarding the behavior
of `@extend`.

## Selectors Level 4

Sass now supports all of the selectors in the CSS Selectors level 4
draft proposal and will take them properly into account when extending
them. The most interesting (from Sass's perspective) is the new subject
selector. The subject selector is not currently supported by any
browsers, but we wanted to be ready for it because it has non-trivial
impacts on our code. Basically with a subject selector, you can indicate
what selector component is being styled by appending a `!` to the end --
allowing elements to be styled according to what they contain. In Sass,
the subject is also what `@extend` applies to.

    header %component {
      margin-bottom: 0;
    }
    %component! ol {
      padding-left: 20px;
    }

    section! .widget { @extend %component; }

Compiles to:

    header section! .widget {
      margin-bottom: 0; }

    section! .widget ol,
    section! ol .widget {
      padding-left: 20px; }

Note: This above how things *will* work once [this bug][subject_bug] is fixed.

## Selector combinators and inheritance.

Sass now understands the meaning of all selector combinators and will
use this knowledge to prune out nonsensical selectors that used to
occur when extending complex selectors.

## Inheritance, Mixins, and Functions within @media and other directives

With the advent of `@media` and responsive design, more and more of the
structure of stylesheets has moved from the top-level of the stylesheet
to a nested context -- namely the `@media` context. But beyond `@media`
this pattern is repeated by `@keyframes`, `@document`, `@supports` and
we are quite sure there will be more like this down the road. As such,
in Sass 3.2 we have made a number of changes to working in a nested
context.

### Limitations on `@extend` in CSS directives

In Sass 3.1 it was possible to extend a selector that was outside an
`@media` directive with a selector that was inside the `@media`
directive. While there were some valid use cases of this that would work
when users were aware of the limitations of the compile-time nature of
Sass's `@extend` implementation, we found that by and large, most users
expected Sass to somehow magically make the `@extend` only apply when
the `@media` query matched.

So we have deprecated the ability for @extend inside a media query to
extend a selector outside it. If you are doing this, you will get a
deprecation message like:

    DEPRECATION WARNING on line 23 of application.scss:
      @extending an outer selector from within @media is deprecated.
      You may only @extend selectors within the same directive.
      This will be an error in Sass 3.3.
      It can only work once @extend is supported natively in the browser.

There are a few ways you can adjust to this:

1. Consider whether the inheritance is specific to this @media query,
   if it can be moved outside the query without changing the meaning, do so.
2. Sometimes, the inheritance can actually be modeled in the other
   direction. Consider whether there is a single class that should be
   extending a per-media placeholder instead.
3. Lastly, if you really need to use extend, you may need to introduce
   some duplication in your stylesheets -- consider making a different
   base class per media query and using a shared mixin to keep it DRY.

Fortunately, this is the only limitation we've had to introduce to
nested contexts. Mixins and functions have actually gained some new
features in these contexts.

### Nested definition of mixins and functions

In sass 3.1, we changed @import of local files to allow importing into a
nested context -- E.g. a selector or a directive. Rightly, many people used this feature, only to discover that the files they were trying to import gave them errors if they contained mixin or function definitions -- this was because those were only legal at the root-level context of a stylesheet.

As of Sass 3.2, `@mixin` and `@function` can be used in any nested
context. The definition of this mixin will replace the definition in the
parent context until the end of the current scope.

One thing to note about nested definitions is that mixins and functions
will call the version of other mixins and functions within their "lexical
scope". This is a fancy way of saying that the structure of the code
dictates what version of the mixin or function gets picked, not the
current runtime definition. Consider the following code example:

    @mixin foreground {
      color: color();
    }

    @function color() { @return red; }

    .not-nested {
      @include foreground;
    }
    .nested {
      @function color() { @return blue; }
      @include foreground;
    }

You might think that because the `color()` function was redefined in the
nested context that the output would be `.nested { color: blue; }` but
instead we get:

    .not-nested { color: red; }
    .nested { color: red; }

This is because the foreground mixin will always call the version of the
`color()` function that was defined in the same scope. What's more, if
you only define the `color()` function in the nested context, you will
get `.nested { color: color(); }` because the mixin being defined in the
outer scope can't see the color function in the inner scope causing it
to assume this is a CSS function.

## Mixin Content Blocks

Mixins have long been a great way to encapsulate the contents of a
selector, but Sass has not had a good solution for creating abstractions
that are more about creating a context than the contents. For instance,
not everyone immediately understands what `* html` at the start of a
selector does (It makes the contents of that selector only apply to IE6
and below). So we'd really like to name this common pattern so that
people who don't live and breathe CSS can still author it.

What's more, as the Sass community has embraced responsive web design
the need to abstract the `@media` directive became an imperative. While
Sass has several `@media`-specific features, we felt there was an
opportunity to create a more generalized feature. So in 3.2 we've added
a new ability for mixins to receive a block of content from the calling
context and place it using the `@content` directive where the mixin
deems it best within its own output.

    @mixin ie6 {
      * html & {
        @content;
      }
    }

    #signin {
      float: right;
      @include ie6 {
        display: none;
      }
    }

which compiles to:

    #signin { float: right; }
    * html #signin { display: none; }

But content blocks can do much more than this. For instance, the
`@content` directive can be called repeatedly, which might seem silly at
first but it can actually be quite useful. For instance, Compass [uses
this ability to reproduce the animation directives][keyframes] that need
to go into each vendor-prefixed section. Similarly, a mixin that accepts
a content block can choose to not use the content block at all.

Sass will raise an error if you try to pass a content block to a mixin
that does not have any `@content` directive in it and it will also raise
an error if you try to use `@content` and the include did not have an
associated content block.

One thing to note about content blocks is that when they are included,
their execution takes place in the caller's scope. That is, the
variables defined locally in the mixin will not be accessible by the
content block. However, the global state is shared by both the mixin and
the calling block and this can be useful. For instance, Compass uses
this to temporarily change the global state of what prefixes to generate
when within a prefixed `@keyframes` directive -- where the other
prefixes would be ignored. This behavior is exemplified by [this
gist](https://gist.github.com/3335300).

If you are a `.sass` syntax user, you will still use `@content` to
place the passed block, and to pass a block to an include you simply
indent. So the example above becomes:

    =ie6
      * html &
        @content

    #signin
      float: right
      +ie6
        display: none

As you see, mixin content blocks make it possible to author
context-based abstractions whether that context be a selector,
a global variable, or a directive like `@media`, `@document`,
`@keyframes`, `@supports` or any other context you can imagine.
For instance, a grid framework might use this to keep track of
grid nesting depth.

## Scriptable @media

The @media query components on the left and right sides of the `:` in a
query condition (enclosed in parens) can now contain SassScript
expressions. Example:

    $min-width-type: min-device-width;
    $smart-phone-min: 320px;

    @media all and ($min-width-type: $smart-phone-min) {
      #logo { background-image: url(/images/logo-small.png); }
    }

## Directive Interpolation

If you need to use SassScript in `@media` directives in places other than
the query conditions, you can now use interpolation (`#{}`). This will
also work in all existing CSS directives and any unknown directive that
is being passed through to the CSS output.

## Variable Arguments

CSS3 introduces many new multi-valued attributes. For example, multiple
background images can now be assigned to the same element. In order for
mixins to provide an adequate interface for abstracting CSS properties,
Sass has added a way to pass a list as arguments to a mixin or function
and to receive several arguments as a list. In Sass 3.2, we only support
variable argument lists for positional arguments, but in a future
release we intend to also support variable keyword-style arguments.

Throughout this section I will use mixins to demonstrate the feature,
but please keep in mind that the same functionality exists for function
declarations and function calls.

### Declaring a variable argument list

To receive several arguments as a list, simply add three dots trailing
the argument which you would like to receive the remaining arguments:

    @mixin background($backgrounds...) {
      -hack-number-of-bgs: length($backgrounds);
      background: $backgrounds;
    }

    #logo {
      @include background(white,
                          url(/images/logo.png),
                          url(/images/watermark.png));
    }

Becomes:

    #logo {
      -hack-number-of-bgs: 3;
      background: white, url(/images/logo.png), url(/images/watermark.png);
    }

A declaration can only receive on variable argument list, but that
variable arguments list can be mixed with other required and optional
arguments, as long as the variable argument list comes last.

    @mixin background($primary-bg, $additional-bgs...) {
      background: $primary-bg;
      background: join($primary-bg, $additional-bgs);
    }

    #logo {
      @include background(url(/images/logo.png),
                          url(/images/watermark.png));
    }

Becomes:

    #logo {
      background: url(/images/logo.png);
      background: url(/images/logo.png), url(/images/watermark.png);
    }

### Passing a list as arguments

It is somewhat common, especially among frameworks, to have a list of
values and then need to pass those into a mixin or function as
arguments -- especially when that mixin is a simple wrapper around a CSS
property. As such, Sass now allows you to pass a list as arguments:

    @mixin colors($fg, $bg, $border) {
      color: $fg;
      background-color: $bg;
      border-color: $border;
    }

    $box-colors: black, yellow, blue;
    .box { @include colors($box-colors...); }

Becomes:

    .box {
      color: black;
      background-color: yellow;
      border-color: blue;
    }

It's important to note that the list passed as arguments can be either a
comma-delimited list or a space-delimited list.

### Special handling of keyword arguments

Even though we don't yet support accessing keyword arguments from the
variable argument list, they can still be passed through to another
mixin or function transparently. For example:

    @mixin wallpaper($image, $top: 0, $right: 0, $bottom: 0, $left: 0) {
      background: $image;
      position: absolute;
      top: $top;
      right: $right;
      bottom: $bottom;
      left: $left;
    }

    @mixin logo($offsets...) {
      @include wallpaper(url(/images/logo.png), $offsets...);
    }

    #please-wait {
      @include logo($top: 3em, $bottom: 3em);
    }

Becomes:

    #please-wait {
      background: url(/images/logo.png);
      position: absolute;
      top: 3em;
      right: 0;
      bottom: 3em;
      left: 0;
    }

This facilitates a major use case of safely wrapping one mixin or
function with another so that you can add other properties alongside it
or manipulate the return value.


## Other small changes

### SASS_PATH

You can now set the `SASS_PATH` environment variable in your shell
(a.k.a terminal) to a colon delimited list of directories and Sass will
automatically look in each of them when finding a file for `@import`.

In ruby, the `SASS_PATH` environment variable will be loaded into the
mutable property `Sass.load_path` where it can further manipulated if
necessary. `Sass.load_path` defaults to an empty array.

### New functions

There are a few new functions avaiable to SassScript:

* `ie-hex-str` - returns a color (with an optional alpha channel) as a
  string suitable for use with IE's legacy filter property.
* `min` - returns the smallest value in a list.
* `max` - returns the largest value in a list.

### New color keywords

The [full array of color keywords][colors] are now understood
by Sass so they can be manipulated by the color functions.

### Null data type

Sass now supports a null data type. The `null` value makes an excellent
defaults for optional arguments in mixins and function or when
initializing a variable. Any null value is pruned from the output as is
any property that has been assigned a null value.

    $color: null;
    div {
      width: 23px;
      color: $color;
      border: 2px solid $color;
    }

Becomes:

    div {
      width: 23px;
      border: 2px solid;
    }

### Precision

Decimal numbers now default to five digits of precision after the
decimal point. While this will cause stylesheets to be slightly larger
this helps reduce sub-pixel rounding issues commonly encountered in
responsive web design.

As before, you can change the precision with the `--precision` argument.
For example `sass --precision 3` will return Sass to the 3 decimal
points of precision in sass 3.1 and before.

Ruby-based applications and Compass projects can set the precision in
their configuration code like so:

    Sass::Script::Number.precision = 3

## Looking forward

We're tired of doing big releases with big gaps between them and we
think you're tired of waiting for good features because the roadmap of a
the "big release" isn't complete. So we have decided that going forward,
each "big feature" that we implement will, after going through a beta
period for feedback, become it's own release. Small features that didn't
warrant a release will ship at that same time. What constitutes a
"Major" feature is left to our discretion, but this release has about
4 or 5 of them.

Here's some major features that we've agreed to ship in the future:

* Maps - An new data type for storing an association between a key and
  a value. This will help us implement variable arguments for
  keyword-style arguments as well as address a very common request for
  "variable interpolation".

* Better APIs for Lists and Strings - Working with Lists and Strings
  sucks. We're going to make it better.

* The parent selector (`&`) is coming to SassScript - this means that
  mixins will be able to make intelligent output based on their selector
  context and selectors that are not currently possible to construct
  using & as a selector will be possible using interpolation with `&`.

* Module system and `@import` improvements - As the sass community
  grows, we're starting to see naming conflicts. Best practices are
  helping avoid this issue for now, but a proper module and scoping
  system is needed to bring sanity here.

* Output optimization - Nathan has been dying to work on an optimizer
  for Sass ever since people started complaining about "Mixin bloat".
  `@extend` alleviated much of that need, but new use cases involving
  media queries have finally made this feature into a necessity.


[compass]: http://compass-style.org/
[changelog]: http://sass-lang.com/docs/yardoc/file.SASS_CHANGELOG.html 
[keyframes]: https://github.com/chriseppstein/compass/blob/37877b7effe9844880ed30373f708e09882a774c/frameworks/compass/stylesheets/compass/css3/_animation.scss#L33-70
[subject_bug]: https://github.com/nex3/sass/issues/481
[colors]: http://www.crockford.com/wrrrld/color.html
