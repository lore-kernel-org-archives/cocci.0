Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617A8D68BDD
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=61FzWbZx8SVE6r33ggD3SgPEq3e2wgbU4/WDXmU67Oo=;
  b=DhU+34J6og1LOwD0hi437lxkjN9wAeYFoX/UWQBovAbs67zcKtmDDnPl
   pY5PpFlLvXjieXLlqebIEtQ0s4Qlf2lXSnmcKqQWnDs39xp04PPd7leZT
   HQUI3jJivyzX+CA634giNsLVY4iUAgLnQwkTOIUqbKDx6+V6mUMVHtIYL
   k=;
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
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194169954"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 68596E0DF6; Fri, 15 Nov 2024 23:35:59 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D2F01E00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:26:47 +0100 (CET)
IronPort-SDR: 6737bc97_frHVzegRE4HVICBQ0K2rG4VktdxZ1KQdsqjuII7hKkSmxKA
 AVqEuglKc/0dssDgqDY8H+5ptMgCtp3SzqtLYbQ==
X-IPAS-Result: =?us-ascii?q?A0EgAABHuzdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHYlRi3aQTYFWgUA+DwEDAU4BAgQBAQMEgUyDN?=
 =?us-ascii?q?AKKSwIfBgEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABg?=
 =?us-ascii?q?QyFew2CYgGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BAR4CA?=
 =?us-ascii?q?QMREgQZAQE3AQ8lAiYCAkYQBgESgwGCZQYCn00Bh2ABAQKLI38zgQGCDAEBB?=
 =?us-ascii?q?oJn2TiBZAmBGi4BiEsBgWyDfTuDQnonG4FJRIFKgQaCLYRYBINCgmmCRWhNg?=
 =?us-ascii?q?mh2JYUGg3mZfgk/gQUcA1khEQFVEw0KCwcFY1c8AyJvalN6K4ELgRc6QoE7g?=
 =?us-ascii?q?RMvGyELXIEpgRoUBhUEgQ5GP4JKaUs3Ag0CNoIkJFmBHYEyhRqEbGcvAwMDA?=
 =?us-ascii?q?4M8gk5kMh1AAwsYDUgRLDUGDhtDAW4HnwRGgzRZKA5LMASBK5Neg3KNQqFrh?=
 =?us-ascii?q?CShXQEyqk4uh2SQZSKoVIIYOoFcRgcjFYMiTwMZD44hDBaDWI8+AbYeQzU7A?=
 =?us-ascii?q?gcLAQEDCYVGAQGKD4FLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:vIsTW6G6yCZ74gaPpLqE0seALOsnbusQ8zAXPo5KOHpom6uj5q
 OTdZUgtSMd6l4qMk3I/OrsBEDuexzhHPJOjbX5eI3SODUO21HIEGgd1/qB/9SIIUSXndK1l5
 0QFpSWY+efMbEVt7ec3ODBKadY/OW6
X-Talos-CUID: =?us-ascii?q?9a23=3A1ikp0mpYtRROnAnDmVPzEcDmUcskXXfy7U32H2u?=
 =?us-ascii?q?5K0ExWvrKUFi60qwxxg=3D=3D?=
X-Talos-MUID: 9a23:KS2FOwlQ7PrTxGVd/khVdno6MsQv6YSQLnsXsrU7sZi0LRZoMiWk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101771130"
X-MGA-submission: =?us-ascii?q?MDGldW7ZuWO7O/BDL5NTjjYN8QhflEuGO9smGR?=
 =?us-ascii?q?wWG/hcutxUifTA3JVxzuzZ5H9BLO6L1DLtUxR6Wp4e7GEB8qiNac1qM1?=
 =?us-ascii?q?SCXJ1b4C/fvfew7H8lu2dReZ0zlPPg6NwZFiasS4mRxdgsKXFBXCMpye?=
 =?us-ascii?q?y2dAEN3OqNPp4ftxaVbKvAlg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:26:47 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 499B0206BCFF;
	Fri, 15 Nov 2024 13:26:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 499B0206BCFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706003;
	bh=61FzWbZx8SVE6r33ggD3SgPEq3e2wgbU4/WDXmU67Oo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=og1s1yT3C7qmGwpXC7BTRjelEYUxv+y/wT3aVo0+4J69TYgfP6zEFIO0yD8KBx7t/
	 92Gtaxjx6bIrpJr767qFI9u3x1d6CtqjQKQq/ajvUlvLNnm+zvVjUogpR6HNP56Qc4
	 chNj7CUafA0bTcDqKth0w7CAJ55sYrNQyLSK+jvY=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:26:27 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v2-10-911fb7595e79@linux.microsoft.com>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, 
 Oded Gabbay <ogabbay@kernel.org>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 James Smart <james.smart@broadcom.com>, 
 Dick Kennedy <dick.kennedy@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jack Wang <jinpu.wang@cloud.ionos.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Louis Peens <louis.peens@corigine.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, cocci@inria.fr, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, linux-mm@kvack.org, 
 linux-bluetooth@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, 
 live-patching@vger.kernel.org, linux-sound@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, oss-drivers@corigine.com, 
 linuxppc-dev@lists.ozlabs.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2 10/21] scsi: lpfc: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2037
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v2-10-911fb7595e79%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/scsi/lpfc/lpfc_init.c      | 18 +++++++++---------
 drivers/scsi/lpfc/lpfc_nportdisc.c |  8 ++++----
 drivers/scsi/lpfc/lpfc_nvme.c      |  2 +-
 drivers/scsi/lpfc/lpfc_sli.c       |  4 ++--
 drivers/scsi/lpfc/lpfc_vmid.c      |  2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 0dd451009b07914450dc70f2c981b690557c1d8c..12666c4c7986ae0bdfaa5c8f040b4ea0be64550d 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -598,7 +598,7 @@ lpfc_config_port_post(struct lpfc_hba *phba)
 		  jiffies + msecs_to_jiffies(1000 * timeout));
 	/* Set up heart beat (HB) timer */
 	mod_timer(&phba->hb_tmofunc,
-		  jiffies + msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL));
+		  jiffies + secs_to_jiffies(LPFC_HB_MBOX_INTERVAL));
 	clear_bit(HBA_HBEAT_INP, &phba->hba_flag);
 	clear_bit(HBA_HBEAT_TMO, &phba->hba_flag);
 	phba->last_completion_time = jiffies;
