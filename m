Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0032C02180
	for <cocci@archiver.kernel.org>; Wed, 15 Jan 2025 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xysvE2+Pd3NPjxmT5LHO7hfXcnRKvboAW1Cs8yMoUW8=;
  b=DtcTq9FTObcrhXZZe4EB2K/YC3U9nsO/CXXxC4Znu8U+H/1F4Tadnj+s
   c+fTw4Ubv4Igr/cL5Je2LLG5BhhZuh2SXfEzBCqseQHaoKI0WBF63qpKI
   J8gG7z4BbJHoOmV7a6sT+GRoEh2gRsWsbVEDeZXj4FVSo3L77D3GMkf/8
   A=;
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
X-IronPort-AV: E=Sophos;i="6.12,316,1728943200"; 
   d="scan'208";a="203191057"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Jan 2025 09:57:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 321DAE0077; Wed, 15 Jan 2025 09:57:48 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5ED68E0077
	for <cocci@sympa.inria.fr>; Wed, 15 Jan 2025 09:57:45 +0100 (CET)
IronPort-SDR: 67877839_P7vI+MW+rwQFhR7MBYL8POTGnzbRn3U8cYjy1nNTfpipsK1
 Zjxw9KC+KsnisjCqk5cGPKEPIqa99l89zLEOT4g==
X-IPAS-Result: =?us-ascii?q?A0HvAADod4dneAQP49RaHQEBAQEJARIBBQUBQIFABwELA?=
 =?us-ascii?q?YJDgVczBAtIhFaPTYF0hGuHO4dWiHaBVoF+DwEDAQ1BAQIEAQGFBwKKdAIeB?=
 =?us-ascii?q?wEEMQgOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABQw4KMYV7D?=
 =?us-ascii?q?YJiAYQAAgEDIx0BAREmAQ8LDgwCJgICVgYBFAEBgn2CMAEDMQezfIEygQGCD?=
 =?us-ascii?q?AEBBtpbHywiV4FkCYEaLgGFaoJjAYYmhDwnD4FVRIE8C4J4PoRDg1uCaYI3h?=
 =?us-ascii?q?ExnnwdSexwDWSwBVRMXCwcFgSpIAy02MSWBJwU1QTqCDGlJNwINAjWCHiRYg?=
 =?us-ascii?q?itrBAWBLYI7hEeEVYVighSBZQMDFhABgyh3HUACAQttPTcJCxsGPZxtg3F8E?=
 =?us-ascii?q?zUOyDw0B4I4gWaBYwyfXAYQAy+DcZNTDgaSe5h8IqkLgWkBN4FcMxokgzZPA?=
 =?us-ascii?q?xkPjiGELb5yQjU8AgcBCgEBAwmFRgEBilqBSwEB?=
