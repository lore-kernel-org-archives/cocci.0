Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CA6C433FE
	for <cocci@archiver.kernel.org>; Tue,  8 Nov 2022 07:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hj/kVZNefcuUWOAa2u9mqxtLX107AkFvcPCLsnb30AM=;
  b=oxb+0XNJe+se9RKdIJcbV+Iz7H+RTgBieOAZpV3urUYuxYcMdEcTgvUq
   j5KutPqZ5ahr4lBnObHlDqI8Ry8mPBbJpvfQtJjoSy36z4mZd90GU6jSq
   w6jdyF8CTSLBW16Un9rzcc+j/r2zv9dPPXMrh6Xhhw7mJSGRjTLgpf7Kn
   I=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@univ-grenoble-alpes.fr
X-IronPort-AV: E=Sophos;i="5.96,147,1665439200"; 
   d="scan'208";a="77153969"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2022 08:55:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5057CE039C; Tue,  8 Nov 2022 08:55:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 45A63E0076
	for <cocci@sympa.inria.fr>; Tue,  8 Nov 2022 08:55:05 +0100 (CET)
IronPort-SDR: 636a0b59_lho4+++53qYHeQgnsHcQB1Ox5u3OwP6n9XOTyxaAizGfiqL
 yS+B2zhxHOxp2ilZBkxrNNo4hsj78KALEJ43p2w==
X-IronPort-AV: E=Sophos;i="5.96,147,1665439200"; 
   d="scan'208";a="77153950"
X-MGA-submission: =?us-ascii?q?MDHlSMHaAcGOTZzGiBFgRBAKeaSe/1SzRK4+1u?=
 =?us-ascii?q?mNNbrsxp2RJeJnM3APJz0+/Zl406FjI00ig22TfupmbtqagJegMx+Jx7?=
 =?us-ascii?q?UaKNiOqgFXy0pFM0/TD1k85jkWe5z8513S2RTYMzFGY4LH0w+SxZ+Wfq?=
 =?us-ascii?q?BVErJ/PUCoA+u7p2/Nj9ZQxQ=3D=3D?=
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 08:55:05 +0100
Received: from mailhub.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
	by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id E97F140388;
	Tue,  8 Nov 2022 08:55:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=univ-grenoble-alpes.fr; s=2020; t=1667894104;
	bh=CifegeMCjXZQIpdO+ZEFHnXLYSNMGD8TGBz3ntYzCk4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M9e07P2kLBWj/+Uoas4G4ukBBAhMtEvltORoInAIUwOv/kYb7r0m/QK/mgGEbnt9L
	 vUk2yzDN6koFWiywXVim5q1+KXnXaI3SwsDnhphFBnLeHR3He9RZWBOpFuxllR6d6F
	 KPYoTM7IMOIxe/6rohzAsGdKDyQzNoV6sYgpu5YSrDvDvjuXf75fqVwKT8hqVhPWTQ
	 tHPHVDxrg4ZSrN3aymcowwu/pEADWq6afZD9djULZh5ugSKz06fWnlBOtgfpprQxXJ
	 hKZe36ejGrwuATY9jWVquT9oFF/rVlaga5W/sHWnyaAVAKpYh34DPBmLxAwUgMmIQ+
	 pRng8whQopcDg==
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
	by mailhub.u-ga.fr (Postfix) with ESMTP id E663D10005A;
	Tue,  8 Nov 2022 08:55:04 +0100 (CET)
Received: from [192.168.1.50] (amontpellier-653-1-4-7.w92-145.abo.wanadoo.fr [92.145.106.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: palixn@univ-grenoble-alpes.fr)
	by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 70BDD40050;
	Tue,  8 Nov 2022 08:55:04 +0100 (CET)
Message-ID: <2fcd7fdb-7984-a2b7-7995-d164754c5eb2@univ-grenoble-alpes.fr>
Date: Tue, 8 Nov 2022 08:55:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: fr
To: Julia Lawall <julia.lawall@inria.fr>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr,
 kernel-janitors <kernel-janitors@vger.kernel.org>,
 nicolas palix <nicolas.palix@imag.fr>,
 linux-kernel <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
 <bd13da2d-6d18-4f33-0987-a193e3c9b761@web.de>
 <20221107200815.u7hcwejileeabnct@pengutronix.de>
 <257596884.6156222.1667886713273.JavaMail.zimbra@inria.fr>
From: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
In-Reply-To: <257596884.6156222.1667886713273.JavaMail.zimbra@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Reply-To: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
X-Loop: cocci@inria.fr
X-Sequence: 723
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/2fcd7fdb-7984-a2b7-7995-d164754c5eb2%40univ-grenoble-alpes.fr>

Hi all,

On 08/11/2022 06:51, Julia Lawall wrote:
> 
>> After uninstalling python2 this ends in:
>>
>> 	Cannot find Python library
>> 	coccicheck failed
>> 	make: *** [Makefile:2076: coccicheck] Error 255
>>
>> Didn't try to debug that any further. Is that worth a bug report against
>> coccinelle (which is shipped by my distribution)?
>>
>> I tried to adapt the org and report modes from other patches in the same
>> directory. So a critical glimpse by someone more knowledgable than me is
>> recommended. However I don't know how to react to "I doubt ... is
>> appropriate", I'd need a more constructive feedback to act on.
> 
> I'm not a python expert, so I'm not sure what to do about this python2 vs python3 problem.  Is there some strategy for printing that works in both of them?

It sounds like a missing dependency in the package system of the 
distribution. Coccinelle has been build with Python support, but
some libraries are missing.

Which distribution is it ?
Can you install some packages that provide the two missing shared 
librairies ?

> 
> julia

-- 
Nicolas Palix
+33 4 574 21538

