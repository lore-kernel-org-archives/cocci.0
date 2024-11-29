Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260EAD6EC04
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2024 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XBduW3SM3+NMMILO/IqPvm90LNGwHqgc69m7I7FFaM8=;
  b=QR3djuGXi93A1i7X4QCPHgrntyzodVDyyusDfIzw24i5ZM4mz/1eLKbW
   LOLyl8vGRSvRiyyh8WMzDsSVi/tTVpELRI8GfG44SPwqviIXzjZzsxPrZ
   yBaMSW/m7SJmfJ+ao/kgbKOQTtHBzESCZc0V5v0pMvh5Kwg0HFncfg6l9
   o=;
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
X-IronPort-AV: E=Sophos;i="6.12,195,1728943200"; 
   d="scan'208";a="196509674"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2024 13:39:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B0DCDE013D; Fri, 29 Nov 2024 13:39:14 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8A2DEE00B6
	for <cocci@sympa.inria.fr>; Fri, 29 Nov 2024 13:39:11 +0100 (CET)
IronPort-SDR: 6749b5ee_WL91IAM7PWL+sIifYFwvdUuaaSZ3+2/vYL3VeBR2+jq3W6g
 3hF+ZUOJeGVZv1QUjBP79qoKIcrQq/znppLgJOg==
