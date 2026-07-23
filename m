Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34D3C531F9
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=awQoiDBDgXhHqvQuYMCoxfsFQDhNz1mjFe+tSKjVwWE=;
  b=o8Ab44Xs43eWFst0oHmdtStEc3lZ2+TSj0i8puXUmZ1cFnpJtnxi718Q
   c1buIWH09+d0zVe/ZgBXuOH+iLlBJbY+RS+aSTsnOMY61sygvxezX/VtT
   Ud0JizktABbpi4mAGb5rr6dpkv+y8d7f7fQqGFuwQGyOEtsTQS5xYIq6R
   o=;
X-CSE-ConnectionGUID: /G15M5qfSua+9bp3xVEcMg==
X-CSE-MsgGUID: lLKl4McLS7C4geyWNkCEKg==
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287732991"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:53:50 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 79FB2803D0; Fri, 24 Jul 2026 10:53:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 44BC8819FC
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:45:59 +0200 (CEST)
X-CSE-ConnectionGUID: VDvUxgxYRuG8n20VEYTCrg==
X-CSE-MsgGUID: hXQQMnGpQPO1Lvn1X3mZtw==
IronPort-SDR: 6a626166_0tJ9OarnXmB6MLRXii0OlDXEmNt1xN5IZvnTMcotYjMP3XB
 jfe/R8Z0CJQZ1lWJOkTPOR6ktRldxjVKT3S3fFA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HqCQBZYGJqgTPYVdFaglkCgj+BaTMEVJUHBoE+gRaIG?=
 =?us-ascii?q?4IZMAKMRIVygSs9Ag8BAwELAQFPAgQBAQECBDiERgKNYAIeBwEEMwYOAQIEA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDjuGTw1JA?=
 =?us-ascii?q?RABBAEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQUCLF8CAQMSIAENARsdAQMMBhA7IAIRAQUBHAYBEiKCYIIjAQYQA?=
 =?us-ascii?q?QM3AgG2V4ECQoxSBQIWgQGCDQaCatd+ChkoDXWBZAICBwkBCgEBgTcBhHcqX?=
 =?us-ascii?q?QOCOoUjdUSCVWl6J4EYgRCBFYJzdoIfgWcjL4YwBIIigQySKgEHBx8SCAEcB?=
 =?us-ascii?q?ggCAkgVEgMEAwQEAQILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMF?=
 =?us-ascii?q?AooIhIrCgMqCxIPAw0GBRUBCAYCAgQEAgQMAgkCAgUDBAIEDQMEAQEIAgItA?=
 =?us-ascii?q?wEDGQgJCAILBREYDAsHMQMQCQMfAxQbCEUIBhYBGgcFBgs3FQUMEQECGwIhB?=
 =?us-ascii?q?B0RCAMBGAQEAgELAwEDARUECAkEDAIQChIVAw4DBw8CDQcuCwMCDgIJCAwXA?=
 =?us-ascii?q?gICBgIDAwMKAQIBAQEBAQEBCAMDAwIDGQcGAwQEAQQEAwMCAwUBAwMDBQICC?=
 =?us-ascii?q?gYJAQEBAQMCAggDBwMKCQIFAxsDHAYBAgIDAgECAwYDBwgDDQMEAgMDAwQBA?=
 =?us-ascii?q?gIBAQECAwEDAwQDAQMDAgEDBwICAwMDCwECAwMDBQMFAQUDBQICAwUFAwUCA?=
 =?us-ascii?q?goCAwMDAgEDAhwDCAMGAxIBEAMDBgEDBwMHAgQDCAQDBgIDCAMDAgkIAxYGA?=
 =?us-ascii?q?wMDAwUBAgICAwUDAwMICAQDAwQCAgMMAgYDAwMCAwMFAwMHAgQCAwYDAwMBA?=
 =?us-ascii?q?wMFAQIHAgMHAgELCwgDAgQCCQcJBwECAwsEAgQGBA0JBAIEAgIPBAQFAwMHA?=
 =?us-ascii?q?QECAQIIBQYDAgIRBQgKBQYCAgIdAyEBAw8GAQkFAgEFDgcFAgIKEgMGAgMEB?=
 =?us-ascii?q?QUBAwEKAQsBAQIDAwUFAwMFBwECBAIHAwMDBAMDAwMBAQICBAYEAwIDBwMDA?=
 =?us-ascii?q?wMDBAMFBQMCBQIEAwUDBwIDAwIBBQoBBAUECgEDAwMDBQUDAgIDAwQBAgQGA?=
 =?us-ascii?q?wQCAwECCAQGBQMDAwUCAwMCAgIDAwUBBQIDAwMEAwMDCAcFAwMFAgkDAwkDA?=
 =?us-ascii?q?wsCAgMhAgUDAwMDBgMHAwMEAwMDBwcCAwIDBwMCBQIHBQMDBQMGAQMCAQMDC?=
 =?us-ascii?q?AsYAwsJCAcMATwMBwokBAQMKgEUFAUEJRlnBwcCjWgjgkABgQ2CKQEVAYE6A?=
 =?us-ascii?q?QEBkhqSNKAhSR4JAQYCYIFngQoVCi+bX4V8GjOXU5MZLodmF5BdI5FwkhA3h?=
 =?us-ascii?q?D4CCgcHESQSgUgkgVwzGiOBAW2BSVADGQ+SI8wVNTU9AQEHAgcOAwuBaIN2i?=
 =?us-ascii?q?SqBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 E7K
