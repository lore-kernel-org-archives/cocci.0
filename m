Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0D0D68BDB
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mjGmNlPTDeXtBIVnBruZVxnncRcSbkg/ti9M5w2fu78=;
  b=GGnkHtXN5FZWX+doXMRqbYDhmm0n+PRBWUfz1w8Uuzi2l/1A8MYbiN7/
   tfinT1VzIOVVCs0iI0Pmy9Syp1X/2OhMFp18zkg5byJW+OJNRI21VGj5g
   J8uNQixkkpnmYtxTLhMoPRJVZNzXJE0vCymbO3woz/D76+/PX/f+UMnXt
   M=;
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
   d="scan'208";a="194169097"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:35:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6AF70E013D; Fri, 15 Nov 2024 23:35:45 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 69DF7E00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:47 +0100 (CET)
IronPort-SDR: 6737bba5_+41ILa7QFp4dn5HpjL0lxLhDBlZ78OEIYmTPGmqfrDkcpBb
 oScvbiGZwcAsTmB1fgPT+29rdCh37DKrfNkqmvA==
X-IPAS-Result: =?us-ascii?q?A0EgAABAujdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVhSBLD4PAQMBTgECBAEBAwSBTIM0A?=
 =?us-ascii?q?opLAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAGBD?=
 =?us-ascii?q?IV7DYJiAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEBHgIBA?=
 =?us-ascii?q?xESHQEBNwEPJQImAgJGEAYBEoMBgmUGAp9MAYdgAQECiyOBMoEBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBFTWBBoIthAZSg0aCaYdYhSuDe?=
 =?us-ascii?q?Zl4CT+BBRwDWSERAVUTDQoLBwVjVzwDIm9qU3orgQuBFzpCgTuBEy8bIQtcg?=
 =?us-ascii?q?SmBGhQGFQSBDkY/gkppSzcCDQI2giQkWYEdgTKFGoRsZy8DAwMDgzyCTmQuH?=
 =?us-ascii?q?UADCxgNSBEsNQYOG0MBbgefAkaDNIEOmXuNQqFrhCShXQEyqk4uh2SQZSKoV?=
 =?us-ascii?q?IIYOoFcRgcjFYMiTwMZD44hg3qPPgG2GUM1OwIHCwEBAwmFRgEBig+BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:lukxn6xF2OG/GjUCaCAPKrPwFr1zdoMgy1knxilNoNJuA6qlfq
 eV7ZcmPH7P6Ar4Ohkb8+xoXZPsfZqyz/FICOUqUYtKGTOW3FdAT7sC0WKd+UyDJ8SWzIc0vp
 uIMZIObeEYZmIVsS+V2njeLz9Z+qj/zJyV
X-Talos-CUID: 9a23:7KCgXGB5UCuVIqv6E2o/yU4QE8onSXvi7lfoAnGeFT51Y7LAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Am3nQTA8zUSBN/Py6qE7XslCQf5lJpPyOJGMwqok?=
 =?us-ascii?q?tmsuGdgBsIS24iA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101770972"
X-MGA-submission: =?us-ascii?q?MDG2dfrC1GHBVi4B01P/RRm/0pDbgBOXB1wLtA?=
 =?us-ascii?q?bPII8E4czndMwQYZcxUYr1Coel/SJuw92QcMicJGLgaA8j+ldgb8MZCU?=
 =?us-ascii?q?i2iDZbkWPaZi0vJPJG5tcyu6BAMqylED8PCO5t8Eel+M/S64uz9ywvLR?=
 =?us-ascii?q?0v5hExO72KptZTWB+i6Zu2HQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:22:45 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 49A20206BCE5;
	Fri, 15 Nov 2024 13:22:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 49A20206BCE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705762;
	bh=mjGmNlPTDeXtBIVnBruZVxnncRcSbkg/ti9M5w2fu78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Oh5o3W+QiJRTTPFI9dpb9A1AWSAOLDDOB8sqUPea54Qx6kUKHNmkqaArwACWjQxKB
	 D55Uc4+WAewzxsbEk8laNjMjSMPfVawB+Zi45VRw0skgegejDy9IgBYr/0jKgvvqvH
	 DeGMefeFQkwrmneQNUkhORZAjpQMci1rsg92zUBA=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-2-19aadc34941b@linux.microsoft.com>
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
Subject: [cocci] [PATCH 02/22] coccinelle: misc: Add secs_to_jiffies script
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2005
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-2-19aadc34941b%40linux.microsoft.com>

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

