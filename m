From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Tue, 21 Jul 2015 13:51:00 -0700
Subject: [Cocci] [PATCH 1/2] autotools: unify the way to determine version
	information
In-Reply-To: <1437511861-2205-1-git-send-email-mcgrof@do-not-panic.com>
References: <1437511861-2205-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1437511861-2205-2-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The version information you get when you run: spatch --version
comes from what ./confgure.ac ends up figuring out for you.
The top level Makefile uses the same mechanism to tell you
and use the version information at build time, but if the
strategy is updated in one place it would need to be updated
in both places.

Avoid this duplicatin of work and instead just make version
information come from ./version.sh script. Then if we update
how we get the version information it just needs to be done
in one place.

We make the version.sh script use old shell mechanisms to be
able to work on any supported unix system.

Cc: Peter Senna Tschudin <peter.senna@gmail.com>
Cc: Nikolay Orlyuk <virkony@gmail.com>
Cc: S?bastien Hinderer <Sebastien.Hinderer@inria.fr>
Cc: Quentin Lambert <lambert.quentin@gmail.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 Makefile     | 2 +-
 configure.ac | 2 +-
 version.sh   | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)
 create mode 100755 version.sh

diff --git a/Makefile b/Makefile
index fd369415b1ec..cff8412019fa 100644
--- a/Makefile
+++ b/Makefile
@@ -19,7 +19,7 @@ endif
 -include /etc/Makefile.coccinelle  # local customizations, if any
 
 
-VERSION=$(shell cat ./version | tr -d '\n')
+VERSION=$(shell ./version.sh | tr -d '\n')
 CCVERSION=$(shell cat scripts/coccicheck/README | egrep -o '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+' | head -n1)
 PKGVERSION=$(shell dpkg-parsechangelog -ldebian/changelog.$(DISTRIB_CODENAME) 2> /dev/null \
 	 | sed -n 's/^Version: \(.*\)/\1/p' )
diff --git a/configure.ac b/configure.ac
index d4072004228c..679660956401 100644
--- a/configure.ac
+++ b/configure.ac
@@ -3,7 +3,7 @@ dnl  run 'automake -acf' to update setup/{install-sh,missing}
 
 dnl  standard initialization (we only use autoconf not automake)
 AC_PREREQ([2.68])
-AC_INIT([coccinelle], m4_esyscmd([cat ./version | tr -d '\n']), [cocci at systeme.lip6.fr], [], [http://coccinelle.lip6.fr/])
+AC_INIT([coccinelle], m4_esyscmd([./version.sh | tr -d '\n']), [cocci at systeme.lip6.fr], [], [http://coccinelle.lip6.fr/])
 AC_CONFIG_MACRO_DIR([setup])
 AC_CONFIG_AUX_DIR([setup])
 AC_SUBST([CONFIGURE_FLAGS], ["$*"])
diff --git a/version.sh b/version.sh
new file mode 100755
index 000000000000..f18206344a76
--- /dev/null
+++ b/version.sh
@@ -0,0 +1,3 @@
+#!/bin/sh
+VERSION=`cat ./version | tr -d '\n'`
+printf '%s' $VERSION
-- 
2.3.2.209.gd67f9d5.dirty
