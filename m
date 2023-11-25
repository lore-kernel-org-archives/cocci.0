Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5757DC624B4
	for <cocci@archiver.kernel.org>; Sat, 25 Nov 2023 09:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=O/dWBbetSLV5gsZaD6vq0VPnj2yZbAYK3fy/koUtwpo=;
  b=HzwuGJ9fgOE9S/Xinv+TcKGKo35Ejs2reyZMW+lMbvg4uwb3GgmlyLpk
   ti2TptTTOflpr3xvN8RT/qkRg4NlYl7+YfKTiM99jeLIBGjnNAvluc+ND
   BmI+Ocn6u0b7HYqjq6FuYkmo/pKAA0LBxfS38gSTc9jsDORFXT7Wm5iic
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,226,1695679200"; 
   d="scan'208";a="138452549"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2023 10:10:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1558FE0CCE; Sat, 25 Nov 2023 10:10:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 87A39E004E
	for <cocci@sympa.inria.fr>; Sat, 25 Nov 2023 10:10:32 +0100 (CET)
IronPort-SDR: 6561ba08_fYFsx/Xw4C+b24iWpXMRzdxx4g67dOVABNMTQ9qyIpxLn4l
 y7axjKKA1Z0vIohfnEvuAT9Wj7LTCqAmmbN59oQ==
X-IPAS-Result: =?us-ascii?q?A0H6AgCruGFl/wQP49RaHgEBCxIMQIFEC4IRKAdzVjAEC?=
 =?us-ascii?q?0iEU5EyLQOEO5dtgVaBQD4PAQMBDT0EAQIEAQEDAwGCC4JrCQKHKQIeBwEEM?=
 =?us-ascii?q?AkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAoEGE4VoDYJcARCBD?=
 =?us-ascii?q?IEeAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR?=
 =?us-ascii?q?0IBBAEjHQEBEScPCxoCJgICVwYBFAEBgnwBgikBAw4jBw0GrlOBMoEBggkBA?=
 =?us-ascii?q?QaBV0GtPR8sIlaBXwMGgRouiA0BhVmENScPgVVEgTyCUjE+gmEBA4Feg1uCa?=
 =?us-ascii?q?IkkB4JUg1KEbAmKA10iBUJwGwMHA38PKwcEMBsHBgkUGBUjBlEEKCEJExI+B?=
 =?us-ascii?q?IFggVEKgQI/Dw4RgkArNjYZSIJbFQw0SnYQKgQUF4ERBGobEx43ERIFEg0DC?=
 =?us-ascii?q?HQdAhEjPAMFAwQzChINCyEFVgNFBkkLAwIaBQMDBIEzBQ0eAhAaBgwnAwMST?=
 =?us-ascii?q?QIQFAM7AwMGAwsxAzBVRAxPA24fNgk8CwQMHwIbHg0nJQIyQgMRBRICFgMkF?=
 =?us-ascii?q?gQ4EQkLKwMvBjgCEwwGBgkeBA4DGSsdQAIBC209NQkLGwY+AiefX4NfRCRZL?=
 =?us-ascii?q?0xSBBcEMxIMxGk0B4IxgV+BYAyKFpUNBhMvlyIOBpJPHpgiII1Hmm2BYz2BW?=
 =?us-ascii?q?TMaJIM2TwMZD44ggSwBAoJ8gQuOPEA1AgkwAgcBCgEBAwmFRgEBg1qBQAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 IlhaOLK4X4=
IronPort-HdrOrdr: A9a23:aoTkrqwo2Zntza5/OW9AKrPw8r1zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 VdmsNFaOEYY2IK7vrS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: =?us-ascii?q?9a23=3AWMp+o2qhg5oPNmAyPrjQXwDmUcU7QD7d8HjXGGu?=
 =?us-ascii?q?lKH5EUJLIWVXPyrwxxg=3D=3D?=
X-Talos-MUID: 9a23:5GAFzAVQZi8FNFfq/Bz8mRhnFsVl2ISrGF4Dwb4shOyqPyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,226,1695679200"; 
   d="scan'208";a="138452540"
