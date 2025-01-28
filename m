Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC1FC0219C
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MrRoSF+FOHzMLN/F6LhKtUoOtRK4Dvpw4z2TjFgN7VQ=;
  b=rpCezamqMzFxECf7eEEDRBsKstAH8Kl1+KhsY3e66+PV9mPv5bKKS9eV
   kiVaZIyrVf09nDZ2piwmG19eMpudhe+kS/lNpShFJ8sptEqAwQFOr+GOR
   cCo02WsvvjcNMg4W6TJE1lJ7qNQ/tgNi7obY0VoNFi+AsvYKSNB8Ewl3M
   o=;
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
   d="scan'208";a="205450266"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3FF00E0D7E; Tue, 28 Jan 2025 19:22:17 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 341AFE0D23
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:05 +0100 (CET)
IronPort-SDR: 6799204c_a3Q1aYaQavsOVBFBt4koJrHKZ1kkkQlhabWMQi6AhyxA9BC
 Z7pSa8RkF4PcokfijCj2CkCo3Z4ARb48EaPqODw==
X-IPAS-Result: =?us-ascii?q?A0EgAACtH5lncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVJkE+BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?nUCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIdAQE3AQ8ZDAImAgJGEAYBEoMCgmUGAqIyAYdgAQECiyOBMoEBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhNAYFsg387CYM5eicbgUlEgUqDM4QKToNGgmmCM4FFg2+Ie?=
 =?us-ascii?q?5giCT+BBRwDWSwBVRMNCgsHBWRVOAMgCwsMCxQcFQIUHQ8GEARtRDeCR2lJN?=
 =?us-ascii?q?wINAjWCHiRYgR2BDoRchEVgLwMDAwODOIJFVIJEghR6gReGQh1AAwsYDUgRL?=
 =?us-ascii?q?DcGDhtDAW4HnF08hAOBDoEnlDyEGY1JoW6EJaFgATKqUy6HZJBqIqhaghg6g?=
 =?us-ascii?q?VxGByMVgyJPAxkPiACGIQwWFoNCjz0BugtDNTwCBwsBAQMJhUYBAYodBDCBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:1Anxtam9d/gPglm6szf3GVkn8hvpDfIW3DAbv31ZSRFFG/FwWf
 re+sjzsiWE6wr5OUtBpTjjUJPrfZq4z/NICOYqUotKMDOLhILsFvAH0WKA+Vzd8lPFh4xgPM
 5bGsAUNDSzNykesS+Q2meF+rgbsb66GdiT9J7j80s=
X-Talos-CUID: =?us-ascii?q?9a23=3AeP9mO2jWd9jN2+9SjsDaJb1lKzJueHb3ljSIDBa?=
 =?us-ascii?q?BJEl3Qrmfclqa6axEnJ87?=
X-Talos-MUID: 9a23:TdybEgTglOq3L2n0RXTetmw5H5lHu5iuAVwrjZsgldDDFBBvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107588279"
X-MGA-submission: =?us-ascii?q?MDGZzBYWdfU1Hvitn2tCPape4L0ce6sfPdyBFC?=
 =?us-ascii?q?fwJ0ZwXCE8wil02iFrZKmZJ8JN2LwuOhm6TCzzIXmJptb4iBrVrwh0YH?=
 =?us-ascii?q?tHE+BhTdi1TW79Gruxeh3lmxZUiBViqaFAP4bHjhX6rZBDFQftA7Ghvw?=
 =?us-ascii?q?8DZDz818d6w1uv41+0XoaifA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 28 Jan 2025 19:22:04 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9DEDF2037186;
	Tue, 28 Jan 2025 10:21:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9DEDF2037186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088519;
	bh=MrRoSF+FOHzMLN/F6LhKtUoOtRK4Dvpw4z2TjFgN7VQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VDOJ0UVcB3tdWtv0kEPgju6P8XjLVhI9v/FwUwQueJEftvBCu5K7f+pdk59MpNfkK
	 ZNizZYJyPBz3Enx9ehl7deE8rXReMEi7MKIck08fnn53suV4apwJE6v0a75dbsKot1
	 FOlMM/x/cVOz5FAhrxA1C4ODo0Fz3V/+H2e0Wt4U=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:22:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-15-9a6ecf0b2308@linux.microsoft.com>
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
Subject: [cocci] [PATCH 15/16] platform/x86: thinkpad_acpi: convert timeouts
 to secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2287
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-15-9a6ecf0b2308%40linux.microsoft.com>

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
 drivers/platform/x86/thinkpad_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 1fcb0f99695a78d392ed000b0831eb4d45eff55f..500b497c3f375f463f014ed3f3361afc9d6f3329 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8505,7 +8505,7 @@ static void fan_watchdog_reset(void)
 	if (fan_watchdog_maxinterval > 0 &&
 	    tpacpi_lifecycle != TPACPI_LIFE_EXITING)
 		mod_delayed_work(tpacpi_wq, &fan_watchdog_task,
-			msecs_to_jiffies(fan_watchdog_maxinterval * 1000));
+			secs_to_jiffies(fan_watchdog_maxinterval));
 	else
 		cancel_delayed_work(&fan_watchdog_task);
 }

-- 
2.43.0

