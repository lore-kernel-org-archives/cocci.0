From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 5 Oct 2017 21:28:00 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: api: detect duplicate chip data
	arrays
In-Reply-To: <CAKvHMgRx9U+GQ82GrSZYTAA6s1RH+HpEtkYZYf+O3VzqLDoD_g@mail.gmail.com>
References: <1506861768-5734-1-git-send-email-Julia.Lawall@lip6.fr>
 <CAK7LNAQK7w3FBxJUhX3Vn48XsUT7jQzGDC7kzCx2r-yWm0CdEw@mail.gmail.com>
 <alpine.DEB.2.20.1710052113090.2626@hadrien>
 <1507230959.4434.39.camel@perches.com>
 <CAKvHMgRx9U+GQ82GrSZYTAA6s1RH+HpEtkYZYf+O3VzqLDoD_g@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1710052127320.2626@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 5 Oct 2017, Liam Breck wrote:

> Hi Joe,
>
> On Thu, Oct 5, 2017 at 12:15 PM, Joe Perches <joe@perches.com> wrote:
> > On Thu, 2017-10-05 at 21:13 +0200, Julia Lawall wrote:
> >>
> >> On Fri, 6 Oct 2017, Masahiro Yamada wrote:
> >>
> >> > 2017-10-01 21:42 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> >> > > This semantic patch detects duplicate arrays declared using BQ27XXX_DATA
> >> > > within a single structure.  It is currently specific to the file
> >> > > drivers/power/supply/bq27xxx_battery.c.
> >> > >
> >> > > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> >> > >
> >> > > ---
> >> >
> >> > Applied to linux-kbuild/misc.
> >>
> >> Thanks for picking it up.
> >
> > If it is specific to one file, why not just run it
> > and post the resultant patch?  Why have it in tree?
>
> The driver which this script analyzes supports more than a dozen
> different chips, which require different parameters. This script
> checks for duplicate parameter arrays.

I think the question is more how will the code change over time.

julia
