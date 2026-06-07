Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF00CD8C8C
	for <cocci@archiver.kernel.org>; Sun,  7 Jun 2026 20:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=kappiOWwpdZtbZdnK6isIFOzSfl58l5JorMn49tbpoY=;
  b=vbarVdR28NMS21gF3+GJSJ6QZPEQz0cRA0N7GfYgQtxdUi2NGlaBBBHj
   qsi2hcb6VSz3NyAdv6DtYnqKD3CK6afjAGRyS0MsBDSfpcY9ixIKAe1Fz
   1ir0UTGsImWYYp6/Zt9XEmEjvQ/eaZFrOvqmsV7djYIerOhGFsuDq6h5K
   4=;
X-CSE-ConnectionGUID: oW4U7u3pT0a0XEUgF6JwXA==
X-CSE-MsgGUID: 21mXwEhUTzCOJhfktzMEPA==
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
X-IronPort-AV: E=Sophos;i="6.24,193,1774306800"; 
   d="scan'208";a="280194323"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jun 2026 22:24:51 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 26E4980706; Sun,  7 Jun 2026 22:24:51 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id AB4D3806C9
	for <cocci@sympa.inria.fr>; Sun,  7 Jun 2026 21:30:30 +0200 (CEST)
X-CSE-ConnectionGUID: q3HvTuIxRNGG64ZVS+GVsg==
X-CSE-MsgGUID: IEMvsEz4Rs26XnwaOqY8qQ==
IronPort-SDR: 6a25c6d6_IMC+B6V4PruzouSR0CAWFKVpv9fIkPTWko7ufxHSa+ow7AQ
 8pq7Mii5Cou+D82r0sZQiiDlwdTZbjbjakHqTMw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FABABBxSVqgAwR49RaHgEBCxIMggULAoI/gQpeNAQLS?=
 =?us-ascii?q?QQEhFCPU4ZfhymHaIh6gVWBfAIPAQMBDUQKAQIEAQEBAgSCC4J0jTYCHgcBB?=
 =?us-ascii?q?DIHDgECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABATsHD?=
 =?us-ascii?q?juGTw1JARABggCBLIEmAQEBAQEBAQEBAQEBHQINOkYnHQEBESYBNAIYDgIiT?=
 =?us-ascii?q?wIBAYJ+AYIiAQYQAQM2Bw0GtQqBMoEBggwBAQaCatd8HywiW4FpAwYVgQouh?=
 =?us-ascii?q?XGCSQQcAQVuiQWBIQ+BVUSBPAuCR4MOQgSCK4MOgmmCJoEMkFuBShwDWSwBV?=
 =?us-ascii?q?RMXCwcFgWYDgQYyPDIdgSM+FzNYGwcFgUqCM4EBAYUSIx8DOYEXgXyBKGdpF?=
 =?us-ascii?q?TE3FwIBC209NwkLGwQ9jSEXD4E7gjaCSJMxgxWvMT00B4I4gWcFgWEMiQmBJ?=
 =?us-ascii?q?pU/BhMvl1MOkwqZBowPgXqVXweFUYFvAjGBXDMaJIM2UAMZD44hhAIzhGDAa?=
 =?us-ascii?q?0UyAgE6AgcCBw4DC4VEAQGKUIIGgUsBAQ?=
IronPort-PHdr: A9a23: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
 NwRR7UdWFFnTpsn
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:QriJ8KyG4IXiMjD6GrA3KrPwP71zdoMgy1knxilNoH1uA66lfq
 WV98jzuiWE7Ar5NEtApTniAtjifZqjz+8R3WB5B97LNmTbUQ2TTL2KhrGM/9SPIUHDH5Zmu5
 tdTw==
X-Talos-CUID: 9a23:/ZasVGzOZSrC+3i7Cc2RBgUNQeA7TmD83E32DGDmVVRXc/66d0SfrfY=
X-Talos-MUID: 9a23:RYdSUAnqKOPCypch6CEsdnpDGeJ2+Im8VHoWy8s2vdaNEjVBay6k2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,193,1774306800"; 
   d="scan'208";a="280191938"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHdXHpd5tJPdUn6R6Dby/irAQ+1G6LZ4ZNaUa?=
 =?us-ascii?q?A+yq9MiU25mzxfUn+e7D/TtGCorUwvFRiIPHIYjt5QuzeY72+cNwpPS0?=
 =?us-ascii?q?WtXqVsO/V3gpHQ+PFKaA5ixwGjxk/x21Xos7N6k1A/VGwOeKOXZ+YNud?=
 =?us-ascii?q?3nIrfG9Umsiq1Rs+g/UZTbzw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 21:30:30 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1My6pZ-1xSh2o11zT-017b7P; Sun, 07
 Jun 2026 21:30:29 +0200
Message-ID: <37bcc073-cc9c-4586-a271-0d6c7cd59693@web.de>
Date: Sun, 7 Jun 2026 21:30:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
Cc: Felix Gu <ustc.gu@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bwm6+RlBVrXO5L5VDhQeKnapglmgOh+Cn2IRPg0fY64KAa1p8M8
 w/KjDRTein0nxH0Ba1a/P30g5pddy5ay2qUE2fy3K1xaCz/HuRFNWJNBkJ2R1X5F9K4iJNf
 2F0LrOlA06SkM8LluJnT75l25J1cS+RchJAtA7eOkcoib7SCyFmoC9HzkkAPYwSTEA8g4Yg
 MvtDkupn4I/nHmY923Ybw==
UI-OutboundReport: notjunk:1;M01:P0:WTeebTrRbvM=;hJdeTaI/6MzTvbFcr/ZNVKRd+zM
 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
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Searching inappropriate readl specifications with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3558
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/FeK665_HtDC0m4W1k5jF4w>

Hello,

Felix Gu pointed another software correction out.

I assumed that something can be achieved also by the means of the semantic
patch language accordingly.


// See also:
// [PATCH] spi: rzv2h-rspi: fix incorrect readl() accessor for 8-bit RX pa=
th
// https://lore.kernel.org/linux-spi/20260605-rzv2h-rspi-v1-1-c1d5ed562249=
@gmail.com/

// https://elixir.bootlin.com/linux/v7.1-rc6/source/drivers/spi/spi-rzv2h-=
rspi.c#L140
@display@
identifier action;
typedef u8;
@@
*action(readl, u8)


Questionable test result (in combination with the software =E2=80=9CCoccin=
elle 1.3.1=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch =E2=80=A6/Projekte/Coccinelle/janitor/show_questionable_readl.cocc=
i drivers/spi/spi-rzv2h-rspi.c
=E2=80=A6
real    0m0,119s
user    0m0,103s
sys     0m0,014s


Why is an expected difference display not generated so far?

Regards,
Markus
