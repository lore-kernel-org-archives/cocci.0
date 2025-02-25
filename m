Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534D3C021B8
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=82bbL98koRjJtuIS1TH+R5Xiyl6+1C/th2kMl65xMM8=;
  b=qjfRILit9VLQADTkML8u1pC6B+EY5uHT6aLb76zkqPXa8wJwwTJz5nEg
   EztOU5CS2NUHgrFQpVnmhoPNNnyoSX0g5XySpBdGWINENW24O4C9XsOKr
   a+KldtjLpBVJ3fAa3VWANybAepC2PTndeUKsFaAZ31tjzoo1nkZmWp0Iu
   M=;
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
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210043884"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1F153E0D87; Tue, 25 Feb 2025 21:28:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A160FE0D1F
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:24 +0100 (CET)
IronPort-SDR: 67be2553_jKBUkeS2c7GsDcjt1CrJ2GNkAzu4lEEDUL+QrxXmdAM45lC
 Dgyd1NCus4+k2tMFTjJN58J280+W05lY5hpinJQ==
X-IPAS-Result: =?us-ascii?q?A0EDAACfJL5ncraaTQ1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBwhIhFaIHYlTFoEAimCQS4FWgUA+D?=
 =?us-ascii?q?wEDAU4BAgQBAQMEhQACixICHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQERAg1eAQEeAgEDERIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKdLQGHY?=
 =?us-ascii?q?AEBAosjfzOBAYIMAQEGgmjZOIFlCYEaLgGITgGBbIN/OwmDOXonG4FJRIEVN?=
 =?us-ascii?q?YEGgTd2hB85g0aCaYIzgUCDbIFsilwcLYIlji+JfAk/gQUcA1ksAVUTDQoLB?=
 =?us-ascii?q?wVkVTgDIAoLDAsSHBUCFB0PBhAEakM3gkVpSToCDQI1gh4kWIEdgQ6EVIRDX?=
 =?us-ascii?q?C8DAwMDgyqCP1GCQoIRcYEaiTKDYx1AAwsYDUgRLDcGDhtDAW4HoCU8hDsWZ?=
 =?us-ascii?q?QYOSzArCi8wNY1qhTUdEYNsjUuCIJ9PhCWaRoccATKqVS6HZZBqIqhdghg6g?=
 =?us-ascii?q?VxGByMVO4JnTwMZD4gAhiEMFoNYjz0BvDVDNTwCBwsBAQMJhUYBAYoxI2phA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 5mGlg==
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:OWJesqpVqbV1vTXz7+XyzOQaV5oReYIsimQD101hICG9vPbo8f
 xG+85rtiMc6QxwZJlD8errBEDkex7hHPFOjrX5UY3PYOCighrNEGgA1+rfKkPbak/DH4dmvM
 8KT0E9MqyUMbEQt6jHCWeDYrEdKaG8gdmVuds=
X-Talos-CUID: =?us-ascii?q?9a23=3Ay5AvfWr4Ts/2sW0e8zZWr27mUccHQE2CknOTGmn?=
 =?us-ascii?q?iWCVDE5euCg+fpKwxxg=3D=3D?=
X-Talos-MUID: 9a23:Jcl4iQlwUV/GkBwhQFWQdnpcJeB1vJv3AXoKuroUuM3HbTcpMmuS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="110053380"
X-MGA-submission: =?us-ascii?q?MDEUpPgk253ah7JcbYWKXLC1ObFdVJ6Xfv+52f?=
 =?us-ascii?q?nRuSPtS+LodaK/Oc52gW5Czb2swUVNdPTU7th6w9tVNKaz1o6uVOWhXF?=
 =?us-ascii?q?V6glVVUBuN4cdcfc3Kr6Uvp94mQJEqO8gK9mFCZLux7VyB3rXn71jll9?=
 =?us-ascii?q?1a4TPqv5fWzsmULDxkrLZ7vw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 25 Feb 2025 21:17:22 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id E9C07203CDFE;
	Tue, 25 Feb 2025 12:17:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E9C07203CDFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514640;
	bh=82bbL98koRjJtuIS1TH+R5Xiyl6+1C/th2kMl65xMM8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r05ca4cLifQi9AJpcKwbPKAtGAH4LLN3RKKC/UO02jSsEcA3F49YHSL1tcdeVrcpX
	 Xl/GrhrLQaulqN5p+IjcMId3V8cAq29YFvNcsnN3fNWQtUOcBvGau6S0eXWPFSzCIL
	 2DWyU92SubkawHOG3U4SXmQg4lK5beWWFTwnPE80=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-2-a43967e36c88@linux.microsoft.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
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
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3 02/16] scsi: lpfc: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2436
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-2-a43967e36c88%40linux.microsoft.com>

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@depends on patch@
expression E;
@@

