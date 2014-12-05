From: joe@perches.com (Joe Perches)
Date: Fri, 05 Dec 2014 07:24:54 -0800
Subject: [Cocci] printf vs. printk (was Re: Side-effect free printk?)
In-Reply-To: <20141205103248.GA6945@amd>
References: <1417629003.2902.14.camel@perches.com> <20141205103248.GA6945@amd>
Message-ID: <1417793094.2721.51.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2014-12-05 at 11:32 +0100, Pavel Machek wrote:
> Hi!
> 
> BTW... All the time I'm programming in kernel, I use printf(), and
> when hacking userspace, I use printk().
> 
> Nasty.
> 
> Given that printf() and printk() have exactly the same behaviour,
> could we allow printf() in kernel? Now... printk()s are usually
> removed before merging the driver, so code will not see much change,
> but it will certainly result in less 4-letter words while developing.

My preference would be to eventually eliminate printk
altogether but I don't see a real problem adding 
	#define printf printk
to include/linux/printk.h

but
