Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C53C4332F
	for <cocci@archiver.kernel.org>; Mon,  7 Nov 2022 21:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ArPtGo0Ir6BJ7A5xeKaQfa7sHZljSO8Ie5/hqHxqGF4=;
  b=n2EUNZ6S+D/DF5KG9Rg836rK/VEdjP2yk4qMYqvjof7N+idZs3qedfMH
   0KjnfMq9pG6F5cOBXNbV/uOs2RE6T/sIXzwngTedTvya6ytzI/8yGHadB
   RpooNYpBgbFxQRsbyQqVHfLIwRxms/ijECUszx/ao7o0IFybl5g8KxVF8
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,145,1665439200"; 
   d="scan'208";a="77110261"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2022 22:40:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E7CDBE0157; Mon,  7 Nov 2022 22:40:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A5429E0157
	for <cocci@sympa.inria.fr>; Mon,  7 Nov 2022 22:40:38 +0100 (CET)
IronPort-SDR: 63697b55_MA+Vrle7fNHFL+M8lqrdmytNACTAeNzbSJp4XnI3zkUYuNu
 Hn4za59HnLOeGJ/HnwtDVjNhIKKi0MJZTygDZpA==
X-IPAS-Result: =?us-ascii?q?A0DGAQD8emljhwQP49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YIsgQVTLgQLRYROkGwIKYQphx6MDYdVDwEDAQ1BAQIEAQGDcoETAoR4Ah0HA?=
 =?us-ascii?q?QQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBGQkXBw4QB?=
 =?us-ascii?q?SKFaA2CNSkBg2QBAgIBIx0BAREmAQQLCxoCHwcCAlcGAQwIAQEXgmKCbgEDD?=
 =?us-ascii?q?SMHqjeBMoEBgggBAQacBh8sIlOBXgmBFCwBjGGDLXonEIFVRIEVJwyCdz6ER?=
 =?us-ascii?q?INXgmeOfYggJgQOAxkrHUACAQs7MgMKShsxJw4JHxwKBBcNBQYSAyBuBQo3D?=
 =?us-ascii?q?ygvZyscGweBDCooFQMEBAMCBhMDIgINKTEUBCkSDSsnbwkCAyJlBQMDBCgsA?=
 =?us-ascii?q?wkhHwcWESQ8B1c6AQQDAhAiOgYDCQMCIhNEcwIvERUFAw0XJQgFTgQIOQUGU?=
 =?us-ascii?q?xICChEDEg8GJkcOSj45FgYnRAEzDg4UA16BbQQ1Z5wMgkNkrleTLTQHgh6BT?=
 =?us-ascii?q?IFNDJ5kBhMug3iMU4YiDgYxkWMthxyPaCCiHYU6gXgkgVszGiSDNk8DGQ+OI?=
 =?us-ascii?q?Bkeg26KLEA0OwIHAQoBAQMJhUcBAYUdAQE?=
IronPort-PHdr: A9a23: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
 J8JV6MdS1E/UP8XWBwNIQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Qu3svKuknc4IHLqNqdw7qgI47skDotV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,145,1665439200"; 
   d="scan'208";a="77110260"
X-MGA-submission: =?us-ascii?q?MDHEbADKTbyezgz8U2ORJrRCCDMCP04eLDn/s9?=
 =?us-ascii?q?sG92kl9Q0yqd2AMJ7zYfiG/39KLviAZnPz33FpodS/gNF+udwzGB6pDG?=
 =?us-ascii?q?+h+8WjFFbqH1JUyfV+Nonhbd1qjbMos4tT724LPYPgVmFmEe7tPHkoi5?=
 =?us-ascii?q?JHw7jeuMODm+txtq17dgu9qg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 22:40:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1667857229; bh=XQyu5rEmWP3pIC1+IrAsH37lMUjmdHWf2IhSlx0b5SI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=A7BC4gXsVHa5+5bGiFv6Qo+KxRzz5AzUl59+vQweNWPMQH1gWS5CbnL0uiEf1V+oQ
	 WqJKKDPGp322q707Yq4HELQwSMJizqoNIAG0wpl65SBd74nd02b+t1O5K87cjhkRKX
	 8Mvmp9Lm5hUl+pFiDV7F3aWC46w264wb4Lb4JYef/P14+LPbKqJKM+sQvEqZwQEWMF
	 lD+C6jsBZtcoFBrlwaHHOn/SWSU67lv1J2JB4krCmscd7PaY5joFzU191s5oJ3H1VT
	 5QtlcmWASHB+R/dvtSCnJTEZFKlEBLjyDyVH7JJFcboujp+jFlfXRxkNvYPBdGzHeU
	 hyCn13RZSKPpQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3m59-1osQhi3DON-000r8M; Mon, 07
 Nov 2022 22:40:29 +0100
