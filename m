Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C27D68BED
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xpBEojaRNmZLcf0UaP4ux3dQkOORS/leVLfy1gAywiE=;
  b=s2ZDKk4SuCmPBlWgX0dTT6BNWSh2GbwqPfSruYLT9dK6noinIWfB5Fn7
   PI7P3YmYAwAgr6OygLvqpT8O1TgCfHesUjJ91hvOJoVcIKev8cs44pWgS
   18713iXdJSivQldmS51VSUGg6Mp1kTkjiUD3h58dodAbNmtrCaVh88sNH
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194204555"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9C042E0D77; Sat, 16 Nov 2024 12:26:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4B0B6E00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 01:12:39 +0100 (CET)
IronPort-SDR: 6737e375_GnBhtBArqktOgUTmnGPC/Q2zS5wJeY6awDK/Z6j7XtnVvxU
 b/PA1qTe+zv9juLpeVttVmhrFymlhGsfA3EuQSw==
X-IPAS-Result: =?us-ascii?q?A0EDBABA4jdncraaTQ1aHgEBCxIMQIFIC4JEgQNUMwcIS?=
 =?us-ascii?q?IRWkXGLc5IjgUA+DwEDAU4BAgQBAQMEhQACiksCHwYBBDIHDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQERAg1eAR8BAQEDERIdAQE3AQ8LDgoCAiYCAlYGE?=
 =?us-ascii?q?wIBAYJ9gmUDAwKfRAGHYAEBAosjgTKBAYIMAQEG3B+BZAmBGi6ITAGFaYR3J?=
 =?us-ascii?q?xuBSUSBPA6CdT6EWINGgmmHWCUMiHOaE1J7HANZIREBVRMXCwcFgSkhLAOCS?=
 =?us-ascii?q?X+BNoFRAYMPSoMugV4FNwo/gkppSzcCDQI2giR9gR2BMoElBAWDbIELg2FnL?=
 =?us-ascii?q?wMDAwODPIQDHUACAQttPTUJCxtDoAtGnXQBjgtroQCEJKFIBg8EL5dUknouh?=
 =?us-ascii?q?2SQZaNZhR2CHwEygVxGByMVgyJPAxkPjiGDesY4IjU7AgcLAQEDCYVGAQGKD?=
 =?us-ascii?q?4FLAQE?=
IronPort-PHdr: A9a23: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
 lg9jQ4sOIwQ
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:xIHf46guslQvE0JULWcbJ/AsyHBQXuoji2hC6mlwRA09TyVXra
 CTdYcgpHvJYVEqKQkdcLG7SdC9qRG1z/RICOwqUItKMzOIhILFFvAE0WKm+UyHJ8SczIBgPM
 VbH5SWYeeYZTNHZITBkWyF+r0bsbq6Gc6T9IXjJjtWLD1XVw==
X-Talos-CUID: =?us-ascii?q?9a23=3ApPz09mtvD0s20hWXaQM1xnWv6IslS3bz6Cn6MXb?=
 =?us-ascii?q?mMkVuRr6+WXqu35ldxp8=3D?=
X-Talos-MUID: 9a23:T4J4FAaK2CnYOOBT7m/8gw16CPxR0rmEEnlWm7Vah8yLHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="101775255"
X-MGA-submission: =?us-ascii?q?MDE/je6N8HaUhcrZ57p5hcGp9uy5vcwMYdonMt?=
 =?us-ascii?q?jUzMN5xCZYKwZHAwBg6esqqFa2rx7khpFLEJubqK4Qu67ummRFjb2+Qu?=
 =?us-ascii?q?fJoHG81939efaIRS0QZZia7wjEGLJhXvhoq5rh69XLPBHFt7mTiWs0Jf?=
 =?us-ascii?q?e9rBXP4T++qEaWyQaV3M6Olg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 16 Nov 2024 01:12:37 +0100
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1600B2064AEE;
	Fri, 15 Nov 2024 16:12:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1600B2064AEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731715954;
	bh=xpBEojaRNmZLcf0UaP4ux3dQkOORS/leVLfy1gAywiE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Pq2k2Nni3cFBRk9EH3pyxgnDw6ECvdbg1vXWXgUrnZTvujbQOLePABt8LVR+E9JSZ
	 k4WoN+iIfUxQpiMRt/FU+pwGNrKJBo/0Q2+4KvxqDSAbq0u3pnKwVj+6aACG5ZF/KB
	 j3wJy4AhuvO/DGvU623x7nThkWYs37o8kaDAxg9k=
Message-ID: <68331eb9-545f-48a4-9c49-1a3637b3d918@linux.microsoft.com>
Date: Fri, 15 Nov 2024 16:12:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Pablo Neira Ayuso <pablo@netfilter.org>,
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
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
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
To: Stephen Rothwell <sfr@canb.auug.org.au>
References: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v1-3-19aadc34941b@linux.microsoft.com>
 <20241116093815.5d37eb43@canb.auug.org.au>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20241116093815.5d37eb43@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 03/22] arm: pxa: Convert timeouts to use
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2060
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/68331eb9-545f-48a4-9c49-1a3637b3d918%40linux.microsoft.com>

On 11/15/2024 2:38 PM, Stephen Rothwell wrote:
> Hi Easwar,
> 
> On Fri, 15 Nov 2024 21:22:33 +0000 Easwar Hariharan <eahariha@linux.microsoft.com> wrote:
>>
>> -#define SHARPSL_CHARGE_ON_TIME_INTERVAL        (msecs_to_jiffies(1*60*1000))  /* 1 min */
>> -#define SHARPSL_CHARGE_FINISH_TIME             (msecs_to_jiffies(10*60*1000)) /* 10 min */
>> -#define SHARPSL_BATCHK_TIME                    (msecs_to_jiffies(15*1000))    /* 15 sec */
>> +#define SHARPSL_CHARGE_ON_TIME_INTERVAL        (secs_to_jiffies(60))  /* 1 min */
>> +#define SHARPSL_CHARGE_FINISH_TIME             (secs_to_jiffies(10*60)) /* 10 min */
>> +#define SHARPSL_BATCHK_TIME                    (secs_to_jiffies(15))    /* 15 sec */
> 
> It might be nice to keep the alignment of the comments here.
> 

Will fix in v3.
