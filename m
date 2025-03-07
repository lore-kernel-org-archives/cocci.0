Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15533C19F32
	for <cocci@archiver.kernel.org>; Fri,  7 Mar 2025 10:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7b0luNExfCB61FsTyWvp182ROiiOzWhnedbdoXJjttc=;
  b=GEx6K1lXeqYXq2kCabXsnIIphrMJsNBS45n864llf6hh1go2blmrTuqS
   jSrJhXTdF9wdeouzV84X+aE8EJDB1KMJNiMbWELpggdTti2AsNzaU6YML
   X/WnuW1QVwtncIfHG4vvANL8lCK6bIYKPab7Xcrr5KkN3ttEGiHeDFHx9
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.14,229,1736809200"; 
   d="scan'208";a="211748794"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2025 11:47:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 09CDEE0261; Fri,  7 Mar 2025 11:47:14 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BEF51E0261
	for <cocci@sympa.inria.fr>; Fri,  7 Mar 2025 11:47:12 +0100 (CET)
IronPort-SDR: 67caceaf_2XRsAeVipiuYZS8IsKagFt982tzyi8JKAG16ydRQKq222ma
 IdxywUfVn/Lt6Pf2jlOfSJxs3vYmEEfYS9Ut70Q==
X-IPAS-Result: =?us-ascii?q?A0GtGQBezcpnfgQP49RaHgEBCxIMQIFIC4JEfVozBAtIh?=
 =?us-ascii?q?FaPT4F0LQOEO5gDg1QPAQMBDTkIAQIEAQEDBIQ6RgKLGAIeBwEEMwYOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgkBMYV7DYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEBAQEBAQEXAg06RAEBAQIBIx0BAREmAQQLCxoCJgICV?=
 =?us-ascii?q?gYBFAEBgn4Bgi8BAw4jBw2wE4EygQGCDAEBBtpcHywiV4FlAwaBGi6FbIJjA?=
 =?us-ascii?q?YVbEDsJhDMnD4FVRIE8gwM+gmEChTuCaYIzhEBnhk2HAYw3jwZSexwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSlDAyo0MSMPgRQFNAo3OoILaUk6Ag0CNYIeJFiCK2oEBYEkgjeEP?=
 =?us-ascii?q?YRBhVKCEYFdAwMWDwGDH3ccg092PIRpNx1AAgELbT03CQsbBj2iCTuEIh9aN?=
 =?us-ascii?q?SwiXoExDMYgNAeCOIFmgWMMiimVNQYTL5dGDgaSfZh+Io1jlnGEPTWBSCSBX?=
 =?us-ascii?q?DMaJIM2TwMZD44hDBaDWDPHHUI1PAIHAQoBAQMJAYFVg3ABAYpUgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:Gr2Qcq2q9OQ7pD0ZtWESRAqjBGYkLtp133Aq2lEZdPWaSL3+qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SODUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:DNYjg2OVIxMFVu5DYjNprXY5N8QffFrP8TDIPAiSIDtuV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3A7Nny/Q7mEyih6rYYkvPD4KiRxoxt/pufUB8cj68?=
 =?us-ascii?q?05eW8bhNsBDq+0yyeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,229,1736809200"; 
   d="scan'208";a="110953835"
