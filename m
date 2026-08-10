Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D6BC5DF9D
	for <cocci@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:to:cc:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=GL/ztLMOvUH4Q12i+RAlPby9ewt/dD+XTkUVXgI/UnU=;
  b=sWT5JU7MqACcnKdeVNhzDn73B7BYn7a3HAVjq+ys+rXNeXEO+5qpFskx
   3s1zhx5d65Q9osGrOdGXyfQltfacGe+DeHGgJaRSVTeJQUEWuY2Y5fMZX
   17M41O7g9uk9P8b8JjXHv9oUjnwTcmSkFD2ipzPorvV5HApont21TYWD3
   I=;
X-CSE-ConnectionGUID: W0cloKXHQ5yM9MoUjV4INQ==
X-CSE-MsgGUID: vVqYk2nySv2exWpjhOkiQg==
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
X-IronPort-AV: E=Sophos;i="6.25,240,1779141600"; 
   d="scan'208";a="291206740"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2026 09:35:01 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 185A881684; Mon, 24 Aug 2026 09:35:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 46C8B80F45
	for <cocci@sympa.inria.fr>; Mon, 10 Aug 2026 08:33:52 +0200 (CEST)
X-CSE-ConnectionGUID: o1Sgb3JgT7OvDN8PWXHe8w==
X-CSE-MsgGUID: uFG+NjFSRXe8fgc6sa7K2g==
IronPort-SDR: 6a7970cf_sfUm2AXKmZuMmR+EEu6eNDDN4q07XkM0dVmX7Od8/jWAMZg
 I96mOQlRZJPJd0jOuxjc6AkaB6VfB4KtiwIjKQQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EeADOdb3lqdxVEz2haHAEBAQEBAQcBARIBAQQEAQFMg?=
 =?us-ascii?q?TAHAQELAYJAgQoGWTMHCEkIhFCDT4RMiVieHoF8Ag8BAwENRA0EAQEBAgEDh?=
 =?us-ascii?q?H5RFY0DAh8GAQQwCQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDA?=
 =?us-ascii?q?QEBAQIQAUNJhk8NgmIBM4IWLA2BACcEGQEBLgkBNAImAkgWARKDAgGCIgdLA?=
 =?us-ascii?q?xEFAcVhfzOBAYIMAQEGgQiBYdswAgMGFAGBCi4BiFwBgXCECESCVWmBIRUGQ?=
 =?us-ascii?q?IFNgRWDaYRcg0KCaoESgiCBeIsIhWYJP4ECHANZLAFVEw0KCwcFYVIzAyAKC?=
 =?us-ascii?q?xISGBUCFC8PGjIdcBwXEiwXNVgbBgWBHX0UBBOEaCMZNnyBCV6BKypkARIXg?=
 =?us-ascii?q?QmCNQKCdoEtFQsYDUgRLDcGDhkEPQFuB413III/BgF7CQosUIEtAWCSfIN+j?=
 =?us-ascii?q?CmBNmuBNZ9ahCiMIZVVMpdnkwUumFoji22Beooei0pohGmBaDqBXDMaCDCDI?=
 =?us-ascii?q?lADGQ+OIYRDgxHIZyQ1AjsCBwIHDgMLhkaLVmxgAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 4QqbTgsfXxXgnId3Sqtl7C51f3ZUP7SI+0UUBqy
IronPort-HdrOrdr: A9a23:QLne/6+RwoWhejzHpL9uk+DuI+orL9Y04lQ7vn2ZKCYlEfBw+P
 rDoB1273fJYVUqOE3I8OroBEDqexnhHOlOjLX5U43IYCDW/EeJaKVHqbbD71TbdRHWx6pw9e
 NbX49SJOa1JWFC5PyU3CCIV/Y6xt6f9ru0wc/D0nYFd2BXV50=
X-Talos-CUID: 9a23:GLqdQWDsEPnfqFn6Ey4+z0EeQeIqTiL60lv2c3eHOUZkGKLAHA==
X-Talos-MUID: 9a23:uYdeUwQjmLP/WrwSRXTxqh4hEsVG2J6eBRADnp5YoMDbFnZ/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,215,1779141600"; 
   d="scan'208";a="289637149"
X-IronPort-Outbreak-Status: No, level 1, Phish - Phish
X-MGA-submission: =?us-ascii?q?MDHeTVei/su4fMWlp3lBy/GOZVXfExcGetbHXu?=
 =?us-ascii?q?MuPzn0UZBCbo0KnhuAYP1JNedZBnU90bxDpRZW+FpmsUAfe+rWwIuB4f?=
 =?us-ascii?q?2RQRtpUwIeW1C5ECAG+cqSx5XxVwiHHHOsCPntGd8nNtM2T19kNfslaE?=
 =?us-ascii?q?a+1g8L1LPjgOMEvEJ7uW0NpA=3D=3D?=
