Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B03D68BE1
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QYs6jKNkSqRMwxas8zTGS0f9EDen03tWxmE1GsbmPvQ=;
  b=g2Rr/ZDsbKXeBb44VW77pWhz90spdxtbYp4BIwh5GHs4ABa92Jg2SmOg
   DbvZ5bTq3zNQscEmsXq5+4nZ0QSVGrXQl/5QJIUg3h4fRXCIgb20DGOZU
   jzrHjEyv5fsHM/sXBjjxIbNvr3zTQLRB3DgMdvLfxkxBRxuK+rGXjHnZb
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
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194169212"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:35:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E94E2E0D37; Fri, 15 Nov 2024 23:35:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2C8DDE00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:49 +0100 (CET)
IronPort-SDR: 6737bba8_2o4k8AimNBu0grFNyxnVLh/Rn5t6fcrzEWzkBNXHANzbCai
 w6khxHdsdp1zWro15zBIbAKbs5OSu0aUjf98/gg==
X-IPAS-Result: =?us-ascii?q?A0EKAABAujdncraaTQ1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDB?=
 =?us-ascii?q?IFMgzQCiksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eA?=
 =?us-ascii?q?QEeAgEDERIEGQEBNwEPJQImAgJGEAYBEoMBgmUGAp9MAYdgAQECiyN/M4EBg?=
 =?us-ascii?q?gwBAQaCZ9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBSoMzhFiDRoJpgkWEH?=
 =?us-ascii?q?XYlhQaDeZl4CT+BBRwDWSERAVUTDQoLBwVjVzwDIm9qU3orgQuBFzpCgTuBE?=
 =?us-ascii?q?y8bIQtcgSmBGhQGFQSBDkY/gkppSzcCDQI2giQkWYEdgTKFGoRsZy8DAwMDg?=
 =?us-ascii?q?zyCTmQuHUADCxgNSBEsNQYOG0MBbgefAkaDNIEPgyKSZYNzjUKha4QkoV0BM?=
 =?us-ascii?q?qpOLodkkGUiqFSCGDqBXEYHIxWDIk8DGQ+OIQwWg1iPPgG2GUM1OwIHCwEBA?=
 =?us-ascii?q?wmFRgEBig+BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:aKRHParlrkbLqruwod0X6msaV5oReYIsimQD101hICG9vPbo8f
 xG+85rtiMc6QxwZJlD8errBEDkex7hHPFOjrX5UY3PYOCighrNEGgA1+rfKkPbak/DH4dmvM
 8KT0E9MqyUMbEQt6jHCWeDYrEdKaG8gdmVuds=
X-Talos-CUID: 9a23:Q43xLm1csRiQYWhCVfBi+LxfIMsvYFvjwCfqI1KpF35SWu2YVEW29/Yx
X-Talos-MUID: 9a23:9CTNRAtaJSFU7b5B/M2n2D5oLthBwq+SIx4nwbsNvJGOLi1zEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101770980"
X-MGA-submission: =?us-ascii?q?MDFgqRkOqPaszVY5V+ZimXxSet6zuYEzcEVLr9?=
 =?us-ascii?q?nQoNHKS53elMYtK4oS7xqmkclf4TyOp2H7I2YcDDr0jKpJyxRvv52Igt?=
 =?us-ascii?q?kVTG81T22obStej9EkdOD+UZiG9R68ZdMqnFDexFbitj8bvGzrAypNc3?=
 =?us-ascii?q?aXglcw8vITVp1jvb+gNfnDTw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:22:48 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5C04E206BCEA;
	Fri, 15 Nov 2024 13:22:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C04E206BCEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705763;
	bh=QYs6jKNkSqRMwxas8zTGS0f9EDen03tWxmE1GsbmPvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I95I66JgO1E7XQYaEm7ineOx+2MkduTJSN9e4D1cu0/NE7dcCwPndmzh7i/cNGesc
	 2yzIBCvlbGPZzvMpNA+k96a1ZOGXJ+A0bPOMF6Lmuw/xKRtew/BB44Qgm554Xu3M7K
	 XgYk3aN7aTdB7omQICy4E1708sGRqDk4h4Xf8u4c=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-7-19aadc34941b@linux.microsoft.com>
References: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
In-Reply-To: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, 
 Oded Gabbay <ogabbay@kernel.org>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 James Smart <james.smart@broadcom.com>, 
 Dick Kennedy <dick.kennedy@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jack Wang <jinpu.wang@cloud.ionos.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Louis Peens <louis.peens@corigine.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, cocci@inria.fr, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, linux-mm@kvack.org, 
 linux-bluetooth@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, 
 live-patching@vger.kernel.org, linux-sound@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, oss-drivers@corigine.com, 
 linuxppc-dev@lists.ozlabs.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 07/22] accel/habanalabs: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2010
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-7-19aadc34941b%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/accel/habanalabs/common/device.c         | 2 +-
 drivers/accel/habanalabs/common/habanalabs_drv.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index e0cf3b4343bb081638430f2552ed27431b488ff9..30277ae410d4b742ffb7bddc35498564ff96fe62 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -817,7 +817,7 @@ static void device_hard_reset_pending(struct work_struct *work)
 		}
 
 		queue_delayed_work(hdev->reset_wq, &device_reset_work->reset_work,
-					msecs_to_jiffies(HL_PENDING_RESET_PER_SEC * 1000));
+					secs_to_jiffies(HL_PENDING_RESET_PER_SEC));
 	}
 }
 
diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index 708dfd10f39c584a6221c29015f4b0323574145a..5ec13f3a46f915e75b04582b28d51ba8bb50be78 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -362,8 +362,7 @@ static void fixup_device_params_per_asic(struct hl_device *hdev, int timeout)
 		 * a different default timeout for Gaudi
 		 */
 		if (timeout == HL_DEFAULT_TIMEOUT_LOCKED)
-			hdev->timeout_jiffies = msecs_to_jiffies(GAUDI_DEFAULT_TIMEOUT_LOCKED *
-										MSEC_PER_SEC);
+			hdev->timeout_jiffies = secs_to_jiffies(GAUDI_DEFAULT_TIMEOUT_LOCKED);
 
 		hdev->reset_upon_device_release = 0;
 		break;

-- 
2.34.1

