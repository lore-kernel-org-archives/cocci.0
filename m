Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76212C433EF
	for <cocci@archiver.kernel.org>; Thu, 30 Jun 2022 02:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=h+OsJrtOr2uLM3hsTPAX+Fh0Y6Qo0ymGHbB2pgNf1ZY=;
  b=eh4HGXj2obazMhK9sAuXmoJwEgdoq/Bo0si8FVi9FXUzu7Bu7JL9aR4g
   wIo2bR0fOHelrNIkWyeL6tngCws5ZWHcKwJsGcbdLu8EoPj9ZHdo4Px6x
   tFY1EMvH+L6dRQgqEBBj63yOmnWpQL9hDbKamyxCWUs/V7r22U6nFL+mP
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.92,232,1650924000"; 
   d="scan'208";a="43509472"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jun 2022 04:24:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 48D23E015F; Thu, 30 Jun 2022 04:24:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D4F68E0092
	for <cocci@sympa.inria.fr>; Thu, 30 Jun 2022 04:22:32 +0200 (CEST)
IronPort-SDR: ve2rFItikRCXZvSziQTxKq4i9pk5l54+TA2CINoBqrVh9k0E4iO+9eMkSItM8vEwmd4Jj9hb+f
 x/vZedd1bD0CK7oI5OJNWkYHNJu7rH4Uz/q8jmkE86Tiuzpj4EtheVaoQSd42q1Po4dfYkzQtS
 nJxtCZqhFcsUsvQ4/Rlx5HyxgGFZ0Ux2DhqGlnvz/C1z8nGAXSLjG4dROJJKQG/PqXQuxSsZYW
 YqseUUinfJERNpQTcVOdhkZyYD5uNyK6l3S85rqdAWBWFpEpyKCgOqjbyH4KVWczeSdHrXJLuL
 +nPyIGbKin1/BK6NFCevKBHB
X-IPAS-Result: =?us-ascii?q?A0DnAgDsB71ih7vU+S1agQmDc4EBVS8EC1uEN5BeLgOEI?=
 =?us-ascii?q?5pMCwEDAQwBMhAEAQGCEIJ0AoVKAh0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBAQEBCw0JBQgKBw4QBTxkaIFPgXQLNA2CNSkBg2QBA?=
 =?us-ascii?q?gIBIw8BRgULCxoCJgICRxAGAQwBBwEBgnkBgnUjAw+sUIExgQGEboULBoERL?=
 =?us-ascii?q?IdLhywngimBFScMgnc+gQ+HC4JlBJFriAgcJgQPAxotLxKBIG4BCAYDAwcKB?=
 =?us-ascii?q?TAGAgwYFAQCExJNBhwCEgUHCgYVDhQcEhIXDA8DEgMRAQcCCRIIFSsIAwIDC?=
 =?us-ascii?q?AMCAyALAgMWCQcKAx0IChwSEBQCBBEeCwgDGR4sCQIEDgNACAsKAxEEAxMYC?=
 =?us-ascii?q?RYIEAQGAwgvDScLAwUPDQEGAwYCBQUBAyADFAMFJAcDIQ8mDQ0EGwcdAwMFJ?=
 =?us-ascii?q?QMCAhsHAgIDAgYVBgICGFYuDQgECAQYHyQPBQIHLwUELwIeBAUGEQgCFgIGB?=
 =?us-ascii?q?AUCBAQWAhAIAggnFwcTGBsZAQVZEAkhFgYKHwoGBQYWAyFIJgUKOw8oNDY8L?=
 =?us-ascii?q?B8bCoEaLAkiFgMEBAMCBhoDAyICEikGNwMWBisGIxsCnBILgSkSBoEMD4EWN?=
 =?us-ascii?q?5IwgwZGjF6eQAcDg06LIZRgBg8ELZZqkXotlVB1II0Ri1aOEgIEAgQFAhaBe?=
 =?us-ascii?q?IF+cC8hgmlNAQIBAg0BAgICAQECAQIJAQECjikNCRWIT4VXN2wCBgEKAQEDC?=
 =?us-ascii?q?Yw/LYEHgRIBAQ?=
IronPort-PHdr: A9a23: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
 fo=
