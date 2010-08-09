---
title: Building a Jekyll Watcher with FSSM
description: "Stop compiling and start watching your jekyll project with FSSM."
category: blogging
---
Travis Tilley's [File System State Monitor][fssm] provides a fantastic API for monitoring a filesystem and
performing actions when changes occur. It has multiple, platform-specific backends for dealing efficiently
with filesystems and will resort to polling if it has to. I have already integrated it into [Compass][compass]
to implement the `--watch` functionality.

When building this blog, I used it to trivially build a watcher for changes to the blog contents and
regenerate the site using [jekyll][jekyll] if anything changed. Coupled with [serve][serve], I can
basically forget that I'm developing a static website that has to be compiled. I've documented the basic
steps required to build your own watcher here.

### Install FSSM

<pre class="console window"><span class="prompt">~</span> <span class="stdin">sudo gem install ttilley-fssm</span>
<span class="stdout">Password:
Successfully installed ttilley-fssm-0.0.6
1 gem installed
Installing ri documentation for ttilley-fssm-0.0.6...
Installing RDoc documentation for ttilley-fssm-0.0.6...</span>
</pre>

### Define An Update Function

This update function uses pipes because I wanted to see the output as it was emitted.

<div class="editor window">
<pre><code class="ruby">def rebuild_site(relative)
  puts ">>> Change Detected to: #{relative} <<<"
  IO.popen('rake generate') do |io|
    print(io.readpartial(512)) until io.eof?
  end
  puts '>>> Update Complete <<<'
end</code></pre>
</div>

### Create a Watch Task

<div class="editor window">
<pre><code class="ruby">desc "Watch the site and regenerate when it changes"
task :watch do
  require 'fssm'
  puts ">>> Watching for Changes <<<"
  FSSM.monitor("#{File.dirname(__FILE__)}/_source", '**/*') do
    update {|base, relative| rebuild_site(relative)}
    delete {|base, relative| rebuild_site(relative)}
    create {|base, relative| rebuild_site(relative)}
  end
end</code></pre>
</div>


### Invoke It

<pre class="console window"><span class="prompt">~/Projects/chriseppstein.github.com</span> <span class="stdin">rake watch</span>
<span class="stdout">(in /Users/chris/Projects/chriseppstein.github.com)
>>> Watching for Changes &lt;&lt;&lt;</span>
</pre>

[fssm]: http://github.com/ttilley/fssm/tree/master
[jekyll]: http://github.com/mojombo/jekyll/tree/master
[serve]: http://github.com/jlong/serve/tree/master
[compass]: http://github.com/chriseppstein/compass/tree/master




