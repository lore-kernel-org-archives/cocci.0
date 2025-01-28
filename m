Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37B8C02192
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rV0pV6uCo+L2WatPjWritu1rnlahIFpB3WVk2Ubag/g=;
  b=Ytx3Y7XFpL/42uQfRl/ZTvqyiWGwg3Jq4VDcJoLTa9+dE0oSjwtd1wVA
   EB9ZD8cn8a+EOM4kLAU49addx+jwo8sjdWsu05NmOjnYmeWVmhmbrQvAl
   mX5kuIo4/K7EFDzcf6lSKzACmsJhfpYtd7MMhkjms6rU6ZIRhUtKlA79m
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
   d="scan'208";a="205449860"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7240EE0D2B; Tue, 28 Jan 2025 19:22:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1B87CE00A5
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:01 +0100 (CET)
IronPort-SDR: 67992048_whzgNUD+6AELWuSGzCijM6L7dLe1+6eQWNwhLVlWBR9rarA
 8Es4WHt1xtjYE7ANdL4aHN6mQxmHWJnu4dzOpyQ==
X-IPAS-Result: =?us-ascii?q?A0EgAACtH5lncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVJkE+BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?nUCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIdAQE3AQ8ZDAImAgJGEAYBEoMCgmUGAqIyAYdgAQECiyOBMoEBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhNAYFsg387CYM5eicbgUlEgUqBBoIthFiDRoJpgjOBRYNvo?=
 =?us-ascii?q?R0JP4EFHANZLAFVEw0KCwcFZFU4AyALCwwLFBwVAhQdDwYQBG1EN4JHaUk3A?=
 =?us-ascii?q?g0CNYIeJFiBHYEOhFyERWAvAwMDA4M4gkVUgkSCFHqBF4ZCHUADCxgNSBEsN?=
 =?us-ascii?q?wYOG0MBbgecXTyEA4EOmXyNSaFuhCWhYAEyqlMuh2SQaiKoWoIYOoFcRgcjF?=
 =?us-ascii?q?YMiTwMZD44hg3qPPQG6C0M1PAIHCwEBAwmFRgEBilGBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:Mb4DVaOy6j1d7MBcTvujsMiBIKoaSvp037Dk7TEWdfUzSL36qy
 nOppQmPX2dslwssRQb9OxoV5PufZqxz/JICMwqTNOftWrd2VdAUrsSj7cKqgeIc0bDH6xmpM
 JdmsNFZuEYY2IK6voSmDPIauod/A==
X-Talos-CUID: =?us-ascii?q?9a23=3A4c0uE2i89cMAgV3T8p4TaVPjnTJueF+azS+LD3C?=
 =?us-ascii?q?EFk1KWaaHFlDIyrs5nJ87?=
X-Talos-MUID: 9a23:IheCuAa/NRQWf+BTmi7+oz9aPfxUyIe/UEFKrJ4lgeeEHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205449844"
X-MGA-submission: =?us-ascii?q?MDHujL+m4pREXdBLvuGRLjKEaOIiKv09qjUCh0?=
 =?us-ascii?q?hG5RnU0v39ZmgNHZ2XQzwh8VnAdAl7e/7zKbjpyKuOcJuiBm4rT+iFO5?=
 =?us-ascii?q?63e31QBn6+Rkn6AvQjpqRuKEku41qR5DvesBR5dQusyLWU0R7K72mzhn?=
 =?us-ascii?q?zHicfFt4HdWPWKo7GeF+MW9w=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:21:59 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 82D962037176;
	Tue, 28 Jan 2025 10:21:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82D962037176
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088517;
	bh=rV0pV6uCo+L2WatPjWritu1rnlahIFpB3WVk2Ubag/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MpuX2sNpGSPCvn8+X9FT8BIYX1CfONbQBAPmYcXzwcby57+iq8EKvUSw9yit4i+7h
	 dPFF//UAxR4uzIgeiuRZT3KuJxDL9DDxO1Shj3JGkr9ECePLei7FWUPWNCb9Vm85BJ
	 TYvfPkoReBWVf1lpVq62IZLjI7cVTJ7HW4ILEEko=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308@linux.microsoft.com>
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
Subject: [cocci] [PATCH 01/16] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2272
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308%40linux.microsoft.com>

Teach the script to suggest conversions for timeout patterns where the
arguments to msecs_to_jiffies() are expressions as well.

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 scripts/coccinelle/misc/secs_to_jiffies.cocci | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
index 8bbb2884ea5db939c63fd4513cf5ca8c977aa8cb..ab9880d239f7d2a8d56a481a2710369e1082e16e 100644
--- a/scripts/coccinelle/misc/secs_to_jiffies.cocci
+++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
@@ -11,12 +11,22 @@
 
 virtual patch
 
-@depends on patch@ constant C; @@
+@depends on patch@
+constant C;
+@@
 
-- msecs_to_jiffies(C * 1000)
-+ secs_to_jiffies(C)
+-msecs_to_jiffies
++secs_to_jiffies
+ (C
+- * \( 1000 \| MSEC_PER_SEC \)
+ )
 
-@depends on patch@ constant C; @@
+@depends on patch@
+expression E;
+@@
 
-- msecs_to_jiffies(C * MSEC_PER_SEC)
-+ secs_to_jiffies(C)
+-msecs_to_jiffies
++secs_to_jiffies
+ (E
+- * \( 1000 \| MSEC_PER_SEC \)
+ )

-- 
2.43.0

