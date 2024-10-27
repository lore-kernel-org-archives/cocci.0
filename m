Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5ADD13577
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2024 17:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PrGRzUgCCGUM5IAClY/4sZD94z11M6HjSF7TBSCWGh8=;
  b=l5viBjFKxnjFi47lSO0XRseK617o31x7S9/+2MdRqeJB7M97ncRXMxg7
   hav8tqNjbkqCp+/zf8yJubR6z+IpHaMN5+y0UqVyunWqnTd9KxryRafgE
   +zQBH9TRx7pqAfa7PZm5ZE0uT/2NGqGlW77w4NVbgSHO9c/cWU9UBObLS
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
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190931771"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2024 18:45:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A5AD6E00B7; Sun, 27 Oct 2024 18:45:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 736E3E00B7
	for <cocci@sympa.inria.fr>; Sun, 27 Oct 2024 18:45:21 +0100 (CET)
IronPort-SDR: 671e7c31_eLUYbBF4aYHrO7wwdSxpjg9g7oeyP3mb8rDjACwWuUPMyQv
 nuUovTCZ0xy2UrVYlt09ZgwzUOWEN/cfRI6x+OQ==
X-IPAS-Result: =?us-ascii?q?A0ELAAAAex5n/wsR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFABAEBAQELAYJDB1t1MwQLSIRWj02BdC0DhDuHOpBKgVaBf?=
 =?us-ascii?q?g8BAwENQQECBAEBAwSFAAKKJwIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBARABA?=
 =?us-ascii?q?QUBAQECAQECBAYBAoEKCAuFNUYNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBA?=
 =?us-ascii?q?QECASMEGQEBESYBBAsLGgImAgJWBgEUAQGCfYIwAQMOIwevP38zgQGCDAEBB?=
 =?us-ascii?q?tpbHywiV4FjCYEaLgGFaYJiAYYkg0J6Jw+BVUSBPIJSMT6EQ4NbgmmCVYdfJ?=
 =?us-ascii?q?Yg3aJFDUnscA1kyAVUTFwsHBYErJi4DhG5bf4E7gVMBRoJmSoNHHIFFOEmCT?=
 =?us-ascii?q?WlLOgINAjaCJCRZglCBJQQFgzqCNh1AAgELbT01CQsbBj2cF4JGgRsTARuVa?=
 =?us-ascii?q?rJeNAeCOIFlgWMMn1UGEy+XPw4GkniYdyKjZIUbgWkCOYFZMxokgzZSCw4Pj?=
 =?us-ascii?q?iGELcwXQjU7AgcBCgEBAwmFRgEBizGBSwEB?=
IronPort-PHdr: A9a23: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
 twCR+0DPGE=
IronPort-Data: A9a23:MPaq2KKFNwwHpgYfFE+REJQlxSXFcZb7ZxGr2PjKsXjdYENS1GMAm
 2sWWjyObqyKM2Hzc9F1borg9hkGvJXRn4MxTQcd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgb8s9JIGjhMsf7a8Ekw5K2aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LuU2DJ+aRHAHoPG6pI4thXC3EW6
 b8nJ2VYBvyDr7reLLOTT+5xmoI8IcOtMI53VnNIl2iDS6x8HtaaHOOTvLe03x9o7ixKNdPXf
 ckEcnxCaBraYhtAEkgaAtQykY9Eg1GmImUJ8wvK+/JfD2770gxg36LdKOPsQPOtH+l2xECnt
 37X4DGsav0dHJnFodafyVqngeTEnAvgSYcKHfu58ORriRud3AQ7FhIfUFG6rOORmE+7UchWb
 U0S4Csn66YonGSvR8b0WxmQsn+BtAQVHdtWCewzrg+Xopc4+C6cAXUYCCFMYpoquafaWAAX6
 7NApPuxbRQHjVFfYSv1Ghq89Fte5QB9wa4+iS44oc8t5t7+vMcsgxiJQtsL/GtZSDHqMWmY/
 txIhHFWa3YvYQojyKixu1zK695pjoacVRY7v207QUr8hj6Up+eZi0iA9lXRq/pNRGpcop9to
 1Bc8/WjACsy4V1hWcBDrCjh3F1k2hpdDADhvA==
IronPort-HdrOrdr: A9a23:sUucd6/SL5Nb7X2UCxJuk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:Nu9kC2GxJ0yZt45rqmJH72suS+kpSUT76yfIHW+yGT51C4KaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AYd3lkQ/q/SD31DfCizMGX3SQf9lo8qu0OFg0qK8?=
 =?us-ascii?q?pnJOoFnZ2BCaBnSviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190931760"
