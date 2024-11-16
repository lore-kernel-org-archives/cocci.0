Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BA0D68BEF
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8aWsE6KsHqgZAR/UTPX2BOaIFAyMPoSLG9xpC4Hm8PA=;
  b=vcb3niIAZEcl8A+QbDvOJfOROY95ajTDguksTpjYG84UaXJ7QQ5tSmIo
   nbVXBNN+b6bLWHFcyClSVbeofjvR2iAGtF66r5IewgZgZJCYMkCwkt2cX
   ZUrzbiJpn6bXDCLCr+vLd1sqnpQZ7Dh0mhZG5tMm0pnix4cHb23Vjvi2d
   o=;
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
   d="scan'208";a="194204578"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 07FF1E0D1D; Sat, 16 Nov 2024 12:26:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8C894E00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 01:13:20 +0100 (CET)
IronPort-SDR: 6737e3a0_Rf7h3/VDBsX60rwdikQrJLU+VOk2a/VNAwAcXufCTnXhuhD
 nkXvflJ2Ct8gTxluAGf5qflRLcBgrWEcpDrHYHw==
X-IPAS-Result: =?us-ascii?q?A0G+AwBA4jdncraaTQ1agQmBU4JEgQNUMwcISIRWkXGLc?=
 =?us-ascii?q?5IjgUA+DwEDAU4BAgQBAQMEhQACiksCHwYBBDEIDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEQAQEFAQEBAgEBAgQGAQIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQERAg1eAR8BAQEDERIdAQE3AQ8LDgoCAiYCAlYGEwIBAYJ9g?=
 =?us-ascii?q?mUDAwKfRAGHYAEBAosjgTKBAYIMAQEG3B+BZAmBGi6ITAGFaYR3JxuBSUSBF?=
 =?us-ascii?q?ScLA4J1PoRYg0aCaYJyhGYliH+aE1J7HANZIREBVRMXCwcFgSkhLAOCSX+BN?=
 =?us-ascii?q?oFRAYMPSoMugV4FNwo/gkppSzcCDQI2giR9gR2BMoElBAWDbIELg2FnLwMDA?=
 =?us-ascii?q?wODPIQDHUACAQttPTUJCxtDoAtGgzUxSplEAY4La6EAhCShSAYPBC+XVJJ6m?=
 =?us-ascii?q?HeodoIaATeBXEYHIxWDIk8DGQ+SG8Y4IjU7AgcLAQEDCYVGAQGKD4FLAQE?=
IronPort-PHdr: A9a23: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
 AJwgQx7M71FyQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:R+PFUaCPS7F0ES3lHemc55DYdb4zR+YMi2TDGXoQdfUnSL39qy
 nIpoVi6faUskdpZJlD8errBEDkex7hHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8KT0E9MqyUMbEQt7eY3ODXKadD/DDKysGVuds=
X-Talos-CUID: 9a23:bF78ymDpCPM+oi36Ey5E+3YzJOd8SEKHy2jzG2SiL2ZsVYTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Ae1o6Zg3n/NkcKqR5vARMTIFqoTUjzvWqIwMVmLg?=
 =?us-ascii?q?6vuaYDxF9HTK3hyiwe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="101775271"
X-MGA-submission: =?us-ascii?q?MDFt8cy2sXR+vCi6us5mHzmKvuzNvU4M3mmXSg?=
 =?us-ascii?q?BuJuwy6ugNR7f+Tnq/3HBF8/5UKe6zUqxT8mzbPUTyGV3oyMi729wGLk?=
 =?us-ascii?q?hBsls2/juccjFs4H7rWsVjtxrdYQtDXeYtWZjqiW3vG9awXPSkFJIojt?=
 =?us-ascii?q?nmrsViaH3Pu0faKO+ijrAQ3A=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 16 Nov 2024 01:13:20 +0100
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 95E342064AF0;
	Fri, 15 Nov 2024 16:13:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95E342064AF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731715997;
	bh=8aWsE6KsHqgZAR/UTPX2BOaIFAyMPoSLG9xpC4Hm8PA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=juHtZTV0RDh+wTFwjvF/I5Cbue56gEXjd0kD3znUPuWXx2wtRwF3SiJZ6HWwI5inJ
	 TBVBD9vnbAv41iOqcNYfHcjXy0Jo4vpPQnYC829Cp+vZARPfhAL4M9phLDROf5akb8
	 KGqyHrYITaajwfOdtt56+uCdzgps3Ezs57MjrN0w=
Message-ID: <0b4bbd38-f6aa-4091-b7db-8b87572ad83a@linux.microsoft.com>
Date: Fri, 15 Nov 2024 16:13:13 -0800
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
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v2-1-911fb7595e79@linux.microsoft.com>
 <20241116093458.4aa19a0e@canb.auug.org.au>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20241116093458.4aa19a0e@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 01/21] netfilter: conntrack: Cleanup timeout
 definitions
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2061
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/0b4bbd38-f6aa-4091-b7db-8b87572ad83a%40linux.microsoft.com>

On 11/15/2024 2:34 PM, Stephen Rothwell wrote:
> Hi Easwar,
> 
> On Fri, 15 Nov 2024 21:26:18 +0000 Easwar Hariharan <eahariha@linux.microsoft.com> wrote:
>>
>>  static const unsigned int sctp_timeouts[SCTP_CONNTRACK_MAX] = {
>> -	[SCTP_CONNTRACK_CLOSED]			= 10 SECS,
>> -	[SCTP_CONNTRACK_COOKIE_WAIT]		= 3 SECS,
>> -	[SCTP_CONNTRACK_COOKIE_ECHOED]		= 3 SECS,
>> -	[SCTP_CONNTRACK_ESTABLISHED]		= 210 SECS,
>> -	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= 3 SECS,
>> -	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= 3 SECS,
>> -	[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]	= 3 SECS,
>> -	[SCTP_CONNTRACK_HEARTBEAT_SENT]		= 30 SECS,
>> +	[SCTP_CONNTRACK_CLOSED]			= secs_to_jiffies(10),
>> +	[SCTP_CONNTRACK_COOKIE_WAIT]		= secs_to_jiffies(3),
>> +	[SCTP_CONNTRACK_COOKIE_ECHOED]		= secs_to_jiffies(3),
>> +	[SCTP_CONNTRACK_ESTABLISHED]		= secs_to_jiffies(210),
>> +	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= secs_to_jiffies(3),
>> +	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= secs_to_jiffies(3),
>> +	[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]	= secs_to_jiffies(3),
>> +	[SCTP_CONNTRACK_HEARTBEAT_SENT]		= secs_to_jiffies(3),
> 
> You have changed this last timeout from 30 seconds to 3 (presumably
> just a copy and paste error).
> 

Will fix in v3.
