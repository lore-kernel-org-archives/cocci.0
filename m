From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 11 Aug 2014 15:05:21 +0200 (CEST)
Subject: [Cocci] [PATCH] scripts/coccinelle/free/ifnullfree.cocci:
 simplify and extend to of_node_put
In-Reply-To: <53E8BE84.3080505@users.sourceforge.net>
References: <1407752653-16883-1-git-send-email-Julia.Lawall@lip6.fr>
 <53E8BE84.3080505@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1408111503550.2518@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 11 Aug 2014, SF Markus Elfring wrote:

> >  @r depends on context || report || org @
> > @@ -37,7 +35,8 @@ position p;
> >  @@
> >
> >  * if (E)
> > -*	\(kfree at p\|debugfs_remove at p\|debugfs_remove_recursive at p\|usb_free_urb\)(E);
> > +*  \(kfree at p\|debugfs_remove at p\|debugfs_remove_recursive at p\|usb_free_urb at p\|
> > +*    of_node_put at p\)(E);
>
> Why do you want to limit this semantic patch pattern to such a small list of
> function names?

Because these are the ones that kernel developers have cited as
interesting for this kind of transformation.

> Would you like to consider also the hundreds of other functions which perform
> input parameter validation?

Personally, no.  I think I have explained why several times already.

julia

> Are you interested to make the checked list more complete with further
> (eventually automatic?) extensions?
>
> Regards,
> Markus
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
