Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0107CEBF95
	for <cocci@archiver.kernel.org>; Fri, 27 Sep 2024 11:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9LwiszU1uNVhnItMlEGCmRLBVwV1PTgWtvYn++mPFGs=;
  b=lnR6C2riRi6Lm8h20JDugcI82sxO5cWw24gA0qoNEwT7+0/RvcxvqqN0
   p8eNdYinFSfioso5gp3Mi6pqpKiePRNds3pUlQz/GcEK71QzUto/Q1OyJ
   pQlAbEwD8O9RUZ94gRTgpFuMw2K75fcDiuJczxHzLvlvqJykvTlqiVBSh
   w=;
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
X-IronPort-AV: E=Sophos;i="6.11,158,1725314400"; 
   d="scan'208";a="185498661"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Sep 2024 13:00:55 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7CFD0E0141; Fri, 27 Sep 2024 13:00:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A8463E0035
	for <cocci@sympa.inria.fr>; Fri, 27 Sep 2024 13:00:48 +0200 (CEST)
IronPort-SDR: 66f69060_A/hMt6P1nMX8NR0Uxgs0s1N2qAeKmYEmkCz7iAnUmJdR0EO
 layeP2L52DyGQEgs4u+tKk6dzX9FKbWa0CWACpg==
X-IPAS-Result: =?us-ascii?q?A0FfAAB6j/Zm/w4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDB1sbBlQzBAtIhFaIHYcwgXUwhDuPDoh2gVaBQD4PAQMBDTsGA?=
 =?us-ascii?q?QIEAQEDBDiESAKKBwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECA?=
 =?us-ascii?q?QECBAYBAoEKCAuFL0YNgmMBEIEUgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg06R?=
 =?us-ascii?q?AEBAQIBIx0BAREnBAsLGgImAgJLCwYBEgIBAYJ9AYIvAQMOIwcNsDqBMoEBg?=
 =?us-ascii?q?gwBAQbaWh8sIleBYwMGgRouAYhKAYVWS4Q8Jw+BVUSBPIMDPoJKgXmDW4Jpj?=
 =?us-ascii?q?moWgw2CEAqFSoQKJYhfcJEsUnscA1khEwFVExcLCQWJOAqDHIFuJoQWCIErE?=
 =?us-ascii?q?4NfgWcJYIdnYoENgT6BWQFGgnNKg0+BeAU4SYJRa048Ag0CN4IoJGqCXIEnB?=
 =?us-ascii?q?AWDUnYdQAIBC209NQkLGwY9rByBW0iCQYFBgj2Sc7J+NAeCN4FkgWMMiieVK?=
 =?us-ascii?q?wYTL5c+DgaSc4YgklYii2GBeJsiNYEyPYFZMxokgzYfMwsOD44hhC2EYbkHQ?=
 =?us-ascii?q?TUCOQIHAQoBAQMJAYFVg3ABAYZBgUsBAQ?=
