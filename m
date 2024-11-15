Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA70AD68BDF
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=94UWkQUgIE+TIBJCr3TB9bjXju243wFFlCrw1pjugTo=;
  b=GLCRMSWPu2QAnOOT43h/iZibND47/gLw111DUkKyiL252UPkNeGZJ3Tk
   3TasyyiAzCe8Vp6KVGh74Y5JMxy90w1282DznM3fJ+Lx9kD1gKYb+yyto
   8u6pHFXLvMoaZWw3Trywmg3nGq98r7qZyBTegPc6QlZjqeLTBcf9ePTG/
   8=;
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
   d="scan'208";a="194170189"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 52FCDE0D4E; Fri, 15 Nov 2024 23:36:02 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 84E16E0133
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:26:53 +0100 (CET)
IronPort-SDR: 6737bc9d_Kjb2SAEpw5eTMKkKxxteMteBCayBsZdZNuFZpmcGmawYReV
 AbdXfsFkg4Qenwd5VmRRS51qMAYrzP3dSZ2VyCw==
X-IPAS-Result: =?us-ascii?q?A0EgAABHuzdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPJQImAgJGEAYBEoMBgmUGAp9NAYdgAQECiyN/M4EBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBFTWDM4QKToNGgmmCRYUTJYUGg?=
 =?us-ascii?q?3mZfgk/gQUcA1khEQFVEw0KCwcFY1c8AyJvalN6K4ELgRc6QoE7gRMvGyELX?=
 =?us-ascii?q?IEpgRoUBhUEgQ5GP4JKaUs3Ag0CNoIkJFmBHYEyhRqEbGcvAwMDA4M8gk5kM?=
 =?us-ascii?q?h1AAwsYDUgRLDUGDhtDAW4HnwRGgzSBDpl7jUKha4QkoV0BMqpOLodkkGUiq?=
 =?us-ascii?q?FSCGDqBXEYHIxWDIk8DGQ+OIYN6jz4Bth5DNTsCBwsBAQMJhUYBAYlbNIFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:0heeS6j4YNxVLp/9Y/bBrzrlbXBQXuAji2hC6mlwRA09TyVXrb
 HJoB19726WtN9xYhEdcbLpAsO9qBbnmKKdjrN/AV7PZmXbUS6TXeVfBOjZogEIZReOlNK1vJ
 0IG8ND4Z/LfD1HZK3BjjVQfexQp+VviJrY/Nvj8w==
X-Talos-CUID: =?us-ascii?q?9a23=3AFFWGyGu1mT3rHcu0sOWtDaWm6It1MSOF7Cj1BHa?=
 =?us-ascii?q?9AGIqb+SWUWKzqYxdxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AnisLbwybDFkIXiTZBLUtbyyGi4KaqOfzJ18wnqg?=
 =?us-ascii?q?ah/C7FQ9NHB20rG6pUpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101771146"
X-MGA-submission: =?us-ascii?q?MDEicMt+AMPMqviVqTzSyW4ZG/ryLGtbV2+0xF?=
 =?us-ascii?q?fFF+9cv6Fiv6H+/UHpVEwoy9mt5LBGuKfvPdnw2bT4jJxL2VpLXkeZC/?=
 =?us-ascii?q?c0MS3keCxaF/hRhTC6RaSU5Su0XzS/7iuTsVtkBarogIfIzG7RSXmWXi?=
 =?us-ascii?q?rH/r4xnlHlixg4DJq95y0amQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:26:53 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 956492064AE3;
	Fri, 15 Nov 2024 13:26:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 956492064AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706005;
	bh=94UWkQUgIE+TIBJCr3TB9bjXju243wFFlCrw1pjugTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mNHdIox58am1vKiSlapYyQSd/IB/puFk5Gi1H5FYHJ3c7VwmewWXtYwpq8qZgM5VC
	 FsoAzIfa/5Dmw/g1Wnz5pM6x92x9pSsv8KUjV1VC6j6e14jtQDSlKdd0OQNegI9M/0
	 o4hIDKt2X5QgI0I8DrdvAcv+VpyUUXxnbDtHt4Jg=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:26:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v2-20-911fb7595e79@linux.microsoft.com>
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
Subject: [cocci] [PATCH v2 20/21] ALSA: line6: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2047
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v2-20-911fb7595e79%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 sound/usb/line6/toneport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index ca2c6f5de407ece21ab69a39ed603e3f10069039..c073b38cd6738176fc6a276d05ed553526573341 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -386,7 +386,7 @@ static int toneport_setup(struct usb_line6_toneport *toneport)
 		toneport_update_led(toneport);
 
 	schedule_delayed_work(&toneport->line6.startup_work,
-			      msecs_to_jiffies(TONEPORT_PCM_DELAY * 1000));
+			      secs_to_jiffies(TONEPORT_PCM_DELAY));
 	return 0;
 }
 

-- 
2.34.1

