---
title: Compass v0.10 Released
browser_title: Announcing the Stable Release of Compass v0.10
description: "Compass v0.10 is released."
category: blogging
featured: true
intro: "Compass v0.10 is released, read on to find out what's new!"
---
The compass v0.10 release is now available! You can install it using ruby gems:

    gem install compass

This is a big release -- over 7 months in the making. This post summarizes the changes, but please refer to the [CHANGELOG][CHANGELOG] for detailed upgrade instructions.

## Documentation!

One of the biggest additions in this release is the great [new documentation for Compass][docs]. The wiki has served us well, but we will be removing most of the documentation from there over the coming weeks, leaving only those pages that are best maintained by the community members themselves. These new docs are partly generated from the compass source code and partly hand-crafted. This is made possible by the über-powerful static site compiler, [nanoc][nanoc]. This provides consistency, accuracy, and a lower cost of maintenance. Because the documents are [checked into the compass source repository][doc-src], it also allows us to make documentation part of the commit process, ensuring that new features will be documented as soon as they are added. The documentation is still not as full-featured as we would like, so expect more updates there in the coming months as we get feedback about what's working and what's not.

## Sass 3 & SCSS

When you upgrade to or install compass v0.10, you'll be required to use Sass 3 which was also released today. From this point forward Compass fully supports both SCSS as well as the indentation-based Sass syntax. However, **SCSS is now the default syntax for Compass**. If you want to keep using sass, simply set `preferred_syntax = :sass` in your compass configuration, or pass `--syntax sass` to the relevant compass command line actions. Additionally, the Compass source is now written in SCSS. This means that if you've been explicitly importing a `.sass` file from the compass library, you'll get deprecation warnings that tell you how you should be importing that file now.

Don't worry, if you've already got a bunch of legacy stylesheets, upgrading to Sass 3 is a breeze thanks to the awesome `sass-convert` utility that comes with Sass now.

[More information on the changes in Sass 3][sass3].

## CSS3 Support

CSS3 is the new hotness, but it is a maintenance nightmare. With different syntax variants and vendor prefixes, just getting a round corner to show up correctly in the supported browsers can be a challenge. Luckily, Sass and Compass make using CSS3 today almost as easy as it will be when all the browsers finally support it. Go browse the [CSS3 reference documentation][css3docs] for more information.

## Extension Improvements

Many people find great value in the compass core library and blueprint framework. But there are now almost [30 compass extensions](http://rubygems.org/search?query=compass) and it's long been a vision of the compass project to enable a design ecosystem. While the vision isn't yet fully realized in this release, a number of improvements were made in this vein.

# Stable Extension API

Compass now provides a stable API for extension developers to use. This API is frozen for the duration of the 1.0 release -- no backwards incompatible changes will be made. If you are an extension creator or would like to become one, please [read more][creating-extensions]. Extension developers can discuss changes and get support on the [compass-devs mailing list][compass-devs].

## Simple Extensions

Additionally, creating and distributing an extension is now much easier than it used to be. There's no requirement to use rubygems or even touch ruby anymore. By following conventions, you can build an extension and distribute it as a download in minutes. Users need only unpack the extension in their project's extensions directory. It will be automatically detected and available for installing files and importing stylesheets.

## Font Support

Coupled with the new CSS3 [`@font-face`][font-face] support, compass now provides configuration options for your font directory. By default, for standalone projects, it is the "fonts" subdirectory of your css directory. Rails projects will default to "public/fonts". Additionally, compass provides the [`font-url()`][font-url] helper for referencing the font files and the ability to [inline fonts][inline-fonts] within your stylesheet.

## Extract Image Dimensions

It is now possible to [extract the dimensions of images][image-dimensions] for use within your stylesheets. Additionally, you can use the new `replace-text-with-dimensions` mixin
to replace text and infer the dimensions.

## Command Line Improvements

We know the CLI is not generally liked among designers, and we've not yet had enough time to build a GUI, so we put some lipstick on the pig. The command line output is now colorized, provides more helpful descriptions and help on the frameworks themselves. And now provides a more friendly sub-command based approach that allows the options to be customized for each command instead of sharing a single set of switches and options and also makes it possible for extensions to provide their own command line tools. Try some of the following to learn more:

    compass help
    compass help install
    compass help compass

## Project Statistics

Get stats on your compass project with `compass stats`. You'll need to install the `css_parser` ruby gem to get stats on your css files. This will allow you to see at a glance how much savings Sass is providing you over CSS and might also direct you in finding places in your project where bloat has occurred unexpectedly.

## YUI Becomes an Extension

YUI was upgraded to 2.7.0 and extracted to a plugin. Please follow the [installation instructions][yui] if you use YUI.

## Deprecations and Important Notes

### Rails Initializer Changes
Rails users must upgrade their initializer to:

    require 'compass'
    rails_root = (defined?(Rails) ? Rails.root : RAILS_ROOT).to_s
    Compass.add_project_configuration(File.join(rails_root, "config", "compass.rb"))
    Compass.configure_sass_plugin!
    Compass.handle_configuration_change!

### Ellipsis Mixin

If you use the `ellipsis` mixin and want full mozilla support, you must set `$use-mozilla-ellipsis-binding : true` and install the additional files with `compass install compass/ellipsis`. If you don't then ellipsis will only work in Firefox 3.6 or greater.

### Miscellany

* The unobtrusive-logo mixin is deprecated and will be removed. If you use this, please move the source to your project.
* Global reset no longer automatically resets the `*:focus`. This allows browsers to use their default `:focus` styles which is considered a best practice. If you wish to continue resetting `:focus` styles simply include this in your stylesheets: `*:focus { @include reset-focus; }`
* Please be aware that many imports have moved in this release. If you have an obsolete import, it will still work, but will generate a deprecation warning.

For a full list of changes, please read the [CHANGELOG][CHANGELOG].

[docs]: http://compass-style.org/docs/
[doc-src]: http://github.com/chriseppstein/compass/tree/docs/doc-src/
[nanoc]: http://nanoc.stoneship.org/
[CHANGELOG]: http://compass-style.org/docs/CHANGELOG/
[creating-extensions]: http://compass-style.org/docs/tutorials/extensions/
[compass-devs]: http://groups.google.com/group/compass-devs
[css3docs]: http://compass-style.org/docs/reference/compass/css3/
[yui]: http://github.com/chriseppstein/yui-compass-plugin
[font-url]: http://compass-style.org/docs/reference/compass/helpers/urls/#font-url
[font-face]: http://compass-style.org/docs/reference/compass/css3/font_face/
[inline-fonts]: http://compass-style.org/docs/reference/compass/helpers/inline-data/#inline-font-files
[image-dimensions]: http://compass-style.org/docs/reference/compass/helpers/image-dimensions/
[sass3]: http://sass-lang.com/docs/yardoc/file.SASS_CHANGELOG.html