From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 12 Nov 2014 21:30:43 +0100
Subject: [Cocci] [PATCH v2 2/2] staging: rtl8188eu: Better memory clean-up
	in efuse_phymap_to_logical()
In-Reply-To: <5463C10D.6020409@users.sourceforge.net>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <544954FD.8040607@users.sourceforge.net>
 <20141029084702.GA18675@kroah.com> <5453CD0D.9010206@users.sourceforge.net>
 <alpine.DEB.2.10.1410311900201.2481@hadrien>
 <5463C10D.6020409@users.sourceforge.net>
Message-ID: <5463C373.5050804@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 12 Nov 2014 20:40:12 +0100

Memory releases were handled in an inefficient way by the implementation of
the efuse_phymap_to_logical() function in case of an allocation failure.
The corresponding clean-up was improved by reordering of kfree() calls
and a few adjustments for jump labels.

Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 697876b..359f169 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -112,7 +112,7 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
 	if (eFuseWord == NULL) {
 		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
-		goto exit;
+		goto cleanup1;
 	}
 
 	/*  0. Refresh efuse init map as all oxFF. */
@@ -130,7 +130,7 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 		eFuse_Addr++;
 	} else {
 		DBG_88E("EFUSE is empty efuse_Addr-%d efuse_data =%x\n", eFuse_Addr, rtemp8);
-		goto exit;
+		goto cleanup2;
 	}
 
 	/*  */
@@ -209,10 +209,14 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 	/*  5. Calculate Efuse utilization. */
 	/*  */
 
-exit:
+cleanup2:
+	kfree(eFuseWord);
+
+cleanup1:
 	kfree(efuseTbl);
 
-	kfree(eFuseWord);
+exit:
+	;
 }
 
 static void efuse_read_phymap_from_txpktbuf(
-- 
2.1.3
