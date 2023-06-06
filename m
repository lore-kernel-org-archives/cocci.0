Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115CDC7EE24
	for <cocci@archiver.kernel.org>; Tue,  6 Jun 2023 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AZfv7h4fBALCv2WdOkQr8h0r08l68bRPhgPTpDzyLno=;
  b=kSzLShktrT1B/5fDr2Nf6OtODFafiM/+q6ky5o5AKA16z/FVMCo9d/qh
   KHchFy+Cq2D/DsxOF0t2NeO89DKmhaT3inUQhJ3PvekNBIz2QM/RtGeFC
   iLa/Oqdl0vPOgbms/A8JplYPlrhW2HAggSxn9KnXjVOzU22z10waYvPq2
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.00,221,1681164000"; 
   d="scan'208";a="111505143"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Jun 2023 15:26:55 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DEB35E0CCE; Tue,  6 Jun 2023 15:26:54 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 31958E00BA
	for <cocci@sympa.inria.fr>; Tue,  6 Jun 2023 15:26:50 +0200 (CEST)
IronPort-SDR: 647f3419_4/PSp8gH6Yg6Daora3OXQ9/FwB17ekxvwWYP+gDdSB2X4kX
 KwxfjZJ6zseuNQWu3CsdwMgEChyp4plXPmb24/A==
X-IPAS-Result: =?us-ascii?q?A0EKAACNM39khwMP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYIueFMwBAtHhFKIHYcFgieEM4cwh0SEaIQEg?=
 =?us-ascii?q?VaBQD4PAQMBDUEBAgQBAQMEOIRHAoVkAh0HAQQwCQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBQECEAEBASMXBw4FCyeFaA2CNykBEWSBCAEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBEgJHPwMDIx0BAREmAQ8fAQUCJgICVwYBDAYCA?=
 =?us-ascii?q?QGCeoIoAQMxB614gTKBAYIIAQEGnA4fLCJVgV8JgRUtAYxsQoM3eicPgVVEg?=
 =?us-ascii?q?TwMgzaIH4JniSaFB45BgSlvgR6BIn8CCQIRZ4EKCGCBdEACDVULC2OBHlI9g?=
 =?us-ascii?q?UYCAhE8FQVJex8DBwQCgQUQLwcEMgkeBgkYMCcGUwctJAkTFUIEg10KgRJCF?=
 =?us-ascii?q?Q4RgVMlBA4DGSsdQAIBC3A9NQYDCx8GQgKCAoEIcAokJKAkAYENgilNkmmxE?=
 =?us-ascii?q?zUHgjCBW4FdDJ8bBhMvlxMOBpIsAS6HOIpphUQgqBSBYzqBXDMaJIM2TwMZD?=
 =?us-ascii?q?44gGR6DcI9IPzQ7AgcBCgEBAwmFRgEBhX4BAQ?=
IronPort-PHdr: A9a23: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
 xRwhgYsOIwQ
IronPort-Data: A9a23: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
 RzyNJE90thdD6yFndou28E=
IronPort-HdrOrdr: A9a23:mt1W2q7CNyrLQ0Ts4QPXwBzXdLJyesId70hD6qm+c203TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNykesS+V2mmFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:+OUFN2AnxofXRX36EyNd9GouQ9kiSWSewHz5G124Dz9uSJTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AqxlssA3kKAoPAfw9lOeezXqFSTUj8Z+3BB5Sjc8?=
 =?us-ascii?q?/gdSUCSk3NTqFrT7qe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,221,1681164000"; 
   d="scan'208";a="111505116"
X-MGA-submission: =?us-ascii?q?MDFqx6L4c9OcEO0wCfnzIdY4fswee9hBPCtBgf?=
 =?us-ascii?q?H52ylONfcWZDZKe/xyIzeWzSQAA83SJWFLV5xc93Q/jXlIE5HLPd1415?=
 =?us-ascii?q?BtXKRYAWQxLxdGDrJWKBqCmdlnGvmXU//np8iy4B3n1Y3DWyhRnBp10r?=
 =?us-ascii?q?/DFOvJYWBB6k6AF0fydjwLUA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 15:26:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686057993; x=1686662793; i=markus.elfring@web.de;
 bh=YnMiHiuM0cpuvosezDCMkw/pMyPyl/jPac6uo7C6V7s=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=YbSLAnpTx0O9YH1sJZw5j45iDnR1BJtdtnC+SK5785ILqpuzV6lqX8NLAgLa7IxJTdqjShL
 8u14BWK/lSJ2gpZmhHEcozt0M6nO5KQeUqtOZ53R1JyF36OamkQe1HU22v2J4CEBI0zCGL1IB
 dTvtmGMh7VlSmaziWN0o+NTAEHvBzdV14o4jow4RPJntmu/A/MQ42SqCrnHjraPL9vqZukrsN
 ydsfd4THBqbFpb0ac/0d7ZZLGgXsVY6zKBIlsaC4S5ruNdQ4BeS0uRoJbgdjiJY+ZDejO10P/
 XpJkrjUHXkRcc/koqDWaMrQ3Yzw55r68cZ5F11Zyaa+N7sxkB7Lg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoYS-1pYS052Hoi-00Yb8v; Tue, 06
 Jun 2023 15:26:33 +0200
