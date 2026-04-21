Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E54F327A9
	for <cocci@archiver.kernel.org>; Tue, 21 Apr 2026 06:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=m7plOuqyK9waRAHk13D03gu5JMjZcUILXL4QLwUhM3A=;
  b=Kx7DJORZRP5fD/ayoCfViMT1ziebPkzrfzcaCSA2pcmK5VcKMRlL1OiV
   FOrCr/VZmzZKKFUJgkY6zWbq6ybN1FImdtvaMSke7go7QAxkaYPmhchh7
   3ud4hOkS9tkL1DhV7Df6S7+mQhWGQ4+m2L0vp6kyGxI7CsgcB8sYyjRt2
   A=;
X-CSE-ConnectionGUID: l9HhNvIoRey32rr+o5Adnw==
X-CSE-MsgGUID: QepdZXggQdqw1bpFNX99aQ==
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
X-IronPort-AV: E=Sophos;i="6.23,191,1770591600"; 
   d="scan'208";a="273389043"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Apr 2026 08:05:09 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id D9ECD825D3; Tue, 21 Apr 2026 08:05:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C3465825BF
	for <cocci@sympa.inria.fr>; Tue, 21 Apr 2026 08:05:06 +0200 (CEST)
X-CSE-ConnectionGUID: fXVZXWpOTR2vd3PeVk7sSQ==
X-CSE-MsgGUID: zDSb5qIMS1CoggdGgJgF/A==
IronPort-SDR: 69e71392_ydI16cXEnZoX+eria+vGYPTeEfPw74j2eoQTWGsz8jWL0+0
 jqd9PCLw/pa33y8jwen1WdDmp4YhSISZJwxJOrA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F5AAA5Eudpg07ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBUIJBgWU0BAtJhFiPU4IkhDuHPIdVhHCECYNSAg8BAwENTgECBAEBA?=
 =?us-ascii?q?QEBBDiBU4J0Ao0tAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQEEA?=
 =?us-ascii?q?QEBAgEBAgQDAQEBAQIQAQEBOgcOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdA?=
 =?us-ascii?q?kdEAQEBAgEjHQEBESYBBAsLFAYCGA4CAksLBgEUAQGCfoIjAQYQAQMPJweya?=
 =?us-ascii?q?4EygQGCDAEBBtpkHywiWYFnCRWBCi6FcoJmAYVmS4Q/Jw+BVUSBPIMDPoQKO?=
 =?us-ascii?q?YNbgmmCJoEOgWCNMlJ4HANZLAFVExcLBwWBIxAzAyAKLxQZAhQNIg8aBS0dc?=
 =?us-ascii?q?AwnEg8dDwgVH1gbBwUSISpugmJ2LlwaDiE1A1ZIOAoBTAWBdAJqgTwCAQttP?=
 =?us-ascii?q?TcGAwsbBD2LJiEQhT6XNAGvazQHgjiBZ4FkDJ9tBhMvl1IOkwsuhXSBcRaQX?=
 =?us-ascii?q?SKpHzaBSSOBXDMaJIM2UAMZD44hGSWDdsQBRDI9AQECBQIHCwEBAwkCgVQUg?=
 =?us-ascii?q?1wBAYwiNIFLAQE?=
IronPort-PHdr: A9a23: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
 XE=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:5jXtWKl2S47JBhkomr6z+xQJ5f3pDfI/3DAbv31ZSRFFG/Fw9v
 re/sjzsCWetN9/YgBFpTntAsi9qBDnhP1ICPcqTNKftWDd0QPDQb2Ki7GD/9SKIULDH4BmuZ
 uIC5IRNOHN
X-Talos-CUID: =?us-ascii?q?9a23=3AmnEk7mlarL72cYCTDF0B+jQR5UPXOXPt8kXgHFe?=
 =?us-ascii?q?fNVwzVrHOcVKu+/x/qPM7zg=3D=3D?=
X-Talos-MUID: 9a23:/OgHUQiOAJir0IU0oIvGEcMpJutT6fm3KWU2yL4BtMaIGiNSNBnapWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,191,1770591600"; 
   d="scan'208";a="273389024"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEZ9yZ8/DVzDbIeTNUbNyrU2WJdn2DL3fGkeG?=
 =?us-ascii?q?OjUzd3rBCHUsVRXbmdl6iepWB0YQ1zoOuqtoEeAHhcnQRqSbAoqsXiTO?=
 =?us-ascii?q?9SZuygF7Uk9L/h/I7Ksh2sPAVfFBIBJnGn35EhHzWayHOxxHS/iPYhPj?=
 =?us-ascii?q?q8PrsFTOnO0BvcF8Ung3/PYA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 08:05:06 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlLE7-1vY4xS0jnR-00dlFK; Tue, 21
 Apr 2026 08:04:43 +0200
Message-ID: <aca6d545-ccb3-42eb-a667-dcde66325a05@web.de>
Date: Tue, 21 Apr 2026 08:04:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Alejandro Colomar <alx@kernel.org>,
 Felix Gu <ustc.gu@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Philipp Hahn <phahn-oss@avm.de>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <4fa1cbbe-506d-4acc-acd6-57700d76d0e2@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <4fa1cbbe-506d-4acc-acd6-57700d76d0e2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SVtUN/Er9RN6YdmbXnvBDCIwT95M6XBhdkXMQ7KgP+vUQKJJGZG
 GkEz4U8jk0kt/3IQ+9+wEpS1sEDMR1vUfPn/88QfS8iMmZVUnTO5kgwmXHvRtyQFKUusqot
 ssXFFPGaycSSswCnEDrWjem84AEYZ/II7YHG1ZnWoNppT5ivY38bSTIab5+e2vMOLMtyn2k
 Q21Gh2ncQX8k7kUm0A4DA==
UI-OutboundReport: notjunk:1;M01:P0:6qtjceTRXEE=;At2bYXYMTEhxbgnA6tx0V3F5Onp
 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
Subject: Re: [cocci] [PATCH] Coccinelle: api: Add SmPL script
 =?UTF-8?Q?=E2=80=9Cpm=5Fruntime=5Fmark=5Flast=5Fbusy-deletion=2Ecocci?=
 =?UTF-8?Q?=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3478
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/JWx4taZ9g6avfwf-wmY3tQ>

> Date: Fri, 13 Mar 2026 18:15:11 +0100
>=20
> The device's last busy timestamp was set in a wrapper function since
> the commit b3db492e8335417dfd66c1fa2ea08e1d2f7b6736 ("PM: runtime:
> Mark last busy stamp in pm_runtime_put_autosuspend()").
> Thus delete pm_runtime_mark_last_busy() calls before
> pm_runtime_put_autosuspend() calls.
> Provide design options for the adjustment of affected source code
> by the means of the semantic patch language (Coccinelle software).

How many contributors will get into the mood to achieve further collateral=
 evolution
also with the help of such an SmPL script?

Regards,
Markus