X-MGA-submission: =?us-ascii?q?MDFnNAOPSLrqcNj9BJhwmm3+Wxmx9QOjl0+EzH?=
 =?us-ascii?q?LLQ9+q8e2lwWBQb4rCYB7FQyX0ueBIsMdHr1eZ5m1Lb6+vQWmUBH4ADY?=
 =?us-ascii?q?TIrvUyxEifIF1rECHa9EUp45pmimpLxq+E8wYONZcQ0I+PctRlNvbMZp?=
 =?us-ascii?q?vxWA2yobpG0WiiI4n1NXzn2A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 10:10:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700903423; x=1701508223; i=markus.elfring@web.de;
	bh=0LMCP47/MEybIrqdapomX7VKcWAbzrPTsMYnouAuHgU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=KLtAvxXPqayRFhP5yBwt9YIZAZ/eh5fEY5wj7n9WIOqDlmKl2ltn+budAYXm6Otw
	 GH7yMjS1hA2U45h9KBmYSUyasOtwK42aAbm6iunQZR/w/8Hmt7EqD3GFYpolrg8DG
	 d/3GqlxUUigpJIoxDrhoy+IePjQwiwxq0QlSUN0eqlSaJ62yz6D4rckMsIUkMwTHg
	 xGnFO/znjm8ok+fZWd/IjFI9aNbCT2BDdf+lvscuYCxu8ew9PjVZaUyHIzsrSsmRj
	 R0X+/M0Kqx/v2mb1K7be+e9/DgnqppaU53YqjV581InFXhf2ayMnD/2dvpD+ZZA/7
	 h24XMgflOGK/fd7shw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyO0u-1rW1Wl16mi-00yl64; Sat, 25
 Nov 2023 10:10:23 +0100
Message-ID: <c6c194b8-68b7-48bc-b298-67e6a6b73656@web.de>
Date: Sat, 25 Nov 2023 10:10:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de>
 <alpine.DEB.2.22.394.2311240807170.3349@hadrien>
 <05cc07d3-385d-48ea-9e4d-be32c3e863fa@web.de>
 <14be81ed-ab8e-cd1-205e-db30745442d3@inria.fr>
 <d36b547b-a4d2-4e0d-a028-fb9237f99f2e@web.de>
 <d22bd929-b0cb-1b1d-9c8d-3e2e9e1e024@inria.fr>
 <087e1c6a-31d2-4205-8afc-5925cc01b20e@web.de>
 <ee749bea-9fdc-40c6-818f-7c14cb705586@web.de>
 <1c6770aa-c9e8-566-3a28-e9cb36e2f85b@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1c6770aa-c9e8-566-3a28-e9cb36e2f85b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i5VtmsjXtEQoC17M1xVOfQXIqiT08XbMNltGh1rTtJaMxDdI47s
 yFi5CD1Mw2dS765fyQyXqyhjd45pkIm/2CzUmbaFUr3VRE7y6CnGeiPZdI5hgW4JFXeNNQb
 A+urncM8CRO50y9Zi3iBFmSjmPA8/BrKd+agu/WYXAZ0UP4s6Ho9KT4x/BFrw590gyr0Xee
 0TBUuFsewn0fyFbpP0XLg==
