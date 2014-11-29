From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 29 Nov 2014 15:33:34 +0100
Subject: [Cocci] [PATCH 1/1] HID: Wacom: Deletion of unnecessary checks
 before the function call "input_free_device"
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
Message-ID: <5479D93E.3040407@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 29 Nov 2014 15:16:01 +0100

The input_free_device() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/wacom_sys.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index eb55316..21ced00 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1099,10 +1099,8 @@ static void wacom_free_inputs(struct wacom *wacom)
 {
 	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
 
-	if (wacom_wac->input)
-		input_free_device(wacom_wac->input);
-	if (wacom_wac->pad_input)
-		input_free_device(wacom_wac->pad_input);
+	input_free_device(wacom_wac->input);
+	input_free_device(wacom_wac->pad_input);
 	wacom_wac->input = NULL;
 	wacom_wac->pad_input = NULL;
 }
-- 
2.1.3
