From: joe@perches.com (Joe Perches)
Date: Thu, 04 Dec 2014 23:28:36 -0800
Subject: [Cocci] Finding embedded function names?
In-Reply-To: <alpine.DEB.2.02.1412050742500.2059@localhost6.localdomain6>
References: <1417741951.2721.30.camel@perches.com>
 <alpine.DEB.2.02.1412050742500.2059@localhost6.localdomain6>
Message-ID: <1417764516.2721.37.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2014-12-05 at 08:18 +0100, Julia Lawall wrote:
> On Thu, 4 Dec 2014, Joe Perches wrote:
> > Is it possible for coccinelle to look at the name
> > of a function that might be embedded in a format?
> > ie for:
> > void testme(void)
> > {
> > 	printf("testme: some message\n");
> > }
> > Can it find the "testme" embedded in a format string?
> 
> Yes, by using python/ocaml:
> 
> @r@
> char [] c;
> position p;
> identifier f;
> @@
> 
> f(...,c at p,...)
> 
> @script:ocaml@
> c << r.c;
> p << r.p;
> @@
> 
> let ce = (List.hd p).current_element in
> if List.length(Str.split_delim (Str.regexp ce) c) > 1
> then Printf.printf "%s:%d: %s\n"
>        (List.hd p).file (List.hd p).line c

Good to know, thanks.

> Here are some results:
> 
> drivers/net/wireless/zd1211rw/zd_usb.c:1573: "%s usb_exit()\n"
[]
> The idea would be to replace these by %s and __func__?  That would also be 
> possible.

Yes and no.

A lot of these are function tracing style messages and
those should just be deleted.

Otherwise, yes.