Received: from out-93wp-a21.jellyfish.systems ([104.207.68.21])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 08:33:51 +0200
Received: from [192.168.1.103] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hJQ2226YNz6tl8;
	Mon, 10 Aug 2026 06:33:46 +0000 (UTC)
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sun, 09 Aug 2026 23:33:32 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-cocci-clk-register-v3-1-60d036e13370@gurudas.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw7CIBQFf6VhLabcvsCV/2FcULi0qGkNtETT9
 N+FutHEuJzknJmFeHQWPTlkC3EYrLfjEKHYZUT1cuiQWh2ZQA51znOgalTKUnW7Uoed9RM6Kiq
 mRQkVk6Yk8Xh3aOxjk57Ob/Zze0E1JVNa9PE4uudWDSzt/gYCo4xqU3NpVMsQzbGb3ayl32sMJ
 CUCfEqKnxKIEgBsuDBNZQT/lqzr+gI2bsfVDQEAAA==
X-Change-ID: 20260802-cocci-clk-register-951d94251af4
To: Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, cocci@inria.fr, 
 Brian Masney <bmasney@redhat.com>, linux-clk@vger.kernel.org, 
 Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3] coccinelle: Detect clk_register() anti-pattern
Reply-To: Guru Das Srinagesh <linux@gurudas.dev>
X-Loop: cocci@inria.fr
X-Sequence: 3695
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/92MpD-g8seB1oIk0SACUVw>

