Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0905DC4828F
	for <cocci@archiver.kernel.org>; Thu,  8 Feb 2024 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pNRbmvLFEc3MknZ1EBU5CHiUnGyRv66QFkcaUfbGdlM=;
  b=DXf8D1L7j9sD4ujFpDd76FC3VHh7PUv/3ELPGPhRqrrfZWJXKIDht+4q
   xOi5IgZiJ53eJwmZlYaHhccNZrd9EEj2jkywwQkMX4PraHHMHMW5scFxl
   +tInIp/M6pA33YHS/YQGuxSQAH2KKNO7NowybqQonT5L1/Ourju3y/9aE
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,254,1701126000"; 
   d="scan'208";a="150968960"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2024 14:35:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3CEECE0CD5; Thu,  8 Feb 2024 14:35:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8D76FE008A
	for <cocci@sympa.inria.fr>; Thu,  8 Feb 2024 14:35:36 +0100 (CET)
IronPort-SDR: 65c4d8a8_cBoMOit2I/MAvK0AZ9IfcC+nOfHHcr+OkjNAjFkv3rCDaZ5
 paEy6Q3b47a5ak9hHhzOYf4vXhMCI6coOSDyS2A==
X-IPAS-Result: =?us-ascii?q?A0EXBgDM18RlhwwR49RaHQEBAQEJARIBBQUBQIFPAoI3f?=
 =?us-ascii?q?1MyBAtIhFOROi0DhDuHN4dOiHCBaoEsPg8BAwENQQECBAEBAwSEfwKHVwIeB?=
 =?us-ascii?q?wEENQUNAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOE?=
 =?us-ascii?q?CeFbA2CXAEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAgIBIx0BAREnD?=
 =?us-ascii?q?wkCGgIRFQICVgYBFAEBgnyCKwEDDiMHmm2cNIEygQGCCgEBBq9aHywiVoFhC?=
 =?us-ascii?q?YEaLgGIJQGFboQ7Jw+BVUSBPAuCRzE+g3wJPj+DHIJohVSXOFR/HQOBBQRaD?=
 =?us-ascii?q?RsQHjcREBMNAwhuHQIxOgMFAwQyChIMCx8FVQNDBkkLAwIaBQMDBIEwBQ0aA?=
 =?us-ascii?q?hAaBgwmAwMSSQIQFAM4AwMGAwoxMFVBDFADZB8yCTwLBAwaAhsbDScjAixAA?=
 =?us-ascii?q?xEQAhYDHRYEMhEJCyYDKgY2AhIMBgYGXSMHDwkEJQMIBAMrKQMhdBEDBAoDF?=
 =?us-ascii?q?AcLB3iCCYE+BBNEAxCBNIU+gxEDGSsdQAIBC209NQkLGwY9Ap9PB4FpTIEkH?=
 =?us-ascii?q?jrEbTQHgjSBYIFhDJ83BhMvly4OBpJemFcgqFeBeyKBXDMaJIM2TwMZD44gG?=
 =?us-ascii?q?R+DdY9HQjU7AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 t3Iib61NzpItd7Zr5N07yf8N8+NdnYsY0OBJQ==
