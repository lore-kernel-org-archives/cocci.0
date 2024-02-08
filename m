Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D867DC48260
	for <cocci@archiver.kernel.org>; Thu,  8 Feb 2024 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NX0OF75yp/iGAEa7UrLpNQSsEaZBe3mKaoTtBZj1PKw=;
  b=swAN2p/6FnnVa430FW8XDlqMPJkF3y/aAK8kO6pANgJCUSkZ3o5otmQW
   MnGBRxq1O7F03b8GOXxJm4voiW33+tdE+iU+ZbCJBi1sRZiZ01NoLDM6q
   j2zbdvjssrXScE2od2jPg0bVV21VN/GV+5rWUM/IyI/7+JY2TfpJXQstQ
   0=;
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
   d="scan'208";a="150970219"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2024 14:40:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 602FFE0CD6; Thu,  8 Feb 2024 14:40:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 46222E008A
	for <cocci@sympa.inria.fr>; Thu,  8 Feb 2024 14:40:09 +0100 (CET)
IronPort-SDR: 65c4d9b8_WPoQKcq8LY+eWHGxVR3uwdKbQtdQLd+HLk2/rCmND/6+ton
 M7CzGt4yiRLt718k2NCZ0Kwf7XI7rwpzz5oByIA==
X-IPAS-Result: =?us-ascii?q?A0HTBADG2MRlhwwR49RaHQEBAQEJARIBBQUBQIFPgjl/U?=
 =?us-ascii?q?zIEC0iEU5E6MIQ7hzeHSwOIcIMWPg8BAwENQQECBAEBAwSEdgkCh1cCHgcBB?=
 =?us-ascii?q?EcBAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4VsD?=
 =?us-ascii?q?YJcARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgECAgEjHQEBEScPCQIaA?=
 =?us-ascii?q?iYCAlYGARQBAYJ8gisBAw4jB5p3nDSBMoEBggoBAQavWh8sIlaBYQmBGi6IJ?=
 =?us-ascii?q?gGFboQ7Jw+BVUSBPAuCRzE+hEODW4JojlaONlR/HQOBBQRaDRsQHjcREBMNA?=
 =?us-ascii?q?whuHQIxOgMFAwQyChIMCx8FVQNDBkkLAwIaBQMDBIEwBQ0aAhAaBgwmAwMSS?=
 =?us-ascii?q?QIQFAM4AwMGAwoxMFVBDFADZB8yCTwLBAwaAhsbDScjAixAAxEQAhYDHRYEM?=
 =?us-ascii?q?hEJCyYDKgY2AhIMBgYGXSMHDwkEJQMIBAMrKQMhdBEDBAoDFAcLB3iCCYE+B?=
 =?us-ascii?q?BNEAxCBNIU+gxEDGSsdQAIBC209NQkLGwY9Ap9Pg37FJzQHgjSBYIFhDJ83B?=
 =?us-ascii?q?hMvg3IBkzsOBpJemFcgqFeCHYFcMxokgzZPAxkPjiAZH4N1j0dCNTsCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 tWdzcobyR9H9M/Iu9QRDY7YJZDfWEc=
