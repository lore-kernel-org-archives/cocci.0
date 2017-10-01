From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 1 Oct 2017 13:59:45 +0200 (CEST)
Subject: [Cocci] [PATCH v3 0/5] bq27xxx_battery data memory update
In-Reply-To: <CAKvHMgTm0JvnawzTSVJx43y-bnO-Rmh0ZPBQL0z3aYFUh=PjLw@mail.gmail.com>
References: <20170824033617.20840-1-liam@networkimprov.net>
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
 <CAKvHMgR9kKj+3DPpoRkk52B7caA7OBf1B0Rjv1q5KxmxpFU=3Q@mail.gmail.com>
 <alpine.DEB.2.20.1709271414310.3186@hadrien>
 <CAKvHMgTm0JvnawzTSVJx43y-bnO-Rmh0ZPBQL0z3aYFUh=PjLw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1710011359070.2031@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 27 Sep 2017, Liam Breck wrote:

> On Wed, Sep 27, 2017 at 5:16 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> >
> > On Wed, 27 Sep 2017, Liam Breck wrote:
> >
> >> Hi Julia, thanks so much for your help!
> >>
> >> On Wed, Sep 27, 2017 at 3:02 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >> > The github version of Coccinelle finally supports the semantic patch for
> >> > your code.  I have attached the semantic patch.  I wonder what should be
> >> > done with this?  Do you want to use it locally with make coccicheck?  Do
> >> > you want it to be integrated into the kernel?  Everything in the semantic
> >>
> >> Yes, our intent is to push it upstream. Can you submit a patch?
> >>
> >> Did you test with 4.13? That should show a handful of dupes...
> >
> > Are you sure?  I did a git checkout v4.13 and there aren't any occurrences
> > of BQ27XXX_DATA.
>
> Sorry, that macro landed in 4.14. If you revert this commit, you
> should see dupes:
> power: supply: bq27xxx: Remove duplicate chip data arrays

Thanks for the pointer to this commit.  I get the results described in the
commit log:

bq27500_regs and bq27510g1_regs have the same registers
bq27500_regs and bq27510g2_regs have the same registers
bq27510g1_regs and bq27510g2_regs have the same registers
bq27510g3_regs and bq2751x_regs have the same registers
bq2750x_props and bq27510g3_props have the same properties
bq2750x_props and bq2751x_props have the same properties
bq27510g3_props and bq2751x_props have the same properties
bq27500_props and bq27510g1_props have the same properties
bq27500_props and bq27510g2_props have the same properties
bq27500_props and bq27520g2_props have the same properties
bq27510g1_props and bq27510g2_props have the same properties
bq27510g1_props and bq27520g2_props have the same properties
bq27510g2_props and bq27520g2_props have the same properties

julia
