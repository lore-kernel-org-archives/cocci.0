Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D70C02198
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=u7OiaBq0jFk7FcA2dC+mPjTQmMAI3oiqK6Ljbdu99Zo=;
  b=ICdDq6+GuRiwBADk01C4duzbhpdf/p97JELIkileLu5FaAhzwZVD25Y0
   Gi1N9K143H4VM+tVOMlIe/ICvc44gYrJm8rdRejEgwC9ubqIobVHqmkIH
   g+qco67tDlFkNhcoBfaa9F90qn/KHAj9f0PexJ+B0oMWC1ibBqK+yUap8
   U=;
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
   d="scan'208";a="205450029"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8FF19E0D79; Tue, 28 Jan 2025 19:22:07 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3F5BFE0137
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:03 +0100 (CET)
IronPort-SDR: 6799204a_L16uNz2bix7SZZVl+i8fWdu1U3yCoPW0xkafXp4jbh/lsWI
 km1txZCq+zLEFns5wIPt8GYMVKoqPURDw2y7nDQ==
X-IPAS-Result: =?us-ascii?q?A0EgAACtH5lncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVJkE+BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?nUCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKiMgGHYAEBAosjfzOBAYIMAQEGg?=
 =?us-ascii?q?mfZOIFkCYEaLgGITQGBbIN/OwmDOXonG4FJRIFKgzOEWINGgmmCM4FFg2+hH?=
 =?us-ascii?q?Qk/gQUcA1ksAVUTDQoLBwVkVTgDIAsLDAsUHBUCFB0PBhAEbUQ3gkdpSTcCD?=
 =?us-ascii?q?QI1gh4kWIEdgQ6EXIRFYC8DAwMDgziCRVSCRIIUeoEXhkIdQAMLGA1IESw3B?=
 =?us-ascii?q?g4bQwFuB5xdPIQDgQ+BJpQ8hBmNSaFuhCWhYAEyqlMuh2SQaiKoWoIYOoFcR?=
 =?us-ascii?q?gcjFYMiTwMZD4gAhiGDeo89AboLQzU8AgcLAQEDCYVGAQGKUYFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:SpTyUqBldxHjy3DlHemW55DYdb4zR+YMi2TDGXoBLyC9Ffbo9P
 xG/c566feX4Ax6ZJhEo7290ca7Lk80maQY3WBVB8bHYOCEggqVxf9ZnOnfKlTbckWUygce79
 YET0EUMrPN5DZB/KHHCXGDYq8d/OU=
X-Talos-CUID: 9a23:vpsvz2HhG9NltTmcqmJY7mQzMNg8cUfy51vrHnG2E0h0Y6+sHAo=
X-Talos-MUID: 9a23:wvv9jgva2p2wrsafWc2nrxpbEv9i6f+UClkAj7kntvmKEitQAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205449854"
X-MGA-submission: =?us-ascii?q?MDHds69IpLrp6ETOnnUtvFK0ZkkU0Yio+4XzYH?=
 =?us-ascii?q?kEZ4Vm2kmm3PzMoAMaFMfuUedMOmRgH3KDZzp/imh74W4AY03vjQaRGY?=
 =?us-ascii?q?H2pXCPqDjHNM/JJgBVBzYAEkGriyI8FHNKberNurQuCMhdcBP3n7nh+I?=
 =?us-ascii?q?R9U1/pWaC9O77+t/DBA/hF2w=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:02 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id B64E5203717F;
	Tue, 28 Jan 2025 10:21:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B64E5203717F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088518;
	bh=u7OiaBq0jFk7FcA2dC+mPjTQmMAI3oiqK6Ljbdu99Zo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bCWdmC5sK+KGAbHIQs99+gR3I9KkUGPk8kFlcCfGOtNz5+PxpeUtS30nO0JF6Kkrh
	 4YdwJAnsnMu3a7zDoviG7hWlukFPfHmJucfdR4tFHFcqEK2OJWxup5PGk5ZafTVcpE
	 UzK+XoLAiEFwEnVWfbUT/XAsd53WZnxAQJy+FV1o=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-9-9a6ecf0b2308@linux.microsoft.com>
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
Subject: [cocci] [PATCH 09/16] xfs: convert timeouts to secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2278
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-9-9a6ecf0b2308%40linux.microsoft.com>

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
 fs/xfs/xfs_icache.c | 2 +-
 fs/xfs/xfs_sysfs.c  | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 7b6c026d01a1fc020a41a678964cdbf7a8113323..7a1feb8dc21f6f71d04f88de866e5a95925e0c54 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -230,7 +230,7 @@ xfs_blockgc_queue(
 	rcu_read_lock();
 	if (radix_tree_tagged(&pag->pag_ici_root, XFS_ICI_BLOCKGC_TAG))
 		queue_delayed_work(mp->m_blockgc_wq, &pag->pag_blockgc_work,
-				   msecs_to_jiffies(xfs_blockgc_secs * 1000));
+				   secs_to_jiffies(xfs_blockgc_secs));
 	rcu_read_unlock();
 }
 
diff --git a/fs/xfs/xfs_sysfs.c b/fs/xfs/xfs_sysfs.c
index 60cb5318fdae3cc246236fd988b4749df57f8bfc..eed0f28afe97ead762a9539e45f292db7d0d0c4a 100644
--- a/fs/xfs/xfs_sysfs.c
+++ b/fs/xfs/xfs_sysfs.c
@@ -568,8 +568,8 @@ retry_timeout_seconds_store(
 	if (val == -1)
 		cfg->retry_timeout = XFS_ERR_RETRY_FOREVER;
 	else {
-		cfg->retry_timeout = msecs_to_jiffies(val * MSEC_PER_SEC);
-		ASSERT(msecs_to_jiffies(val * MSEC_PER_SEC) < LONG_MAX);
+		cfg->retry_timeout = secs_to_jiffies(val);
+		ASSERT(secs_to_jiffies(val) < LONG_MAX);
 	}
 	return count;
 }
@@ -686,8 +686,7 @@ xfs_error_sysfs_init_class(
 		if (init[i].retry_timeout == XFS_ERR_RETRY_FOREVER)
 			cfg->retry_timeout = XFS_ERR_RETRY_FOREVER;
 		else
-			cfg->retry_timeout = msecs_to_jiffies(
-					init[i].retry_timeout * MSEC_PER_SEC);
+			cfg->retry_timeout = secs_to_jiffies(init[i].retry_timeout);
 	}
 	return 0;
 

-- 
2.43.0

