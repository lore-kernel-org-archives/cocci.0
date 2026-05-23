Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31225CD5BAC
	for <cocci@archiver.kernel.org>; Sat, 23 May 2026 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Gqi+Q2aVSsKU2bmu9b+N2+z3Au6QUOZAB79OQwV9dsM=;
  b=Sp5GrOykd5JIxZUMbIal7UNpmdUTy4V15cCgntwnWpjCofVOPhNLfOSy
   ruzFYsfonUryGAv0TFClK+sdEf5Z/8dSHUSM0xqFffk4FuKSX26hoU+Ig
   QpoLVaZkjAisgCl3lEpCAmx07g08DX3j6euCnM1bigZX8xAZkKPEhNq0V
   A=;
X-CSE-ConnectionGUID: UFOuAtAvSyGnDvzaibBbgg==
X-CSE-MsgGUID: 0wKFe/15SsuwhSRg5TAj2Q==
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
X-IronPort-AV: E=Sophos;i="6.24,164,1774306800"; 
   d="scan'208";a="277974062"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 May 2026 20:00:45 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1B9A583AE8; Sat, 23 May 2026 20:00:45 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 73A5F83A51
	for <cocci@sympa.inria.fr>; Sat, 23 May 2026 19:51:57 +0200 (CEST)
X-CSE-ConnectionGUID: 71VUYlh2TsCgracK3Lk0tQ==
X-CSE-MsgGUID: 9kPB7d0xRNCvpce4IxHHrw==
IronPort-SDR: 6a11e93d_v+Xwm03/Iwu5AL7/gg0JLk88CDDyhO41Vow+WL4EW971PE6
 GDNsA/ShHAZcKgQt2OxsTpdPCPwPDRDmUZ5/tVA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F0AgAJ6BFqgAQP49RaglmCQYFmNAQLSYRYj1OCJIQ7h?=
 =?us-ascii?q?zyHVYh6gVWBfQIPAQMBDU4BAgQBAQECBIR1CgKNMwIeBwEEMQgOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBOwcOCjGGTw2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmAQQLCxoCGA4CAlYGARQBA?=
 =?us-ascii?q?YJ+giMBBhABAw8nB7JPgTKBAYIMAQEG2mYfLCJagWcJgR8uhXGCaAGGMYNGe?=
 =?us-ascii?q?icPgVVEgTwLgkcxPoRDg1uCaYImgQyOdVJ4HANZLAFVExcLBwWBI0MDKi8tI?=
 =?us-ascii?q?0sFLR2BIyEdDwgVHlgbBwUSISpuSkwaAwMNITVZQTgKAUYFgW0CghpOIy8DT?=
 =?us-ascii?q?oEtgW8CAQttPTcJCxsEPYtQGw+FPMcrNAeCOIFngWQMn24GEy+DcQGTYA6TC?=
 =?us-ascii?q?pkFIqkegWkBOIFcMxokgzZQAxkPklbGPkUyPQIHAgcOAwuFRAEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 BYCh7/1f9x73mzT3kt/dh9lkY6MF0eCBbhw
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:IBq7a6l7tDbTFRFPwARDm/EXv4bpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3A6p78Z2s4iz3+FniDMVjf3gvY6It6K0Pg/XPQeXO?=
 =?us-ascii?q?jImlzQba2EnuToL9dxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AaXZCjQ8+g125Kpbvh9cFjWyQf5Zr247xBBgdq7M?=
 =?us-ascii?q?tpdGPOHBRKxe9liviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,164,1774306800"; 
   d="scan'208";a="277973570"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEVC5NQ1ggw7eqTpLYrusiz6lTCC7HCVI30xo?=
 =?us-ascii?q?CefBiw04HUwVS5v1Rgsvgx5rx8sXFyBWu8oT0WQc2AlGO0FyFvfGAgfq?=
 =?us-ascii?q?bM8MDLdnchGnN4ft8pGcovqe9XiDU5h3kVCazmNnO7baJ2lxDINemwHg?=
 =?us-ascii?q?PuCFLK7LiiNulXH+57XD+fsw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 19:51:57 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4N98-1xRrHc1qo2-00sH2j; Sat, 23
 May 2026 19:51:50 +0200
Message-ID: <25fb88dd-4573-4897-98ae-f5904a2324cd@web.de>
Date: Sat, 23 May 2026 19:51:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: vulab@iscas.ac.cn
References: <47a6aeca-6c58-4be6-9a4e-a1d6726b5a0a@web.de>
 <8397220-4b66-acd4-32e2-cfa72ee7ac66@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8397220-4b66-acd4-32e2-cfa72ee7ac66@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zi+b6XX1/U1aCwQCX+e3YvP01tOor9kr8MN9sUXVWLtsbjz3IPI
 2f0CefU9JwCFR/+8dh+rnR2Dv1NKhKOcFeqfmAzb0QCSjQzss2AMepSwFo3P4O54Z5WvWbA
 iNFz7zXXpvM2PZHgqJXb4PZnWsXF9SrV25B3mgmbmyXvejj81BwRsZ3iOjhF4IIzlbv7yS0
 CZzrjp0a0bWvKdI1ArN0A==
UI-OutboundReport: notjunk:1;M01:P0:LRgFYw5d/XQ=;4WXH5PV3gYfKz/bsus0LN5aelwE
 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
 P3dbTGtjz2rGdKNOZT7MHqX7438=
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Checking evaluation of another SmPL script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3505
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/MkhBf0AtWYrqrrNBalds_A>

> Due to the goto, they all look fine to me. =E2=80=A6

Which data processing effects do you expect according to the program optio=
n =E2=80=9C--no-loops=E2=80=9D
for the presented source code search pattern?

Regards,
Markus

