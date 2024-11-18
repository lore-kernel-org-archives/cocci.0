Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EE4D591AC
	for <cocci@archiver.kernel.org>; Mon, 18 Nov 2024 18:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MeFLzXLWjsp3xazm690fAfQLAcbfGbqnimGpQ/u+lxI=;
  b=LNdHuVVQg+m8sByrXcaHLM0CkLTDtGy4DOrgsId4cnD+ku+Jt8I+wWO7
   TigNPVz793H+kOFoPaRSdOjAMoXCT0EU2mmdUTM63sfR2CUjI39nWaVL5
   d/rsfXWxN46ae9220i/Dsxg8h8v94JlHZpz29nQQgdSh7yaDe5ShWIqyz
   8=;
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
   d="scan'208";a="194516926"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2024 19:54:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9FCD0E0D83; Mon, 18 Nov 2024 19:54:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 00887E00B7
	for <cocci@sympa.inria.fr>; Mon, 18 Nov 2024 19:14:14 +0100 (CET)
IronPort-SDR: 673b83f6_2foaCLu+BNGwiPwWJ3iKDGjtefVr0QIzbnSwEFOKR0J/A+C
 ZwHTqMYNSGExRqty0rIqlH/7C+J4vBNx1oGZLSg==
X-IPAS-Result: =?us-ascii?q?A0EnAABdgjtnhbaaTQ1aHQEBAQEJARIBBQUBQIFABwELA?=
 =?us-ascii?q?YJDfQZUMwcISIRWkXETi2CSJIFAPg8BAwFGCAECBAEBAwSEdgoCilACHwYBB?=
 =?us-ascii?q?DEIDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNg?=
 =?us-ascii?q?mIBgSRRDQMHPgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QUCDV4BAR4BAQEDERIPAQ0BATcBDwsYAgImAgJWBhMCAQGCfQGCZAMDAgwEn?=
 =?us-ascii?q?j0Bh2ABAQKLI4EygQGCDAEBBtwfgWQDBoEaLgGISwGFaRuEXCcbgUlEgTwLA?=
 =?us-ascii?q?4J1PoRYg0aCaYJFgTGDXnKIMpoSUnscA1khEQFVExcLBwWBKSEsA4JHf4E2g?=
 =?us-ascii?q?VEBgxBKgy6BXgU3Cj+CSmlLNwINAjaCJH2BHYEygSUEBYNpgQuDYWcvAwMDA?=
 =?us-ascii?q?4M8hA8dQAIBC209NQkLG0OgCAFGhDQ7mQUBjnZpoBeEJIwWlTIGDwQvg3EBk?=
 =?us-ascii?q?2KSei6HZJBlhRqIZZVWhSGCGgE3gVxGByMVgyJPAxkPjiEZg2GEPsIIIjU7A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBi3CBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 9V030UDOQ==
IronPort-HdrOrdr: A9a23:f0Yqpa2ms508Yg5vnucN7wqjBIIkLtp133Aq2lEZdPWaSKylfr
 OV7ZMmPHjP+U4ssRAb6Km90MvpexnhHPtOjLX5Uo3MYOCLghrNEGgm1/qF/9SCIUPDH4xmuZ
 uIGpIWYLbN5BpB/KPHCWKDYrUdKbe8gcKVbKvlrktQcQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AqTu8Cmht/QDMpjCOu2IPBB9+rjJuVXfC/UfJGEm?=
 =?us-ascii?q?BOW8qYaOXQGaJxPo6qp87?=
X-Talos-MUID: 9a23:KvdF7glrwB4/ZjDRrVmsdno8P+hk3Y6+D3o2trgvo9KBLDMgZxG02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,164,1728943200"; 
   d="scan'208";a="101964164"
X-MGA-submission: =?us-ascii?q?MDExgjm2oCdF7L1Zvg7aK3R1oemVia98E+wfSS?=
 =?us-ascii?q?6ldZLGC8JrBKB1fPNLYegmg74kwPUr0XqpxRH2jyl67o72wrMzx8NPf4?=
 =?us-ascii?q?JY9/itONDYdIwfOnEQlGNuy/ApvpuWS6vInYncpaXGrte3fl31x3kX90?=
 =?us-ascii?q?UXGJ9IKMLozljtwwjzwv9feQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 18 Nov 2024 19:14:14 +0100
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8D36320BEBD0;
	Mon, 18 Nov 2024 10:14:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D36320BEBD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731953651;
	bh=MeFLzXLWjsp3xazm690fAfQLAcbfGbqnimGpQ/u+lxI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=EpMTlyYxawzrpLWk5xbTVLImz1FjRu/dpjx04XMKC2h+0ZNk23p4q7IoVXWEQqe6i
	 TSxIDdutTSwCt2U1ULNO+LS+MuwrAKZSeARAyR7AcI3+aMeOvdMnHKpbTDEXEPDD9p
	 tittVJRLH13+jNl6nnFYjIZC0+F9Zmxn+hJkRyII=
Message-ID: <89a8b1ea-3f18-4a2a-8226-c287b5427bec@linux.microsoft.com>
Date: Mon, 18 Nov 2024 10:14:08 -0800
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
 <20241115-converge-secs-to-jiffies-v2-2-911fb7595e79@linux.microsoft.com>
 <c07de369-9363-4e1d-9ccc-2db6dff79595@csgroup.eu>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <c07de369-9363-4e1d-9ccc-2db6dff79595@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 02/21] coccinelle: misc: Add secs_to_jiffies
 script
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2086
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/89a8b1ea-3f18-4a2a-8226-c287b5427bec%40linux.microsoft.com>

On 11/16/2024 1:52 AM, Christophe Leroy wrote:
> 
> 
> Le 15/11/2024 à 22:26, Easwar Hariharan a écrit :
>> [Vous ne recevez pas souvent de courriers de
>> eahariha@linux.microsoft.com. Découvrez pourquoi ceci est important à
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
> 
> There should be some explaination in the commit message, what the script
> does for instance.
> 

Thanks, will expand on this in v3.

- Easwar