IronPort-Data: A9a23:QBxJFK9hlNOylSTQRqSDDrUDuXqTJUtcMsCJ2f8bNWPcYEJGY0x3m
 DEZDWCBP67eMDDwfY8gPdnj90kOu8PTm4NkG1Nt/nhEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWYpWo4ow/jb8k835qyi4GlwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TE8uxTLhAcLNEj2u9yIkZI2
 dtIEwggcUXW7w626OrTpuhEg8M+MI/0MYlZtnwIITPxV698B8qZHOOTupkBhl/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUH+QvN9PtqsgA/yiRX8Lv0D+vVSOaQVOROtGO7r
 2HauD7AV0Ry2Nu3kmbVqin82YcjhxjTXIsNHbm83uxrhVeJzyoSDgcXXB21u5GRgUm1UNN3M
 F0R4iNorK4o9UXtQMOVYvGjiHuDowJaRNdaVeE3gO2Q9kbKyzeAO0pVZC8dU/wvsewRQxANh
 mSxssy8UFSDr4apYX6a876Vqxa7Ni4UMXIOaEc4oe0tvYaLTGYb0EynczpzLJNZmOEZDhnc7
 li3QMUWgrIOkYgU2q/98V2vb9OQSnrhHlJdCub/BzzNAuZFiGiNOtzABb/zsKkoEWphZgPd1
 EXoYuDHhAz0MbmDlTaWXMIGF6yz6vCOPVX02AE3QMJxq2Txpi79J+i8BQ2Swm82bq7onhe2P
 SfuVf95vsYOZRNGkIcsONzqW5hCIVbITIy9Cau8giVyjmhZL1PXpHo+OiZ8Lkjsl04riukkN
 P+mnTWEXR4n5VBc5GPuHY81iOd1rghnnD+7bc6hk3yPj+HEDFbLEuhtDbd7RrtkhE9yiF6Jq
 Ik32grj40k3bdASlQGOqtVNdg9bdyNT6FKfg5U/S9Nv6zFOQAkJY8I9C5t7E2C8t/ULyLX77
 TumV1VGyVHyo3TCJE/YIjpgcb7jF9I3534yISVmbx7i1mkBcLSfyv4VV6I2Wr07q81l7/p/F
 Mced+u6X/9gdzXg+hYmV6fbkrBMThqQqDyrAzuEexk6Jp5peBzI8ITrfyzp7yg/MRC0vsof/
 Zyljx3XcaMeS15cDeLTUvaOzkywj1cZiuldT0vFGfgNWUTOoaxBCT39se8zGO4IcS78/zq90
 x2EJDspvszfitYR3PiQoo7ctKavMe91PnQCLlnh9bzsaBXrpDuy87FPQMOjXG77Vlqt3I6Ae
 O8M7fX3EMNfrWZwq4AmTopal/Mv1eDO+Y1f4B9vRkjQTlKRDbhlHHmK8O9PuoBJxZ5boQGGY
 V2OyPYLJYS2PN7ZL3BJKDoHduij0dQmqgvW59kxI2T443ZT15iDWkNwIRKNqXJ8KJ1YDYAb+
 toi6fUms1GHthkXM9i9nn918UaIJSc+SKkJjMwRL7LqrQsJ8Wt8R6LgJBX42qzSVOUUAHIWe
 meVoIHgm4VjwlHzditvNHrVgstYq5c8mDFL614gfGa2u8f3qcI2+DZz8j0HaBtf4Tsa8uB0O
 0ltb1ZUI4fX9RhWpcFzZUKeMCAfOw+85WrK1EovqG3Va2KKR179BjQxFsjV9X9I7l8GWCZQ+
 Y+p7VrMUBHoTZnX5TQzU0s0kM7TZ4V92SOakf/2AvnfOYcxZAfkpaqcZWAojR/DKuFpjW3lo
 dhaxspBWZfZBwUx/ZJiU5K70I4OQi+qPGZBGPFt3J0YFFHmJQ2d52K8FFCTSOhsedrx7k6KO
 +5/LJluVjO/9hq0gBI1OKouG4JwzdkVvIcsW7WzPmMXkaqtnhwwurLqyyXOrmsKQdJvrMUDF
 r3sZw+ySmy9uH8FtFLO/e9lO3W5a+YqfAfT/v6428RXGoMhsNNDS1AT0Ly1sy+rMS9ixRa1v
 RzCVYDS3edN2YRhpKqyM6RhViGfC8L/a/SMyy+36+9xVNLoNdzcki8osXzlAlhmBqQQUNFJi
 ri9it7780fbtrIQUWqCuZ2+O4RWxMe1Bsx7D9nWKSREoC68R8Pc2RsP1GSmI5hvktkGxM2GR
 RO9WfSgZ+wuRNZR631EWRdwSy9HJfzMUZ7hgieho9CnKBsXi1XHJez6007ZVzhQcytQNqDuD
 gPxhe2V2elZi4ZxHz4BOeBtBs5pAV3kWJZ+TebLixujMjCKjG+B65zYrjhx2QGTXzPAWIz/7
 IneTxfzSAWqteuahJtFuoh1pVsMAGw7neA0eVkH9sVrjyyhSlQLNvkZLY5MH6Q8fvYeD30kT
 GqlgKoe5STBsfBsdBLh/JL8Uw3ZCuFm1hIV4NA21xv8Vst0LNro7HhdGuNI/Hp8PDfupA1iA
 c9L4WX+Z3Bd3bkwLdv+JZWHbSNP2f7QgH4Fkaw4fwoeHD5GaYg3OLdd8MahmMAJ/wwhVKkGG
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:27903K5bnUHynm/jqwPXwBbXdLJyesId70hD6qkDc203TiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ856U
 4KSchD4bPLfDpHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: =?us-ascii?q?9a23=3A+xiexGpZjC0OzbhA/Wmdeo7mUfE8T1+M5maMGG+?=
 =?us-ascii?q?xDEVOTpGyGWSo1bwxxg=3D=3D?=
X-Talos-MUID: 9a23:c+r5QQZrvIxBY+BTkR/vnQ5TNPVS+bWPE2oospwFp47eDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,254,1701126000"; 
   d="scan'208";a="79109959"
