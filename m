From: joe@perches.com (Joe Perches)
Date: Fri, 05 Dec 2014 07:26:49 -0800
Subject: [Cocci] printf vs. printk (was Re: Side-effect free printk?)
In-Reply-To: <1417793094.2721.51.camel@perches.com>
References: <1417629003.2902.14.camel@perches.com>
 <20141205103248.GA6945@amd> <1417793094.2721.51.camel@perches.com>
Message-ID: <1417793209.2721.53.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2014-12-05 at 07:24 -0800, Joe Perches wrote:
> My preference would be to eventually eliminate printk
> altogether but I don't see a real problem adding 
> 	#define printf printk
> to include/linux/printk.h
> 
> but

(bah, bad touchpad)

but I'm not going to write or ack that patch.