X-IPAS-Result: =?us-ascii?q?A0EhAACLtElng07ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQgMBAQELAYJDYhsGVDMEC0iEVo9NgXQthD6PEYh1g1QPAQMBDT0EA?=
 =?us-ascii?q?QIEAQEDAwGFAAKKYwIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABAQEhGQcOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQJHRAIBAyMdAQERJgEPCxoCJgICVgYBF?=
 =?us-ascii?q?AEBgn0Bgi8BAzEHDQaxM4EygQGCDAEBBoFYQdhCHywiV4FkAwaBGi4BhWmCY?=
 =?us-ascii?q?gGFaTuEPCcPgVVEgTwLgng+gmEBA4Feg1uCaYJEgTODXCWIGGiKb5EmUnscA?=
 =?us-ascii?q?1kyAVUTFwsHBYEpERAsAyJuaU5/gTYogSkBQoEVgTkvGyELXIEpfR0UBhUEg?=
 =?us-ascii?q?Q4FNwo9gkppTTcCDQI2giQkWYJNgSUEBYNpgQuDXmUvAwMDA4IRgSuCSV2DC?=
 =?us-ascii?q?kMdQAIBC209NwYDCxsGPaFQR4NEaFmCBAkkkyqycDQHgjiBZYFjDIoolTIGE?=
 =?us-ascii?q?y+XQw4GknqIL5BMIo1gmyiBfSSBXDMaJIM2TwMZD44hGYQUgQvFXkI1AgkxA?=
 =?us-ascii?q?gcBCgEBAwmFRgEBjECBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:x7X4bamTDJlcbXHz8YNt3IHo5gxOIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIXW2/QaPuNZ2rwfoggbNyy8RsAvJ7VztNnG1Zury01RFtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTrSs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82Ayazh8B56r8ks14K2r4mJA5zTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN1MXUJvIdwnq918Ln9z0
 6BBLzcrf0mq0rfeLLKTEoGAh+wmK9T3epwSsDdswFk1D958GM+FHP+MvI4Cmmhg7ixNNa62i
 84xTDN1bwnbJTBLNE0WDp0Wg+qiwHXyG9FdgAvN//tmszGPlGSd1pDMNvjqZNiHa/kE3U/ft
 iWZ40ngPTYFYYn3JT2tqS783rSfwksXQrk6ELSn//puqE+Sw2YJAVsXU0G6qL+3kCaWUNVUI
 E084TsrtaF09UqxT9C7UQfQnZKflhsbRsYWDOAwrg2AokbJ3+qHLkpVTWddOeN3j8QZWwEMi
 gaOmPX4XBU65dV5Vkmh3ruTqDqzPw0cImkDeTIIQGM5Dz/L/9tbYvXnEY0LLUKlsuAZDw0c1
 BimgUADa1g7iMkWy+Ok8FqBjz/ESnn1ouwdt1y/soGNtFsRiGuZi2qAtwKzARFoct3xc7V5l
 CJY8/VyFchXZX13qASDQf8WAJai7OufPTvXjDZHRsZ6rWT0qyH7Id4PvVmSwXuF1O5bKVcFh
 2eM6GtsCGN7YSfyMcebnqrqUJpxnfSI+SrNDKyJMYMmjmdNmP+vp30+PRXAgAgBYWAtlqc4I
 t+AfK6R4YUyWcxaIM6Nb75Fi9cDn3hgrUuKHMyT50r8itK2OiXKIYrpxXPVN4jVGovf+V2Nq
 76y9qKil31ibQEJSnOHodFJdQ9WdidT6FKfg5U/S9Nv6zFOQAkJY8I9C5t4E2C8t/UFzLX77
 TumV1VGyVHyo3TCJE/YIjpgcb7jF9I3534yISVmbx7i1mkBcLSfyv4VV6I2Wr07q81l7/p/F
 Mced+u6X/9gdzXg+hYmV6fbkrBMThqQqDyrAzuEexk6Jp5peBzI8ITrfyzp7yg/MRC0vsof/
 Zyljx3XcaMeS15cDeLTUvaOzkywj1cZiuldT0vFGfgNWUTOoaxBCT39se8zGO4IcS78/zq90
 x2EJDspvs/PqJ8R3PzWo5ubvqGVE+daNWhLLVnxtLqZG3HTwTu+/NVmTu2NQwH4aEr136eTP
 cNu0PD2Naw8rmZg6oZTPe5i8vMj2oHJubRf8wVDGUfLZXSNDpdLACGP/etLh5136o5pgymEc
 WPRxYACIpSMAt3vL3AJLgl8buij6+AdqgOP0dsLenfF9A1F15vZd35NPiu8qj1Xd5p0F4IH/
 d0PmuAr7y6Htx57Fere0w518TyXI20iQpcXkMgQILXWhzoBznBAZp3hCRHK3qyfVuUUMmQXJ
 m67uamToZVd2UvITFQrH1fvw+d2pMoDqTJK/nA4NnWLndvJ3ME2+Bhr9RU2UQVn4RFV2M1jO
 mVQFhNUJIff2xxKlcR8T2SXNAUZPyKg+2v10AEvhkDCaluBD0jhDTQaF76W3UY792l8QGBqz
 IuAwjy4bQewLdDD4CQifGVE9drhdIVV3S/fkpmFG8+lIcELUQD9iPXzWVtS+grVOuJvtkjpv
 uIwwf1Rb5f8Pisuo6EWLYmW+LATaRKcLlx5XvBT0/IVLF7YZQ2N92CCG2KpduNJAs76w0uyJ
 shtB8BIDjCV9iKFqBIFDq8tfZ5wutMU5+Q5R7C6Hl5e7oOjrQdovqnAqQn4pmsgGOt1negHd
 4j+SjOlE06rv0VypVPjlsd+BzeHUYE2XzGkhOGR28cVJq0Hq9BpIB0T0KPrnnC7MzlH3hOzv
 SGYVZD30t5N9IVItKnvG5VlGA+bB47SVuOJ0QbrqPVIT4rFHvnvvjMviGvMHlppL4pKfu9oh
 5GhjcXS3n6ZjI0pUmvcpYaNJ5NJ6eq2QuBTFMD9d1teogevR+7u5EEl112jCJkUju5Y2Nard
 zG4ZOS0a9QRfdVXn19RSipGFiciG7bFVbjhqQy9vsazJEAkiyKfF+ye9FjtcW1/XQ0LMcenC
 gbL5tCf1uoBp4FIXBI5F/VqBqFjG2DaWIwkSsbQsAeJBWz5k3KAvbrfzSAb0w/pMUXdMsjG4
 sPifCPcJSSC4PSCiJkTtoFppRQYAUpsmeR6LApX59dyjCv8F2Ica/gUNZIdEJxPjyjuz9fCa
 SrQaHc5QzDINdienc4QPPy4NuteOgAPBjs9Djku4l/SdCq8Qo+NaFekGuGM/F8uEgYPDsn+Q
 T3dxpE0Fge8yNdlSI7/I9Sl1Px/yKqyKm0goCjAfg+bP/raKaoH3jptEWKhkMAB/97lzC32G
 IT+eYyIrIxXh6I8/QaMtkO5wC0kgQ4=
