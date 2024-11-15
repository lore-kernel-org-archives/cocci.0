Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D773ED68BDA
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3U0Zq8t5krsiKxal+ZZuXq1UdnH4Ui7697JSzYEOhjI=;
  b=CgjKUJNEyVMJLIf+U3TyOXUmcpy0PlJZi2MMnCcDFT9JUss7kE/rKj4Y
   9hxhVlfJuM6O8NNQVXYK53eDQKV06fCS0ctw+i+DWr/kjjrBFVrRAvnJn
   aNaufpIJRmflZ02l94uF3yrgsir8uufGXsLcoP8giRSAoKzYQqdYEzFfF
   g=;
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
   d="scan'208";a="194169180"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:35:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A9BEFE0D60; Fri, 15 Nov 2024 23:35:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AAE18E0D1D
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:47 +0100 (CET)
IronPort-SDR: 6737bba6_uookIolccakGdzm0WAq8DzW3YwMcoylzqqGZfx457yWS88t
 ylSXOQBmRu7gJ2rVcr/aSJ5N9MPnHNUlEJDy6tQ==
X-IPAS-Result: =?us-ascii?q?A0EzAABAujdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDgVczBwhIhFadZJBNgVaBQD4PAQMBTgECBAEBAwSBTIM0AopLA?=
 =?us-ascii?q?h8GAQQxCA4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAGBDIV7D?=
 =?us-ascii?q?YJiAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEBHgIBAxESH?=
 =?us-ascii?q?QEBNwEPJQImAgJGEAYBEoMBgmUGAp9MAYdgAQECiyOBMoEBggwBAQaCZ9k4g?=
 =?us-ascii?q?WQJgRouAYhLAYFsg307g0J6JxuBSUSBSoMzhFiDRoJpgkWFEyUMhHqDeZl4C?=
 =?us-ascii?q?T+BBRwDWSERAVUTDQoLBwVjVzwDIm9qU3orgQuBFzpCgTuBEy8bIQtcgSmBG?=
 =?us-ascii?q?hQGFQSBDkY/gkppSzcCDQI2giQkWYEdgTKFGoRsZy8DAwMDgzyCTmQuHUADC?=
 =?us-ascii?q?xgNSBEsNQYOG0MBbgefAkaDNIEOmXuNQqFrhCShXQEyqk4uh2SQZSKoVIIaA?=
 =?us-ascii?q?TeBXEYHIxWDIk8DGQ+OIYN6jz4BthlDNTsCBwsBAQMJhUYBAYoPgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:e0VHwKwGNGS9nwiQOCHuKrPwFr1zdoMgy1knxilNoNJuA6qlfq
 eV7ZcmPH7P6Ar4Ohkb8+xoXZPsfZqyz/FICOUqUYtKGTOW3FdAT7sC0WKd+UyDJ8SWzIc0vp
 uIMZIObeEYZmIVsS+V2njeLz9Z+qj/zJyV
X-Talos-CUID: 9a23:HZ6PdWFbJMypMWPDqmJk7FRMOvB6QEbcwVn3I3WVMm1GYreaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ADbKkOAzdJ3hsRL8AV1QbwBhxgi2aqJ70M14dsp4?=
 =?us-ascii?q?KgpHabR56PzzEt3eyX7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101770973"
X-MGA-submission: =?us-ascii?q?MDFsYA3nUVoQ5Ka8vCxIT7ElyDTYEiRHCL/c8t?=
 =?us-ascii?q?zZAEaUFuGOwWKVt712zdG8PsiYRqhiTquKeDRP64XPVLCLv6d4+gfTEr?=
 =?us-ascii?q?W8SzAFYZ5+Hi94PaEzGsycFJEYuWOB3Ub0HF5rIRLWlJNoQThtHj+U1z?=
 =?us-ascii?q?XiYZ1hpjkKLreWy9228PB+aw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:22:46 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7A864206BCE6;
	Fri, 15 Nov 2024 13:22:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A864206BCE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705762;
	bh=3U0Zq8t5krsiKxal+ZZuXq1UdnH4Ui7697JSzYEOhjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m+WMW1w9+VciYFFrFZA0mxoPGvOfjrhYGrAVRbiO/Z38FXEyCYrwD61KeWUrbI1co
	 ciJpLEmJVGwRKy8PLvAHCagPIhXXgMkeOPvwDiMFvy84ueU3pKKi0uGJZ6fL3Jn5Hz
	 Ra5qi3c9a5aFZzpjfWBaC+oXk3VwB4O9Td0lHhlo=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-3-19aadc34941b@linux.microsoft.com>
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
Subject: [cocci] [PATCH 03/22] arm: pxa: Convert timeouts to use
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2009
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-3-19aadc34941b%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 arch/arm/mach-pxa/sharpsl_pm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index 72fa2e3fd35318e5a63c121ed7990a56a56b134c..bbbd06bc79bbb94fb258562e5a382acaf3c277b3 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -31,9 +31,9 @@
 /*
  * Constants
  */
-#define SHARPSL_CHARGE_ON_TIME_INTERVAL        (msecs_to_jiffies(1*60*1000))  /* 1 min */
-#define SHARPSL_CHARGE_FINISH_TIME             (msecs_to_jiffies(10*60*1000)) /* 10 min */
-#define SHARPSL_BATCHK_TIME                    (msecs_to_jiffies(15*1000))    /* 15 sec */
+#define SHARPSL_CHARGE_ON_TIME_INTERVAL        (secs_to_jiffies(60))  /* 1 min */
+#define SHARPSL_CHARGE_FINISH_TIME             (secs_to_jiffies(10*60)) /* 10 min */
+#define SHARPSL_BATCHK_TIME                    (secs_to_jiffies(15))    /* 15 sec */
 #define SHARPSL_BATCHK_TIME_SUSPEND            (60*10)                        /* 10 min */
 
 #define SHARPSL_WAIT_CO_TIME                   15  /* 15 sec */

-- 
2.34.1

