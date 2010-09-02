---
title: "Data Attributes: Blurring the Line Between Content and Presentation?"
browser_title: "Data Attributes: Blurring the Line Between Content and Presentation?"
description: "Are HTML5 data attributes going to be misused?"
category: blogging
intro: "HTML5 data attributes have the potential to blur the line between content and presentation. I describe why I think this might not be the end of the world."
featured: true
---
While I was drooling over these [delicious buttons][bonbonbuttons] I saw [the author][simurai] do
something quite clever, so I tweeted:

> This is smart: `.button:before { content: attr(data-icon); }`

Basically, the author is using text in conjunction with [this wing-ding-like font][pictos] to
create iconography.

To which [@screwlewse][screwlewse], who always keeps me on my toes, replied:

> There are some that would say `data-icon="s"` is presentation in markup. Thoughts?

As a vocal proponent of a clean separation of presentation and content, I was forced to examine my
reaction against my rhetoric. Why is this any better or worse than `class="icon-s"`?

The answer is: it's not. @screwlewse is right. They are roughly equivalent, though for a number
of reasons which I will outline, I think the use of a data attribute in this case is a cleaner
solution.

Where is the Line between Content and Presentation?
---------------------------------------------------

As always, the world is full of shades of gray. What is content and what is presentation is as much
about content semantics as it is about separation of concerns and division of labor. My ultimate
goal is the reduction of the total cost to produce and maintain a content artifact across redesigns.
As such I see this type of use of data attributes as a superior approach for a content producer to
inform the design about what kind of icon they feel is appropriate for the content at hand.

So, should a designer ever use a data attribute like this when she is creating content? *No.*
Why not? Because she has better tools at her disposal and keeping the presentation in the markup
makes it harder to evolve a website's design.

But often she's not the one creating the content. So let's assume that for some business/workflow
reason, it is desired that the content production team has jurisdiction over iconography.

While I'm harping on it, I should point out that like any pre-canned CSS solution, using these
beautiful buttons commit you to classitis. However, this can be avoided by using a CSS compiler
like [Sass][sass].

Alternate Approaches
--------------------

### The `<img>` Tag

This is the worst possible approach. Iconography enhances content -- it is not
itself content. The image tag should be reserved for those rare instances where imagery is content
like a photo album. This approach takes all the power out of the hands of the designer. They can
disable it if they want, but that's about it -- they can't sprite it or apply interaction states.

### The `class` Attribute

The class attribute comes with this warning from the w3c:

> Note: Because CSS gives considerable power to the "class" attribute, authors could conceivably
> design their own "document language" based on elements with almost no associated presentation
> (such as DIV and SPAN in HTML) and *assigning style information through the "class" attribute*.
> Authors should avoid this practice since the structural elements of a document language often
> have recognized and accepted meanings and author-defined classes may not.

Put another way: the class attribute should describe what the content is, not what it looks like. But let's
ignore the W3C for a moment... so many people do anyway. If we use the class attribute we'd need
an explosion of styles just for iconography, however they could be made more readable:

    .icon-anchor:before { content: 'a' }
    .icon-box:before    { content: 'b' }
    .icon-cloud:before  { content: 'c' }

### Semantic Styles

    a.subscribe:before { content: 'M' } /* a mail icon */

This is my preferred approach. A subscribe link will always be a
subscribe link even if you decide to change the icon, the approach to iconography,
or do away with icons altogether.

Of course, you may have several legitimate uses for the "mail" icon in your application.
This is where [selector inheritance][extend] becomes quite handy:

    .picto-icon:before    { font-family: pictos; }
    .mail-icon            { @extend .picto-icon; }
    .mail-icon:before     { content: 'M'; }
    a.subscribe           { @extend .mail-icon; }
    a.unsubscribe         { @extend .mail-icon; color: red; }
    .toolbar .email-prefs { @extend .mail-icon; }

Presentation in Data Attributes: The lesser of several evils
------------------------------------------------------------

But as noted earlier, we have accepted that we must allow the content producers to indicate
the *desired* iconography. There are a few reasons why I prefer data-attributes to classes
in cases like this:

1. Classes are like tags. They are on or off and they do not have a value. This is severely
   limiting and because they are opaque and so our css and our content gets bloated and fast.
2. Mutual exclusivity. There might be 10 icon classes but only one should be applied. The
   use of a data attribute with a value enforces this constraint. Otherwise the content producer
   gets an unpredictable result from their point of view since it depends on the CSS cascade.
3. The designer can ignore it or override it with a more specific rule. If there's a page
   or context in the site that requires it, they can still evolve the design as long as
   the semantics remain roughly the same:
   <pre><code>.widget a[data-icon="M"]:before { content: url('/images/fancy-icons/mail.png'); }</code></pre>

In Conclusion
-------------

Like all things style related, I think Sass can help us avoid the need for mixing our
presentation and our content, but should you find yourself in a situation where it is necessary,
I think that data attributes present us with a useful, efficient alternative to classes.

[bonbonbuttons]: http://lab.simurai.com/css/buttons/
[screwlewse]: http://twitter.com/screwlewse
[simurai]: http://twitter.com/simurai
[pictos]: http://pictos.drewwilson.com/
[sass]: http://sass-lang.com/
[extend]: http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#extend