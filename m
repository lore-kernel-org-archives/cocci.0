Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB2CD68BDC
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GmA2v8FrQkDc3PawrRu1NLBJUu3qRf/naCkvRhlPz0Q=;
  b=cJU8aorHW6UXZ6l/VdCTgXrb6uzs1i2ja6KvV+yUSFyJ4pktnNn0IFZs
   oAzuK9CjoxvcyujpOGMjWUu709fKjztSKcoFhU/cl9uRhDsKB1YusBw4u
   iP5EI4npINRbRRNetEL7kkaqhFicwh1kbpHiK1ymZlaVkjt4TZfa6CLt1
   k=;
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
   d="scan'208";a="194169929"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5FDF0E0DF1; Fri, 15 Nov 2024 23:35:58 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EE2C2E0133
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:26:46 +0100 (CET)
IronPort-SDR: 6737bc96_TvmB37M5EYqBku/Qk6COB+fsQd535z/m+zLzskiFKJLjLMT
 ubP2IcsEDx5+cS1GDL5SWEXRBhVHX9W8k1/RXEw==
X-IPAS-Result: =?us-ascii?q?A0EgAADnuzdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPJQImAgJGEAYBEoMBgmUGAp9LAYdgAQECiyN/M4EBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBSoMzhApOg0aCaYJFhRMlhQaDe?=
 =?us-ascii?q?Zl+CT+BBRwDWSERAVUTDQoLBwVjVzwDIm9qU3orgQuBFzpCgTuBEy8bIQtcg?=
 =?us-ascii?q?SmBGhQGFQSBDkY/gkppSzcCDQI2giQkWYEdgTKFGoRsZy8DAwMDgzyCTmQyH?=
 =?us-ascii?q?UADCxgNSBEsNQYOG0MBbgefBEaDND1RmXuNQqFrhCShXQEyqk4uh2SQZSKoV?=
 =?us-ascii?q?IIYOoFcRgcjFYMiTwMZD44hg3qPPgG2HkM1OwIHCwEBAwmFRgEBiVs0gUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wSR
IronPort-HdrOrdr: A9a23:YNJKh6sGJ94tKnx3k1Vj/MMx7skDTNV00zEX/kB9WHVpmwKj5q
 aTdZMgpHzJYVcqOE3J+7i7UpVoJEmwyXcb2+Ys1NuZMDUO/VHYSL2KjrGC/9SfIVydygc178
 4JGJSWSueAaGSS5vyV3ODXKadG/DD+ytHQudvj
X-Talos-CUID: 9a23:5PjevW1fIWPJHm9O8rUPuLxfHeogcEHA/E7pDVK0VFtsRYeQRwSV0fYx
X-Talos-MUID: 9a23:NhEvmguGnqqGqlAY2c2nrS1PbNV6uJSXCkEmi5k/mMavMXxaNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="194166020"
X-MGA-submission: =?us-ascii?q?MDEYKfnn+NQBN2vXTiOzrpGL2h/7Vzq3lfbiiQ?=
 =?us-ascii?q?psLX8PAqTZFvAWLmMe+JDIZaS/zU5rYhBSU58JxpF9hFAUAzipM543lI?=
 =?us-ascii?q?IWvC1zdFRsJwiEhATKQUCmrK35teqQ2FCRw9kWkLizmB5BQyO3zvGt40?=
 =?us-ascii?q?WHfZuheDuQmGO4jA3j5lj2mQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 15 Nov 2024 22:26:45 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id D434E206BCFD;
	Fri, 15 Nov 2024 13:26:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D434E206BCFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706003;
	bh=GmA2v8FrQkDc3PawrRu1NLBJUu3qRf/naCkvRhlPz0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PLg1Ut3pMX8AIAjCAjy4bw02khMtlTmOdJICyDZ1qYDkIIeJUIA/Jl8Ax7qK0nzXA
	 69WpHciXaLS10XUYziHT/1hEXLH04lMhVot2lJeh/b4MNSDj4bBTIfL48/xVYbcOQX
	 4FHRZuPnT+9sZJ5HuVZVrIr57njKWIxmoNEf7/uw=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:26:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v2-8-911fb7595e79@linux.microsoft.com>
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
Subject: [cocci] [PATCH v2 08/21] drm/xe: Convert timeout to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2035
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v2-8-911fb7595e79%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/gpu/drm/xe/xe_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index a1987b554a8d2aa42b29301f2853edddfda7fda5..bb3338ef4191e76128611eeb9531c9d2089db85a 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -502,7 +502,7 @@ static int wait_for_lmem_ready(struct xe_device *xe)
 	drm_dbg(&xe->drm, "Waiting for lmem initialization\n");
 
 	start = jiffies;
-	timeout = start + msecs_to_jiffies(60 * 1000); /* 60 sec! */
+	timeout = start + secs_to_jiffies(60); /* 60 sec! */
 
 	do {
 		if (signal_pending(current))

-- 
2.34.1

