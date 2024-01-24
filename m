Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75731C46CD2
	for <cocci@archiver.kernel.org>; Wed, 24 Jan 2024 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=tcaTYT9XLlgub7zVxU5yN++R8fNU1BKmqhWIRrUYMVY=;
  b=orF8AXOrD5l4ELNxGiAJKQDle7jNXHpshw7wbZva2xeAfW1fhHptkwlB
   K5b0xClbgZI6kP5HX05RdGpKwMGflFCc/ASB6QKDdTThBP1Y6N6ikSGT1
   +VYyWtCmMgrSDLosjNT+VH2Mt7qLp/Dgl1adJ65lclMRkqfwlLCEEXA2H
   4=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148464320"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jan 2024 19:09:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F0DD3E0CD7; Wed, 24 Jan 2024 19:09:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1E8CDE0035
	for <cocci@sympa.inria.fr>; Wed, 24 Jan 2024 19:09:27 +0100 (CET)
IronPort-SDR: 65b15256_NRpYnOK8AatwRltJBeyewjVUidEfQ5AKB0o1sS9jvnjjHwq
 zZql69qg4yc/FyPxFQ+yr+skNIEWAT43BZn0GnQ==
X-IPAS-Result: =?us-ascii?q?A0GcBADUUbFl/wsR49RagQmBT4I5B3hTMgQLSIRTkTYtY?=
 =?us-ascii?q?TWDKIc2kD2BVoFAPg8BAwENQQECBAEBAwQ3AYFTgnSHTAIeBwEEMgcOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAoEGE4VsDYJcARCBDIEeAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBFwJHax0BAREmAS4BBQImAk0RARICAQGCfIIrAQMxB?=
 =?us-ascii?q?7cDgTKBAYIKAQEGr1kfLCJWgWEJgRouiBwBhSVCCYJPaYEhD4FVRIEVJwuBC?=
 =?us-ascii?q?YE3dogegmiCGINDhF2FX4gGgVMdA4EFbxsQHjcREAUODQMIbh0CMTwDBQMEM?=
 =?us-ascii?q?goSDAshBVUDQAZJCwMCGgUDAwSBMAUNGgIQLCYDAxJJAhAUAzgDAwYDCjEwV?=
 =?us-ascii?q?UEMUANlHzIJPA8MGgIbGw0nIwIsQAMREgIWAyQWBDYRCQsmAyoGNwISDAYGC?=
 =?us-ascii?q?V0mBw8JBCUDCAQDKykDI3QRAwQKAxQHCwd4g04EE0cDEIEcAxkrHUACAQttP?=
 =?us-ascii?q?TUGAwsbBj0Cmi1ZNYIGcKJGokk0B4I0gWCBYQyfLwYTL5ctDgaSWAEuhWiBb?=
 =?us-ascii?q?ZBRIKM9hRA1gTUFMYFZMxokgzZPAxkPkk2PR0A1OwIHAQoBAQMJAYFVg3ABA?=
 =?us-ascii?q?YNagUYBAQ?=
IronPort-PHdr: A9a23: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
 UNg/A==
IronPort-Data: A9a23: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
 WyxjePK
IronPort-HdrOrdr: A9a23:RiF/Fq5h3iZM8V4vvgPXwPHXdLJyesId70hD6qkRc20tTiX8ra
 qTdZsgpHrJYVoqKRMdcJW7Scq9qBDnlKKdg7NhWYtKNTOO0ACVxcNZjbcKqAeQfBEWmNQts5
 uIsJITNDQzNzVHZArBjzVQ2uxP/OW6
X-Talos-CUID: 9a23:FbgIMW4rll+90MyQpdss7hctJdp6K1DhxUj6IVSFJmV0cLyLYArF
X-Talos-MUID: 9a23:ae6kmwjrt+7DjYJxUIknsMMpMsxPoIGvMUw3mM8Pls7VFnVVPx7ak2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148464314"
X-MGA-submission: =?us-ascii?q?MDFnRgF27CdkFZKXPJ3bIcJrSBi3XzpvbCVBRQ?=
 =?us-ascii?q?li5XEUJiaRzvObWkx2cuwHXfe2aj8A2PZEru2qKoJl+L71Fbch/6df3t?=
 =?us-ascii?q?ts3UPDD2QHSe3I/3WdamuXAxxZJplK4795/0xVMPE9+2VRO/l58VwFzW?=
 =?us-ascii?q?pTCAIGF7ytnNcXwf0N21Qywg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 19:09:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706119753; x=1706724553; i=markus.elfring@web.de;
	bh=tcaTYT9XLlgub7zVxU5yN++R8fNU1BKmqhWIRrUYMVY=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=LCDlsrHUztOXda8WecVV3myWPXt97jl6PoJ/xExvT1yzsGkdAt1mFRb3tkHNooiz
	 uPAyoP74GYydQ2M63gcXlmLA8nP2Ue7Hz0/7MQwGvwd+4tA2DK6WPQDKLEKRIm3eJ
	 fN09k23zdW3N24xmyidKv2HwxEH0Lm+dZ/g/OL/9hjbT40XNx4gENLa+UIqzWSuD1
	 LCg5qVFkcuUFLsNUpbe7QOtv3P0hO1bzxTV0ZHdbLRLDyDZNDRNm+Bt6mFmhenWDK
	 cIyrAxVxdsdTU15HAc4ef/3R9PCQhK/Rih9JO/6kjjXhtJYCxoIifmcn7xKgBr5+n
	 w1jQAelrwrTSC9Y+CA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWzCt-1rYzCq0Gc5-00XOul; Wed, 24
 Jan 2024 19:09:13 +0100