UI-OutboundReport: notjunk:1;M01:P0:TXUsN5scpyQ=;wjvqeNrX5jEnKg9xhOBEYiVSfnt
 JP6seEVILpHkmFNPPvve9xyXwmkjQSvMVr+PKyy1fFQ1TFAVDZVxFvEjte8RWqB2OrRmBKMOA
 7rutEoiSXHZUCtBVd1qLfLnxtZ2e0eC9L91JNjGkRCmZN5B0hQoTvOaZPkvQfaKc/CVR6+WS5
 ht8i4XWyqigcWGjqHXhDrbP5czzunXmGPJEcm/D/YahAM9jldKHVsRb6mlqXdBQb87c16bY7v
 6sb4Sed+NZ5VXxE1NQUbEgo2m90HeYM59raNmie5bt2IjIAMV73psrD4bYRcaY80JSSDUgTcF
 2ab2BnRZwvX4VyFoDgCipSRQpR4Ay3HoXlxaXC5U9j5bvCcB1Rtp2gv9a4UGCxmZ4joVIuvrP
 UabEILcu3m/NX5j1eQvom2zRKsg156fvPf51SfIGHVDhZTz1OmyheLdWOCa+IrgOBe5U2T27F
 0UjPN87dDQ2oGx81Ct/+XOeZwtaQfti+Ctyhf+pmQNhldW/vjOP3rVQrDdy2g/e8bJ8cmM3fl
 BDAPB3T7jU6bLzHTUOAFcwumVVgv/rYkOBkFHipi9B0CvCjmoik7WRXyYCycyC/EQRMrXTRjk
 EN5j0RAlzabyyNt536X1ny1F5Q+iE47UK1r4PYP7ov/wiPxkaNw6zzemJpK3xdItl35SJWTia
 4HvMurGx0NZdZH22FOPZI+24vwXv6/h6rptSyWLCd/cUpr2iuAFKmXq23vqqv/wNWc2PB0w21
 mOmPxbKOj7b/CCW6QkdDqIt/frLQY5Sn7gWjm+bgETkAIgwa/5RgZKrR/uhQBzU13PCZGoQSm
 80RpY3Iwy7RBybU8uzp7ABsi4bQ7dXJn7xxtOCkylZb1NdEv/VTZ3DS1ejQ0Jl452gjxkLtsJ
 irAy1g+FzAqo8EymVLBJTst7qfWijFuY7hEYgLqZZ2g0y0z2CvX/TAoNBZD3HIN71Iaz25M7m
 Ly30gw==
Subject: Re: [cocci] Improving support for processing with data collections
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1335
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/c6c194b8-68b7-48bc-b298-67e6a6b73656%40web.de>

>>> Test result:
>>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch test-=
example-20231124.cocci example-Julia_Lawall-20231124.c
>>> =E2=80=A6
>>> (<coccilib.elems.Location instance at 0x7ffbc3d2b910>,
>>>  <coccilib.elems.Location instance at 0x7ffbc3d2e500>)
>>
>> This test case shows that the script rule =E2=80=9Cdisplay=E2=80=9D was=
 executed only once.
>> The found source code places were accordingly passed in a single data s=
tructure.
>
> This is normal. There is one match.  So all of the positions that are pa=
rt
> of that match are collected together.

The Coccinelle software is capable to put some data into a sequence.


>> Test result:
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch ../jan=
itor/use_common_code17.cocci three_questionable_gotos.c
>> =E2=80=A6
>> (<coccilib.elems.Location instance at 0x7f8bd82e6050>,)
>> (<coccilib.elems.Location instance at 0x7f8bd82e6730>,)
>> (<coccilib.elems.Location instance at 0x7f8bd82e8640>,)
>>
>>
>> Would you ever similarly like to receive position information in one se=
quence
>> instead of separate record sets?
>
> No.  One can import many kinds of metavariables into a python script.
> Each execution of a python script is with respect to a unique snapshot o=
f
> metavariable values resulting from a single match.

I suggest to take another look at corresponding algorithmic properties.
Some data processing can occasionally be performed immediately.
But some actions depend on decisions which can only be performed
after sufficient data were collected.
One well-known use case is the determination if source code elements
were repeated (or not).

The current handling of multiple matches has got the consequence
that provided data need to be stored in further data structures.
These collected data can be used then in another SmPL rule of
the kind =E2=80=9Cfinalize=E2=80=9D. Such a finalisation rule is executed =
just before
the program =E2=80=9Cspatch=E2=80=9D will be finished.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/f0cc79b51b1f836b34ea3=
ba584589851e65f073c/docs/manual/cocci_syntax.tex#L688

If further data processing would be attempted, data need to prepared in wa=
ys
for crossing the involved process boundaries so that they can be reused
again later.
I imagine that we would occasionally like to benefit more from the desire
to perform selected data processing within one program run as much as poss=
ible.
Thus I propose to add a key word to the script rule specifications
so that the rule execution would be intended for data collection.
Decisions can be taken then in the same way as in the single match case.
Metavariables can accordingly be constructed for their application in
subsequent SmPL rules.

Do you find a word like =E2=80=9Cunion=E2=80=9D or =E2=80=9Cmerge=E2=80=9D=
 helpful for a software extension?

Regards,
Markus
