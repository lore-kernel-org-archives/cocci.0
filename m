From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 18 Nov 2014 19:00:09 +0100
Subject: [Cocci] [PATCH 1/2] fs-udf: Deletion of unnecessary checks before
 the function call "iput"
In-Reply-To: <546B8814.2030701@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <546B8814.2030701@users.sourceforge.net>
Message-ID: <546B8929.9010409@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 18 Nov 2014 17:17:46 +0100

The iput() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 fs/udf/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index e229315..f93c65d 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -2237,8 +2237,7 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
 	return 0;
 
 error_out:
-	if (sbi->s_vat_inode)
-		iput(sbi->s_vat_inode);
+	iput(sbi->s_vat_inode);
 #ifdef CONFIG_UDF_NLS
 	if (UDF_QUERY_FLAG(sb, UDF_FLAG_NLS_MAP))
 		unload_nls(sbi->s_nls_map);
@@ -2291,8 +2290,7 @@ static void udf_put_super(struct super_block *sb)
 
 	sbi = UDF_SB(sb);
 
-	if (sbi->s_vat_inode)
-		iput(sbi->s_vat_inode);
+	iput(sbi->s_vat_inode);
 #ifdef CONFIG_UDF_NLS
 	if (UDF_QUERY_FLAG(sb, UDF_FLAG_NLS_MAP))
 		unload_nls(sbi->s_nls_map);
-- 
2.1.3
