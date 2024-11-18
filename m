Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B9BD591B1
	for <cocci@archiver.kernel.org>; Mon, 18 Nov 2024 18:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4rGKqWlJzIh5S6WJog1UbY+9wr2RIzuf6CA98XkvD9A=;
  b=c+nUbFQqhoz+xcQPHnHIHNM9pSCZhnA3lo5M1suLLLE/49rX+eb221qY
   vIlt2L+R7NZ/w/1VvlyQ/FwSgvfF85accWn9v4xbmT3VKJ+qI9vKVecLL
   iMebvBNaKDuAXjVZAVZBd658Mbsl+C2CzXrs+/InAiWnnSyxF2SBZ9kUG
   A=;
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
X-IronPort-AV: E=Sophos;i="6.12,164,1728943200"; 
   d="scan'208";a="194516925"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2024 19:54:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 99E7FE0D8F; Mon, 18 Nov 2024 19:54:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3C564E00B7
	for <cocci@sympa.inria.fr>; Mon, 18 Nov 2024 19:13:30 +0100 (CET)
IronPort-SDR: 673b83c9_krAAKTzKC1TPsgKX+LYkjmDtYg3EwSHq+VFJ5mC3c+VP9U9
 W/ADvSrUp3sLqsCnnhvXvmMOVEFHDSgVOA7cb1g==
X-IPAS-Result: =?us-ascii?q?A0EYAABdgjtnhbaaTQ1aHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDfQZUMwcISIRWiB2JUQMTi2CSJIFAPg8BAwFGCAECBAEBAwSFAAKKUAIfB?=
 =?us-ascii?q?gEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQEmFQ?=
 =?us-ascii?q?QEFAjINgmIBgSRRDQMHPgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQUCDV4BAR4BAQEDERIPAQ0BATcBDwkCGAICJgICVgYTAgEBgn0Bg?=
 =?us-ascii?q?mQDAwIMBJUAiT0Bh2ABAQKLI4EygQGCDAEBBtwfgWQDBoEaLgGISwGFaRuEX?=
 =?us-ascii?q?CcbgUlEgRUnDoJ1PoRYg0aCaYJFgTGDXiVNiDKaElJ7HANZIREBVRMXCwcFg?=
 =?us-ascii?q?SkhLAOCR3+BNoFRAYMQSoMugV4FNwo/gkppSzcCDQI2giR9gR2BMoElBAWDa?=
 =?us-ascii?q?YELg2FnLwMDAwODPIQPHUACAQttPTUJCxtDoAgBRoM0AYEOKARxgQyTZ4MhA?=
 =?us-ascii?q?Y52aaAXhCSMFpUyBg8EL5dUknqYd4UaiGWVVoUhghg6gVxGByMVgyJPAxkPW?=
 =?us-ascii?q?IJohAWGXBmDYYQ+wggiNTsCBwEKAQEDCYVGAQGLcIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:PkxmEKC3BArm77blHemc55DYdb4zR+YMi2TDGXoQdfUnSL3+qy
 nIpoVi6faUskdpZJlD8errBEDkex7hHPFOjrX5UY3SODUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8KT0E9MqyUMbEQt7eY3ODXKadD/DDKysGVuds=
X-Talos-CUID: 9a23:TT8f6GGefx2mOUzjqmJW62ROOsMjT0Te53LBA2K+LlhCD6+8HAo=
X-Talos-MUID: 9a23:8c5xrQV16XtTHaTq/DL+vgFMDJt52Z3tIxEzvJBY5Mm6EBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,164,1728943200"; 
   d="scan'208";a="101964068"
X-MGA-submission: =?us-ascii?q?MDHGGvztln1mZZnizpYQr5QJAzW4aFgCNxrs7K?=
 =?us-ascii?q?/FlD6yLluGtArnyoOTtYs934CmuoEMtUZAI79AEtoI16fjChAal5RC8+?=
 =?us-ascii?q?C96QO0jFlO7YezM/8eB6A93Tiu54ejvzC1Zr3rGRObUMZSbkvwQsqBfA?=
 =?us-ascii?q?XJ5nOB45IJuPuLuhXGETTXUw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 18 Nov 2024 19:13:29 +0100
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 079B420B7D5F;
	Mon, 18 Nov 2024 10:13:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 079B420B7D5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731953606;
	bh=4rGKqWlJzIh5S6WJog1UbY+9wr2RIzuf6CA98XkvD9A=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=WgQq6VDmQPqDVd9HrdDJWYVeePI1o6O7aH2e5YK2i2MPTb79KOYC8kOEtCVdZyQyl
	 eQBQq4Gru6AuE3dhO0MWMctvjnMle6WwOzCHVKzijDojX1XF1tLPvCR2mFqRKiKQA2
	 T8BTz//c1DSiW16jlJvFvYtwS5WkMEtzzK+2O4cI=
