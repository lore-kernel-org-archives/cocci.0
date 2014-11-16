From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 16 Nov 2014 20:22:22 +0100
Subject: [Cocci] [PATCH v2 2/2] kernel-trace: Less calls for iput() in
 create_trace_uprobe() after error detection
In-Reply-To: <5468F756.8070807@users.sourceforge.net>
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
 <5317A59D.4@users.sourceforge.net> <5468ABBD.6000903@users.sourceforge.net>
 <alpine.DEB.2.10.1411161656340.2364@hadrien>
 <5468F756.8070807@users.sourceforge.net>
Message-ID: <5468F96E.4090903@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 16 Nov 2014 19:49:39 +0100

The iput() function was called in three cases by the create_trace_uprobe()
function during error handling even if the passed variable contained still
a null pointer. This implementation detail could be improved by the
introduction of another jump label.

Suggested-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 kernel/trace/trace_uprobe.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index ec002c0..a0288f2 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -434,19 +434,24 @@ static int create_trace_uprobe(int argc, char **argv)
 	arg = strchr(argv[1], ':');
 	if (!arg) {
 		ret = -EINVAL;
-		goto fail_address_parse;
+		goto fail_address_parse2;
 	}
 
 	*arg++ = '\0';
 	filename = argv[1];
 	ret = kern_path(filename, LOOKUP_FOLLOW, &path);
 	if (ret)
-		goto fail_address_parse;
+		goto fail_address_parse2;
 
 	inode = igrab(path.dentry->d_inode);
 	path_put(&path);
 
-	if (!inode || !S_ISREG(inode->i_mode)) {
+	if (!inode) {
+		ret = -EINVAL;
+		goto fail_address_parse2;
+	}
+
+	if (!S_ISREG(inode->i_mode)) {
 		ret = -EINVAL;
 		goto fail_address_parse;
 	}
@@ -554,6 +559,7 @@ error:
 fail_address_parse:
 	iput(inode);
 
+fail_address_parse2:
 	pr_info("Failed to parse address or file.\n");
 
 	return ret;
-- 
2.1.3
