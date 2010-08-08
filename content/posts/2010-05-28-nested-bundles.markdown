---
title: "Working with Nested Application Bundles"
browser_title: "Working with Nested Application Bundles"
description: "Ruby's Gem Bundler doesn't like it when you try to nest bundles. Here's a work-around."
category: blogging
intro: "Ruby's Gem Bundler doesn't like it when you try to nest bundles. Here's a work-around."
---
Once you use [bundler][bundler] to establish a bundled environment, all the ruby code you run, even in a sub-shell will know about the application bundle. This is a feature, and a great one at that -- but sometimes it gets in the way. For instance, we use [Integrity CI][integrity] at [caring.com][caring] which is itself a bundled application. When we shell out to start our application, the Integrity bundle was infecting our own application's bundle. We worked around this by adding a few lines to our shell environment:

    export PATH=${PATH#/path/to/app/vendor/bundle/bin:}
    unset BUNDLE_GEMFILE
    unset RUBYOPT

Here's what it does:

* The first line removes the bundle's executables from the PATH.
* The second line makes bundler forget what bundle it was using.
* The third line keeps ruby from trying to establish a bundled
  environment when it starts up.

Perhaps bundler could provide a way to forget these settings, but until then, it's not too hard to manage it yourself in the rare exception where you need to nest bundled applications.

[integrity]: http://integrityapp.com/
[caring]: http://www.caring.com/
[bundler]: http://gembundler.com/