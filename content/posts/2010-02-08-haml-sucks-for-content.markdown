---
title: Haml Sucks for Content
browser_title: Haml Sucks for Content
description: "Haml is awesome, but if you're using it for inline markup, you're doing it wrong."
category: blogging
featured: true
intro: "Haml is awesome, but if you're using it for inline markup, you're doing it wrong."
---

I am not writing this blog post in HTML, and I'm certainly not writing it in [Haml][haml]. I'm using [Markdown][markdown]. Markdown is a great syntax for content. It's so good at it, that all of the content for the Haml website is [written][haml-ex1] [in][haml-ex2] [markdown][haml-ex3]. 

When I say content, I mean the meat of a web page. The stuff that is left after you take away the header, footer, sidebar, ads, etc. The stuff the user is there to read. Don't use Haml for adding markup to your inline content.

{% include code/haml_sucks/just_dont.html %}

Haml is for Layout & Design
---------------------------

Haml's use of CSS syntax for IDs and class names should make it very clear: The markup you write in Haml is intended to be styled by your stylesheets. Conversely, content does not usually have specific styling - it is styled by tags.

Haml documents do two things to make you faster:

1. Make the structure of the document obvious by forcing indentation.
2. Make it easier to switch between styles and markup.

Work-Arounds
------------

