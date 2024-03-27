Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E5EC54E67
	for <cocci@archiver.kernel.org>; Wed, 27 Mar 2024 13:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=DqdtVmEhkl4Nna1V36uPqCzGe+SfZ6RaLtSSk2wAW+s=;
  b=giVcLwy3lcLuQtBDV1u0ZKL+NIZXS5qWksAPFHzYUJT0sfDpkko1OIrF
   3YSciAwWRlfOz4pWqQ+C0aKm8XHPFcaUDmIdkBxAQxR3RBXn7HjjFOzHz
   HTMEbZRqIuYp3lIc1LeK2+IWGVFKdU7msVb4kk6iYi6gBo0xKfZS5LWbL
   g=;
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
X-IronPort-AV: E=Sophos;i="6.07,158,1708383600"; 
   d="scan'208";a="158741271"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2024 14:10:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CE421E0147; Wed, 27 Mar 2024 14:10:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2E024E008A
	for <cocci@sympa.inria.fr>; Wed, 27 Mar 2024 14:10:37 +0100 (CET)
IronPort-SDR: 66041acd_klumkPNmEDKz0MJ4g57/Taj/yGet1dRUOa2tWqgNE+Na52u
 YvCnetpXDUnOX4tDDhP5okU7Bx9YJz0erkvVlkA==
X-IPAS-Result: =?us-ascii?q?A0G1EQANGgRmhw4P49RaHgEBCxIMQIFEC4I5f1MyBAtIh?=
 =?us-ascii?q?FaPRYF1gQ41gyiHOJA+gxY+DwEDAQ1BAQIEAQEDBDcBgVOCdIgIAh4HAQQzB?=
 =?us-ascii?q?g4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4VtD?=
 =?us-ascii?q?YJnARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHRCcdAQERJgEuAQUCJgJNE?=
 =?us-ascii?q?QESAgEBgnyCKwEDMQewXoEygQGCCgEBBq9cHywiV4FhCYEaLognAYUzQgmCU?=
 =?us-ascii?q?WmBIQ+BVUSBFSeBFIE3dogegmiCFoM3hFWFPI8TgT6FMoFSHAOBBWsbEB43E?=
 =?us-ascii?q?RAFDg0DCG4dAjE6AwUDBDIKEgwLHwVUA0AGSAsDAhoFAwMEgS8FCxoCECwoA?=
 =?us-ascii?q?wMSSQIQFAM4AwMGAwoxLk9BDFADZx8xCTwPDBoCGxQNJCMCLD4DCQoQAhYDH?=
 =?us-ascii?q?RYEMhEJCyYDKgY2AhIMBgYGXCAHDwkEIwMIBAMrJQMgcBEDBBoECwd2gz0EE?=
 =?us-ascii?q?0QDEIEyBooTggmBNimBd4Eqgw8IRh4DGSsdQAIBC209NQYDCxsGIh4Cp0OBD?=
 =?us-ascii?q?oIGcMUtNAeCNoFggWEMn0EGEy+XNg4GkmQBLoVpgW8WkEYgo0yFFzWBRSSBX?=
 =?us-ascii?q?DMaJIM2TwMZD44gGYQUlTdCNTsCBwEKAQEDCQGBVYNwAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
 g==
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:w+xJ/6OvOJu7ksBcThmjsMiBIKoaSvp037Dk7TESdfUnSKylfq
 eV7ZImPH7P+VEssRQb8uxoV5PufZqxz+8R3WBzB9mftWvd1FdARbsKhebfKlbbaknDH4BmpM
 RdWpRfTPvtEFN9kcH22wWgFc08qeP3i5xAyd2+8593JzsaEp2IAj0JcjpymSBNLjV7OQ==
X-Talos-CUID: 9a23:1HZWHm3wFO3noY3TWoJ/DbxfK8kKVl7R5nTrP2SGFW9YUIeSQFac5/Yx
X-Talos-MUID: 9a23:A5bOAwhlle5SHhvxMZLv18Mpaft2/r+lVmQ2lLomqsqjZBx1FBmtpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,158,1708383600"; 
   d="scan'208";a="158741263"
X-MGA-submission: =?us-ascii?q?MDHpsUtboue+d/rVBhlCwH5T3+9XQSyefZaN4E?=
 =?us-ascii?q?c6aXZvjuDf3tl0FGT0UqgdfQ3FEwiG/wzZ3O027gU+GDGeK701R2O/1R?=
 =?us-ascii?q?3xdHkxkrWtO+BxYRwy+5x6lbeYkXkk3vvYxswCS8tI3leQgGZ6/vM6fe?=
 =?us-ascii?q?2ui0g+Pl2pes2MHvopk2FnCQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 14:10:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711545035; x=1712149835; i=markus.elfring@web.de;
	bh=DqdtVmEhkl4Nna1V36uPqCzGe+SfZ6RaLtSSk2wAW+s=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=kAxnOBJaDM6eXQahXFstfTa9+kemCOOTLnXjkEU+FWouPd5W/TKMI10SkQOW/eVm
	 AAYYuDznjqKIUdOe84utsz3KZ3W7oaCYw8fTBsqV8S264YAOXrcOXI2JrvgJcL/zO
	 m0Bd23Qcg2lBAALlt6pcoracJJnkQn1jMkfb07VN6I7XLqiQOyTlXz93kB0tr7wLH
	 v5ik0bWviOk8reeHHVMMlCziCIcZlc3llVY5xaeqdVvrgFhPY4cZeXrwFpPhOB2Rr
	 sCoutegslFi8Ov6JQwr/svBWZENSZb8CR+Q9Vtxg76GOc9vOorrGELqBynHJZ/UXX
	 tgXS0GBlFSMBf0R27Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2jWK-1sqOoB2vXQ-00vB5u; Wed, 27
 Mar 2024 14:10:35 +0100
