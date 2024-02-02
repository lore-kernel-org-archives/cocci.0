Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF5CC47258
	for <cocci@archiver.kernel.org>; Fri,  2 Feb 2024 09:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IpkI2NbT13czMR2fwaCemMXhbQ3i1t6ZiiOtQiEa87I=;
  b=grvl+4pnljHRH+jfqxQS1KDXF76eNObngvYHGF+HpAcooGNljbKin2ZX
   k/vzHCMAXV1KX9mEw/gw/+IvxbECHR7H1hxIi+xjWguv4Z5tNfjyIyJbx
   2ou6ej7STz+eEzCz9PWvOfJ6tqjKSzZvYr7j/0hNRX8CEYrPh0PjCUb9x
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
X-IronPort-AV: E=Sophos;i="6.05,237,1701126000"; 
   d="scan'208";a="149926924"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Feb 2024 10:12:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 057D6E0CD9; Fri,  2 Feb 2024 10:12:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E5FFEE008A
	for <cocci@sympa.inria.fr>; Fri,  2 Feb 2024 10:12:26 +0100 (CET)
IronPort-SDR: 65bcb1f9_KSSvynjDMYX632K5g/hYZcowJsIi+F49rX4MJeEdB2ZDXJm
 wwoP70v9d/A7GeTOGaYzWPLbYCu+I919lAiGNvQ==
X-IPAS-Result: =?us-ascii?q?A0G+AgDisLxlhwMP49RaHgEBCxIMQIFEC4I5fFYyBAtIh?=
 =?us-ascii?q?FOPQ4F1LQOBE4Mol3SBVoFAPg8BAwENOwYBAgQBAQMEOIFTgnQCh1UCHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnh?=
 =?us-ascii?q?WwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAg06QgMDIx0BAREmAQ8fA?=
 =?us-ascii?q?QUCJgICSwsGARICAQGCfAGCKgEDMQcNtkWBMoEBggoBAQavWh8sIlaBYQMGg?=
 =?us-ascii?q?RouiCYBhSxCCYJPaXonD4FVRIEVJwuBCYE3dogegmiCF4M/hF2FWYZGhD6BU?=
 =?us-ascii?q?x0DgQZtGxAeNxEQBQ4NAwhuHQIxOgMFAwQyChIMCyEFVQNABkkLAwIaBQMDB?=
 =?us-ascii?q?IEwBQ0aAhAsJgMDEkkCEBQDOAMDBgMKMTBVQQxQA2QfMgk8DwwaAhsbDScjA?=
 =?us-ascii?q?ixAAxEQAhYDIhYENBEJCyYDKgY2AhIMBgYGXSMHDwkEJQMIBAMrKQMhdBEDB?=
 =?us-ascii?q?AoDFAcLB3iDRwQTRAMQgTQGhVMDGSsdQAIBC209NQYDCxsGIh4CmyMBgkNZN?=
 =?us-ascii?q?SyBWnDFFTQHgjSBYIFhDIoalRoGEy+XLQ4Gkl4uhWiBbZBSIItWgXeVcoURN?=
 =?us-ascii?q?YEuOoFcMxokgzYTPAMZD44gGYQUhGGKZkA1AgEBATYCBwEKAQEDCQGBVYNwA?=
 =?us-ascii?q?QGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 BYCh7/1f9x7Cw==
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:RptGv6C8wmh6e2PlHejnsceALOsnbusQ8zAXPhhKOGRom7+j5r
 uTdZUgpGDJYVMqKQcdcL+7Sc29qB/nlKKdpLNhRItKPzOWxldATrsSircKqgeIc0aVm4Izu5
 uIMZIObuEYZmIK7voSlTPIdurIt+P3kpxA692/815dCSl3dqBt6Bp4AA6HHkBBZCQuP+tPKL
 OsouZBuH6OYnISB/7LdkUtbqzji/js/aiWFCLuTCRXkjVmxQnYlYLSIly/wgoUVS9JzPMDyA
 H+4n3Ez5Tmive/yhXN7Uv61Kk+oqqp9vJzQPWWjNUSQw+c+TqAVcBbV6KOuypdmpDc1H8a1O
 TomX4bTrBOwkKUQUGNmjeo4QPp1zEj8GWK8y7RvZLMm72EeA4H
