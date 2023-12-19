Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BBFC41535
	for <cocci@archiver.kernel.org>; Tue, 19 Dec 2023 15:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qzNCiRbbod5kTHYyIwLXnRVyE1xiT8yVYkVoaL3ZI3c=;
  b=BaEUrKco9DXCA7iUi2AJ0I5WH7S1JakwOSTGuGBxiLWoc5RWE1m/17I6
   QgZbYxefCAxUGUlFlzQcqZO1TKWpOri2vW3+ccsO2LX9NPDf90EMpZ3YO
   4i2tnUEMXKjeHPJ4bAzLxywOifAK+xTCCNkXu2f81XBpIQz4Qn7SPOES9
   Q=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,288,1695679200"; 
   d="scan'208";a="143157053"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Dec 2023 16:36:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5BB6EE004E; Tue, 19 Dec 2023 16:36:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5D102E004E
	for <cocci@sympa.inria.fr>; Tue, 19 Dec 2023 16:36:21 +0100 (CET)
IronPort-SDR: 6581b876_HNWou/gSJMEopKUh7gMitHC/+JJCTBWxfis9ZX3ipuD24uW
 voxhjRm0iPufPsCvur9/pudL/XNNrynnfDwimsQ==
X-IPAS-Result: =?us-ascii?q?A0HvAwDlt4Fl/wsR49RagQmBT4I5B4FLMAQLSIRTj0GBd?=
 =?us-ascii?q?TCEO4c1h0yEa4QEgVaBQD4PAQMBDUEBAgQBAQMEOIRHAoc0Ah4HAQQwCQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECgQYThWwNglwBEIEMgR4BA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEXAkdCBiMdAQERJgEPHwEFAiYCAlcGARICAQGCf?=
 =?us-ascii?q?IIrAQMxB64dgTKBAYIJAQEGgmasch8sIlaBYAmBGi6IGwGFZoNAeicPgVVEg?=
 =?us-ascii?q?RUnglJvhAqEFIJog2aFNwcyghyDUJIHfQVBcBsDBwN/DysHBDAiBgkULSMGU?=
 =?us-ascii?q?AQoIQkTEkCBYIFSCn4/Dw4Rgj4iAj02GUiCWhUMNARGdRAqBBQXgQ5uGxIeN?=
 =?us-ascii?q?xEQFw0DCHQdAjI8AwUDBDMKEg0LIQVWA0IGSQsDAhoFAwMEgTAFDRwCECwnA?=
 =?us-ascii?q?wMSSQIQFAM7AwMGAwoxAzBVRAxPA2kfMgk8DwwbAhseDScjAixCAxEFEAIWA?=
 =?us-ascii?q?yQWBDQRCQsoAywGOAITDAYGCV4mBw8JBCcDCAQDKykDI3YRAwQKAxQHCwdIH?=
 =?us-ascii?q?wYDAwMCIQMLCQgDGSsdQAIBC209NQYDCxsGPgKmEnyBDoJ2xHg0B4I0gWCBY?=
 =?us-ascii?q?QyfKgYTL5ckDgaSUS6HUIp+hU8gqD2BYz2BWTMaJIM2TwMZD45Yg3OPR0A1O?=
 =?us-ascii?q?wIHAQoBAQMJhUYBAYMmNIFBAQE?=
