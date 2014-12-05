From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 5 Dec 2014 08:32:33 +0100 (CET)
Subject: [Cocci] Finding embedded function names?
In-Reply-To: <1417764516.2721.37.camel@perches.com>
References: <1417741951.2721.30.camel@perches.com>
 <alpine.DEB.2.02.1412050742500.2059@localhost6.localdomain6>
 <1417764516.2721.37.camel@perches.com>
Message-ID: <alpine.DEB.2.02.1412050831060.2059@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 4 Dec 2014, Joe Perches wrote:

> On Fri, 2014-12-05 at 08:18 +0100, Julia Lawall wrote:
> > On Thu, 4 Dec 2014, Joe Perches wrote:
> > > Is it possible for coccinelle to look at the name
> > > of a function that might be embedded in a format?
> > > ie for:
> > > void testme(void)
> > > {
> > > 	printf("testme: some message\n");
> > > }
> > > Can it find the "testme" embedded in a format string?
> > 
> > Yes, by using python/ocaml:
> > 
> > @r@
> > char [] c;
> > position p;
> > identifier f;
> > @@
> > 
> > f(...,c at p,...)
> > 
> > @script:ocaml@
> > c << r.c;
> > p << r.p;
> > @@
> > 
> > let ce = (List.hd p).current_element in
> > if List.length(Str.split_delim (Str.regexp ce) c) > 1
> > then Printf.printf "%s:%d: %s\n"
> >        (List.hd p).file (List.hd p).line c
> 
> Good to know, thanks.
> 
> > Here are some results:
> > 
> > drivers/net/wireless/zd1211rw/zd_usb.c:1573: "%s usb_exit()\n"
> []
> > The idea would be to replace these by %s and __func__?  That would also be 
> > possible.
> 
> Yes and no.
> 
> A lot of these are function tracing style messages and
> those should just be deleted.

Would it be possible to characterize what a function tracing style message 
would be?  Something like 
"<===_rtl8723be_phy_convert_txpower_dbm_to_relative_value()\n"
that looks like it may represent a function exit?

Anything that doesn't contain %?

Anything that is not under an if?

julia
