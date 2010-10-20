---
title: "What's New in Sass 3.1: Filesystem Independence"
browser_title: "What's New in Sass 3.1: Filesystem Independence"
description: "Sass no longer requires write or read access to the filesystem."
category: blogging
intro: "Sass no longer requires write or read access to the filesystem."
featured: true
draft: true
---
In Sass 3.1, we've done a [major refactoring of the Sass internals][diff] to allow for new uses of Sass
that free it of the need to read and/or write to the filesystem. Normal users of Sass and Compass
will not notice this change, but it was critical for upcoming integration with Ruby-on-Rails and
to enable the new Lemonade support that is coming in Compass v0.11. Also, it will enable
non-standard deployments like [Harmony][harmony] to properly support imports between files and to
efficiently cache parsed sass files. In this post, I will highlight some of the changes that we
made and provide links to the appropriate documentation if you would like to take advantage of
this new capability.

Sass Cache Store
----------------

Sass has a cache store where it tucks away an intermediate form of parsed sass files so that if
they are imported again before they change, we can skip parsing the file again. Additionally,
Sass extensions like Compass and Lemonade often need a reliable way to store transient data
across compiles. By default, this cache is kept in a hidden directory called `.sass-cache`, or
if you're in a Ruby-on-Rails app, `tmp/sass-cache`.

New in Sass 3.1, any object that implements [CacheStore interface][cache_store] can be passed to
the Sass Plugin or to the Sass Engine using the `:cache_store` option. For instance, this allows
you to bypass the filesystem and write cache contents to memcached so that compilation results
can be efficiently shared across a cluster of machines.

Out of the box, Sass provides two cache store implementations. The default is the
filesystem-based store that we have always provided. The second is an in-memory store that is
better suited for long-running processes or in cases where keeping the cache across process
invocations is not necessary. Using the in-memory store for Sass's test suite cut the running
time by almost half. To use the in-memory store:

    Sass::Plugin.options[:cache_store] = Sass::InMemoryCacheStore.new

Sass Importers
--------------

The `@import` directive in Sass will go find another sass file and treat it as if it was being
processed inline. In Sass 3.1, it is now possible to teach Sass how to find files that are
being imported and to get the contents of those files even if they don't live on the local
filesystem. Importers must inherit from [`Sass::Importers::Base`][base_importer] and instances
of an importer can be placed onto the Sass load path like so:

    class MyImporter < Sass::Importers::Base
      def initialize(...)
        ...
      end
      def find_relative(uri, base, options)
        ...
      end
      def find(uri, options)
        ...
      end
      def mtime(uri, options)
        ...
      end
      def key(uri, options)
        ...
      end
      def to_s
        ...
      end
    end
    Sass::Plugin.options[:load_paths] << MyImporter.new(...)

This is a powerful capability. It could be used to import sass files from remote locations
on the internet, from the database, or it could even be used to import on-the-fly generated
stylesheets. For now, Sass is not providing any of these capabilities. But we'll see how
things develop in the community and will consider expanding our out of the box import system
over time.

[diff]: http://github.com/nex3/sass/compare/f175d8c208b1e5e763c0d54a6fc1c1cb0d144deb%5E...6b0b69482640a906feb9effddcefa5723eece98d#files_bucket
[harmony]: http://get.harmonyapp.com/
[cache_store]: http://github.com/nex3/sass/blob/master/lib/sass/cache_store.rb
[base_importer]: http://github.com/nex3/sass/blob/master/lib/sass/importers/base.rb