Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62160D68BE0
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KRAKVqkmYHFKsYpIbPFWmWMGYVvfzvIpOOiOmhExdwo=;
  b=lb99GTYqdKnRd/IZmhDLpdKQ3xMS/auaE83Xj6Hiy225U4s8sqCPZqlI
   bb9HR3TlmQDAbYfRBg2FwmWSUB/2DOacgf76tHYWCgUEPdPNSyUh9RfS0
   h5w6jWZ3cPI7mVc1d7fL3nkT//WU9s9dM/DKHT5Cj8OgcHRO+6ZMvYRmz
   I=;
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
   d="scan'208";a="194170042"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 54509E0EC8; Fri, 15 Nov 2024 23:36:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F4019E0D1D
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:26:48 +0100 (CET)
IronPort-SDR: 6737bc98_m6RxiJJfSKM5MFvvGGPDWQFmfUf0s5QFWqHzz67RAykA7IU
 8PgLOs5ohS6R2z6X+k+m8eWHuVcCFebeFA/P+mw==
X-IPAS-Result: =?us-ascii?q?A0EgAABHuzdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVHkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?ksCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIdAQE3AQ8lAiYCAkYQBgESgwGCZQYCn00Bh2ABAQKLI4EygQGCDAEBBoJn2?=
 =?us-ascii?q?TiBZAmBGi4BiEsBgWyDfTuDQnonG4FJRIFKgzOECk6DRoJpgkWFEyWFBoN5m?=
 =?us-ascii?q?X4JP4EFHANZIREBVRMNCgsHBWNXPAMib2pTeiuBC4EXOkKBO4ETLxshC1yBK?=
 =?us-ascii?q?YEaFAYVBIEORj+CSmlLNwINAjaCJCRZgR2BMoUahGxAJy8DAwMDgzyCTmQyH?=
 =?us-ascii?q?UADCxgNSBEsNQYOG0MBbgefBEaDNIEOmXuNQqFrhCShXQEyqk4uh2SQZSKoV?=
 =?us-ascii?q?IIYOoFcRgcjFYMiTwMZD44hg3qPPgG2HkM1OwIHCwEBAwmFRgEBiVs0gUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:uS68v6Og5uNQbcBcTvujsMiBIKoaSvp037Dk7TEWdfUzSL36qy
 nOppQmPX2dslwssRQb9OxoV5PufZqxz/JICMwqTNOftWrd2VdAUrsSj7cKqgeIc0bDH6xmpM
 JdmsNFZuEYY2IK6voSmDPIauod/A==
X-Talos-CUID: 9a23:wJ1i2WBP8oX+Y2v6E3kkqhY0ReUCS3jUyDT3ekygNEU4Z4TAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AXHT4fA3uxB4b+PYi0jJtveZ60jUj77i8FEkwjbo?=
 =?us-ascii?q?9htDVZHZNYGbHlzOme9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101771133"
X-MGA-submission: =?us-ascii?q?MDEJWOLZUCsCoxoal6hDWNuM8rdxZyFV7k33Mx?=
 =?us-ascii?q?tKki7aThI0twBPIqL4tn0fkIrFjfZvGay7aSr36DH/C5WXTbBO67rpUK?=
 =?us-ascii?q?mMpFnqX97qOkWO8g7hi1yQd8iHoSQdGxuO3eTFF/SUipo11+xV7Mikld?=
 =?us-ascii?q?qTAHlx21hYGq11mMUXni+QZA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:26:48 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id B08AC2174E41;
	Fri, 15 Nov 2024 13:26:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B08AC2174E41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706003;
	bh=KRAKVqkmYHFKsYpIbPFWmWMGYVvfzvIpOOiOmhExdwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=osivBUZmIsQLl2jL+ZDQlIu+P5dhzLcQCyWk2W1AvFXRp9qFe1ScWwkuHagBoxYIx
	 W4f74U2umtM+/izGX31p0lh8kwNEI1l5coBYaWK3pMcVhuLLHE4asQeuLREQ90Mb9z
	 ups8j6Ezd0JumeEqkyYkZ8sddPZGhvHCQNewXQdE=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:26:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v2-12-911fb7595e79@linux.microsoft.com>
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
Subject: [cocci] [PATCH v2 12/21] scsi: pm8001: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2040
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v2-12-911fb7595e79%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 33e1eba62ca12c2555419197ecdbebad817e4a6d..be88890716cc152b4687edf5e204d14bd177e188 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -734,7 +734,7 @@ static int pm8001_init_sas_add(struct pm8001_hba_info *pm8001_ha)
 		return -EIO;
 	}
 	time_remaining = wait_for_completion_timeout(&completion,
-				msecs_to_jiffies(60*1000)); // 1 min
+				secs_to_jiffies(60)); // 1 min
 	if (!time_remaining) {
 		kfree(payload.func_specific);
 		pm8001_dbg(pm8001_ha, FAIL, "get_nvmd_req timeout\n");

-- 
2.34.1

