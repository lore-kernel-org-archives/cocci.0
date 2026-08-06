Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD247C5DF81
	for <cocci@archiver.kernel.org>; Thu, 20 Aug 2026 08:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=0o4NBheCwSE10XnDe2BerT3Ry5/7biA01jIUqSNl/wI=;
  b=ZDMbaVvHEldQ+0f5v+TC0B9o8zXp+jjJbeTrIW3XpmTYZCggBpaBcVpt
   LLVbWf6Z68budkO4h9xHoHP1tzwXK3ISXQRtXY+wo/nhTMzHMzpWydkz/
   DUatrpZM5dZV5U1g3wXc+KSS45w90UCKIJkJB5sovFjntwqeWeJZgmyKL
   M=;
X-CSE-ConnectionGUID: nEe8G5ShTDmIlprGkgUnOQ==
X-CSE-MsgGUID: 27wSXv/UThKl2pw2TcydqQ==
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
X-IronPort-AV: E=Sophos;i="6.25,232,1779141600"; 
   d="scan'208";a="290784069"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Aug 2026 10:36:48 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1FA2C81C27; Thu, 20 Aug 2026 10:36:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2C919805CE
	for <cocci@sympa.inria.fr>; Thu,  6 Aug 2026 19:50:11 +0200 (CEST)
X-CSE-ConnectionGUID: 7nwJTTjGTZuHyZzK7iIZTg==
X-CSE-MsgGUID: DcKF7FNeS5iyL9dUQjwyAQ==
IronPort-SDR: 6a74c952_8xHEbT6qScQs40A8+wIMjQbqXiB4O2nMkp8cPJexIBpMkWp
 plY43GrIko3WCCce1mh8v0yF9fj0FZE99sF1xAQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HkFACzx3Rqga/WVdFaHgEBCxIMggULAoI/gQpfMwRUB?=
 =?us-ascii?q?JUDBoE+gRaIG4IZMoxEhV4UgSs9Ag8BAwELAQFECwIEAQEBAgQ3AYRGjWkCH?=
 =?us-ascii?q?gcBBDIHDgECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABA?=
 =?us-ascii?q?SIZBw47hk8NSQEBAQMHBAUBAYIBgSVhAgUDOwEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQUCDR9hFiABDQEbHQEDEhBbAhEBBQEiARIig?=
 =?us-ascii?q?mABgiIBBhABAzcCARGycIECQoxSBQIWgQGCDQaCatd+ChkoDXWBZAICAQYJA?=
 =?us-ascii?q?QoBAYE3AYR3Kl0DgjuFI3ZEglVpgSGBGIEQgRWCc3aCH4FnIy+GMASCDRWBD?=
 =?us-ascii?q?IhFg1eGWAEHBx8SCAEcBggCAkgVEgMEAwQEAQILEwkDAwIOAggDAggGGQE/E?=
 =?us-ascii?q?gQTAggDBgQLBwUfCgIMFAooIhIrCgMqCxIPAw0GBRUBCAYCAgQEAgQMAgkCA?=
 =?us-ascii?q?gUDBAIEDQMEAQEIAgItAwEDGQgJCAILBREYDAsHMQMQCQMfAxQcCEUIBhYBG?=
 =?us-ascii?q?gcFBgs3FQUMEQECGwIgBB0RCAMBGwQCAQkDAQMBFQQCFA4QAhIuCwMCDAIJC?=
 =?us-ascii?q?AwXAgICBgIDAwMKAQEBCAMDAwIDGQcGAwQEAQQEAwMCAwUBAwMDBQICCgYJA?=
 =?us-ascii?q?QEBAQMCAggDBwMKCQIFAxsDGwUBAgIDAgECBgMHCAMNAwQCAwMDBAECAgEBA?=
 =?us-ascii?q?QIDAQMDBAMBAwMCAQMHAgIDAwMLAQIDAwUDAwUFAgIFBQMFAgIKAgMDAwIBA?=
 =?us-ascii?q?wIcCAMGAxIBEAMDBgEDBwMHAgQDCQIIAwMICAMXAwMFAQICBAMDCAgEAwMEA?=
 =?us-ascii?q?gIDDAUDAgMDBQMDBwIEAgQDAwEFAQIHAgMHAgEYAwIECAcJBQILBAIIBA0JB?=
 =?us-ascii?q?AIEAgIPBAYDAwcBAQIBBwUGAwICEQUICgUGAgICHAMdAQMPBgEJBQIBBQ4HB?=
 =?us-ascii?q?QICGAMGAgMGBQEDAQoLAQECAwoBAgQCBQMDAQEDAgMCBgMDAgUFBQMJBwUMB?=
 =?us-ascii?q?QkBAwMGBQMCAwQGAwQCAwECCAQGBQMDAwUCAwMCAgIDAwUBBAIDAwMEAwMDC?=
 =?us-ascii?q?AcFAwMFAggDAwkDAwsCAiACBQMDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFA?=
 =?us-ascii?q?wMFAwYBAwIBAwMICxUlAwEFAwMCAQMCBQMDGAICBAUDAwMDAwMJBAICAQcGB?=
 =?us-ascii?q?AICAgEFBQUEAwUGAgIEAwgBAQUDAwUIDQECBxEDDgYDBwMDBAQEAgUMAgMEA?=
 =?us-ascii?q?QcLCQgHDAE8DAcKJAQEDCoBFBQFBCUZZwcHAo1+IIJGATwcNSyBfQEVAR4Jg?=
 =?us-ascii?q?RMBAQGJQIhakjSgIUkeCQEGAmCBZ4EKFQovjCGPPoV8GjOXU5MZLodmF5BdI?=
 =?us-ascii?q?4ttgXqECZF4GDeEPgIKBwcRJBKBOQUugVwzGiOBAW2BSRM9AxkPjiGEAoUTx?=
 =?us-ascii?q?xU1NQIBOgIHAgcOAwuFXoIkhwaBIIErSYFMAQE?=
