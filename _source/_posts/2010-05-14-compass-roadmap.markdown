---
title: "Compass 1.0 Roadmap"
browser_title: "Roadmap to Compass v1.0"
description: "How we're going to get to v1.0"
category: blogging
featured: true
intro: "How we're going to get to v1.0"
---
Now that the v0.10 release is out, we've done some thinking about how to
get to version 1.0. Compass takes a very conservative approach to version
numbering. Stable releases have relatively long betas. Likewise, when we
reach 1.0, it means that compass will have all the features we think it needs
to become a successful project and moreover, it will then have achieved the
initial vision of the project that I had for it almost two years ago (and then some).

In this post, I will outline the upcoming releases so that you understand where we're headed and can offer your feedback if you think there's a critical feature that's missing.

Versioning
----------

First an administrative note, I'm abandoning the even/odd release numbering scheme that many have found confusing. Going forward, we'll be using rubygem's preview releases. The master branch will use the following release numbering scheme:

* `0.11.0.alpha.N` (new features expected, likely buggy)
* `0.11.0.beta.N` (new features expected, less buggy)
* `0.11.0.rc.N` (no new features expected, find the bugs if you can!)

Scheduling
----------

I don't find my life to be predictable enough to assign dates to these
releases. But we will assign good names to them. I've tried to break them apart
into small, focused releases with relatively few moving parts to reduce the
complexity and upgrade concerns. I expect each release to take approximately
two months for development and one month for release candidate testing. We
might overlap some development with branches. There are 5 releases to get to
1.0. So I predict it'll be at least a year before we see 1.0. Of course, this
is open source, so if you see a feature on this list that excites you and feel
you are up to the task, I welcome you to step up and start working with me to
build it.

v0.11 - Antares
---------------
The focus of this release is on turning out
even better documentation and some stylesheet updates and
enhancements that take better advantage of the Sass 3 features.

### Docs

This work can be done on stable and/or a topic branch.

* Improve the design
* Better tutorials and getting started guides.
* Terminal for Designers
* Better examples & example navigation
* Contribution guide:
  * Compass stylesheets
  * Compass ruby code
  * Documentation patches
* SCSS Style Guide
* Bundler 1.0 support
* Upgrade nanoc
* Better search experience
* Search mixins and constants and code fragments that might use those.
* Awesome homepage that is better integrated with the docs.
* HTML5 the docs so they can run locally in offline mode.

### Compass Core

* Updates as necessary to the CSS3 module as the spec
  process develops.
* Typography module

### Blueprint

* Provide an option to use @extend in the blueprint grid

### Rails

* Fully integrated support of Rails 3

### Other

* clean up all mixin argument names in preparation for keyword argument
  support from sass.

v0.12 - Alnilam
---------------

The focus of this release is to make extensions really easy to work with and install from an end-user perspective. The compass website will provide an extension registry and a canonical place for downloading them.

### Extensions

* Extension registry on compass-style.org.
* One step publishing via github + webhooks
* Easy upload using zip files
* Easy install via CLI
* Local (per-user) extension repo with auto-discovery.
* Video showing how easy it is to create, publish, and install an extension.
* Documented API for discovering and downloading extensions from any website
* Support for adding other extension repos.

v0.13 - Markab
--------------

The focus of this release is great application integration support. Making it easier to install and run compass within many types of applications. Where applicable, I'd like to cooperate with existing open source projects and extensions to provide this support.

### Compass Core

* Updates as necessary to the CSS3 module as the spec
  process develops.

### Other

* Consider adding app integration with: Node.js, Django, Drupal, Wordpress
  (Wherever opinionated layouts exist). Also, try to make one of these a plugin
  to test out the concept.

### Internals

* Use the Sass::Plugin to compile stylesheets now that
  it has callback support.

v0.14 - Aldebaran
-----------------

This release depends on Sass 3.2 and is aimed at taking advantage of
the new sass 3.2 feature set as well as really making the extensions
system come alive. Since I don't foresee any deprecations in Sass 3.2,
this will not be a coordinated release. Instead, this release will
trail Sass 3.2 by a month or two.

### Compass Core

* Figure out what to do about multiple attribute properties like background.
  Might require list and function support from sass.

### Blueprint

* If sass 3.2 is out with @function support, use that for grid
  calculations, otherwise punt to 1.0.
* If the @extend version of the grid is full of win, make it the default.


v1.0 - Polaris
--------------

As with any major release, the final step is great documentation. Not just for compass but for all the extensions and even your own project.

### SassDoc

Extract the compass documentation system into a stand-alone project.

### Extensions

* Build basic docs and host them for all extensions using sassdoc.

### Project Tools

* Enable building project docs using the sassdoc tool.

v2.0 - Schedar
--------------

Version 2 is all about making compass easier to use. Compass and Sass
will have a GUI that makes it simple to manage your projects and a simple installer to make getting up and running a breeze.