IronPort-Data: A9a23:MQMqs6IHK2UVGr9yFE+R6ZElxSXFcZb7ZxGr2PjKsXjdYENS1TZUm
 2pMXTvVa6qDM2HzfN5/bYy1o0oCu57Qm9MyGgEd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgf4s9JIGjhMsf7b8ks/5K6aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0Luc1jv6cdxC18PYZASq6EoWCZu/
 uwnJ2VYBvyDr7reLLOTT+5xmoI8IcOtMI53VnNIl2iDS6x8HtaaHOOTv7e03x9o7ixKNdPXf
 ckEcnxCaBraYhtAEkgaAtQykY9Eg1GmLmUJ9gLF9PpfD2777Cp/ieK9HsLsZffRYuIEo1iGm
 2Oa8DGsav0dHIfDmWLeoi3EavX0tSfyR4sWEJWq9/tgmlTVx2oJCRRQW0HTifK+gUW/c8lOL
 lQdvCsot6k7skKxJuQRRDW9p2OY+AERUZxcHoXW9T1h1ILUwAWzNHcDUAcdddZ385BvAhwhx
 mCGyoaB6SNUjJWZTneU97GxpDy0ODQIIWJqWcPiZVVaizUEiN9t5i8jXupe/LiJYsrdNRyY/
 txnhC05mqlVksMBkam2lbwmv95OjsiVJuLWzlyJNo5A0u+fTNP1D2BPwQWEhcus1K7DEjG8U
 IEswqByFtwmA5CXjzCqS+4QBryv7PvtGGSD2QE0T8Vxq2n9pSTLkWVsDNdWexsB3iEsJmKBX
 aMvkVkIucY70IaCNvQpONLtYyjU5fG4TYu+PhwrUja+SsMtJFfcrH4Gib+43mfrl1NkiqxXB
 HtoWZbEMJruMow+lGDeb75Fj9cDn3lirUuNH8yT50r8i9K2OiXKIYrpxXPVM4jVGovf/F6Km
 zueXuPWoyhivBrWO3KMr9VMfApRRZX5bLivw/Fqmie4ClIOMAkc5zX5m9vNoqQ0wfoHpfSC5
 XynRE5TxXz2gHCNe03AaWluZPmrFdxzpG4yd35kd1u5+WkRUaD25ocmdrwzYeYG8s5nxqVKV
 PUrQZiLLclObTXlwA4jS6fBgrZsTin2ujLWDRGZOGA+W7VCWz32/sTVe1qz1SsWUQuym8gMg
 5yh8QL5Gqg8ZhlQI/vXTNmNzFqBm2cXt8wvfknPI/hVIF7N9qozIQPPr/YHGeM+AjSd+Sm/y
 CCtHgY+menBh6QX4ev5r/mIgKnxGtQvA3cAOXfQ6IiHEBXz/02h8Ndma/mJdzWMb1HE0vyuS
 ssNxs6tLcBdukhBtrd9NLNZzagewd/LjJ0CxyRGGET7VXiaOolCEFKng/YW7rZsw4VHszSYQ
 kiMo9lWGYuYMfPfTWI+GlAXUfSh59o1xB/p8vUHEGfr7nRW/Z2Gc3loETuitSh/FIZxYaQZm
 boPmchO8AGuqAsYAvDfhABuymm8BHghUaImi5IkPLHWmjcbklFvXJiNJRL1sbeuaspNOHYEO
 jW7prTPrJUCy1vgc0gcL2ns3+1cic4wuTRP9lsjJkuIqPXBlPQYzB1cyhVpbwV3nzFs8fN/B
 XhvDGJxfZ6xxjZPgNNRekyRACRDOUGpwVPwwF43i2HpdUmkeWjTJmkbO+zW3kQm309DXzpcp
 pe09X3EVGv0QcTPwScCY05phPj9R9hX9AeZusSGHdyALqYqcwjena6iSmoZmSTJWfprqhX8m
 tBr2+JsZYnQFy0a+fQ7ArbH84UgckmPIWgaTMxx+K8MI3rnRwiz/jqzMGG0RNJGIq3b0E2/C
 vE2HPl1aTaF6H+soAwYVIk2GJ0luN4y5dEHRKHnGn5ejZubsQhSkczx8grQuTYVZutAwOcHF
 5PpVjOdE2avq2NetE3ToeJlZGepQ9k2Szft/eKy8e82RssPm7w3Q34Tz4mbgnSxGylk9iKyo
 wnsSfL3zetj6II0hKrqMPxJKDuVIOPJdtaj0V6MofFRS9LQI+LiihgwqGS7Dz9JPLAUZct7p
 Y6NvPHzwknBmrQ8CELdpLWsCIhL4p+UcNdME8eqMkRfozSOaPXs7zQH5Wq8D55Dy/FZx8u/Q
 jqHeNmCTsEUV/hd1U9qRXBnSThFMJvOb4DkuS+ZhNaPAEJE0QX4cfWWxUWwZmRfLiI1K5nyD
 zHvgMmX5/dakZ9tASEVDPQ3Er56J17eAZEdTePTjgXBLGeUgQKlgIDAxCoQsWSBTjHOFcvh+
 pvKSyTvbBn46umC0NhdtJc0pRENSmp0he4rZE8G5tpqkHaAAXUbKfgGe4AzYn2OfvceCLmjD
 N0MUIcjNck5dTFDbAm6/9npGAuSbgDL1hEVORRxl354qQ/vbG9DPFel3jht6TF6d1MPCcm5f
 MoG9CSY0geZm/lUqCV62hB/qfhqzLXWyxrkPKw7f9PaW34jPFnB6JCt8Mehm8AK/wEhWXgn/
 VQIeF0=