X-Talos-CUID: =?us-ascii?q?9a23=3AxS+otGtWJgeZa+5AlBcM2OJA6IsOaXLhlVjoDHa?=
 =?us-ascii?q?CMl9iRbu/Yxidp5J7xp8=3D?=
X-Talos-MUID: 9a23:6bJy2gkN/jpCtnapNdnpdno9aeIy4IOfEnpclLY3osa9MHRzGQik2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,237,1701126000"; 
   d="scan'208";a="149926917"
X-MGA-submission: =?us-ascii?q?MDHU/1a1kVMG0w/rvzldmckkak2rsgUqOp2Xli?=
 =?us-ascii?q?xRqIXZOEnn9sZUmxEZ1jIUa/p+QU7FznUPZeUFJC2LV1Gk8m/j2HgRuo?=
 =?us-ascii?q?HK0yErIhcNbP2Fu6PVB3bSmE8CyDe1EkDdnEpNe4+2eiUWb/QvloXfgZ?=
 =?us-ascii?q?Apl4PrJbHoEeaQUxGOypEI8w=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 10:12:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706865133; x=1707469933; i=markus.elfring@web.de;
	bh=PKmuhun5hicJU/NJ+sjbWZRyKiIfaq+KU/2m4Ypz33I=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=YoZ2lFXmvZ2OprFlyHqNnul+Ti7iHoHITbf/Qv0+sYybFDyFPApxcYZgco1NbLrC
	 g3G9qqdg4oXTAQSst/+WjVpfztqZ/wzP7BkvkT6NansAGe0KEVTzOqueONLAHqWbN
	 PBMhCUwEUNV4nZQjn0JBHn4O8QCoIIRmOGD5qTCqiYywWDMXh3HYMx5rDGCQ6yFRz
	 pY7mbX0+aKaAR5/i0JjW2wxWmlNtuYxoTyjR+CtggGB1RueVvAK5/7zN54jaQTgE6
	 rLhBbiSgoKdGSWvYX0C7ZAjsrvlRLqMQfVIgkAwqA3uLr0r4mi+jz9SuEvhpTtizg
	 e0CqsZELpXvnX/Tfag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnpGw-1qhbb519uE-00pcid; Fri, 02
 Feb 2024 10:12:13 +0100
Message-ID: <b08603d6-cac1-4876-a56c-30c680d5dc52@web.de>
Date: Fri, 2 Feb 2024 10:12:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>
References: <8d53ac92-9693-4ff9-948c-29b7fb252b89@web.de>
In-Reply-To: <8d53ac92-9693-4ff9-948c-29b7fb252b89@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WNCUmyqr1pA3HJoX6TmKsz0s9lqwB4W+ZMqtYmkzCS8cyhcxsx9
 tAQx6sZaiCBtz9m4H2Ox0OhV7tD0tcSninKyEtTVwNLfWbhGiD9JCIPpzw7DW1Q7nvpTbNV
 uTDlfbW8ZxrlscWTyEMoFq2A18KF0AbW71Vg0B/tCYy8nxDzSc/ybeSqszx7OcwAJhzxRgd
 vATfRD6HOZ0v6XQYh43tQ==
