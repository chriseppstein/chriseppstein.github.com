---
title: "How I Build Fancy Buttons"
browser_title: "How I Build Fancy Buttons"
description: "If you're copy and pasting from a blog post, you're doing it wrong."
category: blogging
intro: "If you're copy and pasting from a blog post, you're doing it wrong."
---
We're building some great new stuff at Caring.com right now and it has presented an
opportunity to start some new page templates from scratch. Of course, we needed some
fancy buttons. I guess I could have read a blog post or two describing the complexities
of designing a gorgeous CSS3-based button with all the trimmings, but we're busy and
someone had already done that work for me (Thanks Brandon!).

<pre class="window shell">
$ sudo gem install fancy-buttons
$ cd my_compass_project
$ echo "require 'fancy-buttons'" > tmp_config.rb
$ cat config.rb >> tmp_config.rb
$ mv tmp_config.rb config.rb
$ compass install fancy-buttons
</pre>
