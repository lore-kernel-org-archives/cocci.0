Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328E4C7EE24
	for <cocci@archiver.kernel.org>; Tue,  6 Jun 2023 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WRvxYsYxfwiFiCr323envVLryGcvEtwQBYjtAz7mm9c=;
  b=bzqdxkskAGzUh3SicaWO+HGUlSa4Vu1c2BStUe/xsnju+kFrCYyPURMg
   owxs87mupFHvoaU3T4nqUakjW6I/1QebEl8Mfpuaf5is13tgWYQkQIu2O
   qDvcz+AdKJCCHplwOtbeIdwJc4xwdQkfNR3BQUdO367bx88rpmxlIHy+Q
   k=;
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
X-IronPort-AV: E=Sophos;i="6.00,221,1681164000"; 
   d="scan'208";a="111563337"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Jun 2023 19:16:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 95B49E0CCE; Tue,  6 Jun 2023 19:16:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 76F1CE0094
	for <cocci@sympa.inria.fr>; Tue,  6 Jun 2023 19:16:04 +0200 (CEST)
IronPort-SDR: 647f69d4_aFlHfoxcm7BQSNc6O67Hv7wbkeoE9iypLd+339KSneC4dHq
 NR6QaEXB0+dl1LIHuLmDeq0a98cqiYcnYIO9ouw==
X-IPAS-Result: =?us-ascii?q?A0HKAABmaH9kh07ASNlaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFPgi91A1MwBAtHCIRKjyqCJAOEM450ilaBLD4PAQMBDT0EA?=
 =?us-ascii?q?QIEAQEDAwGBTIMzAoVpAh0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgQFAQIQAQEBIxcHDhAnhWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOj8BAgIBIx0BAREmAQQLCxoCE?=
 =?us-ascii?q?RUCAlcGDQgBAYJ6AYInAQMOIwcNBq4RgTKBAYIIAQEGnA4fLCJVgV8DBoEVL?=
 =?us-ascii?q?ZFgJw+BVUSBPAyCRzE+gmIBA4EXRz+DHIJnji2FA4lEgSlvgR6BIn8CCQIRZ?=
 =?us-ascii?q?4EKCGCBdEACDVULC2OBHoJVAgIRKRMVBUl7HwMHBAKBBRAvBwQyHgkGCRgYG?=
 =?us-ascii?q?CcGUwctJAkTFUIEg10KgRJCFQ4RgiElBA4DGSsdQAIBC3A9NQkLHwZCAiuBV?=
 =?us-ascii?q?zBYcAokJJ1DA4IPbAaBOwlqgSzEJzUHgjCBW4FdDIoSlQkGEy+XEw4Gki2YE?=
 =?us-ascii?q?41amlqBeiOBXDMaJIM2TwMZD44gGYNbM4ELjj0/NAIJMAIHAQoBAQMJhUYBA?=
 =?us-ascii?q?YV+AQE?=
IronPort-PHdr: A9a23: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
 9/SiOTsJT0E/9+GpaMh
IronPort-Data: A9a23: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
 d0DgKbOyckwYNicTSjB3Q==
IronPort-HdrOrdr: A9a23:JoIE868QeIWXIu8+T+Fuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re+cjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AOKKaUmh7zRLyCo+XbAG10mcT0zJuSGHXyHnTGFW?=
 =?us-ascii?q?DLWtqeLalUWbM4px7qp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AETXO9AyplBvX3Z/G6qQd3KzN9+uaqIT3KR5Ko5g?=
 =?us-ascii?q?YgcneEjxJfBWA0yqbRZByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,221,1681164000"; 
   d="scan'208";a="111563323"
X-MGA-submission: =?us-ascii?q?MDFa1STAzdTViMhOnJOxSSXt/4Qc/HXXCsuX0W?=
 =?us-ascii?q?ihLkza15wtoCTgz/cc2FnFXZsKrtmjRJGy4pkgSU2FHS1fwHIGhTtNq+?=
 =?us-ascii?q?bWvNncBiH63IoQK12ymI3kHMGWg0cKdMJu3KJ/DRC6oG6qDLQZm7vV+1?=
 =?us-ascii?q?CBPAqhS63NHFuUe5D+C3m0Vg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 19:16:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686071763; x=1686676563; i=markus.elfring@web.de;
 bh=SKjH80p0+SJ2a6jju9dTE3MTRnRmV0VCLVE4O5TjHYE=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
 b=YHrSTY5RPmjgDXU1iJIwP33zFzObhjSI08NemMOHCE6TO8ayJ/5hNOtnUrW33WcYBNI/Ltc
 DbJWMUCFO+4gEA3kqHfIq5biuoCjzTW/nAyT/g0aqNR+0ZkrtiMepNrbO7/bqKCSLCc2Eb7my
 ewJExrlF62wfrhAtF186N4OzFmetuZkuW7P/Vj4v6tAxcr80eT+P3PYSnv93HDxWnnweKyWBv
 xkGG8R8axu2cvunO4m1rjplwPCX+Q6TpkjbgjEP3XwWjLVZRuyRVACh2uDu9jppLwjfaWxHvk
 losBRSU+V7wQY351TH95X3DzGvDFUJ9DrPAGPo2h4tgP5V06ScJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkElP-1qUbJS0reb-00kG6b; Tue, 06
 Jun 2023 19:16:03 +0200
