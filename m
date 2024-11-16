Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B4FD68BEB
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bvRxnmu+yCK710/wiQawhwot1julMAdZRZ7PalkopIA=;
  b=OswOkw9rePrnX/cTuoVv0jOa7mkpEoC38tJTeptMHMtiJ8R5WFG5z9hy
   uVvS54JMKG+h6c52p3DdY79qXxIAQFr0e0aVMg0GnjP/rV1SDvt2Z+e2p
   KDP6ThWpfzNAbpN9rZckhHcfP3wvFHr+/fzIagpbvJ5rPPXycPKPR4l3B
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
   d="scan'208";a="194204865"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BF8B4E0D2B; Sat, 16 Nov 2024 12:26:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 526B2E00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 11:26:57 +0100 (CET)
IronPort-SDR: 67387370_x2ljY4f7N4ZnqiEZlJR8g2j/JuDtYzMdilq4DCNRKMVaLfF
 P+D+1cPPMZJzepKCloHtwZC8XM+bJsFLDvF0CoQ==
X-IPAS-Result: =?us-ascii?q?A0EcAAAPczhnhQrrEV1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQQQBAQELAYJDfQZTNAQLSIRWiHyGUYF0LYQ+mAaBVoFAPg8BAwENO?=
 =?us-ascii?q?QsEAQEDBIUAAopLAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBAQFASYV7DYJiAYEkUQ0DBz4BAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEFAg1eAQEeAgEDIw8BBUEQCw4MAiYCAlYGARICA?=
 =?us-ascii?q?QGCfQGCZAcNBAKxNYEygQGDbEHaBoFnBoEaLgGFaYJiAYVpO4Q8Jw+BVUSBP?=
 =?us-ascii?q?AuCeD6CYQSFOYJpBIJBhRMlDIhzmhVSexwDWSASAVUTFwsHBYEpERAsAyJva?=
 =?us-ascii?q?k5/gTaBUQFBgk4vGyELXIEpfR0UBhUEgQ4FNwo/gkppSzcCDQI2giQkWYJPg?=
 =?us-ascii?q?SUEBYNsgQuDYWcvAwMDA4M8gk5kVR1AAgELbT01BgMLGwY9oA4BRoM1YS0qA?=
 =?us-ascii?q?i+BHqcYn2M0B4QdgV0GDIonlTIGEy+XTAiSei6HZJBlIoR4iGWVVoVSgUIrA?=
 =?us-ascii?q?TOBXE0mgzRPAxkPjjqIH1aKKgG2Z0UyAjkCBwEKAQEDCY8CgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:fksSa6gTcQpQJF+q6umlWF+VcnBQXu8ji2hC6mlwRA09TyVXrb
 HWoB1p726OtN93YgBepTngAtj9fZqyz+8W3WB8B8bZYOCighrUEGgA1/qG/9SDIVycygc178
 4JGMUTZ7yRMbE5t7eD3ODSKadG/DDoytHPuQ6T9QYIcei0UcsP0ztE
X-Talos-CUID: 9a23:ArBE4mBxEkh4RoL6E3F2xXRXJekKS2/2zXjsOG+FFVdwd4TAHA==
X-Talos-MUID: 9a23:a3QrZgVCfayg0MPq/C7Doj5mMfhN3+ezIlwEqJommcuBBRUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="101791088"
X-MGA-submission: =?us-ascii?q?MDE7PEuyUItLBIP76l5kiAtzLaKeMyfy/Rw4jl?=
 =?us-ascii?q?emrtJM4HLPq3YgaVdNmo32pgX+weaA7N16kmbnZlX/dJ6PXjPAwHMEKl?=
 =?us-ascii?q?yP1pv+yEK4a+27rS2BU8ui/TLUl7Q0m8euLN+vqn5Q31xF1/wvyK9xmY?=
 =?us-ascii?q?/hvMAWgQ+u1/XVTphk6onOdA=3D=3D?=
Received: from pegase2.c-s.fr ([93.17.235.10])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 11:26:57 +0100
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xr96m167Wz9sSL;
	Sat, 16 Nov 2024 11:26:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IieXZuAi8N-1; Sat, 16 Nov 2024 11:26:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xr96l3Rvbz9sSN;
	Sat, 16 Nov 2024 11:26:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 51FF68B7A7;
	Sat, 16 Nov 2024 11:26:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id BlevLl1v9xVh; Sat, 16 Nov 2024 11:26:55 +0100 (CET)
Received: from [192.168.232.159] (POS169858.IDSI0.si.c-s.fr [192.168.232.159])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B911A8B763;
	Sat, 16 Nov 2024 11:26:51 +0100 (CET)
Message-ID: <e0d15960-4fb9-4458-b080-89791d2f5d2a@csgroup.eu>
Date: Sat, 16 Nov 2024 11:26:51 +0100
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
 <20241115-converge-secs-to-jiffies-v2-3-911fb7595e79@linux.microsoft.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-3-911fb7595e79@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 03/21] arm: pxa: Convert timeouts to use
 secs_to_jiffies()
Reply-To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Loop: cocci@inria.fr
X-Sequence: 2072
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/e0d15960-4fb9-4458-b080-89791d2f5d2a%40csgroup.eu>



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
>   arch/arm/mach-pxa/sharpsl_pm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
> index 72fa2e3fd35318e5a63c121ed7990a56a56b134c..bbbd06bc79bbb94fb258562e5a382acaf3c277b3 100644
> --- a/arch/arm/mach-pxa/sharpsl_pm.c
> +++ b/arch/arm/mach-pxa/sharpsl_pm.c
> @@ -31,9 +31,9 @@
>   /*
>    * Constants
>    */
> -#define SHARPSL_CHARGE_ON_TIME_INTERVAL        (msecs_to_jiffies(1*60*1000))  /* 1 min */
> -#define SHARPSL_CHARGE_FINISH_TIME             (msecs_to_jiffies(10*60*1000)) /* 10 min */
> -#define SHARPSL_BATCHK_TIME                    (msecs_to_jiffies(15*1000))    /* 15 sec */
> +#define SHARPSL_CHARGE_ON_TIME_INTERVAL        (secs_to_jiffies(60))  /* 1 min */
> +#define SHARPSL_CHARGE_FINISH_TIME             (secs_to_jiffies(10*60)) /* 10 min */
> +#define SHARPSL_BATCHK_TIME                    (secs_to_jiffies(15))    /* 15 sec */

This comment is completely useless now.

The other ones are probably also kind of useless, everybody knows 1 min 
= 60 sec. See https://docs.kernel.org/process/coding-style.html#commenting



>   #define SHARPSL_BATCHK_TIME_SUSPEND            (60*10)                        /* 10 min */
> 
>   #define SHARPSL_WAIT_CO_TIME                   15  /* 15 sec */
> 
> --
> 2.34.1
> 
