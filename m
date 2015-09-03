From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Wed,  2 Sep 2015 18:20:50 -0700
Subject: [Cocci] [PATCH] Makefile: fix autotools pre ./configure version
	regression
Message-ID: <1441243250-23830-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The change to fold version information into a single helper
removed access to the VERSION variable before ./configure was
run. We have a slew of dependencies on this variable though,
users of this variable are typically only used for release
purpose so when the user hasn't yet run ./configure simply
assume we want the version information as if we're making
a release and don't want any dirty tree annotations.

Reported-by: S?bastien Hinderer <Sebastien.Hinderer@inria.fr>
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index 1564f7197ee1..f706cb86e255 100644
--- a/Makefile
+++ b/Makefile
@@ -18,6 +18,16 @@ endif
 -include Makefile.override         # local customizations, if any
 -include /etc/Makefile.coccinelle  # local customizations, if any
 
+# We inherit the version information *after* the user has run
+# ./configure but in the absence of that the build system has
+# a few dependencies on the version information, we need a default
+# setting then prior to the user running ./configure, this provides
+# that, but will only be set if the user hasn't already run ./configure
+#
+# The only thing we can do is assume that the user relying on this
+# variable then was going to make a release, this means we don't
+# tell them that the tree is dirty.
+VERSION?=$(shell MAKE_COCCI_RELEASE="y" ./version.sh)
 
 CCVERSION=$(shell cat scripts/coccicheck/README | egrep -o '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+' | head -n1)
 PKGVERSION=$(shell dpkg-parsechangelog -ldebian/changelog.$(DISTRIB_CODENAME) 2> /dev/null \
-- 
2.4.3
