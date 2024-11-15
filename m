Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A97ED68BE0
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8an4FgjBOt1s+5Gzupd7mugSuJBcUUHR7ha3x9HR0Ag=;
  b=eqALRDGZ5HyoJywfw2L1Lnno9j7SFIgyIJkDABDzM8z1VtICJwRdtVSg
   yIdG/Hm6ly348rMq+FwtQmRf22mCJQ3PzegSSs5jv4JBEuooPDhL7Ahwn
   y++k2SSbNwJqJYqi+prJyV6DuuIMZEJSxUEk6yXWdiEaqjdgtRyGVEsKE
   Q=;
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
   d="scan'208";a="194169701"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8F502E0E38; Fri, 15 Nov 2024 23:35:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6EA30E013D
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:57 +0100 (CET)
IronPort-SDR: 6737bbb0_Q5rDsoqkpvuGvgeWKSKOrIS5vbyeY4xYRZ79oQJ2udl+tz5
 YfpZ/5IzpmhqhPXLZC0XQUc28BlH3eUQn452LAA==
X-IPAS-Result: =?us-ascii?q?A0EKAABAujdncraaTQ1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYIbKH1aMwcISIRWiB2JUYt2kE2BVoFAPg8BAwFIBgECB?=
 =?us-ascii?q?AEBAwSBTIM0AopLAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAGBDIV7DYJiAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?QINXgEBHgIBAxESHQEBNwEPJQImAgJGEAYBEoIpUwQBAYIwAzEGAgwGnzoBh?=
 =?us-ascii?q?2ABAQKLI4EygQGCDAEBBoJn2TiBZAMGgRouAYFhhmoBgWyDfTuDQnonG4FJR?=
 =?us-ascii?q?IFKgzOEWINGgmmHWCWFBoN5hzoChFuNYQk/gQUcA1khEQFVEw0KCwcFY1c8A?=
 =?us-ascii?q?yJvalN6K4ELgRc6QoE7gRMvGyELXIEpgRoUBhUEgQ5GP4JKaUs3Ag0CNoIkJ?=
 =?us-ascii?q?FmBHYEyhRqEbGcvAwMDA4M8gk5kLh1AAwsYDUgRLDUGDhtDAW4HnwEBRoM0g?=
 =?us-ascii?q?Q8rUEGBA5NGgyxJjUKha4QkjBaVRwEyqk4uh2SQZSKLZYF4mneCGDoQgUxGB?=
 =?us-ascii?q?yMVgyJPAxkPjiEMFoNYhRSKKgG2GUM1AgE4AgcLAQEDCYVGAQGKD4FLAQE?=
IronPort-PHdr: A9a23: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
 nt0kwznTKMyQySbv1jAy2I/d+gdclBu0Lo=
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:FGHpw6x2QuibLLprxl4jKrPwFr1zdoMgy1knxilNoNJuA6qlfq
 eV7ZcmPH7P6Ar4Ohkb8+xoXZPsfZqyz/FICOUqUYtKGTOW3FdAT7sC0WKd+UyDJ8SWzIc0vp
 uIMZIObeEYZmIVsS+V2njeLz9Z+qj/zJyV
X-Talos-CUID: 9a23:YN1K5GOxsNVbzu5DeCBe2V4xBcQfTVLNkEfXeBD/NVZLV+jA
X-Talos-MUID: 9a23:x2GWBAbVErd7KeBTvjbQmhtoZNZT76WpDWAVz6glkderDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101771003"
X-MGA-submission: =?us-ascii?q?MDFiZevbp2CYIS0SeDcY2ec0lwzUDg0+Qni7cj?=
 =?us-ascii?q?UCgdTkb5spv6IxSJU6MVE4KYwvLbORQuCFzQIhJcuKoUjIvu0kfN3YnG?=
 =?us-ascii?q?GB6bI/GaDthQdClpWa5GtVyt54RxLdQYqEwUWCnru3vGR9wFUYlZT7lw?=
 =?us-ascii?q?OzSkEMx6oHICS3K5lt10g44A=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:22:57 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id A22AA206BCEE;
	Fri, 15 Nov 2024 13:22:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A22AA206BCEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705766;
	bh=8an4FgjBOt1s+5Gzupd7mugSuJBcUUHR7ha3x9HR0Ag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iplUk1Nduoh9asilHgzn6HQycVN1VFv/mFBOdW0Mpd4aq8sOOirOgItcWBMTidM3Q
	 FvxfPpyBxEWdptBjBV3AGgplTOjNGMgWDICXRk9fFUvguk5wrwqFw5sjChgX9PZPt7
	 /h1a1SkEI1LPNYXASotI6c+cUqHfSyHVemxnfBAU=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-22-19aadc34941b@linux.microsoft.com>
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
 Easwar Hariharan <eahariha@linux.microsoft.com>, 
 Michael Kelley <mhklinux@outlook.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
X-Mailer: b4 0.14.2
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 22/22] jiffies: Define secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2026
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-22-19aadc34941b%40linux.microsoft.com>

secs_to_jiffies() is defined in hci_event.c and cannot be reused by
other call sites. Hoist it into the core code to allow conversion of the
~1150 usages of msecs_to_jiffies() that either:

 - use a multiplier value of 1000 or equivalently MSEC_PER_SEC, or
 - have timeouts that are denominated in seconds (i.e. end in 000)

It's implemented as a macro to allow usage in static initializers.

This will also allow conversion of yet more sites that use (sec * HZ)
directly, and improve their readability.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Link: https://lore.kernel.org/all/20241030-open-coded-timeouts-v3-1-9ba123facf88@linux.microsoft.com
---
 include/linux/jiffies.h   | 13 +++++++++++++
 net/bluetooth/hci_event.c |  2 --
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 1220f0fbe5bf9fb6c559b4efd603db3e97db9b65..0a7382753c6b636fe285599953e314fb7479ea01 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -526,6 +526,19 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
 	}
 }
 
+/**
+ * secs_to_jiffies: - convert seconds to jiffies
+ * @_secs: time in seconds
+ *
+ * Conversion is done by simple multiplication with HZ
+ *
+ * secs_to_jiffies() is defined as a macro rather than a static inline
+ * function so it can be used in static initializers.
+ *
+ * Return: jiffies value
+ */
+#define secs_to_jiffies(_secs) ((_secs) * HZ)
+
 extern unsigned long __usecs_to_jiffies(const unsigned int u);
 #if !(USEC_PER_SEC % HZ)
 static inline unsigned long _usecs_to_jiffies(const unsigned int u)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0bbad90ddd6f87e87c03859bae48a7901d39b634..7b35c58bbbeb79f2b50a02212771fb283ba5643d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -42,8 +42,6 @@
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
 
-#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * 1000)
-
 /* Handle HCI Event packets */
 
 static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,

-- 
2.34.1

