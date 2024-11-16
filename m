Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D335D68BEC
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Z/h9Fo8qzxX+vwj/gnHe49MO7XxCnXAh2+BwoWgtDC0=;
  b=onxrB6AWXTdlanzw0EQ7yjSMocvkEPgUgP4Bd/tuqtSiU+BgpPR5G5nl
   P2co4b5lLxVGJUzN/hscLwijy4+BKBCgzGuNvJlJGMyiY8kpBWFf+kTTM
   LtKYQuve/IfPS/sYKYL6j+j7h7YpaiK3phrTlbFpFeXJQUYXLt0aWq4CS
   0=;
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
   d="scan'208";a="194204776"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 168C0E0DD2; Sat, 16 Nov 2024 12:26:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 327DFE00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 11:10:58 +0100 (CET)
IronPort-SDR: 67386fb1_/lbefEna8Y09l7K6FLbRQUtaQt+HH3mzcfkH2sw6ts6+6i+
 22IJKa+M7pZCyrbn4TuTyexzrQL4grAxf2K4hbg==
X-IPAS-Result: =?us-ascii?q?A0EEAACtbjhnhQrrEV1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDfQZTNAQLSIRWiB1fhlGBdDCEO5gGgVaBQ?=
 =?us-ascii?q?D4PAQMBDTkLBAEBAwSFAAKKSwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABAQEBQEmFew2CYgGBJFENAwc+AQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINXgEBHgEBAQIBIwQLAQVBBQsLD?=
 =?us-ascii?q?gwCJgICVgYBEgIBAYJ9AYJBIwcNBLE0fzOBAd4zgWcGgRouAYVpgmIBhWk7h?=
 =?us-ascii?q?DwnD4FVRIEVJwuBCYFvPogegmkEhl5kEiWIf5oVUnscA1kgEgFVExcLBwWBK?=
 =?us-ascii?q?REQLAMib2pOf4E2gVEBQYJOLxshC1yBKX0dFAYVBIEOBTcKP4JKaUs3Ag0CN?=
 =?us-ascii?q?oIkJFmCT4ElBAWDbIELg2FnLwMDAwODPIJOZFUdQAIBC209NQYDCxsGPaAOA?=
 =?us-ascii?q?UaDNYEPK3uBfJI/YZJOn2M0B4QdgV0GDIonlTIGEy+XTAiSei6HZJBlIoR4i?=
 =?us-ascii?q?GWVRRGFUoFCJTqBXE0mgzRPAxkPji0NCYgWiwABtmdFMjsCBwEKAQEDCY8Cg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
 JlBj0vsTOEtLhg=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:XXU0daEbXMFBh92XpLqE3ceALOsnbusQ8zAXPo5KOGVom7+j5r
 uTdZMgpGDJYVcqKQ0dcL+7Scu9qB/nhORICMwqTMqftWrdyQ6VxeNZnOjfKlTbckWUm4IztM
 ddmupFeaXN5DNB/KHHCWeDYrAdKZW8gcSVbDjlpRlQcT0=
X-Talos-CUID: =?us-ascii?q?9a23=3A6LhJwGlMUiGZZAu+Gyhx+/Dy1N7XOX/0l0eXCWm?=
 =?us-ascii?q?8Mm9CeIWMYkOtwP1elPM7zg=3D=3D?=
X-Talos-MUID: 9a23:JnhpiAaRyKqq9+BTqxr3hw1cGMZRuYO8MEQRk8oDku2iKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194199493"
X-MGA-submission: =?us-ascii?q?MDF3HFfvNQ+9tpXSuY8sQKiiILeX7V3l2rlsoq?=
 =?us-ascii?q?i7NNfedDsgQiaEmP82Se96wdvr3ccn9rleEVfO6DhqqLXzBtksYb8Uaw?=
 =?us-ascii?q?vXJnHrMOGgnGyvik4lT+NZJoe3n1Ved4vMkGxdFneKrkASHt7dBzjSyq?=
 =?us-ascii?q?BEmDmaDdo+MNckQkRnHuavSw=3D=3D?=
Received: from pegase2.c-s.fr ([93.17.235.10])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 11:10:57 +0100
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xr8mJ70Cyz9sSc;
	Sat, 16 Nov 2024 11:10:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TVeBAyqMk-DH; Sat, 16 Nov 2024 11:10:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xr8mJ5nMzz9sSZ;
	Sat, 16 Nov 2024 11:10:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AD1708B7A7;
	Sat, 16 Nov 2024 11:10:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 44RvYN3jGzXi; Sat, 16 Nov 2024 11:10:56 +0100 (CET)
Received: from [192.168.232.159] (POS169858.IDSI0.si.c-s.fr [192.168.232.159])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 35D3D8B763;
	Sat, 16 Nov 2024 11:10:53 +0100 (CET)
