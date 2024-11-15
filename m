Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6146CD68BDC
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3z7ywabUJ27i2rb14B4LEGDccer8KYu9+MGXqf4uX30=;
  b=SqgeL4hZfhKg1qGRlvzEYUXRGO+azaAhexfVSepj5l3LhWKJ9FCHzE30
   wpm20I9oedON/zFqIXOObu6ROLT3XbZpPJlc18B6+mnROcoottcAl6/mY
   EDCepSxxTQ2CJk8HId/N0Cu1ZZlcqtJNsqSJB8cvPq+EuJvCz327OurVz
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
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194170298"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5107FE0DA6; Fri, 15 Nov 2024 23:36:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 77967E00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 23:15:28 +0100 (CET)
IronPort-SDR: 6737c7f2_fGD6KGYvGCWLApEW7Re0CHpUNGZO4iltYjuPdiEXz9fIxNT
 ScXJiKQSJJTygrv7HvdQiex3ihXMDxwkjX2KQIg==
X-IPAS-Result: =?us-ascii?q?A0EkAACQxzdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfQZUMwcISASEUogdiVEDi3OSI4FAPg8BAwFIBgECBAEBAwSFA?=
 =?us-ascii?q?AKKSwIfBgEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABg?=
 =?us-ascii?q?QyFew2CYgGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BAR4BA?=
 =?us-ascii?q?QEDERIdAQE3AQ8LDgoCAiYCAlYGARICAQGCfQGCZAMDAgwGnzkBh2ABAQKLI?=
 =?us-ascii?q?4EygQGCDAEBBtwfgWQDBoEaLgGBYYZqAYVpG4RcJxuBSUSBPA6CdT6EWINGg?=
 =?us-ascii?q?mmCRS2EZiVNiDKMF41zUnscA1khEQFVExcLBwWBKSEsA4F7Tn+BNoFRAUGCT?=
 =?us-ascii?q?kqDLoFeBTcKP4JKaUs3Ag0CNoIkJFmBHYEygSUEBYNsgQuDYWcvAwMDA4M8g?=
 =?us-ascii?q?3UdQAIBC209NQkLG0OgAgFGgkOCLCAwIxIMgQI3ljsBjFWBNmuhAIQkjBaVM?=
 =?us-ascii?q?gYPBC+XVJJ6LodkkGUii2WBeJVzhQSCGDqBXEYHIxWDIk8DGQ+OIYN6hRTAZ?=
 =?us-ascii?q?SI1AgE4AgcLAQEDCYVGAQGKD4FLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wSR
IronPort-HdrOrdr: A9a23:7TV2cK5065AliOHvyQPXwPjXdLJyesId70hD6qm+c3xom7+j5q
 STdZMgpGfJYVcqKQgdcbLpAsO9qBbnmKKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8ND4Z/LfD1HZK3BkWqF+rgbsbu6GeyT5Nvj8w==
X-Talos-CUID: =?us-ascii?q?9a23=3AXsXkF2m+hEeND3YLoDjFt+nDhjHXOUH20CiIHxH?=
 =?us-ascii?q?kMkVCSIW6ZgaUqJ5GkOM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AlnF/WAwxtATvlasXKHqTuWef42GaqKWgL2BduNY?=
 =?us-ascii?q?jgpK7EitLJGuR1h6UZpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194168297"
X-MGA-submission: =?us-ascii?q?MDHnwAIQgHEj3Pt7zKRvl+geY3Y1N/kZPgPJ2g?=
 =?us-ascii?q?zAUrrydNjEpHIOiAVuJeLIDgpXZ7z+ec9/eyH8PMHFACvFn/5xgaqa7V?=
 =?us-ascii?q?CusUvXt3uRFWw7zdvk/uuicbBLq+5DB/uW3KutzPvdlaPX5c4EW+2IDN?=
 =?us-ascii?q?kQaR9SYkwj/irZHG06ep9mkg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:15:13 +0100
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id C2E092064AEB;
	Fri, 15 Nov 2024 14:15:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2E092064AEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731708911;
	bh=3z7ywabUJ27i2rb14B4LEGDccer8KYu9+MGXqf4uX30=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=N1g55SdNOAVrXtoAUWPnvUkB3x2fHI9b6jafO92eRdbbD4Gte6s/kvOokfmkgYHJe
	 Frz5kbgdiLksPpFFaWRXGFZ7VcwJJIP77+3HbEyB4bGSyYhL140G+m7AP2fdg7ax7k
	 BFhXHlM0RPRrW6JGtgd18IntrfjEtsdFiu0GVoGc=