Message-ID: <b1d4a52f-4dbb-48a3-be59-8e9915f21fa9@web.de>
Date: Wed, 27 Mar 2024 14:10:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/GsLLolzgh3Wa2AC7CoJ+Uxsk9+136AxseuiGYTn64DzRS/S+eb
 94wDxJ3m9vCw81/NujQP+PwEx2iVtTwH1YnWGe3Q/+mu+J/RLPxUp6oCF3yTXkEk4miqU+1
 BQOH2wqk06rvPBvo5pxvyWevTwTlkG9RZ81z5bWgevzEofZtO4Zi8E9W8BRPd/elPKWwzaP
 FbQOz0cq69ohbPJDA493w==
UI-OutboundReport: notjunk:1;M01:P0:Y/bbGx8rh3w=;UXBewfoOnNthhQhTisIQ2qEfgqb
 tT6gbGXsn3szUoSIPIxhyztP7NEajaHuUf1X8KE7Kvz2FvzEcrPdy+iIprIZIIXY1/zLiHbKV
 BNIxTllP9bu1jZTh0DKXPkJVYGIb1P6AzDP6irHg2BzNqBfvODY1zrlDqkR0TROkElMmO0Bkg
 ZAses44mEj779kI7XDunee0tmkerXKJBcoOO0CMYWP/sBSeyhdaHosHjPjEPbgMPHubfbMBwo
 xqpY1n69ZZxayA7xM1rNpK3tPnhxKlt7GLjn1JOa7uRhroknUmcuCkVMstvUwXmYdnhiMJbd6
 ViUd+pvSRHRlsRewgT6HZY5sZxR0pEOO0PhGQijHjdvYjFdvPTKETwt1yKwNLQ3wKHx+BCmCL
 T6FpWMI4q5A55/toXjY7r27M2g73/GwoK1bJwvgaf+/WMZq7/AzbEmGnpj7DgJfskyDR/zuGk
 1R2ueSLDWmAdJ2nV9UacgIpLkhCZvOdAjqIMX1lUhcOhGzT7WN4N2f0w3OHr7VCAcyg1lhJbB
 PTsMFU4h2ss3EV5eAPXQBHRT+99IPQyLaxtxqcWWI3ET/bORItwCkgEhkwNJ8Q/g5IHQDLcMy
 evuB7YIltZnvzlrDK5XMdXJjWjCgzxr9G/c+H8rIFuKPgbYVQMIQblP87ocmTHUAz3z4qh4Q+
 4lP4K6V0JKBZpqd1JvdvJpKYa842HcReern/JhMKkWnxn6qgMrOBIMyqaJenWpECjU+wku26A
 g8SI4q/dkyl85ghlGkl7vkHrmTHjhRgUHutPrAerboglvw+F2m3aLLwGhC/8taggS5RzRaFAl
 CcvUDsQpkMsGaGqUt21rIABkIsvDwaedoY0h9JIdQxGg4=
Subject: [cocci] [PATCH] Coccinelle: api: Add SmPL script
 =?UTF-8?Q?=E2=80=9Cuse=5Freturn=5Fptr=2Ecocci=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1622
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/b1d4a52f-4dbb-48a3-be59-8e9915f21fa9%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Mar 2024 13:56:03 +0100

A wrapper macro is available since the commit 54da6a0924311c7cf5015533991e=
44fb8eb12773
("locking: Introduce __cleanup() based infrastructure").
Provide design options for the adjustment of affected source code
by the means of the semantic patch language (Coccinelle software).

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/api/use_return_ptr.cocci | 57 +++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 scripts/coccinelle/api/use_return_ptr.cocci

diff --git a/scripts/coccinelle/api/use_return_ptr.cocci b/scripts/coccine=
lle/api/use_return_ptr.cocci
new file mode 100644
index 000000000000..7b42a58cceb2
=2D-- /dev/null
+++ b/scripts/coccinelle/api/use_return_ptr.cocci
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Simplify a return statement by using a known wrapper macro.
+//
+// Keywords: wrapper macro conversion returning objects
+// Confidence: High
+// Options: --no-includes --include-headers
+
+virtual context, patch, report, org
+
+@depends on context@
+expression e;
+@@
+ if (!e)
+    return NULL;
+ <+... when any
+*return \( e \| no_free_ptr(e) \)
+ ;
+ ...+>
+
+@depends on patch@
+expression e;
+@@
+ if (!e)
+    return NULL;
+ <+... when any
+(
+-return
++return_ptr(
+ e
++)
+ ;
+|
+-return no_free_ptr
++return_ptr
+ (e);
+)
+ ...+>
+
+@x depends on org || report@
+expression e;
+position p;
+@@
+ if (!e)
+    return NULL;
+ <+... when any
+ return@p \( e \| no_free_ptr(e) \) ;
+ ...+>
+
+@script:python depends on org@
+p << x.p;
+@@
+coccilib.org.print_todo(p[0], "WARNING: opportunity for return_ptr()")
+
+@script:python depends on report@
+p << x.p;
+@@
+coccilib.report.print_report(p[0], "WARNING: opportunity for return_ptr()=
")
=2D-
2.44.0

