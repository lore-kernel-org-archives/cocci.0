Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C78C197BF
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Qo91OPYqvODsMHgSb54ef05BxLTO+JhXe+iNvHfQKU0=;
  b=HIkanQplQ/kLXObzDmJOMl/1F7iGNqgLAfYvbAGH/EDvkU/2OjgHhkY5
   84PJOHqNXvFEqgCxcv71FggCnGifpawscfFQBraUyzZjXuMArf5s0CSGp
   RM+wNti+QjWejqsM9Jh9vWkypV4YCV67RxIMCH6zvzlLbZNB4orDr6AJM
   k=;
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
   d="scan'208";a="210044059"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CB45EE0DF4; Tue, 25 Feb 2025 21:28:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E6CBAE0D1E
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:26 +0100 (CET)
IronPort-SDR: 67be2556_ntzpYGcygVdlBWE25b/bB1YXIT8qJMhVD+D/68CPDvX05Es
 NAfsrYEmsA8Qk5LiTQtgctETBN3SPdkGn7JhcVg==
X-IPAS-Result: =?us-ascii?q?A0ELAAAjJL5ncraaTQ1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDgVczBwhIhFaIHYlpi2CQS4FWgUA+DwEDAU4BAgQBA?=
 =?us-ascii?q?QMEhQACixICHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eA?=
 =?us-ascii?q?QEeAgEDERIdAQE3AQ8ZDAImAgJGEAYBEoMCgmUGAp0sAYdgAQECiyOBMoEBg?=
 =?us-ascii?q?gwBAQaCaNk4gWUJgRouAYhOAYFsg387CYM5eicbgUlEgUqDM4QKToNGgmmCM?=
 =?us-ascii?q?4FAg2ynYQk/gQUcA1ksAVUTDQoLBwVkVTgDIAoLDAsSHBUCFB0PBhAEakM3g?=
 =?us-ascii?q?kVpSToCDQI1gh4kWIEdgQ6EVIRDXC8DAwMDgyqCP1GCQoIRcYEaiTKDYx1AA?=
 =?us-ascii?q?wsYDUgRLDcGDhtDAW4HoCU8hDuBDoEnlD2EGo1LoW+EJaFiATKqVS6HZZBqI?=
 =?us-ascii?q?qhdghg6gVxGByMVgyJPAxkPiACGIYN6jz0BvDNDNTwCBwsBAQMJhUYBAYogN?=
 =?us-ascii?q?IFLAQE?=
IronPort-PHdr: A9a23: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
 KjT
IronPort-Data: A9a23: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
 9V030UDOQ==
IronPort-HdrOrdr: A9a23:9bJrnaNMHTiDlsBcTvujsMiBIKoaSvp037Dk7TEWdfUzSL36qy
 nOppQmPX2dslwssRQb9OxoV5PufZqxz/JICMwqTNOftWrd2VdAUrsSj7cKqgeIc0bDH6xmpM
 JdmsNFZuEYY2IK6voSmDPIauod/A==
X-Talos-CUID: 9a23:juv09Gx/Gsc4XSHu2yoVBgU6MJkEL2b98E3+Ima3DGNgZI+5WE6PrfY=
X-Talos-MUID: 9a23:y+kIGQYUIpyQn+BT7DTQhRV+N5dRvLmfVHsUiKQg68elDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210043063"
X-MGA-submission: =?us-ascii?q?MDHAigtXngGF8hsHnUVLPP5MTOZU+hOIwzuhhH?=
 =?us-ascii?q?cuRO6rCNkAqOrJwYsi531dB4iVE+ZljV4k2Nh1VVlW3oaHZSYC1rniLP?=
 =?us-ascii?q?0A6kAuV33KHrJl0acZYzP6fvzsLFrPpRm2N87PVQPWs5VKrQtJQzBoPr?=
 =?us-ascii?q?CQczVmJiPhFzDcfyjKbs+PtA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:17:26 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id A0B18206AB8C;
	Tue, 25 Feb 2025 12:17:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A0B18206AB8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514641;
	bh=Qo91OPYqvODsMHgSb54ef05BxLTO+JhXe+iNvHfQKU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NMXH+U0FfVKsH005Ul/mGpQZZqnE79yUWLMvhoOTWFpDQyDarjSc0oCwdz+2rujXn
	 VTjGM6YcWNyvkxjO7B3ccLXcLQIuRHCSQ8eixWaHPkdjR/vkz66kfWDUCZdyrDcRWv
	 so4Io1UL/BpfmfbDjKryB0E/3VUPNUzudmnLjHZk=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-12-a43967e36c88@linux.microsoft.com>
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
Subject: [cocci] [PATCH v3 12/16] spi: spi-fsl-lpspi: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2443
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-12-a43967e36c88%40linux.microsoft.com>

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

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 40f5c8fdba765a1334710a696966232a459316e6..5e381844523440c03b1d0bbe4a044f28fbfbc738 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -572,7 +572,7 @@ static int fsl_lpspi_calculate_timeout(struct fsl_lpspi_data *fsl_lpspi,
 	timeout += 1;
 
 	/* Double calculated timeout */
-	return msecs_to_jiffies(2 * timeout * MSEC_PER_SEC);
+	return secs_to_jiffies(2 * timeout);
 }
 
 static int fsl_lpspi_dma_transfer(struct spi_controller *controller,

-- 
2.43.0

