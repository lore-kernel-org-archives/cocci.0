Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573BFC0219A
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cIG2dfkqcecUU0JqZpchlOURAaCdxgZkNT0UTt4bvLA=;
  b=BsRBvUWDs4kzI/pp4tIodIX0Y78Ayb5ufL0SrFJVW4UFpXMJ1/gkm3aF
   sY0eOY0wxXB+bjlAC4WSQJUwww3BdZHFyQyV6a9vF/zqr6ll5mV2bP+qn
   G3Kcn6pSow5HTkGh5ewJY9/IY1RnccbZ7hRkcjx3ushl8xNthp+q6PbuW
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
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205450251"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0F712E0D6F; Tue, 28 Jan 2025 19:22:16 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 05E27E0D22
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:05 +0100 (CET)
IronPort-SDR: 6799204c_EX+diwKNe9I57hWnAo5yQYDf/r8RiR5/8V7Xfz5w3IOb99q
 wPDYXBdovzHFYDKtHOq0bzZXn5Zoq3nJ3ha8yfA==
X-IPAS-Result: =?us-ascii?q?A0EgAACtH5lncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVJkE+BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?nUCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIdAQE3AQ8ZDAImAgJGEAYBEoMCgmUGAqIyAYdgAQECiyOBMoEBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhNAYFsg387CYM5eicbgUlEgUqDM4QKToNGgmmCM4FFg2+hH?=
 =?us-ascii?q?Qk/gQUcA1ksAVUTDQoLBwVkVTgDIAsLDAsUHBUCFB0PBhAEbUQ3gkdpSTcCD?=
 =?us-ascii?q?QI1gh4kWIEdgQ6EXIRFYC8DAwMDgziCRVSCRIIUeoEXhkIdQAMLGA1IESw3B?=
 =?us-ascii?q?g4bQwFuB5xdPIQDgQ6BJ5Q8hBmNSaFuhCWhYAEyqlMuh2SQaiKoWoIYOoFcR?=
 =?us-ascii?q?gcjFYMiTwMZD4gAhiGDeo89AboLQzU8AgcLAQEDCYVGAQGKHTSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:1OP+GK+1k2Gd0wgD9B1uk+DiI+orL9Y04lQ7vn2ZhyYlFPBw8P
 re/8jztCWVtN5yMEtLpTnkAsS9qBznmqKdjbN8AV7mZniDhILKFuBfBPXZsl/d8kTFn4Y36U
 4jSdkaNDSaNzZHZKjBkW6F+q4bsaC6zJw=
X-Talos-CUID: 9a23:bqLfeWzuXzXsSlOxX7rLBgU3I+t6dkHC7kzUCEaSFHtwSLqPeXGPrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AT4g9jQ97Lc3FCvCCO9tbmKKQf+1k36WODW0rq88?=
 =?us-ascii?q?Hme6bLBQtHC6t0CviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107588278"
X-MGA-submission: =?us-ascii?q?MDEMn1fQGrvNv0gNlkCE9sQXDlEQURuiCwuft2?=
 =?us-ascii?q?ACzGXRBqfctLGeTn4TM3Jav33X9pp87NuPWUXojjkkhyW7DdZCQmHnCK?=
 =?us-ascii?q?7nIBb/S5SBILVVQN9VEte2TO+JPBZm47N01HVmNaU3hMLOxy4J8iLRx6?=
 =?us-ascii?q?YqLoenlUCjlTdG1fTmuxP9ng=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 28 Jan 2025 19:22:04 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 367E92037182;
	Tue, 28 Jan 2025 10:21:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 367E92037182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088519;
	bh=cIG2dfkqcecUU0JqZpchlOURAaCdxgZkNT0UTt4bvLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i1P5CteIH6opQQHIehVjxxbMtebMN7rXuNwBXMSI0asiaK5CTudtXAgtKgnK6I75c
	 1ngX/e4Oyj1B1vWMI4mQPUPmJ8cuPN3FTRVbcAp1DyhUYo8gGu4rDV59iA6QKrL9uC
	 BkxdKeiMaFW1YdRdBrMCMMVni2EQgoLc5InCNfZg=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-12-9a6ecf0b2308@linux.microsoft.com>
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
Subject: [cocci] [PATCH 12/16] spi: spi-fsl-lpspi: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2286
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-12-9a6ecf0b2308%40linux.microsoft.com>

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

