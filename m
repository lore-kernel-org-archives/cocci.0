From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 18 Nov 2014 11:35:28 +0100
Subject: [Cocci] [PATCH 1/1] GFS2: Deletion of unnecessary checks before two
 function calls
In-Reply-To: <5317A59D.4@users.sourceforge.net>
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
 <5317A59D.4@users.sourceforge.net>
Message-ID: <546B20F0.9040202@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 18 Nov 2014 11:31:23 +0100

The functions iput() and put_pid() test whether their argument is NULL
and then return immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 fs/gfs2/glock.c      | 3 +--
 fs/gfs2/ops_fstype.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 7f513b1..f4aa085 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -836,8 +836,7 @@ void gfs2_holder_reinit(unsigned int state, unsigned flags, struct gfs2_holder *
 	gh->gh_flags = flags;
 	gh->gh_iflags = 0;
 	gh->gh_ip = (unsigned long)__builtin_return_address(0);
-	if (gh->gh_owner_pid)
-		put_pid(gh->gh_owner_pid);
+	put_pid(gh->gh_owner_pid);
 	gh->gh_owner_pid = get_pid(task_pid(current));
 }
 
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index d3eae24..272ff81 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -918,8 +918,7 @@ fail_qc_i:
 fail_ut_i:
 	iput(sdp->sd_sc_inode);
 fail:
-	if (pn)
-		iput(pn);
+	iput(pn);
 	return error;
 }
 
-- 
2.1.3
