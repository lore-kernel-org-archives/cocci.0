Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C57D591B2
	for <cocci@archiver.kernel.org>; Mon, 18 Nov 2024 18:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fIQzgF1WsNR1uKKNTq0/EQo7zmlio+cixqR17RrtuRg=;
  b=aRWaXZ+Q9IcrLHovufVzr8DmOFTelZV0DQXxYNs9ikr2IenqA04ifs7B
   1PqIPFDvz2QFFc8OeS3bjCfJiwFkB/BwtuRLgc56i5snBhZ2mdpP+Gy91
   0aecIb5id7RuWUzu2RVHQRjQGJP2uGfXs9hPwhVSQhGNSshuSpb6KY8Of
   0=;
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
   d="scan'208";a="194516948"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2024 19:54:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F1CEDE0D9D; Mon, 18 Nov 2024 19:54:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9D58DE00B7
	for <cocci@sympa.inria.fr>; Mon, 18 Nov 2024 19:18:55 +0100 (CET)
IronPort-SDR: 673b850e_QY9pvBT3Xwx+TtOv0OwMIqz8eJo0+donlf5ziZc9Le0HCNF
 91v9ehqbGEsX8qg6eoTF3cRXMIYinZXqw8sba1g==
X-IPAS-Result: =?us-ascii?q?A0F4AQDMgztnhbaaTQ1aHgEBCxIMQIFIC4JEfQZUMwcIS?=
 =?us-ascii?q?IRWkW4DE4tgkiSBQD4PAQMBRggBAgQBAQMEhQACilACHwYBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNgmIBgSRRDQMHP?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCDV4BHwEBA?=
 =?us-ascii?q?QMREg8BDQEBNwEPCw4KAgImAgJWBhMCAQEXgmYBgmQDAwIMBJ5EAYdgAQECi?=
 =?us-ascii?q?yOBMoEBggwBAQbcH4FkAwaBGi6ITAGFaRuEXCcbgUlEgTwOgXOBAj6EWINGg?=
 =?us-ascii?q?mmBFIExeYMgdiVNh0pokW+II1J7HANZIREBVRMXCwcFgSkhLAOCR3+BNoFRA?=
 =?us-ascii?q?YMQSoMugV4FNwo/gkppSzcCDQI2giR9gR2BMoElBAWDaYELg2FnLwMDAwODP?=
 =?us-ascii?q?IQRHUACAQttPTUJCxtDoAkBRoM1gQ4BK4F9AXmTIIJuAY52aaAXhCSMFpUyB?=
 =?us-ascii?q?g8EL5dUknouh2SQZYUaiGWVVoUhghg6gVxGByMVgyJPAxkPjiEMDQmDWIQ+w?=
 =?us-ascii?q?ggiNTsCBwEKAQEDCYVGAQGBAIpwgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 gSR3g==
IronPort-HdrOrdr: A9a23:9PvrZqNa4rXrN8BcTvGjsMiBIKoaSvp037Dk7SBMoG9uA6ulfq
 eV7YwmPH7P+U8ssBNJo7q90cy7LE80mqQb3WB8B8bHYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 xdmupFebjN5DNB/KXHCWeDYrQdKZW8kZyVuQ==
X-Talos-CUID: =?us-ascii?q?9a23=3APOH3ZGmFQtcpVEdbCPfn7bmvgGrXOVv3632KPGT?=
 =?us-ascii?q?/NUtGWLiSeWLX14lFucU7zg=3D=3D?=
X-Talos-MUID: 9a23:eKtzdgaH7fVbBeBT6SK0tR5EDdlRvI+cFHgcg54DmvCkKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,164,1728943200"; 
   d="scan'208";a="101964706"
