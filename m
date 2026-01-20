Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86244D2ECF7
	for <cocci@archiver.kernel.org>; Tue, 20 Jan 2026 13:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bI3N9OhpL5d1zG358OV7OP1bGjBZ6hw+5i1ORjFOV10=;
  b=GxVUX01dUs9EIsdLZ3KsPVOL110zm7Te1mjpqy3u2VPSTr5F6dNC0oTb
   cUUf0zyXPNEE0WbSY7fD13QroKHVX2AC08CFfp6raIEWHNA7QiEs/5Tfr
   kNHyw0bJgq9kXskRv3kiqfEzp8I3mOjDN912+AGaqltJ/6yIpI8XpYVgm
   8=;
X-CSE-ConnectionGUID: 2jwjiBbJQu2s8wg3CRWUTQ==
X-CSE-MsgGUID: Itu1NkOQT3Kq2UebDg78Ng==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="259462434"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jan 2026 14:23:56 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8EC9683A98; Tue, 20 Jan 2026 14:23:56 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 95C2183A97
	for <cocci@sympa.inria.fr>; Tue, 20 Jan 2026 14:23:51 +0100 (CET)
X-CSE-ConnectionGUID: vlc5E/ziQfSMxK8olef9gQ==
X-CSE-MsgGUID: dXZajd+RRBqjuDeneyqHUw==
IronPort-SDR: 696f81e6_tlEauol8ql8hO4KeKfRv207nPGDqdQ9GBVhbLkQj+oXKM9h
 UP2TVUga8wvSLpS0uXLJNjnZU7SKpMbpgNCpxEg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G9BQCJgG9pgAwR49RagQmEEWglWTMEC0mEWI9TgiSEO?=
 =?us-ascii?q?4c8h1WMSwIPAQMBDU4BAgQBAQMEhQACjHkCHgcBBDQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDjuGTw2CYgGBJIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQJHRAEBAQIBIwQZAQERJgEECwsaAiYCAlYGFQEBgn6CIwEGEAEDD?=
 =?us-ascii?q?ycHrxd/M4EBggwBAQbaYx8sIlmBZwmBHy6FboJlAYlteicPgVVEgTwLgkcxP?=
 =?us-ascii?q?oRDg1uCaYImgQ6DH5BvUngcA1ksAVUTFwsHBYEjQwOBBiMPPAUtHYEjIR0XE?=
 =?us-ascii?q?x9YGwcFEyNsBhsGHBICAwECAjpTDIF1AgIEghN7ggEPhxGBAAUubxoOIgJBU?=
 =?us-ascii?q?gIBC209NwkLGwQ9kAlHgTKDeYEFxjI0B4I4gWeBZAyfbQYTL5dSDgaTBR6Ya?=
 =?us-ascii?q?KlBgX8jgVwzGiSDNk8DGQ+OX4N1x15CNTwCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 QQFy/X0INZLXrA=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:g5nrTK1XizK1+7OiAlOIPgqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:BkKzd2Ffe81KMcVJqmJ58EVJN4c3c0TT91LAAB+/DWtnGbKsHAo=
X-Talos-MUID: 9a23:9ROuDQUiMicqhd7q/DPctjhgOIRS2Y63Cl0hnJMLqtCkCDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="136511317"
X-MGA-submission: =?us-ascii?q?MDGZRM12+0NZsKmgiy4/RhZa9JhHucN8WvVq0L?=
 =?us-ascii?q?to0vp7tPUjbACpf1cyOKV3//xAbktOzn5WVq3bsjLBKnEqXnmrM6gL3C?=
 =?us-ascii?q?Tz6C79gjZz68tnyLe+ERTxmtZyQNNE83fC5/4wRYDn3/B0pCTElggU+k?=
 =?us-ascii?q?CtbWGIZHtLOnMvN8uwqv5S3g=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 14:23:50 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.179]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melax-1wFsMi3KgX-00pCtc; Tue, 20
 Jan 2026 14:23:49 +0100
Message-ID: <93ad7521-d583-4997-b21e-91433aa602ec@web.de>
Date: Tue, 20 Jan 2026 14:23:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de>
 <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr>
 <15bca19e-5a87-4efd-8da7-c6ea2cad27f1@web.de>
 <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr>
 <78df0ed3-2bb4-438a-bba5-c858dd20c1f1@web.de>
 <2e04b3-525f-c970-4d51-ae20a9cd7a2@inria.fr>
 <3eb7e985-02b5-4be3-9414-78d7e155bf84@web.de>
 <ba44f42c-202e-4fc2-b906-ff06f0aca80a@web.de>
 <c3137d6-dcfc-b982-9db-4edf95a12ae3@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c3137d6-dcfc-b982-9db-4edf95a12ae3@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7hnURcecD/w/hHhcaEUqePDo9SI6h4W12RcIhGI74Ka0dpEg0CX
 nQOLGXtmPnoXfnM4D/1SAGQ7pe4yDYdFtfTIzno0ZO1IS16DuBXcLCh585ggxuFR8mEOsiH
 WvU4VzIkqPiRm021Ndxl7OkE3LEXwjRbFFHUvciZqy4ww+ds+OLEbzFIwR3ST3QPcCcaACk
 JrqgUrPVx204CUE39hvTg==
UI-OutboundReport: notjunk:1;M01:P0:dzZlIH+bM/4=;zJgxtrKS9O8oQaU06+9JuGjGx1S
 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
 AhFxChavgA5tMrDv8r2o
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3288
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/OHqXrAA63F1JjQP-dvtwIA>

> And yet I made another suggestion that you completely ignored:
>=20
> * pointer =3D action(...);
>   (<+...
> * pointer->member
>   ...+>);

Can such an SmPL code variant prevent the interpretation as an =E2=80=9Cem=
pty statement=E2=80=9D?


> This should you give what you seemed to want, with pointer->member in th=
e
> immediately following statement only.

Another SmPL script variant can be tried out:
@refined_display@
expression action;
expression * pointer;
identifier member;
@@
*pointer =3D action(...);
 (
 <+...
*pointer->member
 ...+>
 );


Corresponding test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/show_questionable=
_statement_combination7.cocci drivers/regulator/fp9931.c
=E2=80=A6
@@ -438,8 +438,6 @@ static int fp9931_probe(struct i2c_clien
=E2=80=A6
-       data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
-       data->regmap =3D devm_regmap_init_i2c(client, &regmap_config);
        if (IS_ERR(data->regmap))
=E2=80=A6

real    0m0,175s
user    0m0,150s
sys     0m0,022s


Regards,
Markus