Message-ID: <8127a2e6-fa62-4c85-b7ed-24748cc9e285@linux.microsoft.com>
Date: Fri, 15 Nov 2024 14:15:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, netfilter-devel@vger.kernel.org,
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
 linuxppc-dev@lists.ozlabs.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Naveen N Rao <naveen@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Louis Peens <louis.peens@corigine.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Lucas Stach <l.stach@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, Petr Mladek <pmladek@suse.com>,
 Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>,
 Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Marcel Holtmann <marcel@holtmann.org>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Jack Wang <jinpu.wang@cloud.ionos.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jeroen de Borst <jeroendb@google.com>,
 Shailend Chand <shailend@google.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, Oded Gabbay
 <ogabbay@kernel.org>, Ofir Bitton <obitton@habana.ai>,
 Sven Schnelle <svens@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Russell King <linux@armlinux.org.uk>, Robert Jarzmik
 <robert.jarzmik@free.fr>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Daniel Mack <daniel@zonque.org>, Nicolas Palix <nicolas.palix@imag.fr>,
 Julia Lawall <Julia.Lawall@inria.fr>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <10ee4e8f-d8b4-4502-a5e2-0657802aeb11@linux.microsoft.com>
 <3ac480f5-549b-4449-baa9-f766e074c409@quicinc.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <3ac480f5-549b-4449-baa9-f766e074c409@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 00/21] Converge on using secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2053
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/8127a2e6-fa62-4c85-b7ed-24748cc9e285%40linux.microsoft.com>

On 11/15/2024 1:41 PM, Jeff Johnson wrote:
> On 11/15/2024 1:29 PM, Easwar Hariharan wrote:
>> On 11/15/2024 1:26 PM, Easwar Hariharan wrote:
>>> This is a series that follows up on my previous series to introduce
>>> secs_to_jiffies() and convert a few initial users.[1] In the review for
>>> that series, Anna-Maria requested converting other users with
>>> Coccinelle. This is part 1 that converts users of msecs_to_jiffies()
>>> that use the multiply pattern of either of:
>>> - msecs_to_jiffies(N*1000), or
>>> - msecs_to_jiffies(N*MSEC_PER_SEC)
>>>
>>> The entire conversion is made with Coccinelle in the script added in
>>> patch 2. Some changes suggested by Coccinelle have been deferred to
>>> later parts that will address other possible variant patterns.
>>>
>>> CC: Anna-Maria Behnsen <anna-maria@linutronix.de>
>>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>>>
>>> [1] https://lore.kernel.org/all/20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com/
>>> [2] https://lore.kernel.org/all/8734kngfni.fsf@somnus/
>>>
>>> ---
>>> Changes in v2:
>>> - EDITME: describe what is new in this series revision.
>>> - EDITME: use bulletpoints and terse descriptions.
>>> - Link to v1: https://lore.kernel.org/r/20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com
>>>
>>
>> Apologies, I missed out on editing the changelog here. v1 included a
>> patch that's already been accepted, there are no other changes in v2.
>>
>> Thanks,
>> Easwar
> 
> How do you expect this series to land since it overlaps a large number of
> maintainer trees? Do you have a maintainer who has volunteered to take the
> series and the maintainers should just ack? Or do you want the maintainers to
> take the individual patches that are applicable to them?
> 
> /jeff

I am hoping for tglx to take it through his tree since the patch
introducing secs_to_jiffies() is in his tree, so sequencing of
dependencies would not be an issue.

But if tglx won't, we could push it out another cycle and individual
maintainers can take the patches that are applicable to their tree for
the series.

Thanks,
Easwar
