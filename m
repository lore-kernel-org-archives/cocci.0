Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB55C19F2E
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZH8umU91mi0wAcmYNb/gkPuUZx7SURsrk1GkGJenkwI=;
  b=s0/40TsGs7YDcCVMsPeGDxcntqQ6jXFJDfhTMwgPLhzdjRTmEtE4dZRb
   UMHWfc6ZkduOPGTrdPICSIaYisgk+hEqjRkM9ath0tFGThouk90J0lO03
   Irx/pF5sTUZBZdEUGtWKnDPkjtaruxkxClMXUitspzyMO+9SWBBVR8aCC
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
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210044073"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 09666E0D44; Tue, 25 Feb 2025 21:28:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3C730E0D23
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:27 +0100 (CET)
IronPort-SDR: 67be2556_59AuRJH7WTMiQO0IkYCZm9vsF4RnxQGAYlGM7fG+vWqg/6b
 zYahXkZa4m0++wM0M+Hnt/AVRYvhzUqI3p3gPpA==
X-IPAS-Result: =?us-ascii?q?A0EDAAAjJL5ncraaTQ1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBwhIhFaIHYlpi2CQS4FWgUA+DwEDA?=
 =?us-ascii?q?U4BAgQBAQMEhQACixICHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QERAg1eAQEeAgEDERIdAQE3AQ8ZDAImAgJGEAYBEoMCgmUGAp0sAYdgAQECi?=
 =?us-ascii?q?yOBMoEBggwBAQaCaNk4gWUJgRouAYhOAYFsg387CYM5eicbgUlEgUqBBoIth?=
 =?us-ascii?q?ApOg0aCaYIzgUCDbKdhCT+BBRwDWSwBVRMNCgsHBWRVOAMgCgsMCxIcFQIUH?=
 =?us-ascii?q?Q8GEARqQzeCRWlJOgINAjWCHiRYgR2BDoRUhENcLwMDAwODKoI/UYJCghFxg?=
 =?us-ascii?q?RqJMoNjHUADCxgNSBEsNwYOG0MBbgegJTyEO4EOgSeUPYQajUuhb4QloWIBM?=
 =?us-ascii?q?qpVLodlkGoiqF2CGDqBXEYHIxWDIk8DGQ+IAIYhg3qPPQG8M0M1PAIHCwEBA?=
 =?us-ascii?q?wmFRgEBiiA0gUsBAQ?=
IronPort-PHdr: A9a23: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
 f0=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:tqMZ4qDys1BuYLHlHemW55DYdb4zR+YMi2TDGXoBLyC9Ffbo9P
 xG/c566feX4Ax6ZJhEo7290ca7Lk80maQY3WBVB8bHYOCEggqVxf9ZnOnfKlTbckWUygce79
 YET0EUMrPN5DZB/KHHCXGDYq8d/OU=
X-Talos-CUID: 9a23:XuACwWxAasBBMMpHDvDXBgU1Qdo+cUzGyk75Om+lDDt3Y7/FGQSfrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AFKzwow8W7q4jT6RdgUw9686Qf/8zpL6JCGYrqoo?=
 =?us-ascii?q?DkZSCDAtSZQ/A0CviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210043066"
X-MGA-submission: =?us-ascii?q?MDG0/jTHhML48bJXIHLgAAYCDQEhurWbSu4g7g?=
 =?us-ascii?q?UjX6x72CPBvBcYm7yXhL6ovBW+ih1riUwNRajezAaA4fySAyyWl2GH46?=
 =?us-ascii?q?O9iA8Zc/Kt6pPLQgp2Gb7GP/CPwoMcC+fqqD41dU0aNlfWYbuEG1tCMg?=
 =?us-ascii?q?5ZigmVvKJsaQNxCFT333LfwQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:17:26 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id CAF7C206AB9B;
	Tue, 25 Feb 2025 12:17:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CAF7C206AB9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514641;
	bh=ZH8umU91mi0wAcmYNb/gkPuUZx7SURsrk1GkGJenkwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XJ2yFpBk3qCLV4nsMZVlvUSB6SJoAMrG/lilaGrXcFN0Lc7s5NOy3uhepXpsayAcq
	 x07K8FkHjDySQIgscKrqdj6VScj0K5xWaPtsAkir9VsMrBs2e09ZnaVPpKQCXsFOuq
	 vOHcRdnBLLKCxEgEkL55Xz0ft8yD2027HMK/8AS8=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:27 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-13-a43967e36c88@linux.microsoft.com>
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
Subject: [cocci] [PATCH v3 13/16] spi: spi-imx: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2444
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-13-a43967e36c88%40linux.microsoft.com>

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
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index eeb7d082c2472f954001045295b349bc2eb53197..832d6e9009ebe741779acd58c3a9450c231151bb 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1449,7 +1449,7 @@ static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
 	timeout += 1;
 
 	/* Double calculated timeout */
-	return msecs_to_jiffies(2 * timeout * MSEC_PER_SEC);
+	return secs_to_jiffies(2 * timeout);
 }
 
 static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,

-- 
2.43.0