IronPort-PHdr: A9a23:niOfNR8nZbXlIf9uWc+2ngc9DxPPW53KNwIYoqAql6hJOvz6uci5Z
 AqFvaQm1wOBdL6YwswHotKViZyoYXYH75eFvSJKW713fDhBt/8rmRc9CtWOE0zxIa2iRSU7G
 MNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1Ifn+FpLPg8it2O2/9YHfbx9WiDahZb5+I
 xu7oArMvcQKnIVuLbo8xRTOrnZUYepawn9mK0yOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ
 7FGFToqK2866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXDmp8
 qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSWZdQspdUipMCZ6+Y
 YQSFeoMJeVWoYfyqFQAsBWwGwesCuPtxTBUiXH7xrE60/07HA3awAAsAdADvXLJp9v1LqcSV
 uW1wbHPwzrZdfNW2ir96JPVeR4upfGMU6hwccvXyUkgCgjIiVKeppb/PzOWy+QNqHKX4eVkV
 eKhkW4nqgdxoje0y8YilIbGnZgZxU3a+ihgxos+ONK3RlJhb9G+DJtQqz+VN5FwQs46R2xmt
 jg2x6AYtZO7fyUExpsqygPCZvKIboWF/gzvWemQLDl4mn5rd6yyihKs/EWkzuDxV9W43VdEo
 CRKjtXBtnYA3AHd5MiAT/ty5Eah2TCX2gDQ9O5EO0Y0mrTfK5I7xb4wjJUTvVzHHi/1nUX2i
 LWadkI++uin7ensf7bopoeEOoNqlw3yLL4iltKhDek6KAQCQmiW9f6h2LDs5UH0RLpHguc4n
 6XEqpzXJssWqrS9DgJV1Iso9giyDzO70NQDgXkIMkhFdg+Gj4noJV7DOOz0APGiiFq2ijhr3
 erJPrj5D5XNMHfDlLDhcK54605b1Qoz0cpT5pxKBb4aOv78R1H+uMTZDh8/LQO03/7qBMtg2
 o8AQ26DHLGVPaHIvVOV5u8jOfSAaYANtDb4Mfcl5vrujXEjmV8aeKmkxZwZZ2qiHvRlPkWZe
 mDgjNgFEWcEpAo+TerqiFKZXD9deXm9RLgw6SwlB46+C4fMXZiigKad0yejAp1WemdGB0iSH
 XvwbYWLR+8MaD6OIs9mijEEUaKuSoE72hGqsA/30LtmLuvR+iIDr5LszsJ55+zVlREo9Dx7F
 d6R02+XT21shGMHWyc23LxjoUx60lqMza94jOBEGtxS/P5JSQc7NZvEz+NgEdzyWwTBfs2IS
 Fm8WNmmDysxHZoNxIosfkJ8Ep2Ghw/K2y7iV70Ik72CQpg97avY21DwIdx8wjDIzv9lx1IhS
 cBOHWygnK92sQbJVKDTlEDMsq+wdrkHlAPJ+n2Cy2XG6GRRSg1tSuPoWX4FZ03Zhcv07AXOQ
 un9WvwcLgJdxJvaeeNxYdrzgAADHa+7UDy/S2e4mmPqQA2N2qvJdo3hPWMUwCTaDkEA1QEV5
 3ePcwYkVW+6u2yLKjtoGBr0Zl/0t/FkoSaeR1U30hrMQklvzbuz9TYKiPbaR/5AlqkctnIZo
 i5vVE24w8qQDtOBowR7e6AJRNon40pck0/duRZ8OJOIMK1owFITIExsp0278RJxB81blNQy6
 nMnyA0nMaWDzFZIbC+Vx7j1PaDLbHb/9lajZsY6w3n419CbsucK4fU88RD4uR2xU1Al+DNh2
 sVU1H2V4tPLChATWNT/SBR/8R8yvLzcbiQnguGcnXRxLam5tCPD0NM1FaMkzBinZdJWLKKDE
 kf7DcQbA8GkLOFilUKua1oIO+Vb9ah8OM3DFbPO/aexP/t72h+ig35G5o9VzU+GsSZxC6bJ0
 5sD3/CEz16fTT6vxFyls83xhcVFfWRIRzD5k3K7QtcMIPQuLuNpQS+0Lsa6x8tzncvoUn9cr
 hu4Ak8endWuclyUZkD82gtZ0QIWp2amkG221W8R8Xlho6yB0SjJ2+mnegAAPzsBYWB4jkr3Z
 6WwgcobWkeAcAUj0heorxWfpeATtOFkIm/fTF0dNQ3/NWJ/Se2dsrSYYshAwIwlu2NbXa7vB
 DLSAq64qBwc3ST5GmJYzz1ubDCmtKLymBligX6cJnJ+xJbAUfl53gyXpNnVRPoLmyEDWDE9k
 z7cQF61I9iu+9yQ0ZbFqOG3EWy7BNVfdizizIXIsyXehyUiJBSlnO2o3PDjHxI71yDTyNRgE
 ynF5BrxeYjk0a2mPPkvJBAyQgWmtIwjR8cnzsM5n9kI1GIfh4mJ8HZi8y+7Kthd1a/kLTIMS
 TMN39/J8V3g0UxnIGiOwtGxXXGcz819ItiiNzlPgGRntZ8MUfrSteAX+Ek96kC1pg/Qf/Vny
 zIUyP90rWUfn/lMog0miCOUHrEVG0Bcey3qjRWBqd6k/8A1LC6id6a90E1mkJWvFraH90t5U
 Wz6Z4xkMCt+9MR5P3rT3Xe15oyuK7yyJZoD8waZlRvNlb0fDZsrlecRwwdjN3j8u3IN1OMxy
 xBjl8Lf3sDPOyBm+6S3BQRdPzv+apYI+z3juq1Zm96fw4GlGpgyUiVORpbjSuikVS4Drfmyf
 RjbCyUy8z3IfNiXVR/a8kptqGjDVoymJ23CbmdM1s1sHVGUdklYnRxSQzgw2JI0Xgn4wcv8b
 AJp6DcL+Vfipl1Tx+guOxSaMC+XrVWtbSooDZKYMRxd40dd6k2TPcHW57B2GDxEu5a6phGJK
 SrCbgJEVCcCXUnhZRirN+ur4sTctuODDe2kN72XaLOC8KpVUPLA05ur1sEOEy+kEMKJMzEiC
 vQ63hAGRnVlA4HDnD5JTSULliXLZsrdpRGm+yQxoNrtuPLsEBni44eCEd4weZ1m5gy2jKGfN
 uWRmDcxKDBW0YkJzGPJz75X1UAbiiVnfT2gWboasiuFQKXVk65RRxkVDkE7fNNP9L451xJRN
 NTzj9Toyvhng/RzB1oEHV3tl8e1ZNAbdmGwMFSUYSTDfL+CJDDN34T2efbmEOcW1r8L8UTt/
 2/HQCqBdnyZmjLkVg6iK7RJhSCfZllFvZ2lNwxqAi7lRc7nbRuyNJl2iyc3yPs6nCCvVyZUP
 D5ifkdKtrDV4zlfh6A1PmVb7Wd+a8SAlTyY6ebwNZsc9/dmSHcR9aoS8DEhxr1Z4TsRDuRyg
 zfXp8VyrkuOl+6S1nx4XRAIpjsB1+fp9Q1yfK7e8JdHQ3PN+hkAuH6RBxo9rNxgEtTzuqpUx
 7Ane4rsJT0E/9+GpKP05uDRL9+bdmUsO1zlFWyMZOPgZSGmPyfTih4F+Mw=
