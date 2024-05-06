Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163CEC10F16
	for <cocci@archiver.kernel.org>; Mon,  6 May 2024 11:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=HIApsnNkvRwZ6owDMf7ooVfGXpHGNAaIH77PltvCKqM=;
  b=gh4DoQYXbdcguGHGrpD4+1PDJQaVHjsDkmNpbAyYHXLNJ6xqx4s8LnFh
   DLGMVDpUCm+dbOLNbRpsEfFWnr0yMqfPeQj7VBxNFl25KwuaLWAn8H6vn
   ATuAMeRYy1wn7gAgYsi3jhZpS8U76KfKyEBMwZV2KE8Mi2V2u0mCob6CN
   c=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.07,258,1708383600"; 
   d="scan'208";a="164659488"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 May 2024 13:03:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5DE04E0141; Mon,  6 May 2024 13:03:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 048A0E0035
	for <cocci@sympa.inria.fr>; Mon,  6 May 2024 13:03:31 +0200 (CEST)
IronPort-SDR: 6638b902_pPdLR/vCBgc3eH42HDPV8qR0IrCb2+3VroTYi3FD4SHMKNg
 KCjQOXSqrYOcWcvfZ69sXsX3fE9IcW4XXjRcoYw==
X-IPAS-Result: =?us-ascii?q?A0GfAABOuDhmhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYJDfFczBAtICIROj0aBdS0DhDuXeYFqgSwWKA8BAwENPQQBAgQBA?=
 =?us-ascii?q?QMDAYILgmoKAoguAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBASMXBw4QJ4V0DYJnARCBDmUJOAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAg0wCkIBAQECASMdAQERJwQLCxoCE?=
 =?us-ascii?q?RUCAlYGARQBAYJ8AYIvAQMOIwcNBrJZgTKBAYIMAQEGgVhB2EAfLCJXgWIDB?=
 =?us-ascii?q?oEaLgGILQGFfIRAJw+BVUSBPAuCRzE+gmEBAQIBgRZHP4McgmmObYJcg0iBY?=
 =?us-ascii?q?oMzgisQilBUfRwDWSETAVUTFws+CRYCFgMbFAQwDwkLJgMqBjYCEgwGBgZZI?=
 =?us-ascii?q?BYJBCMDCAQDEDQDIG8RAwQaBAsHdYF8gTUEE0QDgTiJegyDMYF3KYQhCENsF?=
 =?us-ascii?q?YN0gXgOYoNcgxkdQAIBC209NQkLGwYiAR2hEoQPDll7CoE4xUA0B4I2gWCBY?=
 =?us-ascii?q?QyKIZUjBhMvhAWMfoY1DgaSaJhiII1UmxOBeySBXDMaJIM2TwMZD44gGYNhM?=
 =?us-ascii?q?4ELg1aXdkE1AgkwAgcBCgEBAwmFRgEBg1qBSAEB?=
IronPort-PHdr: A9a23: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
 4cSDKBWXho5G6FCYqyANMMPKtF7U2F8+YM=
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:uVWVAKDyXZAyAALlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:ttZPt2+9NsCo5FcFNj+Vv0MkQu19Q3GA8CnZGBCjJ1hGYeDSd3bFrQ==
X-Talos-MUID: 9a23:8pHY7QT/k0jrqiBgRXTdqRE5L54y+Z2rK1AJ1ogil/eBFRZvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,258,1708383600"; 
   d="scan'208";a="86461235"
X-MGA-submission: =?us-ascii?q?MDGvg4FaiRwBpwPh6HhZsCprOouaJf+qVOkXJS?=
 =?us-ascii?q?ecTEjo7S+C1GHJYVbayvLcaiJ5ntZSdNQvZZ81aBawE8VFQ3X/O7fDWO?=
 =?us-ascii?q?WedAne37GANWeE7pH9XQD6MWGoNjfgk+wnFOlJGefgPB/XCXwtoa5vzS?=
 =?us-ascii?q?lryNcZTls8DX8XajKKIDED8A=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 13:03:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714993409; x=1715598209; i=markus.elfring@web.de;
	bh=HIApsnNkvRwZ6owDMf7ooVfGXpHGNAaIH77PltvCKqM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GSaCV30Z4/qCX217v7pHr0vQkslflJ0G/11CyC9CSZ2GX/B2F4Wh6M0420DpU3VZ
	 jGfXknDTCSWmVscoJeVMyaTsjAJ7Krxc3rj9+iQf/+yABnZJaJIZQ8xJaaHq6l5tv
	 ppGpZMqzEJz4Z/YuVfMCB/wgVoLSi6X9Ue9ygmJj+6fDTsc+ZW4A0fAWbTCVv7x9e
	 fODFadzHj+tbeKkMLZAlzth2J1PW0zaxJws/+mNZXLPQWqeWfm0wp9Dp1PYDvnGdx
	 nCwO8j9jXkaq0VRQ+hhNyvmwNVW0l7BlN6Jyyp6TlB6FLZjI3IJQqD/y2lyk7DMM1
	 sEWbYWzgnE2eS2evXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdHE-1sKV4v0Umq-00Y4jE; Mon, 06
 May 2024 13:03:29 +0200