IronPort-PHdr: A9a23:Z5oHoBHri5jE6kSev+rSeJ1Gf5pGhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k33BmTBN2QtK0MotGVmp6jcFRD26rJiGoFfp1IWk1NouQttCtkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhEmjmwbalsI
 BmrsQnducsbjIl/Iast1xXFpWdFdOtRyW50P1yfmAry6Nmt95B56SRQvPwh989EUarkeqkzU
 KJVAjc7PW0r/cPnrRbMQxeB6XsaSWUWjwFHAxPZ4xHgX5f+qTX1u+xg0ySHJ8L2TLQ0WTO/7
 6d3TRLjlSkKOyIl/GzRl8d9l7xQrg6/qBNjwo7UeICVO+R4fqPBZtMRWG5NUt9MWyBdHo+wa
 o0CBPcDM+lFtYnwv1gAoxWxCgaiGe3hyiFGi2H43aI4z+svHhrL3BA5H98UrHjYsMv5OaUUX
 OuozKfI1zLDb/ZO1Dn68ofIaBMhoeyXXbltfsTRzUcvFxnEjlWWpozuIjSY2OMXvGiB7OpgS
 Pmvh3QopQF1rDiv3MYsio/Gho8OxFHL6z52zJwoKtKmUUN2Z8OvH5RMuS+ALYR2Xt8iTH9yu
 CY80rALt522cSwWxZkjyRDRa/iKfoqK7x//W+icPDR1iG5rdr+hhhu8/0qtx/PyW8S6zVpHq
 iRLn9fNu30T1BHe9NaKR/1g9UmiwTaCzx7f5vxaLUwui6bXNZwszqQtmpcRq0jPAzL6lF3yg
 aKZbEkp9PWk5/7kb7jmvJORM495hwfjOakwnsy/HP84MhQQUGiB5Oq81bzi8lPhTblWiPA9j
 7PXv4rAJcsBo660Gw9V3Zgn6xa4Fzqm1dMYnWQbLF5fdhOIkZPmN0vTL//mFfu/glKsnyl3x
 /3eILHtH4vBImLdnLv/f7tx8VNQxQgpwdxC+p5YErQBL+jyWk/1utzYFBg5MwmszujgEtp9z
 IAeWX+UAqODP63StVGI5vguI+mKa48Yozj8JOY+6PL0kHA2h0cRfa+y0pQPcnC3AuxmI1mFY
 XrrmtoNDH8GvhAiQ+zylF2CTTlTam6uUKI7+j40FIOmAJzYRoGthbyBxD20EodXZmBAEFCME
 G3ne5+KW/cWO2quJZpinyYCWLzkSYYn1A2prhTS1bVqNKzX9zceuJal08J6o6X6kx0o+CM8K
 sOHz2aLBzV9nXsNbzs32r1v5EJ611GP2LR5hPoeEsZcsbcBfR03Otb/1etzC5XSUxjde96PA
 AKpWNipAjEZStM33s8AZFt7F9y+jxfFmS2wDOlR3/axDZI9/6aU/T65GNdmzH3F1eNp20MvT
 MJCMUWli7R5+gyVAJTGxRa3jaGvIIEVxi3Q7y+uyWSUvUdXGFpVWL/GQGtZS0/Yt9X/6WvdQ
 rXoBblxYVgJ8tKLNqYfMo6htl5BXvq2fY2GOwpZ+k+1DBeMnPaXaZbyPn8a12PbAVQFlAYa+
 TCHMxI/D2GvuTGWFyRgQHToZU6k6uxisDWjVEZh6giQbFB6kZex9AQUg/O0VP4ZmL4J6286s
 zshJF+mxJrNDsaY4Q9ofaFSe9Q4tXJOz2HErEpQOpK6LqZtrkETeUJ7shCmzA15X6NHl8Vit
 3Y21ExyJKafhUtGbC+d1IvsN6f/L27v4FawZqSQ1ly2PM++3KAJ5bx4rlziuFvsDU8+6zB91
 NIT1XKA55LMBQ5UUJTrU09x+QIo77fdKjIw4Y/ZzxgOeeG9ryPC1tQ1BeAk1gfoftFRN7mBH
 RPzFMtSDtanKegjkVykJhweO+Ua+KkxNsKgP/yIvczjdMNphjG7liJq5I5n00SD3zVxQKjE0
 tdNwv2V2BeGSyaplE2o4Yj8nYFJYy1XH3Lqk3G+QtQLOesrIsBSUDTLQYX/3Nh1ip/zVmQN8
 VeiAwlDw8q1YV+IaFe72wRM1EMRqHjhmC2izjUynSt6y8jXlCHI3enmcwIKf2BRQ2w3x3LlO
 4uplJY3WEaybg4mvASo7wD2yuIIwcY3Z3mWWkpOcyXseitHW7Gzq6HETspB8pIuvg1IXe76b
 V3QGduf61MKlijkGWVZ3jUycTqn7474kxJNg2WYNH9vrXDddKmc3D/n7cfHDb5U1zsCHmxjj
 CXPQ0K7NJ+v9MmVkJHKtqa/UXigX9tda3ujwYSFvSq9rWpkZH/319W6gN76Ck4X1SHh1t9lf
 TrFplDwb8Hn2r+7PuRuYkRzTAWlsYwgQN44y9R23chY0GNSnpiP+HsbjWr/VLcTkbnzanYAX
 39DwtLY5hTkxFw2K3uIw4zjUXDOisBlZtS8fiYXwndntpoMUv3LquUb23Is8T/a5UrLbPNwn
 ykQ064r4X8e2aQSvRY1iz+aCfYUFFVZOirlk1KJ6cq/peNZfjXKE/D42UxgkNSmFLzHrBtbX
 SOzX544HjJrqOh7PkjN1nLb9YzuPtXdJ4F21FXcg1Lbgu5ZJYhk3N8Dnyl6IiTQuXM/yug0p
 QNj19e2scLUTgcltLL8CRleODrvYsoV8Ty4lqdSkPGd2IW3F4lgEDEGD9P4COilGzUIubH7J
 h6DRXci/2yDF+OVTmr9oA926mjCGJexOzSLKWkFmJ98EQKFKhUXgRhIDm9jxNhjTF/snZa/N
 h4jtndLuzua4lNN0r46bUClFD2F+0HxN3FsD8LCZBtOslMYvh2Ta5bBqLssWXkfpMLprRTRe
 DbCOEIXVydQCxbCXQyzeeP/gLuIu+mAWrjudb2XP+jI8LEPEa/Pn8zn05M6rWzVaYPQZD84V
 6J9gg0ZAjh4A5iLwWxQDXNN0XucNYjF+FDmpEgV5oi+6Ki5CFipvNXSTeEIYJM2oEj+gL/fZ
 b7Kwn8ndHACjctKnyWA3rEb2BR6ZzhGUT6rHPxAsCfMSPiVgapLF1sBbCg1MsJU7qU61w0LO
 MjBi9qz2KQqxvgyQ0xIU1DsgKTLLYQDPn29OVXbBU2KKKXOJDvFxNvyaL+9TrsYhftdthm5s
 zKWW0H5OTHLmz7sXhGpeeZC6UPTdARZo524ew1xBHLLSdX7dlukPdUxgTB3ibw4i3XWNHINZ
 Dhxd0Qey9/YpShcg/h5BylA9i8/dLPCwXzGqbCHbM9P4p4JSmxumulX4Wo30e5Q5SBAHrlun
 TfK68RpqBegm/WOzTxuVFxPrCxKjcSFpxYHW+2R+59eVHLD5B9I43+XDkFAgtJ/CcD0/Y1Ux
 MLOkq3bNzpItd7Zt5h5ZYCcOIecPXwtPAC8UibTFxcARCW3OHv3gktAjLeN+3fTopVw+f2O0
 NIeD7RcUlIyDPYTDE9oSccDLJlAVTQhibeHjcQM6BJWSTHOSc8csp2VDpp67t3wJTzfgbQWP
 nPgIJv9KpkPcJL20QpuZwsi9Lk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:xWvyfqhSrdIGjwLkRHmiUeRtFXBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW2ldAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykcsS+Q2mmF+rgbsby62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:fCja7m9JoJ/VG9dU2m6Vv0QRGeR+c2XB9VTJDFeqV0xVbeKMdGbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AVkSckQ4j1A0ayju/22C8Xb//xox0oLauIk41r64?=
 =?us-ascii?q?jsuOJGidfZW3Arh+oF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,288,1695679200"; 
   d="scan'208";a="143157019"
