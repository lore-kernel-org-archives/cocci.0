Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF59C0219B
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CFb4XrnDSERyLmvQoVXwUxR+JwVzCZvuuqJLbnh8AHY=;
  b=LQNmyvQor8gq6iQHFFIIyBi+j0Mf2Pk8LecMo6LNhKruhsmwsig91FAQ
   X3A8kKIfc3RRjz0KH3mdzgD2M4Csflf22jN7GtRqYLqQr3SWvxo2X3xy/
   I+rKyp5/43aiL6kcZSE1QTCmXpUh5U3Uncfb6nUl1kPa/UI9rX+FlaKDR
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
   d="scan'208";a="205450075"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 24E29E0137; Tue, 28 Jan 2025 19:22:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5332DE0D1F
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:03 +0100 (CET)
IronPort-SDR: 6799204a_vqP6DHG0JmYc0Nez9SE4iiUyS1V3Ifh8gfv3DVRQXJVCt3k
 g2r3zq9G5ct3QsXecbWkn83VDUP/OaVtZ+7F4AQ==
X-IPAS-Result: =?us-ascii?q?A0EgAACtH5lncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVJkE+BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?nUCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKiMgGHYAEBAosjfzOBAYIMAQEGg?=
 =?us-ascii?q?mfZOIFkCYEaLgGITQGBbIN/OwmDOXonG4FJRIFKgQaCLYRYg0aCaYIzgUWDb?=
 =?us-ascii?q?6EdCT+BBRwDWSwBVRMNCgsHBWRVOAMgCwsMCxQcFQIUHQ8GEARtRDeCR2lJN?=
 =?us-ascii?q?wINAjWCHiRYgR2BDoRchEVgLwMDAwODOIJFVIJEghR6gReGQh1AAwsYDUgRL?=
 =?us-ascii?q?DcGDhtDAW4HnF08hAOBDoEnlDyEGY1JoW6EJaFgATKqUy6HZJBqIqhaghg6g?=
 =?us-ascii?q?VxGByMVgyJPAxkPiACGIQwWg1iPPQG6C0M1PAIHCwEBAwmFRgEBilGBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:cJ1HYqkoXM+KPMTJMjVz7dMfq9vpDfIW3DAbv31ZSRFFG/FwWf
 re+sjzsiWE6wr5OUtBpTjjUJPrfZq4z/NICOYqUotKMDOLhILsFvAH0WKA+Vzd8lPFh4xgPM
 5bGsAUNDSzNykesS+Q2meF+rgbsb66GdiT9J7j80s=
X-Talos-CUID: =?us-ascii?q?9a23=3AV+k2mGm4Mo2ASFOefMwlZ5FA6IvXOV7k5yjUH1C?=
 =?us-ascii?q?aMmJCQZeIVEaQ/7lUvdU7zg=3D=3D?=
X-Talos-MUID: 9a23:obfb0QXGDhiqcYDq/A3iv3JLMP5x2IW/LxoLzcg2lPSmLzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107588265"
X-MGA-submission: =?us-ascii?q?MDFnqHcbZAJ0AM0IdEEbhNepO5fIDkSw9Zs/Md?=
 =?us-ascii?q?bJV8p6b/svBDQXpTVafVNPhdsiTGGTgdO34YaqZUsd8tDIs4kxXL7yeX?=
 =?us-ascii?q?mRdvcqw5TLBsnIobkZKxtgmmccfg8Aqdet/L0IiOIgroHwNOy6pnba7Z?=
 =?us-ascii?q?rw2xgRe2z5sAc46umGNlvnpA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 28 Jan 2025 19:22:03 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1D482203717B;
	Tue, 28 Jan 2025 10:21:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1D482203717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088518;
	bh=CFb4XrnDSERyLmvQoVXwUxR+JwVzCZvuuqJLbnh8AHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LxxdIayMSyUMAUeZUUnUyY3SQxVmwYY5Yyy03OWU22J18lbSyq7bmmWrhs+09j8qK
	 AdDxUAv3Opt8Wt6axGPYWRpk6/ENme+ZBSlX8IppgdX/yiYG+JdoRJjp8kHw8DUyuj
	 x3rFLX3PefulMBej9H+RgFZR+bApgqLL7hw3/Tgc=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-5-9a6ecf0b2308@linux.microsoft.com>
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
Subject: [cocci] [PATCH 05/16] btrfs: convert timeouts to secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2280
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-5-9a6ecf0b2308%40linux.microsoft.com>

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
 fs/btrfs/disk-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f09db62e61a1b0e2b8b319f9605883fe0c86cf9d..ed2772d2791997b1e1d15e71d01d818b325f5173 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1568,7 +1568,7 @@ static int transaction_kthread(void *arg)
 
 	do {
 		cannot_commit = false;
-		delay = msecs_to_jiffies(fs_info->commit_interval * 1000);
+		delay = secs_to_jiffies(fs_info->commit_interval);
 		mutex_lock(&fs_info->transaction_kthread_mutex);
 
 		spin_lock(&fs_info->trans_lock);
@@ -1583,9 +1583,9 @@ static int transaction_kthread(void *arg)
 		    cur->state < TRANS_STATE_COMMIT_PREP &&
 		    delta < fs_info->commit_interval) {
 			spin_unlock(&fs_info->trans_lock);
-			delay -= msecs_to_jiffies((delta - 1) * 1000);
+			delay -= secs_to_jiffies(delta - 1);
 			delay = min(delay,
-				    msecs_to_jiffies(fs_info->commit_interval * 1000));
+				    secs_to_jiffies(fs_info->commit_interval));
 			goto sleep;
 		}
 		transid = cur->transid;

-- 
2.43.0