When I asked [Nathan](http://nex-3.com/), the man behind both [Haml][haml] & [Sass][sass], if he would mind it if I wrote this post he responded:

> No, it's true.

Nathan's acknowledgment of Haml's weaknesses is one of its strengths. He has done a lot to sand down Haml's rough edges over the two years I've been following Haml's development. But first and foremost, **I think there is a misconception that Haml's indentation-based tags are the only way to create markup in a Haml document. This is not true.** Here are several ways you can embed inline content within a Haml document:

### &bull; Inline your HTML

That's right. Just put some HTML into your Haml document. Don't be afraid, it'll be just fine.

{% include code/haml_sucks/inline_html.html %}

### &bull; Use Filters

Haml lets you pass any block of content through a filter. If you find yourself thinking that Haml is getting in the way, that's probably because you aren't using a filter. In any filter, you can use `#{}` to insert output from code. The following filters are available for processing your content:

* `:plain` -- Simply passes the filtered text through to the generated HTML.
* `:cdata` -- Surrounds the filtered text with a CDATA escape.
* `:escaped` -- Works the same as `:plain`, but HTML-escapes the text before placing it in the document.
* `:erb` -- Parses the filtered text with ERB -- the Rails default template engine.
* `:textile` -- Parses the filtered text with [Textile](http://www.textism.com/tools/textile). Only works if [RedCloth](http://redcloth.org/) is installed.
* `:markdown` -- Parses the filtered text with Markdown. Only works if [RDiscount](http://github.com/rtomayko/rdiscount), [RPeg-Markdown](http://github.com/rtomayko/rpeg-markdown), [Maruku](http://maruku.rubyforge.org/), or [BlueCloth](http://haml-lang.com/docs/yardoc/www.deveiate.org/projects/BlueCloth) are installed
* `:maruku` -- Parses the filtered text with [Maruku](http://maruku.rubyforge.org/), which has some non-standard extensions to Markdown.

{% include code/haml_sucks/inline_markdown.html %}

### &bull; Partials

Haml is framework agnostic, but at least within rails, the framework will compile partials and insert the compiled content into your page. At [Caring.com](http://www.caring.com) we use the [Amor rails plugin](http://github.com/caring/amor) for markdown content. This makes it easy for us to compose templates, partials, and layouts of different formats into a single page.

{% include code/haml_sucks/partials.html %}

Some Other Haml "Gotchas"
-------------------------

So let's just get it all out on the table. Haml is really good at what it is good at, but it is really bad at some other things. Here they are in no particular order:

### &bull; Preformatted Content

Haml's default mode is to pretty-print your output. This wreaks havoc with preformatted text in &lt;pre> and &lt;textarea> tags. Haml provides a `:preserve` filter that inserts the filtered text into the output with whitespace preserved. For some reason, it still never quite works right for me. So I've found that the simplest way is to just turn the pretty-printer off by adding this to my `environment.rb`:

    Haml::Template.options[:ugly] = true

More on [Whitespace Preservation](http://haml-lang.com/docs/yardoc/file.HAML_REFERENCE.html#whitespace_preservation).

### &bull; Performance

The `:ugly` option was actually added to make haml faster. With it on, Haml is *approximately* the same speed as ERB. With it off, [Haml is 2.8 times slower than ERB](http://nex-3.com/posts/87-haml-benchmark-numbers-for-2-2). **NOTE: the production environment default is to turn :ugly on.**

But with tools like firebug, I just don't see the point in having pretty-printed html even in development. So again, I recommend you just turn `:ugly` on and treat it is a debugging tool.

### &bull; Stand-Alone

Haml comes with a command line tool that lets you process Haml files into HTML. This is useful for small, quick documents, but it's not the basis for a website. Haml is a templating engine and it doesn't provide many of the facilities you need for building a maintainable website. If you want to build a static site with Haml, please consider using one the following:

* [StaticMatic](http://github.com/staticmatic/staticmatic)
* [Nanoc](http://nanoc.stoneship.org/)
* [Middleman](http://github.com/tdreyno/middleman/)
* [Webby](http://github.com/TwP/webby/)
* [Serve](http://github.com/jlong/serve/)

### &bull; Out of Order Processing

You cannot use haml to emit malformed HTML. This is a feature, but it is sometimes in the way. For instance a nice trick in ERB is to join an array like so:

    <ul><li><%%= @items.map{|item| item.name}.join("</li><li>") %></li><ul>

Haml's answer to this is the [`list_of` helper](http://haml-lang.com/docs/yardoc/Haml/Helpers.html#list_of-instance_method). Which is pretty nice for blocks of formatted code.

    %ul= list_of(@items) do |item|
      = item.name

Unfortunately, this helper assumes you're generating a list and requires that you pass a block even when the array consists of simple strings.

### &bull; Multiline Code

Haml is meant to be a designer-friendly template format, and as such it encourages code that is readable by folks with a minimal understanding of code APIs. One of the ways Haml encourages this is by making it hard to write code that continues on the next line. Multiline code ends with a `|` at the end of the line. [Example](multiline).

If You Must
-----------

If you decide that you're going to write some inline markup with Haml anyway (hey, some folks are masochists), then you should read up on Haml's `precede` and `succeed` [helpers][helpers] as well as the [alligator operators][alligators]: `<` and `>`. May God have mercy on your soul.

Conclusion
----------

Despite its flaws, Haml is a very nice template language that optimizes the work my team and I do on a daily basis. We recommend it often. But the goal is that coding will be faster, easier and more enjoyable. If you have a different technology that fits better with how you think, then you should use that. But if you find Haml documents to be easier to read, but that you find yourself fighting it to make the output you need, then I hope this post has helped you understand how to play to Haml's strengths and avoid its weaknesses.

What I hope is clear is that if your job is to produce content, then Haml is probably not the template language for you.

### Postscript

Some might think because of my involvement in Sass that I'm equally involved in Haml. This is not the case. Most, if not all, of my Haml patches have been to help it support Sass better. I'm just an experienced Haml user who wants to be honest about Haml's Pros and Cons.

[alligators]: http://haml-lang.com/docs/yardoc/file.HAML_REFERENCE.html#whitespace_removal__and_
[haml]: http://haml-lang.com
[haml-ex1]: http://github.com/nex3/haml/blob/haml-pages/src/pages/about.haml
[haml-ex2]: http://github.com/nex3/haml/blob/haml-pages/src/pages/help.haml
[haml-ex3]: http://github.com/nex3/haml/blob/haml-pages/src/pages/release-notes.haml
[helpers]: http://haml-lang.com/docs/yardoc/Haml/Helpers.html
[markdown]: http://daringfireball.net/projects/markdown/
[multiline]: http://haml-lang.com/docs/yardoc/file.HAML_REFERENCE.html#multiline
[sass]: http://sass-lang.com
