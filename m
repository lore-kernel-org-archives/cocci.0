Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEE3D68BDD
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kyIMdoD81WSCHIuRs3t1IxAuP6vGJ5R59VD+r/6KKK0=;
  b=noqo2XZSYtUgksqgqRNbY1KtAOJLMvNVG/27Ui50+1jgdG8gutwl7T7S
   Ahh3/D9R2DS+Iql5zjJdrj0IQCdIdxWXy1s2JEgMEPB2OqxJkLCaDTRgC
   b3uw1dxSnT1plQ8lgSchsyfLmsAR32tkzIwjYHJeGq2oCp6KZHoE+aVXE
   s=;
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
   d="scan'208";a="194169585"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0B154E0D7B; Fri, 15 Nov 2024 23:35:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 457A1E0D1D
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:55 +0100 (CET)
IronPort-SDR: 6737bbae_ZO7qeEJpVq2pkT4rFCm1H4aWJARk9zCz+7snMCX7wowetIP
 s5jqshV+BK4ochaatyp2Haivn6OCUpECLqDkiyg==
X-IPAS-Result: =?us-ascii?q?A0EgAABAujdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPJQImAgJGEAYBEoMBgmUGAp9MAYdgAQECiyN/M4EBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBSoMzhApOBINCgmmCRYE1g14lh?=
 =?us-ascii?q?QaDeZl4CT+BBRwDWSERAVUTDQoLBwVjVzwDIm9qU3orgQuBFzpCgTuBEy8bI?=
 =?us-ascii?q?QtcgSmBGhQGFQSBDkY/gkppSzcCDQI2giQkWYEdgTKFGoRsZy8DAwMDgzyCT?=
 =?us-ascii?q?mQuHUADCxgNSBEsNQYOG0MBbgefAkaDNIEOmXuNQqFrhCShXQEyqk4uh2SQZ?=
 =?us-ascii?q?SKoVIIYOoFcRgcjFYMiTwMZD44hg3qPPgG2GUM1OwIHCwEBAwmFRgEBiVs0g?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:CYdd0Ky3XAM88fHtRhg2KrPwFr1zdoMgy1knxilNoNJuA6qlfq
 eV7ZcmPH7P6Ar4Ohkb8+xoXZPsfZqyz/FICOUqUYtKGTOW3FdAT7sC0WKd+UyDJ8SWzIc0vp
 uIMZIObeEYZmIVsS+V2njeLz9Z+qj/zJyV
X-Talos-CUID: =?us-ascii?q?9a23=3ARNF7H2i9Fyg9KmcxLkWnkv2OoDJuUnTk4Wf1PEu?=
 =?us-ascii?q?CNkl5FI2SEgDXxJNGjJ87?=
X-Talos-MUID: 9a23:OQtTAQXjxZH3zoLq/DW2nhtDFM442Lq3JH9WobodoPi9JTMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101770996"
X-MGA-submission: =?us-ascii?q?MDFVEKalAUaIA6ukkSU7UwaFxWQQmWjYkEQXFk?=
 =?us-ascii?q?W4nmdme73eNfNVbnF5shc4k8KV4pSGLkWxAJUgoBukV+lm8fa6QjOSnj?=
 =?us-ascii?q?kkjoKTVU3wgzpTPOaRy6YAv0cu0DiKriKO3YJj/DtHnw+PS4eYEkReTt?=
 =?us-ascii?q?R2GG8tMCQSjeSnb0f74ziteA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:22:55 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 88E5C20BEBD8;
	Fri, 15 Nov 2024 13:22:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88E5C20BEBD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705765;
	bh=kyIMdoD81WSCHIuRs3t1IxAuP6vGJ5R59VD+r/6KKK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hCMeIw/D2+NTRMQJ3FRDpZj2qT/7FbCaDMS9+XIuVvW9RIzS37PIUIxd4jF3sKpOq
	 ONruuQqONZh6MCBIYTovcefPeKanNMMCVBGfAbtnor6PdXfG/kDS1Iyd6np+7CKiaV
	 BV9SmXmoDsx8kPuPU+1F4sBj6APCWtu0lORTDJ94=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-17-19aadc34941b@linux.microsoft.com>
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
Subject: [cocci] [PATCH 17/22] staging: vc04_services: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2022
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-17-19aadc34941b%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 133ed15f3dbcc07dc353c22d8522e11a08ee6f46..6bb2562e071c4e623e51852860c682e047f823df 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -59,7 +59,7 @@ static int bcm2835_audio_send_msg_locked(struct bcm2835_audio_instance *instance
 
 	if (wait) {
 		if (!wait_for_completion_timeout(&instance->msg_avail_comp,
-						 msecs_to_jiffies(10 * 1000))) {
+						 secs_to_jiffies(10))) {
 			dev_err(instance->dev,
 				"vchi message timeout, msg=%d\n", m->type);
 			return -ETIMEDOUT;

-- 
2.34.1

