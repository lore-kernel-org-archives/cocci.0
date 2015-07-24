From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Fri, 24 Jul 2015 11:50:11 -0700
Subject: [Cocci] [PATCH v2 0/2] coccinelle: add localversion information
Message-ID: <1437763813-6171-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This v2 removes the superfluous tr calls and switches to using stdin
instead of using cat for the first look at the version file. While
at it, since I am taking this from the Linux kernel and since the
script used had quite a bit of love over the years I've provided
attribution information to the file. Since Coccinelle does not
currently used PGP signed tags I've also added support for that
and enabled its use by default but am in hopes we can consider
using PGP keys for signed tags in the future.

I also made a small note about using PGP subkeys for deprecating releases,
for details on why that may be good see:

http://lkml.kernel.org/r/20150721002438.GG30479 at wotan.suse.de

In short, I'd encourage folks to use PGP subkeys for different purposes.
For instance use one PGP subkey for making releases, and another different
PGP subkey for deprecating releaes. Using two different PGP keys (different
keys are overkill, hence why I say just use subkeys) can help tools to infer
what releases are supported and unsupported, directly from the git tree.
Feel free to ignore all this if you do not care for tools to infer releases
for coccinelle, but if for instance you do care for it and if it is desirable
for the release page to be made automatically, I can volunteer to help
integrate it as part of rel-html. Example release pages with rel-html:

http://drvbp1.linux-foundation.org/~mcgrof/rel-html/

Lastly, I realize a 'make release' is used right now for releases, I
didn't amend those instructions (on Makefile.release) but here's a way 
to use upkeep a linear git tree (not done right now on Coccinelle) even
if you wanted to bump release with autotools:

Say you have a linear set of history and you are about to make a 1.0.2
release, you'd do this:

a) edit version file and bump it to 1.0.2
b) git clean -f -x -d
   Careful, this will delete *everything* that is not commited in your
   git tree.
c) make a temporary tag for git with 1.0.2, so that when you run ./autogen it
   will pick up all the 1.0.2 tag and detect your tree is intact and all code
   is part of the release.
   git tag -s 1.0.2
d) run ./autogen
e) git commit -a -s
f) delete the temporary tag:
   git tag -d 1.0.2
g) make a new tag now that matches the autogen run:
   git tag -s 1.0.2

This allows you to keep using 1 tag for both git development and autotools
official releases. This means that if people check out a release on the
tag 1.0.2 you will always get 1.0.2 on the version information so long as
you didn't do any modifications and provided your autotools versions match
(this later requirement is less important to developers). It also means that
same git tree checkout for non-developers, who do not run ./autgen but just
run ./configure will always get the same version information.

Luis R. Rodriguez (2):
  autotools: unify the way to determine version information
  autotools: add localversion information

 Makefile                |   2 +-
 configure.ac            |   2 +-
 scripts/setlocalversion | 117 ++++++++++++++++++++++++++++++++++++++++++++++++
 version.sh              |   4 ++
 4 files changed, 123 insertions(+), 2 deletions(-)
 create mode 100755 scripts/setlocalversion
 create mode 100755 version.sh

-- 
2.3.2.209.gd67f9d5.dirty
