Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D54C433FE
	for <cocci@archiver.kernel.org>; Mon,  7 Nov 2022 11:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=EjdqGj77kZX7BdzBwYal3mc/7aZEl+OAgMkczfDOcv8=;
  b=Lb9YBHesu/o77raUiBXLQ31zv7jcrgCqPSQwqi03zctGDxcryEqlkNHm
   jTos2ZhZckvkBaPQlTvFEh6anx1LZD9Rl32ah59CpWmjcGJ0n9KvevW67
   vyFv0rHwC3vTY5AP9KVjdhf/YmIMBssrxt5AciVFgGecPrLcVQ9wlSjkZ
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.96,143,1665439200"; 
   d="scan'208";a="77006224"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2022 12:58:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 468D0E019F; Mon,  7 Nov 2022 12:58:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8CD86E0157
	for <cocci@sympa.inria.fr>; Mon,  7 Nov 2022 12:47:15 +0100 (CET)
IronPort-SDR: 6368f043_pE2APvFcZfzNhYqqRLfxbl0gy1Qh7OCGiAuqqWOrOrvwHGO
 Ckc4S7oCAXMxgZgK6xACuyI5VuR35YLps+h/19A==
X-IPAS-Result: =?us-ascii?q?A0D8BQDE7mhjfUel3FVaHgEBCxIMQIMqUnZjLQQLRYROk?=
 =?us-ascii?q?jCWQYdkAQMBDUEBAgQBAYNyhg0CHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAQBEwEBGgkuDgUihXWCNSkBhA0PAUY1AiYCXwESgn2DIgQDq?=
 =?us-ascii?q?XGBMoEBhHCbJoEngRQshykdV4MqgRuCRIIKgimBFYE8gTd1iBuCZwSBB4swi?=
 =?us-ascii?q?k84AwkDBwUsHUADCxgNFjIDChM3GzEnDgkfHCUNBQYSAyBuBQc6DygvZyscG?=
 =?us-ascii?q?weBDCooFQMEBAMCBhMDIgINKTEUBCkSDSsnbwkCAyJqAwMEKCwDCUAHJyQ8B?=
 =?us-ascii?q?1c6BQMCECI6BgMJAwIiE0RzATASFAUDDRclCAVOBAg5BQZTEgIKEQMSDyxHD?=
 =?us-ascii?q?ko+ORYGJ0QBMw4OFANeTR2BAwSbaQGBDcVMB4IegUygOEyWe5IaLYccj2ggo?=
 =?us-ascii?q?hk5NIRRgXkjgVtxgzZPAxkPjleOGkEzOwIHAQoBAQMJgjqDDQEBfoQfAQE?=
