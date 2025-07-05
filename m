Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC79DC8303C
	for <cocci@archiver.kernel.org>; Sat,  5 Jul 2025 20:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=9WI02iNbdApOyJWKma6F1fUQwFlmblibjncCeVHDD/U=;
  b=CiPrLvzjHq/7vX1av5GqRh5ftx9T+plCjUHpFDNpPgcrix2e/MGUpet4
   XXb/c1m/eAesIXKjBKU4vKpZgs5D2eDBEcxjJ/mk37SDlU6Fe0O4+vRL3
   Q/Sx1HkujyazpBfY5FVNbhCbHNG7Pa2XPM7LJ4xpcopbMded0ttvcUV/a
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,290,1744063200"; 
   d="scan'208";a="230466124"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Jul 2025 22:05:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B860FE0131; Sat,  5 Jul 2025 22:05:58 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 87016E0131
	for <cocci@sympa.inria.fr>; Sat,  5 Jul 2025 22:05:57 +0200 (CEST)
IronPort-SDR: 686985a5_WtH5XY7tfVXya5dlwd5otRErl+CCORitVBQuGYevKnNQibz
 qzOQyHfYwB7uIXINw4dcSH0b6/JGfmdpLnD+YRw==
X-IPAS-Result: =?us-ascii?q?A0EQAAAvhWlogwsR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDgQAGVDMEC0mEVYgchzSCIYQ+k3+ECIFVgVYnAg8BA?=
 =?us-ascii?q?wENSgQBAgQBAQMEOIFUgnSLfAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABAQE6Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdA?=
 =?us-ascii?q?g0HM0YnHQEBER0JARgWAQUCJgJNEQESAgEBgn4BgiEBBhABAzIHDZBrnEWBM?=
 =?us-ascii?q?oEBggwBAQbaXh8sIlmBZQMGgRsuAYVsgmQBhVxLCYJQaXonD4FVRIEVJ4EUg?=
 =?us-ascii?q?i2CYQQYgR6EA4JpgiaBFoJVhyGIDYZYgUocA1ksAVUTFwsHBYEwMwMgCjQUB?=
 =?us-ascii?q?BkCFC8PGjIdcwwoEoVfgQ6DY0YrT4QYeEFYg1MkbQ8GgR2BDkACAQttPTcGA?=
 =?us-ascii?q?wsbBj2ScIMtAVg1AQohdGZwxig0B4I4gWeBZAyKLpU9BhMvl04OBpMBAS6Fd?=
 =?us-ascii?q?IFxFpBdIo1llhaFIDaBMjqBXDMaJIM2TwMZD44hGSWDdTeEKbxRQTUCOgIHA?=
 =?us-ascii?q?QoBAQMJAYFVg3ABAYctM4FLAQE?=
IronPort-PHdr: A9a23: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
 /Pn6az1J8IfO9+is3E=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:h6a+iqm7d1D2WAe52j0Bj/yBGdvpDfL03DAbv31ZSRFFG/FwWf
 re/sjzpiWVtN93YgBHpTngAtjmfZq4z/VICOYqUotKMDOW3VdAT7sN0WKB+VHd8kTFn4Yx6U
 4KSdkbNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHpXgu1bjjuQEWygYzRLreR9dOIE/B
 Hw3KB6mwY=
X-Talos-CUID: =?us-ascii?q?9a23=3ARto7vGqJJIEbbRFd86FsDWTmUZwLVn3P02fwGWL?=
 =?us-ascii?q?mEWhEEeKYQGOh86wxxg=3D=3D?=
X-Talos-MUID: 9a23:CQ7cGQlVk8x6pwxFreMXdnoyH8pSwLTyT3kwvpwfqcndNglLHga02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,290,1744063200"; 
   d="scan'208";a="230466120"
X-MGA-submission: =?us-ascii?q?MDFjrw7tpp05OHsYWJqf0htbFMJN3pkbkAqUUb?=
 =?us-ascii?q?JHBnGyD/hKYlAG4PLi+TEyQr4qNShpBh9q1TcwkZza2QoQBuif2ZAoUS?=
 =?us-ascii?q?NpH/ZgB2j29xaFfgiRhvbeMaPR/299KoUBNiyVJwHzzjnA3Hg/fXw1cv?=
 =?us-ascii?q?SXJMNR/ihTRV0qlejAbdFzaQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2025 22:05:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751745945; x=1752350745; i=markus.elfring@web.de;
	bh=9WI02iNbdApOyJWKma6F1fUQwFlmblibjncCeVHDD/U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lEpC6zLIorzRmz/9Y/sqcRYrkfzrMb/5Pti/LK4rg7PGovXMRAuu+sqgAeUQr+vD
	 iH0mbF9uxiy2PBjfiSpbWob+npCX57PLWi8U3jR4SJYy5bQfuONZ1t2THgt0n5a6J
	 3lfV9SfRKXA1ZITKytcm83OJ4fznxjCFUF0CekAyBVUhZ7SXu0znH+ZrjCpXDjrAg
	 mmXXaqNUOewBJSdZPZWTK4ua6m3rjc3mdjnyqm32j4HxoJhhS/gf2NXlLWP+7gxx8
	 UAg9Z0V/xu1SAdtNkkEDhpff6NBkSyC8Dy7tWtB+G+v9QgONMlzvbqRxV2qDsI1oI
	 4U3lwiupHlNrHVhtqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mty5u-1uoa3w3lXg-012Twu; Sat, 05
 Jul 2025 22:05:44 +0200
