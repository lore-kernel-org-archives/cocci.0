Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC70C19777
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=iJ+KQsH4oEeYhax2MQEUmezdYkZ2iOhqthlkAAynP20=;
  b=rnlQhNPHpvmfYwMV6IvGhvk5uvxDjv8SNWgkYTMUj6KWVakEbbjgOQ2g
   kwSKAvftg6Lh3zNhVy0nCT0zvS2J50flE/3hnpEMyz4csrGtTUiglYUVk
   z5z7Tk9u28yrCctc6QPEpUNSDMl2li5hZk6jkRfaw2zxJ+dJxQbVHx80m
   A=;
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
   d="scan'208";a="210043785"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 94989E0D37; Tue, 25 Feb 2025 21:28:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C13B6E0D20
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:24 +0100 (CET)
IronPort-SDR: 67be2554_LqyrjvM7q3ho5ABZfi4r6S/XatMQgbfIKnJ066frxf2NpOd
 ACGR073ux4OIu1no/ju7ZeOs7Yj9jiwBKWJdRqQ==
X-IPAS-Result: =?us-ascii?q?A0EDAAAjJL5ncraaTQ1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBwhIhFaIHYlTFotQEJBLgVaBQD4PA?=
 =?us-ascii?q?QMBTgECBAEBAwSFAAKLEgIfBgEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABgQyFew2CYgGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARECDV4BAR4CAQMREgQZAQE3AQ8ZDAImAgIgJhAGARKDAoIxAzEGAp0sA?=
 =?us-ascii?q?YdgAQECiyN/M4EBggwBAQaCaNg/DWyBZQmBGi4BiDAeAYFsg387CYM5eicbg?=
 =?us-ascii?q?UlEgUqBBoItgh+COYNGgmmCM4FAg2ynYQk/gQUcA1ksAVUTDQoLBwVkVTgDI?=
 =?us-ascii?q?AoLDAsSHBUCFB0PBhAEakM3gkVpSToCDQI1gh4kWIEdgQ6EVIRDXC8DAwMDg?=
 =?us-ascii?q?yqCP1GCQoIRcYEaiTKDYx1AAwsYDUgRLDcGDhtDAW4HoCU8hBsZBwGBDYEng?=
 =?us-ascii?q?QJ6kkGEGo1LoH5xhCWbUIYSATKqVS6HZZBqIpFqlnOCGDqBXEYHIxWDIk8DG?=
 =?us-ascii?q?Q+IAIYhDBaDWI89AbwzQzU8AgcLAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
 ajT
IronPort-Data: A9a23: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
 wSR
IronPort-HdrOrdr: A9a23:Gw/gFajr3JTj9mimzGshzII0nHBQXuAji2hC6mlwRA09TyVXrb
 HJoB19726WtN9xYhEdcbLpAsO9qBbnmKKdjrN/AV7PZmXbUS6TXeVfBOjZogEIZReOlNK1vJ
 0IG8ND4Z/LfD1HZK3BjjVQfexQp+VviJrY/Nvj8w==
X-Talos-CUID: 9a23:xJkXHG77bWwuSXayXdssyR4/ReI5Yl/kz1zKA3S9CUFVRJabRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AwsAjBg+GI5yZUfcz7cPid8GQf8RuoKaKGkUurbE?=
 =?us-ascii?q?5gtiiLHV1ChPMvR3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210043054"
X-MGA-submission: =?us-ascii?q?MDHxHdQIEOBgd/mC8tAbzZsZ0xhaC5Msccv7+1?=
 =?us-ascii?q?oqFqAFx6qeAhf9kjX+v1nrclWMu6smwgxq72QIktFgq/Oy2XTWtkXr8q?=
 =?us-ascii?q?hLs1pjUCG9vz26VrlTYfY2I/vo/YVhWL5UyR4/O8ammHAon2Xh8KQh00?=
 =?us-ascii?q?Y9vOIUF1I0kh7DhlIEt/HQrg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:17:23 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 990F420460A9;
	Tue, 25 Feb 2025 12:17:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 990F420460A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514640;
	bh=iJ+KQsH4oEeYhax2MQEUmezdYkZ2iOhqthlkAAynP20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ru4P2KWomzrWMLGQikn6OevsdVLonrp+hAJTSQZwPGpN9LPpbikx9bi85AN2E2K8e
	 zwMEYFgcyW4mhVIsdnCbKRImPb9Kb2MWrvPg4WGez6AWSeze5LBjmJ8bdNE8gbm3gn
	 SVCsJfF2BKbHhrq5VadxT1H8d7QtWMsO7m/0BDOU=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
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
Subject: [cocci] [PATCH v3 06/16] rbd: convert timeouts to secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2435
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88%40linux.microsoft.com>

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@depends on patch@ expression E; @@

-msecs_to_jiffies(E * 1000)
+secs_to_jiffies(E)

@depends on patch@ expression E; @@

-msecs_to_jiffies(E * MSEC_PER_SEC)
+secs_to_jiffies(E)

While here, remove the no-longer necessary check for range since there's
no multiplication involved.

Acked-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/block/rbd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index faafd7ff43d6ef53110ab3663cc7ac322214cc8c..41207133e21e9203192adf3b92390818e8fa5a58 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -108,7 +108,7 @@ static int atomic_dec_return_safe(atomic_t *v)
 #define RBD_OBJ_PREFIX_LEN_MAX	64
 
 #define RBD_NOTIFY_TIMEOUT	5	/* seconds */
-#define RBD_RETRY_DELAY		msecs_to_jiffies(1000)
+#define RBD_RETRY_DELAY		secs_to_jiffies(1)
 
 /* Feature bits */
 
@@ -4162,7 +4162,7 @@ static void rbd_acquire_lock(struct work_struct *work)
 		dout("%s rbd_dev %p requeuing lock_dwork\n", __func__,
 		     rbd_dev);
 		mod_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork,
-		    msecs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT * MSEC_PER_SEC));
+		    secs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT));
 	}
 }
 
@@ -6283,9 +6283,7 @@ static int rbd_parse_param(struct fs_parameter *param,
 		break;
 	case Opt_lock_timeout:
 		/* 0 is "wait forever" (i.e. infinite timeout) */
-		if (result.uint_32 > INT_MAX / 1000)
-			goto out_of_range;
-		opt->lock_timeout = msecs_to_jiffies(result.uint_32 * 1000);
+		opt->lock_timeout = secs_to_jiffies(result.uint_32);
 		break;
 	case Opt_pool_ns:
 		kfree(pctx->spec->pool_ns);

-- 
2.43.0