@@ -1267,7 +1267,7 @@ lpfc_hb_mbox_cmpl(struct lpfc_hba * phba, LPFC_MBOXQ_t * pmboxq)
 	    !test_bit(FC_UNLOADING, &phba->pport->load_flag))
 		mod_timer(&phba->hb_tmofunc,
 			  jiffies +
-			  msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL));
+			  secs_to_jiffies(LPFC_HB_MBOX_INTERVAL));
 	return;
 }
 
@@ -1555,7 +1555,7 @@ lpfc_hb_timeout_handler(struct lpfc_hba *phba)
 		/* If IOs are completing, no need to issue a MBX_HEARTBEAT */
 		spin_lock_irq(&phba->pport->work_port_lock);
 		if (time_after(phba->last_completion_time +
-				msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL),
+				secs_to_jiffies(LPFC_HB_MBOX_INTERVAL),
 				jiffies)) {
 			spin_unlock_irq(&phba->pport->work_port_lock);
 			if (test_bit(HBA_HBEAT_INP, &phba->hba_flag))
@@ -3352,7 +3352,7 @@ lpfc_block_mgmt_io(struct lpfc_hba *phba, int mbx_action)
 	spin_unlock_irqrestore(&phba->hbalock, iflag);
 	if (mbx_action == LPFC_MBX_NO_WAIT)
 		return;
-	timeout = msecs_to_jiffies(LPFC_MBOX_TMO * 1000) + jiffies;
+	timeout = secs_to_jiffies(LPFC_MBOX_TMO) + jiffies;
 	spin_lock_irqsave(&phba->hbalock, iflag);
 	if (phba->sli.mbox_active) {
 		actcmd = phba->sli.mbox_active->u.mb.mbxCommand;
@@ -4939,14 +4939,14 @@ int lpfc_scan_finished(struct Scsi_Host *shost, unsigned long time)
 		stat = 1;
 		goto finished;
 	}
-	if (time >= msecs_to_jiffies(30 * 1000)) {
+	if (time >= secs_to_jiffies(30)) {
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 				"0461 Scanning longer than 30 "
 				"seconds.  Continuing initialization\n");
 		stat = 1;
 		goto finished;
 	}
-	if (time >= msecs_to_jiffies(15 * 1000) &&
+	if (time >= secs_to_jiffies(15) &&
 	    phba->link_state <= LPFC_LINK_DOWN) {
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 				"0465 Link down longer than 15 "
@@ -4960,7 +4960,7 @@ int lpfc_scan_finished(struct Scsi_Host *shost, unsigned long time)
 	if (vport->num_disc_nodes || vport->fc_prli_sent)
 		goto finished;
 	if (!atomic_read(&vport->fc_map_cnt) &&
-	    time < msecs_to_jiffies(2 * 1000))
+	    time < secs_to_jiffies(2))
 		goto finished;
 	if ((phba->sli.sli_flag & LPFC_SLI_MBOX_ACTIVE) != 0)
 		goto finished;
@@ -5194,8 +5194,8 @@ lpfc_vmid_poll(struct timer_list *t)
 		lpfc_worker_wake_up(phba);
 
 	/* restart the timer for the next iteration */
-	mod_timer(&phba->inactive_vmid_poll, jiffies + msecs_to_jiffies(1000 *
-							LPFC_VMID_TIMER));
+	mod_timer(&phba->inactive_vmid_poll,
+		  jiffies + secs_to_jiffies(LPFC_VMID_TIMER));
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 4574716c8764fba6d6db103f1f287b7cdb87cebc..4185717f35defbde483b4ff9b1d71c9c3d86a07d 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -914,7 +914,7 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		    (ndlp->nlp_state >= NLP_STE_ADISC_ISSUE ||
 		     ndlp->nlp_state <= NLP_STE_PRLI_ISSUE)) {
 			mod_timer(&ndlp->nlp_delayfunc,
-				  jiffies + msecs_to_jiffies(1000 * 1));
+				  jiffies + secs_to_jiffies(1));
 			spin_lock_irq(&ndlp->lock);
 			ndlp->nlp_flag |= NLP_DELAY_TMO;
 			spin_unlock_irq(&ndlp->lock);
@@ -1355,7 +1355,7 @@ lpfc_rcv_els_plogi_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	}
 
 	/* Put ndlp in npr state set plogi timer for 1 sec */
