Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7029AD68BEA
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cZulbchHoB1m9w53hyTEIrwqdZiac1q3ss+KyydoHrc=;
  b=FPpjZLPkCRixp0NlV8Ony4txsVjX1Oeude6g8xdTxZ2hPMLmikJfxe/v
   laDajT/nzaWG8qxOfk4qElaI7V4N7QD0JwmYQcv8Na6eOokNvRV4SYRy/
   BkVxgHFBPBS6cvoi8WmClS3IOGmZ9L+1dYO7cAQ7TB7/QvYYc5y9hXqmi
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194204749"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C2EB2E0DC9; Sat, 16 Nov 2024 12:26:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D8AFAE00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 10:52:49 +0100 (CET)
IronPort-SDR: 67386b6c_SBhOMJeB1NPo15bY65OtzweibQy24FKPDXhCV4O0MVvF9iZ
 z8AooDBEqlRtO6QS6aG5ka0Q1jdtQ54QgT5/NxQ==
X-IPAS-Result: =?us-ascii?q?A0EnAADKajhnhQrrEV1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfQZTNAQLSIRWiB1fhlGBdDCEO5gGgVYUgSw+DwEDAQ05CwQBA?=
 =?us-ascii?q?QMEhQACiksCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEBAUBJhXsNgmIBgSRRDQMHPgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQUCDV4BAR4BAQECASMPAQVBBQsLDgwCJgICVgYBEgIBA?=
 =?us-ascii?q?YJ9AYJBIwcNBLEwgTKBAd4zgWcGgRouAYVpgmIBhWk7hDwnD4FVRIEVJwuBC?=
 =?us-ascii?q?YFvPoQGhBiCaQSDdoNeiSSaFVJ7HANZIBIBVRMXCwcFgSkRECwDIm9qTn+BN?=
 =?us-ascii?q?oFRAUGCTi8bIQtcgSl9HRQGFQSBDgU3Cj+CSmlLNwINAjaCJCRZgk+BJQQFg?=
 =?us-ascii?q?2yBC4NhZy8DAwMDgzyCTmRVHUACAQttPTUGAwsbBj2gDgFGgzWBDiyoZZ9jN?=
 =?us-ascii?q?AeEHYFdBgyKJ5UyBhMvl0wIknouh2SQZSKEeIhllVaFUoFCJTqBXE0mgzRPA?=
 =?us-ascii?q?xkPjjqIH4sAAbZnRTI7AgcBCgEBAwmPAoFLAQE?=
IronPort-PHdr: A9a23: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
 pVHmBfmTKsySzjC/Tfm
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:zN+crqm6EuraCK1Z4yRp7S034+vpDfIZ3DAbv31ZSRFFG/FwWf
 re5cjzpiWE8wr5P0tQ5uxoWZPwPU80mqQFg7X5UY3SJjUO/VHYUb2KjrGSpgEIeReOldK1vJ
 0IG8MSZLKQbWSSz/yKmDVQeOxQp+VvnprY49s2g00dKT2CtJsLgTtENg==
X-Talos-CUID: =?us-ascii?q?9a23=3Av4tIuGljSATHeX1puBbVVWKVtRbXOXTP0zDQBWC?=
 =?us-ascii?q?2NX5kaKOMdnqXyY07otU7zg=3D=3D?=
X-Talos-MUID: 9a23:3yvR1wXiVYKGZVvq/DPMpyElC/1m34WnWUsqt6UGiZaWPAUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194198534"
X-MGA-submission: =?us-ascii?q?MDE/7s+u/za9RCHJcUJCLRhdgWbpyoApVWcPul?=
 =?us-ascii?q?FX2z+mFxAVLrM3EgMlSDxGTTeLcM4iapHcsKbLAafVvGTOQXjd6VHLJ0?=
 =?us-ascii?q?PpQNNeAcBZ5/OIre/jYDcSH5xTcesDuFT3infGROkQt1DRuMaFsvRPgt?=
 =?us-ascii?q?nR8AmGmmBmI8JCv/INdirh4g=3D=3D?=
Received: from pegase2.c-s.fr ([93.17.235.10])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 10:52:44 +0100
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xr8MJ0y84z9sSL;
	Sat, 16 Nov 2024 10:52:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iRY-YqOlfdJO; Sat, 16 Nov 2024 10:52:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xr8MH5dYsz9sSN;
	Sat, 16 Nov 2024 10:52:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A71F08B7A7;
	Sat, 16 Nov 2024 10:52:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 3dHlADGj7q9l; Sat, 16 Nov 2024 10:52:43 +0100 (CET)
Received: from [192.168.232.159] (POS169858.IDSI0.si.c-s.fr [192.168.232.159])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 278CE8B763;
	Sat, 16 Nov 2024 10:52:40 +0100 (CET)
Message-ID: <c07de369-9363-4e1d-9ccc-2db6dff79595@csgroup.eu>
Date: Sat, 16 Nov 2024 10:52:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Russell King
 <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>,
 Oded Gabbay <ogabbay@kernel.org>, Lucas De Marchi
 <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
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
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann
 <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Xiubo Li <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Louis Peens <louis.peens@corigine.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
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
 linuxppc-dev@lists.ozlabs.org, Anna-Maria Behnsen <anna-maria@linutronix.de>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v2-2-911fb7595e79@linux.microsoft.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-2-911fb7595e79@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 02/21] coccinelle: misc: Add secs_to_jiffies
 script
Reply-To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Loop: cocci@inria.fr
X-Sequence: 2066
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/c07de369-9363-4e1d-9ccc-2db6dff79595%40csgroup.eu>



Le 15/11/2024 à 22:26, Easwar Hariharan a écrit :
> [Vous ne recevez pas souvent de courriers de eahariha@linux.microsoft.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 

There should be some explaination in the commit message, what the script 
does for instance.

> Suggested-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>   scripts/coccinelle/misc/secs_to_jiffies.cocci | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> new file mode 100644
> index 0000000000000000000000000000000000000000..af762b1c0aac8f044f21150bfaafd9efc834ee87
> --- /dev/null
> +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Find usages of:
> +/// - msecs_to_jiffies(value*1000)
> +/// - msecs_to_jiffies(value*MSEC_PER_SEC)
> +///
> +// Confidence: High
> +// Copyright: (C) 2024 Easwar Hariharan Microsoft
> +//
> +// Keywords: secs, seconds, jiffies
> +//
> +
> +@@ constant C; @@
> +
> +- msecs_to_jiffies(C * 1000)
> ++ secs_to_jiffies(C)
> +
> +@@ constant C; @@
> +
> +- msecs_to_jiffies(C * MSEC_PER_SEC)
> ++ secs_to_jiffies(C)
> 
> --
> 2.34.1
> 
