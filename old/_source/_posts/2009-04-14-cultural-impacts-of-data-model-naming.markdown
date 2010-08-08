---
title: "Setting a Tone with Model Naming"
description: Names affect how we think and communicate. Can they impact a company's culture?
category: blogging
---
Early in the days of [Caring.com][1] we planned to build a personal homepage for our users that would delight them with a customized selection of content that was appropriate for the issues they were dealing with. Many of our early architectural decisions centered around this premise. Unfortunately, the breadth and depth of our content was not sufficient to support that feature and it was shelved rather than disappoint our users. Almost two years later, we have an [amazing selection of content for the most common care giving issues][2], a [small army of experts waiting to answer care giving questions][3] from our users, a small but [active community of caregivers][4] that are helping each other get through some of the most difficult times of their lives, and a [comprehensive guide to care giving resources in your area][5]. We are finally ready to personalize our site and deliver what we hope will be delightful experience for those people who choose to fill out a short questionnaire (not yet launched at the time of this writing).

So I got to take some old code off the shelf and dust it off. It was exciting, and a little frightening. In those early days, I knew I needed a model to represent the person or people that our user is caring for. With my overly analytical, highly trained engineer brain and no formal education in geriatrics or care giving, I called this model the `CareTarget`. That name stuck, and from time to time, I'd hear myself and others refer to the care target when we needed a term to use in conversation. And while this name clearly and unambiguously describes the purpose of the model, **it was the wrong term**. These are people, not targets. They are your loved ones and they are my parents. I felt the term `CareTarget` was dehumanizing. These are the people who receive our care, because we love them and because they deserve it. They are a `CareRecipient`. Sitting alone in my office, with deadlines to hit, I decided that I could not allow this term to persist. In two weeks the number of uses of these names, would double or more -- there was no better time to rename them than right then, and so it was done right then. Similarly, a model called `CareTargetType` was changed to `CareRelationship` (E.g. Mother, Father).

When I came to scrum (our daily standup meeting) the next day and announced I had made no progress on my tasks, not everyone understood why the change was so imperative. But these names are at the very heart of what Caring.com is and does, nothing that central can be allowed to be wrong. Not even their names. In total, I spent a day and a half renaming what were arguably fine names -- they needn't have ever been exposed to our users, but now I never have to worry that they might. And in a few months, when I hear folks in the halls of Caring.com talking about the care relationship one of our users has to their care recipient, I'm going to smile because I understand that the names in our code have a real and lasting effect on the tone and understanding of our domain. Software Architecture and Design is most certainly a technical field, but that doesn't mean it has to be dry and impersonal.


[1]: http://www.caring.com/
[2]: http://www.caring.com/site-map
[3]: http://www.caring.com/experts
[4]: http://www.caring.com/community
[5]: http://www.caring.com/local