IronPort-HdrOrdr: A9a23:JnPEM6kKTcZdbXYiUQGDw+ZfhKXpDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE7Qr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK7/oSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:uYDsdWGCJj6U1HumqmJFpU1NBpEaI0bW42ntBRPhDmFPWeS8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AbHr32Q1HDTVtllMtOmMOdqeskzUjwqKMN14JnLs?=
 =?us-ascii?q?66oqNcjw3ZCuwlQuQXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,195,1728943200"; 
   d="scan'208";a="102998140"
X-MGA-submission: =?us-ascii?q?MDHAcKUTUXnLv/66tV2RRNueYtNgiwVfIXAJHR?=
 =?us-ascii?q?0DNTxK33RzoqmdecrZyYIqhTGtD3YzakybZn6CJsBkRkfj8FEZBHmBew?=
 =?us-ascii?q?VdjUzngSyPMHJ6QMJIZDx0Aq4c/TQUmhKuO5fTyb28FEQkrklHOcHR5f?=
 =?us-ascii?q?F9Ax1zuGXAhmxDKLP3FoLw/A=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 13:39:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732883929; x=1733488729; i=markus.elfring@web.de;
	bh=XBduW3SM3+NMMILO/IqPvm90LNGwHqgc69m7I7FFaM8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BeOA8iYdWx7gWqN/WcujJEk4fTqdjx95sW4D9ihtxa+OovXF832fo1GaPKEwftKD
	 ZpMN1Qbhbslceu7Ouk0GOf+qM0xuyiZOpel3tUS6mgqWwT5PNsHCZL4qjHtrJ8zgD
	 D+atgd6ApmZ/6itX0kEX5g4wvI7wg6bt7NeDd2CrbvVAcmTxkO1yvx/oMGSNnCk1C
	 K6no2wa9Ia8em8b7VMqm/PTUNhqNythmC//yOdmazzuWrqu6GbOmMKohSl4+dvGqa
	 pGRF6mI8x0wWZvgV5u+ircbuZeqZKwlr0RqUCM+rCfHF+0PIjeS3xX14vw09Z1SkQ
	 FHgP52CXoij/ZIvhUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfol-1t6rmW36A1-00TrwK; Fri, 29
 Nov 2024 13:38:49 +0100
Message-ID: <b30c7227-c596-4980-aa46-a75b1d429354@web.de>
Date: Fri, 29 Nov 2024 13:38:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 linux-security-module@vger.kernel.org, cocci@inria.fr,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Serge Hallyn <serge@hallyn.com>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-11-cgoettsche@seltendoof.de>
Content-Language: en-GB
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241125104011.36552-11-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:74y8QeqmuatnpqkylLeQMkZwt407mLqdiWTnlCxHrle9Og4CK9R
 DGqAzLJ8BHp/JAsXJi3ePht9owxsEcnR+ZRwB4if4h4w3rL4+uzJ1AFJ1CKpqm54TFEHoP0
 TlpVnqTxdnKqOlOzN6rD+KzJWo14sGOVTkJpJfeogrvFM1LcBDYAzTlJJGqUg8xTcohGLlk
 REaX1gTQU/yjzayGAS6jQ==