IronPort-Data: A9a23:0j3Dza8iVdafG3VRKJPyDrUDpXiTJUtcMsCJ2f8bNWPcYEJGY0x3y
 WIYX2/QMvbYM2TwKI1zbY6y8kkEup7VnIVmGwZp/ClEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvymYAL9EngZqTVMEU/Nsjo+3b9j6mJUqYLhWVnV5
 4mj+5e31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Zy
 OoTqICveBYSY+6VwdkiXjpIOHFiFPgTkFPHCSDXXc271F/WfHK0mrBvCgc2IIQH9+cxCmZLn
 RAaAGxQKErf1qTsmej9E7kz7iggBJGD0Ic3pXBkyTDQCLA2XJnFUaTb7NlX9Dctj99DHLDVY
 M9xhT9HME+dO0wUagd/5JQWwdWNr0jycx1ipEuunKQ6yln5zQJU3+24WDbSUobXGZkLxxfwS
 nj912DwHRgeMPSNyD+P6Hvqh+nVnCq9Vph6PLa//fVrqEaCw3QaThwQT1qy5/ej4nNSQPpEO
 Vwb83J36Kk0sky2R8bwXluzp3vsUgMgt8R4E9Jk9R2S+7vvvkXAX1U7Qx1RQ4w6nZpjLdA17
 WOhk9TsDD1plbSaT3OB67uZxQ+P1TgpwXwqPnNbElBfizX3iNhq1U2VFI4L/Lud14WtQVnNL
 ya2QD8WrJN7sCLm/76p7V/O22vpp56PThM8+QjWGGmi62uVhbJJhaT3szA3Dt4adu51q2VtW
 lBYxaByC8hSU/mweNSlGrllIV1Qz6/t3MfgqVBuBYI90D+m5mSue4tdiBkneho3b5xbJWO1P
 x+J0e+02HO1FCbxBUOQS9/qY/nGMIC6TYi1PhwqRoMVCnSOSON31HszORLOhjGFfLkEkbw2J
 pqaOdqhBnYcDqBgwzu7XK8W1vlD+8zN7T67eHwP9Dz+ieD2TCfNF98taQLSBshksv/siFiLo
 r53aprSoz0CAbaWSnSGoeY7cwtQRVBlXs+eliCiXrXeSuaQMDp9UKC5LHJIU9ANopm5Yc+Tp
 SvgAhQCmQSl7ZAFQC3TAk1ehHrUdc4XhRoG0eYEZD5EAlAvPtSi6rkxbZwyceV1/eBv16csH
 fkYctqNA7JETTGeo2YRapz0rYpDchW3hFPSYHf0P2hjI5MwFRbU/tLEfxf08HVcBCSAs8Zj8
 aar0RnWQMZeSgk7VJTWZfujwkmfp38YnO4uDULELsMKIBfs7YF1Ji23hfgyepleJRLGzzqc9
 gCXHRZJ+baQ8tBlrIXE3PnWoZ2oHu1yGlthM1PatbvmZzPH+meDwJNbVLradz7qUm6pqr6pY
 v9Yzq2hPfAKwARKvo57H+o5xK4y/YG29aRI3gttRCyOblLtCq5pPXSHm8JIs/QVlLNevAK3X
 GOJ+8VbaOnWZZK6QAJNKVp3dPmH2NEVhiLWsaY/LnL86XIl57GAS0hTY0SBhXAPNrdzK495k
 +4ttNRMsl6kmAolO47fyyFSsWSRJ2MNUuMssZRDWN3njQ8iy1djZ53AC36qv8zeNIUQbkR6c
 CWJgKfihqhHwhaQeXQEE3WQj/FWgo4DuUwXwVIPT7hTdgEpWhPqMNxtHTULosB91QdX3OsrY
 y1qMQt1OKyR8jYuj89GN4xp98etGzXBknEdCXNQ/IEac6VsfmzQJXIwOKCG+0VxH6d0YG1A5
 L/BoIr6eW+CQSwytxfenWZltvX8QN03/QrH8Cxi8wJpALFiCQfYbmSSiabkZvcp7Q7dRKEKm
 AWywNtNVA==
