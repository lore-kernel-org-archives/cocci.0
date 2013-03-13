From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 13 Mar 2013 09:47:54 +0100 (CET)
Subject: [Cocci] "virtual rule patch not supported"
In-Reply-To: <513D94DC.9090708@inria.fr>
References: <513D94DC.9090708@inria.fr>
Message-ID: <alpine.DEB.2.02.1303130946150.1933@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 11 Mar 2013, Brice Goglin wrote:

> Hello,
> I am running the kernel 3.9-rc2 coccicheck script on some of my module,
> and I get the following message:
>   virtual rule patch not supported

I guess it doesn't crash?  It is possible that some semantic patch just
doesn't support the patch option.  I don't remember if it is possible to
specify several options, and to have them tried in order?  That could be a
nice feature.  If not, I think that there is an option that tries all of
the options in a fixed order.  Nicolas?

julia

> Things seem to work fine aside of this message. Anything to be worried
> about?
> I already upgraded to coccinelle 1.0-rc16 (from Debian experimental)
> since rc12 didn't accept orplus.cocci. Anything else to upgrade to avoid
> the message?
> Thanks
> Brice
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
