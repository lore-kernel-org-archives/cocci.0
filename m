Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0216D68BEB
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6BITrGwCktL5Jq+X71yuMGeN9lc8EktfbH6sdnkEy4Y=;
  b=uySMgoHTMV56xyi/QiUxJDAcqkwkCgIV6rnOh/sU0FL/so2PZetba0tI
   9D8dy7UPw2YkDzis6Ennv2Oobomgk9T2TZmYhvuWxM1Es5j7iOoZN5NcD
   K1OSICsFObJJZrIC5/PD3XCWcifzE0RRw4ia5PosPwE4hVQrdi1kmcGKn
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
   d="scan'208";a="194204780"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 26D27E0DDD; Sat, 16 Nov 2024 12:26:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C9004E00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 11:07:03 +0100 (CET)
IronPort-SDR: 67386ec5_vjEgx6Oss3HDBxqXue3k8kQKpigQj0qoJ8/ScldQOUr9NE5
 4K7zTennA+wEv/PG3S/gvtLDQs+czhpS63hg5ow==
X-IPAS-Result: =?us-ascii?q?A0EnAAArbjhnhQrrEV1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfQZTNAQLSIRWiB1fhlGBdC0DhDuYBoFWgUA+DwEDAQ05CwQBA?=
 =?us-ascii?q?QMEhQACiksCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEBAUBJhXsNgmIBgSRRDQMHPgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQUCDV4BAR4BAQECASMECwEFQRALDgwCJgICVgYBEgIBA?=
 =?us-ascii?q?YJ9AYJBIwcNBLE2fzOBAd4zgWcGgRouAYVpgmIBhWk7hDwnD4FVRIE8gwM+h?=
 =?us-ascii?q?AqEFIJpBIJBeoQHEiWIf4l3kB5SexwDWSASAVUTFwsHBYEpERAsAyJvak5/g?=
 =?us-ascii?q?TaBUQFBgk4vGyELXIEpfR0UBhUEgQ4FNwo/gkppSzcCDQI2giQkWYJPgSUEB?=
 =?us-ascii?q?YNsgQuDYWcvAwMDA4M8gk5kVR1AAgELbT01BgMLGwY9oA4BRoM1gQ4se5Q7k?=
 =?us-ascii?q?y+fYzQHhB2BXQYMiieVMgYTL5dMCJJ6LodkkGUihHiIZZVWhVKBQiU6gVxNJ?=
 =?us-ascii?q?oM0TwMZD4gAhjqIH4sAAbZnRTI7AgcBCgEBAwmOTjSBSwEB?=
IronPort-PHdr: A9a23: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
 4MOzmXc
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:OhDAnKx2/1Kd53/xB7x2KrPwGb1zdoMgy1knxilNoNJuA7Wlfr
 OV7Y8mPHjP+UkssRAb6Ky90ca7MBHhHPJOkPMs1PKZLXTbUQiTXeRfBOnZsl7d8kTFn4Y3uM
 sOEshD4Z/LfCBHZK3BkW6F+rgbsb+6GeyT9IPjJqhWJ29XV50=
X-Talos-CUID: 9a23:5NshrW80x5kk+aPqTHKVvx9NB+I6fXTl9WeOIlK8ETd7E7OxE0DFrQ==
X-Talos-MUID: 9a23:zkuDdgum8seXVK10GM2nxwhmG+NTwfiSLmMKu5kbmMymCwlcNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="101790146"
X-MGA-submission: =?us-ascii?q?MDFDBVj5xDGn3jCmeFfnDnDkE8sCNusrZq4FH4?=
 =?us-ascii?q?ZGnAiLMuk4y40BURxwSX7j6BgOxKLZzBilzUH6Y2Xm15CmHacc2wKAXP?=
 =?us-ascii?q?ZaO04c2IGi2AlxYF3cXIkT3B3G/izbJfKObOf+Uq15KUN1EsxmvpTk/b?=
 =?us-ascii?q?YyqKx7B3BpTznW/wsVX9CP2A=3D=3D?=
Received: from pegase2.c-s.fr ([93.17.235.10])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 11:07:01 +0100
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xr8gm1HnWz9sSY;
	Sat, 16 Nov 2024 11:07:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id es6k7pGxiX9O; Sat, 16 Nov 2024 11:07:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xr8gl0nQ8z9sSV;
	Sat, 16 Nov 2024 11:06:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EF7308B7A7;
	Sat, 16 Nov 2024 11:06:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id t4lgoLTHg9Gu; Sat, 16 Nov 2024 11:06:58 +0100 (CET)
Received: from [192.168.232.159] (POS169858.IDSI0.si.c-s.fr [192.168.232.159])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7AEB48B763;
	Sat, 16 Nov 2024 11:06:55 +0100 (CET)
Message-ID: <b6a059d8-7b23-455d-9ecd-eb3cdddd22a2@csgroup.eu>
Date: Sat, 16 Nov 2024 11:06:55 +0100
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
 <20241115-converge-secs-to-jiffies-v2-5-911fb7595e79@linux.microsoft.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-5-911fb7595e79@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 05/21] powerpc/papr_scm: Convert timeouts to
 secs_to_jiffies()
Reply-To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Loop: cocci@inria.fr
X-Sequence: 2067
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/b6a059d8-7b23-455d-9ecd-eb3cdddd22a2%40csgroup.eu>



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

Is it a special script or is it done with the script in patch 2.

That's nice to say how it is done, but you also have to say _what_ and 
_why_ you do it. This is even more important as you plan to get it 
merged independently in each tree instead of merging it as a single series.

It could be something like:

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced 
secs_to_jiffies(). As the value here is a multiple of 1000, use 
secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci

> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>   arch/powerpc/platforms/pseries/papr_scm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 9e297f88adc5d97d4dc7b267b0bfebd58e5cf193..9e8086ec66e0f0e555ac27933854c06cfcf91a04 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -543,7 +543,7 @@ static int drc_pmem_query_health(struct papr_scm_priv *p)
> 
>          /* Jiffies offset for which the health data is assumed to be same */
>          cache_timeout = p->lasthealth_jiffies +
> -               msecs_to_jiffies(MIN_HEALTH_QUERY_INTERVAL * 1000);
> +               secs_to_jiffies(MIN_HEALTH_QUERY_INTERVAL);

Wouldn't it now fit on a single line ?

	cache_timeout = p->lasthealth_jiffies + 
secs_to_jiffies(MIN_HEALTH_QUERY_INTERVAL);


Also I'm not sure it is worth the MIN_HEALTH_QUERY_INTERVAL macro as it 
is defined localy and used only once, but that's another story.

> 
>          /* Fetch new health info is its older than MIN_HEALTH_QUERY_INTERVAL */
>          if (time_after(jiffies, cache_timeout))
> 
> --
> 2.34.1
> 
