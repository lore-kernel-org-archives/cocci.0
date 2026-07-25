Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0F7C53219
	for <cocci@archiver.kernel.org>; Sat, 25 Jul 2026 11:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2buC29pHpV7yBLh0Jy1hPDXrgiyuJc6NYxwfRn0zPQ0=;
  b=Q6x1EgKCQHJJIY1Pd9+H+GOyrEh/87KolyLpoXVKFaKhH38PaD7R4HPY
   3yWDaOIJ0xLhCPm1QfTltXmstrN3ntSkZUcguU984J/f46IjOmZ9dLTRG
   ij3Dkc3EOEZLmCQhYGHxxuFbN59gkQIouwoEI0YRLAuwoYdIM9WJELOEi
   8=;
X-CSE-ConnectionGUID: 4/9ve41KSh6XasSNfsi4aw==
X-CSE-MsgGUID: pdGrSbCgQamgK9GJt5BcOg==
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
   d="scan'208";a="287871760"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jul 2026 13:44:45 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2222F80584; Sat, 25 Jul 2026 13:44:46 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5A2FB80579
	for <cocci@sympa.inria.fr>; Sat, 25 Jul 2026 13:35:34 +0200 (CEST)
X-CSE-ConnectionGUID: csjvmovmRvabyUePhdSGgw==
X-CSE-MsgGUID: /nvAtKPYQmaiLt3c+9uoAA==
IronPort-SDR: 6a649f85_jtVp30YWMlOImju2UmPey1g28nEJ2Fq9cNDIHHHsncVxTCv
 mFCeHopJnk40T18e3nv5Tot9eV/i81lzXPmLwIw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EbBgCKnmRqfDXYVdFaglkCgj8WgVMzBFSVBwaBPokxg?=
 =?us-ascii?q?hkwApIigT89Ag8BAwELAQFPAgQBAQECBIR+Ao1hAh4HAQQwCQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOEimGTw1JARABB?=
 =?us-ascii?q?AEBggGBJWECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBQIsXwIBAxIgAQ0BGx0BAwwGEDsgAhEBBQEcBgESIoJggiMBBhABAzcCA?=
 =?us-ascii?q?bZFgQJCjFIFAhaBAYINBoJq134KGSgNdYFjAQICBwkBCgEBgTcBhHcqXQOCO?=
 =?us-ascii?q?oUjdUSDPnongRiBEIQIdoIfgjmGMASDLoJIj3gBBwcfEggBHAYIAgJIFRIDB?=
 =?us-ascii?q?AMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISKwoDK?=
 =?us-ascii?q?gsSDwMNBgUVAQgGAgIEBAIEDAIJAgIFAwQCBA0DBAEBCAICLQMBAxkICQgCC?=
 =?us-ascii?q?wURGAwLBzEDEAkDHwMUGwhFCAYWARoHBQYLNxUFDBEBAhsCIQQdEQgDARgEB?=
 =?us-ascii?q?AIBCwMBAwEVBAgJBAwCEAoSFQMOAwcPAg0HLgsDAg4CCQgMFwICAgYCAwMDC?=
 =?us-ascii?q?gECAQEBAQEBAQIHAwMDAgMZBwYDBAQBBAQDAwIDBQEDAwMFAgIKBgkBAQEBA?=
 =?us-ascii?q?wICCAMHAwoJAgUDGwMcBgECAgMCAQIDBgMHCAMNAwQCAwMDBAECAgEBAQIDA?=
 =?us-ascii?q?QMDBAMBAwMCAQMHAgIDAwMLAQIDAwMFAwUBBQMFAgIDBQUDBQICCgIDAwMCA?=
 =?us-ascii?q?QMCHAMIAwYDEgEQAwMGAQMHAwcCBAMIBAMGAgMIAwMCCQgDFgYDAwMDBQECA?=
 =?us-ascii?q?gIDBQMDAwgIBAMDBAICAwwCBgMDAwIDAwUDAwcCBAIDBgMDAwEDAwUBAgcCA?=
 =?us-ascii?q?wcCAQsLCAMCBAIJBwkHAQIDCwQCBAYEDQkEAgQCAg8EBAUDAwcBAQIBAggFB?=
 =?us-ascii?q?gMCAhEFCAoFBgICAh0DIQEDDwYBCQUCAQUOBwUCAgoSAwYCAwQFBQEDAQoBC?=
 =?us-ascii?q?wEBAgMDBQUDAwUHAQIEAgcDAwMEAwMDAwEBAgIEBgQDAgMHAwMDAwMEBQUFA?=
 =?us-ascii?q?wIFAgQDBQMHAgMDAgEFCgEEBQQKAQMDAwMFBQMCAgMDBAECBAYDBAIDAQIIB?=
 =?us-ascii?q?AYFAwMDBQIDAwICAgMDBQEFAgMDAwQDAwMIBwUDAwUCCQMDCQMDCwICAyECB?=
 =?us-ascii?q?QMDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFAwMFAwYBAwIBAwMICxIJFgMLC?=
 =?us-ascii?q?QgHDAE8DAcKJAQEDCoBFBQFBCUZZwcHAo11I4I/AYEOAX9vDU9AbwEBAZFsk?=
 =?us-ascii?q?mKfVE1JHgkBBgJggWeBChUKL5tfhXwaM5dTkxkumFojkXCSR4Q+AgoHBxEkE?=
 =?us-ascii?q?oEyOoFcMxojgQFtgUlQAxkPkiPOSTU1PQIHAgcOAwuFXokqgSCBK0mBTAEB?=
