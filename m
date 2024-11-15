Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741C6D68BDF
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Dy1gfF2eVFD/Tcz72rvAOzLjHn7ysyv4CietmA0q798=;
  b=U8SiALv59lZXMIBfrbMW6AvE9jarE00/xPShkh2vcgww1lUwRcS4pWHy
   jvsF2m8YlF7Ab5JGLMrHOPxLLoT+mKTL+4YIN0QDpxqy2qxI9T4xJ6yWv
   ZFtwBbOwoWIXW0AaU+71nVtdJaZm4fnxHYn6PV6uOS2M/SHfLOsdBz3hL
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
   d="scan'208";a="194169391"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:35:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 432DFE0DB4; Fri, 15 Nov 2024 23:35:49 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9BF29E0D1C
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:50 +0100 (CET)
IronPort-SDR: 6737bbaa_kd0zYYrbsdEglkdA+1JIdvCB1n6NneHynWURrgdcNIkO5ps
 X9FFLx+ssD/a2ANH/mTNghxy8ERCKppRgQfPAxg==
X-IPAS-Result: =?us-ascii?q?A0EgAABAujdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPJQImAgJGEAYBEoMBgmUGAp9MAYdgAQECiyN/M4EBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBSoEGgi2ECk6DRoJpgkWFEyWFB?=
 =?us-ascii?q?oN5mXgJP4EFHANZIREBVRMNCgsHBWNXPAMib2pTeiuBC4EXOkKBO4ETLxshC?=
 =?us-ascii?q?1yBKYEaFAYVBIEORj+CSmlLNwINAjaCJCRZgR2BMoUahGxnLwMDAwODPIJOZ?=
 =?us-ascii?q?C4dQAMLGA1IESw1Bg4bQwFuB58CRoM0gQENmXuNQqFrhCShXQEyqk4uh2SQZ?=
 =?us-ascii?q?SKoVIIYOoFcRgcjFYMiTwMZD44hDBaDWI8+AbYZQzU7AgcLAQEDCYVGAQGJW?=
 =?us-ascii?q?zSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wSR
IronPort-HdrOrdr: A9a23:uotuWq9VDj2oF6KdU3Fuk+DiI+orL9Y04lQ7vn2ZhyYlFPBw8P
 re/8jztCWVtN5yMEtLpTnkAsS9qBznmqKdjbN8AV7mZniDhILKFuBfBPXZsl/d8kTFn4Y36U
 4jSdkaNDSaNzZHZKjBkW6F+q4bsaC6zJw=
X-Talos-CUID: 9a23:cUMZCW3kABwA28Wmdd1MprxfIMsvYFvjwCfqI1KpF35SWu2YVEW29/Yx
X-Talos-MUID: 9a23:jiVGNwlDUpgrl2y6+wTsdno9Lpwx0oiDUHkgy8ookcvHCjMzZTCC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101770983"
X-MGA-submission: =?us-ascii?q?MDG0r8UksTdfcfP4DffJH8t7mZtTNsnC7FWTz7?=
 =?us-ascii?q?9EW0sONOWB02EgtOC6rp7atBlbTUmoBEqZhwHlZrLUHmCNXW6ap1udBc?=
 =?us-ascii?q?Hk8QvJRiUZzlsbFh3yKdjQF8wOsXOTz9MapL9+MBNOkhTJULjMNyIhv2?=
 =?us-ascii?q?lwrHidh9Ix6qUQahMb2BQtSA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:22:50 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3830420BEBD2;
	Fri, 15 Nov 2024 13:22:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3830420BEBD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705764;
	bh=Dy1gfF2eVFD/Tcz72rvAOzLjHn7ysyv4CietmA0q798=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=noox43IaK9YbVWORCWHfqV/2MVwxKsfvDX3VjXOigGPsIAiMak5TX9WjxZ3URKdej
	 P/FLSpjwMlams/nnBrmsqiNRv/USEaAmRfdc7SPaE7Vpmg+hcqoc2z2b7doqNkw54W
	 wdFLT86eEn0mVPHIwhGf7+XKvkRHVCQ9LgbyTw5c=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-11-19aadc34941b@linux.microsoft.com>
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
Subject: [cocci] [PATCH 11/22] scsi: arcmsr: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2015
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-11-19aadc34941b%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/scsi/arcmsr/arcmsr_hba.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 35860c61468b02cdb59aa59376ad5ea9be60d12b..fd797e2785490839713f9242014f0adefccc6ddd 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1044,7 +1044,7 @@ static void arcmsr_init_get_devmap_timer(struct AdapterControlBlock *pacb)
 static void arcmsr_init_set_datetime_timer(struct AdapterControlBlock *pacb)
 {
 	timer_setup(&pacb->refresh_timer, arcmsr_set_iop_datetime, 0);
-	pacb->refresh_timer.expires = jiffies + msecs_to_jiffies(60 * 1000);
+	pacb->refresh_timer.expires = jiffies + secs_to_jiffies(60);
 	add_timer(&pacb->refresh_timer);
 }
 

-- 
2.34.1

