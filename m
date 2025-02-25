Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850B1C021B2
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KYPN268bDbdUIUQETKGlB40kZ2e2KCK68/xpxhMiE60=;
  b=C6wdWEEGmBQECrOhLzfIyBVO/uM52EkKjLhqPqPEgCfA0pftYhw5TEpp
   g1u5Uk+ZkTkMq4f2oyk7bK5LoxLpl/otzlG01aIkeIipd3bTv3rlJBxdE
   GQkSjwSLelbVstljCzBpPTJwg4oT2+gCefvCYT7yUiC1BJiaJZZeqWu82
   s=;
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
   d="scan'208";a="210043733"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 39720E0D25; Tue, 25 Feb 2025 21:28:02 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 72C8EE0264
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:24 +0100 (CET)
IronPort-SDR: 67be2553_BsPHfj+/BK8jrJVABiA8xfqBBkFwOOnobjc3O5ujeWLUZHs
 Tccq0nKW1NBQQu9TUsWEZgI8zb6PHSC8T6G7WdA==
X-IPAS-Result: =?us-ascii?q?A0EDAACfJL5ncraaTQ1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBwhIhFaIHYlTFotgkEuBVhSBLD4PA?=
 =?us-ascii?q?QMBTgECBAEBAwSFAAKLEgIfBgEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABgQyFew2CYgGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARECDV4BAR4CAQMREgQZAQE3AQ8ZDAImAgJGEAYBEoMCgmUGAp0tAYdgA?=
 =?us-ascii?q?QECiyN/M4EBggwBAQaCaNk4gWUJgRouAYhOAYFsg387CYM5eicbgUlEgUqBB?=
 =?us-ascii?q?oIthCoug0aCaYIzgUCDbKdhCT+BBRwDWSwBVRMNCgsHBWRVOAMgCgsMCxIcF?=
 =?us-ascii?q?QIUHQ8GEARqQzeCRWlJOgINAjWCHiRYgR2BDoRUhENcLwMDAwODKoI/UYJCg?=
 =?us-ascii?q?hFxgRqJMoNjHUADCxgNSBEsNwYOG0MBbgegJTyEO4EOAX8nlD2EGo1LoW+EJ?=
 =?us-ascii?q?aFiATKqVS6HZZBqIqhdghg6gVxGByMVgyJPAxkPiACGIQwWg1iPPQG8NUM1P?=
 =?us-ascii?q?AIHCwEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 f0=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:02+szqzYDr7DzMD8V4unKrPwFr1zdoMgy1knxilNoNJuA6qlfq
 eV7ZcmPH7P6Ar4Ohkb8+xoXZPsfZqyz/FICOUqUYtKGTOW3FdAT7sC0WKd+UyDJ8SWzIc0vp
 uIMZIObeEYZmIVsS+V2njeLz9Z+qj/zJyV
X-Talos-CUID: =?us-ascii?q?9a23=3A3u5YH2vBtSEXubUHG+Myc0FV6IsOQHKCyXbwCXa?=
 =?us-ascii?q?pECEwTbiVdgCp951Nxp8=3D?=
