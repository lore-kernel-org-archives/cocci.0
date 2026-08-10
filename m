Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94068C5AD4E
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2026 06:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Jy1mXnOgzwP16J9PCcnnI5CZdWdJZHs+cXmX0d/fN1c=;
  b=fhESVkryyV6RcNCxxqptWXJRiOWksw5FVMKCuiWXOZKJT34+B1zSlZ8I
   UIs+gVQaJ68iulP6HgUU5JGRQ2ItDtYueNKdKqs3UOrPcGhH7KijYcmp3
   vHV+NZQsrEnM82UCWPkNtAk3Lxzy/QHMSCxfuw5q5CaWM4hJLFFIvF8cO
   M=;
X-CSE-ConnectionGUID: M7taI69PQUO6iG60HnjiEQ==
X-CSE-MsgGUID: jur21dT4STOnI/U7aCF3Qg==
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
X-IronPort-AV: E=Sophos;i="6.25,215,1779141600"; 
   d="scan'208";a="289639283"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Aug 2026 08:53:40 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8137380F63; Mon, 10 Aug 2026 08:53:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 742E680F1C
	for <cocci@sympa.inria.fr>; Mon, 10 Aug 2026 08:53:36 +0200 (CEST)
X-CSE-ConnectionGUID: kZFkhPRgR+e+Gu/As7/hmg==
X-CSE-MsgGUID: 74nADR8WQQKMkAp4G55ISg==
X-IronPort-AV: E=Sophos;i="6.25,215,1779141600"; 
   d="scan'208";a="153948079"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 08:53:37 +0200
Date: Mon, 10 Aug 2026 08:53:35 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Guru Das Srinagesh <linux@gurudas.dev>
cc: Nicolas Palix <nicolas.palix@imag.fr>, 
    Michael Turquette <mturquette@baylibre.com>, 
    Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
    cocci@inria.fr, Brian Masney <bmasney@redhat.com>, 
    linux-clk@vger.kernel.org
In-Reply-To: <20260809-cocci-clk-register-v3-1-60d036e13370@gurudas.dev>
Message-ID: <b93bd4ac-d76b-2dfe-6945-7111ff20f41b@inria.fr>
References: <20260809-cocci-clk-register-v3-1-60d036e13370@gurudas.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v3] coccinelle: Detect clk_register()
 anti-pattern
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3672
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/2z1Lq6BJ4w49g8rwZK-7ng>



On Sun, 9 Aug 2026, Guru Das Srinagesh wrote:

