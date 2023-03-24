Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30990C7619A
	for <cocci@archiver.kernel.org>; Fri, 24 Mar 2023 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RHsurbdzd2jF+P9BCTKbE6gSb10VPLgsD92TZmb2Yvw=;
  b=VMIq1uH8Ck8QThS4N8Gpi1u9mihbYJbPDDaeaihI5xwXAXOMoTG5/3yv
   T0K65pMEL/ytc9Op5ZkBrt24XZ7UccdC/ohbXc6kpmgVRnBuUUduJ+qDp
   YvwjRDhoDGYpWwCXljSxXTcV0W9ORND3kOhBtXaMtL5Pj5DlXjAYOMWPT
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,288,1673910000"; 
   d="scan'208";a="98997923"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Mar 2023 19:03:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 15C87E0D45; Fri, 24 Mar 2023 19:03:12 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A285CE0D40
	for <cocci@sympa.inria.fr>; Fri, 24 Mar 2023 19:03:10 +0100 (CET)
IronPort-SDR: 641de5e0_TGk7CB0Ohu7/rQlqK7Y9zaCvrP+MVy1RSG3kTi58tqa/RXI
 20lARskOxeAoNGzPAXA7H2CTsJK7NeELNWd3mRw==
X-IPAS-Result: =?us-ascii?q?A0FwBABs5B1khwsR49RaHQEBAQEJARIBBQUBQIFPgi51V?=
 =?us-ascii?q?i8EC0YIhEuRAS4DaYNGk02EAoMWPg8BAwENNA0BAgQBAQMEgguCcwKFOgIdB?=
 =?us-ascii?q?wEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHD?=
 =?us-ascii?q?hAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAg06GDs9A?=
 =?us-ascii?q?QICASMdAQERJgEECwsODAImAgJXBgEMBgIBAYJ6AYInAQMOIwcMBrF5gTKBA?=
 =?us-ascii?q?YIIAQEGgUABmkkfLCJTgV4DBoEULY0FgzZ6Jw+BVUSBPIMDPoJEB4F5g1iCZ?=
 =?us-ascii?q?4Iqh1aEI4J1iC0KgTR1gSAOgT2BBAIJAhFrgRIIa4F9QQINZAsOb4FLAmRMg?=
 =?us-ascii?q?RolBA4DGSsdQAIBCzs6PzUGAwshBlhrAgkjERMFAwsVKkcECDkGGjQRAggPE?=
 =?us-ascii?q?g8GJkMOQjc0EwZcASkLDhEDUIFHBC9bgQEGASYkmm0DFoI/EQJSZyAmlFMJk?=
 =?us-ascii?q?kCKFpN4NAeCKIFVgVkMigyVAAYTLpcIDgaSIy6HLZAPIItDgW+aSIF6I4FcM?=
 =?us-ascii?q?xokgzZPAxkPjiAZhAyEYYpmQDQCATgCBwEKAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
 BI72FIWXA==
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:btnX6qF62qY3q8OQpLqEPMeALOsnbusQ8zAXPo5KOHlom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,288,1673910000"; 
   d="scan'208";a="98997920"
X-MGA-submission: =?us-ascii?q?MDH5bZap51VVoLMVnIhr2eJlA2oPRRZrPvasb5?=
 =?us-ascii?q?I5bFRPqVTphT14xpp0Fq0pY+BFa9L2rmflon7ycVV3Zu7OJxAnFchiih?=
 =?us-ascii?q?HcQJRdGT4iuuXkk4qgiaR4S66+4dgvIUuIs+8yuXWZe/+Ejur8jAzSjU?=
 =?us-ascii?q?OcsvoofKtv6rZ3Lq4tCsTbCw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 19:03:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679680983; i=markus.elfring@web.de;
	bh=RHsurbdzd2jF+P9BCTKbE6gSb10VPLgsD92TZmb2Yvw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GvwiJ9ut0E+qaOXet8zYlnM7/lywNxKts4NDPdiM2ONO6rLoWMibLEml5nGVvVxst
	 3oRcPUTCKQ+dC4Rd+NVN99arxyQ4GMtkU1VjOo4ITruLxzHMiiAdAI++atS98FhmCa
	 MIpUpYnXXINfaJyotjh09BwL8lO4MRr5zJCgAitd3O2poJNQE6CiD4Jx6xRXLde1JE
	 dJf9XPR5PUUT00yHcXw/JnB5aKNT7+0qFfFGaKbFtXQgw0LGi/8D1JcpDbTOmh11wA
	 XBraTOirvJzkb0/aNIIUBs0VnCOhmuYqfnUnlp9PLEkepdz/YZ9TSg92ZGc3KoxfmU
	 w3pogz4KyoriA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIya8-1pveyj0Mzi-00KNjP; Fri, 24
 Mar 2023 19:03:03 +0100