IronPort-HdrOrdr: A9a23:bqI71qv7adR+wMKHpFRSRYb37skDXNV00zEX/kB9WHVpmszxra
 +TdYcgpGbJYVEqKRcdcLG7Sc69qBznhP1ICOUqXItKGTOW3FdAT7sSiLcKoQeBJ8SWzIc0vs
 1dmupFZuEYZmIWsS+V2mWF+pobsbu6GHzBv5al8587JjsaEJ2IuD0JcjqmLg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,232,1650924000"; 
   d="scan'208";a="43509388"
X-MGA-submission: =?us-ascii?q?MDHCjlGKHjPm4Unikg3x2Uyh0wXeY3cbM1Nk8D?=
 =?us-ascii?q?DEdyxClDXB2Jodh2x8mbAqmqOLpAPu3aAKcUkFvsKYhK8LtRdZbSi5tP?=
 =?us-ascii?q?YPZsyZk/K+vbsu7pbt6Nc5H1bBFpCoqb7rFbj7C3WtVClquYXiF6PldB?=
 =?us-ascii?q?qmb+XWclPNfoIVGRWEvVjJhQ=3D=3D?=
Received: from szxga01-in.huawei.com ([45.249.212.187])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 04:22:30 +0200
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LYMVb0wMhzhYws;
	Thu, 30 Jun 2022 10:20:07 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 10:22:24 +0800
To: Markus Elfring <Markus.Elfring@web.de>, <cocci@inria.fr>,
	<kernel-janitors@vger.kernel.org>
CC: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>, Fabian Frederick <fabf@skynet.be>, Yajun Deng
	<yajun.deng@linux.dev>, "David S. Miller" <davem@davemloft.net>, Phil
 Edworthy <phil.edworthy@renesas.com>
References: <20220616013253.520310-1-william.xuanziyang@huawei.com>
 <32da2d32-9554-de90-62ca-c4be456ad31a@web.de>
 <6b3eac2c-6e24-46e0-c548-dc87f666709b@huawei.com>
 <0e3d2713-ab8a-2ce5-5423-a72ba36ac1ff@web.de>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <224eeed0-5429-6dc3-7fe7-e4ff820ccb27@huawei.com>
Date: Thu, 30 Jun 2022 10:22:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0e3d2713-ab8a-2ce5-5423-a72ba36ac1ff@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] scripts/coccinelle/free: add NULL test before dev_{put,
 hold} functions
Reply-To: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 469
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/224eeed0-5429-6dc3-7fe7-e4ff820ccb27%40huawei.com>

>>> I find the patch subject improvable.
>>> You would like to detect the remaining usage of redundant null pointer checks
>>> before selected function calls.
>>> Thus it would be nice if the corresponding description can become clearer
>>> another bit, wouldn't it?
>> Sorry, I did not get your mean.
>
> How do you think about a wording like the following?
>
> Commit subject:
> [PATCH] coccinelle: Add detection for redundant null pointer checks before dev_{put,hold} function calls
>
> Commit description:
> The information “Add the case if dev is NULL in dev_{put, hold},
> so the caller doesn't need to care whether dev is NULL or not.”
> was provided by the commit b37a466837393af72fe8bcb8f1436410f3f173f3
> ("netdevice: add the case if dev is NULL").
> Thus extend source code analyses and corresponding transformations
> by the means of the semantic patch language so that null pointer checks
> which became unnecessary at other places because of the mentioned input
> parameter validation.

Patch title looks like better. And I think the main destination of the description is

to tell others what you want to do. If it can, I think it's OK. After all, everyone's style

is different. But I will refer to your suggestions. Thank you!

>
>>> Did you order the case distinctions in the SmPL disjunction according to
>>> the call frequencies of the mentioned function names?
>> No, no any special, just list the related functions.
> Will this view influence the selection which SmPL code variant
> will be preferred finally?
>
>
> Do you get further software development ideas from a data processing approach
> which I published before?
> https://build.opensuse.org/package/show/home:elfring:semantic_patching:Deletion_of_checks_before_specific_function_calls/Deletion_of_checks_before_specific_function_calls_in_Linux_source_files

Sorry, I didn't learn about these. I learn about coccinelle recently by coccinelle scripts in Linux

kernel and coccinelle official website. Now I get more resources. Thank you!


I will give the v2 patch with your suggestions. Thank you!

> Regards,
> Markus
> .
