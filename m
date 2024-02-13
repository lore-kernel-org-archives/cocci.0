Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4A0C48260
	for <cocci@archiver.kernel.org>; Tue, 13 Feb 2024 09:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=sI9tLKZu0dgw8bh+Z2ldKk+YMCbbTxgaOmXc7gwllsI=;
  b=erXfKM9S+4JF9itQJ93NyAlXVSgXP24eiEUVelHwpfh04N0plYhdmohY
   1n7DI5ne1Dy7ZbM0ohgAvtVO3v6UD5ynRgG2XL69OI5dDqfzRidJ71k4D
   R2xUS7QUrCxD/IHQRrgare+138/JJ10WsY97UZ9bwURbkoYnIxzp8KjBO
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,156,1705359600"; 
   d="scan'208";a="151641755"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Feb 2024 10:41:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 55900E008A; Tue, 13 Feb 2024 10:41:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 00CD5E008A
	for <cocci@sympa.inria.fr>; Tue, 13 Feb 2024 10:41:02 +0100 (CET)
IronPort-SDR: 65cb392e_EdrjCcHg/b8NQcinCKDbxTBLO2BU8Ik9QPqTkpUr95BTj9C
 cYLSY2lqh5v1XhDPLLvgJIx1+EKuogsAlmfkTsA==
X-IPAS-Result: =?us-ascii?q?A0HKAgDCN8tlh07ASNlaHgEBCxIMQIFEC4I5fANTMgQLS?=
 =?us-ascii?q?IRTkWmEO48FiHCBVoFAPg8BAwENOQgBAgQBAQMEgguCLkYCh1cCHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhWwNg?=
 =?us-ascii?q?lwBEIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg06QgECAgEjHQEBEScPCxoCH?=
 =?us-ascii?q?wcCAlYGARQBAYJ8AYIqAQMOIwcNsVuBMoEBggoBAQavWh8sIlaBYQMGgRoui?=
 =?us-ascii?q?CYBhW+EOycPgVVEgTyDAz6CYQKBYINbgmiFU5htVH8dA4EFBFoNGxAeNxEQB?=
 =?us-ascii?q?Q4NAwhuHQIxOgMFAwQyChIMCx8FVANABkkLAwIaBQMDBIEwBQ0aAhAaBgwmA?=
 =?us-ascii?q?wMSSQIQFAM4AwMGAwoxMFVBDFADZB8yCTwPDBoCGxsNJCMCLEADCQoQAhYDH?=
 =?us-ascii?q?RYEMhEJCyYDKgY2AhIMBgYGXSMHDwkEJQMIBAMrKQMhdBEDBAoDEwcLB3iCC?=
 =?us-ascii?q?YE9BBNEAxCBNIU+hHUMCAMZKx1AAgELbT01CQsbBiIBHQKeLAGECSIsN4E4x?=
 =?us-ascii?q?Sg0B4I0gWCBYQyKG5UdBhMvly4OBpJemFcgjU+bCIFjOoFcMxokgzZPAxkPj?=
 =?us-ascii?q?iAZH4NCM49HQjU7AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 Z0TVvlEWVZzGv5IUixY