Message-ID: <2d012b08-ea84-79ce-c858-113b26655b5c@web.de>
Date: Fri, 24 Mar 2023 19:03:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: Vlastimil Babka <vbabka@suse.cz>, kernel-janitors@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Kosaki Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Mel Gorman <mgorman@suse.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <6e9ca062-939b-af96-c8ff-56ad485d6e79@web.de>
 <22a1ec75-155a-2392-ce39-4bca3fc081eb@suse.cz>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <22a1ec75-155a-2392-ce39-4bca3fc081eb@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hcldPPeDEvEkETjaa2RUSGTxpzZWR3vaRrmaQelJvteg9wMlR/P
 4UmGi4aEIxS2lUWrqMs9ia+2lLo7v9xdMKMoWOCp23BrcoCw5iU/3OYTyMkZp2+tH1FAO4E
 UkGFcyb3PCrb36plF0mFSDP9I6phcRYS8IeYXk5qoJ8fWfivK+7o3nEfPNzKNKOZhKraCP9
 bCAUH6P7lmQBH5crSzUyg==
UI-OutboundReport: notjunk:1;M01:P0:eYt2YIl+NVw=;ny35/dbsr9awgEHE81/kFxux+uB
 EIDeWgwHynQK41KYORTaR8A3oz1mCHtDyOX2AdPDWceFysScFw+EPrWpYBRIsHHbUAL+ZlGcO
 AKUUUSgbj6hE06vrDIj846tTZyk+kw6PWMuT5XgdshCFRiMlmTJuPlF2NVvEXEYCWaeKqNeqz
 ReQnG+1GjPklBbZfMRQE76H335ZQcGpFh8uRIlkh6FlWzLWceH2Cb5iZBX3TJkWTqj7rZstOF
 ts2y+7sxYaq09MxM1WX2gnSZtT4CxDPpODazmc46LwegucBAXJ2igwb3uJmP+130AvsiAJq1L
 UrHmwR/h6gqCCFo92arYwkNu7Ieu46Ml0ZUT7vQRpCuO9Tk/yDwkfb3l/XKwpaAeVxHDaiHGA
 QHhaHYji7nS6JVgZ94cslQqLD4RuFCo00oAxy0vEB/+8Dy5hruYZJoyio5V0hM5bsD4tHc1DR
 QagQ6gGbHyZ7MjXsDzjY5ckXu824GZpSBR+VvDxyO6uifaOHEiOaU63fGJkrWdnqArRu0ABtt
 eS/qpDRTAnqtdqUCLSGy1T5k7s9DFuQzp/Ci/0OrVYMReK56Ql/gAU6Ib3SXgYy0m9n1tFQzz
 NbJ7su4GPNDZRA4SKIxI86rbwoKPjOzA76dF1qhwoW6k0eF0jQRInexojxcwJtivgEPwuAT7p
 MylEvQ/XUlr1YSP9Cz1TmBy9xiMgSxaHNk9mOzP6BCwogH2F3xezTjlJsmc2RkPOSP06pHAQT
 j8i1OoGSrhtTdpXHTzUPca7aNvuZrEmgToZJO803gC+yP0PsOZly0RPshJqpY5fZuaDgpnioS
 cRVOsaKEWsWG6eVp1KljPyPyox4HJoludyahQc8oCbkQdeEUwr6LtvGGt78POP1OPzd9ZKbAO
 Zdhj8yW1XQRFdgJKFo+rcqiD1zjm9dwYV8015AZplSijZ33Uke2uopKR9
Subject: Re: [cocci] [PATCH] mm/mempolicy: Fix exception handling in
 shared_policy_replace()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 920
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/2d012b08-ea84-79ce-c858-113b26655b5c%40web.de>

> Your patch doesn't apply, seems like it uses spaces instead of tabs.

I am sorry for this glitch.

Andrew Morton picked my change suggestion up yesterday.
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patch=
es/mm-mempolicy-fix-exception-handling-in-shared_policy_replace.patch


> https://lore.kernel.org/all/6e9ca062-939b-af96-c8ff-56ad485d6e79@web.de/
>
> Re: subject, I don't see a bug that this would fix. You could say it's
> "cleanup" and this function could use one, but for a cleanup it's not
> improving the situation much.

I find a few details improvable also for the mentioned function implementa=
tion.


>> The label =E2=80=9Cerr_out=E2=80=9D was used to jump to another pointer=
 check despite of
>> the detail in the implementation of the function =E2=80=9Cshared_policy=
_replace=E2=80=9D
>> that it was determined already that a corresponding variable contained =
a
>> null pointer because of a failed call of the function =E2=80=9Ckmem_cac=
he_alloc=E2=80=9D.
>>
>> 1. Use more appropriate labels instead.
>>
>> 2. The implementation of the function =E2=80=9Cmpol_put=E2=80=9D contai=
ns a pointer check
>> =C2=A0=C2=A0 for its single input parameter.
>> =C2=A0=C2=A0 Thus delete a redundant check in the caller.
>>
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Fixes: 42288fe366c4f1ce7522bc9f27d0bc2a81c55264 ("mm: mempolicy: Conver=
t shared_policy mutex to spinlock")
>
> Again this is not a fix.

Do you find the change description helpful?

Regards,
Markus