IronPort-PHdr: A9a23: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
 IEodE/GDygS
IronPort-Data: A9a23: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
 b4bh4dA3oxO5kEuhA==
IronPort-HdrOrdr: A9a23:ua2KIqiv+JxbWGa0wTDU5790I3BQXgkji2hC6mlwRA09TyVXrb
 HLoB19726PtN91YhsdcL+7Sc+9qB/nhPxICOoqTMyftWvdyRKVxehZhOOIsl7d8kXFltK1vp
 0QFJSWZueAaGRSvILU5hKnG80szNTC3KejnvfG0nthJDsHV4hQqyl8TiiUe3cZeOCEP/UE/V
 ini/av3wDQAUj/p/7bOkU4
X-Talos-CUID: 9a23:J9WGMWARFDyKd2L6E3Zh62woJsIKTk/A7GbiMWznCEdbdLLAHA==
X-Talos-MUID: 9a23:5z/1TQm6qI4ONXlW6VgvdnpOP+RGvIqIBXtQkIQi6sW5DC5vKh6k2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,208,1779141600"; 
   d="scan'208";a="153773231"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGDB4BRMM0+tkJ7w8DSx8VWzlCTcSuqq1wGsi?=
 =?us-ascii?q?3d/nFGQ4ufZSA9qdRhq504T2AMrwrYNbC4r/8xbcSweRKrJ+qcHaJnUD?=
 =?us-ascii?q?7KwOUxBS9lpsuMkWhxrVibRjQq49K55myu9MXeOhjrJmNfZoJ9Ffwefe?=
 =?us-ascii?q?XLn+9K9VZeNCGudrTOMRLlkQ=3D=3D?=
Received: from mail-pl1-f175.google.com ([209.85.214.175])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 19:50:11 +0200
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caed617615so34705195ad.3
        for <cocci@inria.fr>; Thu, 06 Aug 2026 10:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786038608; x=1786643408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0o4NBheCwSE10XnDe2BerT3Ry5/7biA01jIUqSNl/wI=;
        b=gosjzCt5URK1Qu8Cp8yj2UHeu+wUz4L5DBBUkiRoUF1+eT8KXHAq9VNfeslyGlWXxR
         auPFX/Wa4fgj62izZWN2Cc07hNcaOeL1nY38VhnrGeVhW7dU3JEh1wgWC93kzGPTGG7O
         DOHnDQt0cE+tSRsHV51jfgmiRR5v03a5d1iHBlKadDRd9i4cQU6/nFdC3kn706OLs+3s
         5NgHLX1GWIiJrtem8cU5TW3ae3YJNXlCOSXQG8zMiEPtRQZ8eu5csSY/eP+NJD9SPpGW
         EZmJid7n/m6C+XepyNwt0X68yMGfJecKtnGS5gXFhfB1I2Fl7OJX4qWmQLtC2jMgQtI1
         kNDA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9nr51jptL/ZdIigNI+Nz7SIQwK0kDwSUTu5gi6rT5StZUEyHYzlaD8uJuSrp6s3oLVhIKgw==@inria.fr