IronPort-PHdr: A9a23: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
 CSNnjJCfC4HUP94+ppX
IronPort-Data: A9a23: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
 U/KelY=
IronPort-HdrOrdr: A9a23:PXosd69V9CdYuHrLdyhuk+D8I+orL9Y04lQ7vn2ZhyYlF/Bw8P
 re4cjzsCWftN9/YgBGpTntAtjifZqYz+8M3WBzB8bZYOCFghrPEGgK1+KLqF3d8m/Fh5VgPM
 9bEpSWY+eAaWSS4/yKgjWQIpIPxJ2o/smT6ts2DE0AceipUcxdBn9Ce3+m+4RNKjV7OQ==
X-Talos-CUID: 9a23:HDetZW3avs4l9RnnpLm/h7xfEdsnbHja0nLqPUayGFtkcL2ZcnCf5/Yx
X-Talos-MUID: 9a23:LIhr7wm9F5B85L5xYGK+dnolMtlB/4eWOXkImJQip5KPdn1tPB602WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,184,1779141600"; 
   d="scan'208";a="152929179"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHQKrbxbxT1AMc6kD69FTUwSZzzlCBPK3+MTb?=
 =?us-ascii?q?pSnMi5Vlef+ACN0eyUXhrSYpUDcjBPqltcflENPjygWbOm+E8XdD5VIf?=
 =?us-ascii?q?7blDnwfJMr7ySH8zCCRdNoa6uWvJC/sqR+/214ImOaihiwO1blQvIN0C?=
 =?us-ascii?q?BdPCSUNK8l/P+ucJ8nzCYqXQ=3D=3D?=
Received: from mail-pj1-f53.google.com ([209.85.216.53])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2026 13:35:34 +0200
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-381216921aaso1222531a91.1
        for <cocci@inria.fr>; Sat, 25 Jul 2026 04:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784979332; x=1785584132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2buC29pHpV7yBLh0Jy1hPDXrgiyuJc6NYxwfRn0zPQ0=;
        b=OisAtYMIlHYjVUNcQ6VeUdxxJCGTPp72bk9sQy4xJ+4gJkFyluVzdA6R0QPS599Fpl
         Uzr6yBQfDFSGgPdah8Hce3SrlmzeGATDTmH1ESy4flK62EQvs1FiP8eTCdhc30MwmpXq
         P3gORyEC9tuIOEQC+tK/VQbFnpc5LuLvkSbFRw5ERI/gp1ZskoJCtXgwte2TWozHYfgH
         i2RMqk5njBZKEkFVILrlnjOX3wZPaCWH97dvtTGMP4QQtWgDI34m2F51KT97bxRUAmgg
         g4zPuzIWP3Mz38/RP9OOgyErKqo5ydFA8Hpm4P8kC2rJBR0noHoaukq1F6MYmi3+BNJW
         haaA==
