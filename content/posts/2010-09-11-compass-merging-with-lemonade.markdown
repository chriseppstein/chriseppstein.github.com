---
title: "Compass & Lemonade"
browser_title: "Compass & Lemonade are Merging"
description: "Nico Hagenburger is joining the Compass team and Lemonade is becoming part of Compass."
category: blogging
intro: "Nico Hagenburger is joining the Compass team and Lemonade is becoming part of Compass."
featured: true
---
I announced on [twitter][tweet] this morning that [Nico Hagenburger][nico]
is joining the Compass team and we are merging his awesome spriting
solution, Lemonade, into Compass. As you know, Lemonade takes a lot of the
grunt work out of making sprites. If you don't know, please read up on it
[here][lemonade]

However, as easy as Lemonade is to use, it can be even easier, and this is
the point of the integration. I have been working with Natalie to enhance
Sass to make it possible for stylesheets to import from places other than
a file on the disk. This general facility will make it possible to store
stylesheets in the database, import files that do not follow our normal
naming convention, import across the network, etc. Compass will be using
this new facility to generate dynamic stylesheets for sprites according
to a convention. The plan for this is documented [here][plan], but it will
be this easy:

## Step 1: Drop files into a folder

    [images_dir]/
      sprites/
        toolbar/
          new.png
          save.png
          open.png
          undo.png

## Step 2: Import the stylesheet and apply mixins

    @import "sprites/toolbar";
    #toolbar {
      .new  { @include toolbar-sprite("new");  }
      .open { @include toolbar-sprite("open"); }
      .save { @include toolbar-sprite("save"); }
      .undo { @include toolbar-sprite("undo"); }
    }

And voila! You get this CSS:

    .toolbar-sprite,
    #toolbar .new,
    #toolbar .open,
    #toolbar .save,
    #toolbar .undo {
      background-image: url(/images/toolbar.png);
      background-repeat: no-repeat;
    }
    
    #toolbar .new { background-position: 0 0; }
    #toolbar .open { background-position: 50px 0; }
    #toolbar .save { background-position: 25px 0; }
    #toolbar .undo { background-position: 75px 0; }

Of course, this is just the basic usage. Much more can be done! Look for this
feature in Compass v0.11.

Your feedback is both welcomed and encouraged in the comments below.

[tweet]: https://twitter.com/chriseppstein/status/24215478512
[nico]: http://www.hagenburger.net/
[lemonade]: http://www.hagenburger.net/BLOG/Lemonade-CSS-Sprites-for-Sass-Compass.html
[plan]: https://gist.github.com/ff0a3b80901bb0557f6e