IronPort-HdrOrdr: A9a23:z78paqGWbXzZ4iXxpLqENseALOsnbusQ8zAXPjNKOH9om6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4tgPM
 xbE5SWZueAb2RSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: 9a23:k5A1XGGzQQB6NbJdqmJn100+KN8ibESB0X2BZBDhTkZiWIKaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AGIRfCgyDEeDEypBO4SpSB2Vd17GaqISIBhlXwbs?=
 =?us-ascii?q?egtavbgtXagqDkgm2HoByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,254,1701126000"; 
   d="scan'208";a="150968898"
X-MGA-submission: =?us-ascii?q?MDGxHmuJGfl9Tep0VxKt68xE3R89gv9Gptkq64?=
 =?us-ascii?q?ZBdSiI2yVaVKiEaROC0/U6gow26+XeFxd5M9CIO/lBWScHKlSXNUgkJO?=
 =?us-ascii?q?drMm/T8iHtY3llJgQkjHS+FmJTZuEga1PSCEIsQuvdGoAxAASxzepOxc?=
 =?us-ascii?q?+vRnrBlr05Z4EMqwmu9Txv0w=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 14:35:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707399335; x=1708004135; i=markus.elfring@web.de;
	bh=ME81mC7JVr4hE+MPgoy4YIoijPNRoIhX+Pt3PjuDoTU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=gPTuU4mFU499gGfnNnzcD69a5Kj1+ESjayXx5O3afvU/nHNjeaCNOOJc0VAAA+zw
	 UOXCNtICVQHm27Qaua9YQVEfwpr8DVmLZY7DCSO+RXjUzFldHWiEtMaPNEZLq5rBG
	 Z+0g4+jmuBv73dGhfW4AXOsTrCedNJ+bUWBjXkAJ0RlbIhVdGRaGIjkifmYKA7soP
	 o0v3pZ5O3rofEjyX8aoU6cd3JIdd2BE9gy5hIWGb1B6BN8apQccWE4/+48Mr53Vst
	 qNdmknc4aHGJGk0Xz+cCKpfmKOjxY4yzVESsi6Qdimqg9XHoyu/C/OpxfqhSSOcUl
	 KYjqGVBhmrI9MiLq3A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRF3W-1rJgyh0Z3E-00NMrX; Thu, 08
 Feb 2024 14:35:35 +0100
Message-ID: <bcf3a2f8-8578-43ba-8ace-99bad4ac5761@web.de>
Date: Thu, 8 Feb 2024 14:35:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <dcb996ea-f041-406e-b641-0e6b515b9a0a@web.de>
 <7639c70-41e8-9a1-3a5-3a7711fc465@inria.fr>
 <1f8cb65b-715f-404c-84f7-8eee6de02352@web.de>
 <e2189114-2fa3-1045-1ae1-fb308b8c5c1f@inria.fr>
 <cffc1d24-5bb3-4a90-9593-31d3905449e4@web.de>
 <510575-bbc0-442-85a3-3c2fa510aba7@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <510575-bbc0-442-85a3-3c2fa510aba7@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5dnyKYmxJZHFc2gYf/9aQJaEtsvEzdrdCrxpj+Rr7Gu32N4ZJ9i
 PV8l6FtAVNxRx7Oe0pxmjMbSBK0eOQwY+42TZOfc81zOS8SY8fZs8lQHKTwN8rY8bcHlWfN
 1Pddc/s0AmlOMi0UTv9K/DqHxqxqHuGKnm4XkJwIC3ANbkChtbBLA6EYbPqhMjvrfkaps+e
 Zx82TwMT/nouag57/sFwQ==
