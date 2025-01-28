Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9D7C02192
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=T5lTYOdqZ18PkVPGKayEf1CtNzfnccen/5GASjCaKq8=;
  b=opGk44+PxuKB/LEbYmYWeyvl0E7CPpCvpoXghYrCIohUIabFyJe+pen0
   5MLHBBtvC091JyL6laMw4Kt9LCS3aRoRyvSbq6iuejwn/wUeIVih+jyoZ
   rDPu0Se/s9GlrbaG9fKXy4TgSPPj0i4/0LetbnNzLUo4XHaj+P9t7+AOy
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
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205450033"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9F249E0D99; Tue, 28 Jan 2025 19:22:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3AF63E00B7
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:03 +0100 (CET)
IronPort-SDR: 6799204a_jxVDQ63ZLjD9eBnrroL8CJ8AwIxkBJYp+Raiq5MYLUbw1eg
 twbH3enL+Qro6vxCbOKmS2ReW57TqXP3TE0iE2w==
X-IPAS-Result: =?us-ascii?q?A0EgAACtH5lncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHYlTi3aQT4FWgUA+DwEDAU4BAgQBAQMEgUyDN?=
 =?us-ascii?q?AKKdQIfBgEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABg?=
 =?us-ascii?q?QyFew2CYgGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BAR4CA?=
 =?us-ascii?q?QMREgQZAQE3AQ8ZDAImAgJGEAYBEoMCgmUGAqIyAYdgAQECiyN/M4EBggwBA?=
 =?us-ascii?q?QaCZ9k4gWQJgRouAYhNAYFsg387CYM5eicbgUlEgUqDM4RYg0aCaYIzgUWDb?=
 =?us-ascii?q?6EdCT+BBRwDWSwBVRMNCgsHBWRVOAMgCwsMCxQcFQIUHQ8GEARtRDeCR2lJN?=
 =?us-ascii?q?wINAjWCHiRYgR2BDoRchEVgLwMDAwODOIJFVIJEghR6gReGQh1AAwsYDUgRL?=
 =?us-ascii?q?DcGDhtDAW4HnF08g2MZB4EOgSeBfJJAhBmNSaFuhCWhYAEyqlMuh2SQaiKoW?=
 =?us-ascii?q?oIYOoFcRgcjFYMiTwMZD4gAhiEMFoNYjz0BugtDNTwCBwsBAQMJhUYBAYpRg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:czOGgqDr+cyk7nXlHemW55DYdb4zR+YMi2TDGXoBLyC9Ffbo9P
 xG/c566feX4Ax6ZJhEo7290ca7Lk80maQY3WBVB8bHYOCEggqVxf9ZnOnfKlTbckWUygce79
 YET0EUMrPN5DZB/KHHCXGDYq8d/OU=
X-Talos-CUID: 9a23:tqZIy2Omyq4Inu5DaC16yWNNPucZKFaA4UrzKGrmI2RPcejA
X-Talos-MUID: 9a23:fIND8AQZgKufVpXwRXTeuglALcNqx5+gN0MUl88CmfijbyZvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107588264"
X-MGA-submission: =?us-ascii?q?MDE4mbomy2AJEeA3TuARelKfHbAX44AJ9KnPl8?=
 =?us-ascii?q?hNIvj/tJ2mOaWeF6/CFTdtAq+EdlVxjmEiqz2rOEIeXNY/zp1QRnybvv?=
 =?us-ascii?q?h+jHOGDPSg7rgatp0O/3VwRBJKZxqsH5z9CuK9drtLrrLrGAJcfgt2rV?=
 =?us-ascii?q?TRwMCyQml6uSi99dFJuOyHbA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 28 Jan 2025 19:22:02 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 42B3F203717C;
	Tue, 28 Jan 2025 10:21:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42B3F203717C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088518;
	bh=T5lTYOdqZ18PkVPGKayEf1CtNzfnccen/5GASjCaKq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rfpPyd5u2ZlUcIwQygPeTjz3YVe0bsvVHvz8oTJmztLsU9la/gkLXe+572rOIv/gB
	 i7G5iRnJ4ApNulfyRHe7j7M91b9gXSmWOIpvgx9y6je8Dp4x/KKRzHQhcPHDtnmULj
	 WHUHoPOTUtxAhJC69Tbiyelh7/Qnkg0BPCHLyWN4=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-6-9a6ecf0b2308@linux.microsoft.com>
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
Subject: [cocci] [PATCH 06/16] rbd: convert timeouts to secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2279
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-6-9a6ecf0b2308%40linux.microsoft.com>

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
 drivers/block/rbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5b393e4a1ddfc4eba1a821b9bf8e04585bdf2190..c2389500076643b8e1e9caa75431693d12e59a5e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4162,7 +4162,7 @@ static void rbd_acquire_lock(struct work_struct *work)
 		dout("%s rbd_dev %p requeuing lock_dwork\n", __func__,
 		     rbd_dev);
 		mod_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork,
-		    msecs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT * MSEC_PER_SEC));
+		    secs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT));
 	}
 }
 
@@ -6283,9 +6283,9 @@ static int rbd_parse_param(struct fs_parameter *param,
 		break;
 	case Opt_lock_timeout:
 		/* 0 is "wait forever" (i.e. infinite timeout) */
-		if (result.uint_32 > INT_MAX / 1000)
+		if (result.uint_32 > INT_MAX)
 			goto out_of_range;
-		opt->lock_timeout = msecs_to_jiffies(result.uint_32 * 1000);
+		opt->lock_timeout = secs_to_jiffies(result.uint_32);
 		break;
 	case Opt_pool_ns:
 		kfree(pctx->spec->pool_ns);

-- 
2.43.0