IronPort-PHdr: A9a23:l+yM9xzjl4ylwELXCzKpwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xWZvKgyxwaTB83y0LFttan/i+PaZSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pDdfglEniexbLNwI
 Rm5sAndqNcaipZ+J6gszRfEvnRHd+NKyG1yIl6dgwjy7dqq8p559CRQtfMh98peXqj/Yq81U
 79WAik4Pm4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WSm+7
 6puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQXNNUttNWyBdB4+xa
 ZYEAegcMuZCt4TzpFUAohSwCgexGu3vxCFFiH/00qIm3OosCh3G3BU6Et4SrHjYstf4OaEPW
 u611qnIyjDDYutR1zjn8ojIcQ0hoeqRVrx/dcrRx1MvFwLDjlWftIfoODSb2f4Xs2iY8upgT
 vijhWEjqwF/uDivx8EsiobSi4Mb1F/L7j91z5srKtChTkNwfNGrHodKuS6AK4t2Xt0tQ3tuu
 Csi17AKpJq2cSgUxZk7yRPSaOKKfoqL7x79W+idPTh2iG54dL+iiRi/81Ssx+3yW8S231hGs
 jZJn8TRun4D1BHe9M6KQeZ+8Ee5wTuDyR3f5v9eLUwqi6bWKYQtzqMwm5YJvknPBiv7lUrsg
 KKYa0ko4Oql5/j9brjpu5ORMZJ/hx/6MqQzgcy/Hfo3MhITUWia+OWzyqXu8VH/Tb5XlPM5i
 LPZv4rfJckDpq62HQtV0oE75ha6CDemzcgYkWMJLV1bYx2LlZXmNE/WLPD5C/ewnUisnS91y
 /zbILHtGIvBImbBnbv7YLpw61RQxQUrwdBa/Z1UC7UBIPzpWk/2sdzVFhg3PBauw+bkFdV9z
 ZkSV22LAq+XKqPSsFmI5u00LuiCeoAaoyzxJOU76PL2i382gkcSfbO10psPdHC4AvNmLl2Eb
 Xb0mNcODX8KvhYiTOztkFCNTTlTaGquUKI9/Tw7E4KnDYLbRo+3mrCB3SG7HodXZm9cEFyMH
 23oJM24XKIlbj+JIsYpqSYFS7G9UIZpgRi1rg7kwqZ8BvDZ9i0RqdTo090jo6XYkho59BR1C
 d6c2ieDVTJahGQNEho/xqNiugRQzlmZ0K53y6h9HMZQ+ugPfwM0L5/awMRlBtq0Vg+XLYTBc
 0qvXtjzWWJ5ddk22dJbJh8lQ71K7zjG1iuuWPoOkqCTQYcz6uTa1mTwIMB0zzDH0rMghh8oW
 JgHLnWo04h48QWbHIvViwOBja//UK0G3zPWskqHw3CPuk5wTwN6F6nIDjgEfkWDld3i/QvZS
 qO2T7EuMw9P08mHf45DcN70lhNrQPn5OdLRS328kSG8CEXA3auCOaztfWhVxyDBEA4EngQUq
 G6BLhQ7Dzy9rnj2CTtzCRTwbkmq/eQWRGqTaEgywknKakRg0+Hw4RsJnbmHTOtV2LsYuSAno
 jEyHVCn3tuQBcDS7wxmNL5RZ98w+jIlnSrQqhB9M5q8Lqtjmk9WcgJ5uFnr3gl2DYMImNYjr
 Xcjxg5/YayC11YJezSd1JH2crrZTwu6tDWmca3LwRfz1NiM+6EAwOs1oRPvsUDhF0Yv9Wlmz
 8gAy2GVtd3BCAsfV460U15irUEg4euAPW9kusWIhhgOeeGuvzTP2swkHr4gwxekJJJENb+cU
 RT1C4scDtSvL+ojnx6oaAgFNaZc7v1RXYvuev2Y1aqsJOslkiihiDENxYln0V+XsQd4RPTJ2
 Zkt3PySmAeKHWSZ7h/pooXslIZIaCtHVE+20yv5H8h8YqNofIAEIXijKYu7y58t4vylE24d/
 1mlCVQc3cavchfHdF3x0zpb0kEPqGCmky+1p9BtuwkgtbHXnCnHwuC5MQECJnYOX256y1HlP
 YmzidkeGkmudQkg0hW/tw72wK1SpaI3KGe2Iw8AWiHsLHx5FIa0uKCDZcFn954i9ylaGOixe
 lGVTLfhrgBSiXq5WTEEm3ZiKnf28pzi1wR3kmecMGp+oB+7MYlryBHT6cadDf9d0zwaRTVp3
 DzeB1yyJd6srp2fk5bOtPz7Vnr0DMQJN3OxksXZ6W3ntggISVWlkvu+m8PqC10/2C7/jJxxU
 DnQ6Q37es/t3ri7NuRueg9pAkX94ox0ANIb8MN4iZcO1HwdnpjQ82AAlDK5FNxB2r/lKlcJS
 yQKxdH9/wXvnkFuZCHspcqxRjCGz81tasPvKEYfwCEg9IZnDKmO7bpLtTR4qBy0oEiCBJo11
 idYwvwo5nkAhugPswd41SSRDIcZGkxANDDtnRCFvJiu6b9ab2G1ff2sxVJzyJq/WaqarFgWC
 xObMt8yWDV95cJlPBfQ3W3vv8v6LcLIY4tbv0+RlArcyfdYItQ9m7ID1y9gJH64rXMi0fEyl
 xAowpyw+oSKTgcltKvrBxlFKnj/YN4V8TyrkqtU2Mqbl4n9G5J8BnAAR5H1SfHuSTsUua2hP
 AGLdV904n7JHL3CAUqU80xhtWqJSpmtOyjRL34chcNrQB3XTKBGqCYTWjhy3pswFwTxgdfkb
 F88/TcJoFjxthpLzOtscRj5SGbW4gmyOH8yT9CEIRxa4xsnhQ+dONGC7u91AyBT/4Gw5A2LJ
 GuBYg1UDGYPEkWaDlHnN7Oq6JHO6e+dTua5KvLPZ/2Jp4k8H7+Qwomz14J94zuWHsCII2UkE
 PAxnEZOHDh4F8nfhzQTWnkXmibKPKv57F+3/ix6qNz68ey+Alu1o9HVVP0LbJMzqHXUye+ZO
 uWdhTh0M2Nd35IInjrTzaQHmUUVk2dofiWsFrIJsWjMSrjRk+lZFU1+CWs7Oc1W4qY7xgQIN
 9Tcj4a/87dijeMuTXpBW0bgnM6BesEAZW2wfgCiZg7DJPGdKDvHztuiK7u7UqFVhf5IugeYv
 DGGDwn8Mz7FmzSjBHXNealcySqcOhJZooS0dB1gXHPiQNzRYRq+KNZrjDcyzNXcaVvVOGRaP
 TUuKiulT5WV6j5ExOpyESpN4yg9RQFhszmU5a/UJ8RO2cY=
