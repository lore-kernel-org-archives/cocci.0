From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 16 Nov 2014 23:40:18 +0100
Subject: [Cocci] [PATCH 1/1] fs-jbd: Deletion of an unnecessary check before
 the function call "iput"
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
Message-ID: <546927D2.7050709@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 16 Nov 2014 23:23:19 +0100

The iput() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 fs/jbd/journal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/jbd/journal.c b/fs/jbd/journal.c
index 06fe11e..32fe03e 100644
--- a/fs/jbd/journal.c
+++ b/fs/jbd/journal.c
@@ -1373,8 +1373,7 @@ int journal_destroy(journal_t *journal)
 	}
 	mutex_unlock(&journal->j_checkpoint_mutex);
 
-	if (journal->j_inode)
-		iput(journal->j_inode);
+	iput(journal->j_inode);
 	if (journal->j_revoke)
 		journal_destroy_revoke(journal);
 	kfree(journal->j_wbuf);
-- 
2.1.3
