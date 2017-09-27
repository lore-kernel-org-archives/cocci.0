From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 27 Sep 2017 15:25:14 +0200 (CEST)
Subject: [Cocci] [PATCH v3 0/5] bq27xxx_battery data memory update
In-Reply-To: <CAKvHMgQeMTgVQGk7Xn7ijNWPTPu4kVjM4ZAUUR_X-_nxSC1OBw@mail.gmail.com>
References: <20170824033617.20840-1-liam@networkimprov.net>
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
 <alpine.DEB.2.20.1709271154400.3186@hadrien>
 <CAKvHMgQeMTgVQGk7Xn7ijNWPTPu4kVjM4ZAUUR_X-_nxSC1OBw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1709271524240.3186@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 27 Sep 2017, Liam Breck wrote:

> On Wed, Sep 27, 2017 at 3:02 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> > The github version of Coccinelle finally supports the semantic patch for
>
> Should we add something to the script that aborts if the correct
> Coccinelle version is not running?

Yes, I think that functionality is provided.  Otherwise, it will just not
do anything because it is not able to parse the C code.

julia

>
> > your code.  I have attached the semantic patch.  I wonder what should be
> > done with this?  Do you want to use it locally with make coccicheck?  Do
> > you want it to be integrated into the kernel?  Everything in the semantic
> > patch depends on the occurrence of BQ27XXX_DATA, so if make coccicheck is
> > used on files that don't contain this word, they should be ignored very
> > efficiently.  So perhaps it is ok for scripts/coccinelle even if it is
> > relevant to only one file.
> >
> > julia
>
