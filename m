From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 17 Nov 2014 13:12:15 +0100
Subject: [Cocci] [PATCH 1/1] ALSA: hdsp: Deletion of an unnecessary check
 before the function call "release_firmware"
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
Message-ID: <5469E61F.6000002@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 17 Nov 2014 13:04:14 +0100

The release_firmware() function tests whether its argument is NULL and then
return immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/rme9652/hdsp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 7646ba1..0ae568d 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -5368,8 +5368,7 @@ static int snd_hdsp_free(struct hdsp *hdsp)
 
 	snd_hdsp_free_buffers(hdsp);
 
-	if (hdsp->firmware)
-		release_firmware(hdsp->firmware);
+	release_firmware(hdsp->firmware);
 	vfree(hdsp->fw_uploaded);
 
 	if (hdsp->iobase)
-- 
2.1.3