X-Gm-Message-State: AOJu0YwaSroiL0ccViaGx5QOMQUdOJfR8ij2LgK4NUMKVotmocBXL+k8
	cg50rnjZmdkPy1KUz+Vn9dcc3lTIRiGYe1Z8DM6VtE/iEcVhMuBr1ErI89fx+ml5
X-Gm-Gg: AR+sD11v0zp5KrPzq/dsAmw0Ugo2LPmQasTzfXe6NEdu1XkWaYta9+rtlzZdHGU/+GS
	9E1Ez/gDzXNrx24NiGJROru46h9UXV1ahNSUKJkKbXrx4wFtFnkEqQeKUEP3Wn++/Nxa4mIIqmA
	ErFQbgjfraHyxkTp4V7RfXBz4+4+f/vj5Op1JbnOVnzrGOMHa7krXxV7JFCEBkqhNqKwICtcr2A
	MfpHqnl98FcVgdyxA7KyHAfbn5lYx50g6TDG5SnHZ0BM/oXZ0f7a/+2z3P8PW+EJGCqtW/dy71i
	Ws2ZF28qB+kaNO5BHJ8LiDqxgfBDWvgw6aAMjuUPz94MMrdEKNBYTnQ54qN0+plTXWHvcdJlO2r
	LIJgFCsWJHwitD2GykjUBjdCpLg+xMJ5u6sq009His+0NpuUmNnS/lLdRchC0QQQCYXBlAg0DEi
	18Y7byJa3hI/XfBxPWgYVTkpMiK/8j5vEuhBQIl/5hxQOvQ/sG6PLse80=
X-Received: by 2002:a17:903:2ac5:b0:2c9:b8b7:5d27 with SMTP id d9443c01a7336-2d0ca712d8fmr205630375ad.1.1786038608277;
        Thu, 06 Aug 2026 10:50:08 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d120c611casm24675ad.83.2026.08.06.10.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:50:07 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Fri,  7 Aug 2026 02:49:51 +0900
Message-ID: <20260806174953.401869-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2] coccinelle: misc: add
 cond_return_no_effect.cocci
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3685
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/0Hi_S8AQRTjLkBU7p_I2yg>

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
Changes from v1 [1]
- fix unexpected removal of global or static declarations, as Julia
  suggested
- send the patch separately from the treewide series, as Mark
  suggested

[1] https://lore.kernel.org/all/20260723184538.3888637-1-ekffu200098@gmail.com/
---
In the v1 thread, Jani shared the history of removing a similar
script that matched an explicit return 0 at the end [1].

Current status of the cleanup patches, two weeks after v1:
- 17/35 merged (2 sites changed to explicit return 0 as requested)
- 3/35 reviewed
- 15/35 no response yet

[1] https://lore.kernel.org/all/0ee1ef4aa7daa908bf28397ccc639c89b6aabd9c@intel.com/
---
 .../misc/cond_return_no_effect.cocci          | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 scripts/coccinelle/misc/cond_return_no_effect.cocci

diff --git a/scripts/coccinelle/misc/cond_return_no_effect.cocci b/scripts/coccinelle/misc/cond_return_no_effect.cocci
new file mode 100644
index 000000000000..334a9bcd2d6e
--- /dev/null
+++ b/scripts/coccinelle/misc/cond_return_no_effect.cocci
@@ -0,0 +1,143 @@
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
+@depends on patch disable optional_storage@
+type T;
+identifier collect.ret;
+declaration D;
+statement S;
+@@
+(
+-	T ret;
+(
+	D
+|
+	S
+)
+&
+	T ret;
+	... when != ret
+	    when strict
+)
+
+@depends on patch disable optional_storage@
+type T;
+identifier collect.ret;
+constant C;
+declaration D;
+statement S;
+@@
+(
+-	T ret = C;
+(
+	D
+|
+	S
+)
+&
+	T ret = C;
+	... when != ret
+	    when strict
+)
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