X-MGA-submission: =?us-ascii?q?MDHEqE+/dGBR9G++GEynkmHZPuwaQ+fRHtudpP?=
 =?us-ascii?q?YCyE6YOhUh6WnQaS8g5VT1wvLIfbxpiUTOCDuBGtvmcqg0ojskSl7SL5?=
 =?us-ascii?q?ZKzoU6BDkHCaTZAq1C9qh7NiEDA1gHjXS/+rSPqK3EN6HRthUZqJB4Ro?=
 =?us-ascii?q?vgE91czLBCHq7kkXFDD9ZNLQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 18:45:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730051108; x=1730655908; i=markus.elfring@web.de;
	bh=PrGRzUgCCGUM5IAClY/4sZD94z11M6HjSF7TBSCWGh8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=t54GYVklHbu9WMwBky9/kcSdYyNEMAKwuJ8a+l4w4ELc8Is+ROLXnpfuEGm3GnQ9
	 tmfVVigxWdc1l9OCGXcj07vdGWfgroZmXIL8ymgwLpZi6NKpehouDDIhxSBqNsv0X
	 9NXvUv4B2Bd26lCUfK5hBY4LluHXejLDt36fbcy3MkEZIHLD7U1+1WReZNWOx39ao
	 1ZgtSU69VNDkfd22+VHjRoqZhZpihbtXpORO7sDjvmbXmNgtxEmqnbrcb/tINQpOX
	 8n4mwV7N0b6fKrLnXX5swHlhBR3ZFHGrJjlU0F8LmQis+E0jqjF1kFQ2Kf8omob3v
	 Aea2DUHa0n1+1b6qjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gbY-1tzmdy0tL0-00ue91; Sun, 27
 Oct 2024 18:45:08 +0100
Message-ID: <f63293b2-94a8-4c2e-933c-5b2f94f64bb2@web.de>
Date: Sun, 27 Oct 2024 18:45:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: "Derek M. Jones" <derek@knosof.co.uk>,
 Victor Gambier <victor.gambier@inria.fr>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
 <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
 <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de>
 <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de>
 <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de>
 <alpine.DEB.2.22.394.2410271429560.3498@hadrien>
 <80d4b3c8-f29d-466e-b9e2-15f2c78a2f74@web.de>
 <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
 <4893c41d-bdaa-44b9-9381-d04bde2fedd8@web.de>
 <alpine.DEB.2.22.394.2410271833310.3498@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2410271833310.3498@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KfGmoNZ7qtYPaTLCETUOC72E2hIZYvNT8xm8I8l4j6+b4zGN6vv
 0P+LLJY8DfjRVOLLNa1Tf0V8B2oWFmmFNPjz1r9dWSHncR0IcIBpUrr1+WW1anruHyW1GL0
 wjUiyLOfGfcbceulMRX5t7tZR5kGfxbV1ZPdGiA2EBQs3nr6xKNL+/j3+mYCM1G5IM1XB44
 JoU6OzLBR0Z+RwxUjZkMQ==
UI-OutboundReport: notjunk:1;M01:P0:CHmfKG2e3EU=;Mi2o2ytAiCsYIJ+FIPpM16caCWq
 yDweXmpz1ogwZFSmhNW1+PsiPm3bso5/D2R0OWwaVuLNzjwrCVGzg3lmT39aKBWvVMLVwAILc
 cg6L0RIGv7MiKA7CzTem6r2hO4I3y3qujqm20B16Tda2vMrEa/iitdjCY/pvxhGU13pNO1gRD
 29jyYhaHN7rp1eb+9OykImcnRYzMUATmNTcQyhZuWwsuvFFxBT8UIkhx7j+8LeuAzjtG/r0Yn
 hteMwWzYFMz2mGtwdDRQjDQvxTDSAJDwemQv7ggmh90WTt0h63IQ7NqX0MdeDivNeqEijlixc
 RQtbuQxVr85YHslJUXpi7Pl4IaWR3fTeYM9kQ7+fMSQJdI7V/JNlfgih1wiJM4yG3wwpwlOVD
 Yf1zbg01jVN8uOwVWpNZEZVoC05K62ZcPqZ1F8bJoNV4JZoEKN9KvfHAIoDuKHMMjI7slF3tC
 qYcmmcI5YYajwPSqmRkXdFcisEO6Ln2CL7zu+uAKB6hvhjYRksxC7ApSb1Fsrq/7rGIvKdWlF
 7tuTQwicmKAr7QaCrs+vjg815oqhzcG+EqOc4NZg1VcINh0jGbu3LQV/9G12xCNrldBIjCXLp
 XkYt+xmlO90eQ3HdO/iuXHGWNWA/Bd8mew+sHQFYrvhJlkLnzWfNtBGMsOsBdk696clTpiBn8
 7DJ6EKvAdqxkrfOLpB44d7upH3u6aVBpdnWyQoQC+KqKU/YUFQCUW0BN/0CTOXin9PLETp44G
 oTleKMBVIH/lJPZT5lpAUQW2unnEt5Xz7dWN5+LzyYp8rnB1pJVaqJ5TmMKhWIQ7SaqhavIaV
 qvwzmuzDbXAZ7HPk4OYXwi+g==
