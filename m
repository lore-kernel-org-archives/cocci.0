Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844A5C19777
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IkZhwQnmhk/3MZ3WmRVfeHWvCbna6N7BrQR1jWwYokU=;
  b=AokKcrjyJtCfWtektP7M/fACYTF+hXyAomkOtCnsHFBx5FybOswBchia
   1CuH2Cc7GscaG6thpzkcPxLv2k89OdF8DSbpzwtE+EefTyKYFDsQ6doNC
   9yQkqmHegPqXIsXqSlUHXIynw+SBb0VVxqule1Bx1TroMBRuRRrlLFk/Q
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
   d="scan'208";a="210043974"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D0FFBE0DB6; Tue, 25 Feb 2025 21:28:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C37DFE0261
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:25 +0100 (CET)
IronPort-SDR: 67be2555_QJ3j4xx2sPcW1Mr7HEeNpptDm7KkvnK8uFO/LhkwszPQ0Wf
 9/My3rvTUtv8n+oUu4DK5pELe6h9gv/VNsGKAWw==
X-IPAS-Result: =?us-ascii?q?A0EDAAAjJL5ncraaTQ1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBwhIhFaIHYlpi2CQS4FWgUA+DwEDA?=
 =?us-ascii?q?U4BAgQBAQMEhQACixICHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QERAg1eAQEeAgEDERIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKdLAGHYAEBA?=
 =?us-ascii?q?osjfzOBAYIMAQEGgmjZOIFlCYEaLgGITgGBbIN/OwmDOXonG4FJRIFKgQaCL?=
 =?us-ascii?q?YRYg0aCaYIzgUCDbJ1liXwJP4EFHANZLAFVEw0KCwcFZFU4AyAKCwwLEhwVA?=
 =?us-ascii?q?hQdDwYQBGpDN4JFaUk6Ag0CNYIeJFiBHYEOhFSEQ1wvAwMDA4Mqgj9RgkKCE?=
 =?us-ascii?q?XGBGokyg2MdQAMLGA1IESw3Bg4bQwFuB6AlPIQ7gQENgSeUPYQajUuhb4Qlo?=
 =?us-ascii?q?WIBMqpVLodlkGoiqF2CGDqBXEYHIxWDIk8DGQ+IAIYhDBaDWI89AbwzQzU8A?=
 =?us-ascii?q?gcLAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
 A==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:kTTNt6na/rAvmW0uNArZSm3vlHjpDfIW3DAbv31ZSRFFG/FwWf
 re+sjzsiWE6wr5OUtBpTjjUJPrfZq4z/NICOYqUotKMDOLhILsFvAH0WKA+Vzd8lPFh4xgPM
 5bGsAUNDSzNykesS+Q2meF+rgbsb66GdiT9J7j80s=
X-Talos-CUID: =?us-ascii?q?9a23=3A1fjyT2hgpRhVPdxILzQIEriLaTJuUybH13ThOEm?=
 =?us-ascii?q?BIH9JVbjIV3SSqPM/nJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AFP5dlQ1UseFH3Km3OMk1OdBTWjUj56f/F24htbs?=
 =?us-ascii?q?6nsilDQF9KTOTlyqLe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210043058"
X-MGA-submission: =?us-ascii?q?MDFyH84cs62Y/wfqRADUrug+Ob1DNIb6fvG+XW?=
 =?us-ascii?q?1mkHaQuBUBNkIMX3FjeMFcbfADBbX46+9ZDP38SC2kfVKLcwvfjeFJRR?=
 =?us-ascii?q?9DkXCs59G3XMjsLP1IBGE7EM+Nalw+kl4B0j2ywnNFNPV9TQsO5fTk8k?=
 =?us-ascii?q?DIs+GCio4JCy8j3L0ot9ZBcA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:17:25 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id EE0A12069413;
	Tue, 25 Feb 2025 12:17:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE0A12069413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514641;
	bh=IkZhwQnmhk/3MZ3WmRVfeHWvCbna6N7BrQR1jWwYokU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PDr+YdzwKTpyZBicDKqcQQUqPL1iwuSQme5BjsML0hXlTVF9AZr0RQ2wXUwNPrDi5
	 2fLTg4V0dpM1tBw+RLkMSD0aTsmmkxoeSBgL2Xo1cPwMxPo/cff0ffzHQNbO3K0hfD
	 6uIhiei0TRTMFdIWngeYvXNz/apT7GwtHrM4bEfU=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-8-a43967e36c88@linux.microsoft.com>
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
Subject: [cocci] [PATCH v3 08/16] ata: libata-zpodd: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2439
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-8-a43967e36c88%40linux.microsoft.com>

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

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/ata/libata-zpodd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index 4b83b517caec66c82b126666f6dffd09729bf845..799531218ea2d5cc1b7e693a2b2aff7f376f7d76 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -160,8 +160,7 @@ void zpodd_on_suspend(struct ata_device *dev)
 		return;
 	}
 
-	expires = zpodd->last_ready +
-		  msecs_to_jiffies(zpodd_poweroff_delay * 1000);
+	expires = zpodd->last_ready + secs_to_jiffies(zpodd_poweroff_delay);
 	if (time_before(jiffies, expires))
 		return;
 

-- 
2.43.0