IronPort-Data: A9a23:ik5FxKAxb4pR3RVW/xvnw5YqxClBgxIJ4kV8jS/XYbTApDsn0GdTz
 TYWDTvSaKyPYWvyKd4gb4zg9xwH6MKBzYMwOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuHZjdJ5xYuajhIs/ja80s21BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc5xfbXHrzmeg0NlMvGdBE69h9EUhc9
 sVNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5kneGV7B/EMqFHPWiCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA2SijLWcH+A/9Sawf0nLY0DRVjYXUd9fndoyzZp0PxWmGj
 zeTl4j+KkpGZITEmWXtHmiXruTIlij6cJkDEaWxsP9smlyagGIJYDUSXESypf2RmE+7UchWb
 U0S4Csn66YonHFHVfH4WACk5mGJtFgQVrK8DtHW9inX14XV/FyEXFIWVxocNM0Yvt8fVz8Tg
 wrhc8zSORRjt7icSHS4/7iSrC+vNSV9EYPkTXFZJefiy4e9yLzfni7yosBf/LmdovCdJN0d6
 zWNsTR4mLgZy8IGv0lawbwlq2P3znQqZlRtjukyYo5Dxl4kDGJCT9H3gWU3Fd4acO6koqCp5
 RDoYfS24uEUFo2qnyeQWugLF7zBz6/aaGKD3wQxQch/q2jFF5ufkWZ4v20WyKBBbZtsRNMVS
 BWL51I5CGJ7ZyD0Nv8rC25PI5V3kvaI+SvZugD8NYYeOsMhK2drDQlvYkiXxCj2nSARfVIXa
 f+mnTKXJS9CU8xPlWLoL89EiOND7n5lnwv7G8ukpylLJJLFORZ5v59ebADRBg34hYvYyDjoH
 yF3bJPUlkUHCbCuM0E6M+c7dDg3EJTyPriuw+Q/SwJJClMO9LgJWqGPk4AyMZdohbpUneru9
 3SwEB0QglnmiHGNbU3AZnl/Yfm9FdxyvFAqDxwKZFyI4nkEZZrwzaE9c5BsQ6Ir2tY+xtFJT
 t4EWf66PNJxdhr99Q4gMKbN9L5ZSEzzhCalHTaUXzwkTpsxGy3L4oDFeyXsxgkvDw22l5AMn
 Jy95CzmQL4oZQdrPODJYt2BknKzunk8nrppfk3qe9N8RmTlwLJIGQfQ0MAlBt4qEgrS4Aea2
 yK9IwYqlcOUr6AbqND21L259aG3GO5AL29mNmj874fuExLF/2CmkLRyYMzRcR/zDGrLqbifP
 8NLxPTBMdoCrlZAk6x4N51Jlasexd/el4V2/zRePkfgTgqUU+t7A3y8w8NwmLVHxeZZtSuIS
 0u/wIRmFovTCvz1Mmw6BVQDVfuC58E2izOJzPUSIWfG3gFV0oeDc31vO0irtHQAAppzaJgo0
 MUwiv4wsgafsCcnAvyCryJT9lmPEEA+brUahskaLbLv2yUWyQBkQJ3DCyXJzomFRPdSP2ILf
 DKFpqrwqI5N50jFcnZpK3np2NBZpJURuSJlyE0JCESJl+Hk2N42/kx12hYmQjtFyi5o17pIB
 VFqEEluN4CiwixNhvUfb1uzGgpEOgKVynbxx3QNimfdaUuiDU7JE0EQJseP+xo/319HXz0G4
 oyd9nnpYQzqcO71wCE2f0xv8N7nbN5p8zz9iNKVJNuEE7Y6cAjarPeXP0RQkCTeAOQ1mEHjj
 stp9rwpaaTEaAghk5diAIyejbktWBSIIVJZes5Y/YQLIHr9fQ+j0j3fOmGzfcJwf8bxy3GaM
 PA3BMxzVEWZ7h2s/xQ7Hq8HJoFmkME5vOQifqzZHk9Ykr+9gAcwjrfu2HnfvlI7e/Rvjsc3F
 a3JfR2gDGG7pCVZik3NnuZ+K0u6ZtgOW1yl0Mvoq9c2No8xn9xtVWoQ0bKEmWqfHyU63hCTv
 SLFP7T3yc47w6tSvoLcKIdxLCTqFsHWS8KJ7xKWn+lVSNHybff1qAIer2f4MzRsPbc+X8p9k
 ZKPuoXV2HzpkakXUWeDvbW8DIhMuNuPWdRIPvLNLHV1mTWIXOnu6UAh/0G6MZl4r8NP1PK4R
 geXaNqCSvBNYo1znEZqUil5FwoRL4/Vba26/CO0kKmqOygniAfCKIuqyG/tYWRlbRQ3ApzZC
 DLvmvOQ99td/ZVtBhgFOqlcOKVGAmTfAIkoS96gkgOjLDiYsgvX8P+q3x8t8irCBXS4Ad73q
 8CNDAT3cBOp/rrE1pdFuoh1pQcaF2t5nfJ2RE8G5tpqkHqvOQbq9wjG3UkuUfm4UxAe1a0Uo
 BnIa3Y+TzrwV3JIfH0QJTglshi3XoQz1hXRf1TFPH94rw+pCYnGDLYJGuJI/SJtYjW6pA24A
 Yh2x5AzVyRdBrl2SOxV6vHTbSKLAB/F7ipgxH0RWPAez/rT7XvmGZCh8MdwufT7Lvzw