Message-ID: <217a1bdf-d841-4578-a58a-6ec3d1179215@web.de>
Date: Mon, 7 Nov 2022 22:40:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-GB
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 cocci@inria.fr
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, kernel@pengutronix.de
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
 <bd13da2d-6d18-4f33-0987-a193e3c9b761@web.de>
 <20221107200815.u7hcwejileeabnct@pengutronix.de>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20221107200815.u7hcwejileeabnct@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hij8F9cjVPKcDJnnn/i32lGeX4FEE8/2uhOMvWFlFFVtqCkyfIQ
 FG5gOghGu4R+YF5K6AwB7MOyTnu8ng7AdMfKDSdkMINylu2mkSZokuWSvqvHgvzBriaKOWg
 2O4ZdZqR/UNmILQo1PbU7oDG//tj+Ft/mr/xqxUnvoU4bhnOQarotRUmabmzjJoG9mMqXJl
 +/ep5w29IBollE7l/xZeA==
UI-OutboundReport: notjunk:1;M01:P0:NwR4+6LSyXk=;HVUlmHIxvFqwQExEqR1/sPLiv7N
 Vnug40oIuO6l8uU9KT0m+f3YprsaZgg/wdFZUuqUVOfynMLrcDBX3rz/+XtHxuKmuCpQyCsS7
 ZVahdOu6IPct6LesgniGztGmCeRCNlVOtgedrIuOh9F9o4f1buYrNeP9/3LXeo9JKFZjBkSKW
 wr2w7hRTMAJj73SAe6tkcp4qS9HG1QhefqT9s6bAVFvkNsB456nJqiy6xztfgk1nNDRGSalZm
 14gU2j5dqUofUombSWzo/cbqI02ZbvSrNFZs0XcVEJcOx6GOf1Jq7GBkn5G6rxCmV6iyR8q8U
 7IrUDb7r+sM/RwL1Ps789gCWIZRuyYn0+pG53Pf8GUXeetDMibL8ZVre1BRWKaLH5PjgJc+bV
 KxEVmNfE4XpDHY8FLNWpIAioNXYsrNCjWOYRSZvOtAV3VVyf8M7c/Zf9yM1jQyzKTRVzLwcH+
 j33jkyJaXi5DRkneuc//US9c1xAcLNDOBGNwR37RGpTsUqxI4L+WvO5rtcU9rd32X78fD0J2f
 klNT9xfZRAzUmwYhwzCpaFZgbZOP32rMtExkOiU4IT+TLyTFP5vRdkQpHy9tGwFOC7JilQGrf
 N2evLbk2nA6aZqsVK1oxQrucZk2Yw5IGvgkmxUZ9/F/HbS449+ugoPY71EHn48P1MqjdWesnL
 vO7W3zz22Fb9HRVvM1tNDFr+BZg1vtH800r8DUetM8ZhFnOUNUFP8XCVH1kopQGRed+QFpJmL
 bpqGEC0lPjAQy3Blo3/FIklJLw1lQ/VwcqQvel0C17xrRR1cATQmc7JaSyS39+4upZDxwsT2m
 NGCgA7Aabtz5whsb0xv1HJX5QSOASKSbKVETc93hGsGuBxU6Hir2EZPx3cMFrJAJO+qcLElrM
 dYRik3jkx3Z1m7T9YAozy89+fF9PChthRFId+mTB3zGvKZRpmij3X7O8Rjgk50gsHF4jE0iI+
 idj5Jg==
Subject: Re: [cocci] [PATCH] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 720
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/217a1bdf-d841-4578-a58a-6ec3d1179215%40web.de>


>>> devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalen=
t to
>>> the shorter devm_platform_ioremap_resource(pdev, index).
>> =E2=80=A6
>>>  create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resou=
rce.cocci
>> =E2=80=A6
>>> +@depends on patch@
>>> +expression pdev,index;
>>> +position p !=3D r1.p;
>>
>> Why do you think that different source code positions would be required=
 for
>> your transformation approach?
> That is important that the implementation of
> devm_platform_ioremap_resource isn't adapted.


Can this design desire result in an other solution approach for a possible
script with the semantic patch language?


>>> +@@
>>> +
>>> +-  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
>>> ++  devm_platform_ioremap_resource(pdev, index)
>> I suggest to use the following SmPL code variant instead.
>>
>> -devm_platform_get_and_ioremap_resource@p
>> +devm_platform_ioremap_resource
>> =C2=A0(pdev, index
>> - , NULL
>> =C2=A0)
> I don't care much,


I propose to reconsider this view a bit more.



> but IMHO my variant is easier to read.


This can be.

I am trying again to point further development concerns out.


Would you occasionally like to modify only essential source code places?



> Might be subjective, though.


Yes, of course.



>>> +@r2 depends on !patch exists@
>>> +expression pdev,index;
>>> +position p;
>>> +@@
>>> +
>>> +*  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
>>
>> I doubt that the usage of the SmPL asterisk is appropriate for the oper=
ation
>> modes =E2=80=9Corg=E2=80=9D and =E2=80=9Creport=E2=80=9D.
> I have no idea about org and report modes.


Please take another look at relevant application differences.



> When I try these I get a python2 error message:


How do you think about to switch to a newer version of the interpreter for
the Python programming language?

Regards,
Markus