Message-ID: <9ace5c4c-5e17-4207-5a02-6a47ba0aee22@web.de>
Date: Tue, 6 Jun 2023 15:26:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
To: kernel-janitors@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Dvorkin Dmitry <dvorkin@tibbo.com>, Linus Walleij
 <linus.walleij@linaro.org>, Wells Lu <wellslutw@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Wells Lu <wells.lu@sunplus.com>
References: <1685277277-12209-1-git-send-email-wellslutw@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1685277277-12209-1-git-send-email-wellslutw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IfThuN+vRUDXXIjYaUwraSDOMlugaMM9dgnxVhVQ4Bt1v8AFX/6
 vCtjuM80AsY33lGUh0y0wwBCll51YgTScSo74bne0YsEw7C99l1+kSI7tnSm2vxG00P6eX9
 RMcIBDFwwBo3oqzX1cjjPq8esJxt/FfmlUYJnGubAxw923FHxsBu6fwb7sCbVd10nJ0K02m
 AOtRYEc+HhVjHGMdsQTtw==
UI-OutboundReport: notjunk:1;M01:P0:DA2RpCt+4Ds=;0v3gzyL5WIz+9SPC7H8qjXGluhg
 PGNpUiGXfF7LhdFVubJtx7p8Pq0iUl8MF7rRXhA4ZDniswpPwBN081j82caOJFZEFouCVtrfG
 tDfNpTQGKi+R0PBT4m20DNaMlsDxRaquRufLbIPM2zugmGjSzFH+h0ZABXduKeXngekT6CiZE
 qHBxiSHBWQr5nWAxiouubaS1VJFSkBRFJVTfeghGNagPh9yPexrGdX2zRoQ04p7ysUxWvnMn2
 Q+5zf+nDz3QuJka2LyqSDrel0k0JR/np3kFZFfoK6MCAUB6TkPtcTEDHghLfRgF+ih8XQn4uK
 V2bB0elj2wyk/LmCGu5YEmtgJcLmiatlTVkfFm9PQ6gvQdVQ3PM/ZbJ4nTeDBxiReuOO6Y0MD
 I4zuxWwR6Sw7pKMY0cG0gZ3rOJz8qlarr3pTaC3X5h4MY25M8j/XQwKZ7r/fu5QmmaYBdWmMh
 lytqoblKdq5eKi30p8NrlrhFHq6sElK3OPZQM3VnKPn6CC2aQPzIhA2RyMRNY4q5VXvZn2mn2
 GMMsbBDkugON5Ai4DrgJWcN/KrRjN8DLJvXZxXm36g4VT6Qvh6VNuA8HVRll00M+8wGY9B0Fz
 zY7l2lIXyr3YntYPScU2+Yxv5xUAX/rXvjOYG7KyUcNXn9oSImmzCAsAcc7P1h9flVIJbLDK0
 LEWeO3m3E9xVIik/OuXgzc9Lhc59nKaCW8xahHJPsnxDLcAnLiDt/Bhi7atzTwDdviV0NcTTx
 eLt/HsSIT8J/8YwuYBd1LtxQEVWkiR0h/A8TL8byignlR4u3ZPn8f/S+YhGbbOpzL9AOukuDV
 PRWHwhnRTHTnIDbnFGMRrXl7YII2bEvhOYgtkrfCRgId76kEccSY1IssOkMA4O7/8yH2Nkuhm
 ETv85WFBxZs+3gVAUVNTxCggeZPUD8IzxNtHojDAit8/sHuyAgt26lrPIa5zSHQ3KC3l2eFeQ
 WHSj3Q==
Subject: [cocci] [PATCH] pinctrl: sunplus: Delete an unnecessary check
 before kfree() in sppctl_dt_node_to_map()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1168
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/9ace5c4c-5e17-4207-5a02-6a47ba0aee22%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Jun 2023 15:00:18 +0200

It can be known that the function =E2=80=9Ckfree=E2=80=9D performs a null =
pointer check
for its input parameter.
It is therefore not needed to repeat such a check before its call.

Thus remove a redundant pointer check.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/pinctrl/sunplus/sppctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sp=
pctl.c
index e91ce5b5d559..150996949ede 100644
=2D-- a/drivers/pinctrl/sunplus/sppctl.c
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -971,8 +971,7 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *p=
ctldev, struct device_node

 sppctl_map_err:
 	for (i =3D 0; i < (*num_maps); i++)
-		if (((*map)[i].type =3D=3D PIN_MAP_TYPE_CONFIGS_PIN) &&
-		    (*map)[i].data.configs.configs)
+		if ((*map)[i].type =3D=3D PIN_MAP_TYPE_CONFIGS_PIN)
 			kfree((*map)[i].data.configs.configs);
 	kfree(*map);
 	of_node_put(parent);
=2D-
2.40.1