IronPort-PHdr: A9a23:Xwq1iRYQZSx8ZmCVwHLUI+X/LTE22oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1gOPB9WQsaMMy7KP9fy6AipYudfJmUtBWaQEbwUCh8QSkl5oK+++Imq/EsTXaTcnF
 t9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+M
 hq7oR/PusQVjoduNKI8wQbNrndUZuha32xlKUydkhrm+su84Jtv+DlMtvw88MJNTb/0dLkiQ
 7xCCzQmPWE15Mn1uhTGUACC+HgSXHgInxRRGwTK4w30UZn3sivhq+pywzKaMtHsTbA1Qjut8
 aFmQwL1hSgdNj459GbXitFsjK9evRmsqQBzz5LSbYqIL/d1YL/Tcs0GSmpARsZRVjJOAoWgb
 4sUEuENOf9Uo5Thq1cSqBezAxSnCuHyxT9SnnL43bM03vo8Hw/I3wIuGN0Bv2jbotjuKKcfU
 vq4wLXSwDnfbf5b3yr25ojSchAmpPGBRbx/cMTPxkIyEg3FikufqY3jPzyLz+gDtm6D7+xhV
 eKglmUqrBxxriKsxscolIbJh4QVxU7d+SV6x4Y6O9u4SE90YdO/CJtfqSeaN4RrQsM+WWFov
 yA6yrwJuJKhYScF1o0qyhjCYPOIb4aG+AjsVPqNIThmnnJlfqqyigi9/0S+xePxSse53EtKo
 ydFktfBtm0A2RPX58aIRfZx41mt1CqA2g3Q6+xIP045mKrVJZMhzLA9lYYfvFjNECLwhU74j
 7eWe10n9+Wo8ejrfKvqqoOGO4NpiwzzMr4il86iDeggLAQBRXSX9v652bL94EL2XKlGg/gqn
 qTctJ3WOdgXq6ukDwBI14su7hSyAjWg3d8Fh3cINkhFdwiCj4XxO1HBPvT4DfCnjlSpjjhr2
 /HGPqb7DprTIXnDjK3tfa5j5E5axwoz0Mxf54hTCrEHIfLyVVX9u8HGARMhMgy0xfjoCMll2
 44dWW+DGLGVPL3OvVOS++4iIumBaJUXtTrgM/Ql4uThjX49mV8TZ6mp2p4XZWilHvRlJ0WUe
 mLsjckHEWcFowo+UPbqiFqEUT5SaHe+Rb8z6S8jBIKgFojMXpqtj6CZ3CenAp1WYXhLBk2UH
 Xfya4qEQ+sMaD6VIsJ5jjMEUqSuRJMg1Ry1rw/7y79nLvLO9SECtJLj0sJ15+zJmh0o+zx0F
 ZfV72bYbXxwn2pAYzYp1aR76Rhf11OC2O5ciuNREdh75vVTUw58O4SKi6RcCtv1XgvaNu+AT
 Fe2CoGgADo2StsqhccHZ0dtM9Snhx+F0TD8UJEPkLneOYM5uoHY0nn3KoNeVXDH2+F1kh8lR
 sZOM2Djhaly8QncL5bElUqEi7ytc6UMmiLAojTQhVGStV1VBVYjGZ7OWmoSMw6P9YyRDiLqS
 ravDe5iKQ5d0YuYLaAMbNT1jFJATfOlOdLEYmv3lX3jTQ2QyOaqa4znM34YwD2bEFINxh1V/
 nKLNA4zQySmrmTfAxR2GFTgfl/29u9/uDW3Qxx81BmEOnVozKH94RsJnbqZQvIX0KgDvXI8q
 DFcBFu70M/KEd2GphoncKgPKcgl7gJh0mTU/xd4IoTmL61mgQsGdB9rukr1yxhtIoBNjckx6
 n460ExqJKSXzU9bcDWZzdb8N9U7M0HU+xaiI+7T01DaipON/7sXre4/oBPltR2oEUwr9zNm1
 cNU2j2S/MeCCg1aSp/3Xkstknoy77jHfikw4Z/V3nxwIOG1tDHFwdcgGOoizF6pYd5eNKqOE
 AK6HdcdAoCiL+kjml7haRxhXqga6eg3O86ncfbD26mmOudvtCqri2ta/Jp61EOcsSZxC6bJ0
 5sD3/CEz16fTT6v6TXp+svzmI1CeXQTBj/vlG6+XtYXP/MvO9lSWgLMa4Wty95zhoDgQStd/
 V+nXRYd3dOxPACVZBr71BFR0kIepTqmnzG5xnp6iWJMzOLX0SrQzuDlbBdCNHRMQTwokFToC
 ZC5id8HQFKvaQk50heorxWfpeATtOFkIm/fTF0dNTWwLGVvU62987mFbshO57swvCNYTfimZ
 labWvjxrlFJtkGrV3sbzzc9eTawv5z/lBEvk2ORIkF4q3/BcN1xzxPSjDDFbcZYxSFOBCxxi
 D2NQ0O5I8Hs59Kf0ZHKruG5UWulEJxVayjii42a5mO34mhjABv3mP7W+JWvDAs++Tf20dZ3S
 T/PqhfsJIXmn6i3KuNoeEB0CUS0u5c8QNsm1NJu2ddPgDATnd2N8GACkHvvPNk+u+q2d3cLS
 TMRgpbU7AXjxEx/PyeMzoP9WG+ax5gpbN27b2UKnyMlupAXTv3OtPodw3Yz/QPryGCZKeJwl
 Toc1/Y0vXsTguVT/REo0j3YGLcZW09RIS3rkR2MqdG4tqReImi1It3SnAJzm86sCLaar0RSQ
 nH8L90/HitY9sh5P0/Qynr165GidNSaPrdx/lWE1gzNieRYMsd7i/kOrTJqP23goWcize8ry
 xBjl8LyrM2MLGNj+7i8CxhTO2juZs8dzTrqiL5Xgsec2438e/cpUiVORpbjSuikVS4Drfmyf
 RjbCyUy8z3IUaqaBwKU711q6m7CA4z+fW/CP2EXlJ1nVHz/bARakFIMUTM1g58/GBqrycrtd
 FY/6j1Z406qshZKxf9pMVzxSGbSoguse3E4RdCJJR5SpGmu/m/zNsqTpqJ2FiBcpNi6qRCVb
 3acbEJOBH0IXUqNAxbiOKOv7J/O6brQAO32NPbIbbiUzI4WH/6V2ZKi1Jdn9DeQJ42OOHdlF
 fgyxktEWzhwBc3YnzwFTyFfmTjKaoaXoxK1+ys/qc7akryjQAX0+Y6GEKdfK/1q9gy3muGOJ
 /LWnCt/JitEzJQKxG+OxLVelF8ehidydiW8RLQNsSmeKcCY0qRTDhMdd2ZyLJ4YsuRmhFELY
 JCGzIyshdsaxrYvBlxIVELsgJSsbM0OeSSmMU/fQVyMP/KALCHKxMf+ZeW9T6dRhaNarU7V2
 37THkn9MzCEjzSsWQqoNLQGkSKfFARTvo6gbgxqD2nzCt7rIE7eUpc/nXgtzLs4i2mff3YbK
 iR5elhRo6e46C5Eg+45FnxdqGJoK+aZhzye6ejIbJob+6gOYGw8h6dR53I0zKFQ5SdPSalum
 SfcmdVppkmvjuiFzjcPuP9msjtNi5+Xp0JkOLWf+pQSAR4sEzoV4GOfFggQoN1kGpvjtvIJo
 jAuvKf+NDZZtd/E4Y0ECs7bNd6dN3wgIVzlFWyMZDY=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:XO6YoKsUuRApPbNDJJAkjCk27skDm9V00zEX/kB9WHVpmwKj+f
 xG+85rsiMc6QxhPE3I9urhBEDtex/hHP1OkOws1MmZLWrbUQKTRekIh+bfKlbbehEWmNQz6U
 4ZSdkdNPTASWFGvILd+wm3E9EpxZ29/KqpnOfTyGoFd3AQV4hQqz1QTiqLEkkzbg9AApYyCd
 6936N81lydUEVSVOz+KmgEW6zmr93P0L38ZxpuPW9f1CC+yQmBrJLqExzd5B0XVDRCzN4ZgB
 D4rzA=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,143,1665439200"; 
   d="scan'208";a="77004775"