X-MGA-submission: =?us-ascii?q?MDFg2+r5xM0YYIyFPaLr5rXXCBamzrkHs37Csb?=
 =?us-ascii?q?ZHNMYktSHPERtmwVJp+NL2IwauyJt+DoOlqacDKSIdk8w4FLs/Q5YyYE?=
 =?us-ascii?q?2gFhBAFRi4+B0vMJUwgfrpLZZxo8ZX6sVRj7dG3yggOvpBByPpXtfEY4?=
 =?us-ascii?q?P5JeGm9KSnN0Eilocz0AuKXw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 14:40:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707399607; x=1708004407; i=markus.elfring@web.de;
	bh=XZntdYjyJ8JpYsB+rjo9cnKT1bx8ZigglsIkzGs3z7g=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=DlXHybQUkQvYLiZ8HOY3mOUAwtgncV2JrwG+Srpf1uKVvNpoCBcpFyB4NaDw76yB
	 2oMHufYEKFz2j6R/EZ9ZRaSS+117V0lN1UyiRrOGFNuNov0j8VAUB2YNVrVY6PexB
	 z2/tZQHJCIB9DeQq3HaWZv3eylCVV0mKyN1xuNv8DemfvcC9r0y/XZFog1BvP/1NN
	 VDj//j2ruLA86oB+8eTLEgKhsDDGq93sogMnSbBFG+GDputkZhGk0fzxiHZYHNGBM
	 14gVGf6jcih8vDJP2H1Z0LH2SRhLfo4CZsoZ04AGdc4JhVqKKUX0InbG5gsRxwiuz
	 wK1GEkcSHMSRfpc3jA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4vRm-1qooCJ2aMG-010mzZ; Thu, 08
 Feb 2024 14:40:07 +0100
Message-ID: <22f84f21-9780-4c75-81a4-c97ecf0d1a21@web.de>
Date: Thu, 8 Feb 2024 14:40:07 +0100
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
 <55ea3e4-8ef8-b457-ea92-9d612ba9d943@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <55ea3e4-8ef8-b457-ea92-9d612ba9d943@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ha7nieoIFycWk2NQ97yTty0EN0lgOtpQgCKsTjiQM4RfkRK1nQV
 EF3EOr+b5Bjp1571/8mlYVQL90KRXy/bv7GLSft23IYxCncD7XIq6Hr4wK/So55/OdbUBuL
 6uA22ws8PaLtIZBAhHe44pmPLjSITQu3xp2wQ9HC4wsImAB9tiU3eWEAtdn+rK9FOj0OQOV
 AIX85lR8To1r64WrisMKA==
UI-OutboundReport: notjunk:1;M01:P0:wtR434QV5xs=;3nGDJiz5OQf5NCqupZwkaVn9Hsy
 HodTHo8enpLsR/suy7pwc6NQwK2vmJwhvPoW7q1pV7ENLvI8z+zYjcZztNuSkeDNuKt65QSTB
 XqYISYFPqcnuN0GZHNrN3csYlzT3fRJtGOL4jEdLoq49t1RuoNoqKpK5mGsmJ0NOowu2bvqjJ
 SdRNrKhHlgqoYDwot0wM08oAFiHAdwehSGtdQ+i8FKlVApMGqPdN2rWkE/kvfMjlSA0JJ58aU
 E8XEiKRVtGtqJzvtJtPNnCBKw6ishHq0VpR1gUVS76+4cSF0TtUCDXQzxZpo+TfmpQGK7VFKq
 s9mQprpzCOdBkLUveoI6xGn5XjskqihVZ8Yng272GhscwiLQ3sh4/HzHCasCQPEethPdZlOol
 G7frFhoPAH4cSPogd8H+4qv0cA18xL1A3+Hvw/DKNO3Q3mNycJGK1rd9cEbN8gFRMc1ZiT9UN
 NQz37IJqMIMoagCCvpY74iPxMRVPVs/Z6Ix9MrRA0WvKoz7zU8IM5xqzakSsRgNIz1lrr5KJW
 S1/H9pg6WIzgD1KGfczen1MvoOlb8lMCEjJi7eq9KbkDlir8rV05t11UgmFAb642qa6iIpYEt
 V1mnIJi/0s5804936l0HHi6l0lWSizWM0CAg9L2d5M+4ggri5MGgA9EgUXfv/jocSLGxPwdNo
 vunFweVt6DY37weE4HZrKJEMcaPLRqPD6x+W5nJ9RImyx6mu02EkNTp46ycrsOnZCvaw/naYT
 NegCTK2FDxISYH5mfdukk5L+jCXDfRzfp5fKyaqC5tw0nR5Jqg0vYiYTgj3YQVwXWxGR1zf3P
 buAzveOcuD3CUbIXrcOsz8O40v3HmbUPBy1hUxwpXYJ9s=
Subject: Re: [cocci] Improving support for code positions with opposite SmPL
 dependencies
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1521
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/22f84f21-9780-4c75-81a4-c97ecf0d1a21%40web.de>

>>> How will the handling of  =E2=80=9Cif =E2=80=A6 else =E2=80=A6=E2=80=
=9D constructs evolve further for SmPL code?
>
> You need to figure out how to put the two cases in the different branche=
s
> of a single disjunction.

I got the impression that SmPL disjunctions would not be relevant so far
for the discussed test case.

Regards,
Markus
