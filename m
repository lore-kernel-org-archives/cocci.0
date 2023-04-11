Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDC2C76196
	for <cocci@archiver.kernel.org>; Tue, 11 Apr 2023 06:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=h2uixlNpC4PKhVjTFhFgoEihI3/3YRbxYRaYpGzVhLk=;
  b=o1ATvCYznqtnni7RFRMOr4pzy0r3RRBHjvs+dlIzbtEMhajEmPuvXJqm
   jCm8CrYsBbOj6wu6NwhAQVsmE2x+NcxtLj7jT9kIHbgv/nI2T11fUK27l
   hiHu99y3WrT/XBTOvqxCaQ7/JUL39vKmzvVXQtgUgQmglioh9ZiQbSoDB
   E=;
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
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102334488"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2023 08:15:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0FDA0E7315; Tue, 11 Apr 2023 08:15:35 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CFBA0E72F8
	for <cocci@sympa.inria.fr>; Tue, 11 Apr 2023 08:15:32 +0200 (CEST)
IronPort-SDR: 6434fb03_qC7W2onxZEoL5SCEcmU3ZdXgaEP+cDqgfpUb0J8APpDrfNX
 s9mLwdRpSTJ3u7U264In/5GCQrupM3oG9RANcTQ==
X-IPAS-Result: =?us-ascii?q?A0FCAACY+TRkh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItgUsvBAtGhFOQfzGEMIcuhz6Ia4FWFIEsPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wSEfwKFPQIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBA?=
 =?us-ascii?q?hABAQEYCxcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkc+AQICASMdAQERJgEPCxoCJgICVwYBDAgBAYJ6gigBAw4jB6wjgTKBA?=
 =?us-ascii?q?YIIAQEGnAsfLCJUgV4JgRQtAY0JgzZ6Jw+BVUSBPIJTMD4ehA0Zg1uCZ45li?=
 =?us-ascii?q?0UKgTR0gSAOgTyBBAIJAhFrgRAIaoF5QAINYwsOb4FJY0yBewQCFDglBA4DG?=
 =?us-ascii?q?SsdQAIBCzs6PzUGAwsfBlhrAgkjERMFAwsVKkcECDgGHDQRAggPEg8GJkQOQ?=
 =?us-ascii?q?jczEwZcASkLDhEDUIFHBC9cfAoGASYk5h00B4IqgVaBWQyfDQYTL4NqAZMeD?=
 =?us-ascii?q?gaSJZdzIKd/gWoJKoFcMxokgzZPAxkPjiAZhAyPSD80PQIHAQoBAQMJhUYBA?=
 =?us-ascii?q?YV9AQE?=
IronPort-PHdr: A9a23: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
 JdcEtdm
IronPort-Data: A9a23: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
 PrxgKfOxMkzsfmosfkx3Tg7YjqiOw==
IronPort-HdrOrdr: A9a23:xNgqCKHaAbSEUDQHpLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102334484"
X-MGA-submission: =?us-ascii?q?MDHLuL6e0sNOEbmTSaJVTJb26XwsLJpjrBwf+A?=
 =?us-ascii?q?iSSD3guDSFNqFIxJfxZ6D77Zar936ujUkvU+Dx425s5fjItE7ne4XTz4?=
 =?us-ascii?q?uvI8zNfcsGsCJM7Jd1xrGXO4a2OndEfOkw4El1mlwFGc0TfQl2aiFwab?=
 =?us-ascii?q?OtrVHI+GsXCakux19JNZGiyw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 08:15:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681193729; i=markus.elfring@web.de;
	bh=h2uixlNpC4PKhVjTFhFgoEihI3/3YRbxYRaYpGzVhLk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K+8q5YSg69zJ/KutrP8ieW2wzlZXen6r5YAPLRmUO1hy4d4WuUEVvpJhFfDCjVErO
	 WcvveS5jI4phV2sSn6+Wlx66PGsJ4RakFRwCTqBB38WIR0x3GpReHL8EJcyJMd1Udn
	 4loc73o0u8PEB3/4ey4nKTYuYXBHlOLu3VoaLdAN4tPc7GVH/ssdzj3F8JovrywF4d
	 wEXh4/8ab3bfI3YZvS9KTTPMJLT98vPP36XjKBUu4w1djpGB56uj3ViYwMahAx7qib
	 oDS/US1euZyYpjnvH4HKnJZOLkGqKbeCPBWIOetEKFMO768NaIs3ANmrQZywpcDGeQ
	 k38HLLZB8TIsA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuF8x-1qe4r62SpJ-00uFND; Tue, 11
 Apr 2023 08:15:29 +0200
