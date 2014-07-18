---
title: What is Compass
description: "\"I'm trying to understand where Sass ends and Compass begins.\" Let me explain..."
category: blogging
---
An astute person asked me yesterday:

> It seems the only thing compass is is a repackaging of existing CSS frameworks like Blueprint into SASS mixins.
> Is that accurate?  Just trying to understand where Sass ends and Compass begins...

The short answer is: Yes. That, and some original Sass mixins. Oh and all the parts needed to make that possible.

Sass is the Star
----------------

Make no mistake, Sass is Awesome. I'm a fanboy. [Natalie Weizenbaum](http://nex-3.com) has been an awesome maintainer of Sass and doesn't get enough recognition for her work. I started using Sass just after it hit 2.0. Compass has pushed the limits of Sass and many of the language features of 2.2 were driven by Compass -- the two have co-evolved into a powerful platform.

Compass is a Stylesheet Distribution Framework
----------------------------------------------

Compass was initially a port of blueprint to Sass. But as I built it, it became apparent to me that the toolset I was building to distribute the blueprint source was orthogonal to the stylesheets. So Compass was born as a Meta-Framework (A framework for building and distributing css frameworks). With the ultimate goal of enabling anyone who wanted to share Sass stylesheets with others to do so without having to build any infrastructure.

Compass is Project Aware
------------------------

Sass has it's own compiler, but it operates on a single Sass file and generates a single CSS file. Compass understands that you have a complete website and provides a compiler for a whole directory tree of Sass files.

But distributing a design, is more than just distributing some stylesheets. There's likely some images. But how can you build distributable, upgradable stylesheets if those stylesheets need to refer to an image? Well, you could provide a mixin that takes an argument, or you could allow a variable to be set that says where it is. Or, you can use the `image_url` function provided by Compass that knows how to write a url, relative to your images path when serving over a webserver or **relative to the generated stylesheet** itself.

Compass enables Open Source Design
----------------------------------

With a compass extension you can build a completed design, widget, toolset, etc. and distribute it to projects of different types (rails, php, java, etc) and when a bug is discovered, fix it and enable your users to upgrade without hassle or worry.

Compass Has Core Mixins
-----------------------

A mixin qualifies for "Core" status when it is generally useful to most projects and other frameworks. The core framework eliminates duplication and inconsistency between compass extensions.

The Next Version
----------------

The next major release of compass will provide tools to make building, distributing, discovering, and installing compass extensions a breeze. I've been working on it for a couple months now and it is really shaping up nicely. The command line tool will integrate with a plugin registry on the compass website to make it easy to find and install compass extensions.

Can you help?
-------------

Compass is a big project and there's plenty of room for designers and coders alike to help out with Compass development and extension creation. If you're sitting on some design that you're proud of, it's time to share it. If you want to contribute in any way (even testing new versions) join the [compass-devs](http://groups.google.com/group/compass-devs) mailing list.




