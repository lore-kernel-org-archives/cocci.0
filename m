Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923B3C18E7C
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=iYMbK5A793RDdkoEPga+PoRyWET+ntXiAELhCjFiDKo=;
  b=E6JyJrxDhWJDo3sKEfbiPwm3QLKTxOg1WV408vVsc7LddIBIox16Kuf5
   5NJ1P4eo2OcTAl6X0Ym2/7RnkIR3rcsQE2C3K89zkZElRAdDY+7U+xbi8
   5KYuriJNIQeeK8yBEqR6ucLDxnDX+rZVTNeVJ75xggKaw3Zo92cYPNsWb
   w=;
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
   d="scan'208";a="210043687"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 16303E0D1D; Tue, 25 Feb 2025 21:28:01 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5A4F2E0261
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:24 +0100 (CET)
IronPort-SDR: 67be2552_wty2/T8o2sKqR87aO+VHc0+xtJLAEyPHdWZzW/BFFR6AJt7
 E5tQdJk7Y5H9L2P9lXHKyZC4AiHCCKdnTmsu1WQ==
X-IPAS-Result: =?us-ascii?q?A0EhAACfJL5ncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHYlpi2CQS4FWgUA+DwEDAU4BAgQBAQMEhQACi?=
 =?us-ascii?q?xICHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIdAQE3AQ8ZDAImAgJGEAYBEoMCgmUGAp0tAYdgAQECiyOBMoEBggwBAQaCa?=
 =?us-ascii?q?Nk4gWUJgRouAYhOAYFsg387CYM5eicbgUlEgUqDM4RYg0aCaYNzg2ynYQk/g?=
 =?us-ascii?q?QUcA1ksAVUTDQoLBwVkVTgDIAoLDAsSHBUCFB0PBhAEakM3gkVpSToCDQI1g?=
 =?us-ascii?q?h4kWIEdgQ6EVIRDXC8DAwMDgyqCP1GCQoIRcYEaiTKDYx1AAwsYDUgRLDcGD?=
 =?us-ascii?q?htDAW4HoCU8hDuBDpl+jUuhb4QloWIBMqpVLodlkGoiqF2CGDqBXEYHIxWDI?=
 =?us-ascii?q?k8DGQ+OIYN6jz0BvDVDNTwCBwsBAQMJhUYBAYpUgUsBAQ?=
IronPort-PHdr: A9a23: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
 f0=
IronPort-Data: A9a23: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
 wSR
IronPort-HdrOrdr: A9a23:d3bOv6yY82VNbJ8IxEJrKrPwFr1zdoMgy1knxilNoNJuA6qlfq
 eV7ZcmPH7P6Ar4Ohkb8+xoXZPsfZqyz/FICOUqUYtKGTOW3FdAT7sC0WKd+UyDJ8SWzIc0vp
 uIMZIObeEYZmIVsS+V2njeLz9Z+qj/zJyV
X-Talos-CUID: 9a23:9LuNrmFGcTs07FJhqmJJt1UEF8IOQkHb533BGVOzJ2B4eIeaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AYrwh/A3vxqkhLLhVaC0mVNNx1zUj55qpIxhWr7A?=
 =?us-ascii?q?9nOaCKTRQHRbDjGmRTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="110053379"
X-MGA-submission: =?us-ascii?q?MDGMEezY8DQVxfZeWJb831qvuzdLfpPjyOJKXI?=
 =?us-ascii?q?FRfsLMiUU+Rsbr5zntHKWzQzneNLKooEdGr7cTgH8wtLL055WRfPDYsi?=
 =?us-ascii?q?ZHfcwlBvb8cMV+NB4OrblM9CgkXb+1m7ZnacGunYv4nNa2rnL/L0XXZM?=
 =?us-ascii?q?vv6BQ/sYU6ZWv4KMmNfYd2Jg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 25 Feb 2025 21:17:22 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id BF51B203CDFD;
	Tue, 25 Feb 2025 12:17:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF51B203CDFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514639;
	bh=iYMbK5A793RDdkoEPga+PoRyWET+ntXiAELhCjFiDKo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OP63wp67iKSqHjNTjMNd+sihLCyoASTZi2GNLl0ELqRwvrBXcEngcH+yXafC8Yprq
	 nAvYY5Wrea0EY1UvsDuANN22sm/ZDZFvEyjRA+KLA6UssBgo0/5UVPQNqQpxTLUDBc
	 wEQUX4uMwl08WGSAzFvomPPI3q3DYIQICkks+WHI=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-1-a43967e36c88@linux.microsoft.com>
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
Subject: [cocci] [PATCH v3 01/16] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2432
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-1-a43967e36c88%40linux.microsoft.com>

Teach the script to suggest conversions for timeout patterns where the
arguments to msecs_to_jiffies() are expressions as well.

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 scripts/coccinelle/misc/secs_to_jiffies.cocci | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
index 8bbb2884ea5db939c63fd4513cf5ca8c977aa8cb..416f348174ca659b544441f5f68f04a41d1ad4a3 100644
--- a/scripts/coccinelle/misc/secs_to_jiffies.cocci
+++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
@@ -20,3 +20,13 @@ virtual patch
 
 - msecs_to_jiffies(C * MSEC_PER_SEC)
 + secs_to_jiffies(C)
+
+@depends on patch@ expression E; @@
+
+- msecs_to_jiffies(E * 1000)
++ secs_to_jiffies(E)
+
+@depends on patch@ expression E; @@
+
+- msecs_to_jiffies(E * MSEC_PER_SEC)
++ secs_to_jiffies(E)

-- 
2.43.0