-	mod_timer(&ndlp->nlp_delayfunc, jiffies + msecs_to_jiffies(1000 * 1));
+	mod_timer(&ndlp->nlp_delayfunc, jiffies + secs_to_jiffies(1));
 	spin_lock_irq(&ndlp->lock);
 	ndlp->nlp_flag |= NLP_DELAY_TMO;
 	spin_unlock_irq(&ndlp->lock);
@@ -1975,7 +1975,7 @@ lpfc_cmpl_reglogin_reglogin_issue(struct lpfc_vport *vport,
 
 		/* Put ndlp in npr state set plogi timer for 1 sec */
 		mod_timer(&ndlp->nlp_delayfunc,
-			  jiffies + msecs_to_jiffies(1000 * 1));
+			  jiffies + secs_to_jiffies(1));
 		spin_lock_irq(&ndlp->lock);
 		ndlp->nlp_flag |= NLP_DELAY_TMO;
 		spin_unlock_irq(&ndlp->lock);
@@ -2798,7 +2798,7 @@ lpfc_rcv_prlo_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	if ((ndlp->nlp_flag & NLP_DELAY_TMO) == 0) {
 		mod_timer(&ndlp->nlp_delayfunc,
-			  jiffies + msecs_to_jiffies(1000 * 1));
+			  jiffies + secs_to_jiffies(1));
 		spin_lock_irq(&ndlp->lock);
 		ndlp->nlp_flag |= NLP_DELAY_TMO;
 		ndlp->nlp_flag &= ~NLP_NPR_ADISC;
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index fec23c7237304b471e58194726ff7932b0010385..64d7060e0d4cb628c74c0fa22ece2b956155c1ba 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2236,7 +2236,7 @@ lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
 	 * wait. Print a message if a 10 second wait expires and renew the
 	 * wait. This is unexpected.
 	 */
-	wait_tmo = msecs_to_jiffies(LPFC_NVME_WAIT_TMO * 1000);
+	wait_tmo = secs_to_jiffies(LPFC_NVME_WAIT_TMO);
 	while (true) {
 		ret = wait_for_completion_timeout(lport_unreg_cmp, wait_tmo);
 		if (unlikely(!ret)) {
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 2ec6e55771b45ab70320a9ad1934d5ead2371d4c..b6f19c123e25a00c0eb4444476a7194d6b045824 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -9024,7 +9024,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 
 	/* Start heart beat timer */
 	mod_timer(&phba->hb_tmofunc,
-		  jiffies + msecs_to_jiffies(1000 * LPFC_HB_MBOX_INTERVAL));
+		  jiffies + secs_to_jiffies(LPFC_HB_MBOX_INTERVAL));
 	clear_bit(HBA_HBEAT_INP, &phba->hba_flag);
 	clear_bit(HBA_HBEAT_TMO, &phba->hba_flag);
 	phba->last_completion_time = jiffies;
@@ -13335,7 +13335,7 @@ lpfc_sli_mbox_sys_shutdown(struct lpfc_hba *phba, int mbx_action)
 		lpfc_sli_mbox_sys_flush(phba);
 		return;
 	}
-	timeout = msecs_to_jiffies(LPFC_MBOX_TMO * 1000) + jiffies;
+	timeout = secs_to_jiffies(LPFC_MBOX_TMO) + jiffies;
 
 	/* Disable softirqs, including timers from obtaining phba->hbalock */
 	local_bh_disable();
diff --git a/drivers/scsi/lpfc/lpfc_vmid.c b/drivers/scsi/lpfc/lpfc_vmid.c
index cc3e4736f2fe29e1fd4afe221c9c7c40ecf382d4..14dbfe954e423acc47d1b1c80160ff193783f500 100644
--- a/drivers/scsi/lpfc/lpfc_vmid.c
+++ b/drivers/scsi/lpfc/lpfc_vmid.c
@@ -278,7 +278,7 @@ int lpfc_vmid_get_appid(struct lpfc_vport *vport, char *uuid,
 		if (!(vport->phba->pport->vmid_flag & LPFC_VMID_TIMER_ENBLD)) {
 			mod_timer(&vport->phba->inactive_vmid_poll,
 				  jiffies +
-				  msecs_to_jiffies(1000 * LPFC_VMID_TIMER));
+				  secs_to_jiffies(LPFC_VMID_TIMER));
 			vport->phba->pport->vmid_flag |= LPFC_VMID_TIMER_ENBLD;
 		}
 	}

-- 
2.34.1