X-Gm-Message-State: AOJu0YyHBw+KljaPozdvrPsXaBb2yXNd2mQ2zrZvRradFdieJRpVBgEF
	pO9a2xcpB8pOQf+gu6W7w5DP0mlf2+NiatnGRRUolOvGMLFy5W0RQ1OY
X-Gm-Gg: AR+sD11pnRCrjqImcrTWJ7bBPTN4YXTcxDpC+xTXse5Aw8mK5vas045p5rJ8YOo3ea9
	iLhq9kgVw2uZfZ1+XzeYHG7Rwi9n3hA2WSxz2ssagtZIaRMoDYPdPIJKnj/mBkLdPw42Fvc3Ubp
	CbQCvHkru5lNaAKbYBYXCSNgLcZKxOkhDzNGx2xCLTVGh4WlwZT8wQT7oCPEdFIzWYkJjdqkQuA
	1hHqeGqLX4BptpshMbZWPr1S7qYVv5VAsHUzz5BPxBWRDmcFFeqLP201C1EDfBiQqEdYMj7G7Xn
	8AI93vAsC6U6AEPnksFpTefvVshsATmcb+mwctMAxkll/zB3VuRxs+5loSF/wBkkt/5QNR/4GM0
	ddgKtmmjV6iRlOBXU3WubMXvjivdS4Iz9vMYv1csqmD8knYm71WgeHYueoaXGsNa3x67GDDQy
X-Received: by 2002:a17:90b:3bce:b0:38e:e0b:320d with SMTP id 98e67ed59e1d1-38f297812c8mr2044827a91.41.1784979331848;
        Sat, 25 Jul 2026 04:35:31 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f08ae3079sm1539083a91.3.2026.07.25.04.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:35:30 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Sat, 25 Jul 2026 20:32:39 +0900
Message-ID: <20260725113303.691676-2-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725113303.691676-1-ekffu200098@gmail.com>
References: <20260725113303.691676-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 1/3] coccinelle: mini_lock: improve performance when
 searching loops
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3656
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/QUhDVE0WywgYvMXvODyJ5w>

The 'looped' rule collects the returns inside a for loop to
prevent 'err' from reporting them. It searches every for loop in
the file, and on files with large loop bodies the search explodes.

For example, kernel/bpf/verifier.c runs for over 200 seconds,
almost entirely in 'looped' according to --profile. Since the
kernel .cocciconfig sets a 200 second timeout, coccicheck silently
skips the file.

To avoid this, collect the candidate returns first, so that
'looped' checks only those positions. 'err' then excludes what
'looped' found.

Every return that 'err' can report is also a candidate, so the
same returns are excluded as before and the output does not change.
A report-mode run over every .c file in the tree produces identical
output.

So verifier.c now finishes well within the timeout, in a few
seconds.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 scripts/coccinelle/locks/mini_lock.cocci | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/locks/mini_lock.cocci b/scripts/coccinelle/locks/mini_lock.cocci
index 71065d8a5d54..54e06cced63b 100644
--- a/scripts/coccinelle/locks/mini_lock.cocci
+++ b/scripts/coccinelle/locks/mini_lock.cocci
@@ -53,11 +53,31 @@ spin_lock_irq@p1
 spin_lock_irqsave@p1
 ) (E1@p,...);
 
-@looped@
+@err_candidate exists@
+expression E1;
+position prelocked.p;
+position up != prelocked.p1;
+position rc;
+identifier lock,unlock;
+@@
+
+lock(E1@p,...);
+... when != E1
+    when any
+if (...) {
+  ... when != E1
+  return@rc ...;
+}
+... when != E1
+    when any
+unlock@up(E1,...);
+
+@looped depends on err_candidate@
+position err_candidate.rc;
 position r;
 @@
 
-for(...;...;...) { <+... return@r ...; ...+> }
+for(...;...;...) { <+... return@rc@r ...; ...+> }
 
 @err exists@
 expression E1;
-- 
2.43.0