X-MGA-submission: =?us-ascii?q?MDFmFRlkFGo+YdhNL8Tla3bfoZKhr9UrgtuuqD?=
 =?us-ascii?q?dQbb804xjkuKjSbpjFjyQ2eq/owfBsi460gYMVJUdEwrcrEeaXmtgGug?=
 =?us-ascii?q?Y64tBNdc1mMsEXRXa2CW4BFJc5rfglzP+ISvYPLxUCx7zOdXWDOTElG0?=
 =?us-ascii?q?mNRiADKhJULND8y47cZSw3HA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 11:47:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741344430; x=1741949230; i=markus.elfring@web.de;
	bh=7b0luNExfCB61FsTyWvp182ROiiOzWhnedbdoXJjttc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k24dJYN6RZ+hLkRioAb8xIvWkIO2gZtvjwW8Y9HiImVOzlWxe8FW/AIlH7Vv2LFL
	 E5Hp8C2HTdeLP4vsvRhNjT+gBUlquoqqoxw350TOQPbeQ5cxPgTTuLqPlU+th8XNW
	 dlYacfBxMCoBztRnMhy2eMWOuNXZwWTZy8NsTkQvOXBqwKVxLt8g8tmaijj/S23VH
	 svFE4H+zAA1KXaWYY3JmoiazQM9FL4avg4J3EnXbY2tBowSKZ8imZvNRKtTS3tY1y
	 y/h6qrMH3WDVtoqZR+3JD4l0xCI+A0Ifu/stKpbrm2KzsuSgoCBlRcBCEj8l7KuM5
	 BQoO4re7vGugI3J0VQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.70]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKMA7-1tXRk936YJ-00PQUP; Fri, 07
 Mar 2025 11:47:10 +0100
Message-ID: <c3991582-ecb1-4b7a-b2d9-057a6be1d7fd@web.de>
Date: Fri, 7 Mar 2025 11:47:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jacob Keller <jacob.e.keller@intel.com>, cocci@inria.fr
References: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pUABQKv8Ch+h0xrnYti0lraW3DbKYZn5RHYSok2Lh6X+NM1BozO
 ZWp0bgNdfUd6bH6NcIxXt3TjdmLM22wX0ESQchL/JIQ792x3i+ZpbLe9FXp106k6OtLvzqT
 rOR7UwEeOhsUSVd1DruEfgszdKKM6NPAMfhZUQCRq+vVg8g1rPH/skxS3PMhRNMY7an16DS
 xWw5e9VBAZm+LtzQg9jMw==
UI-OutboundReport: notjunk:1;M01:P0:pnepqrzl91c=;APLC3OCllGfCi74g6dkuKUMotJV
 3GhHO4Vf55As+FD3iwyeZXWhpDdrCnxzXKaH3f5PrdKgQN28gwpNyJiCl561ryJknADU8KzRo
 I1vJ4ivOIexJrOR+sk4Gl0dZGJ9SoatfbKnSHxvSxeYGUMZc7vsssqcKOHDvLgSl+n/Mu0cxF
 qPCpZ4qjp39ehCl3lDr2z1UAsFpf5qAIYfO/YO6YGNgqhkcwgOc5kpvCKg7lbmDBuyVYUToRo
 ZKK91FWvGvdGR1lY1Vc/HdjQoHE4SGYdF1HVxKqw3TIB0VifBYquGzuomYQE47Oj9fjZ/nTqF
 oOy20kW+b7rFF9/DamREuAkxUV+1NcNx7xHsqW0210Wzgfy6d9SwRj+u78+uVLQTms4oYJZKw
 rDDziGOFYc3zTDZ5eQ/PssyOQh+AEEUvCzLwZfOvhnvEN39i9UK8Orl8BZHP74P9YmQmpnX1n
 glWEk68jwAxngSJt/Y/3/oNyrST3NEaZcHitp5K4X4Dv/Wa07M86Of+cEu6wPPBHqnzfUXukb
 oS0OLTh/Nrb+sZKYDKlkmmYBlGfo1Ow6mYL0udVo5aNWbpE9hyfjIDdstY18LHSneAPAm4JUQ
 gRUrHW5Vsl1qKgtOVixPdB5+OBhVRFxqGv4L4L5r3ydg57Tv6ng92WAqMM4wWaKP62cuj1P28
 zws3osuckPGrHw63GSH38qEwhCt+lf8tHREHM6p2o12o04p6AUi1Ro3GEowOIoKJSMlDHclaz
 Uurf485dMgePmgXwlj3cshs70g4SQzKsLPKtWFdPfLFY+E2hKBO3eNnR20Ifnb/GNdNFz3yU7
 4aqcrlppuiw8lPA/IOQKxa3pALn4zno0uS/XQftD4bCNkd42IisrGFnztbyVHVfIkV99HDZnJ
 VvlYJT7b8DQdo6/4z6Sgvdbm22fvbZ5Sia7jSZImXQ99WtWh6myJ/5OWR9/nERA0eJ8e4NDT2
 vBAcZAQNyfaWpWmRVy98IaePA9J1F1L2NNtuEBtVyHQ/FofLYbbWuUbe8qsac5QDAgJtVBFwo
 SIr6FJZDp9WtAMCix6LXE697VdOXoCGJe7k2sxtgv2BMe6yyULzrDHXoRwva5q3FYMs5+FwlS
 utsBZ0Osy78X2FwaJKHt31eCEvn5WCShEk3myhgapnOhzg3pxzrolGpR/tEvXBToF/BnnjZEV
 uLsh2HU3TAdAgVDRCg9K1S8dmNpyI2YBH0hfN5bHMpYKh3/QNR2u60dHJSWKNPgWJamdKOdNN
 xttEV7ZPxNpo9sJRitsf85dL52EKpcIlQxtd+Qk89i93XBAQNQkp9yr5Mj50W4mqXPVLOaoWN
 WXNmr3OaJb5w2o1hqjIEjO5XHwt37SoEk3ffyBjk+MEKOXXpbyu+lF5CF2sKWYS1KkUdcE2sG
 Iuxs+4nCFeWtlOG0ZFz8HCIfgFlUi9YCLubzhfDo6GGsmiWEfookDiQd6YgRf0Cno3kdm1wxN
 MiZoHDXhWvNND9q8hQj777IFT68uapNs7rKZFqAS8OiKu0qoQZnbl1rU33atUtsoHCVsX5g==