IronPort-HdrOrdr: A9a23:UK7Rt6ytPL4W6Vkb+L0ZKrPwEb1zdoMgy1knxilNoNJuA6qlfq
 eV/cjztCWbtN91Yh4dcL+7Scy9qB/nlaKdpLNhRItKIjOW3FdAXbsSjrcKqgeIc0aSmtK1l5
 0QFJSWY+eAb2SS4/yKmDVQa+xQu+VvL5rDudvj
X-Talos-CUID: 9a23:NL1JymExTUOXVgZEqmI96WEVBZo4KEfP1VONf16GA3ZAWr6sHAo=
X-Talos-MUID: 9a23:gSd0zAZMdgZl+uBThiXnmAlGafpRpKmcBBA0ss1c4OaaHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,156,1705359600"; 
   d="scan'208";a="79462785"
X-MGA-submission: =?us-ascii?q?MDE5e/mShjZo0h/QMjE2rejrZIa9yvhWPJ0j+V?=
 =?us-ascii?q?ech9b7pkcsHSJijG0L4E8J9u3MTWal5BzS8DUijfgYtZke1fsEm+kbHG?=
 =?us-ascii?q?CKZsmd+YGQGarX4sG013WsXEZ1jfahAM68MBDiS/HePkkUL87wBrTfQ3?=
 =?us-ascii?q?WxVGeluioDbY+q6Nw0ztzVaw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 10:41:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707817261; x=1708422061; i=markus.elfring@web.de;
	bh=sI9tLKZu0dgw8bh+Z2ldKk+YMCbbTxgaOmXc7gwllsI=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=J8rlvrk4y9A9UZFDfEo6aqABmPsYtJAsdJfGhUfmJPssQd/pS2vN+gI9r0z/CZWu
	 cDgLz2q3+bW1jZ2dU6dJuOJ2181U9xQ19SsH0qRlr+jluGiUee5f6RWV9CqkUGyJT
	 a2ZhIdJaeqC1KlPCjUOf9uctkll3RSOrwqotTz0947QmZV6DjHqQCif0pepV0eGw3
	 PsccgcXStL30gfLNAbv5GG0aKLAOui3hfPB5nL+qR4vccRjlYWkxB21p4tCxrQ/KY
	 HuVBTSkPKxhIXUvtEP3ZZAZw/d/48WeObSVrgogLWaG7akHvLu+ijCxQM2DEObk8H
	 P0APEBVkjmBV9Vao1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MALiL-1rfYhj3ViV-00Bu1A; Tue, 13
 Feb 2024 10:41:00 +0100
Message-ID: <7e4d1543-0aeb-40b3-a956-3100e83b0287@web.de>
Date: Tue, 13 Feb 2024 10:41:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <41052adc-2065-4cf2-9160-2e986de1bf9b@web.de>
 <289a052b-86ff-4ecd-ae55-89fc0238373e@web.de>
 <alpine.DEB.2.22.394.2402072108500.3138@hadrien>
 <d983ec62-2e0e-4102-bddc-4c420a75601b@web.de>
 <51feebc2-751d-4e1b-bf72-28dc8ed975c9@web.de>
 <eb10beb1-c8b-47e5-ab28-5c1bba502d2a@inria.fr>
 <70dc14fc-5e21-4eee-be17-c9fd30b99cef@web.de>
 <856ae5f3-f31a-2661-90ae-6041c3318893@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <856ae5f3-f31a-2661-90ae-6041c3318893@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W295oh72OEm28RbFkLFswoNjSgB1sV0iKwwlm28BNBGGYd6veGG
 W0NBr1DxnnCkm1QlXnpVGaz1emb43NWnW4E7LIc59GzEUg7T05Zou/cGffXCjdwCRiikz+f
 T9LpEuJ6juOMkqYdBiHBFW0cwPFeLk/WYNpAqQgF8e/OUggJ97WsMuwGr4LPVO4aeFlWz0G
 gHOmXGcZw/KCtbgSCsp0g==
