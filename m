Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A663DC3DA49
	for <cocci@archiver.kernel.org>; Fri, 26 Jul 2024 13:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cioIVg3tujlt00q2GAvahFP+evhh70BOwtUfs8Y2PSU=;
  b=dCkpvstP4hOZsrJW4YrJYREoF64cQuWrELb9pxVDN5d6uEFypaVSi03B
   bl4e8QYs8ltVOsPP9+TbTGOSEWUvaTnYS/UsDcHYNf8+DCvZQVX/0HHe7
   7XY7HuR5SmZJvojIdFc9DQoDHkIJNP6K9YC4CziY+NzvmUmn5mXt8UMzM
   U=;
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
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="177108015"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jul 2024 15:25:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E0D02E0141; Fri, 26 Jul 2024 15:25:23 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 86A79E0035
	for <cocci@sympa.inria.fr>; Fri, 26 Jul 2024 15:25:19 +0200 (CEST)
IronPort-SDR: 66a3a3bf_fEaK9ePebtB1t5FdmJ7DcArGDRoKqO7Y8gSBZfk7l2a1S8c
 XTJS7ufE6gSznPnItz2h9DunoYz3iKn/hWdYxSw==
X-IPAS-Result: =?us-ascii?q?A0FTAABtoqNmhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDYhoGVDMEC0iEVogdhy6GYI8LiHWBVoFAPg8BAwENOQgBAgQBA?=
 =?us-ascii?q?QMEgUyDKQEJAok6Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBAToHDjuFdQ2CZwEQgRKBJgEBAQEBAQEBAQEBAQEBAQEBARcCD?=
 =?us-ascii?q?TpEAgEDIx0BAREmAQ8LGgImAgJWBgEUAQGCfAGCLwEDMQcNrR2BMoEBggwBA?=
 =?us-ascii?q?QbaWR8sIleBYwMGgRouAYg8AYYMg016Jw+BVUSBPAuCRzE+gQUBgVsEAYFdg?=
 =?us-ascii?q?1uCaYgdhC6EcmkEBRWLfCaNTlR7HANZIRMBVRMXCwkCBRCJYAqDJSmBSSaEG?=
 =?us-ascii?q?wiBLRWDZIFrDGGHdmKBD4E+gV8BSYJ3S4NoggFsHUACAQttPTUJCxsGPaImh?=
 =?us-ascii?q?HI/gk4axTk0B4I2gWKBYwyKJZUqBhMvg3IBEo0AhjcOBpJumG0ijVibF4FnO?=
 =?us-ascii?q?oFcMxokgzZPAxkPjiEXAoNhM8wLQTU7AgcLAQEDCYVGAQGDWoFKAQE?=
IronPort-PHdr: A9a23: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
 sNmol5zUVsoCrUFB04jENFQeP9K
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:K62Of6oFqSy90PSUKJy9jgkaV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: 9a23:9lN64m1yrMrI/HQ16+nbYLxfIfI5UlbcwSfqCmC8IjdRc7aOcF6L9/Yx
X-Talos-MUID: 9a23:HbSSIQockECw+8skJR8ezxp9asl55aP/NBg2q60ghs6aayhrNDjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="177108011"
X-MGA-submission: =?us-ascii?q?MDEki6UwlrzuWwGe35WTNVyj75KaARhS2bkE/B?=
 =?us-ascii?q?rDdLlTJwexauxv8BlVD639dvSQoEoMkhj2ZaR+OA9vKiVD95KqkoDJyJ?=
 =?us-ascii?q?HUBMuY3g48NmFYqI/kb1dcVMRpLGmVledaybELPLYV3fM8c5nEoCYzTf?=
 =?us-ascii?q?2SNZ8oYxhV1UKcdyOoLPv6Yw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 15:25:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722000311; x=1722605111; i=markus.elfring@web.de;
	bh=cioIVg3tujlt00q2GAvahFP+evhh70BOwtUfs8Y2PSU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Uoh4XHn8zTgbfQ9BxnvaM4wHl1PXZI4kHarQpMgBUvO+VclPQ5FWR4njYoDffMDC
	 9ui+EEZS5zjhPCR0ZfREXJcLX3U/efZrokasiQtMBCu8eLG+IHCFoEytn/F1xftoJ
	 rX07X/UQXxmZPOfEGAKdFSzAg9j3tcTxEWpjdJvmBqrl+l3lVQrMiOSwMveeCOn9p
	 onVaSjwYZ7/fmnAQ3q1y8jO8aECmRtPXAiXQs9XlujYKTR2OUfs2HrBRrWWhuwSNB
	 ZgYz2Nr2BVmw/uHa/zkI/bfjmes+Ib2xdcxXgOas7Qx+sYUvbRjdWe435OUq9pCI9
	 Fg+U0NslmEUAivz7+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4N9I-1s7O3l1mg2-011ma5; Fri, 26
 Jul 2024 15:25:11 +0200
