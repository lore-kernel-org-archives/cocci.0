From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 15 Aug 2018 11:40:11 +0200 (CEST)
Subject: [Cocci] Adjustment for const qualification
In-Reply-To: <94cb119a-e880-2442-35e7-c1286ea8b032@users.sourceforge.net>
References: <deb8e4df52ce0baddcae77458a8a7246814b8804.camel@intel.com>
 <b417bf64-7970-8482-0246-ab00129b4657@users.sourceforge.net>
 <alpine.DEB.2.20.1808151127520.2309@hadrien>
 <94cb119a-e880-2442-35e7-c1286ea8b032@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1808151139210.2309@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 15 Aug 2018, SF Markus Elfring wrote:

> >> How do you think about to try the following SmPL script variant out?
> >>
> >> @replacement@
> >> @@
> >> -const
> >> +__genl_const
> >>  struct
> >> (
> >>  genl_multicast_group
> >> |genl_ops
> >> )
> >
> > This is rejected by the semantic patch parser.
>
> Can my update suggestion make sense if the parsing software
> will be adjusted anyhow?
>
> Does this variant need a small adjustment to get it working
> with the current tool version?

I don't know.  It may be large and it may be small.  You are welcome to
try to change it if you want.  Otherwise it doesn't seem urgent.

julia
