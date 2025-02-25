Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6858BC18E7C
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=20ohR9ydXU2pCwzgNxjjrd2yDVsQ48Ay1dojiJT8hzc=;
  b=c3RmTN036iiB4UU6pH4+8zh0RfFzVQbqLJ9Y73kGXn6UwfMmAR9fMbmQ
   voG9NhwQuaVYZSRTSCxh5jZ7p4DnhTaVTfFKfa/kY0NeapHCqv/03ccOz
   Wzj3aPxCheubeqdknNKWyvSCvFvYCgvVz8JVH9PVzgZKGyuWrbBanZAG7
   g=;
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
   d="scan'208";a="210043972"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C502AE0DB2; Tue, 25 Feb 2025 21:28:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 171D5E0D1D
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:26 +0100 (CET)
IronPort-SDR: 67be2555_pTpso4rJnCHKvNPqyaCg7ezImwigPk1qowWdkbthmp/Yc8R
 sDR+4IewKevfCjio6juokdLa+NKFdYbF6PMAemg==
X-IPAS-Result: =?us-ascii?q?A0ELAACfJL5ncraaTQ1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDgVczBwhIhFaIHYlpi2CQS4FWgUA+DwEDAU4BAgQBA?=
 =?us-ascii?q?QMEhQACixICHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eA?=
 =?us-ascii?q?QEeAgEDERIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKdLQGHYAEBAosjfzOBA?=
 =?us-ascii?q?YIMAQEGgmjZOIFlCYEaLgGITgGBbIN/OwmDOXonG4FJRIFKgzOEJTODRoJpg?=
 =?us-ascii?q?jOBQINsiGaeewk/gQUcA1ksAVUTDQoLBwVkVTgDIAoLDAsSHBUCFB0PBhAEa?=
 =?us-ascii?q?kM3gkVpSToCDQI1gh4kWIEdgQ6EVIRDXC8DAwMDgyqCP1GCQoIRcYEaiTKDY?=
 =?us-ascii?q?x1AAwsYDUgRLDcGDhtDAW4HoCU8hDuBDoEnlD2EGo1LoW+EJaFiATKqVS6HZ?=
 =?us-ascii?q?Y4KgmAiqF2CGDqBXEYHIxWDIk8DGQ+IAIYhg3qPPQG8NUM1PAIHCwEBAwmFR?=
 =?us-ascii?q?gEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 JK2w90=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ynBH+6yWPOdeiF8oLPsmKrPwFr1zdoMgy1knxilNoNJuA6qlfq
 eV7ZcmPH7P6Ar4Ohkb8+xoXZPsfZqyz/FICOUqUYtKGTOW3FdAT7sC0WKd+UyDJ8SWzIc0vp
 uIMZIObeEYZmIVsS+V2njeLz9Z+qj/zJyV
X-Talos-CUID: =?us-ascii?q?9a23=3AdoLE1GqK1WfUA4f3VCfjSCDmUcY0Y2Pww0b+GW6?=
 =?us-ascii?q?bVHsuaZHFYkSV8awxxg=3D=3D?=
X-Talos-MUID: 9a23:0IchxAqHuWmgxUNSZAkez2pAJt03vLWrM2EqwZIXmcq8LgVuYx7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="110053385"
X-MGA-submission: =?us-ascii?q?MDG2L3MHDbaWMZq7JCaV/8WgDUTzdRZLB+hOgF?=
 =?us-ascii?q?xiAZJ05hSJm7EQVIGG4kRJSFCO5lhxy544jnOScJgsLb/N/5CPLkpoHt?=
 =?us-ascii?q?U2HkhtOcYmzsQ4gcEZQIHmLQ4It1rqoaqM0icAtFqZLKt95MAkWB624x?=
 =?us-ascii?q?/zDLf9EZR41mTz1/mN6FtxUA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 25 Feb 2025 21:17:25 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4BD7A2069419;
	Tue, 25 Feb 2025 12:17:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BD7A2069419
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514641;
	bh=20ohR9ydXU2pCwzgNxjjrd2yDVsQ48Ay1dojiJT8hzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K0iLGq1rGc4Qg7xtebfYNMLt7AN2VvRrBSayFG3R2ubH/K1ImvnybXJrcnesEf8Va
	 cjRHQ1+ptab8tqVzdvfsEgqdZ2cuicdWCcfCnvxFiNuLLWeeATmmp/van3jz7hvAmZ
	 byfY8S+3q00hAqCMvFkJrtiZmQlqR3XmHjwAmbVw=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-10-a43967e36c88@linux.microsoft.com>
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
Subject: [cocci] [PATCH v3 10/16] power: supply: da9030: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2440
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-10-a43967e36c88%40linux.microsoft.com>

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
 drivers/power/supply/da9030_battery.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/da9030_battery.c b/drivers/power/supply/da9030_battery.c
index ac2e319e95179039279dacaed1744136f679fbac..d25279c260308b6c82acb2aabf44f3749f71b703 100644
--- a/drivers/power/supply/da9030_battery.c
+++ b/drivers/power/supply/da9030_battery.c
@@ -502,8 +502,7 @@ static int da9030_battery_probe(struct platform_device *pdev)
 
 	/* 10 seconds between monitor runs unless platform defines other
 	   interval */
-	charger->interval = msecs_to_jiffies(
-		(pdata->batmon_interval ? : 10) * 1000);
+	charger->interval = secs_to_jiffies(pdata->batmon_interval ? : 10);
 
 	charger->charge_milliamp = pdata->charge_milliamp;
 	charger->charge_millivolt = pdata->charge_millivolt;

-- 
2.43.0

