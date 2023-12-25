Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2A8C3DA6E
	for <cocci@archiver.kernel.org>; Mon, 25 Dec 2023 10:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=5QSo0c0Cl8C1byUvtUKYRMImJ/cqzZslJ0KQBPApo0w=;
  b=Z8F5C0kpMQA1eqsYfkI79wyg019dlHfH/gI2TbAVdWqXuLUyw1rNP9Dp
   h5dxZISjelYUvX/jqjgZPgvA4qHHXJBQee+IN3YGCN2JoXAr7+mf3bx1R
   vgMIJvUXHM6QqnzT3mI9St2et7FUaMyMI6eRR99r5geLlEBr6dmt11tpy
   c=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,302,1695679200"; 
   d="scan'208";a="143972687"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Dec 2023 11:15:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8D35DE0CCA; Mon, 25 Dec 2023 11:15:58 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A342DE004E
	for <cocci@sympa.inria.fr>; Mon, 25 Dec 2023 11:15:54 +0100 (CET)
IronPort-SDR: 6589565b_MNOKEVshNVUma/030ZNPKUnxdl9HHtArpyBfqnfrRadtMv7
 irhhnuJOja7mfbv1kbdE99g2WUH8Q5Gsr3qw7lw==
X-IPAS-Result: =?us-ascii?q?A0FIAABbVYll/wQP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YI4B4FLMgQLSIRTiB2HJIF1gQWDZoc1h0yEa4QEgVYUgSw+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDcBhEeHOAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECB?=
 =?us-ascii?q?AYBAoEGE4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHax0BAREmA?=
 =?us-ascii?q?S4BBQIRFQJeARICAQGCfIIrAQMxB68UgTKBAYIKAQEGgmasch8sIlaBYAmBG?=
 =?us-ascii?q?i4BiBoBhEWBIoNBgSEPgVVEgTyDQYN8gQaDHIJoiRwHMoIcg0+KJIc4fQVBc?=
 =?us-ascii?q?BsDBwN/DysHBDAiBgkULSMGUAQoIQkTEkCDMAp+Pw8OEYI+IgI9NhlIglsVD?=
 =?us-ascii?q?DQERnUQKgQUF4EObhsSHjcREAUSDQMIdB0CESM8AwUDBDMKHQshBVYDRQZJC?=
 =?us-ascii?q?wMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDFADbB8yCTwLB?=
 =?us-ascii?q?AwaAhseDScjAixCAwkKBRACFgMkFgQ2EQkLKAMsBjgCEgwGBgldJgcPCQQlA?=
 =?us-ascii?q?wgEAyspAyN0EQMECgMUBwsHXAMZKx1AAgELbT01BgMLGwY+AqZQexOCdpJyk?=
 =?us-ascii?q?x2ecjQHgjSBYIFhDJ8rBhMvg24BEpMlDgaSVC6HUJBPIIIxphWBYz2BWTMaJ?=
 =?us-ascii?q?IM2TwMZD44ghCuPR0A1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:miEX96g+TGZ8wsUI1nm80IHdGHBQXgIji2hC6mlwRA09TyVXrb
 HNoB1p726WtN93YgBHpTngAtjmfZq4z/VICOYqUotKMDOW3VdAT7sN0WKB+VHd8kTFn4Yx6U
 4KSdkbNDSfNzhHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNj2CJ5sA0+9jYDzra3GeqTM2fabQn/
 enjPZ6mw==
X-Talos-CUID: 9a23:6O0Ak21qlr0hEd0XKFCvRLxfRM4if3vQyHzpBGy1LjdQcaa6TnWJ9/Yx
X-Talos-MUID: 9a23:tB7uHgXYCMrPvr3q/D7IlRpIHdtU2p6VS1tSkrYIgcOHFRUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,302,1695679200"; 
   d="scan'208";a="143972686"
