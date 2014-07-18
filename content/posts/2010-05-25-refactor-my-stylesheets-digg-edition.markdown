---
title: "Refactor My Stylesheets: The Digg.com Edition"
browser_title: "Refactoring Digg.com's Stylesheets using Sass"
description: "See how Chris Eppstein cleans up Digg's CSS using Sass."
category: blogging
featured: true
intro: "See how I clean up a portion of Digg's CSS using Sass."
---
Secret confession: I like refactoring code. I especially enjoy refactoring stylesheets. So I'm considering a semi-regular blog posting where I refactor someone's css into Sass. Maybe they request it, maybe they don't... But I think there's a lot we can learn from seeing the process for both existing and potential Sass users. Having this thought, and for no particular reason, it came to me that I should pick on [digg.com](http://digg.com/). I had never looked at digg's stylesheets before starting on this endeavor and had no idea what I would find. The results were surprising.

Before I begin, I'd like to say that I was impressed by digg's stylesheets. They have clean, semantic markup that is styled using CSS that upon initial inspection made me think they must be using a generator of some kind, but after closer investigation, I've decided that they are just really diligent and anal about their stylesheets. I was both pleased and dismayed to find that they serve their CSS uncompressed -- this gave me a unique insight into how they format their CSS, but I was sad to see such a high traffic website not following some basic best practices.

## The Process

I made a new compass project and downloaded [their css][original-css-location] as a file named global.scss. Sadly it didn't compile. Happily, this was because of a syntax error in their stylesheets. They had a trailing comma in a selector, and while most browsers probably handled this gracefully, it was a validation error that might have caused a user-agent to drop that rule. Fixing this allowed compilation to succeed. I then compiled their stylesheet using `--style compressed` and found that the Sass Compiler was able to reduce the output by almost 14kb without a single change to the code -- **a 23% reduction in size**.

I now set my mind to reading through their stylesheet. However, I was already looking at a gold mine. The compilation error was in a block of styles that are the exact use case that we presented as the [canonical example for `@extend`][extend-example]. And since the styles were already operating on semantic markup, I decided I didn't need to look much further.

### Step 1: Extract Partial

I cut the related styles and pasted them into a new partial stylesheet named `_feedback.scss`. Then I inserted `@import "feedback";` in its place in `global.scss`. Now I was able to focus on a single set of related styles. Here's the raw css:

<script src="http://gist.github.com/412696.js?file=feedback_original.css"></script>

### Step 2: Analyze styles

There is a lot of duplication in CSS when you use semantic markup. It can be challenging to identify the different types of duplication. First and foremost, I saw a large amount of selector duplication that implied an inheritance relationship. I looked for a CSS class that could function as the base class and found none. I also saw a repeating pattern relating to the colors and iconography. Lastly, there was some complex nesting of selectors.

### Step 3: Extract Base Class

Since there was no functional base class existing in the site styles, I needed to create one. I decided to call it `.feedback` because all of the class names in use described a type of user feedback and this class was not in use already. Unfortunately, Sass does not yet have any notion of an abstract base class, so this cleanup will incur some cost of additional output of a style they don't want or need. I think the clarity of the code makes this trade-off worth while, but this is an opportunity for a new Sass feature and one that [Natalie](http://nex-3.com/) and I have discussed before. At this point, the stylesheet now looked like so:

<script src="http://gist.github.com/412696.js?file=extract_base_class.css"></script>

As you can see, extracting a base class lends considerable readability to the source file. After adjusting the formatting and making some minor changes to the generated css, we have the [following differences](http://gist.github.com/412696#file_extract_base_class.diff).

Summary of differences at this point:

* An extra base class in the output.
* Some changes to how colors are printed.
* Four bugs have been magically fixed: Missing commas, typos, and a forgotten class in a set of inherited styles.

The rest of our refactoring will have no further material differences to the output.

### Step 4: Apply Nesting

Much of the duplication required when styling semantic content is due to styling nested content. Sass's ability to nest selectors makes this stylesheet much easier to read and understand what's going on. Note how I'm using Sass's parent-reference selector (`&`) with the styles for `h3, strong`. The intent of that block is to style those elements, so I have inverted the nesting order to give more clarity to the intent of those styles.

<script src="http://gist.github.com/412696.js?file=feedback_nested.css"></script>

### Step 5: Extract Mixin

The last major source of duplication in this stylesheet fragment is the common styling pattern for colors and iconography. To simplify this we extract a mixin and apply it wherever the pattern is in use. 
<script src="http://gist.github.com/412696.js?file=feedback_extract_mixin.css"></script>

## Results

The final form weighs in at 85 lines of code ([see the final generated css][final-css]). Down from 125 lines of code and providing the exact same output modulo formatting and the order of selectors within a single rule. This is a **32% reduction in the number of lines of source code**! Additionally we fixed **six bugs** without trying. But the biggest win is that the adding a new kind of feedback requires only 1 or 2 points of edit instead of the 5-7 that would have been required before. This is, without a doubt, more maintainable and the defect rate in this tested, in-production stylesheet around this set of styles is evidence of how hard it is for even great front-end developers to maintain semantic CSS.

## Epilog

If you liked this blog post and think I should do more like them, I need your help. Please send me an email with the styles you'd like me to refactor. If I feel there's some unique learning to be had, I'll dissect them and put them back together in a future post.

[original-css-location]: http://cotnet.diggstatic.com/css/448/global.css
[extend-example]: http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#extend
[final-css]: http://gist.github.com/412696#file_final_generated_output.css
