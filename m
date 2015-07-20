From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 20 Jul 2015 18:27:35 +0200 (CEST)
Subject: [Cocci] [PATCH v2 0/4] pycocci: index opts,
 SmPL patch proof support
In-Reply-To: <CAB=NE6VEpGSU2tY4H+QjuL82ku-Lz80sXN509q9_DgpbLnPEUQ@mail.gmail.com>
References: <1437195911-28821-1-git-send-email-mcgrof@do-not-panic.com>
 <alpine.DEB.2.02.1507181901020.2059@localhost6.localdomain6>
 <CAB=NE6VEpGSU2tY4H+QjuL82ku-Lz80sXN509q9_DgpbLnPEUQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1507201826320.2475@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 20 Jul 2015, Luis R. Rodriguez wrote:

>
>
> On Jul 18, 2015 10:01 AM, "Julia Lawall" <julia.lawall@lip6.fr> wrote:
> >
> > On Fri, 17 Jul 2015, Luis R. Rodriguez wrote:
> >
> > > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > >
> > > This v2 changes the way we do git tree inference by using
> > > git rev-parse. While at it, I decided to mesh in SmPL? <--> patch
> > > equivalence proof support. This is a generalized solution, I
> > > originally had written for the backports project, we now give
> > > this instead a proper home and purpose under pycocci.
> > >
> > > If there are no issues I'll merge this soon, in hopes it will
> > > make it for the coccinelle 1.0.2 release.
> > >
> > > Luis R. Rodriguez (4):
> > >? ?pycocci: add requirements class
> > >? ?pycocci: add git class
> > >? ?pycocci: figure out if to enable --jobs, --use-gitgrep or
> > >? ? ?--use-glimpse
> >
> > Do you need patches 2 and 3?
>
> Do you mean I should squash them together, or something else ?

I meant that since --use-git is able to cope with receiving a subtree of a
git repository, because git itself is able to cope with that, perhaps you
don't need them at all.  It seems like you are redoing all the work that
git already does.

julia

>
> ? Luis
> > julia
> >
> > >? ?pycocci: add Coccinelle SmPL patch proof support
> > >
> > >? tools/pycocci | 475
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
> > >? 1 file changed, 462 insertions(+), 13 deletions(-)
> > >
> > > --
> > > 2.3.2.209.gd67f9d5.dirty
> > >
> > > _______________________________________________
> > > Cocci mailing list
> > > Cocci at systeme.lip6.fr
> > > https://systeme.lip6.fr/mailman/listinfo/cocci
> > >
>
>
>