IronPort-Data: A9a23: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
 FU=
IronPort-HdrOrdr: A9a23:Z92kCa8HrMFWw+Y4xyhuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re+cjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:9LRhxG2DAfGSRcEKM6/u7LxfMdAndlfU7EvrOE6yCFczY6WrbwbI0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AYORC4A+9v8BrZSr5vtJzDr6Qf/xv4baTMmUMqo0?=
 =?us-ascii?q?tg+2/NhZ5CxPekyviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,316,1728943200"; 
   d="scan'208";a="106385875"
X-MGA-submission: =?us-ascii?q?MDEqV2LhaCcGXC8aO5OEcnVdFJbyC6o4bgvHw0?=
 =?us-ascii?q?KQO7pRbcCOcrate2TxoI91YRlKSlsTaudCr2dimTd7txtAfagntIzOkM?=
 =?us-ascii?q?gtNgxpCf1iFk3fv04dZ48IzokfWN+u07792kNGhvljlOl/CaGjxNtr5l?=
 =?us-ascii?q?oZ3Sgn9budCC0vozQUpoi6cQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 09:56:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1736931384; x=1737536184; i=markus.elfring@web.de;
	bh=xysvE2+Pd3NPjxmT5LHO7hfXcnRKvboAW1Cs8yMoUW8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=snk5GV5eFTu0TgoNshzI2eiLTbt/BF7Tv9+RbUaIewmd1GS9YX4K2eu9uo83JezW
	 cqxv3rsJ1O5B88NH2Q8phYvNsGD1vbStpyrSP7b3alauyZ1idLAhBue7wVGjMrLhy
	 DDPU0+8yYKI5NBT/P8jPFWYSiG3zHdW6z9oQoaMd7aDTo4kEZzt5oSMn9u9lNG0zz
	 OkSTRTW011t4VQfsj8vGulAp9D2GH028dgeugs/d1O+JZLNa68pEqAvtY26k548Nx
	 IM7b0bJ3pgkwqyuvfh+HVXsZNv8wbg00NAFc9rnJm7sEEGvnioDmsLitkeehmHJCd
	 wbiu8PlIYbJ9hWhgIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.41]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3Euv-1tYo943ngr-0057wP; Wed, 15
 Jan 2025 09:56:23 +0100
