Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39D2D68BDF
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=94UWkQUgIE+TIBJCr3TB9bjXju243wFFlCrw1pjugTo=;
  b=HW+ieRzWJKUrHciO0SpV//gb5kVejWOb+ZuWAaIbPBYr3UIt2q+vZI62
   2UrZ6z0LUHDEtuZZAYEfPCW5PW6cjTdXKJ4EvnxCgX2oO4g6V3fm605Yx
   YIW2j0FV13xRY6zwtHmqjN2g/qpmZz2AsZNGdf4TWhJloj1jfJHQ4XmIy
   o=;
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
   d="scan'208";a="194169647"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AE5B5E0E28; Fri, 15 Nov 2024 23:35:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9B378E0133
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:56 +0100 (CET)
IronPort-SDR: 6737bbb0_KvPNjKiPiOn56SyNqOYH2InQew9vEmlAApj76S9Z6TGX4q0
 8om5obccgnDra+eHddxawx0RrC7irrlnpYcYQxw==
X-IPAS-Result: =?us-ascii?q?A0EgAABAujdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPJQImAgJGEAYBEoMBgmUGAp9MAYdgAQECiyN/M4EBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBFTWDM4QKToNGgmmCRYUTJYUGg?=
 =?us-ascii?q?3mZeAk/gQUcA1khEQFVEw0KCwcFY1c8AyJvalN6K4ELgRc6QoE7gRMvGyELX?=
 =?us-ascii?q?IEpgRoUBhUEgQ5GP4JKaUs3Ag0CNoIkJFmBHYEyhRqEbGcvAwMDA4M8gk5kL?=
 =?us-ascii?q?h1AAwsYDUgRLDUGDhtDAW4HnwJGgzSBDpl7jUKha4QkoV0BMqpOLodkkGUiq?=
 =?us-ascii?q?FSCGDqBXEYHIxWDIk8DGQ+OIYN6jz4BthlDNTsCBwsBAQMJhUYBAYlbNIFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wSR
IronPort-HdrOrdr: A9a23:+OwL1aHAeqguhVaYpLqE0seALOsnbusQ8zAXPo5KOHpom6uj5q
 OTdZUgtSMd6l4qMk3I/OrsBEDuexzhHPJOjbX5eI3SODUO21HIEGgd1/qB/9SIIUSXndK1l5
 0QFpSWY+efMbEVt7ec3ODBKadY/OW6
X-Talos-CUID: 9a23:7hKuYW3+stGNU3j6hWgQjbxfQNInLX/fzE/sI2ijJmZwbp2wbG+30fYx
X-Talos-MUID: 9a23:gk4IzARAg4z0GpI0RXSr3zVHEstVyJ+MVhswirYvtPHcGRZvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101771001"
X-MGA-submission: =?us-ascii?q?MDEIY6MzQk04jQ3Hi676A9Xq/3L/eqv9uNu3un?=
 =?us-ascii?q?DBRmJrKoOL8I0W6ula6/aAwfVzx1BSSBstSqsWdouM+XNxNsDiFhXsM4?=
 =?us-ascii?q?aWUGHu9IcFY2ZTSwps860j3KmxUixyrAvljdxYIJYTfGwmxK57oSX7VX?=
 =?us-ascii?q?w6emmIJ+2p9OKEKr59sKBR0w=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:22:56 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 391A4206BCED;
	Fri, 15 Nov 2024 13:22:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 391A4206BCED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705766;
	bh=94UWkQUgIE+TIBJCr3TB9bjXju243wFFlCrw1pjugTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SFgsUzV2pr+7sgkN9ckclI41KlvZ5rbgTJNvcYfQiJkXt/zfibxMELK/nTIaeiHDO
	 ea+s5uVXRp6XFAaIO7MmvRCgTW3Xe5hl6IpUNHPKOVjiYfv0tTkJJCNkRHRjEL8vOu
	 pgAUpMsv2jfhmvY7krwkZWjWRsRmTp18YKKkcVMM=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-20-19aadc34941b@linux.microsoft.com>
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
Subject: [cocci] [PATCH 20/22] ALSA: line6: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2024
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-20-19aadc34941b%40linux.microsoft.com>

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

