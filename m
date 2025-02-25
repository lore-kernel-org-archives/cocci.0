Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF62C021B2
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=43Vrmw689COEddN2FS9b3k4xJeLol8HtOHP5G9OUfEI=;
  b=jwWku9zX/wXbn3zPw9BOFbGzhq2K1fK7jJGPMHf76PYNiQx/ETq/93lS
   5Hs2LGMLGtU+W6aVJxd+7fmyYIH+WymzwspsXSHV+R3+RSlAkpYyfy8nC
   OA9QKsPN4ZOpgopTNoYu2nXf/SAOmej6wfPHUQ8Qaii5h5c/X/sUH2p57
   Y=;
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
   d="scan'208";a="210043899"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 25FA4E0D88; Tue, 25 Feb 2025 21:28:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E2AB8E0D21
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:24 +0100 (CET)
IronPort-SDR: 67be2554_pXuVAzKQ7n9HIMeNXShPAWCkh7vh71hVK4O5aNxB6igG90a
 0A3i81UD/wL0wQ2TjfGy1LLFAwKt8xalFRyzfvQ==
X-IPAS-Result: =?us-ascii?q?A0EDAACfJL5ncraaTQ1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBwhIhFaIHYlpi2CQS4FWgUA+DwEDA?=
 =?us-ascii?q?U4BAgQBAQMEhQACixICHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QERAg1eAQEeAgEDERIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKdLQGHYAEBA?=
 =?us-ascii?q?osjfzOBAYIMAQEGgmjZOIFlCYEaLgGITgGBbIN/OwmDOXonG4FJRIFKgQaCL?=
 =?us-ascii?q?YRYg0aCaYIzgUCDbKdhCT+BBRwDWSwBVRMNCgsHBWRVOAMgCgsMCxIcFQIUH?=
 =?us-ascii?q?Q8GEARqQzeCRWlJOgINAjWCHiRYgR2BDoRUhENcLwMDAwODKoI/UYJCghFxg?=
 =?us-ascii?q?RqJMoNjHUADCxgNSBEsNwYOG0MBbgegJTyEO4EOgSeUPYQajUuhb4QloWIBM?=
 =?us-ascii?q?qpVLodlkGoiqF2CGDqBXEYHIxWDIk8DGQ+IAIYhDBaDWI89Abw1QzU8AgcLA?=
 =?us-ascii?q?QEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
 ajT
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:U7vH/q0cRyiiP2tYfVfj2QqjBIgkLtp133Aq2lEZdPWaSL3/qy
 nIpoV56faUslYssBNJo7q90cy7LE80mqQb3WB8B9uftUzdyQ+VxeJZjLcKvQeQeREWn9Q1vc
 xdmupFebjN5DNB4/oSjjPIdOrIuOP3iZyVuQ==
X-Talos-CUID: 9a23:WRnSmGHLJY3Arv6JqmJeyBcJQMc1MUTvyWX/PkKYKzhuaYOaHAo=
X-Talos-MUID: 9a23:m3O7hAoNrKbvD4opjbwezzxjF+tLvqKlMmYyt5QhhsCiKyNWHijI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="110053382"
X-MGA-submission: =?us-ascii?q?MDGRiO5v8BVm8JCM/io6CPiZW8l0KArLxsEdzh?=
 =?us-ascii?q?oO4jKlIxBH88c0Pd5FkPsoJfwsVUVfnkyLWqV6Husc48kpKF8z162wj3?=
 =?us-ascii?q?a+sqQ84PTxzM3UT4iWKH7ZJBW2fOVW1n64oWDTAbfCO7lsP8Ntfr0C4q?=
 =?us-ascii?q?1i7AJC58sVVWX71GWlyeE8+g=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 25 Feb 2025 21:17:24 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6E76620460A8;
	Tue, 25 Feb 2025 12:17:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6E76620460A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514640;
	bh=43Vrmw689COEddN2FS9b3k4xJeLol8HtOHP5G9OUfEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pk0xnKO9WBFe46q3Ywjq7JsVadxRRKjvYrB9zIzbdZYd66bY8+Mfl+SOuW98ovT8m
	 RZ9T82wwrWfEpvwsx9UKS0c/nfb81Mr/DBVwwYUcW+0kbutViK4+XjzpCBl7z2tJAL
	 gU7qljh7WuzOn/DH6zvRyvuT2mG0Zr/ppFF0MI78=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-5-a43967e36c88@linux.microsoft.com>
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
Subject: [cocci] [PATCH v3 05/16] btrfs: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2437
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-5-a43967e36c88%40linux.microsoft.com>

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

Acked-by: David Sterba <dsterba@suse.com>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 fs/btrfs/disk-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c0b40dedceb53d6f1452b4dafea6b76eac08b932..606b004001bd8720f2aef059d435afb2d7b975d1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1567,7 +1567,7 @@ static int transaction_kthread(void *arg)
 
 	do {
 		cannot_commit = false;
-		delay = msecs_to_jiffies(fs_info->commit_interval * 1000);
+		delay = secs_to_jiffies(fs_info->commit_interval);
 		mutex_lock(&fs_info->transaction_kthread_mutex);
 
 		spin_lock(&fs_info->trans_lock);
@@ -1582,9 +1582,9 @@ static int transaction_kthread(void *arg)
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

