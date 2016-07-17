From: standby24x7@gmail.com (Masanari Iida)
Date: Sun, 17 Jul 2016 17:29:21 +0900
Subject: [Cocci] [PATCH 2/4] [bug-cocci] Fixed : typo in spatch.1.in
In-Reply-To: <20160717082923.1771-1-standby24x7@gmail.com>
References: <alpine.DEB.2.10.1607170817320.3253@hadrien>
 <20160717082923.1771-1-standby24x7@gmail.com>
Message-ID: <20160717082923.1771-2-standby24x7@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This patch fix a spelling typo in docs/spatch.1.in

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 docs/spatch.1.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/spatch.1.in b/docs/spatch.1.in
index dccf6fca4b51..9e72eb1e7821 100644
--- a/docs/spatch.1.in
+++ b/docs/spatch.1.in
@@ -404,7 +404,7 @@ convert ifdef to if (experimental)
 \fB\-\-noadd\-typedef\-root\fR
 .TP
 \fB\-\-disallow\-nested\-exps\fR
-disallow an expresion pattern from matching a term and its subterm
+disallow an expression pattern from matching a term and its subterm
 .HP
 \fB\-\-disable\-worth\-trying\-opt\fR
 .HP
-- 
2.9.2.277.g2949358
