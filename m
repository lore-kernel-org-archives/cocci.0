From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 7 Oct 2016 16:16:10 +0200
Subject: [Cocci] [PATCH] scripts/coccicheck: Update reference for the
 corresponding documentation
In-Reply-To: <alpine.DEB.2.10.1610070824490.3074@hadrien>
References: <ea62a1ea-c566-65a0-e2fd-2ee96839cf48@users.sourceforge.net>
 <alpine.DEB.2.10.1610070749420.3074@hadrien>
 <76a6d8fa-03b9-5589-2885-fa62933dd391@users.sourceforge.net>
 <alpine.DEB.2.10.1610070803550.3074@hadrien>
 <8d36952c-1dbb-bb26-ee57-3e1540c042c0@users.sourceforge.net>
 <alpine.DEB.2.10.1610070824490.3074@hadrien>
Message-ID: <8ecdc02a-1a22-951f-f3ac-2389dfbae02a@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 7 Oct 2016 16:06:15 +0200

Use the current name (in a comment at the beginning of this script) for
the file which was converted to the documentation format "reStructuredText"
in August 2016.

Fixes: 4b9033a33494ec9154d63e706e9e47f7eb3fd59e ("docs: sphinxify coccinelle.txt and add it to dev-tools")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index c92c1528..ec487b8 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -1,7 +1,7 @@
 #!/bin/bash
 # Linux kernel coccicheck
 #
-# Read Documentation/coccinelle.txt
+# Read Documentation/dev-tools/coccinelle.rst
 #
 # This script requires at least spatch
 # version 1.0.0-rc11.
-- 
2.10.1