Subject: Re: [cocci] Broken code block size determination in function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1950
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/f63293b2-94a8-4c2e-933c-5b2f94f64bb2%40web.de>

> Coccinelle doesn't report on parse errors unless an option like
> --verbose-parsing or --parse-c is provided.

How helpful do you find the following information then?


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch --verb=
ose-parsing =E2=80=A6/Projekte/Coccinelle/janitor/list_curly_bracket_posit=
ions_for_function_implementations4.cocci arch/sh/drivers/pci/common.c
=E2=80=A6
HANDLING: arch/sh/drivers/pci/common.c
ERROR-RECOV: found sync col 0 at line 49
parsing pass2: try again
ERROR-RECOV: found sync col 0 at line 49
parsing pass3: try again
Warning: PARSING: arch/sh/drivers/pci/common.c:34: two or more data types:=
 dropping int
, keeping typeD __init

; value =3D ([0], [0], [(0, 0, (Tag9 ((["__init"; (Tag2 (("__init", 736, 3=
4, 4, "arch/sh/drivers/pci/common.c"), (("\n", 983, 41, 0, "arch/sh/driver=
s/pci/common.c"), 4)), (0), ((0, 0, 0, 0)), 0, (3))]), 0)))], [(0, 0, 0)],=
 [0])
Warning: PARSING: arch/sh/drivers/pci/common.c:34: two or more data types:=
 dropping int
, keeping typeD __init

; value =3D ([0], [0], [(0, 0, (Tag9 ((["__init"; (Tag2 (("__init", 736, 3=
4, 4, "arch/sh/drivers/pci/common.c"), (("\n", 1014, 42, 30, "arch/sh/driv=
ers/pci/common.c"), 4)), (0), ((0, 0, 0, 0)), 0, (3))]), 0)))], [(0, 0, 0)=
], [0])
Warning: PARSING: arch/sh/drivers/pci/common.c:34: two or more data types:=
 dropping int
, keeping typeD __init

; value =3D ([0], [0], [(0, 0, (Tag9 ((["__init"; (Tag2 (("__init", 736, 3=
4, 4, "arch/sh/drivers/pci/common.c"), (("\n", 1046, 43, 31, "arch/sh/driv=
ers/pci/common.c"), 4)), (0), ((0, 0, 0, 0)), 0, (3))]), 0)))], [(0, 0, 0)=
], [0])
Warning: PARSING: arch/sh/drivers/pci/common.c:34: two or more data types:=
 dropping int
, keeping typeD __init

; value =3D ([0], [0], [(0, 0, (Tag9 ((["__init"; (Tag2 (("__init", 736, 3=
4, 4, "arch/sh/drivers/pci/common.c"), (("\n", 1079, 44, 32, "arch/sh/driv=
ers/pci/common.c"), 4)), (0), ((0, 0, 0, 0)), 0, (3))]), 0)))], [(0, 0, 0)=
], [0])
Warning: PARSING: arch/sh/drivers/pci/common.c:34: two or more data types:=
 dropping int
, keeping typeD __init

; value =3D ([0], [0], [(0, 0, (Tag9 ((["__init"; (Tag2 (("__init", 736, 3=
4, 4, "arch/sh/drivers/pci/common.c"), (("\n", 1109, 45, 29, "arch/sh/driv=
ers/pci/common.c"), 4)), (0), ((0, 0, 0, 0)), 0, (3))]), 0)))], [(0, 0, 0)=
], [0])
Warning: PARSING: arch/sh/drivers/pci/common.c:34: two or more data types:=
 dropping int
, keeping typeD __init

; value =3D ([0], [0], [(0, 0, (Tag9 ((["__init"; (Tag2 (("__init", 736, 3=
4, 4, "arch/sh/drivers/pci/common.c"), (("\n", 1140, 46, 30, "arch/sh/driv=
ers/pci/common.c"), 4)), (0), ((0, 0, 0, 0)), 0, (3))]), 0)))], [(0, 0, 0)=
], [0])
-> duplicate data
file:
arch/sh/drivers/pci/common.c
function:
early_read_config_dword
line:
36
=E2=80=A6



Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch --pars=
e-c arch/sh/drivers/pci/common.c
=E2=80=A6
NB total files =3D 1; perfect =3D 1; pbs =3D 0; timeout =3D 0; =3D=3D=3D=
=3D=3D=3D=3D=3D=3D> 100%
nb good =3D 159,  nb passed =3D 6 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 3.64% passe=
d
nb good =3D 159,  nb bad =3D 0 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 100.00% good o=
r passed


Regards,
Markus
