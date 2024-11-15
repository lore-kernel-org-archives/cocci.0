Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE5FD68BDA
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pCX0EpdqmyNkdZPLk4Z0q7m89NufhvHb1Y+2Mrmnnrk=;
  b=Cc9P8BzDL9UewKY6Hs2vL9apO3uVc7VMnJVprY+gHmKOsDcP7nmB8b/e
   7HVCJ+CXgOUWHtJR//1YR1ZjnZt1JA9wy9rNs5Nh6/3o3c1mTjsf/F4eE
   mi8M/nso8mFIiPP4+J3MsXzdBKkGZLIJScUWrv8OQbx74rlz2Q6pz2vTT
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
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194170001"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DD508E0DEF; Fri, 15 Nov 2024 23:35:59 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 697C6E00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:26:49 +0100 (CET)
IronPort-SDR: 6737bc99_QfX77ZxzPIO9d+BXVYa7h12VY6YZ8gwGcbopgpCyP88HDIC
 p262DdPUxE7QIWBR1H1UlqYu9ph/P2+g2hhS9mg==
X-IPAS-Result: =?us-ascii?q?A0EgAABHuzdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPJQImAgJGEAYBEoMBgmUGAp9NAYdgAQECiyN/M4EBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBSoMzhApOg0aCaYJFhRMlhQaDe?=
 =?us-ascii?q?Zl+CT+BBRwDWSERAVUTDQoLBwVjVzwDIm9qU3orgQuBFzpCgTuBEy8bIQtcg?=
 =?us-ascii?q?SmBGhQGFQSBDkY/gkppSzcCDQI2giQkWYEdgTKFGoRsZy8DAwMDgzyCTmQyH?=
 =?us-ascii?q?UADCxgNSBEsNQYOG0MBbgefBEaDFCCBDoJFlzaNQqFrhCShXQEyqk4uh2SQZ?=
 =?us-ascii?q?SKoVIIYOoFcRgcjFYMiTwMZD44hDBaDWI8+AbYeQzU7AgcLAQEDCYVGAQGJW?=
 =?us-ascii?q?zSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:eEngsqBMZIH5s77lHemW55DYdb4zR+YMi2TDGXoBLyC9Ffbo9P
 xG/c566feX4Ax6ZJhEo7290ca7Lk80maQY3WBVB8bHYOCEggqVxf9ZnOnfKlTbckWUygce79
 YET0EUMrPN5DZB/KHHCXGDYq8d/OU=
X-Talos-CUID: 9a23:CdjF925CFSKfHnZdWdss/087EO8ESFvh6HbyBBeqTjlwT5e/RgrF
X-Talos-MUID: 9a23:X6CQoghj7VtZW8DkwK2SZsMpc/l2wLSiAWk0u5Ac4uSIHgpaBRGeg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101771134"
X-MGA-submission: =?us-ascii?q?MDE0qmL0Ry2RyZtPf8RNjb1QfgnXaW+6L14Wp/?=
 =?us-ascii?q?CvMO6XslwRM6/6nAeAXOCP0vOvmqqPGs6S3/oj4/X1uf5NZEO99s4SZV?=
 =?us-ascii?q?CCLUxnubOS8hUYUOkDWoCjGsuhXc75QlcoKebFnZBVChBiGIb2Z0vN9U?=
 =?us-ascii?q?i23wwlcQQ7bbhNMW0mFLMdug=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:26:49 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id E651E23718AC;
	Fri, 15 Nov 2024 13:26:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E651E23718AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706004;
	bh=pCX0EpdqmyNkdZPLk4Z0q7m89NufhvHb1Y+2Mrmnnrk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eAVIrYLNHkRW1opV+l10sI01k9fp5RPobV2nEm7OQtZTXvL1OZpViQrABNURt8i3R
	 Lt5oz4EgCq0BgTDEpnRIgtHazGUHt44mhOWeQa6X66HXQwFE3odFdSj0nTsElRySJE
	 uoqOVSbVkxhvj88d1jkAwyWIgOOXRrS//ir9JXro=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:26:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v2-13-911fb7595e79@linux.microsoft.com>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
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
Subject: [cocci] [PATCH v2 13/21] xen/blkback: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2039
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v2-13-911fb7595e79%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/block/xen-blkback/blkback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 838064593f62b75f3d937c0c041ea78dedbbaf84..a7c2b04ab943de9cbd69b596aad177a0534f7762 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -544,7 +544,7 @@ static void print_stats(struct xen_blkif_ring *ring)
 		 ring->st_rd_req, ring->st_wr_req,
 		 ring->st_f_req, ring->st_ds_req,
 		 ring->persistent_gnt_c, max_pgrants);
-	ring->st_print = jiffies + msecs_to_jiffies(10 * 1000);
+	ring->st_print = jiffies + secs_to_jiffies(10);
 	ring->st_rd_req = 0;
 	ring->st_wr_req = 0;
 	ring->st_oo_req = 0;

-- 
2.34.1

