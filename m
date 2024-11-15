Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1E1D68BE0
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=tK04utDeNCseuvXH6irwCudSXxUYSbugurANWfhj/RA=;
  b=Y412Q9fEnfx8VF83+t5rvK5+ULUo75Y++Z5+pl410MYt4ltADMe1GtfZ
   DSYdTxuON1y3OtITY8W5+Ac9Hq55cmIgOrOXQefN8L3YeVnVFAn/mkJHh
   S17bVR9pdCXVtHgJwG2z1MRdhlnoUz2zPF9Nc5tiIRXqaDC7/z9iy42V7
   0=;
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
   d="scan'208";a="194169488"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:35:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2CB10E0D75; Fri, 15 Nov 2024 23:35:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8942CE0D1F
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:53 +0100 (CET)
IronPort-SDR: 6737bbad_hGWFakCz1ReAuNlgDoz/Knan+2hlQhSio/CrNGeo0TNCZFy
 FTl+JpBfQi+TvsGUx3UTbf+x7n9+GujF/u/ydww==
X-IPAS-Result: =?us-ascii?q?A0EgAABAujdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYIbKIFXMwcISIRWiB2VR5BNgVaBQD4PAQMBTgECBAEBAwSBTIM0A?=
 =?us-ascii?q?opLAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAGBD?=
 =?us-ascii?q?IV7DYJiAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEBHgIBA?=
 =?us-ascii?q?xESHQEBNwEPJQImAgJGEAYBEoIpWIJlBgKfTAGHYAEBAosjgTKBAYIMAQEGg?=
 =?us-ascii?q?mfZOIFkCYEaLgGISwGBbIN9O4NCeicbgUlEgUqBBoIthApOg0aCaYJFhRMlh?=
 =?us-ascii?q?QaDeYdGh0OKbwk/gQUcA1khEQFVEw0KCwcFY1c8AyJvalN6K4ELgRc6QoE7g?=
 =?us-ascii?q?RMvGyELXIEpgRoUBhUEgQ5GP4JKaUs3Ag0CNoIkJFmBHYEyhRqEbGcvAwMDA?=
 =?us-ascii?q?4M8gk5kLh1AAwsYDUgRLDUGDhtDAW4HnwJGgy0HgQ6Ze41CoWuEJKFdATKEB?=
 =?us-ascii?q?KZKLodkkGUigjShA4Udghg6gVxGByMVgyJPAxkPjiGDeo8+AbYZQzU7AgcLA?=
 =?us-ascii?q?QEDCYVGAQGJWzSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:GwM1l6GSWwic+mvZpLqE0seALOsnbusQ8zAXPo5KOHpom6uj5q
 OTdZUgtSMd6l4qMk3I/OrsBEDuexzhHPJOjbX5eI3SODUO21HIEGgd1/qB/9SIIUSXndK1l5
 0QFpSWY+efMbEVt7ec3ODBKadY/OW6
X-Talos-CUID: =?us-ascii?q?9a23=3A6aCEVGlDN96Mjr2zU+IFMVJ/O2XXOV3U9VrABlC?=
 =?us-ascii?q?8M1lGWOGlTgTPv59UsdU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ab4FfUw+0q2Nw35cspW8IvTeQf856yav0C2MGra1?=
 =?us-ascii?q?FmvSmMDcsJBrGkTviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101770990"
X-MGA-submission: =?us-ascii?q?MDGwvSEAsxQ1ehOlAfk1Mh2bIwXzzW3v69JdT1?=
 =?us-ascii?q?NhwCdApOdrhkiyX0nMa8iwa0U1zYWkvACTb2C6TOJr2gU36vs6GYbu0M?=
 =?us-ascii?q?edM9nvG1XUpXGj/Z9H6DRRHInSRCqGWfzjV3nAMKBuDNey8xlpdDy0ib?=
 =?us-ascii?q?6pGaGSngsLIM+9JSBCFrDUxg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:22:53 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 17D8D20BEBD6;
	Fri, 15 Nov 2024 13:22:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17D8D20BEBD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705765;
	bh=tK04utDeNCseuvXH6irwCudSXxUYSbugurANWfhj/RA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EeaKXUIdhndTAyki8bUakndKNZ8kLOJGUUMqUnCCfo6p9a/zgVkYL/LMfKrnFK+tG
	 f7KXDookDfXLSuaDjHu+S/m6N1geUmPHCzm2E8/XUOv0uy4oS5S0wjKzm7GAQ4iGTZ
	 d5PjcF/6XEBO/WEPS/wh7fexVacCMlg1D+TYznuQ=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-15-19aadc34941b@linux.microsoft.com>
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
Subject: [cocci] [PATCH 15/22] wifi: ath11k: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2019
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-15-19aadc34941b%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/net/wireless/ath/ath11k/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 57281a135dd7fa6b8610636f47873c8bba21053c..bf192529e3fe26a91e72105a77b4c6f849b905ec 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -178,7 +178,7 @@ static int ath11k_debugfs_fw_stats_request(struct ath11k *ar,
 	 * received 'update stats' event, we keep a 3 seconds timeout in case,
 	 * fw_stats_done is not marked yet
 	 */
-	timeout = jiffies + msecs_to_jiffies(3 * 1000);
+	timeout = jiffies + secs_to_jiffies(3);
 
 	ath11k_debugfs_fw_stats_reset(ar);
 

-- 
2.34.1