X-MGA-submission: =?us-ascii?q?MDEUVz42nQPyVIC1YtqdGvzxq6lKSD98at077C?=
 =?us-ascii?q?tI4IBWJ/0N7g8S2gOGGrtbkOwcRKcsvhrJ3E7rAYyd/S65Nqk/mMDrzX?=
 =?us-ascii?q?vJYmvHvbZwUJJKnKRPNQMz6wzrrf6pT2geFHQdnB0T/u41kFPMiQ/3wM?=
 =?us-ascii?q?TILMaFTlIen7+xCFzTbnV85w=3D=3D?=
Received: from metis.ext.pengutronix.de ([85.220.165.71])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 12:47:14 +0100
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1os0at-00025I-Fz; Mon, 07 Nov 2022 12:47:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1os0ar-002qN3-5E; Mon, 07 Nov 2022 12:47:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1os0ar-00ExHH-Gw; Mon, 07 Nov 2022 12:47:09 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: linux-kernel@vger.kernel.org,
	cocci@inria.fr,
	kernel@pengutronix.de
Date: Mon,  7 Nov 2022 12:47:02 +0100
Message-Id: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: cocci@inria.fr
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v1] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Reply-To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-Loop: cocci@inria.fr
X-Sequence: 717
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/20221107114702.15706-1-u.kleine-koenig%40pengutronix.de>

devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalent to
the shorter devm_platform_ioremap_resource(pdev, index).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

a potential improvement is to check for invocations of
devm_platform_get_and_ioremap_resource() where the res parameter isn't
used afterwards, but my coccinelle foo isn't strong enough for that.

Best regards
Uwe

 .../api/devm_platform_ioremap_resource.cocci  | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resource.cocci

diff --git a/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
new file mode 100644
index 000000000000..401610b9a17d
--- /dev/null
+++ b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Don't use devm_platform_get_and_ioremap_resource with NULL as third parameter
+// Confidence: High
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@r1@
+position p;
+@@
+ devm_platform_ioremap_resource(...) {
+	...
+	devm_platform_get_and_ioremap_resource@p(...)
+	...
+ }
+
+@depends on patch@
+expression pdev,index;
+position p != r1.p;
+@@
+
+-  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
++  devm_platform_ioremap_resource(pdev, index)
+
+@r2 depends on !patch exists@
+expression pdev,index;
+position p;
+@@
+
+*  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
+
+@script:python depends on org@
+p << r2.p;
+@@
+
+cocci.print_main("WARNING opportunity for devm_platform_ioremap_resource", p)
+
+@script:python depends on report@
+p << r2.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for devm_platform_ioremap_resource")
-- 
2.38.1