Message-ID: <4bbe0876-0184-478b-45a9-93b9286cac0b@web.de>
Date: Tue, 6 Jun 2023 19:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
To: Yann Droneaud <yann@droneaud.fr>
References: <5ac0affb-f517-7caa-d622-3b11acc96c7d@droneaud.fr>
Content-Language: en-GB
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5ac0affb-f517-7caa-d622-3b11acc96c7d@droneaud.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jx/VLiXgvpqQFUsaPx4WSc+mXNZqFGppgBa6+KNxkFTPPsSt4n6
 v4ujzQ9J1UTx4Qr67hBL04oi2lhZKPL4mrR9f52TXiMr45IaflOarM9OzQoOHxI8axOauHi
 m0Kq6WzdEwI4XW/pmuHprvd0HnNfv+pHCcEOFcLrBcZim7Yhr9xjLrLPOWhJBaaCrQzXn8T
 UAMBSMzRpJM2BK+kQFtjw==
UI-OutboundReport: notjunk:1;M01:P0:NDdYeuGY7CE=;k6H82qtSHJILCCLoIdXwQGOQjSp
 pP1mMizUt3LoVni5awgoBTm6yVA6hTSI2eH/Z3nrM4l9TESjSEI1Pd7TgjhFbERpYi4tCf6Uk
 /no7/NFnGPiFBKaOolQN4X5S7UA+ry2ca+wsRhjRZBM3L3NegidLVE8VS0K0JkS5VUxjeUwQ2
 1y8OTbP6nifq1GwxUY1XNaLtS7/9hZeN/MP9liOiPixJAveOAvv0Bba3uZB/pS1Gkhb1EGhw8
 foqKI09DMG7dFf/8TIF4QtxG+9p2Xic8JlsAH/j/l/JMRndF7AR2hObuH/lSsSDzCZ6+MXXmR
 XZXNaDk2U20NOtty0xiBX9OLAgUcImEzRzKVxk6d9nnpHawWNwL/xlxqcxpdeV8Zx4bzc/twY
 PonRvP+YgWeim7wu6z7yJiaJvR3ucdn9lq4iGvPp+sA8dPJ1n8KkbYGD3ASeV0af81DLRcP9m
 lqV/NOA45c4mLaAxwabhdPmS7er29UaShiV5WDxKYQPyqInTJNlp26Eh2BGGRljKDffm5tBi8
 oeiUjqUsv1KusnTszKKS0TJvJwg+TJqkQa5fvsBlw0oGbARaWci8IpCNu5bjMbALmJ9o+O6BT
 B881h/i76Vw1XtU5p20fUtQsneXajEpZWP18vXADCKq/SQgiID5j7btzNKqYbmrQIpOFC6eMs
 C0hWyJmfp1PGPjxpVyaaASPb1dp+KdMa1E8yieVUrdp0UAE24INE/9uXfGqne2mg8/8x8U14x
 wFV7sfKZzWwktgQxs53isUevIWyVaKVzCr+xgy4YMTob7grP21rky13GOjR5OhbBMIFp/FcIV
 oFDN8mWbgGkhIECbvW6bbyQ7lJzwzPFx8xh37RuKfBoHL+A80023iovQpCg8vQBbCvauk+8DS
 iG7qudsLa2zCp6pAVEbRa73O12N2zYse3qzSewmIEmqPgHzGz9n37qatAF15P/tiYvJMV52i3
 cI9ONA==
Subject: Re: [cocci] Matching the size of an array
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1171
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/4bbe0876-0184-478b-45a9-93b9286cac0b%40web.de>

> I'm sure I've missed some ways to use simpler constructs.

I suggest to take a few additional SmPL code variants into account
(by increasing a possible change granularity).

How do you think about to use a SmPL rule like the following?

@replacement1@
expression DST;
@@
-snprintf
+SNPRINTF
         (DST,
-         sizeof(DST),
          ...);


> The example can be found here, with the test case:

https://gitlab.com/ydroneaud/snprintf.cocci/-/blob/cf9d49d31dda5d3e6af94a3=
8c998d31356b2a177/SNPRINTF.cocci#L8

Does your SmPL rule =E2=80=9Cas_variable=E2=80=9D indicate a need for addi=
tional isomorphisms
according to array variables?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/6608e45f85a10c57a3c91=
0154cf049a5df4d98e4/standard.iso#L465


Would you like to increase the usage of SmPL variable lists
instead of repeating a key word like =E2=80=9Cidentifier=E2=80=9D at a few=
 places?

Regards,
Markus
