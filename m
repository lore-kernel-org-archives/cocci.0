Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EDECD8C88
	for <cocci@archiver.kernel.org>; Sun,  7 Jun 2026 11:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ep6p/ojbHOZHsAZCVPBHisQEwr73lmvsxb0RsRv5GfI=;
  b=t/uu7TR1Gy3l4h9PG3CaKgyPM6p2XhUBZLy+lZ3rI6ojDirbm8/0tCsD
   jr9pMjfN7286dWnzMICzvtLxywfUZIfSA1MgPXYoScCwxzVofwm2IUHnn
   tRYvSKHhVDx6pV41cj3FOOOIjpJqhDCOS3aCf+b8wYwtHhbadg6rDkmTm
   I=;
X-CSE-ConnectionGUID: xauyMJYdQ9GyLKqspsk4qw==
X-CSE-MsgGUID: Sy7Was3HSkKh8MmL/5XzHQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.24,192,1774306800"; 
   d="scan'208";a="280168036"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jun 2026 13:24:44 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 364CF80561; Sun,  7 Jun 2026 13:24:44 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D71D0804C8
	for <cocci@sympa.inria.fr>; Sun,  7 Jun 2026 13:22:06 +0200 (CEST)
X-CSE-ConnectionGUID: p4DfOPOcTNO/OzH7vRcfCA==
X-CSE-MsgGUID: RgQ9++4eTjmEswLJesFLew==
IronPort-SDR: 6a25545e_l21/4zlXolqraLNvNA6sdKlPcz9O3vbWorzARfulKMUrW1E
 Yc+Fpu+oFvBvptMtG0RxyXT+10im1iEylgVPTRA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HPAgCAUyVqg07ASNlaglmCQYEKXjQEC0mEWI9TgiEDh?=
 =?us-ascii?q?DuPEYxLAg8BAwENPREBAgQBAQECBIILgnQCjTQCHgcBBDMGDgECBAMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEhGQcOO4ZPDYJbgSyBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CDTpEAQEBAgEjHQEBEScECwsaAhgOAgJWGwEBgn4Bg?=
 =?us-ascii?q?iIBBhABAw8nBw20AIEygQGCDAEBBoJq13wfLCJbgWkDBoEfLoVxgmkBinInD?=
 =?us-ascii?q?4FVRIE8C4JHMT6CYQQBgV1Ngw6CaYImgQyENIwnUngcA1ksAVUTFwsHBYEjQ?=
 =?us-ascii?q?wOBBiMPPAUtHYEjIR0XFR5YGwcFEiAqbkYrAwMNITVZPzgKAUYFgV0CghpOI?=
 =?us-ascii?q?x8DOYEXgXyBKGdpFTE3FwIBC209NwkLGwQ9jSEXD4E7dYECEyyCSi3GBTQHg?=
 =?us-ascii?q?jiBZ4FmDIovlT8GEy+XUw6TCpkGjgmbN4F+JIFcMxokgzZQAxkPjjqDaTPEZ?=
 =?us-ascii?q?kUyPwcCBw8ChU8BAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:ycPj26Bvz+s2IZ/lHely55DYdb4zR+YMi2TDpHoBLSC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBDhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOk9K1vp
 0BT0ERMqyTMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3ArfbGaWiBcyxSEU9XdpCIJo0zeDJuaiHxwlDoBES?=
 =?us-ascii?q?EL0Eub6+1FkGq861Pup87?=
X-Talos-MUID: 9a23:YEY0fgu/SCeYBrzsLs2nvj5bZYQrv6mSCkUgiooimcSfGwh9JGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,192,1774306800"; 
   d="scan'208";a="148643880"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHr3V9nMe8MHGgKIRI8vd2IGhQ3XrXC487VvX?=
 =?us-ascii?q?EYt4Kr1/6+TCjjEznWLUQusrn0LUAqNvxGQaBYIlTtDXcz8uRjD8fHri?=
 =?us-ascii?q?tluteA7t/kL8kU1y+kWW9bHqSEl7gRDwmmDSg4ESqISJKvTp4F1/jmXG?=
 =?us-ascii?q?pOlCgGuJYxbbbseuAHWECn1Q=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 13:22:06 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkVwi-1wyPf10rzK-00cgjB for
 <cocci@inria.fr>; Sun, 07 Jun 2026 13:22:05 +0200
Message-ID: <06c1a8ed-1619-470b-b92c-974955a415a4@web.de>
Date: Sun, 7 Jun 2026 13:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <b90fe034-4d51-41cb-b011-d98565044a53@web.de>
 <876f76fe-c234-498c-9381-02697370dc18@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <876f76fe-c234-498c-9381-02697370dc18@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qa9mQBF3UI6zUoyXiRfxmf7KjBgtNOF5QhE5xPS0qcPk3MaePDF
 dYtvEUzoRBe1u//sDHlqa9nG7XTy5192hm/4cT1aOghTRyRDOExMo1MxKyD66d1K/BkSca6
 Qfyeb5jvm2DGoMVANCPF3E50OwxPwsd5cdsnaFDifxs527+q9PnofNCWqCnGCeVO1cfxPz5
 2ZZpa3FmOhctH9r2calPg==
UI-OutboundReport: notjunk:1;M01:P0:LNNBU4/w44o=;3iEP6/ts9qW/Rl2LYsgfTj2UzgX
 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
 GeNVReFV/u39emoK+hvAah9RmO8cGpkY2aoc=
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Adding a string literal after a string literal with
 SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3556
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/sloLwnbAIofC4bKjY6HMow>

> Under which circumstances will the following data processing approach be=
come supported?
>=20
> Another SmPL script variant:

@addition@
identifier action;
@@
 action("My test"
+       " case!\n"
       )


Questionable test result (in combination with the software =E2=80=9CCoccin=
elle 1.3.1=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-parse-cocci add_literal_after_literal.cocci
=E2=80=A6
plus: parse error:=20
  File "add_literal_after_literal.cocci", line 5, column 17, charpos =3D 6=
8
  around =3D '"',
  whole content =3D +       " case!\n"


Would any more software users like to achieve that such a simple source co=
de transformation
can work also with this evolving development tool?
https://en.cppreference.com/c/language/string_literal#Explanation

Regards,
Markus