X-MGA-submission: =?us-ascii?q?MDEp2U5PEXgWRMJ2/fCqcILGwSLv7gSCYC4ebN?=
 =?us-ascii?q?qj9S3yeb7Rp2Sbzdqns2auiuS1RxD+tiol4JXFjYRT45cMmt3DBvyTjl?=
 =?us-ascii?q?p6jL5TEKBzos0xGhzmQC3s6xTQZYIo/iG3jtIFFjZV7wmjqSk+2zcJ5J?=
 =?us-ascii?q?Jqkh1ev3AoQVeO0NZNIJMOsA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 11:15:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703499345; x=1704104145; i=markus.elfring@web.de;
	bh=CX4XrVdpP/rmSF+luv1fR+SLA7jv9GtKDnHAzolDcMM=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=myxSzruOU3vRfAN2O6LiFDuj/unESZEhd6nw9RiCoQHUh4YNrvrINKLm/m5xmqk7
	 QaDwSDv8umiBs3JDwot7/NmLhhR+1gsaR8L5cgfJU9locZlmfYmwEhk1IE+RPfLp6
	 UuUsmMEywkwTBL3H2ZU5xD+rJWtMK4RQxp4cuBKMN/fOZ5BbB4JL4gaMI0Z6OaXrU
	 Kh6twsT7jugcLn2GXfU8nnKn6kjKUSXiDsWajce25VD6ss6TPVupq3vnZwZMr9SIM
	 ESfLgOGQo6MZlqrThqNSRoSYmnqK6Flc6P/49wV0xk7LojDXqmsG4DMiDK7Juzbxc
	 YZqQ6p9vHlSet0t+zg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N62yi-1rBCht0oHI-016ZhP; Mon, 25
 Dec 2023 11:15:45 +0100
Message-ID: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
Date: Mon, 25 Dec 2023 11:15:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y/FD+iSa3EBExn1MYsUggKexGMnSjtrzkFIyPzLSRPcOsGI39BZ
 h1wWI7EqwreaymNkj43eUPt/hWzowCNY3bcwjmEZS5iGcDQAMv3P1/KR4fMNVZVnwHs5607
 3FNQcSEPwWrG+mfQxUfJGVDm2RhAZgRt15l+tDo1skSdq1WxN1L30zI6+Nfg9OoYm+Bd9T8
 ARmk6FBOzzhxzM+Mz6QFA==
UI-OutboundReport: notjunk:1;M01:P0:WWz7nW/Kxd4=;+P83b+SGk4yHHw1fHMJC69ld+qk
 yP4wwQ/ti30/QOf2fgSggNHMgr04+lhbRxnawNXcU5eWbazkDcYS5tPXS6ttFxncOzRoWmUkl
 1rbylmlpTihS0Q9ObcYYVHN+gUw+Oe8nnu1OnFCx8CcTkb0AzKMzoOQyA8UfGiOUPQJxikl/K
 NgYIbSv0WYhuMimgEiF64wPL22pGs7L6gQvJgCGahclYBiGfdVPXr90dHPjMmujf+7tnrLkUJ
 4l5XrR1a/vDhT0Ymc2XWGG6Onbyp+3eNyXYS7CsE6m3S9QVGlzakuZGz+Q0kB04aiOzBz3ROf
 ZJGae30e8H74zj7ffU1mQ01V5VcSWN++XupKlg52AqaR2RzPnGFuN+MM1UeGQf5am3g97t+1l
 I5QfxWRCgPvc5nYuz9VGoMNP75FbqeNYO2Ji6MeBCx/CRfIs/ZrND6U4FAwU+ATxr4EHn7ARi
 MAWLhMAtdpXmhn0hgfCc2uYdGFbOo20bOThpCxy23TfQ3RuzZMIj5PfTzd9lhk/0sLF95ShrC
 5ILOQiu88lRzDwoO1E6aYkSGLc7/jmm5udfAIbZJJu8aEUUtE+UdlMVowk7+h9G9a7QoiRY72
 s20OiAZLBLS/84dYDzqOp9fhM5b9BngAn1D84RMrZZe44RJanNEE+fTlgCMYP8DAY8rV8ilhB
 +gYkBCc8PvFhtm7qjWB6hXhTLNuLVe+NK02idUdEiEieAcjJCJZTwyXOghuogwO19e6o4MjTK
 5OZ501FpAK51lgdsqzo7KQYLRf0kjTiMhAAZ1sUp/KVyCuWUcuYknXm3hL70QMOU3QY7m1Vae
 CyaNlA7yi5SUTs7XIEY87K6gxkNrLINVS5A3zGnIlyLpmVXOG/vLlJOjuNv+Mf3EdB342mFdR
 IpN1cU/bkyommLkmXvifUxeneiAGj8b8j209zNKT9mPOTuSYWL5PrRMkRXVUaPvhoDYrpEL7m
 x/ONIuFbGZwS+COAphUKuOt2sCg=
Subject: [cocci] [PATCH 0/3] dmaengine: timb_dma: Adjustments for
 td_alloc_init_desc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1380
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/ebd531dd-60e3-4ac3-821e-aa9890960283%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 11:05:45 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Return directly after a failed kzalloc()
  Improve a size determination
  One function call less after error detection

 drivers/dma/timb_dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

=2D-
2.43.0

