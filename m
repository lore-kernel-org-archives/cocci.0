From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Mon, 27 Jul 2015 15:03:31 -0700
Subject: [Cocci] [PATCH v3 1/2] autotools: simplify the way to determine
	version information
In-Reply-To: <1438034612-10595-1-git-send-email-mcgrof@do-not-panic.com>
References: <1438034612-10595-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1438034612-10595-2-git-send-email-mcgrof@do-not-panic.com>
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
information come from ./version.sh script. We also remove the
Makefile version of determining the version information and
instead rely on the fact that Makefile.config.in is part of
AC_CONFIG_FILES() and have AC_SUBST([COCCI_VERSION], ["$PACKAGE_VERSION"])
in place.

Cc: Peter Senna Tschudin <peter.senna@gmail.com>
Cc: Nikolay Orlyuk <virkony@gmail.com>
Cc: S?bastien Hinderer <Sebastien.Hinderer@inria.fr>
Cc: Quentin Lambert <lambert.quentin@gmail.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 Makefile           | 1 -
 Makefile.config.in | 2 ++
 configure.ac       | 2 +-
 version.sh         | 2 ++
 4 files changed, 5 insertions(+), 2 deletions(-)
 create mode 100755 version.sh

diff --git a/Makefile b/Makefile
index fd369415b1ec..f8c99d3bb8d8 100644
--- a/Makefile
+++ b/Makefile
@@ -19,7 +19,6 @@ endif
 -include /etc/Makefile.coccinelle  # local customizations, if any
 
 
-VERSION=$(shell cat ./version | tr -d '\n')
 CCVERSION=$(shell cat scripts/coccicheck/README | egrep -o '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+' | head -n1)
 PKGVERSION=$(shell dpkg-parsechangelog -ldebian/changelog.$(DISTRIB_CODENAME) 2> /dev/null \
 	 | sed -n 's/^Version: \(.*\)/\1/p' )
diff --git a/Makefile.config.in b/Makefile.config.in
index 5eb7ac496fd3..ee23e09f29ce 100644
--- a/Makefile.config.in
+++ b/Makefile.config.in
@@ -1,3 +1,5 @@
+VERSION=@PACKAGE_VERSION@
+
 # * for each library $1, add another entry in the same manner
 MAKELIBS=@MAKE_dynlink@ @MAKE_menhirLib@ @MAKE_pycaml@ @MAKE_pcre@ \
   @MAKE_parmap@
diff --git a/configure.ac b/configure.ac
index d4072004228c..4c610afa5a2d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -3,7 +3,7 @@ dnl  run 'automake -acf' to update setup/{install-sh,missing}
 
 dnl  standard initialization (we only use autoconf not automake)
 AC_PREREQ([2.68])
-AC_INIT([coccinelle], m4_esyscmd([cat ./version | tr -d '\n']), [cocci at systeme.lip6.fr], [], [http://coccinelle.lip6.fr/])
+AC_INIT([coccinelle], m4_esyscmd([./version.sh]), [cocci at systeme.lip6.fr], [], [http://coccinelle.lip6.fr/])
 AC_CONFIG_MACRO_DIR([setup])
 AC_CONFIG_AUX_DIR([setup])
 AC_SUBST([CONFIGURE_FLAGS], ["$*"])
diff --git a/version.sh b/version.sh
new file mode 100755
index 000000000000..02a5b7253ba9
--- /dev/null
+++ b/version.sh
@@ -0,0 +1,2 @@
+#!/bin/sh
+tr -d '\n' < ./version
-- 
2.3.2.209.gd67f9d5.dirty