Message-ID: <d3f11294-5751-442e-b7d4-616c3bd217b9@web.de>
Date: Fri, 26 Jul 2024 15:25:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Chen Ni <nichen@iscas.ac.cn>
References: <959b8771-76a1-4cee-a7b1-2b391deb23cc@web.de>
 <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zL8gi/bZXiOtbAwVObowDtZMvjh1mz7OiFCiaqP7/V2pCFlZ/pM
 zUXcrq5no1qauFVa4QvKOEeX6sBFosS2+J6EbEKPgExVeuKcVN1wTXJraoqlk0zULwvx4vU
 b6ndkG0eM1uvqxLCBjcMexdx+NneY2Uq0LxBRzimrlq1pvzKCHLCAx6bXYD7yhBzdMq0BCa
 Pwmn+fLCxC+UBlu9Wxw/g==
UI-OutboundReport: notjunk:1;M01:P0:sc/NZhSZ/Hk=;/ACPqbNn9NLm2qkbs/RXqw1k7pI
 2lZN9iB/dKUYqlIs3s6bR3L+c3T7eO+UgTrXXgkO3qf1MJ2CKU/ouxxQzZCuHmmNm9G1o/L9/
 hnQrmnTlfk/jNlexUYk4dW/zr7EBYdqJ2qERXC/vrd1JYhiNIfvtpXC80BWHWJVFpd2Wn9+cD
 r6ukHChlnT5KWuWIJS1SfsRiNJA2qZhK9cMndd1WnpMyfdBxXxzNSZewhhIoXbIVsys1Sk+d7
 /zH40rYG2Dbt8pbmkKVE0mSZo+XlD9kRwGNCEMYDjS3Z41c85izHfOMUuEE2+zTYzOURdAs8z
 Zio+NjbE6ooXaFARQT2jl2ta490m6KAs6EHfB/tj3fJwpEHKelTHL4o01fxKBacnsGxOs+vbh
 gEAif9VoSY7j66Rz5yEZye8+nT7LRUGFlJ1TvuL72fGVKqc7pD94Nm1gCgjn2dwz1virDmdfn
 JOk1ZzUADHANa5FHfP2PngqW1WCW7qQDt+O2OPkA99P6/gy/ZXHz+nEhexPfFBw6og8vJMgRh
 LAuLeVIuRwDpDwJ9g0xpzt3TrJXtZpN/wM86wHoidcRNc+OgaHA4anExr0gstr3L4pomta1Vy
 PtSzfeJG+DfFez6qIGPlazycUwtLdktnxdbgy0NC8ryLeIGDdDmGMaF1A1T8ZCjcPFlDaWLqd
 jQZkwfKUDLs0dBRL0TbjN9NS8fWeyb0ACaxJlQcM9Fz5oGkzaqr48u4QgR053MpHfUwuxNU6Y
 yFywWr0NtTdbuzOEqvBmxvjLUptUiNLFJkmLmkwPcxNNFP1EpJ5HPfaSApIN/gG2Dh0Ra+3TP
 yoKebuwDJRSuoIvRJioNH8Dw==
Subject: Re: [cocci] How to fix a parse error for another SmPL script?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1816
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/d3f11294-5751-442e-b7d4-616c3bd217b9%40web.de>

>> @adjustment@
>> assignment operator ao;
>> expression e, ex, te, tex;
>> @@
>>  <+...
>>  te ao e
>> -,
>> +;
>>  ...+>
>>  tex ao ex;
>
> The above semantic patch does not parse because te ao e, is not a valid =
C
> term.  There is no term in the C language that ends with a comma.

Please reconsider such a view once more.
https://en.cppreference.com/w/c/language/operator_other#Comma_operator

Regards,
Markus
