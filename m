Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCE5C021BB
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wTxfjRn6ejxewAXZKfJHLeChqeGMTW3kANLgvmjkhrM=;
  b=pLKdK2IywPXEU8Vx7bA4YQ/ugDWd/Na9NqwT79YTbnMoI5xpnA/MqL3N
   EhFh4X83ie1yX2ZKKfiOPdjzN77StMfr153Jji9128C+vZL0MEYzlpvF1
   DT766OYafCDbNC0rkztcqnTlTOANxzTiMnA42o8dgpolEWVLEeTt2cO5X
   E=;
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
   d="scan'208";a="210044023"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5EC9AE0DE4; Tue, 25 Feb 2025 21:28:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6B0F0E0D22
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:26 +0100 (CET)
IronPort-SDR: 67be2555_WuA5SnDn+fm5pxo8QwRCxDfa8NamNSurufbRiEETJ/ziQRI
 1PqqUHUFUcQAOUWekxI4MrbUBVncKTBwBFnsoxA==
X-IPAS-Result: =?us-ascii?q?A0ELAAAjJL5ncraaTQ1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDgVczBwhIhFaIHYlpi2CQS4FWgUA+DwEDAU4BAgQBA?=
 =?us-ascii?q?QMEhQACixICHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eA?=
 =?us-ascii?q?QEeAgEDERIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKdLAGHYAEBAosjfzOBA?=
 =?us-ascii?q?YIMAQEGgmjZOIFlCYEaLgGITgGBbIN/OwmDOXonG4FJRIFKgzOEWINGgmmCM?=
 =?us-ascii?q?4FAg2yBbIpcHC2CJZgrCT+BBRwDWSwBVRMNCgsHBWRVOAMgCgsMCxIcFQIUH?=
 =?us-ascii?q?Q8GEARqQzeCRWlJOgINAjWCHiRYgR2BDoRUhENcLwMDAwODKoI/UYJCghFxg?=
 =?us-ascii?q?RqJMoNjHUADCxgNSBEsNwYOG0MBbgegJTyEO4EPgSaBGZMkhBqNS6FvhCWhY?=
 =?us-ascii?q?gEyqlUuh2WQaiKoXYIYOoFcRgcjFYMiTwMZD4gAhiGDeo89AbwzQzU8AgcLA?=
 =?us-ascii?q?QEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
 sfr+bmfKg==
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:li4i0auh9QC102hJU6Xhuwq77skDTNV00zEX/kB9WHVpmwKj5q
 aTdZMgpHzJYVcqOE3J+7i7UpVoJEmwyXcb2+Ys1NuZMDUO/VHYSL2KjrGC/9SfIVydygc178
 4JGJSWSueAaGSS5vyV3ODXKadG/DD+ytHQudvj
X-Talos-CUID: =?us-ascii?q?9a23=3ACPog2Wlc1T8ppzocuOCq2e+GgTLXOUCN5yjyP1+?=
 =?us-ascii?q?aMGVCUp2uTF+3xK9PncU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A3B9r8A9lDlH93URtjWLBev2Qf9cz47ySF3suqpB?=
 =?us-ascii?q?YtdiAPAhfBm7BnQ3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210043061"
X-MGA-submission: =?us-ascii?q?MDFU1Ypzuuy7Ev+wHQlmAC1TYvxWqhAun/T35x?=
 =?us-ascii?q?URArOWbtKezFs2a9K/OZcsKwqYO+H+shJUja9HDqsBGMLxf/WYR3iKuL?=
 =?us-ascii?q?klXEoy8dWo6DEh4t2Y97i9rU3BD6bw+E49vJGM+LQg5XAQLHA/hjR38L?=
 =?us-ascii?q?KqHmxQC6Jjbe1FDhjAnuNU3g=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:17:25 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 22C782069416;
	Tue, 25 Feb 2025 12:17:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 22C782069416
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514641;
	bh=wTxfjRn6ejxewAXZKfJHLeChqeGMTW3kANLgvmjkhrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H5CqFUFBZqsAA4PRbz8RW4SOBjttBXuZ0J6R7/3lHjRGaHX2TGj50oaKtOaS4tQi4
	 rNrspexwWI2u14WXiU3O8hDT5FRl+JbNn7p2aSLgpcWAmzkYtLkH8zv/wByJnNS1Iq
	 XT8ArtX0KavYZwC3ToNL3tNTtPMP08inXfniMCjU=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-9-a43967e36c88@linux.microsoft.com>
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
 Easwar Hariharan <eahariha@linux.microsoft.com>, 
 Carlos Maiolino <cmaiolino@redhat.com>
X-Mailer: b4 0.14.2
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3 09/16] xfs: convert timeouts to secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2442
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-9-a43967e36c88%40linux.microsoft.com>

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

Acked-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 fs/xfs/xfs_icache.c | 2 +-
 fs/xfs/xfs_sysfs.c  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

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
index 60cb5318fdae3cc246236fd988b4749df57f8bfc..c9ca8cd8a2f2785841e3eba2f8e070e45d10b79a 100644
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
@@ -686,8 +686,8 @@ xfs_error_sysfs_init_class(
 		if (init[i].retry_timeout == XFS_ERR_RETRY_FOREVER)
 			cfg->retry_timeout = XFS_ERR_RETRY_FOREVER;
 		else
-			cfg->retry_timeout = msecs_to_jiffies(
-					init[i].retry_timeout * MSEC_PER_SEC);
+			cfg->retry_timeout =
+					secs_to_jiffies(init[i].retry_timeout);
 	}
 	return 0;
 

-- 
2.43.0

