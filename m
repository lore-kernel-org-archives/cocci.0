From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 22 Oct 2014 16:30:09 +0200
Subject: [Cocci] [PATCH 1/1] GPU-DRM-nouveau: Deletion of unnecessary
 checks before two function calls
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
Message-ID: <5447BF71.7040200@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> If you are convinced that dropping the null tests is a good idea, then you 
>> can submit the patch that makes the change to the relevant maintainers and 
>> mailing lists.

Would you like to integrate the following proposal into your source code repository?

Regards,
Markus


>From 29e61d5ccc44cd5e5961acff61b6938e0705044d Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 22 Oct 2014 15:45:22 +0200
Subject: [PATCH] GPU-DRM-nouveau: Deletion of unnecessary checks before two
 function calls

A semantic patch approach was proposed with the subject "[PATCH with
Coccinelle?] Deletion of unnecessary checks before specific function calls"
on 2014-03-05.
https://lkml.org/lkml/2014/3/5/344
http://article.gmane.org/gmane.comp.version-control.coccinelle/3513/

This patch pattern application was repeated with the help of the software
"Coccinelle 1.0.0-rc22" on the source files for Linux 3.17.1. An extract
of the automatically generated update suggestions is shown here.

It was determined that the affected source code places call functions
which perform input parameter validation already. It is therefore not
needed that a similar safety check is repeated at the call site.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/nouveau/core/core/handle.c | 3 +--
 drivers/gpu/drm/nouveau/nouveau_drm.c      | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/core/core/handle.c
b/drivers/gpu/drm/nouveau/core/core/handle.c
index a490b80..75d0c2c 100644
--- a/drivers/gpu/drm/nouveau/core/core/handle.c
+++ b/drivers/gpu/drm/nouveau/core/core/handle.c
@@ -219,8 +219,7 @@ nouveau_handle_get_cinst(struct nouveau_object *engctx, u32
cinst)
 void
 nouveau_handle_put(struct nouveau_handle *handle)
 {
-	if (handle)
-		nouveau_namedb_put(handle);
+	nouveau_namedb_put(handle);
 }

 int
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c
b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5723807..5c29079 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -512,8 +512,7 @@ nouveau_drm_unload(struct drm_device *dev)
 	nouveau_vga_fini(drm);

 	nvif_device_fini(&drm->device);
-	if (drm->hdmi_device)
-		pci_dev_put(drm->hdmi_device);
+	pci_dev_put(drm->hdmi_device);
 	nouveau_cli_destroy(&drm->client);
 	return 0;
 }
-- 
2.1.2
