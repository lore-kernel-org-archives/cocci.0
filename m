Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D676C83030
	for <cocci@archiver.kernel.org>; Sat,  5 Jul 2025 18:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=bibURbGOjubPsEAg2xSN5qVVNGZGkISJNtjiwpLZpwg=;
  b=jZeNPUvOH8M4I1YZP+Hx3u363PNMkbxaY8DmRsNEfWVsLahmwq0+T4mS
   mcv8Ylzpefcz4JEwFCGP8bzXhJLvlbu8dsM4Z8iSKnJfdFJDSKz9Z9SZP
   YjeBdNQfj12GDPpFGensVCEuu6va7CvphkCrNVFPGdTy7vNMagPJRI+o+
   s=;
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
X-IronPort-AV: E=Sophos;i="6.16,290,1744063200"; 
   d="scan'208";a="230463653"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Jul 2025 20:20:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1F21DE01A8; Sat,  5 Jul 2025 20:20:51 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9A4ECE0131
	for <cocci@sympa.inria.fr>; Sat,  5 Jul 2025 20:20:46 +0200 (CEST)
IronPort-SDR: 68696cec_ZEb3QwNUb/OYMgkXq+TjH4WQwm0A5Bha0MzN1I5HFLwQmjd
 SqAJwQw72vgD3aQc8tkmiu1fENZXo0AiO8QAPWw==
