From: qpuzh@yahoo.com (qpuzh at yahoo.com)
Date: Tue, 6 Oct 2015 05:25:49 +0000
Subject: [Cocci] change #include <file>
Message-ID: <56135B5D.4030302@yahoo.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

how can i change #include directives file name?
this doesn't work:
@@ @@
-#include <a.h>
+#include <b.h>