Subject: Re: [cocci] behavior change in semantic patches since c36b51ffc889
 =?UTF-8?Q?=E2=80=A6?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2572
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/c3991582-ecb1-4b7a-b2d9-057a6be1d7fd%40web.de>

> I also noticed a behavior change in another patch:
>
>> @@
>> expression hw, ptr;
>> @@
>> (
>> - ice_free(hw, ptr);
>> + devm_kfree(ice_hw_to_dev(hw),ptr);
>> )
>
> This patch updates some code that used an internal wrapper function to
> use the appropriate kernel function directly.

Would you like to experiment with another transformation approach?


@replacement@
expression hw;
@@
-ice_free
+devm_kfree
 (
+ ice_hw_to_dev(
  hw
+ )
  , ...
 );


> When the function is inside a block like this, it is transformed to
> include braces. This often violates our style guide as braces around
> single line if or other scopes are not desired.

I became also curious how the support can be improved for source code
analyses and transformations according to compound statements.


> I ran a git bisect to determine when these changes broke, and both
> changes appear to occur due to the following change:

Would you like to share any commands and related background information?


> I was using spatch --parse-cocci and saw some warnings about the patch
> file, and refactored it to:
>
> @disable drop_cast@
> void * void_ptr;
> type T;
> T * typed_ptr;
> @@
>  typed_ptr =3D
> -(T *)
>  void_ptr

I find it interesting that you tried also an SmPL script variant out
with a better change precision.


> This fixed so that the patch does find all the typecasts, but has often
> left us with undesirable white spacing, =E2=80=A6

Will development interests grow for topics like the following?

* Advanced data processing for whitespace characters
  2016-01-12
  https://github.com/coccinelle/coccinelle/issues/58

* Fix indentation algorithm for Linux coding style
  2016-08-29
  https://github.com/coccinelle/coccinelle/issues/75

* Fix usage of white-space characters at two places for Linux coding style
  2016-08-29
  https://github.com/coccinelle/coccinelle/issues/76

* Preserve selected whitespace characters (for Linux coding style)
  2025-02-28
  https://github.com/coccinelle/coccinelle/issues/392


Regards,
Markus
