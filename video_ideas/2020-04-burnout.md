What Frustrates Me Most About Software Engineering

When I was 12 years old, I wrote my first lines of software code in QBASIC. Mastering the skill of being able to build things inside of the computer, manifesting whatever I can dream to create, was so fun to me that from then on programming has become both a personal and professional enjoyment. But even for someone as driven as me when it comes to writing software, coding has its frustrations. The thing that often gets in the way of the rewarding aspects of programming is that nowadays, getting anything done requires so much depth of knowledge, and that knowledge gets outdated so rapidly, that doing even a simple task becomes a time consuming ordeal.

Take this simple website I'm working on for my local area. Initially, my goal is to start out with a few simple pages of information, and a signup form. Starting a simple project like this presents you with a few engineering decisions to make off the bat. What technologies should I use? Should I use a canned CMS system like Wordpress, or build from scratch using my tool of choice, Ruby on Rails? If I choose Rails, should I use the traditional means of rendering the web pages using the templating system provided by Rails? Or should I take the trendy path and just use Rails to send data to a Javascript powered front end like React?

Speaking of which, a fresh Ruby on Rails application has gotten more difficult to get up and running over the past few years, thanks to advancements in the world of Javascript. ES6 and front end frameworks like React, Vue and Angular are the trendy thing to do. They enable you to build a more capable front end for a richer end-user experience in the web browser, but they come at the cost of being more difficult to maintain because you now have to manage the knowledge and deployment skill for two complex software packages, each of which can easily become a full time job. Because I didn't feel like dealing with a second framework for an application with a few simple forms, I decided to just stick with plain Rails 6.0, using Slim templates and JQuery if needed.

Rails 6 is still fairly new, and I haven't built any projects with it yet. It seems like every time a new Rails come out, there are a few annoying compiler warnings when you use it with the latest Ruby that haven't yet been ironed out by the project. The biggest change in the last 2 editions of Rails is that the asset pipeline has been replaced with a tool called Webpacker. This complicates the way stylesheets and Javascript is integrated into your web application, but provides the advantage of allowing you to easily use more modern front end packages through Node or Yarn. It's not so bad once you learn the hang of it, and I'm working on a separate video for that topic.

So the first mistake I made in getting this website up and running was failing to run the webpacker compile step in my deploy script. This caused my styles to not be found on my initial production run. Next, I discovered what appeared to be a bug in the production-compiled version of the webpacked styling assets. A box where I set the opacity to 75% in development was not displaying at all in production because for some reason that opacity setting was getting overwritten by something else that I couldn't find. I had to get around the issue by just avoiding the use of opacity.

Once I finally got the styling issues figured out, then I found out that my webform wasn't working. This was a tricky one. I had to dig into the server logs, only to find a cryptic error message. After about 2 hours of research, I learned that this was caused by the Cross Site Forgery Token in my Rails app not getting along with the reverse proxy on my site. I had to add some forwarding settings inside my NGINX configuration to make it work. 

I finally got a simple web page working, and this is just the beginning, but it was exhausting to get here. There's still a lot more I'd like to add. I'm thinking about adding a tool like Refinery to make it easier for me to administer the pages on the site and upload static files like 3D printing plans that end users can download. I'm also not happy with the way Capistrano works with this deploy setup, because it's folder structure doesn't play well with Docker containers and I had to make a few workarounds for that, which are kind of hacky.

So to sum of what I'm saying, is that I still love writing software code, but I feel like the industry is evolving at such a fast pace that there are diminishing returns. Much of a software engineer's day can now be spent figuring out how to navigate bugs, deprecations, and new features being introduced. It takes a lot of effort to get all the different frameworks you're using to talk to each other, and sometimes you find quirks that get in the way of the code you're trying to write. So, how do I deal with this mentally so that I don't get burned out as a developer?


Ways to deal with this:
* Practice, practice, practice. When I do something like this, it's the journey that matters. I like using hobby or side projects as opportunities to explore new platforms, and very often gain some knowlege that I later apply in a more professional setting.
* Have realistic expectations of yourself. Realize this is part of the game. Need to balance the urgency of meeting your end goal vs using the technologies you may be interested in deploying. Maybe it would have been more effective if I used a Google form for this. 
* Cutting corners for the sake of getting things done maybe necessary.