From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Tue, 21 Jul 2015 13:50:59 -0700
Subject: [Cocci] [PATCH 0/2] coccinelle: add localversion information
Message-ID: <1437511861-2205-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

When working with pycocci I noticed that 1) the git tree version of coccinelle
at Inria has different tags than the git tree at github, and 2) that I was not
able to easily get Coccinelle's own tools to determine if we had some sort of
dirty tree or tree with changes beyond a tagged official release. As an example
even though --jobs is now fixed on the inria git tree, this code is not yet
on github.

The issue with 1) prevents me to build custom versions of coccinelle
and get pycocci to work with my goal to support the future 1.0.2 release
or a release beyond 1.0.1. The issues with 1) may hopefully be fixed by
streamlining how the releases are made with development but discussion is
ongoing with this.

Provided 1) was fixed, and say the inria git tree had the proper 1.0.1 tag
as well, I'd then be able to modify pycocci to say: hey, use --jobs if you
detect you are on a release which is > 1.0.1. I can't do this though as the
version information on coccinelle does not take into consideration local
deltas. I've decided to borrow the Linux kernel mechanism for determining
this and allowing Coccinelle to make use of it. With these changes we will
keep the version string clean if no tree modifications are on your tree and
your tags are synced up.

If you have modifications you can end up either with a -dirty postfixed tree,
or a tree that shows the delta of commits on top of a blessed release. For
instance, if you have changes not commited you'll now get on spatch --version:

1.0.2-dirty
                                                                                
Likewise if your tree has some commits not upstream these will be reflected.
For instance, say you had one extra commit, you'd end up with something like:

1.0.2-00001-g8870d8b0cf33

Provided we address 1) then tools can infer local hacks and let you move on
with life as the coccinelle development train moves forward.

Luis R. Rodriguez (2):
  autotools: unify the way to determine version information
  autotools: add localversion information

 Makefile                |  2 +-
 configure.ac            |  2 +-
 scripts/setlocalversion | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
 version.sh              |  4 +++
 4 files changed, 83 insertions(+), 2 deletions(-)
 create mode 100755 scripts/setlocalversion
 create mode 100755 version.sh

-- 
2.3.2.209.gd67f9d5.dirty
