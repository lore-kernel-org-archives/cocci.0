From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 22 Sep 2015 15:15:30 +0200
Subject: [Cocci] [PATCH v2] Coccinelle: fix incorrect -include option
	transformation
In-Reply-To: <56015315.507@samsung.com>
References: <56015315.507@samsung.com>
Message-ID: <1442927730-18676-1-git-send-email-a.hajda@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

kbuild/gcc uses -include option to include files and -I to provide paths for
#include <> directive. In case of spatch latter option should be prefixed with
two -.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index bbf901a..b2d75818 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -30,7 +30,7 @@ FLAGS="$SPFLAGS --very-quiet"
 # spatch only allows include directories with the syntax "-I include"
 # while gcc also allows "-Iinclude" and "-include include"
 COCCIINCLUDE=${LINUXINCLUDE//-I/-I }
-COCCIINCLUDE=${COCCIINCLUDE//-include/-I}
+COCCIINCLUDE=${COCCIINCLUDE// -include/ --include}
 
 if [ "$C" = "1" -o "$C" = "2" ]; then
     ONLINE=1
-- 
1.9.1
