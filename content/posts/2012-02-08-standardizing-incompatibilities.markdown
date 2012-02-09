---
title: "Standardizing Incompatibilities"
browser_title: "Standardizing Incompatibilities"
description: "It's time for the W3C CSS Working Group to enable a CSS Ecosystem"
category: blog
intro: "It's time for the W3C CSS Working Group to enable a CSS Ecosystem"
featured: true
---

[Yesterday's minutes][minutes] of the W3C's CSS Working Group revealed that the
Mozilla team is seriously considering adding support for some `-webkit`
prefixed properties. Make no mistake about it, this represents a real failing
of the CSSWG to officially standardize these vendor CSS properties before they
become widely adopted by developers.  Let us also agree on this fact: the net
effect of vendor prefixes on the web has been very good for the web. Giving
browser vendors the space to experiment and get developer feedback during the
development process has benefited both developers and users alike.

I'm sure there will be a lot of discussion about what a better approach for
browsers vendors might be. Versioned prefixes? New @-rules? Whatever they come
up with I'm sure it will be fine, until it falls apart in some unforeseeable
way and we get to play this game again.

## Much Ado about Nothing

If you are a Compass user, all these prefixes are dead to you. You don't need
to know or care about them.  Your stylesheets are insulated from what largely
amounts to an implementation detail. Compass maintains the browser vendor
support matrix and gives you a single, well-documented API. And when that API
changes, Compass deprecates it and provides you with helpful warnings so that
you can update your stylesheets accordingly.

Do you remember back when webkit's gradient syntax was horrible and firefox's
gradient syntax won? I do because I remember hating the webkit syntax and
trying to make it better in the API that compass provided.

These days, you only need to write:

    @import "compass";
    .bg {
      @include background-image(linear-gradient(#fff 20%, #0c0 50%, #000 80%))
    }

And Compass will still generate the old webkit syntax for your legacy users:

    .bg {
      background-image: -webkit-gradient(linear, 50% 0%, 50% 100%,
         color-stop(20%, #ffffff), color-stop(50%, #00cc00), color-stop(80%, #000000));
      background-image: -webkit-linear-gradient(#ffffff 20%, #00cc00 50%, #000000 80%);
      background-image: -moz-linear-gradient(#ffffff 20%, #00cc00 50%, #000000 80%);
      background-image: -o-linear-gradient(#ffffff 20%, #00cc00 50%, #000000 80%);
      background-image: -ms-linear-gradient(#ffffff 20%, #00cc00 50%, #000000 80%);
      background-image: linear-gradient(#ffffff 20%, #00cc00 50%, #000000 80%);
    }

However, there is only so much a Stylesheet Preprocessor can do on this front
by relying solely on progressive enhancement, but when you [combine it with
Modernizr][modernizr] you start to get a feeling of what could be possible...

## jQuery Saves Us from the DOM

I'm sure there are some downright horrible incompatibilities in the DOM. I'm
not 100% sure because it's been a very long time since I used the DOM directly.
jQuery, MooTools, Prototype and the like can all provide me with a single API
that adapts to the browser. On top of these tools, entire ecosystems are
thriving and making javascript web development pretty easy for new developers
and experts alike. As a result, our webpages are snappier and our user
experiences are richer.

But what made jQuery possible? As Molly E. Holzschlag [points out][mollysquote]
it was two things:

1. Browsers *try* to standardize the DOM. In most cases they succeed.
2. Javascript is standardized.

10 years ago, when the DOM was in shambles, scripting was too. There was no
standard programming language for the web and as a result, there could be no
jQuery. So if you love jQuery, you have to admit that establishing Standards
and aiming for Standard-compliant browsers is good for the web.

Recently, browser vendors have been cranking out tons of new DOM APIs for
HTML5. But it is DOM abstraction libraries that are giving them the cover to
make mistakes, learn, and eventually converge on a standard API. Fortunately
for the HTML Working Group, Javascript is [Turing
Complete][turing] and comes with
enough introspective ability to adapt to the browsers. Unfortunately, this is
not the case for CSS.

## CSSWG, Save Us from CSS

The CSS Working Group needs to stop rearranging deck chairs for a while and
plug the giant holes first.

Never in the history of software development have developers had to support so
many runtime environments with so little language support. We are currently
supporting almost 50 browser versions spanning 10 years of releases. We are
supporting screen sizes from small handhelds to giant desktops. We are
supporting high-latency, low bandwidth mobile experiences and broadband. And we
do this with selectors, property/value pairs, and a host of parsing tricks and
hacks. That a website looks even remotely fine in any significant subset of
these combinations is a testament to the hard work and diligence of web
developers -- not standards committees.

We need a language for expressing design abstractions. Two and a half years
ago, I wrote about [Why Stylesheet Abstraction Matters][whyabstraction] and
gave life to the CSS Preprocessor movement. It is time for the expressive power
of Sass to come to browsers themselves.

Don't get me wrong, preprocessing is and will forever remain an essential
approach to stylesheet development. There are a boatload of things that Compass
does (like sprite assembly and url munging) that simply wouldn't be viable
within a browser.  Not to mention, pre-compiling any new syntax will be
required to provide "graceful degradation" for legacy browsers.

But what is good for developers is also good for vendors. The CSS WG needs to
embrace the differences that make each browser unique and to give those
browsers the freedom to converge their implementations over time or to even
agree to disagree. This can be done while simultaneously giving them cover by
enabling CSS abstraction libraries through new syntax and language feature and
standardizing **the language** and a set of core APIs to provide introspection
of browser abilities.

It is time for [native feature detection][at-supports],
it is time for mixins and selector inheritance, it is time for variables, it is
time for user-defined functions, it is time for better syntax. Actually, I take
that back. It's way past time. Developers have been demanding variables for
their CSS for a decade and that CSS doesn't have this feature yet is an
absolute _embarrassment_.

It is time for the CSS WG to acknowledge its failures and to address the issues
fundamental to CSS's overly-simplistic syntax that has stunted web development
for over a decade now. By trying to make CSS "Simple" through simple sytax, the
working group has instead achieved incomprehensible property spaghetti. It is
time for a division of labor. Give new syntactic sugar and browser awareness
to the very best developers among us. Those developers can work together to
make beginner-friendly APIs for CSS like jQuery has done for the DOM.

Stylesheet abstraction has gone mainstream and it's time for CSS to embrace this
new direction and use it to everyone's advantage. If the CSSWG will commit
to this direction, I will do everything in my power to support your efforts and
make the end result a Stylesheet language that people love.

[turing]: http://en.wikipedia.org/wiki/Turing_completeness
[whyabstraction]: http://chriseppstein.github.com/blog/2009/09/20/why-stylesheet-abstraction-matters/
[at-supports]: http://dev.w3.org/csswg/css3-conditional/#at-supports
[mollysquote]: http://en.wikipedia.org/wiki/Turing_completeness
[minutes]: http://lists.w3.org/Archives/Public/www-style/2012Feb/0313.html
[modernizr]: http://roytomeij.com/2011/modernizr-the-sass-parent-reference.html

