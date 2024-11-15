Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C1ED68BE2
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mjGmNlPTDeXtBIVnBruZVxnncRcSbkg/ti9M5w2fu78=;
  b=fpJmUnmHpaQ2mV80O5xfiDFZV2rJ/3MCdQzTfwUtswelGlqDnAJ3Ej34
   v05lq9SlVxcmiwGDjFesqwpae2RUiNRwWwkuYpfGfQKpzI9ZOt9b0LWDk
   5JQ8EPBwTdaYUw8bUYq4atTcRTcSJBUBNo+bNYAW/R4Qd9hMqM7PPlYh4
   Y=;
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
   d="scan'208";a="194169826"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A1FC9E0E59; Fri, 15 Nov 2024 23:35:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BC5EFE013D
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:26:43 +0100 (CET)
IronPort-SDR: 6737bc93_IIAq5YQYYXXpDvCnjcS0+idTyNRRBPMEwSDvQWfjJ2PDzHr
 T/+LHI0zhju7ionoIRD4KYhP0Y7yqQbWlLLQAkw==
X-IPAS-Result: =?us-ascii?q?A0EgAABHuzdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVhSBLD4PAQMBTgECBAEBAwSBTIM0A?=
 =?us-ascii?q?opLAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAGBD?=
 =?us-ascii?q?IV7DYJiAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEBHgIBA?=
 =?us-ascii?q?xESHQEBNwEPJQImAgJGEAYBEoMBgmUGAp9NAYdgAQECiyOBMoEBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBFTWBBoIthAZSg0aCaYdYhSuDe?=
 =?us-ascii?q?Zl+CT+BBRwDWSERAVUTDQoLBwVjVzwDIm9qU3orgQuBFzpCgTuBEy8bIQtcg?=
 =?us-ascii?q?SmBGhQGFQSBDkY/gkppSzcCDQI2giQkWYEdgTKFGoRsZy8DAwMDgzyCTmQyH?=
 =?us-ascii?q?UADCxgNSBEsNQYOG0MBbgefBEaDNIEOmXuNQqFrhCShXQEyqk4uh2SQZSKoV?=
 =?us-ascii?q?IIYOoFcRgcjFYMiTwMZD44hg3qPPgG2HkM1OwIHCwEBAwmFRgEBig+BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:uQ3536j/yQPULW1MYD6Z4+qyAnBQXuAji2hC6mlwRA09TyVXrb
 HJoB19726WtN9xYhEdcbLpAsO9qBbnmKKdjrN/AV7PZmXbUS6TXeVfBOjZogEIZReOlNK1vJ
 0IG8ND4Z/LfD1HZK3BjjVQfexQp+VviJrY/Nvj8w==
X-Talos-CUID: 9a23:2+MM0m6OwU4YlCa2W9ss92RKQscaTHPk6S2LPkrjAD1Cd6KHRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AsWtmOA4c1Df7s2Hv+GhR8sCNxox626efNGBKtK8?=
 =?us-ascii?q?ilM6KNANCAQbNsgWeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101771119"
X-MGA-submission: =?us-ascii?q?MDGPujSVvnTwyM5dWUVlH/pOpXQwt3THW6Cquh?=
 =?us-ascii?q?oibEgwmsi4t5GT0gDozsUVI/VRBFAFKLujr1x3a30jWskip9eSX/oQGD?=
 =?us-ascii?q?N23SrpA9K1ps0hH6BehQ+jNnFGZ/TLVUuuNE5M1fpTRgVc9GIDJgKwYR?=
 =?us-ascii?q?Gnmu8NxoHszO0V5NJ144g2KA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:26:43 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 669E7206BCF5;
	Fri, 15 Nov 2024 13:26:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 669E7206BCF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706001;
	bh=mjGmNlPTDeXtBIVnBruZVxnncRcSbkg/ti9M5w2fu78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U/gvH0lzaLER5CbzPB6zD06w9Keq1U18T2/iQ93vXhu6AQN4lJ3/X3Ps8tBq+V9hU
	 8JfV3K4VKfGl26W2AQ+6bKbYPc1Tg7Mcqod+tAQYKeaUhj6tHi9CdVz4KsBV+7LMZi
	 VJMS6VhHAm7J/udfK+gDmWasBhF364IpIQjqUPkc=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:26:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v2-2-911fb7595e79@linux.microsoft.com>
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
Subject: [cocci] [PATCH v2 02/21] coccinelle: misc: Add secs_to_jiffies
 script
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2030
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v2-2-911fb7595e79%40linux.microsoft.com>

Suggested-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 scripts/coccinelle/misc/secs_to_jiffies.cocci | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
new file mode 100644
index 0000000000000000000000000000000000000000..af762b1c0aac8f044f21150bfaafd9efc834ee87
--- /dev/null
+++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Find usages of:
+/// - msecs_to_jiffies(value*1000)
+/// - msecs_to_jiffies(value*MSEC_PER_SEC)
+///
+// Confidence: High
+// Copyright: (C) 2024 Easwar Hariharan Microsoft
+//
+// Keywords: secs, seconds, jiffies
+//
+
+@@ constant C; @@
+
+- msecs_to_jiffies(C * 1000)
++ secs_to_jiffies(C)
+
+@@ constant C; @@
+
+- msecs_to_jiffies(C * MSEC_PER_SEC)
++ secs_to_jiffies(C)

-- 
2.34.1

