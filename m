From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Mon, 27 Jul 2015 15:03:30 -0700
Subject: [Cocci] [PATCH v3 0/2] coccinelle: add localversion information
Message-ID: <1438034612-10595-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This v3 makes use of the recommended strategy by Nikolay to avoid
a local variable for the version.sh. It also clarifies in the commit
log on patch 2 that PGP signed tags are not required by default. If
Coccinelle switches over to using PGP tags the scripts/setlocalversion
file can be modified to require them, but for now this is disabled.

Lastly, in order to try to help simplify the way release managers might make a
release in a linear fashion with a git tree I modified autogen.sh to accept
a new argument:

./autogen --ignore_localversion

which can be used by release managers to skip the local version string
when making a release. This is in contrast to my v2 series which would
have otherwise required release managers to make temporary tags, delete
them, and them finally add a new tag later. This is much simpler solution.

The default is to parse the localversion string then if available.

Luis R. Rodriguez (2):
  autotools: simplify the way to determine version information
  autotools: add localversion information

 Makefile                |   1 -
 Makefile.config.in      |   2 +
 autogen                 |   5 +++
 configure.ac            |   2 +-
 scripts/setlocalversion | 117 ++++++++++++++++++++++++++++++++++++++++++++++++
 version.sh              |   5 +++
 6 files changed, 130 insertions(+), 2 deletions(-)
 create mode 100755 scripts/setlocalversion
 create mode 100755 version.sh

-- 
2.3.2.209.gd67f9d5.dirty
