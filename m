Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9C9D68BDD
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DChbJW+DaqGHGWE0sMF41tmxT4FReQ1FKA/KDyHL32Y=;
  b=qbcn6sVTvZXkZOYL7B6w8i0BBQbwQnq3sXocjFNX2KhJACwYIqmc/hQj
   1GXMVX5tAYopWUDt6H9MazHsjvEQAPI1GycLLRrWkDxKv1psobZqX1NUA
   qngBGQb0puHcEVWy+ahAaNHiPEraka6mS8MvysMkxQiiR82cYV6MvRR4b
   4=;
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
   d="scan'208";a="194170162"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7C15CE0D70; Fri, 15 Nov 2024 23:36:01 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0ACB4E00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:26:53 +0100 (CET)
IronPort-SDR: 6737bc9c_+NBJvbN7qi8iEgkHG6tSGT2J3Ty652w+H22xhVWb5Qx3hS0
 Ft5OKCJpFSXjmmtYRcsFhTPc/jiJhPlKuanCuIw==
X-IPAS-Result: =?us-ascii?q?A0ECAABHuzdncraaTQ1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAP?=
 =?us-ascii?q?g8BAwFOAQIEAQEDBIFMgzQCiksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQERAg1eAQEeAgEDERIEGQEBNwEPJQImAgJGEAYBEoMBgmUGAp9NA?=
 =?us-ascii?q?YdgAQECiyN/M4EBggwBAQaCZ9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBF?=
 =?us-ascii?q?TWBBoIthFiDRoJpgkWEHXYlhQaDeZl+CT+BBRwDWSERAVUTDQoLBwVjVzwDI?=
 =?us-ascii?q?m9qU3orgQuBFzpCgTuBEy8bIQtcgSmBGhQGFQSBDkY/gkppSzcCDQI2giQkW?=
 =?us-ascii?q?YEdgTKFGoRsZy8DAwMDgzyCTmQyHUADCxgNSBEsNQYOG0MBbgefBEaDNIEPg?=
 =?us-ascii?q?yKTIIM4jUKha4QkoV0BMqpOLodkkGUioyKFMoIYOoFcRgcjFYMiTwMZD44hD?=
 =?us-ascii?q?BaDWI8+AbYeQzU7AgcLAQEDCYVGAQGKD4FLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:v4up+q9WaL9mOG1uvUZuk+DiI+orL9Y04lQ7vn2ZhyYlFPBw8P
 re/8jztCWVtN5yMEtLpTnkAsS9qBznmqKdjbN8AV7mZniDhILKFuBfBPXZsl/d8kTFn4Y36U
 4jSdkaNDSaNzZHZKjBkW6F+q4bsaC6zJw=
X-Talos-CUID: =?us-ascii?q?9a23=3AwClN4WphD5E6gQf9xqroafzmUcskXXfy7U32H2u?=
 =?us-ascii?q?5K0ExWvrKUFi60qwxxg=3D=3D?=
X-Talos-MUID: 9a23:64EVcggrn7CyBzMmtRecAcMpNuk5+/q3UBA2yIRf6vapLDRAZGvMg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101771144"
X-MGA-submission: =?us-ascii?q?MDHCzNXpanNzMkOZi7vDGDxMBLIUdLlBO3+nni?=
 =?us-ascii?q?290MmmqtLAe0Itb03jRaI9tRpZfZB5mLzABJ56dcDxp61RBAEmLN3SGu?=
 =?us-ascii?q?4JmkFBOJxcjAJ5jDaUQAegH5dnSO4v0GQkFl32djY9b+MiXBijS9y0V8?=
 =?us-ascii?q?6wslRR8EZQqU78Xy/lsuzgqA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:26:52 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5CD1F2064AE2;
	Fri, 15 Nov 2024 13:26:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5CD1F2064AE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706005;
	bh=DChbJW+DaqGHGWE0sMF41tmxT4FReQ1FKA/KDyHL32Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ge1adyPGW09osua+wGGbdGdLanSrZuA2fUn6nHmkQB9BNqn7wXFeAp1cdPu9VCOCp
	 35/hCv3XcEWTsrlvlhY2AjaoCI0WZCFykTU/SVB+MenGuEggOAvCtL12icddG0ZBHS
	 CbMDQbZbPdYcJR1LvpcZibK937QvjL6m/Aizu5/Q=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:26:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v2-19-911fb7595e79@linux.microsoft.com>
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
Subject: [cocci] [PATCH v2 19/21] livepatch: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2046
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v2-19-911fb7595e79%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 samples/livepatch/livepatch-callbacks-busymod.c |  2 +-
 samples/livepatch/livepatch-shadow-fix1.c       |  2 +-
 samples/livepatch/livepatch-shadow-mod.c        | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/samples/livepatch/livepatch-callbacks-busymod.c b/samples/livepatch/livepatch-callbacks-busymod.c
