Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBFBD68BDA
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kyIMdoD81WSCHIuRs3t1IxAuP6vGJ5R59VD+r/6KKK0=;
  b=cdYv5Xayngtk2of0vqdYzHPDinmoZdOGzCV2ORJMXzYJYckB9FL3KS44
   kz5oLQWjRlAuvLE4UQqQtrZXCC2uFQGgwbpr1BpNMNuQq8VAIcm9vI9/h
   dyxwyeKCTSZnm4gsljQVPlGDwRxaAb6ND5cNKNjeIItuknNgEUASQNpNn
   w=;
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
   d="scan'208";a="194170078"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8FA3DE0ECC; Fri, 15 Nov 2024 23:36:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7A8ABE013D
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:26:51 +0100 (CET)
IronPort-SDR: 6737bc9b_Q1uFduq6oFHIbwEXScpGoT1w+BsfTpDPo0ddN7hYm0Dpnr4
 J+6QkqReCXfHQItVholGEgOj+Hv6Jm8/16vAuoQ==
X-IPAS-Result: =?us-ascii?q?A0EgAADnuzdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPJQImAgJGEAYBEoMBgmUGAp9LAYdgAQECiyN/M4EBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBSoMzhApOBINCgmmCRYE1g14lh?=
 =?us-ascii?q?QaDeZl+CT+BBRwDWSERAVUTDQoLBwVjVzwDIm9qU3orgQuBFzpCgTuBEy8bI?=
 =?us-ascii?q?QtcgSmBGhQGFQSBDkY/gkppSzcCDQI2giQkWYEdgTKFGoRsZy8DAwMDgzyCT?=
 =?us-ascii?q?mQyHUADCxgNSBEsNQYOG0MBbgefBEaDNIEOmXuNQqFrhCShXQEyqk4uh2SQZ?=
 =?us-ascii?q?SKoVIIYOoFcRgcjFYMiTwMZD44hg3qPPgG2HkM1OwIHCwEBAwmFRgEBiVs0g?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:0Znp/K2KR1fZetz3rawZFgqjBIgkLtp133Aq2lEZdPWaSL3/qy
 nIpoV56faUslYssBNJo7q90cy7LE80mqQb3WB8B9uftUzdyQ+VxeJZjLcKvQeQeREWn9Q1vc
 xdmupFebjN5DNB4/oSjjPIdOrIuOP3iZyVuQ==
X-Talos-CUID: 9a23:8n/1RGDsaHFc0wL6Eytl1VMGGewkTibM6lr/CmuULntDWITAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AV+HrEQ1exFQ3QefVTWMhXj4PrTUj24b1AxwNic4?=
 =?us-ascii?q?/ucSnJQshZRS/qGXwTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="194166050"
X-MGA-submission: =?us-ascii?q?MDGziSqVOk8X9b0XrWr10S6FEZrs4AQhGyPweT?=
 =?us-ascii?q?swufCvTXHv4RprEnDLu+m3/84wW4gXaKn6aY1OjtBTFLBgx8AXxaYFEZ?=
 =?us-ascii?q?64seueqffPKBiwQ7nItrGShyx9HlI31UTu9JpcpVLHun2qQYAcJtFrnD?=
 =?us-ascii?q?Nmcu8Kus2BTBZoxoRmvFj3JQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 15 Nov 2024 22:26:50 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id E068E2064AE1;
	Fri, 15 Nov 2024 13:26:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E068E2064AE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706005;
	bh=kyIMdoD81WSCHIuRs3t1IxAuP6vGJ5R59VD+r/6KKK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OvSN4ExTI3ztYwv8z22+okCfYqet5Vamjrrd8DLniE8bXBLrrqlExhm9XqqhqVQAv
	 K9X4eAD6Lklhy7dtiZRCgteR1YNNFWOyXJy0qOlBw+SNmEx9GYlOniMke213AVuk1H
	 UgCfCoB89XARJTc4CqTz96UEBf2hkM8Effwv9vsg=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:26:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v2-17-911fb7595e79@linux.microsoft.com>
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
Subject: [cocci] [PATCH v2 17/21] staging: vc04_services: Convert timeouts
 to secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2043
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v2-17-911fb7595e79%40linux.microsoft.com>

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