IronPort-HdrOrdr: A9a23:9uxNv6wdmF4WNu9YVE+6KrPwCL1zdoMgy1knxilNoNJuA6mlfq
 eV7YkmPHrP4gr5N0tQ/uxoVJPwIk80sKQFmbX5Xo3SJjUO2lHYSr2KhLGKq1aBJ8S9zJ8n6U
 4JSclD4bbLfDxHZKjBkWuFOudl7t3C3q7Av4jjJrRWIT2CqZsM0+4AMHfjLqS+fmd7OaY=
X-Talos-CUID: =?us-ascii?q?9a23=3AcSamjWpNEBToJgrEQ33OAVbmUf4JbEDNw2fhGVK?=
 =?us-ascii?q?XWWAzEIO4eGO74qwxxg=3D=3D?=
X-Talos-MUID: 9a23:mfYRfQrDDIHY5OgOI4YezzFSDf5N5Yu2MXgqyLEYvZC0bilCJyjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815226"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEE+vUp0hDlj13H5LfKRYfmMIfVp9Kny5vhow?=
 =?us-ascii?q?ILu604iT9NWSYvI1JCLNclwzUaCB16FHp1gm7oQsbCiQTqR+Dy7JWAwt?=
 =?us-ascii?q?gto59Yc7/xCF5NkpcXnyEA0cxepWroNP7oEQ4d6i5l4bK7sBIEvleW/l?=
 =?us-ascii?q?7C4vSYVJcDAZB/hTtXI8EK1Q=3D=3D?=
Received: from mail-pj1-f51.google.com ([209.85.216.51])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:45:59 +0200
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e7109321dso719993a91.3
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832357; x=1785437157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=awQoiDBDgXhHqvQuYMCoxfsFQDhNz1mjFe+tSKjVwWE=;
        b=mKB43fRrAbP0qBUdjDCJOfBDCEFPgjKRKs7but4Dv5w2yT7Z2W9gqk9fMNLYXnVhXQ
         mYtKkrEH9jkUDG8sFCIsjhfhnxIBb0uOsQIQvrDX/pR89+0Mx0vhsVqT2Qv4rYxzdEJ2
         WnLpAf1G20mT/dR6/thta9N0mhbqHE1JdY0VcbdaSmMtllnZ4hxBqxCZl0cYojxwmaYo
         BfcJIQ6focBqHjYZcew7UPWJauamUHyAHZsW5+mmELzEYeov1818fK9nEfIzjWRpHsnT
         FAZY7VXLppGaN9sW0zdBJG6Mfv3ju8/ipqwo4GsG4wz8Q6cdEuPmrKz1kBu2yFTZiKxN
         xYhw==
X-Gm-Message-State: AOJu0YwGZHxeQCBEM0qwqI33Yp5z7NQ18xuD95NZ5b92LX4c5EXWahPI
	LgMZyHssnSu8RIOmRy7oKWpEZC8/rT6mHl+lX//9G9qoc+RP80haXmSOrrXESrOMzzM=
X-Gm-Gg: AR+sD10/2FlWIL03KoOvRc649xT8GzVGCcbJVXa66PonoT/x7T3AqMuYwViUfVmd1wP
	LPXZmDKtA3gdalDDxIa9Dh02mnvZ0nZx+l6vMgGmMgFqJJViSkayxXURrHAr1TPVcq+QUVzg4sQ
	403+7pwrF4mUDsc6V7MorrPNWQKRDIKMcFxAAIaAAFLXTDajkT+Yqi8djbO2gvhqoh9cKB4pGdn
	0sO0pgi3CUyD7/pw7bmOOm2mnnAURtiJmtxSZGYyS/8SSMwYF/Dcu4kedQaaafMnMCPvzX/r6PN
	LGiTDgmhNcwDv92mYd0hUrNeTMrzL882qb/fQpVXcZe+T10XgpXXo/pIrIkdgrbHIHLKKxpza1N
	VcVtEvX7kd90Zvk90f5PjVqhKJ6ayJuh0kCTKkCzoCum7wk+DHTPh2TwBszquhrlcb5zvixL4
