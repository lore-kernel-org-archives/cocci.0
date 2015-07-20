From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 20 Jul 2015 19:16:45 +0200 (CEST)
Subject: [Cocci] [PATCH v2 0/4] pycocci: index opts,
 SmPL patch proof support
In-Reply-To: <CAB=NE6X2oHaW3VCR5F2o3j6RmEVeEdtwZenarM1U5qPeAB=F4Q@mail.gmail.com>
References: <1437195911-28821-1-git-send-email-mcgrof@do-not-panic.com>
 <alpine.DEB.2.02.1507181901020.2059@localhost6.localdomain6>
 <CAB=NE6VEpGSU2tY4H+QjuL82ku-Lz80sXN509q9_DgpbLnPEUQ@mail.gmail.com>
 <alpine.DEB.2.10.1507201826320.2475@hadrien>
 <CAB=NE6X2oHaW3VCR5F2o3j6RmEVeEdtwZenarM1U5qPeAB=F4Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1507201913370.2475@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 20 Jul 2015, Luis R. Rodriguez wrote:

> On Mon, Jul 20, 2015 at 9:27 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >> > Do you need patches 2 and 3?
> >>
> >> Do you mean I should squash them together, or something else ?
> >
> > I meant that since --use-git is able to cope with receiving a subtree of a
> > git repository, because git itself is able to cope with that, perhaps you
> > don't need them at all.  It seems like you are redoing all the work that
> > git already does.
>
> Ah, well so although --use-gitgrep has its own heuristics for
> determining if gitgrep can correctly be used or not we still need
> something to figure out if it toggle --use-gitgrep or not as I do not
> think Coccinelle automatically tries to make use of --use-gitgrep
> unless otherwise specified, please correct me if I'm wrong. That is,
> if no indexing arguments are passed does Coccinelle figure out on its
> own whether or not to use --use-glimpse, --use-gitgrep and as a last
> resort --use-coccigrep ? This is what pycocci is doing here. Other
> than this another reason for the git class in this series is for
> Coccinelle SmPL patch equivalence proof support, that uses git to
> create branches for the patch version of changes, then the smpl
> version of changes, and finally 'git diff --stat between these two'.

Not sure to understand.  If there is glimpse information in the specified
directory, then it would be reasonable to use glimpse.  If there is
glimpse information in a parent directory, I don't think that using
glimpse would be a good idea.  In any case, there is no code to handle
that.

Otherwise, if you give the argument --use-gitgrep, and the git command
fails (not just that it doesn't find anything, but that it actually
fails), then it will fall back to --use-coccigrep.

On the other hand, maybe the git detection is necessary for the
equivalence check.

julia
