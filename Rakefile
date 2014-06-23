
require "rubygems"
require "bundler/setup"

require 'nanoc3/tasks'
# require 'active_support'
# require 'active_support/core_ext'
# require 'active_support/core_ext/object/blank'

def ok_failed(condition)
  if (condition)
    puts "OK"
  else
    puts "FAILED"
  end
end

port = "4000"
site = "output"

desc "remove files in output directory"
task :clean do
  puts "Removing output..."
  Dir["#{site}/*"].each { |f| rm_rf(f) }
end

desc "generate website in output directory"
task :generate => :clean do
  puts "Generating website..."
  system "bin/nanoc co"
  # system "mv _site/blog/atom.html _site/blog/atom.xml"
end

desc "build and commit the website in the master branch"
task :build => :generate_all do
  require 'git'
  repo = Git.open('.')
  repo.branch("master").checkout
  (Dir["*"] - [site]).each { |f| rm_rf(f) }
  Dir["#{site}/*"].each {|f| mv(f, ".")}
  rm_rf(site)
  Dir["**/*"].each {|f| repo.add(f) }
  repo.status.deleted.each {|f, s| repo.remove(f)}
  message = ENV["MESSAGE"] || "Site updated at #{Time.now.utc}"
  repo.commit(message)
  repo.branch("source").checkout
end

desc "generate and deploy website"
task :deploy => :build do
  system "git push origin master"
end

namespace :serve do
  desc "start up an instance of serve on the output files"
  task :start => :stop do
    cd "#{site}" do
      print "Starting serve..."
      ok_failed system("serve #{port} > /dev/null 2>&1 &")
    end
  end

  desc "stop all instances of serve"
  task :stop do
    pid = `ps auxw | awk '/bin\\/serve\\ #{port}/ { print $2 }'`.strip
    if pid.empty?
      puts "Serve is not running"
    else
      print "Stoping serve..."
      ok_failed system("kill -9 #{pid}")
    end
  end
end

desc "preview the site in a web browser"
multitask :preview => [:generate, :start_serve] do
  system "open http://localhost:#{port}/"
end

def rebuild_site(relative)
  puts ">>> Change Detected to: #{relative} <<<"
  Rake::Task["generate"].execute
  puts '>>> Update Complete <<<'
end

desc "Watch the site and regenerate when it changes"
task :watch do
  require 'fssm'
  puts ">>> Watching for Changes <<<"
  FSSM.monitor("#{File.dirname(__FILE__)}/content", '**/*') do
    update {|base, relative| rebuild_site(relative)}
    delete {|base, relative| rebuild_site(relative)}
    create {|base, relative| rebuild_site(relative)}
  end
end

def departialize(target)
  if (bn = File.basename(target))[0..0] == "_"
    target = file.join(file.dirname(target), bn[1..-1])
  end
  target
end

namespace :sass do
  desc "generate syntax highlight files for sass files in this project."
  task :pygmentize do
#     sass_files = filelist.new('content/stylesheets/**/*.sass')
#     sass_files.each do |file|
#       target = departialize(file.gsub("content/stylesheets", "content/highlighted/stylesheets")+".html")
#       fileutils.mkdir_p(file.dirname(target))
#       puts "writing #{target}"
#       open(target, "w") do |f|
#         f.puts %q{---
# layout: stylesheet
# body_id: stylesheet
# title: "#{file[7..-1]}"
# ---}
#       end
#       sh "pygmentize -o linenos=table -f html #{file} >> #{target}"
#     end
  end

  desc "Make import directives link to the corresponding syntax hightlighted sass file."
  task :link_imports => :pygmentize do
    require 'hpricot'
    require 'sass'
    hightlight_files = FileList.new('content/highlighted/stylesheets/**/*.sass.html')
    hightlight_files.each do |file|
      puts "Adding links to #{file}"
      doc = open(file) {|f| Hpricot(f.read) }
      doc.search("span.s") do |span|
        puts "Checking if #{span.inner_text} exists."
        local_dir = "content/stylesheets/#{File.dirname(file)[32..-1]}"
        puts "local_dir is #{local_dir}"
        begin
          full_path = Sass::Files.find_file_to_import(span.inner_text, ["content/stylesheets", local_dir])
          next if full_path =~ /\.css$/
          puts "Found #{span.inner_text} at #{full_path}"
          wrapped = span.make(%Q{<a class="import" href="/highlighted/#{departialize(full_path[8..-1])}.html">#{span}</a>})
          span.parent.replace_child(span, wrapped)
        rescue Sass::SyntaxError
          #pass
        end
      end
      open(file, 'w') do |file|
        file.write doc.to_s
      end
    end
  end

  task :highlight => :link_imports
end

desc "Build an XML sitemap of all html files."
task :sitemap => :generate do
  html_files = FileList.new("#{site}/**/*.html").map{|f| f[(site.size)..-1]}.map do |f|
    if f =~ /index.html$/
      f[0..(-("index.html".size + 1))]
    else
      f
    end
  end.sort_by{|f| f.size}
  open("#{site}/sitemap.xml", 'w') do |sitemap|
    sitemap.puts %Q{<?xml version="1.0" encoding="UTF-8"?>}
    sitemap.puts %Q{<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">}
    html_files.each do |f|
      priority = case f
      when %r{^/$}
        1.0
      when %r{^/blog}
        0.9
      when %r{^/highlighted/$}
        0.7
      else
        0.8
      end
      sitemap.puts %Q{  <url>}
      sitemap.puts %Q{    <loc>http://chriseppstein.github.com#{f}</loc>}
      sitemap.puts %Q{    <lastmod>2005-01-01</lastmod>}
      sitemap.puts %Q{    <changefreq>weekly</changefreq>}
      sitemap.puts %Q{    <priority>#{priority}</priority>}
      sitemap.puts %Q{  </url>}
    end
    sitemap.puts %Q{</urlset>}
    puts "Created #{site}/sitemap.xml"
  end
end

desc "Generate the whole site."
task :generate_all => [:generate, :sitemap]

task :build => :generate_all