X-IPAS-Result: =?us-ascii?q?A0GiDACobGlogAwR49RaHQEBPAEFBQECAQkBFYFTAoJCg?=
 =?us-ascii?q?QAGVDMEC0kIhE2PUIZfjw+IeIFVgX0CDwEDAQ0UAQE0BAECBAEBAwMBggyOc?=
 =?us-ascii?q?AIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHD?=
 =?us-ascii?q?goxhXsNgluBLIEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQECR20dAQERJzQCJgJzAQGCfgGCIQEGEAEDMgcNBq0dgTIUbYIMA?=
 =?us-ascii?q?QEGgmnXdR8sIlmBZQMGgRsuAYVsgkoaAQVtihgPgVVEgTyCUoNQAQOBNnWDD?=
 =?us-ascii?q?oJpgiaBFoJVgiSEEoh4hliBShwDWSwBVRMXCwcFgWMDgQ8yPDIdgSeFcYEOh?=
 =?us-ascii?q?CkrT4UQQViDUyRtDwaBHYEOQAIBC209NwkLGwY9knCCZ4IAgj2TOrJ7NAeCO?=
 =?us-ascii?q?IFnBYFfDIkIgSaVPQYTL5dODgaTApkGjgeVXTmFIIFoOoFcMxokgzZPAxkPk?=
 =?us-ascii?q?lSBC8AiQTUCCTECBwEKAQEDCYVGAQGLCTOBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:5IJOBKk8cx85JEvYjZyRWj/o5gyvIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbWTuGb/jYM2fzc9t3b4zk8EgGu8TSzoRhGVM++SBgEFtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTrSs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82Ayazx8B56r8ks14ayt4G5A5DTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN1lSx0RZqdFxd9MGG5k/
 8NCcQJXTVOq0rfeLLKTEoGAh+wmK9T3epwSsDdswFk1D958GMqFGf+Vo4YHmm5q7ixNNa62i
 84xTDN1bwnbJTBLNE0WDp0Wg+qiwHXyG9FdgAvP/fVqvDWJlGSd1pDiKsrse9mUSv5zpVeqn
 0/h022nHT4VYYn3JT2tqS783rSfwksXQrk6H7qz/f9Cm0yW3mVVCRsMVFL9r+PRt6Klc9dYN
 lBS5Sck66Q/nKC2cjXjdxb//FnflEMjYuFJHMcw11vU+PD3oC/MUwDoUQV9QNAhscY3Qxkj2
 VmIg87lCFRTXFu9Fiv1GlC88mnaBMQFEVLucxPoWiMpzrHeTGwbixXSUpB8HaTzgtCd9dDML
 9Ki/HlWa1Y71JBjO0CHEbbv3WjESn/hEFVd2+kvdjj5hj6Vnab8D2BS1XDV7OxbMKGSRUSbs
 X4PlqC2tb9TVM/Qz33VELpRRtlFAspp1hWD3jaD+LF+p1yQF4KLIdEIvlmS2W8yY59VImGBj
 LH7418Lv8c70ISWgV9fON7hU596ksAM5PzkUfbTdZJVb/BMmPyvrElTibqr9zm1yiAEyPlhU
 b/CKJrEJShAVcxPkmDoL89DiuVD7n5lmgvuqWXTlUTPPUy2Pi7NEe9t3ZrnRrxR0Z5oVy2Fo
 owGbpXTkkU3vS+XSnC/zLP/5GsidRATba0aYeQOHgJaCls4RjMSGLXKzKk/eodoua1Qm62at
 ju+Q0JUgh63z3HONQzAODgpZaLNTKRPiysxHRUtGlK0hFklQ4Kkt5kEe7UNILIIye1EzNxPd
 ccjRfmuOPp1d2n4y2wvVqWl9I1GXza3tD2KJBugMWQefYY/Zgnn+e3EXwrI9QtVPBWWqPkRn
 ryE/SHYSKolWA5NIpv3avWu7lXpplkburt4cHXpK+lpWnfH0dZVOQnuqMQoMucwKRnn7RmL5
 Ta8WBs3i7HEnN4ozYPvm6uBkbaML8J/OUhrR0/g8re8MHjhzFqJmINvfr6BQmHAaTnS5q6nW
 ORyysP8Ot0hmHJhkdJ1M5Rv/JIEy+rfnZ1o5SU6IyyTdHWuMK1qHVee18oWtqFt+K5QiTHrZ
 m2xoOtlKZe7E+K7NmUOJTgVTPWJjtAVvTjw0c4bAmvH4A1Pwb7WdnkKYjetjnRGIapXIbEV5
 74rmPQr5jyVjjsoNde7jR5oyVmcE0xYU4sbm8EbJKTJljsUzkpzZM2AKy3uv7CKRdZ+EmgrB
 T62mKCZuex4wEbGQntuFkr2/PF8gK4Ws0tg124yJFWum/vEiMQo3RZXzy8FcwRNwjhD0MNxI
 mJOJWQvAYmr4BFTm9llY2CgPypjFS+p0BX95HVRnVKIUnTycHLGKVMMHNqk/Wcbwjp6RSda9
 rTJ81TVe2/mU++p1xRjRHM/jeLoSOFw0QjwmMqHOcChNLtiaBrHhp6eX0Y5myHFM+gQ2nKe/
 fJL+dxuY5LVLSQT+q03K7eL3IQqFSyrGjZwfuFDzogoQ0fnZzCA6RqfIRuQe+RMBcDw322WN
 shMHv9LBjOCjHugjzZDHqMdAa5GrNhw7vo4R77bD2onsbyekzlXjKzt5hXO3G8GftE/vvs+e
 6Xwdi2DGFO+nXF7uXHAh+gaN3uaYesrXhzd3ue0/L83FrYGiuVNcF4z4JSwrX66IAtqxDPKn
 QLhNov97f1u9pRopKToSp58PgSTLcjhcci16yWxjoh+VszOOsLwqA8lkFnrEABIN783Wd4st
 7CynPPo/UHC5pAabnv4nsSfKqx3+smCZupbHcbpJn18nyHZesvN4QMGyl+oO65yj9JRycm2d
 TSWMPLqW4YuZO5c43lJZwx1MRUXUf33Z5i9gxKNla2HDxxF3DHXKN+iy2TSUlhaUS01ILz7N
 B7/vqe/x9JfrbkUPiQ+OdNdP8ZaLmPgCIwcTP+ghQnAWyPsyhmHt6D5nBUt1SDTBzPWWIzm6
 JbCXV7leA70pKjMy8pDvpdvugEMSkxwmvQ0YllX7useZ+pW14LaBb913VQ65pBofuja0Zble
 HfSYWFkBSiVsfGot/njyIyLY+tdLrVm1hTFyvgB4E6eLSu7bG9FKKU07T9uuh+aZRO6pNxK6
 rgiFrnYIRW7hJ1kLQrWCjpXns8/rs7nKrk0FYwRXiA879vywVnH6ZC5IDdwaA==
IronPort-HdrOrdr: A9a23:A3spXazPCUudvT6n4//5KrPwDr1zdoMgy1knxilNoG9uA6+lfq
 eV7ZMmPH7P+VIssRQb8uxoV5PufZqxz+8W3WBzB9mftWvd1FdARbsKhebfKlbbakjDH4BmtZ
 tIT4g7LsHsBl5nisvA7BC/CMtI+qj+zEnlv4bjJ2wGd3ANV0iM1XYBNu4Rf3cdeDV7
