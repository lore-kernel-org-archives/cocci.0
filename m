From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 9 Aug 2014 10:37:51 +0200 (CEST)
Subject: [Cocci] [patch 119/197] scripts/coccinelle/free: Delete NULL
 test before freeing functions
In-Reply-To: <53E5DA60.90902@users.sourceforge.net>
References: <53e53fd1.zO3IbUqJ421c7VXf%akpm@linux-foundation.org>
 <53E5DA60.90902@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1408091028520.2016@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 9 Aug 2014, SF Markus Elfring wrote:

> > + at r depends on context || report || org @
> > +expression E;
> > +position p;
> > +@@
> > +
> > +* if (E)
> > +*	\(kfree at p\|debugfs_remove at p\|debugfs_remove_recursive at p\|usb_free_urb\)(E);
> 
> How do you think about to add the construct "@p" also behind the function name
> "usb_free_urb"?

Yes, that would be needed, thanks.  Also, it was recently suggested to add 
of_node_put to the list of things that are checked for.

> Is my previous update suggestion for such an issue worth for another look, too?

I still don't think this should be done for any random function that 
performs a null test on its argument.  The corrections involved here are 
not as trivial as they would seem.  Often it is not the case that the null 
test at the call site should be just deleted, instead the code should be 
reorganized.  Making a rule that treats 5000 functions that are 
automatically selected will just encourage people to do sloppy things.

(Personally, I don't like the whole null test removal idea.  It mixes the 
notion of something that is necessary and has failed and something that is 
optional.  In the case of something that is necessary and has failed, the 
null value is usually statically apparent, and the code can be reorganized 
so that a null value doesn't go where it is not wanted.  In the case of 
something that is simply optional, the presence of the null test gives 
the reader of the code some information.  Removing this information in 
rarely executed code seems unfortunate.)

julia

> 
> Regards,
> Markus
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
