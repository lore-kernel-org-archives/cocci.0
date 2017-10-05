From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 5 Oct 2017 21:19:16 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: api: detect duplicate chip data
	arrays
In-Reply-To: <1507230959.4434.39.camel@perches.com>
References: <1506861768-5734-1-git-send-email-Julia.Lawall@lip6.fr>
 <CAK7LNAQK7w3FBxJUhX3Vn48XsUT7jQzGDC7kzCx2r-yWm0CdEw@mail.gmail.com>
 <alpine.DEB.2.20.1710052113090.2626@hadrien>
 <1507230959.4434.39.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1710052116480.2626@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 5 Oct 2017, Joe Perches wrote:

> On Thu, 2017-10-05 at 21:13 +0200, Julia Lawall wrote:
> >
> > On Fri, 6 Oct 2017, Masahiro Yamada wrote:
> >
> > > 2017-10-01 21:42 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> > > > This semantic patch detects duplicate arrays declared using BQ27XXX_DATA
> > > > within a single structure.  It is currently specific to the file
> > > > drivers/power/supply/bq27xxx_battery.c.
> > > >
> > > > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> > > >
> > > > ---
> > >
> > > Applied to linux-kbuild/misc.
> >
> > Thanks for picking it up.
>
> If it is specific to one file, why not just run it
> and post the resultant patch?  Why have it in tree?

I guess that they anticipate that the data may change in the future?

If id-utils is used, Coccinelle will completely ignore files that don't
contain BQ27XXX_DATA, so the rule will have essentially no performance
impact.  If there is no indexing, it will only "grep" for BQ27XXX_DATA,
not actually parse the files that don't contain it.  So there is not much
performance impact even in that case.

julia
