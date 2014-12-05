From: joe@perches.com (Joe Perches)
Date: Thu, 04 Dec 2014 23:49:30 -0800
Subject: [Cocci] Finding embedded function names?
In-Reply-To: <alpine.DEB.2.02.1412050831060.2059@localhost6.localdomain6>
References: <1417741951.2721.30.camel@perches.com>
 <alpine.DEB.2.02.1412050742500.2059@localhost6.localdomain6>
 <1417764516.2721.37.camel@perches.com>
 <alpine.DEB.2.02.1412050831060.2059@localhost6.localdomain6>
Message-ID: <1417765770.2721.41.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2014-12-05 at 08:32 +0100, Julia Lawall wrote:
> On Thu, 4 Dec 2014, Joe Perches wrote:
> > On Fri, 2014-12-05 at 08:18 +0100, Julia Lawall wrote:
> > > On Thu, 4 Dec 2014, Joe Perches wrote:
> > > > Is it possible for coccinelle to look at the name
> > > > of a function that might be embedded in a format?
[]
> > > Yes, by using python/ocaml:
[]
> > > Here are some results:
> > > 
> > > drivers/net/wireless/zd1211rw/zd_usb.c:1573: "%s usb_exit()\n"
> > []
> > > The idea would be to replace these by %s and __func__?  That would also be 
> > > possible.
> > 
> > Yes and no.
> > 
> > A lot of these are function tracing style messages and
> > those should just be deleted.
> 
> Would it be possible to characterize what a function tracing style message 
> would be?  Something like 
> "<===_rtl8723be_phy_convert_txpower_dbm_to_relative_value()\n"
> that looks like it may represent a function exit?
> 
> Anything that doesn't contain %?

Some of these tracing style messages are also
emitting arguments.  I'd still delete those.

> Anything that is not under an if?

For function entrances:
Maybe something in a function's first few non-definition
statements not under an if/while/do/for/switch?

For function exits:
Maybe the last couple statements just before a return
statement or ending brace (also not under an if/etc)