X-MGA-submission: =?us-ascii?q?MDEeqX+C17hBaKrRAyN93FWYk0Qctvw10sj8a5?=
 =?us-ascii?q?Zwynpwq2ta0i2GTo2Ucn1EEuii3wJ3o1+wFtY3RGcX6SA6K/igSkhQEj?=
 =?us-ascii?q?crxqK3de+hbwbnHSIz1bbpSJ58NFuoHtsDFfntFO2UspcnaPF4DfQhEP?=
 =?us-ascii?q?WvRFsjJ3C4RcVqBlha8sgKGQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 18 Nov 2024 19:18:54 +0100
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7B6DB206BCF9;
	Mon, 18 Nov 2024 10:18:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B6DB206BCF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731953932;
	bh=fIQzgF1WsNR1uKKNTq0/EQo7zmlio+cixqR17RrtuRg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AG9s/uyDx0OBII3cr4HUzEtCn4nG6edMY2UD6tMYQJ1OpbxvtlkXS/eCyyKzQSDkC
	 KcdCHl5p58vf39EYGhD7mqQUrW1VKQADyz79vhjulvgZLmWmAZisUXU71InKFz7Poi
	 T4lQlDCJsC2Y9ZlNmbnEUe8f/zo4dQilCRsXYjpY=
Message-ID: <96f3b51b-c28c-4ea8-b61e-a4982196215f@linux.microsoft.com>
Date: Mon, 18 Nov 2024 10:18:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 eahariha@linux.microsoft.com, Pablo Neira Ayuso <pablo@netfilter.org>,
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
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
 Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Louis Peens <louis.peens@corigine.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
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
To: Petr Mladek <pmladek@suse.com>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v2-19-911fb7595e79@linux.microsoft.com>
 <718febc4-59ee-4701-ad62-8b7a8fa7a910@csgroup.eu>
 <Zzsfuuv3AVomkMxn@pathway.suse.cz>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <Zzsfuuv3AVomkMxn@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 19/21] livepatch: Convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2087
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/96f3b51b-c28c-4ea8-b61e-a4982196215f%40linux.microsoft.com>

On 11/18/2024 3:06 AM, Petr Mladek wrote:
> On Sat 2024-11-16 11:10:52, Christophe Leroy wrote:
>>
>>
>> Le 15/11/2024 à 22:26, Easwar Hariharan a écrit :
>>> [Vous ne recevez pas souvent de courriers de eahariha@linux.microsoft.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> Changes made with the following Coccinelle rules:
>>>
>>> @@ constant C; @@
>>>
>>> - msecs_to_jiffies(C * 1000)
>>> + secs_to_jiffies(C)
>>>
>>> @@ constant C; @@
>>>
>>> - msecs_to_jiffies(C * MSEC_PER_SEC)
>>> + secs_to_jiffies(C)
>>>
>>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>>> ---
>>>   samples/livepatch/livepatch-callbacks-busymod.c |  2 +-
>>>   samples/livepatch/livepatch-shadow-fix1.c       |  2 +-
>>>   samples/livepatch/livepatch-shadow-mod.c        | 10 +++++-----
>>>   3 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/samples/livepatch/livepatch-callbacks-busymod.c b/samples/livepatch/livepatch-callbacks-busymod.c
>>> index 378e2d40271a9717d09eff51d3d3612c679736fc..d0fd801a7c21b7d7939c29d83f9d993badcc9aba 100644
>>> --- a/samples/livepatch/livepatch-callbacks-busymod.c
>>> +++ b/samples/livepatch/livepatch-callbacks-busymod.c
>>> @@ -45,7 +45,7 @@ static int livepatch_callbacks_mod_init(void)
>>>   {
>>>          pr_info("%s\n", __func__);
>>>          schedule_delayed_work(&work,
>>> -               msecs_to_jiffies(1000 * 0));
>>> +               secs_to_jiffies(0));
>>
>> Using secs_to_jiffies() is pointless, 0 is universal, should become
>> schedule_delayed_work(&work, 0);
> 
> Yes, schedule_delayed_work(&work, 0) looks like the right solution.
> 
> Or even better, it seems that the delayed work might get replaced by
> a normal workqueue work.
> 
> Anyway, I am working on a patchset which would remove this sample
> module. There is no need to put much effort into the clean up
> of this particular module. Do whatever is easiest for you.
> 
> Best Regards,
> Petr

If we're removing the module, I'll drop it from the series. Just to
clarify, do you mean to remove all of samples/livepatch/* or some
particular file(s)?

Thanks,
Easwar
