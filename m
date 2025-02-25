Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3EAC021BB
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VGzSq/vFDjX4bdM3inKgi/ZFFDhHhBOzDHEuBXOOojs=;
  b=sOOhDthney5AcBNhcHLtjqhAXMxTf2032UhEyQb7/k10wxjc+zXkSpgY
   XIFJNKg7lWxeA+cpLxutqsxVCR2vO7FccV7Hu2boifLKhvdLmbN0li3jb
   0ppr0YS/ddhD0tDGU3lFhcA1Fh/zbQbIkDg60awEt9uH+BkKv2wv+W9f6
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
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210043654"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5B6DFE0D1F; Tue, 25 Feb 2025 21:28:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 85E54E0D1D
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:24 +0100 (CET)
IronPort-SDR: 67be2554_hqtOERxcepo+fBZ68/u/M8+AOr6MLk0bxCfOTlBZhqB8t5g
 8lLIwxkNonVWT12sdnUT+M2vnOOJtPncyEb8XmA==
X-IPAS-Result: =?us-ascii?q?A0ELAAAjJL5ncraaTQ1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDgVczBwhIhFaIHYlpi2CQS4FWFIEsPg8BAwFOAQIEA?=
 =?us-ascii?q?QEDBIUAAosSAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAGBDIV7DYJiAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINX?=
 =?us-ascii?q?gEBHgIBAxESBBkBATcBDxkMAiYCAkYQBgESgwKCZQYCnSwBh2ABAQKJcoExf?=
 =?us-ascii?q?zOBAYIMAQEGgmjZOIFlCYEaLgGITgGBbIN/OwmDOXonG4FJRIEVNYMzhARUg?=
 =?us-ascii?q?0aCaYIzgUCDbIZRhCSCYpoKCT+BBRwDWSwBVRMNCgsHBWRVOAMgCgsMCxIcF?=
 =?us-ascii?q?QIUHQ8GEARqQzeCRWlJOgINAjWCHiRYgR2BDoRUhENcLwMDAwODKoI/UYJCg?=
 =?us-ascii?q?hFxgRqJMoNjHUADCxgNSBEsNwYOG0MBbgegJTyEO4EOgScWlCeEGo1LoW+EJ?=
 =?us-ascii?q?aFiATKqVS6HZZBqIqhdghg6gVxGByMVgyJPAxkPiACGIYN6jz0BvDNDNTwCB?=
 =?us-ascii?q?wsBAQMJhUYBAYogBDCBSwEB?=
IronPort-PHdr: A9a23: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
 JK3w90=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZbLtpqF/08sOPFaBpLqE0seALOsnbusQ8zAXPo5KOHpom6uj5q
 OTdZUgtSMd6l4qMk3I/OrsBEDuexzhHPJOjbX5eI3SODUO21HIEGgd1/qB/9SIIUSXndK1l5
 0QFpSWY+efMbEVt7ec3ODBKadY/OW6
X-Talos-CUID: 9a23:tSqlnWwBKlBCvFuQNmQhBgVPG8UqQmzNk0yBCB/iAkQxE5OnQnGprfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AIpuKKA6+NDZdxnN5InYQTCvFxoxD3oK3VnsKiKw?=
 =?us-ascii?q?KkPmvGj5CZR6FgBi4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210043052"
X-MGA-submission: =?us-ascii?q?MDELg9jDadfkVa5XLVYrqaqobxnVpVQ6TIZOVE?=
 =?us-ascii?q?Dhr4wEGF8v/zea2FfefDIIJqENFycTfLkve2mCT1ScmpSqJrbeNl1IpC?=
 =?us-ascii?q?ylY5bHf5Jd6oBBJkZ80Somyutje55XxDMzvA8DGWp7TE7JPe5fC05o1n?=
 =?us-ascii?q?ZwDZOMaGzRuO2FBNlBJ9ZPQw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:17:23 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 45AC820460A7;
	Tue, 25 Feb 2025 12:17:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45AC820460A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514640;
	bh=VGzSq/vFDjX4bdM3inKgi/ZFFDhHhBOzDHEuBXOOojs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NUya4tRaF9277cBwhYqQO7yzS8lMnqfHV5bhsseG/CtxWPz/gV8ztZR14fqeo6LgV
	 741al7zU+/EmCxYJ5lbwC/kdZB/J4wUtoYc96e0caxkwVbHT9BUlIVjAK1s/XVAu/j
	 GKc43d43v39nGwyqXko3AU4FfwpCRelgSKOuWoY0=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-4-a43967e36c88@linux.microsoft.com>
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
 Easwar Hariharan <eahariha@linux.microsoft.com>, 
 Takashi Iwai <tiwai@suse.de>
X-Mailer: b4 0.14.2
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3 04/16] ALSA: ac97: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2431
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-4-a43967e36c88%40linux.microsoft.com>

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

Acked-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 sound/pci/ac97/ac97_codec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 6e710dce5c6068ec20c2da751b6f5372ad1df211..88ac37739b7653f69af430dd0163f5ab4ddf0d0c 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2461,8 +2461,7 @@ int snd_ac97_update_power(struct snd_ac97 *ac97, int reg, int powerup)
 		 * (for avoiding loud click noises for many (OSS) apps
 		 *  that open/close frequently)
 		 */
-		schedule_delayed_work(&ac97->power_work,
-				      msecs_to_jiffies(power_save * 1000));
+		schedule_delayed_work(&ac97->power_work, secs_to_jiffies(power_save));
 	else {
 		cancel_delayed_work(&ac97->power_work);
 		update_power_regs(ac97);

-- 
2.43.0

