From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Fri, 10 Jun 2016 13:42:11 -0700
Subject: [Cocci] [PATCH 3/4] scripts: add glimpse.sh for indexing the kernel
In-Reply-To: <1465591332-31113-1-git-send-email-mcgrof@kernel.org>
References: <1465591332-31113-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1465591332-31113-4-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Glimpse is a tool you can use to index the kernel. The tool
was recently open sourced under the ISC license and can be
obtained at:

https://github.com/mcgrof/glimpse.git

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 scripts/glimpse.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100755 scripts/glimpse.sh

diff --git a/scripts/glimpse.sh b/scripts/glimpse.sh
new file mode 100755
index 000000000000..5fd24e49f31b
--- /dev/null
+++ b/scripts/glimpse.sh
@@ -0,0 +1,12 @@
+#!/bin/bash
+
+DIR=$(dirname $(readlink -f $0))
+DIR="${DIR}/../"
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
