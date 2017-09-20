From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 20 Sep 2017 11:45:05 +0200 (CEST)
Subject: [Cocci] [PATCH v3 0/5] bq27xxx_battery data memory update
In-Reply-To: <CAKvHMgTUrdF_ZmJYOB3jn020BMv-70MLpUBosBLstDrBN_KY9w@mail.gmail.com>
References: <20170824033617.20840-1-liam@networkimprov.net>
 <20170830002939.ns43wldvffmwqhuv@earth>
 <CAKvHMgSyr8aZ1cVd-Zf6WHNkwyTcSBvRaVuDWuHEnuNM=MStUA@mail.gmail.com>
 <alpine.DEB.2.20.1708311150440.3243@hadrien>
 <CAKvHMgSkuzi_BuicT7edYrM8Q87pnPJcgHRMDJEB21wdNKf8ow@mail.gmail.com>
 <alpine.DEB.2.20.1708311330570.3243@hadrien>
 <CAKvHMgSKLJk2wB9pefYuGyMG2aNp7bCCaOMABGRxXZ9ju-ivHw@mail.gmail.com>
 <CAKvHMgRzFpueUccSL1iu_-EazCe76cF8iSAPyYgcxJ3dNOZejA@mail.gmail.com>
 <alpine.DEB.2.20.1709052214030.2058@hadrien>
 <CAKvHMgTE-vypWKjhR7QgQNHFbVNdg99MgARmC-cTv6vfjgzZFg@mail.gmail.com>
 <alpine.DEB.2.20.1709180731060.2547@hadrien>
 <CAKvHMgSnULnEAtW5Axi1fyJG_2YW7hD3K_-N5P3Xdq_Gn72z4A@mail.gmail.com>
 <alpine.DEB.2.20.1709192355160.2518@hadrien>
 <CAKvHMgTF8C+7xcO31MvVeepCmSiP4V6tvvC4uVfcA4_JAfFHsw@mail.gmail.com>
 <alpine.DEB.2.20.1709201108070.3290@hadrien>
 <CAKvHMgTUrdF_ZmJYOB3jn020BMv-70MLpUBosBLstDrBN_KY9w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1709201142150.3290@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > Also, Coccinelle is comparing the list, but I guess you would prefer that
> > it compare the set, to check for the cases where the names are the same
> > but appear in a different order.
>
> Yes, ideally it would sort arrays before doing compare. Is that doable?

Yes.

>
> >>
> >> > I've attached the script and some fake data that I made to test it.  The
> >> > fake data has some added cases where I have replaced 27 in the structure
> >> > name by 07.  For my test data I get:
> >> >
> >> > bq07421_regs and bq27421_regs have the same registers
> >> > bq07000_regs and bq27000_regs have the same registers
> >> > bq07421_dm_regs and bq27421_dm_regs have the same registers
> >> > bq07421_props and bq27421_props have the same properties
> >> > bq07000_props and bq27000_props have the same properties
>
> We can just write
> "%s & %s are identical"

OK.

But just to check, there are three fields of interest: regs, dm_regs and
props.  If for two entries regs are the same but dm_regs and props are
different, you still want a warning about regs, right?  This is the
behavior that seemed to be in the C code and is what I have implemented.
Or do you want a warning only if all three are the same.

julia
