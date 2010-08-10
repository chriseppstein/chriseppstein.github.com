---
title: "We Can Have Hack Free CSS With the @unsupported Directive"
description: "Stylesheets can be hack free with a little help from the W3C."
intro: "Stylesheets can be hack free with a little help from the W3C. The @supported and @unsupported directives would allow conditional evaluation of CSS based on feature inspection."
category: blogging
featured: true
---

*This post discusses a feature for CSS that does not yet exist.*

As a CSS Framework creator and maintainer, it's become obvious to me that graceful degradation can only get us so far down the path of creating robust designs that work in all browsers. Moreover, CSS parsers are less and less broken, but are increasingly diverse in the list of features they support, making relying on CSS Hacks an impossibility. It is time for the CSS specification to provide feature support that solves the backwards-compatibility problem once and for all.

My One Request for CSS3: The `@unsupported` Directive
-----------------------------------------------------

The `@unsupported` directive processes the corresponding CSS if the CSS feature is not supported. Similarly, the `@supported` directive has the same syntax but only processes the embedded CSS if the style property is supported.

<%= render "code/unsupported_directive/simple_example" %>

Feature Queries
---------------

The `@unsupported` directive would accepts a "Feature Query" as its single argument. Feature queries should be quoted except in the simple case of basic property query as seen above.

<dl>
  <dt><code>border-radius</code></dt>
  <dd>Checks if the border-radius style property is supported.</dd>
  <dt><code>&quot;div {border-radius}&quot;</code></dt>
  <dd>Checks if the border-radius property is supported on div elements.</dd>
  <dt><code>&quot;display: table;&quot;</code></dt>
  <dd>Checks if the value table is allowed for some element.</dd>
  <dt><code>&quot;div{display: table;}&quot;</code></dt>
  <dd>Checks if the value table is allowed for the display property on div elements</dd>
  <dt><code>&quot;div,span{display: table;}&quot;</code></dt>
  <dd>Checks if the value table is allowed for the display property on div and span elements</dd>
  <dt><code>&quot;div{display: table;}&quot;, &quot;div{display: table-cell;}&quot;</code></dt>
  <dd>Checks if the div elements allow both <code>display:table</code> AND <code>display:table-cell</code></dd>
  <dt><code>&quot;div{display: table;}&quot; | &quot;div{display: table-cell;}&quot;</code></dt>
  <dd>Checks if the div elements allow EITHER <code>display:table</code> OR <code>display:table-cell</code></dd>
</dl>

Only element selectors may be used in a feature query selector.

Working with Legacy Browsers
----------------------------

The parsing rules of CSS dictate that unsupported features should be ignored, which is exactly the opposite behavior we'd like to have for the `@unsupported` directive. To work around this, I also propose a live-comment syntax to allow the `@unsupported` directive to be used to target legacy browsers that do not support the @unsupported directive (not unlike the conditional comments of IE). Browsers that understand the `@unsupported` directive would also need to parse these live comments and ignore the content between them if they support the feature. Legacy browsers would not see the `@unsupported` contents because they are within a comment, but they would see the directive's contents. Example:

<%= render "code/unsupported_directive/legacy_support" %>

What Do You Think?
------------------

I can't petition the W3C directly, I don't work for a member company, but the CSS3 specification needs some thought about how developers are supposed to gracefully take their applications forward. The specific syntax of feature queries still need some serious thought and discussion. I'm curious to see what the community thinks about this idea and if there's a better syntax or approach.