IronPort-Data: A9a23:Y6tRcazv619acpd4m/Z6t+cYxyrEfRIJ4+MujC+fZmUNrF6WrkVTn
 GZOWG+DO/zYNGr3f49wPd++8EgPsZ7dn9c1QQNpr1hgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgmcc3l48sfrZ9Es+5quq4Vv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPj4OVoCGYKbbcI86FsX3AW6
 6FFLSk0O0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKxgG8qcBfyXo4YEtNszrpgm8fL2Q
 sMDaid0KjnEbQdOPFg/F5802uul7pX6W2QI9Q7E9fRrvQA/yiRDzaTyMurQe+aHG+dkmliJt
 G3M2l3QV0Ry2Nu3jGDtHmiXruvGgir/XKoAFbiy7PcsgVuJx2VVBgd+fVC8qvK4olWvXspWb
 U0S4Csn66YonHFHVfH4WACk5mGJtFgQVrK8DtEH1e1E8YKMiy7xO4TOZmQphHEO7afamRRCO
 p61c9LV6fhHtbqIVTSC+73SoT7a1e3564MdTXdscOfHy4CLTEIPYtbnUdtpVqK45jEwMS+l2
 CiE9UDSmJ1K5fPmFMyHEZTvnD+m4JTEJuLwCsM7QUr9hj5EiEWZi0BEJLQVATus7GpUc7VZg
 EU5pg==
IronPort-HdrOrdr: A9a23:4xkSMqD9rGuTwKTlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3AGWDtOmhGelwXb59jcVqJZvhvQDJufV7NynP3Hx+?=
 =?us-ascii?q?CGW8uU+OEEUHNpaZ9qp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AxPavPAz3eweUMgBafqv0cdPvkFuaqJazFF8PoZA?=
 =?us-ascii?q?HgcTaFx10JSaPgz6Se6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,158,1725314400"; 
   d="scan'208";a="185498646"
X-MGA-submission: =?us-ascii?q?MDE26612v1YHzighFtG6yoJGemljMxwumj5NPj?=
 =?us-ascii?q?XN3HTWOQEzyf/GJbXdjj5zLBNRFatNnHihpRf+eCIpBD5nUjAGn69nac?=
 =?us-ascii?q?QBR+KEX1osdn8ZYeJv7okTH81muES10s7pLITATYI4mTI61fpMOtTsZ5?=
 =?us-ascii?q?eCvIgmSPuOa+9FUjLBFIAtzg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 13:00:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727434837; x=1728039637; i=markus.elfring@web.de;
	bh=9LwiszU1uNVhnItMlEGCmRLBVwV1PTgWtvYn++mPFGs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=avAK9hRJCBaRzd/zJJSWk23jbhf5S//0Lg6xdRMw0zRq5qORDxxSgal8pPpAkvfy
	 xgcNFRGeMXYlTBQcAyWauzkwhHs1ExpmJZgCrfMCZgtbuiQrpXTGBI2OofzXmksfp
	 0+Y4tmOXoQTMzCReQp1Hw7Ydn92df0P7A86DCrd/Ku6uGYo/Rb8XiOppITd4Co7lJ
	 fee5LMzIXc06auzUF87G7Ay1itp8UX5ZYVyW64JrH2DO7rGnCzsAx5a1HCyVP1Eb+
	 OUVEJwRUGF/av2qt0MdNEHJC40wXeJcDkgQ1DdWv1oBeBryJ8wqk/qxc0/Pk248km
	 yvqvaiFTbVb/Su1uAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5Qm1-1stJtg2FFt-005YzU; Fri, 27
 Sep 2024 13:00:37 +0200