UI-OutboundReport: notjunk:1;M01:P0:prGzneAXXc4=;Ulp7GxXjDa8N87RdfCwwHcrq9Sy
 jN9Q3HqHC23pcUP8OhVeyhZwFXpjGajk/xQbeq9COuNZ763RMfimAQxQOVkDy/Pc+1TveB9Kq
 MyT49SqiQfCzyw+vCjyB0nwMkSFCfafoWY2r8crs7/jgfvytrNjgieZ3r1DkJSgk/+hFV24Da
 rO6eq52V0kFt1DgF/NXj1GTy+8qUQvlIoR0oimkJQs84qZ9IkNUegNoDl+JzXNtq1SGc/jBqn
 4BVN5l83nSFhQTB4WsoZsT16X0+zPpA1ayYNZzbI2Cxx2Lw5sPQb1ShATPRf548D6aevDdyNo
 NLzaYBCtxw6TEqadE86tvfh0tL63noHrv7rXo5przb3kExKqVXeFW1s/eYJ1sqNfAYj4vUPFx
 7VVw7cpzPpY57qVk1EG6Ykp3KiMADbEo4enPH7KEdM25uw2cy2fE9zx9NtC3jPxC6t4a7dwor
 18ABOyBWZImJ1eVwKEMt51yunRqB6DG1R+180eSFUkz2cHf2VX/wSRSs7ig57Xn0i4KRyExKx
 QYyxaEk6mWZHfQGaOW+6L/Buioa6eFsDSuv4TpayPqN6mgeOiZO1FJIBFrJ4s03fJijIOa2Ly
 eGPwBsdaJBrS/J2n6q568kB0xnQP+qfeZeye+yzz+BCugdPiz9Kv3nUiQG3VbJy3TZfrvyMsG
 48fEhhVfvx6dUxp8enYWjvvNUUEAcf30kyps+HYWJLEtLrwpMFjWnucWezvUgUOIngFW920rg
 JQc4dbcgucOlGBu5TXn0HOu7OPWx7h2wgKz42ZMFU5ewWXBauHvd1GXsEu7Vd6aAh/aov9/to
 AW2YxJpuQLOXOtZyGroKeeCohGvgN6pyofLj6TYacPHyE=
Subject: Re: [cocci] Improving support for code positions with opposite SmPL
 dependencies
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1519
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/bcf3a2f8-8578-43ba-8ace-99bad4ac5761%40web.de>

>>> Once you make transformations, the positions of the
>>> changed code have changed.
>>
>> I propose to take the specification =E2=80=9Cadjustment2 depends on !te=
st_switch=E2=80=9D
>> better into account .
>> This case distinction is already working as expected for the
>> specification =E2=80=9Cvirtual test_switch=E2=80=9D according to anothe=
r test case variant.
>
> And?  The fact that one case is the negation of the other doesn't do
> anything to imply that eg multiple matches cannot occur in the same func=
tion.

I would appreciate that the SmPL design pattern =E2=80=9Cdepends on test_s=
witch=E2=80=9D
and a companion rule depends on the negation would work for more use cases=
.
I find it essential for the convenient selection of desirable source code =
transformations.
Can they occasionally become safer if SmPL position variables are applied =
accordingly?


>> How will the handling of  =E2=80=9Cif =E2=80=A6 else =E2=80=A6=E2=80=9D=
 constructs evolve further for SmPL code?
>
> It won't.

Does this kind of feedback indicate just another communication difficulty?

Regards,
Markus
