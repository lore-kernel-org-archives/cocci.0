From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu, 16 Jun 2016 15:31:28 -0700
Subject: [Cocci] [PATCH v2 4/8] scripts: add glimpse.sh for indexing the
	kernel
In-Reply-To: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
References: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1466116292-21843-5-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Glimpse is a tool you can use to index the kernel. The tool
was open sourced on 2014-09-26 [0] under the ISC license however
the original release still [1] does not compile. A fix for this
and a release that does compile is provided in a temporary
tree [2].

v2 changesl:
o simplify DIR in one line and add verbose release information
  to commit log about the open sourcing of glimpse and its
  current status.
o add index files to .gitignore

[0] http://webglimpse.net/
[1] https://github.com/gvelez17/glimpse/
[2] https://github.com/mcgrof/glimpse.git

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 .gitignore         |  3 +++
 scripts/glimpse.sh | 11 +++++++++++
 2 files changed, 14 insertions(+)
 create mode 100755 scripts/glimpse.sh

diff --git a/.gitignore b/.gitignore
index 2be25f771bd8..e6b40a6f3a7a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -113,3 +113,6 @@ all.config
 
 # Kdevelop4
 *.kdev4
+
+# Glimpse
+.glimpse_*
diff --git a/scripts/glimpse.sh b/scripts/glimpse.sh
new file mode 100755
index 000000000000..2e866228a88f
--- /dev/null
+++ b/scripts/glimpse.sh
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+DIR="$(dirname $(readlink -f $0))/.."
+
+GLIMPSEINDEX="`which ${GLIMPSEINDEX:=glimpseindex}`"
+if [ ! -x "$GLIMPSEINDEX" ]; then
+	echo 'glimpseindex can be obtained at https://github.com/mcgrof/glimpse.git'
+	exit 1
+fi
+
+find $DIR/* -name "*.[ch]" | $GLIMPSEINDEX -o -H . -F
-- 
2.8.2
