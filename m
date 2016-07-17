From: wagle@mac.com (Perry Wagle)
Date: Sat, 16 Jul 2016 19:12:20 -0700
Subject: [Cocci] Coccinelle vs Firefox
Message-ID: <009C7972-C7EB-4B7F-ABC5-A1C0C1CA5797@mac.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi ?

I need to comprehend the huge Firefox source, excise the bookmark subsystem, turn it into an extension, hack on the extension to bring back the functionality I need, and drop in the new extension.  Then, I just need to replace the whole thing with something far more advanced than the toy they want to turn it into.

My workflow depends on bookmark tags working thus and so, and I anticipate that this yak shaving expedition will take me a year (since I want to develop tools to do it for me, instead of brute forcing it, which my ag?d brain doesn?t handle any more for programs of this size).  One of those tools involves my bookmark tags thing, so its a bootstrapping thing too (fun!).

So my question is whether you guys think Coccinelle would be useful to me in comprehending and doing MASS transformations of the firefox source?  I get the impression from lightly skimming that you concentrate on what I would describe as point fixes, which doesn?t seem the same.  But this couldn?t be it all, else you wouldn?t be interested?

The main problem is that firefox is written in a variety of programming languages.  How hard would it be to retarget Coccinelle to those languages?  And how useful for finding excision point for removing the existing bookmarks subsystem might it be?

At this point, I?m just trying to determine what order to do things in, and where learning Coccinelle fits in, if at all.

Is this enough information for you all to give me an idea, from 20,000 feet, of whether Coccinelle makes sense for me or not?  If not, I?ll return in a week with more details.

Thanks!

? Perry