UI-OutboundReport: notjunk:1;M01:P0:cSSoDwnzbig=;fGWfoNWnwmMCFPo6gxQqMsL/Cph
 MRh1F2DYKR26GefJWXnVPLGqNFfCHe1XmE7RHJ/ecWYDOl974t92s1Kdh0OoWazB2MvDVcGu/
 s6DHi3QeAm/Mvx+0lvTQXWFLEdiY5bNC9jlZCqCDFAKMDz1gHsTu5NMCl5M2ZjDYOrJoWu+y7
 iJKrQDmwPT0EBIxeNIBJohwmTufAIFFuqoshw/I9bsBu0Yoe92LNe6AM/eKkusk6gw29B1c0P
 7Hufljp5fWRrBtAeUjoXXUK6i7HygG0JmCRrC2NzK7ij6+0jTte6FXSfYBBDPgkLJbhrjgtlD
 GQkhNDKtrpuGaaq+Urvg/NqP9wgm4YK5bNGlVXYDlu9KWr8mfJ6A6OkyVhw+jwEGr16hvP9nd
 u/clEErIN4q53sW1ar14nHon+cW7qKdrcZx3wMsj4c6lOYSNlBXhOoi/I4C43H2Y5Cl18j1ZZ
 7j2tCJXP/hRYWyf2rf+50y9iOGfWDaxJzZTYqjxmxNu65oA6FpmtUns1HdaErmHgky+Qoi+lP
 W4gpvUQrCKwSxTPHamciRdPB5kuS17NVMVdbxxVkA8YQLYqM1eVTi+3oAlhNbNMkonIx5zkm2
 Fkv/pGryRpoOK7Ls7QqvmZ3U7thm0qAD1SvYGzMFuDZaIwFpYEg82QZAlzho88iIW4T8mWcyz
 T3Q1gQEH5z0KqsJbAIg0XIp5yC30J4sOEJhhzHxet22f5gx7nPY2uzRsx3Q+DjJn22UUZv1KI
 vjgLkh1AhuyKEcOu5auko515WRqrLaa332mWGM4WPwhXnTbSejWHF9xRdjnbf/6Yip4eH2ttZ
 ClBYszcxvbc7nfWFgps6OCkT5HJF6WfbZs86WaE6aeV9w=
Subject: Re: [cocci] Supporting transformations better according to reduced
 number of function call parameters
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1549
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/7e4d1543-0aeb-40b3-a956-3100e83b0287%40web.de>

>> Can it be that a branch of a SmPL disjunction can not directly benefit =
from
>> metavariable matches in previous branches by reusing their contents so =
far?
>
> I don't think it is useful to do anything for this.

We are struggling with challenges according to further evolution for the d=
iscussed software.

Some source code search patterns can be expressed in a way so that
they can be directly evaluated by the provided =E2=80=9Cengine=E2=80=9D.
We occasionally stumble on capability limitations of this software compone=
nt.

But such an evaluation provides a data processing result at least
which subsequent SmPL rules can pick up for further computations.
A search pattern can eventually be split into a combination of smaller one=
s
which can hopefully be better evaluated then.

Will the support accordingly grow for =E2=80=9Cadvanced SmPL dependencies=
=E2=80=9D?
https://github.com/coccinelle/coccinelle/issues/353

Regards,
Markus
