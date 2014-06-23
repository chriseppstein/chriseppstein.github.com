---
title: "Balancing Complexity in Sass"
browser_title: "Balancing Complexity in Sass"
description: "When is a Sass file too complicated? How far should you go
with Sass?"
category: blog
intro: "When is a Sass file too complicated? How far should you go
with Sass?"
featured: true
---

Psst. I want to let you in on a little secret about Sass. Let's keep
this between you and me: _Sass doesn't have any original ideas in it_. I
think this is actually the key to Sass's success. Original ideas are
hard to understand. Every single Sass feature is simply a formalization
of what developers had already been doing.  Initially, Sass features
simplified what developers were doing in CSS, or in templating languages
on top of CSS, and simply put a nice abstraction on top of existing
patterns that we saw in use every day.

As Sass has progressed, we have turned that eye of simplification onto
Sass itself. Recently, some Sass features have been added to simplify
the Sass code we saw people writing every day and the language's
expressiveness has continued to increase.

As Sass has become more powerful, we are starting to reach a very
interesting point in the language's maturity: Sass users are now able to
express in Sass syntax complex behavior for things that they would have
used to only imagine as language features.

As you might expect, when implementing a complex behavioral pattern in
Sass, the code is going to be complicated. Recently, I read a blog post
calling out someone blogging about a Sass pattern they've found useful
and saying that they had gone "too far" and created code that is
"unmaintainable".  But if it's done right, that complexity is hidden
behind a strong abstraction.  So the question is, how far is too far?
When has a Sass developer jumped the shark and made something that is
unintelligible and unmaintainable?

I'll grant you, sometimes I read a Sass user's code and I shake my head
and say to myself:

![You took too much man](http://i.imgur.com/glxrZ.jpg)

I see a pattern as new Sass features are introduced or when people first
discover the language (this is true for other technologies as well). We
want to try them out! And in doing so, we tend to reach a bit too far.
Maybe we nest too deep. Maybe we make too many mixins or extend things
that should not have been extended... because we can. And then we
experience this and realize it's not better and then we find the happy
medium of when and where to use a particular feature. 

I will grant you that concepts implemented in pure Sass might not feel
as natural as if they were in Sass itself. In fact, the limitations of
the Sass syntax might make an otherwise good idea, bad in practice. But
I **always** appreciate the attempt to find a simplification that works.
Every community needs these risk-taking, crazy people who are willing to
buck trends and try things that may actually be terrible ideas. Because
the only way to have a great idea is to have lots of ideas and for us to
share them, try them and critique them. Bad ideas will wither and die.
But the good ideas will spread because they will make people's code
better.

I would encourage people who have tried to do something in your Sass
project only to discover that it turned out to be a net negative, *you
need to undo that mistake*. Don't leave bad ideas in your project -- but
also don't be afraid to try them! And if you write something
complicated, by all means [test
it](http://mts.io/2014/04/02/sass-unit-testing/) and document it.

I for one am really happy to see Sass reach this point where the
language can self-host new ideas. As one of the language's designers,
seeing things actually working for people makes a very strong case for
what should become part of Sass's core feature set. Or maybe they point
towards features that make it easier to extend Sass's syntax in a more
natural way. I'm not entirely sure yet.

Finally, when you look at a some concept that causes you to scratch your
head, you can actually read the implemenation. And when you do, If your
reaction is "Whoa, that's too much!" instead of "Cool, I can figure this
out!"  Then, I humbly submit that you are being short-sighted. The
underlying implementation of *everything* you do every day when working
on the web is so incredibly complex. The fact that a little bit of that
complexity is accessible to you instead being neatly tucked away across
a language barrier, doesn't make things inherently less maintainable.

In fact, it may make them more maintainable. Strong abstractions are
stable and don't need updates very often, so even if the code is
complex, that's ok. As long as it presents a coherent, well-tested API,
you will have a codebase that is usually more maintainable one the
whole. And in the rare case where you find a bug in Sass code, instead
of in something in Sass itself, you'll be able to actually dig in and
maybe even fix it yourself instead of just filing a bug and hoping for a
fix.
