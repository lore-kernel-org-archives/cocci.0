Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2331CC83F25
	for <cocci@archiver.kernel.org>; Tue, 22 Jul 2025 07:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qv1aBjv5fRftC80oA+8z4xVmVvXnvY0bCXodrC1eLbQ=;
  b=QXcDBrsrvT2D3rgwCVBxDy+41sY0e9zJf+dMSxXn9py76ctfFRIWsHZL
   BRL2WOI47iaGNIlDv63yZ/y1uDTfQ+eIHymi0kCSFm6t14IrZmwP4Zp6Y
   ql0HQMC9l9I4UEdvnUCdWnKDfyHc49DwLFZEKbYOrTXNQPNNVmq1w/HSE
   M=;
X-CSE-ConnectionGUID: BwoMkdk3SLyY9PqviYTWKg==
X-CSE-MsgGUID: YcM6HQuzTeiy0wqxmn7fdg==
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
X-IronPort-AV: E=Sophos;i="6.16,330,1744063200"; 
   d="scan'208";a="232569165"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jul 2025 09:33:55 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3C0D4E0CD5; Tue, 22 Jul 2025 09:33:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4127FE0171
	for <cocci@sympa.inria.fr>; Tue, 22 Jul 2025 09:33:54 +0200 (CEST)
X-CSE-ConnectionGUID: lxfHEqxrSdeuoHludBQaeQ==
X-CSE-MsgGUID: caKvJ6GLSVSzOlyZcp6w/A==
IronPort-SDR: 687f3ee2_Xu5P9KIzVwVR8llpGwoeumRbSo1zYvE0SFG2rx2wPBGrfaY
 fla832cW9VO21RHnhTdMaq+TuZKREJ0d6x5DkHQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FSGgBbPX9ogA4P49RaHgEBCxIMQIFICwKCQoEGVDMEC?=
 =?us-ascii?q?0mEVY9QgiSEO4c8h1SIeIFVgX0CDwEDAQ1OAQIEAQEDBIUAAowTAh4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGFe?=
 =?us-ascii?q?w1JARABggcBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgn6CIgEGEAEDDiQHsC2BMoEBggwBAQbaXh8sIlmBZAmBGy6Fb?=
 =?us-ascii?q?YJkAYYnhDwnD4FVRIE8gwM+hEODW4JpgiaBFoNkjQaIDlJ4HANZLAFVExcLB?=
 =?us-ascii?q?wWBIEMDKjQxI0sFLR2BJ32DCoEOhCgrT4IidYF5QRk/g1MeBm0PBoEYGkoCA?=
 =?us-ascii?q?gIFAkNFgSNAAgELbT03CQsbBj2Sd4Izg3I4k0CzOzQHgjiBZ4FkDJ9rBhMvl?=
 =?us-ascii?q?1EOBpMEmQYiqR2BbwIxgVwzGiSDNk8DGQ+OIYQzwRJBNTwCBwEKAQEDCYVGA?=
 =?us-ascii?q?QGFKIRygUsBAQ?=
IronPort-PHdr: A9a23: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
 V0EzOGgRWz2HpL20QpuZwsi9Lk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:cz1BmaxhzzzjvSozxMJeKrPwyL1zdoMgy1knxilNoHxuGfBw8P
 re4MjztCWE7gr5PUtMpTnuAsW9qB/nm6KdmLNhWYtKPzOW31dATrsSjrcKmAeQfhEWn9Q1vc
 1dms5FaeEYZmIbsS+V2maF+q4bsbu62ZHtvv3Gx3NhCSlhdqFn6G5Ce3umO3wzfxNeDZ41UK
 KB6tZK4xqsEE5nFviTNz0/RfHKo9COrp78fhIcbiRXkTVmlwnYk4LSIlyjxx8bXnd1za0/9H
 WtqX2C2pme
X-Talos-CUID: 9a23:24K3h2/GbQparwz+OxmVv0oEFOAIa23H93vdPkiYDXtlYoScRGbFrQ==
X-Talos-MUID: 9a23:o85cUQTHTAySTXgCRXTnjRJ8FplHx5+QM1IqlYQ0sNHaKmtZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,330,1744063200"; 
   d="scan'208";a="232569158"
