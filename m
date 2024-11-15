Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7C8D68BDD
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=z5d0KiQ+mxHfS/dtMsbc4ttBd/lyUqPHYPOKqCM1B/M=;
  b=eXda2GNphdQQPveioho2WHmFWbCpZTq3hHQTqP4U/IpNL50MBw/D5ZEo
   TjRxcjGqSgbv6qcKnunz+ALmtpeatRQURmDr5rlyA1BuyMM10d8o6V5SC
   /JqxixDgcG52zHXNmJKNm2+c29gBA0nr3x9DITWo4c/Nxf4riY1en4KLa
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
   d="scan'208";a="194169295"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:35:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7A47DE0D74; Fri, 15 Nov 2024 23:35:48 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 77C06E0D1F
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:49 +0100 (CET)
IronPort-SDR: 6737bba9_Hs1CUGhlWdVGPCC/LtRX/8N0WKss6ghCMEgZLW/5Kb0r1fC
 KIjcyYt9aT0baTauy4kEjYp8XS0ZmVkCu4MqcBA==
X-IPAS-Result: =?us-ascii?q?A0EgAABAujdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPJQImAgJGEAYBEoMBgmUGAp9MAYdgAQECiyN/M4EBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBSoEGgi2ECk6DRoJpgkWFEyWFB?=
 =?us-ascii?q?oN5gW+MBB0zgjmIfAk/gQUcA1khEQFVEw0KCwcFY1c8AyJvalN6K4ELgRc6Q?=
 =?us-ascii?q?oE7gRMvGyELXIEpgRoUBhUEgQ5GP4JKaUs3Ag0CNoIkJFmBHYEyhRqEbGcvA?=
 =?us-ascii?q?wMDA4M8gk5kLh1AAwsYDUgRLDUGDhtDAW4HnwJGgzSBDoEAmHuNQqFrhCShX?=
 =?us-ascii?q?QEyqk4uh2SQZSKoVIIYOoFcRgcjFYMiTwMZD44hg3qPPgG2GUM1OwIHCwEBA?=
 =?us-ascii?q?wmFRgEBiVs0gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:pXqlT6HohGxkrvQcpLqE0seALOsnbusQ8zAXPo5KOHpom6uj5q
 OTdZUgtSMd6l4qMk3I/OrsBEDuexzhHPJOjbX5eI3SODUO21HIEGgd1/qB/9SIIUSXndK1l5
 0QFpSWY+efMbEVt7ec3ODBKadY/OW6
X-Talos-CUID: =?us-ascii?q?9a23=3AJaYBeWqA3JgS2PbYOAPEyQPmUed4bSH4kUraGG6?=
 =?us-ascii?q?DKXkwV6ekWUHI0bwxxg=3D=3D?=
X-Talos-MUID: 9a23:PyUH2wYxwCmEBOBT7TPP1DZZN/ZT8fqlUnwUiI4FuPiKOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101770981"
X-MGA-submission: =?us-ascii?q?MDE7FJ6wL/NOHY12R5pVWLM6r/+nLpUiyKQ7t+?=
 =?us-ascii?q?7Y0o6BH+s1yiIpbijG482EWPWZACjd/KG2SMVC13X509bP4fJnXC3qBe?=
 =?us-ascii?q?Nd56ojOVqKjtizktSUDD+0vIggwi1JkPhb8WpGAJG6LmvNupjRm8zUyg?=
 =?us-ascii?q?/yLkALUxJcMnKPKFnJTjL6Rw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:22:49 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id C16E420BEBD0;
	Fri, 15 Nov 2024 13:22:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C16E420BEBD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705763;
	bh=z5d0KiQ+mxHfS/dtMsbc4ttBd/lyUqPHYPOKqCM1B/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VBP5tE+91MUeXr01PKBwol/kwfSOvrGFcon5R6GLvth1r2SEL/vDLGmoM3VztkA/D
	 HDCC8H4UjO/VDL4my3JCQHRpPk1aNqcxHWoN43qx7hLXlHFWnlfQU1gMcNN2K2LO5S
	 3qBHgiY0qCMM5wc+rwKNzT/8mVMznrFpdjl06mtQ=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-9-19aadc34941b@linux.microsoft.com>
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
Subject: [cocci] [PATCH 09/22] drm/etnaviv: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2012
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-9-19aadc34941b%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
index 721d633aece9d4c81f0019e4c55884f26ee61c60..0f5a2c885d0ab7029c7248e15d6ea3c31823b782 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
@@ -100,7 +100,7 @@ int etnaviv_cmdbuf_init(struct etnaviv_cmdbuf_suballoc *suballoc,
 		mutex_unlock(&suballoc->lock);
 		ret = wait_event_interruptible_timeout(suballoc->free_event,
 						       suballoc->free_space,
-						       msecs_to_jiffies(10 * 1000));
+						       secs_to_jiffies(10));
 		if (!ret) {
 			dev_err(suballoc->dev,
 				"Timeout waiting for cmdbuf space\n");

-- 
2.34.1

