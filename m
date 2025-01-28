Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE86C02194
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DdLbmsRzgWLdzC2fj6O2CIX1t5gGJspI8Pgb54drLsE=;
  b=hPFuBY8ZDyi9/cHvYnI5O6I2TAodMkr0YyB3FEO3DAHz0bgjSt2IxN06
   0UxMG+FAWSKpNPXDDFkrw5jvmaSvpx5DuNcCbQpnW7sZ350f0lt6PQAiW
   DZt4uKog9mwPFI4a/2E61wtCeCKu5oREkol34fpz70Iw8/uPbW7Y/KAN8
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
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205449990"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DC26FE0D5B; Tue, 28 Jan 2025 19:22:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C04EDE00A5
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:02 +0100 (CET)
IronPort-SDR: 6799204a_RkOZsDBtfMa1Sr7QlTwg5m+Ld5aJHnybTzVMeV2wtJ/0fF/
 mnUe35TXT6uI7/keJaWwc97jPzegD3yIOtGWyQQ==
X-IPAS-Result: =?us-ascii?q?A0EgAACtH5lncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVJkE+BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?nUCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKiMgGHYAEBAosjfzOBAYIMAQEGg?=
 =?us-ascii?q?mfZOIFkCYEaLgGITQGBbIN/OwmDOXonG4FJRIFKgQaCLYRYg0aCaYIzgUWDb?=
 =?us-ascii?q?6EdCT+BBRwDWSwBVRMNCgsHBWRVOAMgCwsMCxQcFQIUHQ8GEARtRDeCR2lJN?=
 =?us-ascii?q?wINAjWCHiRYgR2BDoRchEVgLwMDAwODOIJFVIJEghR6gReGQh1AAwsYDUgRL?=
 =?us-ascii?q?DcGDhtDAW4HnF08hAOBAQ2BJ5Q8hBmNSaFuhCWhYAEyqlMuh2SQaiKoWoIYO?=
 =?us-ascii?q?oFcRgcjFYMiTwMZD4gAhiEMFoNYjz0BugtDNTwCBwsBAQMJhUYBAYpRgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:E54tO6MtvRrP1cBcTvujsMiBIKoaSvp037Dk7TEWdfUzSL36qy
 nOppQmPX2dslwssRQb9OxoV5PufZqxz/JICMwqTNOftWrd2VdAUrsSj7cKqgeIc0bDH6xmpM
 JdmsNFZuEYY2IK6voSmDPIauod/A==
X-Talos-CUID: 9a23:QO+/p2+7B3VIMRvVvLmVvxEpJcZ8QyH3923JJHG6Ll00UrS6E2bFrQ==
X-Talos-MUID: 9a23:I05UyARCp5FVA5YARXTLpit/HcNP2J6WDV8nsKsBvMWVBTV/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107588261"
X-MGA-submission: =?us-ascii?q?MDH/jHAswM4kuUwLswu3531pmfP3nqxKs1lTWz?=
 =?us-ascii?q?aZH5eAu6ZsXlyxoFOhEiluyTdHBLcDyY8U0vemGyxESv/Jd3XlZRFfD7?=
 =?us-ascii?q?lT+0o9Jothwy8d1L6iycNSb6FwjFhJV3JVeIIXGAs4JqSt1l7OjjdjtY?=
 =?us-ascii?q?cXnXv3k6DC/EcYLawSKZYlxw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 28 Jan 2025 19:22:02 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 91DF1203717E;
	Tue, 28 Jan 2025 10:21:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 91DF1203717E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088518;
	bh=DdLbmsRzgWLdzC2fj6O2CIX1t5gGJspI8Pgb54drLsE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y6ylpiLi1KVZ08WiTao/OJYzlh6hCYH9M4Lti7xtSLDcF9isW5mseElvLmHpIZ8qP
	 x/5hoAPvzc6Kc/w4ySGEyIVQMvEw8hunjl0cSDD/bAeaa2sgqpNFi8a/A/eDwTMxh5
	 TRAFAiqE6+9cKOciP+b85ff4KZYaPvXJLO+fVtn0=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-8-9a6ecf0b2308@linux.microsoft.com>
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
Subject: [cocci] [PATCH 08/16] libata: zpodd: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2277
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-8-9a6ecf0b2308%40linux.microsoft.com>

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