X-Received: by 2002:a17:90b:544f:b0:37f:9cdf:f037 with SMTP id 98e67ed59e1d1-38ec660bb8dmr4570424a91.26.1784832356687;
        Thu, 23 Jul 2026 11:45:56 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:45:56 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:03 +0900
Message-ID: <20260723184538.3888637-2-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 01/36] coccinelle: misc: add
 cond_return_no_effect.cocci
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3598
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/qbKRDZkq-yhuZnz_YIyBWA>

Add a new Coccinelle script which removes a conditional return that
has no effect:

	if (ret)
		return ret;
	return ret;

Both branches return the same value, so the check can be removed.
The condition can also be a negation or a comparison with a
constant. Such code is usually a leftover from removing a
statement between the two returns.

When a local variable is assigned right before the check, the
assignment and the two returns turn into a single return of the
assigned expression, and the declaration is dropped if nothing
else uses the variable. Otherwise only the check is removed.

The fold can delete comments between the check and the final
return, so the generated patch should be reviewed.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 .../misc/cond_return_no_effect.cocci          | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 scripts/coccinelle/misc/cond_return_no_effect.cocci

diff --git a/scripts/coccinelle/misc/cond_return_no_effect.cocci b/scripts/coccinelle/misc/cond_return_no_effect.cocci
new file mode 100644
index 000000000000..541aafdc32c6
--- /dev/null
+++ b/scripts/coccinelle/misc/cond_return_no_effect.cocci
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Remove a conditional return that has no effect:
+///
+///	if (ret)
+///		return ret;
+///	return ret;
+///
+/// Both branches return the same variable, so the check has no
+/// effect. It can also be a negation or a comparison with a
+/// constant.
+///
+/// When a local variable is assigned right before the check, the
+/// assignment and the two returns turn into a single return of the
+/// assigned expression, and the declaration is dropped if nothing
+/// else uses the variable. Otherwise only the check is removed.
+///
+// Such code is usually a leftover from removing a statement between
+// the two returns.
+//
+// Confidence: High
+// Copyright: (C) 2026 Sang-Heon Jeon
+// Comments: The fold can delete comments between the check and the
+//           final return, so review the generated patch.
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+@collect depends on patch@
+identifier ret;
+expression E;
+binary operator cmp = {<, <=, >, >=, ==, !=};
+constant C;
+@@
+	ret = E;
+	if (\(ret \| !ret \| ret cmp C\))
+		return ret;
+	return ret;
+
+@depends on patch@
+local idexpression ret;
+expression E;
+binary operator cmp = {<, <=, >, >=, ==, !=};
+constant C;
+@@
+-	ret = E;
+-	if (\(ret \| !ret \| ret cmp C\))
+-		return ret;
+-	return ret;
++	return E;
+
+@depends on patch@
+idexpression ret;
+binary operator cmp = {<, <=, >, >=, ==, !=};
+constant C;
+@@
+-	if (\(ret \| !ret \| ret cmp C\))
+-		return ret;
+	return ret;
+
+@depends on patch@
+type T;
+identifier collect.ret;
+@@
+-	T ret;
+	... when != ret
+	    when strict
+
+@depends on patch@
+type T;
+identifier collect.ret;
+constant C;
+@@
+-	T ret = C;
+	... when != ret
+	    when strict
+
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+@depends on context@
+idexpression ret;
+binary operator cmp = {<, <=, >, >=, ==, !=};
+constant C;
+@@
+*	if (\(ret \| !ret \| ret cmp C\))
+*		return ret;
+	return ret;
+
+//----------------------------------------------------------
+//  For org and report mode
+//----------------------------------------------------------
+
+@r depends on org || report@
+idexpression ret;
+binary operator cmp = {<, <=, >, >=, ==, !=};
+constant C;
+position p;
+@@
+	if@p (\(ret \| !ret \| ret cmp C\))
+		return ret;
+	return ret;
+
+@script:python depends on org@
+p << r.p;
+@@
+cocci.print_main("WARNING: conditional return with no effect (both branches return the same value)", p)
+
+@script:python depends on report@
+p << r.p;
+@@
+coccilib.report.print_report(p[0], "WARNING: conditional return with no effect (both branches return the same value)")
-- 
2.43.0

