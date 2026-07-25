Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A09C531C9
	for <cocci@archiver.kernel.org>; Sat, 25 Jul 2026 11:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AXIwBDXgHdbOW1IakbnrDMGsgn739j8hqGA9qy4lB8M=;
  b=dInlXYuq5GY4Trt9UOYao870ydDfZ/T59BAL07yHzE6sFi9+QjCaaLwp
   5kLlyzSb0L/NZdabNkoe5hh53CPmPed9H1+D8bOb0nxkFHfLWZnaEMMWj
   gyUAOfzYI4amAMTv5KjIFAkaCQBw1puMYkOzUiirz2ynzAAbmIr2deLam
   0=;
X-CSE-ConnectionGUID: LS36FCVwRb2rQI5Oo+aIjg==
X-CSE-MsgGUID: OdkE9oSHTYqRG1OIjncI6w==
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
X-IronPort-AV: E=Sophos;i="6.25,184,1779141600"; 
   d="scan'208";a="287871818"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jul 2026 13:44:48 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id EF87780584; Sat, 25 Jul 2026 13:44:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2825580568
	for <cocci@sympa.inria.fr>; Sat, 25 Jul 2026 13:35:41 +0200 (CEST)
X-CSE-ConnectionGUID: QABgtBM4QJSzL8PxWNXB7w==
X-CSE-MsgGUID: f8MYKSYHSNmwC/RLtKxzkA==
IronPort-SDR: 6a649f8c_3y/LZzHkqDGLgOFBtHKrdbhLxuEP2BQ8/MGeTrxTyqsziqr
 uQ6CeEHA4mDkKXqBWfyN72VhU8ZkOJg3yVCtbDw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EZBgCKnmRqfLLWVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKSIoE/PQIPAQMBCwEBTwIEAQEBAgSEfgKNYQIeBwEEMAkOAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEQAQQBA?=
 =?us-ascii?q?YIBgSVhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QUCLF8CAQMSIAENARsdAQMMBhA7IAIRAQUBHAYBEiKCYIIjAQYQAQM3AgG2R?=
 =?us-ascii?q?YECQoxSBQIWgQGCDQaCatd+ChkoDXWBYwECAgcJAQoBAYE3AYR3Kl0DgjqFI?=
 =?us-ascii?q?3VEgz56J4EYgRCECHaCH4I5hjAEgy6CSI94AQcHHxIIARwGCAICSBUSAwQDB?=
 =?us-ascii?q?AQBAgsTCQMDAg4CCAMCCAYZAT8SBBMCCAMGBAsHBR8KAgwUCigiEisKAyoLE?=
 =?us-ascii?q?g8DDQYFFQEIBgICBAQCBAwCCQICBQMEAgQNAwQBAQgCAi0DAQMZCAkIAgsFE?=
 =?us-ascii?q?RgMCwcxAxAJAx8DFBsIRQgGFgEaBwUGCzcVBQwRAQIbAiEEHREIAwEYBAQCA?=
 =?us-ascii?q?QsDAQMBFQQICQQMAhAKEhUDDgMHDwINBy4LAwIOAgkIDBcCAgIGAgMDAwoBA?=
 =?us-ascii?q?gEBAQEBAQECBwMDAwIDGQcGAwQEAQQEAwMCAwUBAwMDBQICCgYJAQEBAQMCA?=
 =?us-ascii?q?ggDBwMKCQIFAxsDHAYBAgIDAgECAwYDBwgDDQMEAgMDAwQBAgIBAQECAwEDA?=
 =?us-ascii?q?wQDAQMDAgEDBwICAwMDCwECAwMDBQMFAQUDBQICAwUFAwUCAgoCAwMDAgEDA?=
 =?us-ascii?q?hwDCAMGAxIBEAMDBgEDBwMHAgQDCAQDBgIDCAMDAgkIAxYGAwMDAwUBAgICA?=
 =?us-ascii?q?wUDAwMICAQDAwQCAgMMAgYDAwMCAwMFAwMHAgQCAwYDAwMBAwMFAQIHAgMHA?=
 =?us-ascii?q?gELCwgDAgQCCQcJBwECAwsEAgQGBA0JBAIEAgIPBAQFAwMHAQECAQIIBQYDA?=
 =?us-ascii?q?gIRBQgKBQYCAgIdAyEBAw8GAQkFAgEFDgcFAgIKEgMGAgMEBQUBAwEKAQsBA?=
 =?us-ascii?q?QIDAwUFAwMFBwECBAIHAwMDBAMDAwMBAQICBAYEAwIDBwMDAwMDBAUFBQMCB?=
 =?us-ascii?q?QIEAwUDBwIDAwIBBQoBBAUECgEDAwMDBQUDAgIDAwQBAgQGAwQCAwECCAQGB?=
 =?us-ascii?q?QMDAwUCAwMCAgIDAwUBBQIDAwMEAwMDCAcFAwMFAgkDAwkDAwsCAgMhAgUDA?=
 =?us-ascii?q?wMDBgMHAwMEAwMDBwcCAwIDBwMCBQIHBQMDBQMGAQMCAQMDCAsSCRYDCwkIB?=
 =?us-ascii?q?wwBPAwHCiQEBAwqARQUBQQlGWcHBwKNdSOCPwGBDjCDSgEBAZFskmKgIUkeC?=
 =?us-ascii?q?QEGAmCBZ4EKFQovm1+FfBozl1OTGZkII5FwkkeEPgIKBwcRJBKBMjqBXDMaI?=
 =?us-ascii?q?4EBbYFJUAMZD45fg0TOSTU1PQIHAgcOAwuFXokqgSCBK0mBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Z86eodV312r5w==
