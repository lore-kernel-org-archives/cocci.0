From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 4 Feb 2015 14:02:43 +0100 (CET)
Subject: [Cocci] broken comments handling
In-Reply-To: <20150204125956.GA12030@rei.scz.novell.com>
References: <20150204083900.GA2093@rei.scz.novell.com>
 <alpine.DEB.2.10.1502041337360.2394@hadrien>
 <20150204125956.GA12030@rei.scz.novell.com>
Message-ID: <alpine.DEB.2.10.1502041402270.2394@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 4 Feb 2015, Cyril Hrubis wrote:

> Hi!
> > > The comment for a is removed and replaced with the comment for b, which may
> > > lead to serious confusion.
> >
> > Thanks.
> >
> > I would have expected that both comments would stay.  I will look into it.
> > Thanks for the report.
>
> In this case removing the comment for the removed variable makes more
> sense to me.

Sure but Coccinelle is not always that clever...

julia