-msecs_to_jiffies(E * 1000)
+secs_to_jiffies(E)

-msecs_to_jiffies(E * MSEC_PER_SEC)
+secs_to_jiffies(E)

While here, convert some timeouts that are denominated in seconds
manually.

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/scsi/lpfc/lpfc.h         |  3 +--
 drivers/scsi/lpfc/lpfc_els.c     | 11 +++++------
 drivers/scsi/lpfc/lpfc_hbadisc.c |  2 +-
 drivers/scsi/lpfc/lpfc_init.c    | 10 +++++-----
 drivers/scsi/lpfc/lpfc_scsi.c    | 12 +++++-------
 drivers/scsi/lpfc/lpfc_sli.c     | 41 ++++++++++++++++------------------------
 drivers/scsi/lpfc/lpfc_vport.c   |  2 +-
 7 files changed, 34 insertions(+), 47 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 62438e84e52a3bf93aff6adf6c6fbbb61e3f1e3f..fe4fb67eb50c9b773d0fc0066b705024513faea4 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -74,8 +74,7 @@ struct lpfc_sli2_slim;
  * queue depths when there are driver resource error or Firmware
  * resource error.
  */
-/* 1 Second */
-#define QUEUE_RAMP_DOWN_INTERVAL	(msecs_to_jiffies(1000 * 1))
+#define QUEUE_RAMP_DOWN_INTERVAL	(secs_to_jiffies(1))
 
 /* Number of exchanges reserved for discovery to complete */
 #define LPFC_DISC_IOCB_BUFF_COUNT 20
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 9ab2e98cf69336c8f6a0ceca3870cbecb6c77ef2..e08b48b1b655c2e145b30261bbdcb9a57d40e19e 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -8045,8 +8045,7 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 			if (test_bit(FC_DISC_TMO, &vport->fc_flag)) {
 				tmo = ((phba->fc_ratov * 3) + 3);
 				mod_timer(&vport->fc_disctmo,
-					  jiffies +
-					  msecs_to_jiffies(1000 * tmo));
+					  jiffies + secs_to_jiffies(tmo));
 			}
 			return 0;
 		}
@@ -8081,7 +8080,7 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 		if (test_bit(FC_DISC_TMO, &vport->fc_flag)) {
 			tmo = ((phba->fc_ratov * 3) + 3);
 			mod_timer(&vport->fc_disctmo,
-				  jiffies + msecs_to_jiffies(1000 * tmo));
+				  jiffies + secs_to_jiffies(tmo));
 		}
 		if ((rscn_cnt < FC_MAX_HOLD_RSCN) &&
 		    !test_bit(FC_RSCN_DISCOVERY, &vport->fc_flag)) {
@@ -9511,7 +9510,7 @@ lpfc_els_timeout_handler(struct lpfc_vport *vport)
 	if (!list_empty(&pring->txcmplq))
 		if (!test_bit(FC_UNLOADING, &phba->pport->load_flag))
 			mod_timer(&vport->els_tmofunc,
-				  jiffies + msecs_to_jiffies(1000 * timeout));
+				  jiffies + secs_to_jiffies(timeout));
 }
 
 /**
@@ -10897,7 +10896,7 @@ lpfc_do_scr_ns_plogi(struct lpfc_hba *phba, struct lpfc_vport *vport)
 				 "3334 Delay fc port discovery for %d secs\n",
 				 phba->fc_ratov);
 		mod_timer(&vport->delayed_disc_tmo,
-			jiffies + msecs_to_jiffies(1000 * phba->fc_ratov));
+			jiffies + secs_to_jiffies(phba->fc_ratov));
 		return;
 	}
 
@@ -11154,7 +11153,7 @@ lpfc_retry_pport_discovery(struct lpfc_hba *phba)
 	if (!ndlp)
 		return;
 
-	mod_timer(&ndlp->nlp_delayfunc, jiffies + msecs_to_jiffies(1000));
+	mod_timer(&ndlp->nlp_delayfunc, jiffies + secs_to_jiffies(1));
 	set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 	ndlp->nlp_last_elscmd = ELS_CMD_FLOGI;
 	phba->pport->port_state = LPFC_FLOGI;
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index a2fd74cf86036ef134ec6959c90aada8a0218294..18c0365ca30563530189ca5eda7b9c8901398c82 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -4979,7 +4979,7 @@ lpfc_set_disctmo(struct lpfc_vport *vport)
 			tmo, vport->port_state, vport->fc_flag);
 	}
 
-	mod_timer(&vport->fc_disctmo, jiffies + msecs_to_jiffies(1000 * tmo));
+	mod_timer(&vport->fc_disctmo, jiffies + secs_to_jiffies(tmo));
 	set_bit(FC_DISC_TMO, &vport->fc_flag);
 
 	/* Start Discovery Timer state <hba_state> */
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index e1add109017b95fc87d024beb477ee424ea39df4..7238608ca49f9bcfc4d43acd6f400b12f2865589 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -595,7 +595,7 @@ lpfc_config_port_post(struct lpfc_hba *phba)
 	/* Set up ring-0 (ELS) timer */
 	timeout = phba->fc_ratov * 2;
 	mod_timer(&vport->els_tmofunc,
-		  jiffies + msecs_to_jiffies(1000 * timeout));
+		  jiffies + secs_to_jiffies(timeout));
 	/* Set up heart beat (HB) timer */
 	mod_timer(&phba->hb_tmofunc,
 		  jiffies + secs_to_jiffies(LPFC_HB_MBOX_INTERVAL));