UI-OutboundReport: notjunk:1;M01:P0:tTVq7jzpR08=;Ye8eBRyqLIxiAqAKtJr7JfjMptl
 S5uHgF3J4FUjCnAwNxEyn/aBm81DuYwi8W4WDjpaq9MydncgDfwEbBXkwJJZJXIeadL7ucYnb
 oyEVtHK8jNzKUpxdk2cKc+UZSGeK1WEpyEwDQFkmTrRf91cvFK5K+5LCmrqfoixHRIcuMTFJz
 bPq0rFrUoao+APs7wVUE0G01IZhoqYfuBkU5oQzmrf6pphelpM09gbupzrgehoXYI/hshyAAW
 lMb+typeC4i1wowqVjWc7DVXJb9gJMxOYRiFHv/i90ZqAftI1siCJHRHQh0Ljj7mpjY9uGPlg
 3J+8N7Fo6hEtq+wBGyBoWR4o52h+sFarmhaqEbHW3Vr3V33HZkpUajN5dUw3y9Dd7vg6w2Wph
 956D0XvJJbVpf8bDxz8l4Ft2YBmd9gXQlKtyIY5HUViKPTDisvsrx6FvtIZNopfQWMQq01KC/
 zpwUD3JKpuVlwEGtlKW+G3dsfBgm13rgj93imZaw8b2eXHrkl0xddxIhvMZGm5fjkjsIZ1Tjs
 I0CiAQERgPGNtTU4PWRymE2o9omIqGE4fDJ8kexA21WqkVbt6bwyxy5gTMoNyuWl1WQMDL+SV
 jbEvFxuWBeol9//5Kp6eIOh5/PpNkitzHq0nJ3rmp1sOwqMRQy2XGsheW8sUyDFkadOK2ZiGH
 JAt0UogtvCoEfkw6zv93QELD3AoB+ZJrrj7FgCeVdBLKRzDi8qIRo66QLPEosp5gV27UCnp38
 cPAnm2qwkYVsz6iAKs8neuRff1Q4WellYdaVot+IakM13/qggfkOu6777fjsZC4DFySQZz+zy
 VAx7rBZAaHem7dtr/fkvyNe9ejqfl7h/N2lz6ROjPi30Q=
Subject: [cocci] [PATCH v2] Coccinelle: api: Add SmPL script
 =?UTF-8?Q?=E2=80=9Cuse=5FKMEM=5FCACHE=2Ecocci=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1492
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/b08603d6-cac1-4876-a56c-30c680d5dc52%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2024 09:48:11 +0100

A wrapper macro is available since the commit 0a31bd5f2bbb6473ef9d24f0063c=
a91cfa678b64
("KMEM_CACHE(): simplify slab cache creation").
Provide design options for the adjustment of affected source code
by the means of the semantic patch language (Coccinelle software).

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
* The reference for the previous commit was adjusted in
  the patch description.

* A constraint was added for the metavariable =E2=80=9Ctext=E2=80=9D
  also based on information in a hint by Julia Lawall from 2018-02-17.

  [Cocci] Clarification for scripted SmPL constraints
  https://lore.kernel.org/cocci/alpine.DEB.2.20.1802171531330.2205@hadrien=
/



 scripts/coccinelle/api/use_KMEM_CACHE.cocci | 53 +++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 scripts/coccinelle/api/use_KMEM_CACHE.cocci

diff --git a/scripts/coccinelle/api/use_KMEM_CACHE.cocci b/scripts/coccine=
lle/api/use_KMEM_CACHE.cocci
new file mode 100644
index 000000000000..e158e4c7c1d1
=2D-- /dev/null
+++ b/scripts/coccinelle/api/use_KMEM_CACHE.cocci
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Simplify a function call by using a known wrapper macro.
+//
+// Keywords: wrapper macro conversion cache creation
+// Confidence: High
+// Options: --no-includes --include-headers
+
+virtual context, patch, report, org
+
+@initialize:python@
+@@
+def is_equal(text, id):
+   return True if text[1:-1] =3D=3D id else False
+
+@depends on context disable sizeof_type_expr@
+expression alignment, flags;
+identifier id;
+constant char[] text: script:python(id) { is_equal(text, id) };
+@@
+*kmem_cache_create(text, sizeof(struct id), alignment, flags, NULL)
+
+@depends on patch disable sizeof_type_expr@
+expression alignment, flags;
+identifier id;
+constant char[] text: script:python(id) { is_equal(text, id) };
+@@
+-kmem_cache_create
++KMEM_CACHE
+ (
+-text, sizeof(struct
+ id
+-), alignment
+ , flags
+-, NULL
+ )
+
+@x depends on org || report disable sizeof_type_expr@
+expression alignment, flags;
+identifier id;
+constant char[] text: script:python(id) { is_equal(text, id) };
+position p;
+@@
+ kmem_cache_create@p(text, sizeof(struct id), alignment, flags, NULL)
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

