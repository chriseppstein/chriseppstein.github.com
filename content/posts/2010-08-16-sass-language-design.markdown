---
title: "Sass Language Design: Philosophy & Approach"
browser_title: "Sass Language Design: Philosophy & Approach"
description: "How we analyze and approve or reject new features for Sass."
category: blogging
featured: true
intro: "How we analyze and approve or reject new features for Sass."
byline: "By Chris Eppstein & Nathan Weizenbaum"
---
Sass has a lot of language features that CSS does not provide. To
the outside observer, the way new features come into existence
might seem like a bit of mystery. It's become clear recently
that we need to do a better job of explaining it.

First, there's no formal process for how we decide to add new features to
Sass. Good ideas can come from anyone from anywhere and we're happy to
consider them from the mailing list, IRC, twitter, blog posts, other css
compilers, or any other source. However, most of the time we end up saying
no.

In this post, we hope to describe the thought process we go through to make
those decisions. In future posts, Nathan and I will cover some
often-requested features and why we've decided against them.

## Personas

There are four personas who we consider when thinking about new Sass features:

<dl>
  <dg>
    <dt>Beginning Front-Ender</dt>
    <dd>Knows CSS syntax, but is confused and frustrated by the nuances of
      building cross-browser websites. Often bases their stylesheets
      using a core from a blog post or CSS framework. Maybe a programmer
      who has to do CSS for one reason or another.</dd>
  </dg>
  <dg>
    <dt>Knowledgeable Front-Ender</dt>
    <dd>Has a strong working knowledge of CSS. Gets the job done,
      but still gets frustrated when the styling for a site gets large and complex.
      Reads blog posts about CSS, but probably doesn't write them.</dd>
  </dg>
  <dg>
    <dt>Expert Front-Ender</dt>
    <dd>Lives and breathes CSS. Knows what to avoid and has most of
      <a href="http://www.quirksmode.org/">quirksmode</a> memorized.
      Has read several books on stylesheets. Can create novel designs
      and implementations that inspire others.</dd>
  </dg>
  <dg>
    <dt>Extension/Framework Builder</dt>
    <dd>Sees patterns in their work and wants to share them
      with others. Likely to have some programming skill.
      May overlap with other personas to varying degrees.</dd>
  </dg>
</dl>

We've come up with these personas by talking to people who write CSS.
We include as wide a sample as possible.
We talk to people who love Sass, people who dislike it,
people who are new to it and ask for help on the mailing list,
and even people who have never heard of it.

We're primarily focused on supporting the knowledgeable front-ender,
because that's the largest group of users. For them, we want features
that are frequently useful, and that don't require exceptionally deep
knowledge of CSS or Sass to use. Our secondary focus is
making it easy for a beginner to get started using Sass, and to create
cross-browser designs with very little effort.

Only once we're confident that these two personas are well-served are
we willing to add advanced features for the expert front-ender and the
extension builder. This means that features that are very complex,
that require advanced knowledge of CSS or Sass, or that require
advanced programming ability, usually don't make it in.

## The Gauntlet

Any new feature proposal must run the gauntlet, and be able to stand
up against a series of difficult questions. Following is a list of
some of these questions. It's not comprehensive and we don't
explicitly check each one off, but it's a good summary of our thought
process when evaluating a new feature.

1. **What problem does the feature solve?** Any new feature must solve
   a real problem that can be clearly explained. The more common the
   problem, the more awesome the feature and Awesome is Sass's middle
   name.

2. **Does this problem have another solution?** If an existing solution
   exists then we'd prefer to keep things as they are. But this does
   not mean that the feature is rejected, instead it must bring
   substantial benefit. This is often the case for those features
   that make a very common task easier. The ability to nest
   selectors is a good example of a feature that optimizes something
   that is very simple to do, but that happens a lot, resulting in a
   large cumulative benefit.

3. **How does the feature interact with the other Sass features?** Are
   there cases where the feature would introduce confusion? Features that
   work well with existing features are more likely to be accepted. Can
   the interaction of with another feature be reasoned about easily? Will
   it generate the expected result for a Sass user who understands both
   features individually? For instance, if a user understands both the
   parent selector (`&`) and mixins, when she sees the `&` used at the top
   level of a mixin, she'll understand that it refers to the selector that
   includes the mixin.

4. **Will the user understand the feature intuitively?** Ideally, a new feature
   would be so obvious it wouldn't need any explanation at all.
   Unfortunately, this can't always be the case. If it does need to be
   learned, how hard is it? Can it be explained to even the beginning
   front-ender in one or two sentences? Variables pass this test with
   flying colors -- when a new user sees them, they know what's going on
   right away. Mixins usually aren't that obvious, but they require very
   little explanation to be clear.