@@ -604,7 +604,7 @@ lpfc_config_port_post(struct lpfc_hba *phba)
 	phba->last_completion_time = jiffies;
 	/* Set up error attention (ERATT) polling timer */
 	mod_timer(&phba->eratt_poll,
-		  jiffies + msecs_to_jiffies(1000 * phba->eratt_poll_interval));
+		  jiffies + secs_to_jiffies(phba->eratt_poll_interval));
 
 	if (test_bit(LINK_DISABLED, &phba->hba_flag)) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
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
 
@@ -6909,7 +6909,7 @@ lpfc_sli4_async_fip_evt(struct lpfc_hba *phba,
 			 * re-instantiate the Vlink using FDISC.
 			 */
 			mod_timer(&ndlp->nlp_delayfunc,
-				  jiffies + msecs_to_jiffies(1000));
+				  jiffies + secs_to_jiffies(1));
 			set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 			ndlp->nlp_last_elscmd = ELS_CMD_FDISC;
 			vport->port_state = LPFC_FDISC;
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
index 3fd9723cd271c8a024b6f34e583668e973404e6f..531fd47cda5ca6985bfb510c44888ed6d7121853 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -1025,7 +1025,7 @@ lpfc_handle_rrq_active(struct lpfc_hba *phba)
 	LIST_HEAD(send_rrq);
 
 	clear_bit(HBA_RRQ_ACTIVE, &phba->hba_flag);
-	next_time = jiffies + msecs_to_jiffies(1000 * (phba->fc_ratov + 1));
+	next_time = jiffies + secs_to_jiffies(phba->fc_ratov + 1);
 	spin_lock_irqsave(&phba->rrq_list_lock, iflags);
 	list_for_each_entry_safe(rrq, nextrrq,
 				 &phba->active_rrq_list, list) {
@@ -1208,8 +1208,7 @@ lpfc_set_rrq_active(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 	else
 		rrq->send_rrq = 0;
 	rrq->xritag = xritag;
-	rrq->rrq_stop_time = jiffies +
-				msecs_to_jiffies(1000 * (phba->fc_ratov + 1));
+	rrq->rrq_stop_time = jiffies + secs_to_jiffies(phba->fc_ratov + 1);
 	rrq->nlp_DID = ndlp->nlp_DID;
 	rrq->vport = ndlp->vport;
 	rrq->rxid = rxid;
@@ -1736,8 +1735,7 @@ lpfc_sli_ringtxcmpl_put(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		BUG_ON(!piocb->vport);
 		if (!test_bit(FC_UNLOADING, &piocb->vport->load_flag))
 			mod_timer(&piocb->vport->els_tmofunc,
-				  jiffies +
-				  msecs_to_jiffies(1000 * (phba->fc_ratov << 1)));
+				  jiffies + secs_to_jiffies(phba->fc_ratov << 1));
 	}
 
 	return 0;
@@ -3956,8 +3954,7 @@ void lpfc_poll_eratt(struct timer_list *t)
 	else
 		/* Restart the timer for next eratt poll */
 		mod_timer(&phba->eratt_poll,
-			  jiffies +
-			  msecs_to_jiffies(1000 * phba->eratt_poll_interval));
+			  jiffies + secs_to_jiffies(phba->eratt_poll_interval);
 	return;
 }
 
