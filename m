Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E336D68BE8
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VPdyc30iNLh1F/YcS88wqEE6MNTecDdE0d2dBEGzlFA=;
  b=RFoi3D73ZXtMZiI8w0n18zDltb9drJ+zNIuBFz98pXtj2NMZg+Na/mni
   eXrAOxhpEAf3pvfvEqpJjCycXwc63LXY72ZvHY0hexhW4lQXJFslF42m8
   gm0V5jH+KErK/vjizrOmN0gCYwxGnmPKsDTDYcBzuCpksb5VyXoQMrM+/
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
   d="scan'208";a="194204710"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 558D2E0DB0; Sat, 16 Nov 2024 12:26:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8D4A4E00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 10:40:42 +0100 (CET)
IronPort-SDR: 6738689a_EktczUBL1VsV2BQWLeCr5f42gdqqm/1EuuYT9IaRCavMTke
 8RlOEbgK3zwEkHqdUfcSPeNCJ1VrAp59Jfh7RZw==
X-IPAS-Result: =?us-ascii?q?A0EnAABzZzhnhQrrEV1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfQZTNAQLSIRWiB1fhlGBdC0DhDuYBoFWgUA+DwEDAQ05CwQBA?=
 =?us-ascii?q?QMEhQACiksCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEBAUBJhUEBBQIyDYJiAYEkUQ0DBz4BAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEFAg1eAQEeAQEBAgEjDwEFQRALDgwCJgICVgYBE?=
 =?us-ascii?q?gIBAYJ9AYJBIwcNBLE1gTKBAd4zgWcGgRouAYVpgmIBhWk7hDwnD4FVRIEVJ?=
 =?us-ascii?q?wuCeD6IHoJpBIJBgTWDXiWIf5oVUnscA1kgEgFVExcLBwWBKREQLAMib2pOf?=
 =?us-ascii?q?4E2gVEBQYJOLxshC1yBKX0dFAYVBIEOBTcKP4JKaUs3Ag0CNoIkJFmCT4ElB?=
 =?us-ascii?q?AWDbIELg2FnLwMDAwODPIJOZFUdQAIBC209NQYDCxsGPaAOAUaDNAGBDigEc?=
 =?us-ascii?q?YEMk2eTAZ9jNAeEHYFdBgyKJ5UyBhMvl0wIknqYdyKEeIhllVaFUoFCJTqBX?=
 =?us-ascii?q?E0mgzRPAxkPWIJohAWGdYgfiwABtmdFMjsCBwEKAQEDCY8CgUsBAQ?=
IronPort-PHdr: A9a23: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
 JNBxVSJbA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:rnx/TqqmVx10CP+kytG6WUEaV5oeeYIsimQD101hICG9vPbo7v
 xG785rriMc7wxhJ03I+OrwRJVoLkmsl6KdjbNhR4tKGTOWxVdAT7sSiLcKoQeQeBEWn9Q1vc
 wMH8ceaOEYT2IK9foSizPIdOrIruP3lpxAyd2uq0uFkjsBBZ1d0w==
X-Talos-CUID: 9a23:cv0W9W23k9tV1z7tyloCobxfIp19UH7tj1zqKBHoIlZIceK6dBiX0fYx
X-Talos-MUID: 9a23:jadQOQnHY/rJo0aqbYg0dnpfD5Y35vWPJHw2lKwhlpibLxNuBW202WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194197832"
X-MGA-submission: =?us-ascii?q?MDEArQaP6yy9JCx4f0IBc+xzdQK8ufa2QNNnNg?=
 =?us-ascii?q?cDESsWyrPwpi0vzXhYVv5PGs3EVxoOxPVFIa28hVnS9Q7nMwdhX7UX6T?=
 =?us-ascii?q?xAPAqxRwExFw9+z8KEN7ES43qRrlFAofUp1lhGAqvZd4hNcYBvCRYxK0?=
 =?us-ascii?q?FOyPaDaSlHuXM8Mq+thj6eng=3D=3D?=