Message-ID: <718febc4-59ee-4701-ad62-8b7a8fa7a910@csgroup.eu>
Date: Sat, 16 Nov 2024 11:10:52 +0100
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
 <20241115-converge-secs-to-jiffies-v2-19-911fb7595e79@linux.microsoft.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-19-911fb7595e79@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 19/21] livepatch: Convert timeouts to
 secs_to_jiffies()
Reply-To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Loop: cocci@inria.fr
X-Sequence: 2068
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/718febc4-59ee-4701-ad62-8b7a8fa7a910%40csgroup.eu>



Le 15/11/2024 à 22:26, Easwar Hariharan a écrit :
> [Vous ne recevez pas souvent de courriers de eahariha@linux.microsoft.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
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
>   samples/livepatch/livepatch-callbacks-busymod.c |  2 +-
>   samples/livepatch/livepatch-shadow-fix1.c       |  2 +-
>   samples/livepatch/livepatch-shadow-mod.c        | 10 +++++-----
>   3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/samples/livepatch/livepatch-callbacks-busymod.c b/samples/livepatch/livepatch-callbacks-busymod.c
> index 378e2d40271a9717d09eff51d3d3612c679736fc..d0fd801a7c21b7d7939c29d83f9d993badcc9aba 100644
> --- a/samples/livepatch/livepatch-callbacks-busymod.c
> +++ b/samples/livepatch/livepatch-callbacks-busymod.c
> @@ -45,7 +45,7 @@ static int livepatch_callbacks_mod_init(void)
>   {
>          pr_info("%s\n", __func__);
>          schedule_delayed_work(&work,
> -               msecs_to_jiffies(1000 * 0));
> +               secs_to_jiffies(0));

Using secs_to_jiffies() is pointless, 0 is universal, should become 
schedule_delayed_work(&work, 0);

>          return 0;
>   }
> 
> diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
> index 6701641bf12d454a770e49abeeb0dea92560e55e..948ea1f5760fed2fa27baf478c97cf98ad5c99a8 100644
> --- a/samples/livepatch/livepatch-shadow-fix1.c
> +++ b/samples/livepatch/livepatch-shadow-fix1.c
> @@ -73,7 +73,7 @@ static struct dummy *livepatch_fix1_dummy_alloc(void)
>                  return NULL;
> 
>          d->jiffies_expire = jiffies +
> -               msecs_to_jiffies(1000 * EXPIRE_PERIOD);
> +               secs_to_jiffies(EXPIRE_PERIOD);
> 
>          /*
>           * Patch: save the extra memory location into a SV_LEAK shadow
> diff --git a/samples/livepatch/livepatch-shadow-mod.c b/samples/livepatch/livepatch-shadow-mod.c
> index 7e753b0d2fa611524c9e2adbe02c8fa3e9b6015e..79296e6ccb119f521e86a121623855d841c9fc5e 100644
> --- a/samples/livepatch/livepatch-shadow-mod.c
> +++ b/samples/livepatch/livepatch-shadow-mod.c
> @@ -102,7 +102,7 @@ static __used noinline struct dummy *dummy_alloc(void)
>                  return NULL;
> 
>          d->jiffies_expire = jiffies +
> -               msecs_to_jiffies(1000 * EXPIRE_PERIOD);
> +               secs_to_jiffies(EXPIRE_PERIOD);

Should fit on a single line, avoid multiple lines when possible.

> 
>          /* Oops, forgot to save leak! */
>          leak = kzalloc(sizeof(*leak), GFP_KERNEL);
> @@ -153,7 +153,7 @@ static void alloc_work_func(struct work_struct *work)
>          mutex_unlock(&dummy_list_mutex);
> 
>          schedule_delayed_work(&alloc_dwork,
> -               msecs_to_jiffies(1000 * ALLOC_PERIOD));
> +               secs_to_jiffies(ALLOC_PERIOD));

Should fit on a single line, avoid multiple lines when possible.


>   }
> 
>   /*
> @@ -185,15 +185,15 @@ static void cleanup_work_func(struct work_struct *work)
>          mutex_unlock(&dummy_list_mutex);
> 
>          schedule_delayed_work(&cleanup_dwork,
> -               msecs_to_jiffies(1000 * CLEANUP_PERIOD));
> +               secs_to_jiffies(CLEANUP_PERIOD));

Should fit on a single line, avoid multiple lines when possible.


>   }
> 
>   static int livepatch_shadow_mod_init(void)
>   {
>          schedule_delayed_work(&alloc_dwork,
> -               msecs_to_jiffies(1000 * ALLOC_PERIOD));
> +               secs_to_jiffies(ALLOC_PERIOD));

Should fit on a single line, avoid multiple lines when possible.


>          schedule_delayed_work(&cleanup_dwork,
> -               msecs_to_jiffies(1000 * CLEANUP_PERIOD));
> +               secs_to_jiffies(CLEANUP_PERIOD));

Should fit on a single line, avoid multiple lines when possible.


> 
>          return 0;
>   }
> 
> --
> 2.34.1
> 
