Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73746C02190
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Wadsy2NxJXxqQ+ZbhJ1ZiEC/4XRrTap5C0/XqtGuMu0=;
  b=MVO3vVSfkHpBFnW1mgk/lrxuOXmMMiWUaGPOvSZdm+iYMrYwEOPrVFQ/
   yNT76yOpTz12p4aivaNpvS0EAQdBccZu08rEyLtEq9ucmbWvpbon4kXMi
   xzEOQFMZ5KoTFDGP+HQ6vTSWBmVDfVc1QQRUwaYeSp7nJasMRj++ktXzq
   c=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205449931"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 09655E0D6F; Tue, 28 Jan 2025 19:22:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7E9B1E0137
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:01 +0100 (CET)
IronPort-SDR: 67992049_6K6OQgA+kDNTN6GUVOHLVaKJY2R8clRs9Eg/kvMHcm99nq3
 +IilSiGH6qNOc/Zmsu9ojqtHQf0sZK0YJPPk+PA==
X-IPAS-Result: =?us-ascii?q?A0EyAACtH5lncraaTQ1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQgMBAQELAYJDgVczBwhIhFaRcIEWimCQT4MWPg8BAwFOAQIEAQEDB?=
 =?us-ascii?q?IFMgzQCinUCHwYBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eA?=
 =?us-ascii?q?QEeAgEDERIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKiMgGHYAEBAosjfzOBA?=
 =?us-ascii?q?YIMAQEGgmfZOIFkCYEaLgGITQGBbIN/OwmDOXonG4FJRIEVNYEGgTd2hB85g?=
 =?us-ascii?q?0aCaYIzgUWDb4FsiwAdL4IpkTwJP4EFHANZLAFVEw0KCwcFZFU4AyALCwwLF?=
 =?us-ascii?q?BwVAhQdDwYQBG1EN4JHaUk3Ag0CNYIeJFiBHYEOhFyERWAvAwMDA4M4gkVUg?=
 =?us-ascii?q?kSCFHqBF4ZCHUADCxgNSBEsNwYOG0MBbgecXTyEAxZrDktblDwdEYNrjUmCH?=
 =?us-ascii?q?59PhCWhYAEyqlMuh2SQaiKoWoIuJIFcRgcjFYMiTwMZD4gAhiEMFoNYjz0Bu?=
 =?us-ascii?q?gtDNTwCBwsBAQMJhUYBAYouI4FLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Lu3AwqnOzI8qV4LFPqYjUQXI/qvpDfIW3DAbv31ZSRFFG/FwWf
 re+sjzsiWE6wr5OUtBpTjjUJPrfZq4z/NICOYqUotKMDOLhILsFvAH0WKA+Vzd8lPFh4xgPM
 5bGsAUNDSzNykesS+Q2meF+rgbsb66GdiT9J7j80s=
X-Talos-CUID: 9a23:dPo4N2y+yEUuHkcJdn5xBgVFQdg3czqByE2LMh6YDmttVKCke0OPrfY=
X-Talos-MUID: 9a23:/l40Ugjtk/WagHhaxood8sMpc+VvzbuBK2E3s9YsqvOaMAJIa3CatWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205449846"
X-MGA-submission: =?us-ascii?q?MDF5vj6obneaD+hWo7Iwa7EkzslbKnpyVCnE+T?=
 =?us-ascii?q?d5qme4FIclP3MkWP5KVwdhdDpLiqQ+EWKQJG3e+5HkcQ3wMZ7E+x2UlL?=
 =?us-ascii?q?DtezHrPWTpKQXu9dqcI+4PSvIknvPI5fx3nfO2l06EqzTS0ttpnLD0vm?=
 =?us-ascii?q?SfoXGDaBv8Jib/Z/3zQ/RVaQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:00 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id A5F412037178;
	Tue, 28 Jan 2025 10:21:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A5F412037178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088517;
	bh=Wadsy2NxJXxqQ+ZbhJ1ZiEC/4XRrTap5C0/XqtGuMu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=na5TgR7ElKwogZ/k+Z0ybAln+R1AMEzKcOKd3gVcuZRiyqr/iXkxm5sB4wdMicFT8
	 5cV0NYPUXQT7qjedQEwyZQIdf7RjebrBopNTxrugtd5gFZqW8w6LS7rzpaEmz3HAP1
	 6iPQpwjqyuRZVEMFlWOaUeR52txcp6jerxVEtbhM=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-2-9a6ecf0b2308@linux.microsoft.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 James Smart <james.smart@broadcom.com>, 
 Dick Kennedy <dick.kennedy@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, 
 Xiubo Li <xiubli@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>, 
 Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
