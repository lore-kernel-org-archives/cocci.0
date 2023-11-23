Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8977AC5AD4C
	for <cocci@archiver.kernel.org>; Thu, 23 Nov 2023 18:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nYrLccf8AN54zkEkF8iN1Zd4ffvW3pTKVjNiTnjlhX0=;
  b=RFRnvcXwonkHLU2rN6jMS4oNlDJf1kXr7Q7F83Et/a1GQsPm1e/my3Iy
   vUPwg7XItxzGGf6605AmXfymLbxkFKVgJIfWFv4VLbIKKRRLTp8ccnGlp
   hy+LDOfAsDaFJOpUCE3dukUH+H1kpStYiDKx4Fx1s5ApSWPPwzMQ6xEGH
   s=;
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
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="138196180"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Nov 2023 19:16:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 912F9E0CCA; Thu, 23 Nov 2023 19:16:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5381CE004E
	for <cocci@sympa.inria.fr>; Thu, 23 Nov 2023 19:16:44 +0100 (CET)
IronPort-SDR: 655f970c_7uOkflwT3FvaIBAif+28aU4Mcr1cXa5JFPkSSlK/L+QGL6u
 tQE5/1siKTPtmzAYGKRqluGMNt3bkmaryWZasdg==
X-IPAS-Result: =?us-ascii?q?A0EwBAC1lV9l/07ASNlaHgEBCxIMQIFEC4I5B3NWMAQLS?=
 =?us-ascii?q?IRTjz2BdTCEO45+iG+BVoFAPg8BAwENPQQBAgQBAQMDAYR/AocpAh4HAQQxC?=
 =?us-ascii?q?A4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECgQYThWgNglwBEIEMg?=
 =?us-ascii?q?R4BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQJHQ?=
 =?us-ascii?q?gEEASMdAQERJw8LGgImAgJXBgEUAQGCfAGCKQEDDiMHDbEpgTKBAYIJAQEGg?=
 =?us-ascii?q?VdBrT0fLCJWgV8DBoEaLogNAYVZhDUnD4FVRIE8C4JHMT6CYQEDgV6DW4Joi?=
 =?us-ascii?q?ScHhiWOfV0iBUJwGwMHA38PKwcELRsHBgkUGBUjBlEEKCEJExI+BIFggVEKf?=
 =?us-ascii?q?z8PDhGCPys2NhlIglsVDDRKdhAqBBQXgRIEahsSHjcREhcNAwh0HQIRIzwDB?=
 =?us-ascii?q?QMEMwoSDQshBVYDQgZJCwMCGgUDAwSBNgUNHgIQGgYMJwMDEk0CEBQDOwMDB?=
 =?us-ascii?q?gMLMQMwVUQMTwNuHzYJPA8MHwIbHg0nJQIyQgMRBRICFgMkFgQ4EQkLKwMvB?=
 =?us-ascii?q?jgCEw4GBgkeBA4DGSsdQAIBC209NQkLGwY+AiefX4QXMC0sgVqTf7FNNAeCM?=
 =?us-ascii?q?YFfgWAMihaVDQYTL5ciDgaST5hAII1Hmm2BZAE7gVkzGiSDNk8DGQ+OIIQrg?=
 =?us-ascii?q?QuOPEA1AgkwAgcLAQEDCYVGAQGDWoFAAQE?=
IronPort-PHdr: A9a23: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
 RcFk+qQEA==