> Enforce commit 12a0fd23e870 ("clk: Print an error when clk registration
> fails"): clk_register(), clk_hw_register(), and their devm_/of_ variants
> log their own error on failure, so driver-side error prints after these
> calls are redundant.
>
> Two independent match families, one per return-value convention:
> pointer return checked via IS_ERR() (clk_register()/devm_clk_register()),
> and int return checked via a nonzero value (clk_hw_register()/
> devm_clk_hw_register()/of_clk_hw_register()). Both families match
> regardless of whether the redundant message's "if" also has a trailing
> "else", via an "else S" clause with S otherwise unused.
>
> In "patch" mode, removing the redundant message also collapses the
> enclosing braces when only one statement remains, and deletes the whole
> "if" when the message was already the only (braceless) statement.
>
> Assisted-by: Claude:claude-sonnet-5 coccinelle
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> ---

Hello,

Thanks for the update, which I will look into shortly.

But you are not structuring your patches in the right way.  The part above
the first --- is what will go into the git comit.  That looks fine.

But I don't understand what is the big pile of text below the ---.  When
there is a new version, I want to see what has changed as quickly as
possible.  So the changes in v3 should be the first thing that I see below
the ---, not the last thing.

For the following information, I'm not sure it should be here at all.
Either it is important, in which case it should be above the --- so people
in the future can easily benefit from it, or it is not important, in which
case it should be dropped.

julia


> Add a Coccinelle semantic patch enforcing commit 12a0fd23e870 ("clk:
> Print an error when clk registration fails"): flags, and in "patch"
> mode removes, driver-side error prints that are now redundant after
> clk_register()/clk_hw_register() and their devm_/of_ variants.
>
> Two independent match families, one per return-value convention.
>
> Pointer return, IS_ERR()-checked (clk_register()/devm_clk_register()),
> e.g. drivers/clk/clk-xgene.c:152-157:
>
>     clk = clk_register(dev, &apmclk->hw);
>     if (IS_ERR(clk)) {
> -       pr_err("%s: could not register clk %s\n", __func__, name);
>         kfree(apmclk);
>         return NULL;
>     }
>
> Int return, nonzero-checked (clk_hw_register()/devm_clk_hw_register()/
> of_clk_hw_register()), e.g. drivers/clk/meson/meson-clkc-utils.c:49-54:
>
>     ret = devm_clk_hw_register(dev, hw);
> -   if (ret) {
> -           dev_err(dev, "registering %s clock failed\n",
> -                   hw->init->name);
> +   if (ret)
>         return ret;
> -   }
>
> Already-braceless single-statement case: the whole "if" is deleted
> instead of just the message, e.g. drivers/clk/ux500/clk-sysctrl.c:171-175:
>
>     clk_reg = devm_clk_register(clk->dev, &clk->hw);
> -   if (IS_ERR(clk_reg))
> -           dev_err(dev, "clk_sysctrl: clk_register failed\n");
>
>     return clk_reg;
>
> Matches regardless of whether the "if" also has a trailing "else", via
> an "else S" clause with S otherwise unused, e.g.
> drivers/media/platform/microchip/microchip-isc-clk.c:269-275:
>
>     isc_clk->clk = clk_register(isc->dev, &isc_clk->hw);
> -   if (IS_ERR(isc_clk->clk)) {
> -           dev_err(isc->dev, "%s: clock register fail\n", clk_name);
> +   if (IS_ERR(isc_clk->clk))
>         return PTR_ERR(isc_clk->clk);
> -   } else if (id == ISC_MCK) {
> +   else if (id == ISC_MCK) {
>         of_clk_add_provider(np, of_clk_src_simple_get, isc_clk->clk);
>     }
>
> Testing:
> - Baseline: coccinelle 1.3.1, the Torvalds tree at v7.2-rc5.
> - "make coccicheck COCCI=<path> MODE=report M=drivers/clk" produced 73
>   hits, unchanged after this revision, and verified to have zero false
>   positives.
> - All four modes (report/context/patch/org) verified via "make
>   coccicheck COCCI=<path> MODE=<mode> [M=<path>]" against the
>   drivers/clk baseline and the new else-branch case above.
> - "make coccicheck COCCI=<path> MODE=report" (whole tree, no M=) finds
>   94 hits; the 21 outside drivers/clk are not part of this series.
> ---
> Changes in v3 (Julia):
> - Match an "if" regardless of a trailing "else" (else S, S unused),
>   across context/patch/report/org rules for both families. Found via
>   this to be a real, previously-invisible case in
>   drivers/media/platform/microchip/microchip-isc-clk.c.
> - Fix the org-mode script rules: cocci.print_main() takes (message,
>   position), not just a position; the previous calls omitted the
>   message entirely.
> - Drop the MAINTAINERS addition from v2 per Julia's comment that a
>   specific maintainer isn't needed for this file.
> - Link to v2: https://patch.msgid.link/20260803-cocci-clk-register-v2-1-22e789f75f98@gurudas.dev
>
> Changes in v2 (Julia):
> - Use a literal function-name disjunction instead of a regex identifier,
>   enabling spatch's file pre-filter optimization.
> - In "patch" mode, drop braces when only one statement remains, and
>   delete the whole "if" when the message was the only (braceless)
>   statement.
> - Drop two never-observed condition variants (IS_ERR(clk) == 1, ret !=
>   0); keep the one with real precedent (ret < 0).
> - Link to v1: https://patch.msgid.link/20260802-cocci-clk-register-v1-1-df68afcb1eef@gurudas.dev
> ---
>  scripts/coccinelle/api/clk_register.cocci | 165 ++++++++++++++++++++++++++++++
>  1 file changed, 165 insertions(+)
>
> diff --git a/scripts/coccinelle/api/clk_register.cocci b/scripts/coccinelle/api/clk_register.cocci
> new file mode 100644
> index 000000000000..150279827bf4
> --- /dev/null
> +++ b/scripts/coccinelle/api/clk_register.cocci
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/// Remove error messages after clk registration failures, because
> +/// clk_register(), clk_hw_register(), and their variants already log
> +/// an error when they fail. See commit 12a0fd23e870 ("clk: Print an
> +/// error when clk registration fails").
> +//
> +// Confidence: Medium
> +// Options: --include-headers
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +@depends on context@
> +expression clk;
> +identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
> +statement S;
> +@@
> +
> +clk = \(clk_register\|devm_clk_register\)(...);
> +if ( IS_ERR(clk) )
> +{
> +...
> +*voidfn(...);
> +...
> +}
> +else S
> +
> +@depends on patch@
> +expression clk;
> +identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
> +@@
> +
> +clk = \(clk_register\|devm_clk_register\)(...);
> +-if ( IS_ERR(clk) )
> +-voidfn(...);
> +
> +@depends on patch@
> +expression clk;
> +identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
> +statement S, S_else;
> +@@
> +
> +clk = \(clk_register\|devm_clk_register\)(...);
> +if ( IS_ERR(clk) )
> +(
> +-{
> +-voidfn(...);
> +S
> +-}
> +|
> +{
> +...
> +-voidfn(...);
> +...
> +}
> +)
> +else S_else
> +
> +@r1 depends on org || report@
> +position p1;
> +expression clk;
> +identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
> +statement S;
> +@@
> +
> +clk = \(clk_register\|devm_clk_register\)(...);
> +if ( IS_ERR(clk) )
> +{
> +...
> +voidfn@p1(...);
> +...
> +}
> +else S
> +
> +@depends on context@
> +expression ret;
> +identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
> +statement S;
> +@@
> +
> +ret = \(clk_hw_register\|devm_clk_hw_register\|of_clk_hw_register\)(...);
> +if ( \( ret \| ret < 0 \) )
> +{
> +...
> +*voidfn(...);
> +...
> +}
> +else S
> +
> +@depends on patch@
> +expression ret;
> +identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
> +@@
> +
> +ret = \(clk_hw_register\|devm_clk_hw_register\|of_clk_hw_register\)(...);
> +-if ( \( ret \| ret < 0 \) )
> +-voidfn(...);
> +
> +@depends on patch@
> +expression ret;
> +identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
> +statement S, S_else;
> +@@
> +
> +ret = \(clk_hw_register\|devm_clk_hw_register\|of_clk_hw_register\)(...);
> +if ( \( ret \| ret < 0 \) )
> +(
> +-{
> +-voidfn(...);
> +S
> +-}
> +|
> +{
> +...
> +-voidfn(...);
> +...
> +}
> +)
> +else S_else
> +
> +@r2 depends on org || report@
> +position p2;
> +expression ret;
> +identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
> +statement S;
> +@@
> +
> +ret = \(clk_hw_register\|devm_clk_hw_register\|of_clk_hw_register\)(...);
> +if ( \( ret \| ret < 0 \) )
> +{
> +...
> +voidfn@p2(...);
> +...
> +}
> +else S
> +
> +@script:python depends on org@
> +p1 << r1.p1;
> +@@
> +
> +msg = "line %s is redundant because clk_register() already prints an error on failure" % (p1[0].line)
> +cocci.print_main(msg, p1)
> +
> +@script:python depends on report@
> +p1 << r1.p1;
> +@@
> +
> +msg = "line %s is redundant because clk_register() already prints an error on failure" % (p1[0].line)
> +coccilib.report.print_report(p1[0], msg)
> +
> +@script:python depends on org@
> +p2 << r2.p2;
> +@@
> +
> +msg = "line %s is redundant because clk_hw_register() already prints an error on failure" % (p2[0].line)
> +cocci.print_main(msg, p2)
> +
> +@script:python depends on report@
> +p2 << r2.p2;
> +@@
> +
> +msg = "line %s is redundant because clk_hw_register() already prints an error on failure" % (p2[0].line)
> +coccilib.report.print_report(p2[0], msg)
>
> ---
> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
> change-id: 20260802-cocci-clk-register-951d94251af4
>
> Best regards,
> --
> Guru Das Srinagesh <linux@gurudas.dev>
>
>