@@ -9008,7 +9005,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 
 	/* Start the ELS watchdog timer */
 	mod_timer(&vport->els_tmofunc,
-		  jiffies + msecs_to_jiffies(1000 * (phba->fc_ratov * 2)));
+			jiffies + secs_to_jiffies(phba->fc_ratov * 2));
 
 	/* Start heart beat timer */
 	mod_timer(&phba->hb_tmofunc,
@@ -9027,7 +9024,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 
 	/* Start error attention (ERATT) polling timer */
 	mod_timer(&phba->eratt_poll,
-		  jiffies + msecs_to_jiffies(1000 * phba->eratt_poll_interval));
+		  jiffies + secs_to_jiffies(phba->eratt_poll_interval));
 
 	/*
 	 * The port is ready, set the host's link state to LINK_DOWN
@@ -9504,8 +9501,7 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 			goto out_not_finished;
 		}
 		/* timeout active mbox command */
-		timeout = msecs_to_jiffies(lpfc_mbox_tmo_val(phba, pmbox) *
-					   1000);
+		timeout = secs_to_jiffies(lpfc_mbox_tmo_val(phba, pmbox));
 		mod_timer(&psli->mbox_tmo, jiffies + timeout);
 	}
 
@@ -9629,8 +9625,7 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 						       drvr_flag);
 			goto out_not_finished;
 		}
-		timeout = msecs_to_jiffies(lpfc_mbox_tmo_val(phba, pmbox) *
-							1000) + jiffies;
+		timeout = secs_to_jiffies(lpfc_mbox_tmo_val(phba, pmbox)) + jiffies;
 		i = 0;
 		/* Wait for command to complete */
 		while (((word0 & OWN_CHIP) == OWN_CHIP) ||
@@ -9756,9 +9751,8 @@ lpfc_sli4_async_mbox_block(struct lpfc_hba *phba)
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
@@ -9881,8 +9875,7 @@ lpfc_sli4_wait_bmbx_ready(struct lpfc_hba *phba, LPFC_MBOXQ_t *mboxq)
 		}
 	}
 
-	timeout = msecs_to_jiffies(lpfc_mbox_tmo_val(phba, mboxq)
-				   * 1000) + jiffies;
+	timeout = secs_to_jiffies(lpfc_mbox_tmo_val(phba, mboxq)) + jiffies;
 
 	do {
 		bmbx_reg.word0 = readl(phba->sli4_hba.BMBXregaddr);
@@ -10230,7 +10223,7 @@ lpfc_sli4_post_async_mbox(struct lpfc_hba *phba)
 
 	/* Start timer for the mbox_tmo and log some mailbox post messages */
 	mod_timer(&psli->mbox_tmo, (jiffies +
-		  msecs_to_jiffies(1000 * lpfc_mbox_tmo_val(phba, mboxq))));
+		  secs_to_jiffies(lpfc_mbox_tmo_val(phba, mboxq))));
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_MBOX | LOG_SLI,
 			"(%d):0355 Mailbox cmd x%x (x%x/x%x) issue Data: "
@@ -13159,7 +13152,7 @@ lpfc_sli_issue_iocb_wait(struct lpfc_hba *phba,
 	retval = lpfc_sli_issue_iocb(phba, ring_number, piocb,
 				     SLI_IOCB_RET_IOCB);
 	if (retval == IOCB_SUCCESS) {
-		timeout_req = msecs_to_jiffies(timeout * 1000);
+		timeout_req = secs_to_jiffies(timeout);
 		timeleft = wait_event_timeout(done_q,
 				lpfc_chk_iocb_flg(phba, piocb, LPFC_IO_WAKE),
 				timeout_req);
@@ -13275,8 +13268,7 @@ lpfc_sli_issue_mbox_wait(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmboxq,
 	/* now issue the command */
 	retval = lpfc_sli_issue_mbox(phba, pmboxq, MBX_NOWAIT);
 	if (retval == MBX_BUSY || retval == MBX_SUCCESS) {
-		wait_for_completion_timeout(&mbox_done,
-					    msecs_to_jiffies(timeout * 1000));
+		wait_for_completion_timeout(&mbox_done, secs_to_jiffies(timeout));
 
 		spin_lock_irqsave(&phba->hbalock, flag);
 		pmboxq->ctx_u.mbox_wait = NULL;
@@ -13336,9 +13328,8 @@ lpfc_sli_mbox_sys_shutdown(struct lpfc_hba *phba, int mbx_action)
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

