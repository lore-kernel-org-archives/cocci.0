Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A583EC02195
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NnK20PmZCF3Ily6Bk4PfjyKx9tsw9Ltz3kRT5x7zGKM=;
  b=u8WbdiUzZ6IPkby2DR4q+HWH46KuqMZkPVgCofCVEXDcKfWVbnux50bm
   f1hQIyc9imwD5niVtN5hz9TQj1eVdJMa7WUoJGJO+2lwzt74V9oYxg0N/
   3lP6YUCnuRfTnfiLBz+EL13Dn3htgWHeGh7e1+B5o6qZaKiBDhq3nV5RF
   4=;
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
   d="scan'208";a="205449875"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8EBD1E0D3F; Tue, 28 Jan 2025 19:22:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 71530E00B7
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:01 +0100 (CET)
IronPort-SDR: 67992049_cLN7sJ4scymwJjcefvbKYpIhhiIdznOM1NEjlf0VFh0zUfT
 4mLO4+gM2ZH59iOg3d0QXCJpZG67KSdfAy7CTJg==
X-IPAS-Result: =?us-ascii?q?A0EgAACtH5lncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHYlTi3aQT4FWFIEsPg8BAwFOAQIEAQEDBIFMg?=
 =?us-ascii?q?zQCinUCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?YEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeA?=
 =?us-ascii?q?gEDERIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKiMgGHYAEBAosjfzOBAYIMA?=
 =?us-ascii?q?QEGgmfZOIFkCYEaLgGITQGBbIN/OwmDOXonG4FJRIFKgQaCLYQqLoNGgmmCM?=
 =?us-ascii?q?4FFg2+hHQk/gQUcA1ksAVUTDQoLBwVkVTgDIAsLDAsUHBUCFB0PBhAEbUQ3g?=
 =?us-ascii?q?kdpSTcCDQI1gh4kWIEdgQ6EXIRFYC8DAwMDgziCRVSCRIIUeoEXhkIdQAMLG?=
 =?us-ascii?q?A1IESw3Bg4bQwFuB5xdPIQDgQ4BfyeUPIQZjUmhboQloWABMqpTLodkkGoiq?=
 =?us-ascii?q?FqCGDqBXEYHIxWDIk8DGQ+IAIYhDBaDWI89AboLQzU8AgcLAQEDCYVGAQGKU?=
 =?us-ascii?q?YFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:PtgDLKmgf05ksWSgIZwqPnAGP5DpDfIW3DAbv31ZSRFFG/FwWf
 re+sjzsiWE6wr5OUtBpTjjUJPrfZq4z/NICOYqUotKMDOLhILsFvAH0WKA+Vzd8lPFh4xgPM
 5bGsAUNDSzNykesS+Q2meF+rgbsb66GdiT9J7j80s=
X-Talos-CUID: =?us-ascii?q?9a23=3AHx7GGGm9cIuJ+qNNEm5+yezmhi7XOU3g6krgZAz?=
 =?us-ascii?q?iNU1GbKe+b3661oZDisU7zg=3D=3D?=
X-Talos-MUID: 9a23:rRRnRQbU4clhTeBTkQOyqG0hJvZU+63+I3AdjZIhgsKOOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205449845"
X-MGA-submission: =?us-ascii?q?MDG7pNcs5jsPaQWVMpgp+PQscVbCFmtZFckkhO?=
 =?us-ascii?q?3PAvUA4c/0xudNSFInskttNhlQQbB8NqW3z6l32827UEvWQPJR9JGA/f?=
 =?us-ascii?q?9iIGI1UTBj7SL1Vff2E81OX/gnLIH6LkxLZjL80gk1BsIK6zK8lppsq9?=
 =?us-ascii?q?LTQ7/X+e0oKZmG2LW/5rFmgA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:00 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id C988B2037179;
	Tue, 28 Jan 2025 10:21:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C988B2037179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088517;
	bh=NnK20PmZCF3Ily6Bk4PfjyKx9tsw9Ltz3kRT5x7zGKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FaJCMhXqnOBKCZK58/aDFyxpugTwuUI0zorVbM17ln8zh2Kidcw4dLV6kvgQrvjgC
	 0NTPud50z5k1yBSbcBf+9ThgyXzP902+ENnzRWcvFd3c3gCBEPcZA9Zr7F3/Xti+Lp
	 3eGcpMelp4xFNnrE38aQ+AoRxDphqgUTWgfcQdRE=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-3-9a6ecf0b2308@linux.microsoft.com>
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
Subject: [cocci] [PATCH 03/16] accel/habanalabs: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2273
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-3-9a6ecf0b2308%40linux.microsoft.com>

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

