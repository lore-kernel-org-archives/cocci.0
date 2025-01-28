Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7F6C02197
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mkn/3Lgtg54GNzaXlgwnQtoAqu7SMhloWS9nR/qJKuY=;
  b=AkCrvVuKLxNlEpebKEFsshnrqwRyPOE+ZEd+QUBRgCFI8VBGBSWpX/SY
   0Ltov/IwqO58xKga3ryR6H6QR1ztuFdvLXS3bqmvXhdvfRkiH7qLNNUsL
   PSdhnx0+DgErNv8PqcaRLQgrtrxOAcRxMC2x9Zdp4LK5NbjTLfxmU0eUM
   U=;
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
   d="scan'208";a="205450143"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0C9BEE0D33; Tue, 28 Jan 2025 19:22:15 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E591EE0D21
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:03 +0100 (CET)
IronPort-SDR: 6799204b_QLeNJ+T7Y3yK8Xp14OagWd8rMLqsP+FklNMR3BHQa5pNlsx
 nZmUtIKGXDXGruHyqpAXTnYjpoVqOmEnGEpH/ZA==
X-IPAS-Result: =?us-ascii?q?A0EgAACtH5lncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVJkE+BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?nUCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKiMgGHYAEBAosjfzOBAYIMAQEGg?=
 =?us-ascii?q?mfZOIFkCYEaLgGITQGBbIN/OwmDOXonG4FJRIFKgzOEWINGgmmCM4FFg2+hH?=
 =?us-ascii?q?Qk/gQUcA1ksAVUTDQoLBwVkVTgDIAsLDAsUHBUCFB0PBhAEbUQ3gkdpSTcCD?=
 =?us-ascii?q?QI1gh4kWIEdgQ6EXIRFYC8DAwMDgziCRVSCRIIUeoEXhkIdQAMLGA1IESw3B?=
 =?us-ascii?q?g4bQwFuB5xdPIQDgQ6BJ4F8kkCEGY1JoW6EJaFgATKqUy6HZJBqIqhaghg6g?=
 =?us-ascii?q?VxGByMVgyJPAxkPiACGIQwWg1iPPQG6C0M1PAIHCwEBAwmFRgEBilGBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:gMwASqBQ/zsuElTlHemW55DYdb4zR+YMi2TDGXoBLyC9Ffbo9P
 xG/c566feX4Ax6ZJhEo7290ca7Lk80maQY3WBVB8bHYOCEggqVxf9ZnOnfKlTbckWUygce79
 YET0EUMrPN5DZB/KHHCXGDYq8d/OU=
X-Talos-CUID: =?us-ascii?q?9a23=3APtg8oWq7y/Ar7tYstN6bA+DmUewKLEb6yimXGm6?=
 =?us-ascii?q?DC0M1Gbq+ShyP97wxxg=3D=3D?=
X-Talos-MUID: 9a23:YeyUYAvBwbTQ01bZD82nxxVQLZZw0fiUVkEjsKUsu/KiPw1VAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107588269"
X-MGA-submission: =?us-ascii?q?MDHo3+qR0UG/lDmUeXWrF/WUDJnsYJzo1VNNKR?=
 =?us-ascii?q?F6t6NqgaHzAtA9XuvvdvoNpsTHXzvwPCNGnbmvh06eaO5N/gDNmwuR4y?=
 =?us-ascii?q?UzX2K2JTmvDKAXOc/f+VCGjfWFpU5r/tXAnLnM/VXcbeh3TvfbYPAXz8?=
 =?us-ascii?q?GQ8PVzN4Fg4G8XLWszrqbQkg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 28 Jan 2025 19:22:03 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0FF192037181;
	Tue, 28 Jan 2025 10:21:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FF192037181
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088519;
	bh=mkn/3Lgtg54GNzaXlgwnQtoAqu7SMhloWS9nR/qJKuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cKEYru15Mtf5Q/kd1hSFKWBC52Cu5K/BLR2OJkWAzj2ZRqT7jwKiudaaP1oxpVDD2
	 Ch28OEl3D9iSWgJG7LiMGUZuZZPQ0TT3G25/suv+aMV6FU+12BnnbXEYRDXYc7j3CK
	 B5oP9zQfweGdZD0+cB+LjlH0pntkjNINNMAcz/8U=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-11-9a6ecf0b2308@linux.microsoft.com>
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
Subject: [cocci] [PATCH 11/16] nvme: convert timeouts to secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2283
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-11-9a6ecf0b2308%40linux.microsoft.com>

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
 drivers/nvme/host/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 76b615d4d5b91e163e5a6e7baf451c959a2c3cab..87498215ede4bcaf48660b89c901075dfcfaf041 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4459,11 +4459,9 @@ static void nvme_fw_act_work(struct work_struct *work)
 	nvme_auth_stop(ctrl);
 
 	if (ctrl->mtfa)
-		fw_act_timeout = jiffies +
-				msecs_to_jiffies(ctrl->mtfa * 100);
+		fw_act_timeout = jiffies + msecs_to_jiffies(ctrl->mtfa * 100);
 	else
-		fw_act_timeout = jiffies +
-				msecs_to_jiffies(admin_timeout * 1000);
+		fw_act_timeout = jiffies + secs_to_jiffies(admin_timeout);
 
 	nvme_quiesce_io_queues(ctrl);
 	while (nvme_ctrl_pp_status(ctrl)) {

-- 
2.43.0