X-Talos-CUID: =?us-ascii?q?9a23=3AYjZ5GmrrTNvaLJ9Fl+Qc3/jmUctiLlqG5irvGnS?=
 =?us-ascii?q?hBkxjd+fMewWzu4oxxg=3D=3D?=
X-Talos-MUID: 9a23:KhsuTwTbGMCyqUcWRXTjniFbNcJ27J+IM1E/qLghl8DaKgN/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,290,1744063200"; 
   d="scan'208";a="120757520"
X-MGA-submission: =?us-ascii?q?MDFyRuogYHK8yriE0/5VW1qPeQw3op9m8D/oYt?=
 =?us-ascii?q?UbL630OPpfWKNt5WamaFGILJoIy+KnuGxqGuCatGdysfzB4CyLiCcxWg?=
 =?us-ascii?q?V2LD2NWndmR2eebGjSDq160EolrwxosIpW6G6huXO9yGz9cba5mhNpKE?=
 =?us-ascii?q?+EO42g96I/UiwS+Yo4Eas5GA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2025 20:20:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751739627; x=1752344427; i=markus.elfring@web.de;
	bh=bibURbGOjubPsEAg2xSN5qVVNGZGkISJNtjiwpLZpwg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FC+Zcv73igh5+qxhX8zLd0tiVrZvA0rs3mqyow0OvN879PGfYeOQ2TyOdOOw9R88
	 HOmc3iLg+Qf1rzYwxtz1ufinUYvCMx+tL/A21gHzH+d6FJxsefH1At0TBWHi+cRto
	 GweQCVtGto6siamGTPblYU6VvI5PWkmNlU6Btq4d97biHR9uPfxhtwH4QI6y8PpOZ
	 Qgs65kGK8DhraKOlI4NeFnCBIfIdblBf5VTXdopAPZmF6lez92fbS6qKoofOb8wLG
	 JRV4B6eqwS55KZbuNPbGxVb76YrpA5591WkjNyVnnf7qwUhgsibdeif8nsd5Hb9eZ
	 tTAmrw/L1vKCqnmJCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MS13Z-1u5ghs0Wzb-00IFZS for
 <cocci@inria.fr>; Sat, 05 Jul 2025 20:20:27 +0200
Message-ID: <866027f2-598a-4aff-80ad-f9067ee2a951@web.de>
Date: Sat, 5 Jul 2025 20:20:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uW4pMKiPWoU+rR+AN4pEScpUgSb1RaIFVIW5FE24ZdAQgpDtzA2
 M6EImkldb3xm3VeD2rGQw2m223Ky56nedOD4GM28OuDksgTq1CiB6k9aC8pzt3geVZxqcQ8
 eDyAnno9QmE3XEo0MUdC3kVosUPhyKynLx09/fVsRXiKVTIBNNUs23Y24KJ8ShuxdWaCAMt
 AdLn3M1IqkRdlx7EE9b3g==
