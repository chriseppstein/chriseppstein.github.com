---
title: "My Daughter's First Pair Programming Session"
browser_title: "My Daughter's First Pair Programming Session"
description: "Our conversation and the results."
category: blogging
intro: "A troll dad tries to teach his daughter a lesson about graceful losing."
featured: true
---

My daughter was very disappointed that she lost a game of Chutes & Ladders. She hit the biggest slide, then the biggest ladder then tied my wife in race to roll a 1 -- it was a very exciting game. After some tears we had the following conversation:

<dl>
<dt >Daddy</dt>
<dd>I can see you're very disappointed. What do you think we should do about it?</dd>
<dt>Piper</dt>
<dd>I want it so that was the the winner of the game.</dd>
<dt>Daddy</dt>
<dd>Ok.</dd>
<dt>Piper</dt>
<dd>Wha?</dd>
<dt>Daddy</dt>
<dd>You're the winner.</dd>
<dt>Piper</dt>
<dd><em>Pauses. Then starts to cry.</em> I still feel frustrated!</dd>
<dt>Daddy</dt>
<dd>That's because you didn't really win.</dd>
<dt>Piper</dt>
<dd>We should play it again but I'll win this time.</dd>
<dt>Daddy</dt>
<dd>Ok.</dd>
<dt>Piper</dt>
<dd>Wha?</dd>
<dt>Daddy</dt>
<dd>But I'm unclear on how to do it. Maybe you can help me figure it out.</dd>
<dt>Piper</dt>
<dd>When we play, I'll win.</dd>
<dt>Daddy</dt>
<dd>Right. So you'll spin the numbers and those numbers will make you win.</dd>
<dt>Piper</dt>
<dd>Yes.</dd>
<dt>Daddy</dt>
<dd>How do we make the spinner know you're the one spinning it?</dd>
<dt>Piper</dt>
<dd><em>Pauses</em> We'll make a machine that knows.</dd>
<dt>Daddy</dt>
<dd>Cool idea! Where do we get that machine?</dd>
<dt>Piper</dt>
<dd>We have to make it.</dd>
<dt>Daddy</dt>
<dd>Ok. How do we make it?</dd>
<dt>Piper</dt>
<dd>We get blueprints like on Phineas and Ferb and follow the instructions.</dd>
<dt>Daddy</dt>
<dd>You know. My job is to make blueprints for a kind of machine that runs in a computer called a program.</dd>
<dt>Piper</dt>
<dd>Really?</dd>
<dt>Daddy</dt>
<dd>Yep. Do you want to help me make a machine that plays a game where you always win?</dd>
<dt>Piper</dt>
<dd><em>Big Grin</em> Sure!</dd>
<dt>Daddy</dt>
<dd><em>Begins Coding</em> Ok. So how will it know if you're playing?</dd>
<dt>Piper</dt>
<dd>It'll ask our own names.</dd>
<dt>Daddy</dt>
<dd>Ok. So you'll type it in?</dd>
<dt>Piper</dt>
<dd>Yes.</dd>
<dt>Daddy</dt>
<dd>And what if I was to type your name in? <em>(I'm hoping she'll invent passwords)</em></dd>
<dt>Piper</dt>
<dd><em>Pauses</em> That's not nice to do.</dd>
<dt>Daddy</dt>
<dd>No it's not. So we type our names in and if you're playing, you win?</dd>
<dt>Piper</dt>
<dd>Yep.</dd>
<dt>Daddy</dt>
<dd><em>types for a few minutes</em> Ok. Let's play!</dd>
</dl>

We played the game about 10 times. Each time we played, she won. Now I have to admit that my goal was that she would discover that a rigged game wasn't fun to win and that winning is fun **because** there is losing. But each time she won, she beamed with happiness. A bit disappointed I talked her thru how the program worked. Then content at her perfect success at our game she said "I'm ready for books now."

Here's the program we wrote:

    print "How many players? "
    $stdout.flush
    number_of_players = gets.strip.to_i
    
    player_names = []
    number_of_players.times do
      print "What is the name of player ##{player_names.size + 1}? "
      player_names << gets.strip
    end
    
    if piper = player_names.grep(/piper/i).first
      puts "#{piper} wins!!!"
    else
      puts "#{player_names[(number_of_players * rand).to_i]} wins!!!"
    end

And some of the console log:

    [master][~/Projects/piper] ruby only_piper_wins.rb 
    How many players? 2
    What is the name of player #1? daddy
    What is the name of player #2? piper
    piper wins!!!
    [master][~/Projects/piper] ruby only_piper_wins.rb
    How many players? 3
    What is the name of player #1? mommy
    What is the name of player #2? daddy
    What is the name of player #3? piper
    piper wins!!!
    [master][~/Projects/piper] ruby only_piper_wins.rb
    How many players? 3
    What is the name of player #1? mommy  
    What is the name of player #2? chris
    What is the name of player #3? piper
    piper wins!!!
    [master][~/Projects/piper] ruby only_piper_wins.rb
    How many players? 2
    What is the name of player #1? daddy
    What is the name of player #2? mommy
    daddy wins!!!
    [master][~/Projects/piper] ruby only_piper_wins.rb
    How many players? 3
    What is the name of player #1? mommy
    What is the name of player #2? piper
    What is the name of player #3? daddy
    piper wins!!!
    [master][~/Projects/piper] ruby only_piper_wins.rb
    How many players? 2
    What is the name of player #1? mmmommmy
    What is the name of player #2? piper
    piper wins!!!
    # I mention I'm sad that I never win so she changes her name to mommy
    [master][~/Projects/piper] ruby only_piper_wins.rb
    How many players? 2
    What is the name of player #1? mommy
    What is the name of player #2? daddy
    mommy wins!!!
    [master][~/Projects/piper] ruby only_piper_wins.rb
    How many players? 2
    What is the name of player #1? daddy
    What is the name of player #2? mommy
    mommy wins!!!