Enforce commit 12a0fd23e870 ("clk: Print an error when clk registration
fails"): clk_register(), clk_hw_register(), and their devm_/of_ variants
log their own error on failure, so driver-side error prints after these
calls are redundant.

Two independent match families, one per return-value convention:
pointer return checked via IS_ERR() (clk_register()/devm_clk_register()),
and int return checked via a nonzero value (clk_hw_register()/
devm_clk_hw_register()/of_clk_hw_register()). Both families match
regardless of whether the redundant message's "if" also has a trailing
"else", via an "else S" clause with S otherwise unused.

In "patch" mode, removing the redundant message also collapses the
enclosing braces when only one statement remains, and deletes the whole
"if" when the message was already the only (braceless) statement.

Assisted-by: Claude:claude-sonnet-5 coccinelle
Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
Add a Coccinelle semantic patch enforcing commit 12a0fd23e870 ("clk:
Print an error when clk registration fails"): flags, and in "patch"
mode removes, driver-side error prints that are now redundant after
clk_register()/clk_hw_register() and their devm_/of_ variants.

Two independent match families, one per return-value convention.

Pointer return, IS_ERR()-checked (clk_register()/devm_clk_register()),
e.g. drivers/clk/clk-xgene.c:152-157:

    clk = clk_register(dev, &apmclk->hw);
    if (IS_ERR(clk)) {
-       pr_err("%s: could not register clk %s\n", __func__, name);
        kfree(apmclk);
        return NULL;
    }

Int return, nonzero-checked (clk_hw_register()/devm_clk_hw_register()/
of_clk_hw_register()), e.g. drivers/clk/meson/meson-clkc-utils.c:49-54:

    ret = devm_clk_hw_register(dev, hw);
-   if (ret) {
-           dev_err(dev, "registering %s clock failed\n",
-                   hw->init->name);
+   if (ret)
        return ret;
-   }

Already-braceless single-statement case: the whole "if" is deleted
instead of just the message, e.g. drivers/clk/ux500/clk-sysctrl.c:171-175:

    clk_reg = devm_clk_register(clk->dev, &clk->hw);
-   if (IS_ERR(clk_reg))
-           dev_err(dev, "clk_sysctrl: clk_register failed\n");

    return clk_reg;

Matches regardless of whether the "if" also has a trailing "else", via
an "else S" clause with S otherwise unused, e.g.
drivers/media/platform/microchip/microchip-isc-clk.c:269-275:

    isc_clk->clk = clk_register(isc->dev, &isc_clk->hw);
-   if (IS_ERR(isc_clk->clk)) {
-           dev_err(isc->dev, "%s: clock register fail\n", clk_name);
+   if (IS_ERR(isc_clk->clk))
        return PTR_ERR(isc_clk->clk);
-   } else if (id == ISC_MCK) {
+   else if (id == ISC_MCK) {
        of_clk_add_provider(np, of_clk_src_simple_get, isc_clk->clk);
    }

Testing:
- Baseline: coccinelle 1.3.1, the Torvalds tree at v7.2-rc5.
- "make coccicheck COCCI=<path> MODE=report M=drivers/clk" produced 73
  hits, unchanged after this revision, and verified to have zero false
  positives.
- All four modes (report/context/patch/org) verified via "make
  coccicheck COCCI=<path> MODE=<mode> [M=<path>]" against the
  drivers/clk baseline and the new else-branch case above.
- "make coccicheck COCCI=<path> MODE=report" (whole tree, no M=) finds
  94 hits; the 21 outside drivers/clk are not part of this series.
---
Changes in v3 (Julia):
- Match an "if" regardless of a trailing "else" (else S, S unused),
  across context/patch/report/org rules for both families. Found via
  this to be a real, previously-invisible case in
  drivers/media/platform/microchip/microchip-isc-clk.c.
- Fix the org-mode script rules: cocci.print_main() takes (message,
  position), not just a position; the previous calls omitted the
  message entirely.
- Drop the MAINTAINERS addition from v2 per Julia's comment that a
  specific maintainer isn't needed for this file.
- Link to v2: https://patch.msgid.link/20260803-cocci-clk-register-v2-1-22e789f75f98@gurudas.dev

Changes in v2 (Julia):
- Use a literal function-name disjunction instead of a regex identifier,
  enabling spatch's file pre-filter optimization.
- In "patch" mode, drop braces when only one statement remains, and
  delete the whole "if" when the message was the only (braceless)
  statement.
- Drop two never-observed condition variants (IS_ERR(clk) == 1, ret !=
  0); keep the one with real precedent (ret < 0).
- Link to v1: https://patch.msgid.link/20260802-cocci-clk-register-v1-1-df68afcb1eef@gurudas.dev
---
 scripts/coccinelle/api/clk_register.cocci | 165 ++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/scripts/coccinelle/api/clk_register.cocci b/scripts/coccinelle/api/clk_register.cocci
new file mode 100644
index 000000000000..150279827bf4
--- /dev/null
+++ b/scripts/coccinelle/api/clk_register.cocci
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Remove error messages after clk registration failures, because
+/// clk_register(), clk_hw_register(), and their variants already log
+/// an error when they fail. See commit 12a0fd23e870 ("clk: Print an
+/// error when clk registration fails").
+//
+// Confidence: Medium
+// Options: --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@depends on context@
+expression clk;
+identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
+statement S;
+@@
+
+clk = \(clk_register\|devm_clk_register\)(...);
+if ( IS_ERR(clk) )
+{
+...
+*voidfn(...);
+...
+}
+else S
+
+@depends on patch@
+expression clk;
+identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
+@@
+
+clk = \(clk_register\|devm_clk_register\)(...);
+-if ( IS_ERR(clk) )
+-voidfn(...);
+
+@depends on patch@
+expression clk;
+identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
+statement S, S_else;
+@@
+
+clk = \(clk_register\|devm_clk_register\)(...);
+if ( IS_ERR(clk) )
+(
+-{
+-voidfn(...);
+S
+-}
+|
+{
+...
+-voidfn(...);
+...
+}
+)
+else S_else
+
+@r1 depends on org || report@
+position p1;
+expression clk;
+identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
+statement S;
+@@
+
+clk = \(clk_register\|devm_clk_register\)(...);
+if ( IS_ERR(clk) )
+{
+...
+voidfn@p1(...);
+...
+}
+else S
+
+@depends on context@
+expression ret;
+identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
+statement S;
+@@
+
+ret = \(clk_hw_register\|devm_clk_hw_register\|of_clk_hw_register\)(...);
+if ( \( ret \| ret < 0 \) )
+{
+...
+*voidfn(...);
+...
+}
+else S
+
+@depends on patch@
+expression ret;
+identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
+@@
+
+ret = \(clk_hw_register\|devm_clk_hw_register\|of_clk_hw_register\)(...);
+-if ( \( ret \| ret < 0 \) )
+-voidfn(...);
+
+@depends on patch@
+expression ret;
+identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
+statement S, S_else;
+@@
+
+ret = \(clk_hw_register\|devm_clk_hw_register\|of_clk_hw_register\)(...);
+if ( \( ret \| ret < 0 \) )
+(
+-{
+-voidfn(...);
+S
+-}
+|
+{
+...
+-voidfn(...);
+...
+}
+)
+else S_else
+
+@r2 depends on org || report@
+position p2;
+expression ret;
+identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
+statement S;
+@@
+
+ret = \(clk_hw_register\|devm_clk_hw_register\|of_clk_hw_register\)(...);
+if ( \( ret \| ret < 0 \) )
+{
+...
+voidfn@p2(...);
+...
+}
+else S
+
+@script:python depends on org@
+p1 << r1.p1;
+@@
+
+msg = "line %s is redundant because clk_register() already prints an error on failure" % (p1[0].line)
+cocci.print_main(msg, p1)
+
+@script:python depends on report@
+p1 << r1.p1;
+@@
+
+msg = "line %s is redundant because clk_register() already prints an error on failure" % (p1[0].line)
+coccilib.report.print_report(p1[0], msg)
+
+@script:python depends on org@
+p2 << r2.p2;
+@@
+
+msg = "line %s is redundant because clk_hw_register() already prints an error on failure" % (p2[0].line)
+cocci.print_main(msg, p2)
+
+@script:python depends on report@
+p2 << r2.p2;
+@@
+
+msg = "line %s is redundant because clk_hw_register() already prints an error on failure" % (p2[0].line)
+coccilib.report.print_report(p2[0], msg)

---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260802-cocci-clk-register-951d94251af4

Best regards,
--  
Guru Das Srinagesh <linux@gurudas.dev>