UI-OutboundReport: notjunk:1;M01:P0:KDhbbpCfHaY=;n/DXPrV9jGKBnLsK7ZRYQ6TFV8y
 VX29y5mEjbtc2JE6T6k2A9gio0nOxfTk3Jq2xoBM6VB/dlNoLtSvMaAvdHmtK//vPLoiaNN8C
 G8iXusnZBX5xch3DrF4M+6D+P3AAl00SR/Z/KKGACBuZvr+h4FO9os7icGG3OTrpyTAF/R+yV
 nUZZVcrCmjusA6SD83PCo0HsY+s9yDznDPeZ+9v5Uj9fo1nxinqavBYaGS3lfeJ8EQHZrFVs3
 TH6IjDLeHqE6hpIiqudsGbTCfu1iLiCR+xb51lBP7s2GeKdtpIy5wedfAl8IDZJNsZtwNkpY/
 UrwSCD6tNAi71CAAjDuIv1Xe1VCG9nPVSCu7pxxzcu4Cq1mMnRMPWVNLrjBxQEY5SpICXHchX
 O+StCL4/Rr/PoPszUxQIrQFhrYEjn2c4JY4OpQhJp4mFnCZbICuJWWRAjk/y1nEopcjih5Dhm
 YE9PSdTslJk6LklL1QjIsjUJKVafsJ+Gc+tzj7mI3hFGzlASQ799Mw3UBIlsTepwogAzuXRAN
 Jiy/wfNLoFFQgVXEWD3u83lOoZDJ0dml9tCWxYSG+BDxZh6pd6W3NKW6+N0aMfZXAr19H2L06
 X5MV8sYnz4GnbwdXw+RiEuXK2i5MiBsHtLOL8JmVPnzVDZYzYz0DBhmj2sGwcjMMSQX6GdqzJ
 CypFaO9qfr6ZTJtSo6JVnwmyGP1GzgWolbkWYJJXm2m5jDeuHf2h5dY5/ZJ2tLLliZkJpE15I
 N6Qk6Vwvsmkz86xNBsytrx1csve3mPyN+xvYxigGj6ngzlAVY/WiKT3ZN0JMlA0ZxFlD9nWuu
 JuCVAVOR7xzWzjggZRpbNgw/p7KLarcTN6QBNUj9MHP3r3GFmB2/vyzd0mwEk2zf9zrD8MoQJ
 H7PJHUxDAlURDmDh455Y6J3cfU6zLl4A5VPpyNoePr5EPcYAdlI8jAsWCGH1yeNjEPJZ/p505
 Vx3JpGHxjA89ummM3Slgaj/VctxeoVLGnoRbqZH45ucdOcz4FPnKcrkcTcVYmJ5fZEOvU3idj
 B2zlver55TBP87Lv0sKTaRNXZESJoDl2FQFuUHS0omnQjt90vyRaFF0bR6Ct9/6JFaj7wXjil
 ETmITs9oE=
Subject: Re: [cocci] [PATCH 01/11] coccinelle: Add script to reorder
 capable() calls
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2139
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/b30c7227-c596-4980-aa46-a75b1d429354%40web.de>

=E2=80=A6
> +++ b/scripts/coccinelle/api/capable_order.cocci
=E2=80=A6
> +@ depends on patch@
> +identifier F =3D { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
=E2=80=A6
> +-  F@p(EL) op E
> ++  E op F(EL)
=E2=80=A6

It can be amazing how many source code places can be handled by such
a transformation approach already.
I hope that corresponding data processing requirement analyses will trigge=
r
further collateral evolution.
You propose to use the metavariable types =E2=80=9Cexpression=E2=80=9D and=
 =E2=80=9Cbinary operator=E2=80=9D.
These filters have got the potential to match more source code than it wou=
ld be
intended here.
The length of computations behind a selected operator is not really restri=
cted.
Such expressions can probably contain varying operator chains.
There is a desire to split the affected code into subexpressions.
Special development challenges are involved accordingly.
I find it safer and more promising to use scripting interfaces for this us=
e case.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/620463b4bfb8bdc5c99da=
bfdfa337b34cbaa9ef1/docs/manual/cocci_syntax.tex#L655

Unfortunately, required programming interfaces (for OCaml and Python) prob=
ably
need significant improvements.

Regards,
Markus