X-MGA-submission: =?us-ascii?q?MDGadKymagQ6s7jf52q7BmHH9e06/Zpzy9nmcW?=
 =?us-ascii?q?lWHh9uROspoouSqfgX5f8G5agb+88pmH0gI8nluf3y9P9QIvOnPqfyfN?=
 =?us-ascii?q?6zGCTc2SnwTzzpbFVoSTPDNgZVZYdOtE6VOh3pfp0uV9ZlaG/BUqFDIZ?=
 =?us-ascii?q?r5naGgXfH1KCAWNUM/mwEarQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 16:36:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703000172; x=1703604972; i=markus.elfring@web.de;
	bh=behxKfyGna2w4fIuLyZUlD9UgVji5Pzaqh7fdVWijjk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=NdSHAllz2ytmZIT0QQCD69MNm4qSxBOrxg96wlionm7kXZr/joZYDH7INPo3N3+g
	 KoXYVYaKuknbstv0fU3v+mfBgQIbyEDDW8swCkjMzoWeb48bJ7eAcDyYH8hujKMD/
	 4KHfJM37clRxBi0tVFEGCOe0B4R6aGOLKMVddak03dqlFH8yRJVZ2s6Yf6iI3Ragn
	 iff1isB3nGfvsMf8+j8e4xnPaaZC8Haeb0L84L/w6b6UJ9kRE8eSMoXacv/qcPlrK
	 ZUXxrZf3JaCyIpFJOrE3w5ux5K6GVOvFceRD53KmS4agGP/BMz+ZFWiWwLbAvS7hj
	 Zuwpyown8cwj76WQlw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGxQX-1rT2XA40kl-00EGMH; Tue, 19
 Dec 2023 16:36:12 +0100
