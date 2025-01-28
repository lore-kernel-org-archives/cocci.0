Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92870C0219C
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=++CcFDhMGmgcKwzaiNwx3lMiN5jr5twzkm9Lzfmspqc=;
  b=Trf1MKkXkPKyk2w7pPSSbhU4g2+E7+TF0+DiKQIKHhmJMsCQ3d8s+CLX
   NIWgZAfSfpDA9IykGnfdcl6M6c21/n3vI39f/3tXSY7bp/NEazvlq2zki
   wSDsmRECYoInZDXjNYvMJcpsw06vwLbOTE06XKnRyuv8N2Kg9/i4WVvyR
   Q=;
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
   d="scan'208";a="205450101"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BED1DE00B7; Tue, 28 Jan 2025 19:22:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6921EE0D20
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:03 +0100 (CET)
IronPort-SDR: 6799204a_LLTHgpAf+EL3+PnBYuXtUGsVdibq5FFPBcViuSSaknSQjli
 dCaOVLYvK9ZyVKersOrWmKpFj+vqhWf0B8T3btA==
X-IPAS-Result: =?us-ascii?q?A0EgAACtH5lncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVJkE+BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?nUCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKiMgGHYAEBAosjfzOBAYIMAQEGg?=
 =?us-ascii?q?mfZOIFkCYEaLgGITQGBbIN/OwmDOXonG4FJRIFKgzOEJTODRoJpgjOBRYNvi?=
 =?us-ascii?q?HuYIgk/gQUcA1ksAVUTDQoLBwVkVTgDIAsLDAsUHBUCFB0PBhAEbUQ3gkdpS?=
 =?us-ascii?q?TcCDQI1gh4kWIEdgQ6EXIRFYC8DAwMDgziCRVSCRIIUeoEXhkIdQAMLGA1IE?=
 =?us-ascii?q?Sw3Bg4bQwFuB5xdPIQDgQ6BJ5Q8hBmNSaFuhCWhYAEyqlMuh2SOCoJgIqhag?=
 =?us-ascii?q?hg6gVxGByMVgyJPAxkPiACGIYN6jz0BugtDNTwCBwsBAQMJhUYBAYpRgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:4fhBkas1hGIR+CifYxkjafuE7skDTNV00zEX/kB9WHVpmwKj5q
 aTdZMgpHzJYVcqOE3J+7i7UpVoJEmwyXcb2+Ys1NuZMDUO/VHYSL2KjrGC/9SfIVydygc178
 4JGJSWSueAaGSS5vyV3ODXKadG/DD+ytHQudvj
X-Talos-CUID: 9a23:VOD3RGyWwyT1WuCgh6q4BgUeEep/MSXylU79DFGyDWxSTbeERn+frfY=
X-Talos-MUID: 9a23:EcPeGgnf4mtUoI6dBerRdnolaPhC74mRVnwhnK84kpeALDNVFTiS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107588266"
X-MGA-submission: =?us-ascii?q?MDHCXT0ChxA7EBryqA8ko/GZbgsCkc04tHeg1K?=
 =?us-ascii?q?7qz13liWnZ/2nfiopwp32CuSJAqvvsMFveIUICnCObOkQVzWiy/D0P2i?=
 =?us-ascii?q?S6eUtWxEggvosBhCru/gVxKNcwlwBYyLDz/wMsSAI8Ej+u0NQxlfDeTv?=
 =?us-ascii?q?RvOMKSrlzvuB9Djzke16es5g=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 28 Jan 2025 19:22:03 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id DB2792037180;
	Tue, 28 Jan 2025 10:21:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB2792037180
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088518;
	bh=++CcFDhMGmgcKwzaiNwx3lMiN5jr5twzkm9Lzfmspqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nOvIreoPo3EtPXnqT78hdGSPjS+BJfm76bfob6LjYY8fpAzAx+SSWBMemjjxO+8RL
	 gtA/N4PvBwCgX5MwsErpmvFLEJEFEicnjVAtYs/DImfDKgiY3inNNwt6TIW4w8Mj2E
	 eLHR2MK1+CS1Dd52E6DvRE+gXgt4inmHotPghBSw=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-10-9a6ecf0b2308@linux.microsoft.com>
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
Subject: [cocci] [PATCH 10/16] power: supply: da9030: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2281
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-10-9a6ecf0b2308%40linux.microsoft.com>

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

