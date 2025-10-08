Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D793ECCA470
	for <cocci@archiver.kernel.org>; Wed,  8 Oct 2025 11:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KA7JjW0nxc+oitqSNpPoSjlnb83sv9faV/zYNM+vTA8=;
  b=rv23VssmyhV2pDR0/Wt+jMwoOmGNEO33gz3jZTLYAZBWqJO2j1cPxx3V
   P8JN1OQNmobpuo4/RteEBvPlPSHZzhtWwustYA3qxC0iLNB2D24gyOQnw
   5n5lr38/RqhbrM2WQpBZz5z7XKWTwchO7HrQLs9DyE+DI6Z+yN6UFak/6
   0=;
X-CSE-ConnectionGUID: Ee62r7eoQayy7wLXEv4oZg==
X-CSE-MsgGUID: ysObEqFbRLG5kegTekWx9Q==
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
X-IronPort-AV: E=Sophos;i="6.19,323,1754949600"; 
   d="scan'208";a="243097551"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Oct 2025 13:50:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3DE38E0172; Wed,  8 Oct 2025 13:50:35 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4DDB8E0172
	for <cocci@sympa.inria.fr>; Wed,  8 Oct 2025 13:50:30 +0200 (CEST)
X-CSE-ConnectionGUID: WxVrOw08Se6DbS7JgPmdxQ==
X-CSE-MsgGUID: 3BqPpXudTtyNY4Dz1ukOJQ==
IronPort-SDR: 68e65006_Pbi2mfjJ5EvTJjQMOVrUERndSwvqScYL04Xet8tslPs1s4P
 xlRzNiiIJMCQboPZO+Y7xJ0I7JmTUDFipATK3hg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HxEwAQT+ZojwsR49RaHgEBCxIMQIFFC4JAZR0GWDMEC?=
 =?us-ascii?q?0kIhE2PUoIkhDuPEYpOgX0CDwEDAQ1KBAECBAEBAwMBhHYKAoxHAh4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQI6BQ4KM?=
 =?us-ascii?q?YZPDYJbgSyBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAkdEAQEBAgEjHQEBEScECwkCGgImAgJWGwEBgn4BgiIBBhABAw8nB?=
 =?us-ascii?q?w0Gkl+cRoEygQGCDAEBBoJp13YfLCJZgWQDBoEcLoVtgmQBhVOFECcPgVVEg?=
 =?us-ascii?q?TyCUjE+gmEBA4FeTYMOgmmCJoEVhkGCdYxeUngcA1ksAVUTFwsHBYEgQwOBD?=
 =?us-ascii?q?yMPPAUtHYEnIiMeE2Q9F0GDTBwGaA8GgRMZSQICAgUCQj6BaiIGHxICAwECA?=
 =?us-ascii?q?jpXDYF4AgIEgi+BEoIqD4M0AgELbT03CQsbBj2Rf4J5gTnIejQHgjiBZ4FkD?=
 =?us-ascii?q?IoulT4GEy+XUg4GkwWZBo4IlhmFIIFvAjGBXDMaJIM2TwMZD44hGYQagQuyT?=
 =?us-ascii?q?0E1AgkxAgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 twCR+0CPGE=
IronPort-Data: A9a23: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
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:HAFDq6n5opAI9zdvHQf6wwThL6LpDfIv3DAbv31ZSRFFG/Fw9v
 re/sjzuiWftN98YhwdcJW7VpVoIkmslqKdg7N/AV7KZmCP01dAbrsC0WKI+V3d8ljFh4hgPN
 BbAs9D4bPLYWSS9fyKhDVQROxQpeW6zA==
X-Talos-CUID: =?us-ascii?q?9a23=3ALCPXxWgaC/noxNkztSrH7iNbAjJuTW3j1lDPex+?=
 =?us-ascii?q?DBDhFQobKa1Co/a90qp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3ABmh6QQ44mFHPn4WFG8bL/Kpoxowzyb2WEHAQnak?=
 =?us-ascii?q?aqu+1aQBiYiqeqxaOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,323,1754949600"; 
   d="scan'208";a="243097519"