Message-ID: <e53bfa4f-c4b0-ee80-a64c-be8e9af76230@web.de>
Date: Tue, 11 Apr 2023 08:15:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <b3cce5b3-2e68-180c-c293-74d4d9d4032c@web.de>
 <2d125f3e-4de6-cfb4-2d21-6e1ec04bc412@web.de>
 <20230403033529.x6n3ihhkypwizq3b@vireshk-i7>
 <39342542-9353-6a7b-0aa9-f9c294b158cb@web.de>
 <20230403230432.xeubpa3cc2gt4mw3@vireshk-i7>
 <68b1988b-987f-fa2b-111e-b1b42f9767ab@web.de>
 <20230409235511.7xxqdxsqtflrhifk@vireshk-i7>
 <f9f40c8a-a392-27e3-b19c-c8985a163159@web.de>
 <20230411033048.zwsijlyiksjcmgcc@vireshk-i7>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230411033048.zwsijlyiksjcmgcc@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NjPk0DUjCytyIf5LUdqkZZ1Pg1WiBRWJHDb/LvhdLBIuW7/Vkte
 1m2S7kYzDDFUaU5xCwvwyssalUT4Y6UG5cEDxx0t13uXxRLeZLALFi13lXfc/a3pAVMcb12
 q30g18y047WwQqWNsd1Cd9qQXW3c5H64yELA/ApPTd/y0FbaY0i8TtnI65dLLx0stG2FtUm
 n8MuLzyFy5Avk2aU72TCQ==
UI-OutboundReport: notjunk:1;M01:P0:HpHSpb9xzpM=;46fjngk2/Hm8LTS96ZzVWIyWECM
 b/e8QK2lGJxTZPl+zqfQ+npOQH+1WFFVBEa1VYJy1UaoHTVeJoi2aPsscVxdf/WvMySmZg44f
 +tqLYNiN31382UJsXds+69vCWNJS756iFUXR4THoRR8tDmzZLsWmUmvthsiD8XWD/PUg1fosR
 throBaSmHSxlbWzL5KdaESeliCBdcDMpXB7Y0JMhT8MbhkGPbb8/i/G6KnoSOULhK5RQdU7hH
 YpT2vcXAPA4429MlTh9PRnOzmfesdWyoNGfiEq746uzWFP/q9+G4OwIsRMB08L7iGZd9I6WLW
 zkjo3k2hxiAeutRPjY3Wo3IFn5mqPm+nZF7nhD55q0nK+eDe1dVpQUOtXevR8ldtstvRyiCb2
 PecpZ5zqGISjrfeKeNed0IJya9MrPOzMxkcszPuvr5Z7Hd3AYn2uOiVbO+hzuKVVb/kA38BVd
 cHSRuO7Rz1O6ziKt9vkeFM4X23kqACQZW6u0n30nCsB4uTAdtALqN3tQdSb0NQoSjf3iBOwom
 h5bOjGXiUvNTJaMhBBuzQiTN4ahhGBoYdRH+xV316KBfBttkQPGfsQEe4oRFkUNQici8cgvbQ
 j0/FODna7/tVByg7KYLaTs5wglqwnQQXKiLZV6zLD+vx1QOc4yu0de1y+cfjW9vV6g6Z8aFyo
 X9WSnk7TvPLQn1/YAtJs3puFdkyxYiprFcTWlOk54P9wtt5LsBaqdduYnw+rIwQOEwbwcPEJd
 EV2N0Vsr8OgrJK5h6XGZt9v42FmoGpSpJJ7S4Lp2j5vjYhETpCBlNKSDo2EcYpU38419Z+88c
 79J6U8XRcUkqhFfRT5EWPn2NrsIHCEVBt1/vVRFxH0WBNgJ9fmgMP4fRhlOuAllrHgHB5KRla
 vHhptHtjkDkcKOGO7cJeIuQ2U8YUkjfqH4yF4WwYyO+Omo6u/+wgTJw1W
Subject: Re: [cocci] [v2] cpufreq: sparc: Fix exception handling in two
 functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1024
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/e53bfa4f-c4b0-ee80-a64c-be8e9af76230%40web.de>

>> The setting of the variables =E2=80=9Ccpufreq_us=E2=80=A6_driver=E2=80=
=9D influences the need
>> to reset them to null pointers for the desired exception handling,
>> doesn't it?
>
> This is what all should be done for these drivers I guess. There is no
> points doing the dance of {de}allocating resources unnecessarily.

Are you going to integrate your source code adjustment according to
reduced dynamic memory allocation?

Regards,
Markus
