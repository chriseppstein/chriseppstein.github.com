---
title: "Compass Extensions are Easy"
browser_title: "Compass Extensions are Easy | How to make a simple compass extension"
description: "How to make a simple compass extension."
category: blogging
intro: "How to make and distribute a simple compass extension in 5 simple steps."
featured: true
---
If you've ever taken the time to read the [documentation on compass extensions][extensions]
you've probably been a little overwhelmed by it. Compass extensions are powerful -- an
extension can provide:

1. Stylesheet libraries
2. Project templates & patterns that can install
   front-end assets into the user's project.
3. Integration with an application framework (Ruby based or otherwise).
4. Custom ruby-based sass functions.
5. New command line subcommands.
6. New configuration options.

All I want to do is share some stylesheets!
-------------------------------------------

But you don't have to do any of that fancy stuff. This should be easy -- and it is!
Just follow these 5 simple steps:

1. Make a directory with the name of your extension, create a subdirectory named `stylesheets`
   and put your stylesheets in there:
       mkdir -p my_awesome_extension/stylesheets
       cp -r my_project/sass/utilities/* my_awesome_extension/stylesheets
   
2. Create an archive of your extension:
       tar -zcvf my_awesome_extension-0.1.0.tar.gz my_awesome_extension

3. Post your extension online somewhere.

4. Download/Copy the extension and unpack it into your project's extensions directory:
       mkdir extensions # rails projects should use vendor/plugins/compass_extensions
       cd extensions
       # download or copy the extension to this folder
       tar -zxvf my_awesome_extension-0.1.0.tar.gz
       rm my_awesome_extension-0.1.0.tar.gz

5. You can now import your extension's stylesheets:
       @import "my_utility"

That's it. Sorry if I made it sound hard! You don't even have to make an archive file.
You could simply create a git repo and clone it when you need it -- any way that gets
the extension files into the project's extensions directory.

[extensions]: http://compass-style.org/docs/tutorials/extensions/