Message-ID: <eb581667-9255-49ef-9434-2fe66e206bca@web.de>
Date: Mon, 6 May 2024 13:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JySLelpUhlHfShW4A1SA1bI94FGWDFdxLzjdZX8dgbvvV7zkypW
 CzLo81wsQuW1VqCifR2Mv4MNkgyHGWs5Tmv3IoauGlpt16quMtJh0naz6OV5huU3NuNn4Hg
 rCoLla+hyzmMDmERK8i1Srt39PeiKlSoOPw4GlT86exm9siXJDR5rSngoyS+RI3CoXV6mY2
 0Kyokl+C9SAChFdvPMLIg==
UI-OutboundReport: notjunk:1;M01:P0:ghonSjVWIzs=;fz96XKv42zbYqNEV+N+0Y43Hl4X
 IvSkLrCy7BghlqZPear5wU1jkK5AEYksW0gUcm9SdMetIFuMbNOZttqISz0r9Up9HSFH5nhNb
 1vuAgAqzioQzLvQ1DXpHZn+O4PlgUvLrsq8Kgh2gNxsT/jnkbJ06WTa4o2d/qzH+dnYfBrzEH
 vFvs75UhvAAcmDuXSEADyMx2Rt04Dw9NLvJ/HD/99qaMFoXzJIpPue4zHxvecYrZZgewYxPce
 77SdYtdofOS9HMKekeLYrk0XsP5IzmBg9KHPxuK3zy1miy3+dIHt+qTy66rDQ+D50DKVjUClr
 iWGWP5BnByjrtoR6dcql/H55h7sOwM1f/rQuHzRawzzGl6xG8o5Tda3BB2fjRAKkOuFkwDwSr
 xNQUb58QRxohW0LPBtKiS3uvQZ+ZFSiQKx2erDl4WZ3v0qYrOLU//yyPhgXTHFq1Yk7BSebIR
 KeFIPFLu+flumTGJzh1qVH21naUXYFlI8RxD2GqT2l+Su3EoikB3cCaPBPhT23upp2izVgc/9
 i/oMMge0zrtuttWXnu4/BcmTBiTX3+7JCMDe3HkUE4ug7Jk9nZZlit62WsDGK2R2jqZpfr0Gx
 iUZewfET73B20AO7jRIdFJkt7cgr0gkot74DX6rIrI0SkJIFV5CjSLjWxP8rVbsK1cYAcL5Aj
 Xks/pg7T3RQ1IXwPPva/gqzrbUVBmt75I2AsfJOT7qgU9LoroSSK6Z618stDqOAfICyfVCoDS
 iZOj6+aU2sqi3NCVozyGxFKfl6Y2XNrVda+5c/NaoJP9nazCe3RVtaukVZAQOeZC95D+JNITR
 KzAbSNds9On/cXF90ZqxIxaPMsdx73Z7enAEaMbDLSdx0=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1703
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/eb581667-9255-49ef-9434-2fe66e206bca%40web.de>

>> Source code parts can occasionally be repeated.
>>
>> * Loops
>>   The control flow can contain ordinary loops.
>>
>> * Recursion
>>   A function may be called by itself.
>>
>>
>> Such constructs trigger special consequences also for further data proc=
essing
>> with higher level technologies.
>>
>> + Computation tree logic
>>
>> + Linear temporal logic
>>
>>
>> I am still looking for clarifications so that the Coccinelle software
>> can be applied in safer ways.
>>
>>
>> Regular expressions support some search operators for quantification.
>> A notation is accordingly supported for the specification of a minimum =
number
>> of matches which would be bigger than one item.
>>
>> I imagine that such functionality would be helpful also for the semanti=
c patch language.
>> How will the chances evolve to extend corresponding quantifiers anyhow?
>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/23f7738a7881b02d01=
6d278ee293cfd4a126fcab/docs/manual/cocci_syntax.tex#L793
>> https://github.com/coccinelle/coccinelle/blob/755250323b80f27701e78d325=
cc83509197b33b1/docs/manual/cocci_syntax.tex#L793
>>
>> I would appreciate if multiple occurrences of code elements can be bett=
er detected
>> and transformed.
>
> I have no intention of adding regular expressions.

Please take another look at provided information from my clarification app=
roach
so that undesirable misunderstandings can be better avoided.

* Regular expressions are supported already by the Coccinelle software.

  + They can be applied for advanced SmPL constraints.

  + Embedded scripts for programming languages like =E2=80=9COCaml=E2=80=
=9D and =E2=80=9CPython=E2=80=9D
    occasionally benefit from this technique.


> Be more concrete about what you are not able to do.

The semantic patch language supports a few =E2=80=9CDot variants=E2=80=9D =
so far.
I am looking for further possibilities according to item quantification.
How should a search be performed for source code which would occur twice a=
t least
(without taking repetition because of loops and recursion into account)?

How would a notation =E2=80=9C{2,}=E2=80=9D look like in SmPL?
https://en.wikipedia.org/wiki/Regular_expression#Basic_concepts

Regards,
Markus