Message-ID: <526df884-8d9f-4fe1-8a32-c98dfff261d7@web.de>
Date: Tue, 19 Dec 2023 16:36:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <e0543d9d-a02a-4c9c-b341-36771cfb5353@web.de>
In-Reply-To: <e0543d9d-a02a-4c9c-b341-36771cfb5353@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ty9JQzMTJdBwRgq27eu4X1MYwBgEoqbzGhLFiC0uyypy8ISyY/3
 04ttYsnYF4svdZvfzX2e0Q5LP9xnbZXCwWwLPotK0G3FSPKrDvSggC3MSn7WHsRqklFB8u8
 Y/zvYhANVJwd/l7F38NBblZ6qZZHqwg+tm+flOv8n6ggTQHf/+98Jhh3Uyg15wdIWKJAzUW
 rYw7t/s52WNc20JKw5meg==
UI-OutboundReport: notjunk:1;M01:P0:bn4Ds0KTrg4=;i9ZeJm85eydOOEPORA+V0LPdHbM
 5dd4Z4bvbJMQeTztCMzJ5ZOE074edtSA8hze0krNwEGRBPzr+n7FGg/Tsth9nxgoKU8MsGE14
 J5nDsA2n3dfOiqBE1I7KRw2+fwFlw/xcL9gIW/k++bHjNgZyOFA0RdXirtX997AEnkhAjFeYd
 SXwLcOEPBp6sNLWCpSQCIlFluLBFxOizeDNFCfFeWIKtZwtr4b6WjeQZHnusPsfMDN4J93C1T
 hPznwNJMqkBuXELcjpDLAnvWgd7tnnw3KMRKrkRxwKrjszWHVSokaUSiHqQJjCVUvgQcSOjmi
 bAjZV81AHAvg00HRxZQ3GsyV1FUd6xJVvaT947/UhMeW9lTEC+n2pi+0Fg1XCoesBWupmbv+c
 ufUM+YcVv/BaV33Vqd/4pHBwgIDzy+Sf6Vc7yap6TxhB6Lt1Pi28U1NSXDpyLtO+wWCfh5uko
 is+/2jLi3fD+V22WB7Cy+Dg1UARlflZSBrHjKBjJjmCTstjPKg2TcgH7Y+jtCNj1l4B6s/GKA
 LpJTVQC0ArOQjl1knDByBuFa6x1/Tw1ui5/gYQfPQXqCvIhYtbL34gHF8Bih8NasXSm3oRtph
 k23pSlBWO8lte3tTJsUXc0VM+EjjWeQf8BxSxuHqf+UDxEanFGJyHWOcVvExZv+yF450YHJL7
 B3b/BhVmj/UTqzC2S02Wh5zciuL96MDNyfgldgzZODcKKWugIZyBXjL3b3XIY9QvuXLh2zmWy
 2mHBlMLN9oXP33u0GK62z1SvHEpKOeI9naEUVZ2WDoQD0NS9VzCxEhAZKtrwQiz6sSqZl4Yhy
 g5hFxtKusafBRxL9/Vn50YH0AEhWBRHTpcCtzLzXHqly5+4Gx7XAu/A8vNpfsJeRBgqShlNm4
 r354EUyMvxkjZik6xZzKjBTJea6EEtimOVJYI3rNuCAiS3wIGYp7BA3ZSZObWDhOfHfd14MLI
 +aTfAw==
Subject: [cocci] [PATCH 3/3] kobject: Delete an unnecessary variable
 initialisation in kobject_uevent_env()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1351
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/526df884-8d9f-4fe1-8a32-c98dfff261d7%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 19 Dec 2023 16:03:39 +0100

The local variable =E2=80=9Cdevpath=E2=80=9D will eventually be set to an =
appropriate
pointer a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 lib/kobject_uevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index a9b1bc02f65c..1b7b42dc160c 100644
=2D-- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -459,7 +459,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobj=
ect_action action,
 {
 	struct kobj_uevent_env *env;
 	const char *action_string =3D kobject_actions[action];
-	const char *devpath =3D NULL;
+	const char *devpath;
 	const char *subsystem;
 	struct kobject *top_kobj;
 	struct kset *kset;
=2D-
2.43.0

