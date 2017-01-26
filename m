From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 26 Jan 2017 16:47:02 +0100 (CET)
Subject: [Cocci] modifying initializers with spatch?
In-Reply-To: <1485440882.14760.8.camel@sipsolutions.net>
References: <1485433691.14760.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261415040.3109@hadrien>
 <1485437521.14760.5.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261518560.3109@hadrien>
 <1485440882.14760.8.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1701261644140.3109@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 26 Jan 2017, Johannes Berg wrote:

> > Try for the braces.??Maybe something like
> >
> > {
> > ? ... when != { ... }
> > ? T x
> > -?????= {0}
> > ? ;
> > ? ... when != S
> > ??????when any
> > ++ memset(...)
> > ???S1
> > ???... when any
> > }
>
> Yep, thanks! (I'm on the phone, and didn't get a chance to try yet)
>
> That works for anything that's actually "= {0}" today, but for I can't
> even match "= {}" properly, it seems?

The problem is that Coccinelle lets you put fewer field initializers than
are actually available.  The reasoning is that they are optional for
fields, and the user doesn't really know how many will be present in each
case.  {} is the degenerate case where none are mentioned.  But that
should not apply to your case, 1) because you are removing the braces, and
2) because you aren't doing field initializations anyway.  I'll have to
look into it.

julia
