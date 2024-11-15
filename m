Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326F9D68BDE
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=C//qZdfJfhN40N7nu/AQ5wmq+hj+onzvFzX2KrlsiOc=;
  b=hEupCeDGhQgmU9e97BC7kIbuHizFE0wukVHS3qHQqkIN6fHCDWPgrJ+2
   hyeNn/ZIovrNY7ZP0FfFxyd+wEFhZF+26cqh1Lxu9onZYqUUyBR9kcwH9
   Exlh35TqzaTUM1QDgOQ9ITC3lA2UmW6fyZe6wcEQoX89uNk7D0R3+8ZIT
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
   d="scan'208";a="194169700"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8A2CEE0E39; Fri, 15 Nov 2024 23:35:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CA805E00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:56 +0100 (CET)
IronPort-SDR: 6737bbb0_uP5njmT+d8/pTl1dTIot4TAwYj/SBrfJYz66IYupbVuR30s
 pSYNpH9SwI7RfX+7XrmiyAqp3a5onU/NqRIbdBQ==
X-IPAS-Result: =?us-ascii?q?A0EgAABAujdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPJQImAgJGEAYBEoMBgmUGAp9MAYdgAQECiyN/M4EBggwBAQaCZ?=
 =?us-ascii?q?9k4gWQJgRouAYhLAYFsg307g0J6JxuBSUSBSoMzhApOg0aCaYJFhRMlhQaDe?=
 =?us-ascii?q?Zl4CT+BBRwDWSERAVUTDQoLBwVjVzwDIm9qU3orgQuBFzpCgTuBEy8bIQtcg?=
 =?us-ascii?q?SmBGhQGFQSBDkY/gkppSzcCDQI2giQkWYEdgTKFGoRsZy8DAwMDgzyCTmQuH?=
 =?us-ascii?q?UADCxgNSBEsNQYOG0MBbgefAkaDNIEOmXuNQqFrhCShXQEyqk4uh2SQZSKoV?=
 =?us-ascii?q?IIYOoFcRgcjFYMiTwMZD44hDBaDWI8+AbYZQzU7AgcLAQEDCYVGAQGJWzSBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:ITpGGKtzrfJculCEl0ND74WE7skDTNV00zEX/kB9WHVpmwKj5q
 aTdZMgpHzJYVcqOE3J+7i7UpVoJEmwyXcb2+Ys1NuZMDUO/VHYSL2KjrGC/9SfIVydygc178
 4JGJSWSueAaGSS5vyV3ODXKadG/DD+ytHQudvj
X-Talos-CUID: 9a23:rszk/GDRs0DLpxj6ExNs/lwyJMx1SH3A3WnIGF3oBHtzbrLAHA==
X-Talos-MUID: 9a23:cnIpygvcBPH3kehDUc2n3z1QL8x32aSUDn8DkpgJ+MuoCGtKEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101771002"
X-MGA-submission: =?us-ascii?q?MDExStar1isqPzA5J2lOb6ptJtQQojadcK7k6K?=
 =?us-ascii?q?ZKlDkU+GBFDx45PguPtSnbO6xnwsMQUiOVbCqCn83q3k7DrWaGnWjmvN?=
 =?us-ascii?q?IserinbyTpVDA9A2LX+MRblVW8WQVqh5qVBTW4SFNuC7ZDTCooNZTsBQ?=
 =?us-ascii?q?bhEytmiHY2NRe3yUqI+1sBIA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:22:56 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6D0F7206BCEF;
	Fri, 15 Nov 2024 13:22:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D0F7206BCEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705766;
	bh=C//qZdfJfhN40N7nu/AQ5wmq+hj+onzvFzX2KrlsiOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PgOujrsxbS3CIW2HtLS/dd5ya7VtRG8QHhCZQdBAsTM3cx+kDkUAOUPnWwMnerztw
	 8X+Y81upKcxyh16cr7IomUwsyHP2XT7qOxm2nnfHsDBJOEcmEz0gtoHQc1mKP3Fi67
	 1u154eT7RN/hsmnSsi2wJWAYt//zpJk5MiSg9/YM=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-21-19aadc34941b@linux.microsoft.com>
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
Subject: [cocci] [PATCH 21/22] nfp: Convert timeouts to secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2025
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-21-19aadc34941b%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 6e0929af0f725b2b3855c69bbe894e6626c566b3..6925ad985fc9e2d5641feea41ff277107a8dee9c 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2779,7 +2779,7 @@ static void nfp_net_netdev_init(struct nfp_net *nn)
 		break;
 	}
 
-	netdev->watchdog_timeo = msecs_to_jiffies(5 * 1000);
+	netdev->watchdog_timeo = secs_to_jiffies(5);
 
 	/* MTU range: 68 - hw-specific max */
 	netdev->min_mtu = ETH_MIN_MTU;

-- 
2.34.1