Message-ID: <3771e8f1-e6a6-47fe-a348-3ab248d765a6@web.de>
Date: Fri, 27 Sep 2024 13:00:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <12bd8d0a-d066-4fd7-a7ee-99209f18a613@web.de>
 <ca8a6747-ca52-5a1e-b0ba-df9bb18ac010@inria.fr>
 <4ec353d5-9771-4db3-83ed-7571b35eadce@web.de>
 <f2835a9f-425-211e-2d91-e6ff92903dd2@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f2835a9f-425-211e-2d91-e6ff92903dd2@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N8+6odkT6MI2VIA6+j5UbH1h/vycWlHFA2FyJTlSqdNuC3NnNL/
 Y66FmCfGtk8zHtNg445MSvVNs+gD3IgrY4kArnodZLSPXzB5MBF7cRCtuqZ8j1/z//4b4Sa
 IioeX0zF8Af1IB5oHG/tEaR3OIkH9Vx5aCJLHKQbNDaApmuU/pwSKMiwk/1Ivc7f5xm3tEj
 yiRlBEjYuMOSN14rAzzqQ==
UI-OutboundReport: notjunk:1;M01:P0:xBcVFuWocJY=;qBj70YcUPOs/hKL4FltXmnAU3Cy
 I1dE9/TkJ+W5bmQo1r+NclTnwlY29fHz7i3jBbiLEE92BRV2jrrJxfLrcZhFZuo5WJBweULen
 hpv8+Aqhhy3FSzK1ny+D5YaaYsQmxt7H+a0HwhP0nkHNJyFC9jK3bJlgp0IdxBIJ70ouRg4CB
 cuLHrjXDtwQozYrKjg/TJZXT0dGz4ACRaUGCG/tvJ4VCCXcvnUlOHlLwsEI9s1VQKf9CCDDpj
 B5dSzllb7EzcGn4PULh6UkJQvbv5p9kNf/05OZihgaMi8ktAghalPB6oFShxPGqvsCLpm1RDL
 oEMReq5PJlTqcw/tv+vDQ/LxeFwXYh1hUV6o2qc/zbTdQm8tGQHtxS2Tl0RLnxA0XPrmT/Iu8
 aXqrmisDRWRAnvQGkq8NrX8Z4l5AlqhSvnVVbdeOTPrxSn6YWCxMCnXPpMi6hp3FLBwkWbHgu
 LzsSpDeIAZlbKzEQ+ouq6+3VlZHDw/MUW9K+TTLw3gbpzxE+hrZRF7e7fOviC6QpZsjbK6Yoi
 PmCC+ktm13jzjsOn3qnKEev4opGv9VGZVZB8PdGkYlq9MlJsOdnpFns5jMkGwmNYIfIiNhBSR
 P3ZQQWM+vyl5iBK1Pcr3q8nJUyE7GcKsjjhayQZR4fg1Jj/McczXyk0tMk2O/g3wSAAKphwh4
 d1MX2g1ZM7Zss5bx/ht9OBPxyftRrtq/q/addaLDWczHeXp1fq+fhUqhnDFVYjbJcVnMIo7c9
 TH9RD4CGJI7uYM+nEoQAp6XTZjQdWz4CAY+Qg1M5SfH2m8zPOyvPhiUViVeUBz35mTraXp8me
 UQN/dHfpyI3XTykLYP9UaSjA==
Subject: Re: [cocci] Searching compound statements without
 =?UTF-8?Q?=E2=80=9Cif=E2=80=9D?= filter (by SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1893
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/3771e8f1-e6a6-47fe-a348-3ab248d765a6%40web.de>

>> There are more control flow variations possible which do not begin
>> with such a key word before compound statements (source code blocks wit=
h
>> curly brackets).
>> Will the support grow for this general use case?
>
> What is a real semantic patch that fais,


// See also:
// [PATCH] bpf: Call kfree(obj) only once in free_one()
// https://lore.kernel.org/kernel-janitors/08987123-668c-40f3-a8ee-c3038d9=
4f069@web.de/
// https://lkml.org/lkml/2024/9/26/634
@display@
expression x;
@@
 {
 <+...
 {
 ...
*kfree(x);
*return;
 }
 ...+>
 kfree(x);
 }


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch =E2=80=
=A6/Projekte/Coccinelle/janitor/show_kfree_candidates_for_reduction.cocci =
kernel/bpf/memalloc.c
=E2=80=A6


I miss the presentation of a known source code place.


> or a real example of C code that you are not able to match?

I would occasionally like to avoid the extra specification of control flow
key words for special source code search patterns.

Regards,
Markus