IronPort-Data: A9a23:9QfpAq9vsC5Q+5J4yCcCDrUD/XuTJUtcMsCJ2f8bNWPcYEJGY0x3n
 WoeUD3UM/zYa2TyKIt/O4qyoB8DusTdydVgTQs+/CpEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWYoWo4ow/jb8kg25a6p4GlwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TEydNEHGwNN9chwOdwPXMS6
 94Uby08YUXW7w626OrTpuhEg8M+MI/0MYlZtnwIITPxV695B8+ZBfybv5kHjF/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUB8wLM9PRuvDO7IApZ4JHzGtbyYuK2V+Z0pF7Ih
 TiF7TmoHURPXDCY4X/fmp62vcfEmijwWaoJBbig/7hrhkeSzyodEnU+UVKkqP29oly/XthFI
 goV/DAvpO487iSWosLVWhqlvDibsxRaV9c4//AG1TxhA5H8u26xblXohBYYADD/nJ5oG24Zx
 RWSksn3BDdilrSQRDjPvv2XtD6+c2xdZ2MLeSZOH0NP7sjBsbMDqEvFbu9iN6qp0fzzOzX7m
 A6RoAYE2r48sM8s1oeAx27hvQ6CnJbyYzQO1l3lZV79tgJdT6y5VrOs8mnevKphLp7Gb1yvv
 0okusm57cJVP66siR6ifeQpN5Oq7sajLzfzrwNOHZ4g1jL14F+lX9lazw9fLXdTEPQvWGHWc
 mrMnzhO9blvPHeORo1mUbKbUsgF4/DpKoX4a6rycNFLXKlUSCaG2yNfPWirwGHnlRkXo5EVY
 Ju0X56lMicHNP5B0jGzeuY61I0rzAAYwUf4Z8jy7zaj4IqkSE+lc5U3G3rQUblh94KBmhvfz
 PhHPcjTyxl/bvz3UhOKzaEtd2I1PVoJLrGojfdId9yzABtsQ0AgLP7z/YkPWaJYm4Ztq+OZ2
 U3lB2F5zgLkiGzlODe6TClpSInSUKZVqVM5Oi0RPmiU5UUzXLb30oAhc8oYQLp20s1i0v9+c
 NcdceqiHPlka2rK6hYdX7bHva1gcxWn3zyPGy+fZBk+YJ9SaAjb8fD0fgbU1XcvDwjmkeAcs
 rGfxgfgbp5bfDtbDeHSc+CK426qmHogxNJJQErDJ+dMdHXW8IRFLzL7itk1KZouLSrv6yS71
 QHMJzslvsjI/pEI9efWiZC+r4uGF/V0GmxYFTL56Ze0LSzrwXqx87RfUeqnfSHva02swf+MP
 d5q9vDbNOELuH1osIAmSrZi8v8Y1uvV/rRfylxpIWXPY1GVEYhfG3ih3/RUl6hz17Rc6BqXW
 EWOx4FgAo+3GvjZSXwfGAl0Sd6496AwuiLT5vELMknF9HdJ3L6YY35zYTiIqgJgdYVQDq104
 N0cqPY36hO+gCUEKtyprD5Z3EXSI20iU5cIjIA7AojqgDV6k11pPMfuNQ7r0r6yavFnEEojE
 hmLjoXs2pVewUvjdSIoNH7vhOByu7UHiCpo/nQjeWubv8Xjh+Al+TFs6hE1c1hl9QpG2OdNJ
 WRbDU15CqGQ9TNOhsIYfWSTNyxeJR+eoGrd9kAokTDHckyWSWD9Fm0xFuKT9kQ/8WgHXDx6/
 qmd+Vn1QwTRY8D98Ssja3FL88W5Y4RKyTTDv8S7E+CuPZowO2Pli5DzQ1s4kULsBMdpiXDXo
 eVvwv1LVpT6EiwtuIw+NZiR0OUBaRKDJVEae8pbwoEyITj+dg2xiB+0EGLgSvMVcraOuQW9B
 td1L81CawWm2Wzc5noHDKoLOPlvkORv+NMGfajxKHUbt6eE6ABkq4/U6jO0kVpDrw+CSirhA
 ti5m/O+/m2sab98nmjQsI9bN2D+bdRsiMgQGgyq2L1hKn7BmLgEnYIOPn+coHifdgdql/5Rl
 B2WfLfYloSO1qw197YB0cx/68GcNt75EuiFmOx2XxKicvuXWfrzW8gpRpUL8uiY0Xb9mzi6q
 FhVjOPK4Q==
IronPort-HdrOrdr: A9a23:6/u0eaB4sQjzqaflHely55DYdb4zR+YMi2TDpHoBKiC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOk9K1vp
 0BT0ERMqyTMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:sSVZO2/H7TeUUkfoQo2Vv0QyMNAISXeH9U3RJHOqVXhLRPqIeFDFrQ==
X-Talos-MUID: 9a23:KNBuzws3p+o6NsLmas2ntBh8HstP+5qSGmMsq41WmJPHJ3EhJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="138196173"
X-MGA-submission: =?us-ascii?q?MDGPzPVN5ADTTSNAU7cdD7WVXhbB+f1Ydzgj1v?=
 =?us-ascii?q?8bBKbMhHnXL6RPaDMXfgeiHRt+w5eZVUO/dXBHl4ivIGJhMZWhfaBGiS?=
 =?us-ascii?q?+wuKnxZzRDdlcouZWDZInhTbXtLy8UYTKPxGXtFXWI28WzyaieNGuOcY?=
 =?us-ascii?q?duFKWUu9+cnAgkkpK8ZKvm0Q=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 19:16:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700763395; x=1701368195; i=markus.elfring@web.de;
	bh=HrXkuccGRaTophDNT725ypTRx21xaOoQNaVABECv8uE=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=JLFyNT6sR+BMcpBg+u4+A2wzIeRUJR5YpEsFytlRUyxVPe0kErYceyxmROVlaVPz
	 6tbxci59vUjsbnuSTRMTdvSXxrNLK+OfkN7FqaSgMzHvac6WYMdvzNzFsLNQERhcE
	 BtTHVOMOJpDdCkNZYn6ZpLlz/ucHZHIGM7BHC+3lhT7dNWemrCmBraOHvo42eTBIE
	 zAIEOWbMP1qXtXpXzSrivbhW1D904gbU6YQueSr9kGX2r/8P20DmI9nbAVXZADETG
	 RpWIdp2adq3Qqiq7XF1OFGwi6/BR1Y0njrEDkkjaV9IXN1ZASZurLm8gw/ZjVNTwB
	 bapgib2jIqgntT5szg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7QQB-1rObb40LyX-017pzT; Thu, 23
 Nov 2023 19:16:35 +0100
