---
title: "Where are your Images?"
browser_title: "Where are your Images?"
description: "Compass helps you find your images when they move."
category: blogging
featured: true
intro: "If you think you know where your images are -- think again."
---
Websites start simple. They might even start as an html mockup served off your local
filesystem without a web server. But they don't stay simple. Since you don't have a
webserver, you use relative urls to point to images in the directory next to your
stylesheets. But soon a backend gets involved, and web servers and deployment scripts.
Eventually you work through this by setting up a simple webserver on your development
machine so that you can use absolute paths. That is until your client informs you that
the application will now be deployed into a non-root url path and you have to go hunting
urls on a search and replace safari.

Some time passes and you hear that you can give your users a
[faster page load experience](http://www.die.net/musings/page_load_time/)
if you add some DNS names and serve your static assets across several
"asset hosts". So now you're stuck between a rock and a hard place. How will you
develop stylesheets where assets are hosted from four different "servers"?
But a developer shows you that you can now edit your `/etc/hosts` file and map
all the production urls to your development machine. But now you can't see
what the production website is really up to -- without editing that file again.

Some more time passes and you're a `/etc/hosts` editing pro now when the devs tell
you that they're going to be moving to a CDN to give distributed image hosting and
an even faster page load to the end-users. That's great... for the users. But now
you have a different url for images in staging and production and you're not sure
how you're going to manage that at all. So a developer whips up a script that can find
the urls and convert them to the right host. Whew, disaster averted. Of course, now
you have to process these stylesheets all the time. But you manage.

You're moving on to your next website now and you've decided that there's some re-usable
bits from your last site that you can use again -- but those bits use some images and
so you convert the dns names from the last site to relative urls and start the cycle over
again. Then it dawns on you...

## You have no clue where your images will be hosted

Where you host images is a deployment concern, not a development concern.
Ruby-on-Rails understands this -- which is why they [provide a helper function][rails]
called `image_tag` that keeps the html templates free of any assumptions about where
the images are at. Those clever developers -- no wonder they're always moving things
around without a care in the world.

Of course, compass has had a solution for this problem for a while now.

## `image-url` -- Refer to an image no matter where it is!

Compass provides a [suite of helper functions][url-helpers] to help you find your
assets no matter where the developers decide to put them. They are trivially easy to use:

    #nav {
      background: #DDD image-url("nav_bg.png") repeat-x scroll top center;
    }

But I often find experienced compass and sass users who do not take advantage
of this simple tool.

Once you use these helpers religiously, then **you** can decide where **you** want
to server **your** assets. Want to access them without a webserver? Set this in your
compass configuration:

    relative_assets = true

Since Compass & Sass know where images are and what stylesheets are being generated
at the time of the call, this feature works relative to the generated css file, not
the sass files -- so don't worry about referring to images in mixins or stylesheets
that get imported and combined with others. It just works.

If you need to set the path where your site is hosted, Compass will adjust accordingly:

    http_path = "/my-client/"

You can set the images directory relative to your http_path:

    http_images_dir = "assets/images"

Or you can change just the location of the images themselves:

    http_images_path = "http://assets.my-client.com/images/"

Want to distribute the host to one of four hosts in your domain? Set this in your config:

    asset_host do |path|
      "http://%d.my-domain.com" % (path.hash % 4)
    end

Additionally, compass will automatically add cache busters to your images based on image
timestamps. This will keep browser caches from displaying the wrong image if you change
the image but not the url. If you don't want this behavior, it is easy to configure
or disable:

    asset_cache_buster do |http_path, real_path|
      nil
    end

## Extension Developers, Rejoice

If a single site cannot be expected to know where their images are -- then how can
extensions? jQuery UI extensions work around this by dumping images relative to the
stylesheets they give you. This works, but forces you to put images in a non-standard
location that is not taking advantage of the user's infrastructure.

Compass extensions can install images into the user's location of choice and refer
to them safely from within library code.

## A Stylesheet Authoring Framework

[Compass][compass] is a stylesheet authoring framework -- not a CSS framework,
because compass provides tools to manage the development of stylesheets from
prototype to production. If you're a compass user, there's no excuse to not be
using these simple helpers.

And if you're not a compass user -- why not? 

[rails]: http://api.rubyonrails.org/classes/ActionView/Helpers/AssetTagHelper.html
[url-helpers]: http://compass-style.org/docs/reference/compass/helpers/urls/
[compass]: http://compass-style.org/