5. **Does the feature make a stylesheet harder to maintain?**  When a
   feature would create a situation where a change in one place in the
   stylesheet causes unexpected changes elsewhere, it's unlikely to be
   accepted. Many features found in other CSS preprocessors fail this
   test, and it is our primary reason for rejecting them in Sass. Usually
   we consider this question in the context of a team of designers working
   on one stylesheet, or one person picking up a stylesheet that hasn't
   been touched in months and changing it without fear.

6. **Does the feature make something new possible?**
   This question is structural in nature: of course, Sass can't add
   anything that's impossible in CSS. But the `@extend` directive and
   numeric expressions are great examples where features allow the
   expression of a relationship that exists in practice but that couldn't
   be expressed in a stylesheet before.

7. **Will the feature be misused?** Sass's philosophy leans towards
   giving power to advanced users, but there are cases
   where a powerful feature is likely to be misused by a beginning user.
   Unless it provides enough benefit to warrant inclusion anyway,
   it's likely to be rejected.

8. **Is it CSS-y?** Sass syntax should feel right at home with CSS syntax
   and its existing semantics and structure. This means that sometimes a
   good idea gets changed a lot between initial concept and final
   implementation. For instance, [there were several syntaxes we considered for
   providing the ability to inherit selectors](/blog/2009/10/12/css-class-inheritance/).

## For Example

A common request that we get for sass is to allow `@import` to import an entire
folder of sass files with one call using some sort of globbing syntax. This
feature has been rejected and you can view the [feature request for
it][globbing-request] if you like.

1. **Does it solve a problem?** Yes, this feature solves a common problem of
   having to create a top level import file and then specify each imported file
   explicitly. This saves time because the person adding a new stylesheet doesn't
   have to worry about adding it to their master stylesheet.
2. **Does it have an existing solution?** Sort-of. The import directive can accept
   more than one stylesheet separated by commas.
3. **Does it interact well with existing features?** It has no positive or
   negative impact.
4. **Will the user understand it intuitively?** Yes. We think it is not hard to
   understand this feature and most users will grok it immediately or can learn
   it in a few minutes of research.
5. **Does the feature make a stylesheet harder to maintain?** This feature would
   make stylesheets easier to maintain in some respects: Less files changed when
   adding a new one, less time spent figuring out that you forgot to import it.
   But it will also make some stylesheets harder to maintain: Adding a new file
   might import into a point of the cascade that causes styles to apply in an
   unexpected way -- fixing this requires reverting to the current import
   mechanism and debugging it might take a while to understand.
6. **Does the feature make something possible that wasn't possible before?** Yes.
7. **Will the feature be misused?** Yes. This feature is best used when following
   certain best practices like having scoped stylesheets or importing library
   files that don't themselves define any selectors, but there's no good way to
   enforce this, thus leaving the the feature open to misuse by users who think
   they are saving time only to lose all those savings and then some when it
   fails for them.
8. **Is it CSS-y?** Yes. Presumably the syntax for such a feature would use `*` to
   glob imports and `*` means any element in a selector so it has some
   familiarity.

Clearly this feature was a mixed bag. It benefits some users but it also
discourages other users from thinking through an important aspect of CSS:
Where does a partial belong in the cascade. If the feature offered a greater
benefit to the power users, it might have been approved but files are added
rarely and the error scenarios around forgetting to add an import are much
easier to diagnose than the error scenarios around breaking the cascade. At
the end of the day, we said no to this feature because it had more downsides
than upsides in a "weighted average" sense.

## We're not perfect

We understand that reasonable people might come to different conclusions
when they evaluate features against these criteria. Many of them can be
influenced by one's past experiences and their mindset. In this respect,
it's good that there are other stylesheet compilers making different decisions
about what features should exist and what features shouldn't. It allows for
experimentation and learning.

At the end of the day, someone has to make a decision about whether a proposed
feature is in or out. In almost all cases, Nathan and I come to an agreement
-- sometimes this takes minutes, sometimes it takes weeks or more. But open
source software is generally governed by a [benevolent dictatorship][dictator]
and for at least a couple years now that person has been Nathan. I've found
him to be increasingly good at this role. He's eager to hear new ideas,
and careful in his consideration. With a well crafted argument, it is very
possible to change his (and my) mind.

[dictator]: http://catb.org/~esr/writings/homesteading/homesteading/ar01s16.html
[globbing-request]: http://github.com/nex3/haml/issues/issue/97