Message-ID: <30a3a2b1-deef-4f3f-b7da-4164360190ed@web.de>
Date: Sat, 5 Jul 2025 22:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:crTopZG3SyMDw0FZJSlk0C5CfAPMnmELcTzhVoKq+U98/o+GdF8
 IW+o4Fz0X2JsFnxY6wY1VdtvWhMvUmgEBtHWBdhxmo/DAFcdVl4vmAabPNFqOOobCld2FiD
 pXdGcxJIyE2CgI4O1rV+rMeak1ZbHzeJIedJjhPM6Pwh/ZtOAfLNbcTej1x+cx8IrImwkxo
 9cR6PuiuaS//Cfu55aBKw==
UI-OutboundReport: notjunk:1;M01:P0:+HnbNdr0qPk=;WvG64qlPv0ZWYzmWY89vfj+J6Im
 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
Subject: [cocci] [PATCH] Coccinelle: misc: Add SmPL script
 =?UTF-8?Q?=E2=80=9Cshow=5Fquestionable=5Fcount=5Flimit=5Fchecks=2Ecocci?=
 =?UTF-8?Q?=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2859
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/30a3a2b1-deef-4f3f-b7da-4164360190ed%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 5 Jul 2025 21:46:23 +0200

Some known programming mistakes are repeated.

See also:
* https://lore.kernel.org/all/?q=3D%22Fix+off+by+one%22

* https://wiki.sei.cmu.edu/confluence/display/c/ARR30-C.+Do+not+form+or+us=
e+out-of-bounds+pointers+or+array+subscripts


Thus provide design options for the adjustment of affected source code
also by the means of the semantic patch language (Coccinelle software).

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

A parse check for the operation mode =E2=80=9Creport=E2=80=9D provides the=
 following hint.

=E2=80=9C=E2=80=A6
Grep query
for
=E2=80=A6=E2=80=9D

It seems that such a key word tends to occur in a lot of source files.
Thus this source code search pattern will probably trigger the demand for
special computation resources.
I became curious on corresponding collateral evolution.


 ...show_questionable_count_limit_checks.cocci | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 scripts/coccinelle/misc/show_questionable_count_limit_=
checks.cocci

diff --git a/scripts/coccinelle/misc/show_questionable_count_limit_checks.=
cocci b/scripts/coccinelle/misc/show_questionable_count_limit_checks.cocci
new file mode 100644
index 000000000000..d565e306711f
=2D-- /dev/null
+++ b/scripts/coccinelle/misc/show_questionable_count_limit_checks.cocci
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Reconsider questionable count limit checks.
+//
+// Keywords: detection programming mistakes
+// Confidence: Medium
+// Options: --no-includes --include-headers
+
+virtual context, patch, report, org
+
+@depends on context@
+expression limit;
+identifier i;
+statement s;
+@@
+ for (
+      <+... i =3D 0 ...+> ;
+*     i <=3D limit
+      ;
+      <+...
+(     i++
+|     ++i
+)     ...+>
+     )
+ s
+
+@depends on patch disable gtr_lss_eq@
+expression limit;
+identifier i;
+statement s;
+@@
+ for (
+      <+... i =3D 0 ...+> ;
+(
+-     i <=3D limit
++     i < limit
+|
+-     limit >=3D i
++     limit > i
+)     ;
+      <+...
+(     i++
+|     ++i
+)     ...+>
+     )
+ s
+
+@x depends on org || report@
+expression limit;
+identifier i;
+position p;
+statement s;
+@@
+ for (
+      <+... i =3D 0 ...+> ;
+      i <=3D limit
+      ;@p
+      <+...
+(     i++
+|     ++i
+)     ...+>
+     )
+ s
+
+@script:python depends on org@
+p << x.p;
+@@
+coccilib.org.print_todo(p[0], "WARNING: Reconsider questionable count lim=
it check once more.")
+
+@script:python depends on report@
+p << x.p;
+@@
+coccilib.report.print_report(p[0], "WARNING: Reconsider questionable coun=
t limit check once more.")
=2D-=20
2.50.0