Received: from pegase2.c-s.fr ([93.17.235.10])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 10:40:42 +0100
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xr85P2jCRz9sSL;
	Sat, 16 Nov 2024 10:40:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WM2ylrrKzRNT; Sat, 16 Nov 2024 10:40:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xr85N47M0z9sSN;
	Sat, 16 Nov 2024 10:40:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6EC608B7A7;
	Sat, 16 Nov 2024 10:40:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id LwtPoXQs3II6; Sat, 16 Nov 2024 10:40:40 +0100 (CET)
Received: from [192.168.232.159] (POS169858.IDSI0.si.c-s.fr [192.168.232.159])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EDBE28B763;
	Sat, 16 Nov 2024 10:40:36 +0100 (CET)
Message-ID: <b370e8d0-2f87-4819-8f30-1181946295d9@csgroup.eu>
Date: Sat, 16 Nov 2024 10:40:36 +0100
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
 <20241115-converge-secs-to-jiffies-v2-1-911fb7595e79@linux.microsoft.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-1-911fb7595e79@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 01/21] netfilter: conntrack: Cleanup timeout
 definitions
Reply-To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Loop: cocci@inria.fr
X-Sequence: 2065
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/b370e8d0-2f87-4819-8f30-1181946295d9%40csgroup.eu>



Le 15/11/2024 à 22:26, Easwar Hariharan a écrit :
> [Vous ne recevez pas souvent de courriers de eahariha@linux.microsoft.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> None of the higher order definitions are used anymore, so remove
> definitions for minutes, hours, and days timeouts. Convert the seconds
> denominated timeouts to secs_to_jiffies()

There is very similar things with tcp_timeouts[] in 
nf_conntrack_proto_tcp.c, why not convert it as well ?

> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>   net/netfilter/nf_conntrack_proto_sctp.c | 21 ++++++++-------------
>   1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
> index 4cc97f971264ed779434ab4597dd0162586b3736..6c95ac96fa42a39acafb5b88a7cf8898010e911c 100644
> --- a/net/netfilter/nf_conntrack_proto_sctp.c
> +++ b/net/netfilter/nf_conntrack_proto_sctp.c
> @@ -39,20 +39,15 @@ static const char *const sctp_conntrack_names[] = {
>          [SCTP_CONNTRACK_HEARTBEAT_SENT]         = "HEARTBEAT_SENT",
>   };
> 
> -#define SECS  * HZ
> -#define MINS  * 60 SECS
> -#define HOURS * 60 MINS
> -#define DAYS  * 24 HOURS
> -
>   static const unsigned int sctp_timeouts[SCTP_CONNTRACK_MAX] = {
> -       [SCTP_CONNTRACK_CLOSED]                 = 10 SECS,
> -       [SCTP_CONNTRACK_COOKIE_WAIT]            = 3 SECS,
> -       [SCTP_CONNTRACK_COOKIE_ECHOED]          = 3 SECS,
> -       [SCTP_CONNTRACK_ESTABLISHED]            = 210 SECS,
> -       [SCTP_CONNTRACK_SHUTDOWN_SENT]          = 3 SECS,
> -       [SCTP_CONNTRACK_SHUTDOWN_RECD]          = 3 SECS,
> -       [SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]      = 3 SECS,
> -       [SCTP_CONNTRACK_HEARTBEAT_SENT]         = 30 SECS,
> +       [SCTP_CONNTRACK_CLOSED]                 = secs_to_jiffies(10),
> +       [SCTP_CONNTRACK_COOKIE_WAIT]            = secs_to_jiffies(3),
> +       [SCTP_CONNTRACK_COOKIE_ECHOED]          = secs_to_jiffies(3),
> +       [SCTP_CONNTRACK_ESTABLISHED]            = secs_to_jiffies(210),
> +       [SCTP_CONNTRACK_SHUTDOWN_SENT]          = secs_to_jiffies(3),
> +       [SCTP_CONNTRACK_SHUTDOWN_RECD]          = secs_to_jiffies(3),
> +       [SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]      = secs_to_jiffies(3),
> +       [SCTP_CONNTRACK_HEARTBEAT_SENT]         = secs_to_jiffies(3),

Was 30 before, if you think it must be changed to 3 you must explain it 
in the commit message, or maybe do another patch for that change.

>   };
> 
>   #define        SCTP_FLAG_HEARTBEAT_VTAG_FAILED 1
> 
> --
> 2.34.1
> 

Christophe