Subject: [cocci] [PATCH 02/16] scsi: lpfc: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2274
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-2-9a6ecf0b2308%40linux.microsoft.com>

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@depends on patch@
expression E;
@@

-msecs_to_jiffies
+secs_to_jiffies
(E
- * \( 1000 \| MSEC_PER_SEC \)
)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/scsi/lpfc/lpfc_init.c  |  4 ++--
 drivers/scsi/lpfc/lpfc_scsi.c  | 12 +++++-------
 drivers/scsi/lpfc/lpfc_sli.c   | 24 +++++++++---------------
 drivers/scsi/lpfc/lpfc_vport.c |  2 +-
 4 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index bcadf11414c8a41d6fc99d03586d55c26d0a6a0f..783ba9c6a81cdc560b8c901d383c3c4d55eedbc7 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -3361,8 +3361,8 @@ lpfc_block_mgmt_io(struct lpfc_hba *phba, int mbx_action)
 		/* Determine how long we might wait for the active mailbox
 		 * command to be gracefully completed by firmware.
 		 */
-		timeout = msecs_to_jiffies(lpfc_mbox_tmo_val(phba,
-				phba->sli.mbox_active) * 1000) + jiffies;
+		timeout = secs_to_jiffies(lpfc_mbox_tmo_val(phba,
+				phba->sli.mbox_active)) + jiffies;
 	}
 	spin_unlock_irqrestore(&phba->hbalock, iflag);
 
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 055ed632c14df51376126a285df728269ca1da6c..f0158fc00f783239db615b0978b6785de064535f 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5645,9 +5645,8 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
 	 * cmd_flag is set to LPFC_DRIVER_ABORTED before we wait
 	 * for abort to complete.
 	 */
-	wait_event_timeout(waitq,
-			  (lpfc_cmd->pCmd != cmnd),
-			   msecs_to_jiffies(2*vport->cfg_devloss_tmo*1000));
+	wait_event_timeout(waitq, (lpfc_cmd->pCmd != cmnd),
+			   secs_to_jiffies(2*vport->cfg_devloss_tmo));
 
 	spin_lock(&lpfc_cmd->buf_lock);
 
@@ -5911,7 +5910,7 @@ lpfc_chk_tgt_mapped(struct lpfc_vport *vport, struct fc_rport *rport)
 	 * If target is not in a MAPPED state, delay until
 	 * target is rediscovered or devloss timeout expires.
 	 */
-	later = msecs_to_jiffies(2 * vport->cfg_devloss_tmo * 1000) + jiffies;
+	later = secs_to_jiffies(2 * vport->cfg_devloss_tmo) + jiffies;
 	while (time_after(later, jiffies)) {
 		if (!pnode)
 			return FAILED;
@@ -5957,7 +5956,7 @@ lpfc_reset_flush_io_context(struct lpfc_vport *vport, uint16_t tgt_id,
 		lpfc_sli_abort_taskmgmt(vport,
 					&phba->sli.sli3_ring[LPFC_FCP_RING],
 					tgt_id, lun_id, context);
-	later = msecs_to_jiffies(2 * vport->cfg_devloss_tmo * 1000) + jiffies;
+	later = secs_to_jiffies(2 * vport->cfg_devloss_tmo) + jiffies;
 	while (time_after(later, jiffies) && cnt) {
 		schedule_timeout_uninterruptible(msecs_to_jiffies(20));
 		cnt = lpfc_sli_sum_iocb(vport, tgt_id, lun_id, context);
@@ -6137,8 +6136,7 @@ lpfc_target_reset_handler(struct scsi_cmnd *cmnd)
 			wait_event_timeout(waitq,
 					   !test_bit(NLP_WAIT_FOR_LOGO,
 						     &pnode->save_flags),
-					   msecs_to_jiffies(dev_loss_tmo *
-							    1000));
+					   secs_to_jiffies(dev_loss_tmo));
 
 			if (test_and_clear_bit(NLP_WAIT_FOR_LOGO,
 					       &pnode->save_flags))
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 3fd9723cd271c8a024b6f34e583668e973404e6f..3ccc444c018c51f7c78a8acdb9d12ead8697fbcb 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -9504,8 +9504,7 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 			goto out_not_finished;
 		}
 		/* timeout active mbox command */
-		timeout = msecs_to_jiffies(lpfc_mbox_tmo_val(phba, pmbox) *
-					   1000);
+		timeout = secs_to_jiffies(lpfc_mbox_tmo_val(phba, pmbox));
 		mod_timer(&psli->mbox_tmo, jiffies + timeout);
 	}
 