X-MGA-submission: =?us-ascii?q?MDHHLK8RiO9FpYU9H0hlKKZWsj4SDh1tmIcvaW?=
 =?us-ascii?q?7xxErL7b36i9DvRT8gdc7R9OVBGZp8Rf0AXsb9+k64QQgxbbGatOfmuA?=
 =?us-ascii?q?wDPNcTUzA9kz5BGLPCu0XwxNJk1TQ2i3vytArCIaLvdJyoOGJ9QA+Jli?=
 =?us-ascii?q?XGbup/uDELWnqTGxFVXgC7Hw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 13:50:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759924229; x=1760529029; i=markus.elfring@web.de;
	bh=KA7JjW0nxc+oitqSNpPoSjlnb83sv9faV/zYNM+vTA8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=p2bjvtxksS76z1eT6X/ZW0cTCtUvsG5i5PwVyj2THxuu/MvHGiWQr49ztAazvXjA
	 hr1a8g0Uq4Vklm52sY6cTTMno3o4ZF+LIxEQb4W27ZrKnhWyHoiH+cAORv/3Zk7M1
	 Hd0cNmu4jUMZlIvLdG05PEZpKEpH8mHOIYpD5cJ5LjdCHHAuOcGYJBEm7f+6EUVOS
	 FCC9iE4fs9HMIW0HqeTFlbp86289U3jLPzP3+CQpVeD2qOh3euYF8oz5QjWu4+LcY
	 noY+HbAPAAE1/i2dq11j23BzyymQAiEz9ixOmIsoMaXq6Jofkj4IjCgVQxHVHQzJj
	 DHOKSizIusaoEbk6AQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.249]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mdf8F-1uXg6C2bvl-00kfjZ for
 <cocci@inria.fr>; Wed, 08 Oct 2025 13:50:25 +0200
Message-ID: <b0830182-f585-433e-bd77-71022068477e@web.de>
Date: Wed, 8 Oct 2025 13:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <36f32079-1045-4913-9fff-3d1110b153c7@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <36f32079-1045-4913-9fff-3d1110b153c7@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F0H89MtPidkJtBLYmnouQxHjsLK1XLBtm+ASrgObN5/y2e2bVZi
 6o3EmIL6854KE8puuzSRuuWhp/yKe+8K2GI9CprUQzYaH8ojPEFDxdkri7FAeQGcmXw7EIb
 bgyafsjFFkSyrUKr26DZcuY4mHEuxqoAg2QPocGBjQKqYwTr6X7AMDmf9kV0d/7ghPjqjjV
 7P5o3xH5vR4jbhPgKSRFQ==
UI-OutboundReport: notjunk:1;M01:P0:Dx8EnY90IT4=;weR/qNZWEIFN2ywxFM47qFiYNHf
 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
 X8+Hw==
Subject: Re: [cocci] Reconsidering condition check repetitions with help of
 SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3064
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/b0830182-f585-433e-bd77-71022068477e%40web.de>

> Another SmPL script example for further clarifications:

The SmPL code can be reduced for further development considerations.

@display3@
@@
*if (rc =3D=3D 0 && ...)
    { ... }
 else
    { ... }
 <+... when !=3D rc
*if (rc =3D=3D 0)
    { ... }
 else
    { ... }
 ...+>


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci show_questionable_condition_check_repetitions3.cocci
=E2=80=A6
@display3@
statement _S_7;
=E2=80=A6
statement _S_0;
@@
=E2=80=A6
warning: =E2=80=A6: should rc be a metavariable?
=E2=80=A6
warning: iso drop_else does not match the code below on =E2=80=A6
=E2=80=A6
Grep query
rc


It seems that algorithmic constraints would need corresponding improvement=
s.

* Some code is converted to applications of unique metavariables.
  https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/9e8fb87bd681a6f5ee9=
ae43df6322d2c5ee7887b/standard.iso#L492-527

* Is there a need for marking the usage of these unique metavariables in t=
he way
  that found source code should not be stored further?

* May the mentioned statement variables match similar source code?

* Should the amount of captured technical information be refined?


Regards,
Markus
