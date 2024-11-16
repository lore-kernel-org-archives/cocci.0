Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E042DD68BEE
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=agrWh4a1c02Ln/4ieq2OSCQsDoWRwZEB12hKkLZZ+VY=;
  b=ep6IK9xdKwgWqJ/g2ucSJ+frTHDzMwjXK9oLoYsBSr9L2p2OCHFb0vQr
   zedp3zsW6LKSe5OUvqeAQOJClGSMujgtMLhx7mXecHCpqn4HvFSeJIkkK
   bhKc8n901Rl9xW2z8Qwnn8sK0vH052qpoyL1MjdYztlzbwBnDAYx3xif2
   M=;
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
   d="scan'208";a="194204799"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5329AE0D7B; Sat, 16 Nov 2024 12:26:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BC3CBE00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 11:13:29 +0100 (CET)
IronPort-SDR: 67387049_TrQKjjBvnxWZOFA6J+Yy8HbemG4+NHvkTZN7PtyK5Zkpivf
 2VhQZHltMt1kivvLTLp0he+hlSUH0qCFmXDtReA==
X-IPAS-Result: =?us-ascii?q?A0EnAACZbzhnhQrrEV1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfQZTNAQLSIRWiB1fhlGBdDCEO5gGgVaBQD4PAQMBDTkLBAEBA?=
 =?us-ascii?q?wSFAAKKSwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQEBQEmFew2CYgGBJFENAwc+AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBBQINXgEBHgEBAQIBIwQLAQVBEAsODAImAgJWBgESAgEBg?=
 =?us-ascii?q?n0BgkEjBw0EsTJ/M4EB3jOBZwaBGi4BhWmCYgGFaTuEPCcPgVVEgTwLgng+h?=
 =?us-ascii?q?AqEFIJpBIM7hBkliH+aFVJ7HANZIBIBVRMXCwcFgSkRECwDIm9qTn+BNoFRA?=
 =?us-ascii?q?UGCTi8bIQtcgSl9HRQGFQSBDgU3Cj+CSmlLNwINAjaCJCRZgk+BJQQFg2yBC?=
 =?us-ascii?q?4NhZy8DAwMDgzyCTmRVHUACAQttPTUGAwsbBj2gDgFGgzWBDiyoZZ9jNAeEH?=
 =?us-ascii?q?YFdBgyKJ5UyBhMvl0wIknouh2SQZSKEeIhllVaFUoFCJTqBXE0mTYJnTwMZD?=
 =?us-ascii?q?44tDQmIFosAAbZnRTI7AgcBCgEBAwmOTjSBSwEB?=
IronPort-PHdr: A9a23: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
 ZMG0QakSvV6XHfIzWI=
IronPort-Data: A9a23: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
 bMbilZhO1yr50E=
IronPort-HdrOrdr: A9a23:j911wqEjj8ryN0sxpLqE3ceALOsnbusQ8zAXPo5KOGVom7+j5r
 uTdZMgpGDJYVcqKQ0dcL+7Scu9qB/nhORICMwqTMqftWrdyQ6VxeNZnOjfKlTbckWUm4IztM
 ddmupFeaXN5DNB/KHHCWeDYrAdKZW8gcSVbDjlpRlQcT0=
X-Talos-CUID: 9a23:WZSSPm1/LgFEDG5GvP2ICLxfFuB4WXT06n7rLxWxDX1KFeybQw+b0fYx
X-Talos-MUID: 9a23:3zTEOwriUicHRG5bAeIezxhAKIA5/6WWNG0qmMldi/XYBSNdEQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194199646"
X-MGA-submission: =?us-ascii?q?MDGGvN53J4kD+8TGVp5IA5UMjGcvMk6fh1CJGY?=
 =?us-ascii?q?U58jEIZqD+GICOfV4wCJ8i1GuP+nbm4r8UdLhgb0+oIXfamQAhRhFYpr?=
 =?us-ascii?q?wmRiGF+O7USE9aolKrC1uBIHgIDH+Xc7SoR0nLiy52rwcluYdnkvEa37?=
 =?us-ascii?q?LNKI1kZD7oBytuU2goEsfJaA=3D=3D?=
Received: from pegase2.c-s.fr ([93.17.235.10])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 11:13:29 +0100
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xr8qD6MqGz9sSh;
	Sat, 16 Nov 2024 11:13:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bgc9eTs4hq8I; Sat, 16 Nov 2024 11:13:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xr8qD4zW2z9sSf;
	Sat, 16 Nov 2024 11:13:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 871718B7A7;
	Sat, 16 Nov 2024 11:13:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 3guV967Ix0Cb; Sat, 16 Nov 2024 11:13:28 +0100 (CET)
Received: from [192.168.232.159] (POS169858.IDSI0.si.c-s.fr [192.168.232.159])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DD3108B763;
	Sat, 16 Nov 2024 11:13:24 +0100 (CET)
Message-ID: <76fe994b-b9b9-49e0-8224-df48db48f1e5@csgroup.eu>
Date: Sat, 16 Nov 2024 11:13:24 +0100
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
 <20241115-converge-secs-to-jiffies-v2-21-911fb7595e79@linux.microsoft.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-21-911fb7595e79@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 21/21] nfp: Convert timeouts to
 secs_to_jiffies()
Reply-To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Loop: cocci@inria.fr
X-Sequence: 2069
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/76fe994b-b9b9-49e0-8224-df48db48f1e5%40csgroup.eu>

Le 15/11/2024 à 22:26, Easwar Hariharan a écrit :
> [Vous ne recevez pas souvent de courriers de eahariha@linux.microsoft.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]

As you plan to get those merged independant in each tree, I guess it 
should be sent to netdev list targetting net-next tree in the subject 
line as per netdev rules.



> 
> Changes made with the following Coccinelle rules:
> 
> @@ constant C; @@
> 
> - msecs_to_jiffies(C * 1000)
> + secs_to_jiffies(C)
> 
> @@ constant C; @@
> 
> - msecs_to_jiffies(C * MSEC_PER_SEC)
> + secs_to_jiffies(C)
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>   drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> index 6e0929af0f725b2b3855c69bbe894e6626c566b3..6925ad985fc9e2d5641feea41ff277107a8dee9c 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> @@ -2779,7 +2779,7 @@ static void nfp_net_netdev_init(struct nfp_net *nn)
>                  break;
>          }
> 
> -       netdev->watchdog_timeo = msecs_to_jiffies(5 * 1000);
> +       netdev->watchdog_timeo = secs_to_jiffies(5);
> 
>          /* MTU range: 68 - hw-specific max */
>          netdev->min_mtu = ETH_MIN_MTU;
> 
> --
> 2.34.1
> 
