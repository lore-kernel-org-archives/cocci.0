Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A970D1356C
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2024 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=YhO//bO621t7BGGosVsytQ78SLPgR+dQxqYbb4Ol6B8=;
  b=Tf/M9yW+u8T0GoBk51czYernz0N7P2TtnMl8EfnlOsc7w6qioVB7XJw9
   rmqTFpCodX9dDBS7V6IvJO9Ss4w0IQ53SBQ4Vu10yeb2hPU3SNtlYewZg
   qR1x0UPmoBShM3QXyLMvx9RLShBObZMILwIrNZUFhGUjE+EsUoQIshqsJ
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.dev
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190922879"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2024 16:26:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EBC79E0D1E; Sun, 27 Oct 2024 16:26:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 53279E00B7
	for <cocci@sympa.inria.fr>; Sun, 27 Oct 2024 13:59:52 +0100 (CET)
IronPort-SDR: 671e393d_ze/9u453QSxZW8WZnW/bJk3QNWa5UEbcDrkGVkfV8e3kyTZ
 yDu2B+mzT7AvEBz2WrO1W5Tn+9zCvmuHGXVgFVw==
X-IPAS-Result: =?us-ascii?q?A0FWAQC5OB5nhbCv2ltaHgEBCxIMgggLgkSBVjQHCEi0X?=
 =?us-ascii?q?IFoFg8BAwENRAQBAYUHiikCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEBAUBJhXsNgmIBhAI2AQ0BATcBgTwBgxOCZQewfIEBg?=
 =?us-ascii?q?gwBAQbcH4FjCR6BKoVqi2BpgSEPgVVEhAd2hFiGL4pJJYkhkUGBaQNZMgFVE?=
 =?us-ascii?q?xcLBwWBQ08DgWGDFIFagTuBU0eCZi8bIQuCHYE2FYEVgQaCTWpLOgINAjeCJ?=
 =?us-ascii?q?CRZglCHPkADC209NQYOGwacaYJmgQ7IZDQHhB2BXQYMn1AaM6pKAS6HZJBlI?=
 =?us-ascii?q?qh/gWc6gVwzGoNaTwMZD44hGYQiy3xFMjsCBwsBAQMJkDKBSwEB?=
IronPort-PHdr: A9a23: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
 0djMWWdL1q0p79hc317zgPRp8kXccM=
IronPort-Data: A9a23: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
 b8biodDD616GpDehEfxh+8UvA==
IronPort-HdrOrdr: A9a23:BCUYHq2ERMAcWGrJiFrdlgqjBLAkLtp133Aq2lEZdPWaSKOlfq
 eV7ZYmPHrP4gr5N0tApTntAsS9qBDnhP1ICOsqXYtKNTOO0FdAR7sN0WKN+VHdMhy70u5S3a
 p9N4d6DsOYNykesS8M2mKFL+o=
X-Talos-CUID: 9a23:UCvJcm+qVcX7uVeeE7CVv3QOK+kAXm/E9lbRZHXjB1tFd42bGVDFrQ==
X-Talos-MUID: 9a23:E2s+8wSyucHOivnLRXT0oh9JDvozpJ6pJ0cyl6sD4si2OD5JbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="100134070"
X-MGA-submission: =?us-ascii?q?MDFcn9ABFRrfap0JTvU6rI/rBm9AqM9FTH6bih?=
 =?us-ascii?q?X2eV7kRaoDrqsxGTQsy9DDBtACyVPB4JwOqV0Qtosjos+E+OElh3HPSy?=
 =?us-ascii?q?stLEOLBDR3XgvqbBQZNI8TEkqDYDN+HsdYuFTTzJ1nbajF6Vn9KGtR4R?=
 =?us-ascii?q?RopzeWv8CPeyBLW5erLr0duw=3D=3D?=
Received: from out-176.mta0.migadu.com ([91.218.175.176])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 13:59:41 +0100
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730033980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YhO//bO621t7BGGosVsytQ78SLPgR+dQxqYbb4Ol6B8=;
	b=S4aY9y4j2u25q+5w64LIMfW+SceTZ0oFz4KZJll4T/0CMfFDNLfMgUywZrDyUSrS9xE1yV
	kYBIahAphc/lRjwveWm2dDeNIFoOoDU+cCzhG4LdAzylYwNV3lMopu0mPw7PZR3BZs8Xd/
	27YuIyH3+PX3ep8Q0VsMbjCJUZrofX0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Sun, 27 Oct 2024 13:58:59 +0100
Message-ID: <20241027125858.1804-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] coccinelle: Add str_off_on() and str_no_yes() rules
Reply-To: Thorsten Blum <thorsten.blum@linux.dev>
X-Loop: cocci@inria.fr
X-Sequence: 1944
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/20241027125858.1804-2-thorsten.blum%40linux.dev>

In addition to str_on_off() and str_yes_no(), add rules to search for
str_off_on() and str_no_yes() replacements.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 scripts/coccinelle/api/string_choices.cocci | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 375045086912..93de05aeded2 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -282,6 +282,25 @@ e << str_on_off_r.E;
 
 coccilib.report.print_report(p[0], "opportunity for str_on_off(%s)" % e)
 
+@str_off_on depends on patch@
+expression E;
+@@
+-      ((E) ? "off" : "on")
++      str_off_on(E)
+
+@str_off_on_r depends on !patch@
+expression E;
+position P;
+@@
+*      E@P ? "off" : "on"
+
+@script:python depends on report@
+p << str_off_on_r.P;
+e << str_off_on_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_off_on(%s)" % e)
+
 @str_yes_no depends on patch@
 expression E;
 @@
@@ -300,3 +319,22 @@ e << str_yes_no_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_yes_no(%s)" % e)
+
+@str_no_yes depends on patch@
+expression E;
+@@
+-      ((E) ? "no" : "yes")
++      str_no_yes(E)
+
+@str_no_yes_r depends on !patch@
+expression E;
+position P;
+@@
+*      E@P ? "no" : "yes"
+
+@script:python depends on report@
+p << str_no_yes_r.P;
+e << str_no_yes_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_no_yes(%s)" % e)
-- 
2.47.0

