From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 5 Dec 2014 11:32:48 +0100
Subject: [Cocci] printf vs. printk (was Re: Side-effect free printk?)
In-Reply-To: <1417629003.2902.14.camel@perches.com>
References: <1417629003.2902.14.camel@perches.com>
Message-ID: <20141205103248.GA6945@amd>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!

BTW... All the time I'm programming in kernel, I use printf(), and
when hacking userspace, I use printk().

Nasty.

Given that printf() and printk() have exactly the same behaviour,
could we allow printf() in kernel? Now... printk()s are usually
removed before merging the driver, so code will not see much change,
but it will certainly result in less 4-letter words while developing.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