X-MGA-submission: =?us-ascii?q?MDFpCyPFExpZpR75sTVwhSdGiQCXNXoJ6IYQFC?=
 =?us-ascii?q?tXrxfKHaIlLQjjMJaaCkH91aOAq401El4RzcirwNYig6096xdKcsHPcz?=
 =?us-ascii?q?AERjFb0cx27cj+smzuGrIz9LQqer0tah76JUpIGfR/wEoFuoNSeR2T/8?=
 =?us-ascii?q?llCAlW5vx39T+UrBYUzfXatg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 09:33:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753169633; x=1753774433; i=markus.elfring@web.de;
	bh=qv1aBjv5fRftC80oA+8z4xVmVvXnvY0bCXodrC1eLbQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P4QeuwriVjSIe+jPDyzmq9zq2IgHaix305qejr5kGgJnWkJv1NpT5g78QlhN5XNL
	 PKNEBaaOFETZ8Cm3tUDOx5sDyiZqatVkIyMyX5bpuB2V3a3Ch8vZSj6gFP+VhqQqP
	 UzkPUbQXJzZD6OV9L4sZj016Q41qHdYHAblsYI301xdgYx57n804EjvJovgeHroAS
	 FCMhpqSEdpzI4X3ZBEKog21oIsQ2BOOUke7JYVIZxu0V4aunLG9UWoaKN6bMYmJoK
	 cjaJNTifR2M4dgDhYyPadunpS0BPb8T0Nu3U40qfw4RTuoFD1HNfTu3yZOhk/1htL
	 rtjv7da2SuupTZfOiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MEUWM-1uO6o63m6U-002WmS; Tue, 22
 Jul 2025 09:33:52 +0200
Message-ID: <8c949c3e-cb28-42f4-9db6-e4e81231236e@web.de>
Date: Tue, 22 Jul 2025 09:33:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de>
 <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr>
 <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de>
 <alpine.DEB.2.22.394.2507201608390.3477@hadrien>
 <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
 <alpine.DEB.2.22.394.2507210747070.18950@hadrien>
 <6fa377f7-0612-42aa-afbc-cdeab8bea314@web.de>
 <8a4b47e2-725e-769e-6bb-43e01113f9fa@inria.fr>
 <52ce78f5-8141-46dc-9ad0-5cbfedfd92a1@web.de>
 <cd40be57-cdef-7834-5c8d-eda49eb3a8b@inria.fr>
 <9083cb34-5f8a-43d9-b908-43a9fe2a4281@web.de>
 <4752963-ce2-3e23-fe61-9cbd1acbbdc1@inria.fr>
 <9154fc36-842b-4797-9b55-397cfdcba283@web.de>
 <2914d20-68da-a23d-6345-fd48f0b9bed8@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2914d20-68da-a23d-6345-fd48f0b9bed8@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RawJgA+AN0vMUQhCU7wQYJTc1B4c21kPhmwkoSJcswqe02MAD02
 H7uCc+Q/gCzHKWw4CVFHgu+l466vGLwPESJujulbapA3c8mgfzYBRZT6zzkE7EQNAv0CELA
 sPBoClCSS4uTIpoMez0xz02QNIqrl/nJTtKSb5sUKB1skS2zugbIw1PIYX5nrYTpVF8xR4Y
 ybRsKZBVH4aQCmS1e3bxg==
UI-OutboundReport: notjunk:1;M01:P0:7C0N+9UfDlQ=;lGs+kHRB43ThMQfXJmF2qoJvCUj
 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
 r6si+M0t8kflLh2BwZcAou4=
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2898
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/8c949c3e-cb28-42f4-9db6-e4e81231236e%40web.de>

>> Can you recognise development concerns better from another SmPL code va=
riant?
>>
>>
>> @adjustment@
>> expression e;
>> statement s;
>> @@
>> -if
>> +my_result =3D
>>     (e)
>> +&& true;
>> -   s
> And what is the problem?

It is supported (to some degree by the means of the semantic patch languag=
e)
to construct expressions for the usage within SmPL plus slice specificatio=
ns.
Developers can generally apply the design choice to use additional parenth=
eses then.

Some properties might be even unknown so far according to metavariable ins=
tances
of the type =E2=80=9Cexpression=E2=80=9D.
Programming interfaces can be extended accordingly.


> If you don't want the parentheses around e, then remove them.

There is a desire to avoid extra parentheses in the generated diff output.
If such difference displays should be accepted as patches for known code b=
ases,
it would probably be more helpful if they could adhere better to coding
style preferences.

Regards,
Markus
