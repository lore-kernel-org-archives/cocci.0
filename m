Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11ECC02194
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kdMVzzkgTOOmufQV39efQmOyjkxwKqjsv6zrS4rXQDA=;
  b=GRWP7in2NERIMauCjkzK5kVCfUceXxX/SQg8XNBZ/F2loW3/wG7SpKYa
   4sMo0XZ6YrKNpBmQMQBj94irjut6IxVzd7x5YVxo7ZnMdHavn65zWVp9j
   sB2+bwsjc2Zl+J3R9XtYQsRXT5mdPaXoUreaseNR1IRulWduMN8cl1lZc
   c=;
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
   d="scan'208";a="205450296"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9D090E0D1F; Tue, 28 Jan 2025 19:22:17 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AEC9EE0D64
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:05 +0100 (CET)
IronPort-SDR: 6799204d_IGabmaLwVTEbEZL8WbDvZN81VJOdoPGJPGmyCWZ1uIQh9zT
 OiN/Cv9Ofv4kQ1kX0TwTWd+2k+m400hTDn7KSDA==
X-IPAS-Result: =?us-ascii?q?A0EgAACtH5lncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVJkE+BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?nUCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKiMgGHYAEBAosjfzOBAYIMAQEGg?=
 =?us-ascii?q?mfZOIFkCYEaLgGITQGBbIN/OwmDOXonG4FJRIEVNYEGgi2ECk6DRoJpgjOBR?=
 =?us-ascii?q?YNvgWyLAB0vgimRPAk/gQUcA1ksAVUTDQoLBwVkVTgDIAsLDAsUHBUCFB0PB?=
 =?us-ascii?q?hAEbUQ3gkdpSTcCDQI1gh4kWIEdgQ6EXIRFYC8DAwMDgziCRVSCRIIUeoEXh?=
 =?us-ascii?q?kIdQAMLGA1IESw3Bg4bQwFuB5xdPIQDgQ6BJ5Q8hBmNSaFuhCWhYAEyqlMuh?=
 =?us-ascii?q?2SQaiKoWoIYOoFcRgcjFYMiTwMZD4gAhiGDeo89AboLQzU8AgcLAQEDCYVGA?=
 =?us-ascii?q?QGKHTSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:RG4I6q0eOpSrafMOJfnBugqjBIgkLtp133Aq2lEZdPWaSL3/qy
 nIpoV56faUslYssBNJo7q90cy7LE80mqQb3WB8B9uftUzdyQ+VxeJZjLcKvQeQeREWn9Q1vc
 xdmupFebjN5DNB4/oSjjPIdOrIuOP3iZyVuQ==
X-Talos-CUID: 9a23:zYAAUG1TOIzt6KGDFXGoxrxfSt8UXVvd3VrqO16nD3dHZq2oZUSZ9/Yx
X-Talos-MUID: 9a23:W18LtgsXnA50p3e/y82ngyN+KPc1vbSXJGcgnJ4roZPbMBRqEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107588280"
X-MGA-submission: =?us-ascii?q?MDFPPKgQQ6SJWQNrPcDS1KcA6cse9xN6gO0TQq?=
 =?us-ascii?q?OrwMISWFiED8fpomSw97YWeTl2qWGj9+dwaMlEVPZ2xoumstKIQQiHrj?=
 =?us-ascii?q?eBHdZiMCbZucLWmw09RKOYKoMIjsVHwSilcctNuIMjA7nEyRnUpTeNFO?=
 =?us-ascii?q?6jdR1TXCW8AuR6dI9QOeJHuA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 28 Jan 2025 19:22:05 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id C24F42037187;
	Tue, 28 Jan 2025 10:21:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C24F42037187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088519;
	bh=kdMVzzkgTOOmufQV39efQmOyjkxwKqjsv6zrS4rXQDA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q+xwP6ClPU9Ft8nUZaAm0N07V7hTj7HoQgpntSqU7xz/FSC1uyq8yI9vSrWHQTVoJ
	 PSX32EpAjhCmTdNfYRkq0EvtpfRW1IfUg+fLiSx95EzydAGIAXQme2d6mFML8NbA9f
	 CPhNataDz2TgSPTNZMYPFDRtUHD77vCxTnf0vsIo=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:22:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-16-9a6ecf0b2308@linux.microsoft.com>
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
Subject: [cocci] [PATCH 16/16] RDMA/bnxt_re: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2288
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-16-9a6ecf0b2308%40linux.microsoft.com>

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
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 17e62f22683b14a3571188e25fe0df3cbf1d8360..b1a18c9cb7f6c248548bc38fcb98781a3030a1b6 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -160,7 +160,7 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 		wait_event_timeout(cmdq->waitq,
 				   !crsqe->is_in_used ||
 				   test_bit(ERR_DEVICE_DETACHED, &cmdq->flags),
-				   msecs_to_jiffies(rcfw->max_timeout * 1000));
+				   secs_to_jiffies(rcfw->max_timeout));
 
 		if (!crsqe->is_in_used)
 			return 0;

-- 
2.43.0