X-Talos-MUID: 9a23:xtS4cgZz5APBNOBTjDLwpS5HCZ5T4q30Gms1g6ktmpCWDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="110053378"
X-MGA-submission: =?us-ascii?q?MDH8bQGpgyiYckW5kg/uMhCvSctWPrfqzhTjpI?=
 =?us-ascii?q?UugkDbZjucjMi4MHBYQxrK3nVbNesHU2qwLQG3+SovKSBCCz6hY9QweZ?=
 =?us-ascii?q?E30ZiIqEPBjst6+qE50dv3/PN8AA62yTmsg3SftEChRqEV45t/nsBPfx?=
 =?us-ascii?q?JWPEiXADmExPdOLhwTj705XA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 25 Feb 2025 21:17:23 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1F342203CDFF;
	Tue, 25 Feb 2025 12:17:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F342203CDFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514640;
	bh=KYPN268bDbdUIUQETKGlB40kZ2e2KCK68/xpxhMiE60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e42hykosxujhPhv78giqAldREjaCd3tOogFdPdzoqAYHeLsN/ZNksfZFwl/WtAZQB
	 XiF+xYeoTrVtF5AAhyZwWPDpveaqk+oc2J+05Jy4aLPcUnA1GUi/8dla7xvl3N8/O7
	 MmnJD7+9WUmiZmh++Xb1njp/a3RFDwYsLoo+1ke4=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-3-a43967e36c88@linux.microsoft.com>
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
Subject: [cocci] [PATCH v3 03/16] accel/habanalabs: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2434
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-3-a43967e36c88%40linux.microsoft.com>

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication

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
 drivers/accel/habanalabs/common/command_submission.c | 2 +-
 drivers/accel/habanalabs/common/debugfs.c            | 2 +-
 drivers/accel/habanalabs/common/device.c             | 2 +-
 drivers/accel/habanalabs/common/habanalabs_drv.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
index 59823e3c3bf7a4fafc0b112fd7b4b2209149973c..dee487724918554c24c3e78df4e8715dd1c73acd 100644
--- a/drivers/accel/habanalabs/common/command_submission.c
+++ b/drivers/accel/habanalabs/common/command_submission.c
@@ -2586,7 +2586,7 @@ int hl_cs_ioctl(struct drm_device *ddev, void *data, struct drm_file *file_priv)
 		cs_seq = args->in.seq;
 
 	timeout = flags & HL_CS_FLAGS_CUSTOM_TIMEOUT
-			? msecs_to_jiffies(args->in.timeout * 1000)
+			? secs_to_jiffies(args->in.timeout)
 			: hpriv->hdev->timeout_jiffies;
 
 	switch (cs_type) {
diff --git a/drivers/accel/habanalabs/common/debugfs.c b/drivers/accel/habanalabs/common/debugfs.c
index ca7677293a55822f703a3a1cbf947c4c44fdc569..4b391807e5f2e2a2570a38b9dfdf6be4299dbfb6 100644
--- a/drivers/accel/habanalabs/common/debugfs.c
+++ b/drivers/accel/habanalabs/common/debugfs.c
@@ -1403,7 +1403,7 @@ static ssize_t hl_timeout_locked_write(struct file *f, const char __user *buf,
 		return rc;
 
 	if (value)
-		hdev->timeout_jiffies = msecs_to_jiffies(value * 1000);
+		hdev->timeout_jiffies = secs_to_jiffies(value);
 	else
 		hdev->timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
 
diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 30277ae410d4b742ffb7bddc35498564ff96fe62..68eebed3b050f72f81e55b86da869b56b4cdeadf 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2091,7 +2091,7 @@ int hl_device_cond_reset(struct hl_device *hdev, u32 flags, u64 event_mask)
 	dev_dbg(hdev->dev, "Device is going to be hard-reset in %u sec unless being released\n",
 		hdev->device_release_watchdog_timeout_sec);
 	schedule_delayed_work(&hdev->device_release_watchdog_work.reset_work,
-				msecs_to_jiffies(hdev->device_release_watchdog_timeout_sec * 1000));
+				secs_to_jiffies(hdev->device_release_watchdog_timeout_sec));
 	hdev->reset_info.watchdog_active = 1;
 out:
 	spin_unlock(&hdev->reset_info.lock);
diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index 596c52e8aa266bf48e2be45e719adb202604577b..0035748f3228246da235f227b2cf3939d64af350 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -386,7 +386,7 @@ static int fixup_device_params(struct hl_device *hdev)
 	hdev->fw_comms_poll_interval_usec = HL_FW_STATUS_POLL_INTERVAL_USEC;
 
 	if (tmp_timeout)
-		hdev->timeout_jiffies = msecs_to_jiffies(tmp_timeout * MSEC_PER_SEC);
+		hdev->timeout_jiffies = secs_to_jiffies(tmp_timeout);
 	else
 		hdev->timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
 

-- 
2.43.0