Message-ID: <c2a5d9d2-ac73-46b0-9d2e-6960e2a13c1e@linux.microsoft.com>
Date: Mon, 18 Nov 2024 10:13:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
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
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 eahariha@linux.microsoft.com, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, cocci@inria.fr,
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
To: Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v2-1-911fb7595e79@linux.microsoft.com>
 <b370e8d0-2f87-4819-8f30-1181946295d9@csgroup.eu>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <b370e8d0-2f87-4819-8f30-1181946295d9@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 01/21] netfilter: conntrack: Cleanup timeout
 definitions
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2085
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/c2a5d9d2-ac73-46b0-9d2e-6960e2a13c1e%40linux.microsoft.com>

On 11/16/2024 1:40 AM, Christophe Leroy wrote:
> 
> 
> Le 15/11/2024 à 22:26, Easwar Hariharan a écrit :
>> [Vous ne recevez pas souvent de courriers de
>> eahariha@linux.microsoft.com. Découvrez pourquoi ceci est important à
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> None of the higher order definitions are used anymore, so remove
>> definitions for minutes, hours, and days timeouts. Convert the seconds
>> denominated timeouts to secs_to_jiffies()
> 
> There is very similar things with tcp_timeouts[] in
> nf_conntrack_proto_tcp.c, why not convert it as well ?

This patch happens to have been hand-modified and not by Coccinelle.
I'll consider tcp_timeouts[] for v3, but that actually seems to have
minute, hour, and days denominated timeouts, and replacing the 4 SECS
timeouts may actually hinder readability in that file.

> 
>>
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> ---
>>   net/netfilter/nf_conntrack_proto_sctp.c | 21 ++++++++-------------
>>   1 file changed, 8 insertions(+), 13 deletions(-)
>>
>> diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/
>> nf_conntrack_proto_sctp.c
>> index
>> 4cc97f971264ed779434ab4597dd0162586b3736..6c95ac96fa42a39acafb5b88a7cf8898010e911c 100644
>> --- a/net/netfilter/nf_conntrack_proto_sctp.c
>> +++ b/net/netfilter/nf_conntrack_proto_sctp.c
>> @@ -39,20 +39,15 @@ static const char *const sctp_conntrack_names[] = {
>>          [SCTP_CONNTRACK_HEARTBEAT_SENT]         = "HEARTBEAT_SENT",
>>   };
>>
>> -#define SECS  * HZ
>> -#define MINS  * 60 SECS
>> -#define HOURS * 60 MINS
>> -#define DAYS  * 24 HOURS
>> -
>>   static const unsigned int sctp_timeouts[SCTP_CONNTRACK_MAX] = {
>> -       [SCTP_CONNTRACK_CLOSED]                 = 10 SECS,
>> -       [SCTP_CONNTRACK_COOKIE_WAIT]            = 3 SECS,
>> -       [SCTP_CONNTRACK_COOKIE_ECHOED]          = 3 SECS,
>> -       [SCTP_CONNTRACK_ESTABLISHED]            = 210 SECS,
>> -       [SCTP_CONNTRACK_SHUTDOWN_SENT]          = 3 SECS,
>> -       [SCTP_CONNTRACK_SHUTDOWN_RECD]          = 3 SECS,
>> -       [SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]      = 3 SECS,
>> -       [SCTP_CONNTRACK_HEARTBEAT_SENT]         = 30 SECS,
>> +       [SCTP_CONNTRACK_CLOSED]                 = secs_to_jiffies(10),
>> +       [SCTP_CONNTRACK_COOKIE_WAIT]            = secs_to_jiffies(3),
>> +       [SCTP_CONNTRACK_COOKIE_ECHOED]          = secs_to_jiffies(3),
>> +       [SCTP_CONNTRACK_ESTABLISHED]            = secs_to_jiffies(210),
>> +       [SCTP_CONNTRACK_SHUTDOWN_SENT]          = secs_to_jiffies(3),
>> +       [SCTP_CONNTRACK_SHUTDOWN_RECD]          = secs_to_jiffies(3),
>> +       [SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]      = secs_to_jiffies(3),
>> +       [SCTP_CONNTRACK_HEARTBEAT_SENT]         = secs_to_jiffies(3),
> 
> Was 30 before, if you think it must be changed to 3 you must explain it
> in the commit message, or maybe do another patch for that change.

This one's a typo, I'll fix it in v3.

Thanks,
Easwar