Message-ID: <eb737656-e7fd-4331-a641-bd208b459f83@web.de>
Date: Thu, 23 Nov 2023 19:16:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de>
 <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr>
 <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de>
 <alpine.DEB.2.22.394.2311222131120.3262@hadrien>
 <471b38f1-fc2d-482b-ba0a-8c7982ba9618@web.de>
 <alpine.DEB.2.22.394.2311222158000.3262@hadrien>
 <fabb554b-d109-4a77-96c1-a96f31d107d1@web.de>
 <alpine.DEB.2.22.394.2311231846240.3125@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2311231846240.3125@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SFwbqJLABSeW7p3aNjf8IWzTWGWYTAF9mQ3dZpZrq/HwbuX2ueI
 tIYZ3NrHKBxfI74QZXsLLJZw9B96DbEtdZz8M2bBTF6ss9EAkK4KURjsWwKm/h3EzQlAtol
 jT1l0IaK+quNKGo6lqv8vSr5wnfCoKcahJrx9bIkmYLozYYKMgXoZqNALUli6p/sBut0LpB
 iwU2BMK0ZejhdapPbOslA==
UI-OutboundReport: notjunk:1;M01:P0:jDzVkKbo5gg=;inUu2SZ2Mqbf/0YpNwerjc5i14P
 Gr+de08aFpNSq3aLa5yfZtjp0YQmy7p0l+VoEgVyzgGuoqT7fBJh3d8RRKKjY7LpWrpt5EUua
 swHXnonGeB+WTsSV1spc5w6AfHK9zK342jIeRcGZ9dghvWCO9tbw37msVxQeBwiDqx4agb10/
 93esVTuohvIZDzdlS5WNLQfS38U1WVogL7psq/DVjgvrZxbBpv48qIuvEutSO4/YcUudfDRh0
 wCjs3dHHns39YNQINzcKOWjLlOt7Mol4byM17GRseWuVRcLxOpR12hTAk+HPu9jS9C7Yf62ai
 62iTFWTXvAnRAWlO7P7NTKoZ3Kwe1DYnXD/mnhEJf8DZ5DDLrdaB3LGU5a2Z2VjI7t9IbMUuJ
 G3JTlKgXZBeZRCUEhfeb1VFst0WTrL8Bo5Yp3RWIDDdkbPNtywapwkUphj44jjArWI9fSpsQ8
 WkveKN0n3pYjqMcihdiImk/nMQS5uf5gy+e2JKR1yqwcz6B4leGjP70/6EwLoVTY81Krioxxl
 BJbFO7bAIBNTHCxItrzQtSJoNUxv/fUlc7URNpt1sJfxi6tl6Wwdn+oCtfxiocrVj9ZeiEWTP
 6EkdvQDhldZFh+SSeMNTU4WpwCJUZ8DsZDz6hfoTdCsq/ue5gOzrSw5j/tFEyRYfE4nn4U3Zp
 FH+RLm58a1JEiRzgQC/g7wr8ZbHKnuqqjKWOa7+SwfU0lFgtSlu0qkJxbFNGXmwIaPe1HWdHG
 1x/8SS82xqnNNFM7PxeY8tdVJ451iF79x845QcsTEvflvNaNTNTaaT7RiAQGRFGLCDCVBt1bH
 99lG8ta33vdYLV0vTYqtLLWCcoz8b09LONDqmb4EwRtCXCwAgmXXXNa+MlvLEZ7VaXweFdE2O
 cs69bM2BXMgv8fUPHxuKVq6WZdHSks8LmcXsHIVUdIp5GuZ2I70GMrT1RlDmjTWBhbPZDijEP
 IA3WaA==
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1322
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/eb737656-e7fd-4331-a641-bd208b459f83%40web.de>

>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8d66511d00b27de44e=
5c21b60d41938d32321b1a/docs/Coccilib.3cocci#L226
>>
>> How do you think about to provide a function variant which can copy rel=
evant data
>> from a previous position object directly?
>
> I don't see why it would be useful.

Would you find any other code variant more reasonable than an approach
like the following?

@script:python selection@
places << find.pos;
marker;
@@
place =3D places[-1]
coccinelle.marker =3D cocci.make_position(place.file,
                                        place.current_element,
                                        int(place.line),
                                        int(place.column),
                                        int(place.line_end),
                                        int(place.column_end))


Regards,
Markus