IronPort-HdrOrdr: A9a23:I8zrNKv3IfyyOozyQEYgLlpp7skDUtV00zEX/kB9WHVpmwKj5q
 WTdZMgpGLJYVMqMk3I9urwX5VoLUmslqKdpLNhRYtKPzOWwldATrsSi7cKqgeIc0afygce79
 YaT0EXMrzN5DNB/KLHCWeDYrQd6ejC3qTtq+m29RhQpMJRB52ILT0VNu/iKDwOeOCOP/QEKK
 Y=
X-Talos-CUID: =?us-ascii?q?9a23=3AibQFNmswdf5DefE8rpdRLs546IscW1fS0F31f3a?=
 =?us-ascii?q?aMnRNGIWFdnmg0vx7xp8=3D?=
X-Talos-MUID: 9a23:sb6VcArE2X3sYmwyVrgezz8yEfZL2JWOM2YIjr5Bge2YFjxiOB7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,184,1779141600"; 
   d="scan'208";a="152929189"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHFv+QU9HgaVukg3/dAofEmPMAJbfUCmHNHuT?=
 =?us-ascii?q?eCgJmTNRTh4pzBRZoEO5DDyXzqUM0rLsC1Drq//znkSs8L9mg6t6sb8K?=
 =?us-ascii?q?d+LLG3wHSb30UHAKFOP/L91/lYzW0l+/jnKq1M5fZJjxsNUwZMt/ioTD?=
 =?us-ascii?q?6JTw7U7zNbmNGwyvSL61CQYg=3D=3D?=
Received: from mail-pl1-f178.google.com ([209.85.214.178])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2026 13:35:41 +0200
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso12332255ad.3
        for <cocci@inria.fr>; Sat, 25 Jul 2026 04:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784979339; x=1785584139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AXIwBDXgHdbOW1IakbnrDMGsgn739j8hqGA9qy4lB8M=;
        b=HpNj9EFYuWh84JH7rBLdlShLiQJ5ZY8TGxn9+zLo6f5+D9dR4t5WXr0sQMmyg9h3LF
         F5WG7a0HDVCYEQTM8T9jD07ef6cu/f7GmhdNoGK7LeF77UbNei0Zg9Eqnb9PAZuFWaoc
         4LHTs7Ji4QdXeDcgd8dLCmazkO+LiBDg9FqXRambv5U5Ss2goQfqbzekroArBgM0/faJ
         bJWcEOpXtyGGywwK4IR/a5gM435SAcndT9nKOcNH5by9abuS3DQ31MPh604OGYi+aOh4
         yfsunEZhK4wtHVYZ9gJWqejGbS/yc0tartNAwwrRd/SbjMZ11KUvVvpHo6WCsNNIAoXW
         ClAQ==