UI-OutboundReport: notjunk:1;M01:P0:R1Uf9Vv4AQM=;Dx+re16tnxRbyKFmNCHKooHRcK0
 AHiNNpIyfujKZWcGC1Md4+W9QQlr35HKHxt+gouDcIRUYTMhZsfc5nKFxnnuz4u35rj9oaFDX
 P8OMayP3TCDn+K+bOprcDPoetz0VDmvkjeQE6c/cDMv3y3bAOJTfHZG7RdUG5Civafo/0myzH
 m+q9+EDbULMFBUIHTzeg3nCSGXu//QgPg68THtVMWYVT6RDF2JwCpDAqm+bvpF0fmBYl9PYqg
 ef7Nt/71e5hLzwFuUyRgQl7fiCw9v2EX6PFHBH1StfKWXkpC4vpCJId2QrTiJNeYabQj0sp65
 GpgomdEulhF9X7FKETXilGOFWy8DbRTkDJfC0nipVqmS+HPMBHW8l7cSeUxIAOLBm0Mn06Vod
 dZrcBXqqgBTVI8qpzbZS8goMFGUPsgWXYQBq4RwZ1DpbcmPXGnmWNeBHAmNotUy9q0RmUssQy
 6NpKE1nUc3OywukI5ZInlC269W0u90ZMUxHXZYWvr+0UCJotF9eyn8POWdWNnDBTZ4nkb3jMO
 WzY++SH9ZlesVTzgiZAHy6mwV+GQ5UUw6jSLsi/svvvRRLxEUoJocbi8dnD3btL9bqkTNE7Fq
 lmpYg0YN4Na41WVcNxk+bU4xqUROwW3I+E+SubFoFQOh2xws/twT0eOicSJmTEs+hM15BTRq/
 uHAs+L8WannUlV/zOEiDsnBGDUB3RfPKE3VqxfyhyCgb1JXYiOXpQOyuua1yxblbDAnxEIkql
 Bc/YTuuHMQuVopA4Zl5FdtHptYN2Lrolod+nxxGuqMKbpHtrh6DP3IlJ5LzVGfmJXmmOiD4kR
 qPZSFRuv2oKbj/Aqg45Z1eRitAv8a1E9WCXNdpI2GZRtNmx+JZXszwYCeCAQlt8Ezl7RBtapj
 UaCRINW8NIXVsLMSFZroFHzM8McqYHUx2DP07Kqe90cksZrTTmWMJMjm0iWzI5NrD/5Jwmrz0
 sSnhF3vra1fSNPQ8oA34Ku0ZWO1GAqY7TIV6XblFaLnfbSJro8lNtf9rWgYzm1DJvjbvnCVpb
 EtzgopM861bcxHF4PU+U7FbBFCkhv1Q2lcaDR5Cj+mWR9mVQfzRdPnIQ3zEGB4Q4MISgmNijR
 g3tbNJCdFZW8yZaquNlXxe+9vPy8M2xhey0AaOXcGaW3FdEeUVk7Ldc4pOONN+xp7C5nZjc1u
 VEFt24BeTfdxUFtJWOncsCcJLE6adpExqmk29yZOE02zHqhfMqIsPYBzoSL92phDqJADrUkqG
 c82rJscr33JkwCCERUL+pOcGpFmqdpJQxMUK28bctO9JwaLs7FHarqQHYAcaaDURn+j6/PckP
 krC4/p1L14yOOTv51v0FCtC/HJTwshWn7ouWtRCyeM1BEZXQDhhWRaZBE1M0zHPHjfchMcLqf
 +148uU3sGmTJxA8aTyOn4AnlgUpl0GRkGT3ogWSAhJUruGT333E/old7UJ8Un0JJTCtkm7SOG
 wXfuaf1lW+3126WtRso/bZHi0mS0z+4NdYDtNl/NEsZwpjMkaZ5LO4x3WJ3AypU/0fAqZG2pH
 2SP6VuLmxYFMB4Gc+6CnaTImUtcMWMJ8JnSdS8dHDAECQET6LfqllG7qCI26BDKsIo+qwJVFz
 2vdzIQxVv/ezifPg60iiEqF1H2BsIinh6j4prr5akrt9llLE2SEk97200r6dGdwMacBfXXopa
 lbt4tzfXFZG7+6Bp+vmq99rxOUM3VenSe+/vhOKFQ+gb1gIPAUGJvayivYfS9f6zOKExUryYM
 p/1/1cylvK8VrkUt42DeDPcr/SMN/V88rSFsUedU4alQmptjVH5jp6D+oDA7wmJzaL3KLSQ9l
 NRDpZ697GscS/jfS4K9S8jJnHTPk0QP74Aw8x4cy5M7WxYUgrD2L/dpmP+x5Rktx9PGU/G2kj
 L5cpWpz4uroYwdJ7UllORwwDgy9LwiynOz8Fpr7mq2ZcaYKanL/jgpTeicmRxR8jRaPf/hEi9
 VoIbrgjeFAQMFK4hQ5646mIemyc31O8BTZzDDg+RzuPg1NTSjpfD4YxdnK70cf1UMDvKSI/Xk
 FKFFljdxiuxnmo1RjBtDsvSvkxl95ZKyO85Bcdid5M5GIM+ef9VZwXdXipJJt6ydFTflsgv6t
 OfunY+LbikS29KyIv2CWkZ99xd7APRaxAxPFoyBIFHUSZGTEO/Wr2PGQDWTfgE8vFxdplPqjB
 9zzAwoOYldt1bJkhepWz7vg3ek6Nf9OgCtMby5kNrMxyXeSzkEVsXCh2zEajfpIltHj/T2X2G
 C0C8YfXvmvxyLhXYCV4j54cKvlOVpjn3FLkXoBYQ62RQpMWY2gg2TVZev3S7mG7HKjTRxwYtU
 2rSVCQAjEvov9sEW65ga3ByjAMHANxnSJIpooQtgixwTcaAPcBJoR4oklHXFKq0w6d3rfsK7+
 S4B5OWvpkKdU8Qb54Hjdj3ISr+DzLLYYJ90CByszRu0twmm7DPq5gy6kJgeACjiTgxI5GyANH
 okYByAgL7sFEQovQonSw2eCkJy4QP2GHp5Dkt/nWEbu2N7hz8DtTBe9H30/9trEQQ5BiXaaD3
 IjQXD4RrGEIzKFYhoachtYI0NPMawQuVevGorpGIxvtDz4re2rfWuoNSidrFV/P/lAUjtdGeV
 puF+UAPFzrBBbFHUH8OMCKVGFhi9BtvcF5YhJKLwAPDjRcVWdHHFGb79lztkeqpLr6FANZwYq
 t25meouZa/EllovnRfUGGBMVt5l82wprPnj6slDvc7AL4K62bpkGaytcJCStbrci/pduTBy7F
 6PQA+ErJabnVs8ddZDec3XMQyDS/AhH2b2kZWe9zRJIgdXV4Ymue0t6IM+osYmmH7MCrVbzTX
 CG4ZTcmeAtaZ2lWpQ7vOEwcVB/3Mrx0IwSyZCdh01MIdGehxgyS1GjZ4/J6lqAS07CWkkv+DI
 94m+LIDvXSYoeQmXI6TG2Q+pqObJdS8q+TzlVLbnqMy836TpzjRDFUV1PrOU5Hfr7FM2IXUDA
 rfRxtTDwHwhozGzoVMRhjeYphQR9lsLx2C0JPlYfC0YhNHUIQ+uWuAkuM6gCDrXnpHNHF2w83
 FMlxGny/Etbxh8xGjvPHh7ArSHs4MnFeVOW5yYEJNEQhkINss4GgIp0Ic0CbzJcQL+LpXfeSe
 mY+7X1+xig3sX4su9K+H4WqDyy81FMJvskMhbYS7rnWMXFMPfJSkIw/IWELb03P0CXsJV0gOi
 lW9W/Ev7dZ5qGznMSihexEMCAGsRCQh1ocam0CfuGcWoAeYar+PCCX5uTX8bMvJ3sHMnpNXyb
 oq5D6vKVyWalTqFHHICBrCDyQlRFGPFHBMjTX2M8lx2azLIffBmULOP0awrI6yrH42iOHLc7K
 1zB5BVP3xLozRACBNoJ47awvEuAlL9s2c4OW4Mmv9PY+k9LLCIChYR9n810X7jP9HDM6Qse2v
 HStcoLzP5VMKaZiwikoQBqFlMsGk39b4zI2JnyQNc9jaP1o0J57dwmL3INggNANCCRxPTr24l
 fSP+nhV7OBg==
Subject: [cocci] Support for position variables on comparison operators with
 SmPL isomorphisms?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2856
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/866027f2-598a-4aff-80ad-f9067ee2a951%40web.de>

Hello,

I would like to attach a position variable to a comparison operator in ano=
ther
script for the semantic patch language.


@x depends on org || report@
expression limit;
identifier i;
position p;
statement s;
@@
 for (
      <+... i =3D 0 ...+> ;
      i <=3D@p limit
      ;
      <+...
(     i++
|     ++i
)     ...+>
     )
 s


Unfortunately, I got the following information (by the software combinatio=
n
=E2=80=9CCoccinelle 1.3.0=E2=80=9D) for further considerations.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/b00c5adb1a485321c8845=
0bdaa9e0d9ff93123dc/standard.iso#L316-329

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next2-patched> /usr/bin/spat=
ch --parse-cocci -D report scripts/coccinelle/misc/show_questionable_count=
_limit_checks.cocci
=E2=80=A6
warning: iso gtr_lss_eq does not match the code below on line 50
bool (i <=3D@p limit)

position variable x.p conflicts with an isomorphism
=E2=80=A6


Will any more software adjustments become desirable accordingly?

Regards,
Markus