index 378e2d40271a9717d09eff51d3d3612c679736fc..d0fd801a7c21b7d7939c29d83f9d993badcc9aba 100644
--- a/samples/livepatch/livepatch-callbacks-busymod.c
+++ b/samples/livepatch/livepatch-callbacks-busymod.c
@@ -45,7 +45,7 @@ static int livepatch_callbacks_mod_init(void)
 {
 	pr_info("%s\n", __func__);
 	schedule_delayed_work(&work,
-		msecs_to_jiffies(1000 * 0));
+		secs_to_jiffies(0));
 	return 0;
 }
 
diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
index 6701641bf12d454a770e49abeeb0dea92560e55e..948ea1f5760fed2fa27baf478c97cf98ad5c99a8 100644
--- a/samples/livepatch/livepatch-shadow-fix1.c
+++ b/samples/livepatch/livepatch-shadow-fix1.c
@@ -73,7 +73,7 @@ static struct dummy *livepatch_fix1_dummy_alloc(void)
 		return NULL;
 
 	d->jiffies_expire = jiffies +
-		msecs_to_jiffies(1000 * EXPIRE_PERIOD);
+		secs_to_jiffies(EXPIRE_PERIOD);
 
 	/*
 	 * Patch: save the extra memory location into a SV_LEAK shadow
diff --git a/samples/livepatch/livepatch-shadow-mod.c b/samples/livepatch/livepatch-shadow-mod.c
index 7e753b0d2fa611524c9e2adbe02c8fa3e9b6015e..79296e6ccb119f521e86a121623855d841c9fc5e 100644
--- a/samples/livepatch/livepatch-shadow-mod.c
+++ b/samples/livepatch/livepatch-shadow-mod.c
@@ -102,7 +102,7 @@ static __used noinline struct dummy *dummy_alloc(void)
 		return NULL;
 
 	d->jiffies_expire = jiffies +
-		msecs_to_jiffies(1000 * EXPIRE_PERIOD);
+		secs_to_jiffies(EXPIRE_PERIOD);
 
 	/* Oops, forgot to save leak! */
 	leak = kzalloc(sizeof(*leak), GFP_KERNEL);
@@ -153,7 +153,7 @@ static void alloc_work_func(struct work_struct *work)
 	mutex_unlock(&dummy_list_mutex);
 
 	schedule_delayed_work(&alloc_dwork,
-		msecs_to_jiffies(1000 * ALLOC_PERIOD));
+		secs_to_jiffies(ALLOC_PERIOD));
 }
 
 /*
@@ -185,15 +185,15 @@ static void cleanup_work_func(struct work_struct *work)
 	mutex_unlock(&dummy_list_mutex);
 
 	schedule_delayed_work(&cleanup_dwork,
-		msecs_to_jiffies(1000 * CLEANUP_PERIOD));
+		secs_to_jiffies(CLEANUP_PERIOD));
 }
 
 static int livepatch_shadow_mod_init(void)
 {
 	schedule_delayed_work(&alloc_dwork,
-		msecs_to_jiffies(1000 * ALLOC_PERIOD));
+		secs_to_jiffies(ALLOC_PERIOD));
 	schedule_delayed_work(&cleanup_dwork,
-		msecs_to_jiffies(1000 * CLEANUP_PERIOD));
+		secs_to_jiffies(CLEANUP_PERIOD));
 
 	return 0;
 }

-- 
2.34.1