X-Gm-Message-State: AOJu0Yxx20J87qafE2gkI61cglbXmTiQmZFpXgGaqqljNuGgVZy9F5Bw
	mXylgXFUyOGVkpLoIGjPMTYrxCYdYiI9DydDK4ZXgCbzNi3A0iDNnfdo
X-Gm-Gg: AR+sD12wpdGbtXvK9pnnQEv9dOIODnsou5Hd+UYiVpe5tLZIeN8q//0+KcuQiXoBavw
	ZfapGHMTWZYSwiGA8MfBPHSU8F2glGswvgCRTuxNZTkjtxRKevstNpnHoWFWS8EG2zh8mHlCXIB
	fM7eNeMxfnKE4w9hxJqZflhUphadRnelJAX/hlPojHPmrYzrnbwHAHdirIXoh5+6xRQj+BZCtV0
	Cx8U632LXN92UXmOlTabW5ifIyFgBBqYdgyrZrlF2gIrqeB93iTIt5/yg8O5zO3uW3Af3hZFNoq
	d6JhI0Vh8sfvUiigNNCERHRMhfv0Bns4OxgPuiLo965RyHNxN3pg15MQao924c3QnTtRVxk5P5T
	p0PzlHpW63zV8pPnbrfjOU2wZ/tgvfIM9/Zld1aBhivvgSaCuXMSzXlPPgYNAHx5RTqzHvMVP
X-Received: by 2002:a17:90b:3c8e:b0:38e:69ae:7148 with SMTP id 98e67ed59e1d1-38f2960cb21mr2041956a91.24.1784979338624;
        Sat, 25 Jul 2026 04:35:38 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f08ae3079sm1539083a91.3.2026.07.25.04.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:35:37 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Sat, 25 Jul 2026 20:32:41 +0900
Message-ID: <20260725113303.691676-4-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725113303.691676-1-ekffu200098@gmail.com>
References: <20260725113303.691676-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 3/3] coccinelle: misc: minmax: improve performance
 when no candidate exists
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3658
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/wNmn-3IKB7bz2BR-Y3bU_Q>

The rules that report an opencoded min() or max() search every
function body, even when the file contains nothing to find.

To avoid this, collect the candidates first and run the search only
when one exists. A candidate is any conditional expression whose
condition is a comparison.

Every opencoded min() or max() is also a candidate, so the same
opportunities are reported as before and the output does not
change. A report-mode run over every .c file in the tree produces
identical output.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 scripts/coccinelle/misc/minmax.cocci | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
index ca4830ae3042..93c074b9439f 100644
--- a/scripts/coccinelle/misc/minmax.cocci
+++ b/scripts/coccinelle/misc/minmax.cocci
@@ -17,7 +17,21 @@ virtual org
 virtual context
 virtual patch
 
-@rmax depends on !patch@
+@max_candidate@
+expression E1, E2, E3, E4;
+binary operator cmp = {>, >=};
+@@
+
+	(E1 cmp E2 ? E3 : E4)
+
+@min_candidate@
+expression E1, E2, E3, E4;
+binary operator cmp = {<, <=};
+@@
+
+	(E1 cmp E2 ? E3 : E4)
+
+@rmax depends on !patch && max_candidate@
 identifier func;
 expression x, y;
 binary operator cmp = {>, >=};
@@ -51,7 +65,7 @@ func(...)
 }
 
 // Ignore errcode returns.
-@errcode@
+@errcode depends on min_candidate@
 position p;
 identifier func;
 expression x;
@@ -65,7 +79,7 @@ func(...)
 	...>
 }
 
-@rmin depends on !patch@
+@rmin depends on !patch && min_candidate@
 identifier func;
 expression x, y;
 binary operator cmp = {<, <=};
@@ -98,7 +112,7 @@ func(...)
 	...>
 }
 
-@pmax depends on patch@
+@pmax depends on patch && max_candidate@
 identifier func;
 expression x, y;
 binary operator cmp = {>=, >};
@@ -131,7 +145,7 @@ func(...)
 	...>
 }
 
-@pmin depends on patch@
+@pmin depends on patch && min_candidate@
 identifier func;
 expression x, y;
 binary operator cmp = {<=, <};
-- 
2.43.0