Message-ID: <00305913-302b-489b-b9ed-e2e06618d60b@web.de>
Date: Wed, 15 Jan 2025 09:56:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Anusha Srivatsa <asrivats@redhat.com>, cocci@inria.fr
References: <CAN9Xe3T2LjcD9Xr8vAGQWu5MUvVjr-eEaMhB-JauL5DW0aA9QQ@mail.gmail.com>
Content-Language: en-GB
Cc: Maxime Ripard <mripard@redhat.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAN9Xe3T2LjcD9Xr8vAGQWu5MUvVjr-eEaMhB-JauL5DW0aA9QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Txe/Q+AAqHgeXOPZk9nL2w3byVmXUPMsjz28QJaawFMifKu+Jim
 iLDsCDBCQdjN+XROEe3wGSPyEtnnU0pUT4+LICIazp1aH6s6CUMo4qybmkyd1yEzZCsv8+F
 7nZ0muxNH/42BBrrDwj0hkG3x4fmMNoY8+PRfi+/vnW4EMFAJJrdQEBRTP7p0AQMup407Gt
 C+zMR2lPFLaTwXxs5gPoA==
UI-OutboundReport: notjunk:1;M01:P0:ThOZh4Za2Os=;zwqyjnwifg9VF8HI8vE96FL9QIr
 MBT7oGV0oP+Dg2gin5o06kOT/qHMkMQ2Wm6FCL8O+/TYzqgvDbElLRRDscfWdqkVnJFHXT/F3
 RZFkewG+YsTzcAsTv93HaN6w74SwVzymEis+gKZsV/gjmBAyqV0j7a3KZVdg6WEvDS3/e2mnL
 iGEuHxl3mA+Ln++JcB5D9s8UcglsShal6f3Eqi8MpcDbgvZpDEh81y17Akx1Qrdu4jHc43NyE
 ShBuvvXGiVW7Aje2H6KRvkW/4Py/JvVpjCybhOURAqjtlOzHVXnmwYUbRqdAzmvbAoasz2dvZ
 0tnwn2Cum62QdrEzoxA/Ohk2X/ArIv19IHko6Ei4UjrbXYc+uHJWs3m9jn4JCdwfZte62o0Oh
 T1Fd8RAzk0JinhRov7PcLrx5yyGUWRRAFHmd23mHfgDVx4q1AzV0cecnXADZ82zrIHBJeMCXC
 PrRL1A2y+MHS1r28vm+RK61OAagWrcQVikoCKW6ewpQKGR/f4Zlyn9R4usZYsDgMUaPfLY8FN
 yaLTi1sr0v/z4zbUjTuSl47PSoaQ+DnQhluAi6NFVlxPUN7tyTs9e9XTbLbMEFBJkLxjdGme0
 iLdzxnKb5bjA3Ur6nSmGBTJTjPSoW6Vmh8o8H33HRnqHtIKaBpIzhZo6jYTKAGOzIREB9AoG3
 Tm/Z3gqv6p7kFB431oY0E6yur+hSQJsbtcyKF57q5YFIMrRBa9Yegb1P1wHetwMcqXbObcKyM
 NQh7Tq4kGRAEob+it7QGY42x/UBuFF/okCT3vvS5eSapwetAXgP0YFT+Sa2uvXyzqwoEdpimD
 KJSKT7FBMQQLEfXys9hQmLLL7hq1pF9MEnN2MY5NlIWRN4gGyD4ITAWSPpBor85XzJvcsM3tQ
 B0eQmSgFwCthnShkMintgYePk9ySzwPCZFQxojkZpaVQPVWkF9Hlv66GRbO422Q4dwadcNLW/
 ARDJ5bpwbZQv80Hs4UQ9GyDAftxPVknqRjxsuMAT/WkjTvTAIkeNAPUVLUVf4XkoEOkJryJsa
 AUUr6768rTE09kxUc1cULOZmCsj7oOESA9YQ3w2izuyAeEXoCnjFUNSfEf9LZUA9ln3r6lv5P
 E4pxrVFUg=
Subject: Re: [cocci] Ellipses usage in line addition
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2209
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/00305913-302b-489b-b9ed-e2e06618d60b%40web.de>

=E2=80=A6
> lexical error: invalid in a + context: ...
> =C2=A0 File "mipi.cocci", line 9, column 39, charpos =3D 298
> =C2=A0 around =3D '...',
> =C2=A0 whole content =3D +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);*

SmPL ellipses indicate generic source code placeholders.


=E2=80=A6
> Would be nice to know what is going wrong with this approach.
Such a transformation approach is generally improvable.
How do you think about to increase the change precision here
(also according to the SmPL construct =E2=80=9C<+... =E2=80=A6 ...+>=E2=80=
=9D)?

Regards,
Markus