Message-ID: <8d53ac92-9693-4ff9-948c-29b7fb252b89@web.de>
Date: Wed, 24 Jan 2024 19:09:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R+R+0lFc93rU0ByW3WjO8aNyBaw+zZ0nWeefyndetMWQjTB/K2F
 5Qs9KmaTDM8lc+hBShh1Jsdd9rCRklmtn9O/axOuDeVu6CAQUm+Xb83MeY1hIJNUMZuhQ6A
 UodX6lzF+blrzcYd+ls9CN9K2ksUX2Y6OWtA8+gl9ioK7rn328uTHXrFRrs6vKJcLUP5nir
 Gl14Wh7ywvGEzSKFM+bTg==
UI-OutboundReport: notjunk:1;M01:P0:t6CMuhiGozs=;C7xlARAWolS5eb6itI9pt00VJi/
 4CUWvA7WSWEt4RQZgh8ygzv69tSq8oyVYDKOmTMSkOAwHIYXkTrS2Ot9Wa73Ljuf7/8igDyD1
 8g/t1HxR4peObdDVivgVUWq6MZjpvVyvKfxmbzJt5ukjKblOkVJ2hpmIcRrzeND8zwS2J4T+x
 SbFXbqOMMFW/5dlHxHR47CUoSbdCMDrPakk4reRYvIP8DhAbIYNAFb57V83xz5g9h4Jol6OKy
 r10omdKMW2RmVBnkCFsgZVy+HnoRl6WkhSIJRMT1EniNCPRlu0sNZOmvPaGh+FAW5D16NZi+i
 rkn7sFVfHyp43eeTM+2omt7FU5GbLm9IaIcnStBAKNlHdpMqAjF7/k43r7X1wgulsgQrMJKI7
 U4J5BLfXO0puWdufADxxC/8FNJIdsyM5nFYPp57qOCP2Dfx8rMYqSsfTcpImqhb6L3WyatxDb
 M+jEGBwf73Jp28OIbpNb6DJh6eqGckdqHl2pcLWLEUvrf2GBOwx/a5ArRL0GsqQZ6HrVIOBJo
 1u8lly/QZORv724G2EY4F/lcCI0VmfKuaXEGNBw6ADC3DIEzBJCb6bwWdCXCFxcnLqsh3aVpq
 jvoZ6qOTHkyHL+zeWwBV2IRcdkMYhEBPgP7420X+7O7Cf8CsnAy8cS2D+W8rb7YzuTeLl4LUj
 FNEkGDPryls8Lk7RehHRG8+yGBmiu4IFC7dUKnUTS615+ax/MRM6GfQoE3vzx+p1+cAqpn8lL
 E1roYgG0uQ4t7j1abzv3M19U/0s4jBNklFCI2xQVnGUThiaJyd2J6gQ08U6Tkx+ZIc9+t1SsE
 komaH+oOd4NSZzTRWQDKCd7mxTNqhGRsUMa5g6I/XE7teHMqP6J3Mfg4iQ01ZgrUKhx2wE9AB
 J4G2s8//n5uwugciYUtXJeM7E6ehuMxR6u87ZPBFNksMTLmrTXLbFVEplZPjlV1QWV2gLB8uP
 SBd0DQ==
Subject: [cocci] [PATCH] Coccinelle: api: Add SmPL script
 =?UTF-8?Q?=E2=80=9Cuse=5FKMEM=5FCACHE=2Ecocci=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1482
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/8d53ac92-9693-4ff9-948c-29b7fb252b89%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2024 18:38:39 +0100

A wrapper macro is available since the commit 8eb8284b412906181357c2b0110d=
879d5af95e52
("usercopy: Prepare for usercopy whitelisting").
Provide design options for the adjustment of affected source code
by the means of the semantic patch language (Coccinelle software).

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/api/use_KMEM_CACHE.cocci | 48 +++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 scripts/coccinelle/api/use_KMEM_CACHE.cocci

diff --git a/scripts/coccinelle/api/use_KMEM_CACHE.cocci b/scripts/coccine=
lle/api/use_KMEM_CACHE.cocci
new file mode 100644
index 000000000000..259a8c998bb1
=2D-- /dev/null
+++ b/scripts/coccinelle/api/use_KMEM_CACHE.cocci
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Simplify a function call by using a known wrapper macro.
+//
+// Keywords: wrapper macro conversion cache creation
+// Confidence: High
+// Options: --no-includes --include-headers
+
+virtual context, patch, report, org
+
+@depends on context disable sizeof_type_expr@
+constant char[] text;
+expression alignment, flags;
+identifier name;
+@@
+*kmem_cache_create(text, sizeof(struct name), alignment, flags, NULL)
+
+@depends on patch disable sizeof_type_expr@
+constant char[] text;
+expression alignment, flags;
+identifier name;
+@@
+-kmem_cache_create
++KMEM_CACHE
+ (
+-text, sizeof(struct
+ name
+-), alignment
+ , flags
+-, NULL
+ )
+
+@x depends on org || report disable sizeof_type_expr@
+constant char[] text;
+expression alignment, flags;
+identifier name;
+position p;
+@@
+ kmem_cache_create@p(text, sizeof(struct name), alignment, flags, NULL)
+
+@script:python depends on org@
+p << x.p;
+@@
+coccilib.org.print_todo(p[0], "WARNING: opportunity for KMEM_CACHE()")
+
+@script:python depends on report@
+p << x.p;
+@@
+coccilib.report.print_report(p[0], "WARNING: opportunity for KMEM_CACHE()=
")
=2D-
2.43.0