@@ -9629,8 +9628,7 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 						       drvr_flag);
 			goto out_not_finished;
 		}
-		timeout = msecs_to_jiffies(lpfc_mbox_tmo_val(phba, pmbox) *
-							1000) + jiffies;
+		timeout = secs_to_jiffies(lpfc_mbox_tmo_val(phba, pmbox)) + jiffies;
 		i = 0;
 		/* Wait for command to complete */
 		while (((word0 & OWN_CHIP) == OWN_CHIP) ||
@@ -9756,9 +9754,8 @@ lpfc_sli4_async_mbox_block(struct lpfc_hba *phba)
 	 * command to be gracefully completed by firmware.
 	 */
 	if (phba->sli.mbox_active)
-		timeout = msecs_to_jiffies(lpfc_mbox_tmo_val(phba,
-						phba->sli.mbox_active) *
-						1000) + jiffies;
+		timeout = secs_to_jiffies(lpfc_mbox_tmo_val(phba,
+						phba->sli.mbox_active)) + jiffies;
 	spin_unlock_irq(&phba->hbalock);
 
 	/* Make sure the mailbox is really active */
@@ -9881,8 +9878,7 @@ lpfc_sli4_wait_bmbx_ready(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 		}
 	}
 
-	timeout = msecs_to_jiffies(lpfc_mbox_tmo_val(phba, mboxq)
-				   * 1000) + jiffies;
+	timeout = secs_to_jiffies(lpfc_mbox_tmo_val(phba, mboxq)) + jiffies;
 
 	do {
 		bmbx_reg.word0 = readl(phba->sli4_hba.BMBXregaddr);
@@ -13159,7 +13155,7 @@ lpfc_sli_issue_iocb_wait(struct lpfc_hba *phba,
 	retval = lpfc_sli_issue_iocb(phba, ring_number, piocb,
 				     SLI_IOCB_RET_IOCB);
 	if (retval == IOCB_SUCCESS) {
-		timeout_req = msecs_to_jiffies(timeout * 1000);
+		timeout_req = secs_to_jiffies(timeout);
 		timeleft = wait_event_timeout(done_q,
 				lpfc_chk_iocb_flg(phba, piocb, LPFC_IO_WAKE),
 				timeout_req);
@@ -13275,8 +13271,7 @@ lpfc_sli_issue_mbox_wait(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmboxq,
 	/* now issue the command */
 	retval = lpfc_sli_issue_mbox(phba, pmboxq, MBX_NOWAIT);
 	if (retval == MBX_BUSY || retval == MBX_SUCCESS) {
-		wait_for_completion_timeout(&mbox_done,
-					    msecs_to_jiffies(timeout * 1000));
+		wait_for_completion_timeout(&mbox_done, secs_to_jiffies(timeout));
 
 		spin_lock_irqsave(&phba->hbalock, flag);
 		pmboxq->ctx_u.mbox_wait = NULL;
@@ -13336,9 +13331,8 @@ lpfc_sli_mbox_sys_shutdown(struct lpfc_hba *phba, int mbx_action)
 		 * command to be gracefully completed by firmware.
 		 */
 		if (phba->sli.mbox_active)
-			timeout = msecs_to_jiffies(lpfc_mbox_tmo_val(phba,
-						phba->sli.mbox_active) *
-						1000) + jiffies;
+			timeout = secs_to_jiffies(lpfc_mbox_tmo_val(phba,
+						phba->sli.mbox_active)) + jiffies;
 		spin_unlock_irq(&phba->hbalock);
 
 		/* Enable softirqs again, done with phba->hbalock */
diff --git a/drivers/scsi/lpfc/lpfc_vport.c b/drivers/scsi/lpfc/lpfc_vport.c
index 3d70cc5175730b31eeaf46c89d65c0dc09367d44..cc56a73343195a263c307fab6870a0012899060a 100644
--- a/drivers/scsi/lpfc/lpfc_vport.c
+++ b/drivers/scsi/lpfc/lpfc_vport.c
@@ -246,7 +246,7 @@ static void lpfc_discovery_wait(struct lpfc_vport *vport)
 	 * fabric RA_TOV value and dev_loss tmo.  The driver's
 	 * devloss_tmo is 10 giving this loop a 3x multiplier minimally.
 	 */
-	wait_time_max = msecs_to_jiffies(((phba->fc_ratov * 3) + 3) * 1000);
+	wait_time_max = secs_to_jiffies((phba->fc_ratov * 3) + 3);
 	wait_time_max += jiffies;
 	start_time = jiffies;
 	while (time_before(jiffies, wait_time_max)) {

-- 
2.43.0

