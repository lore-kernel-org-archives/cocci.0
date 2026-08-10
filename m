Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF298C5DF94
	for <cocci@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Z4IFTisua/RegQxEP1MskZjCmSMfAF370cvKdqSQxLI=;
  b=qxSK15AD3ua0aJLiK9cEZqLsJu6e7bM7EbOH61zzOw874egHMrdFf8EU
   PuJR6+1xwUp7meTiH2SjEmPQV6cSrEkWwlUTL5S0CU7FAFIrVZOszFKdd
   fID3KAvsRtJJTbk6jxEmMRMUKQ0kONHl3UhdNcVMV6DtrnvhH43OOGeVX
   w=;
X-CSE-ConnectionGUID: My8MSJqjQ16GVU2AyX+hFg==
X-CSE-MsgGUID: MdgxJfwtTG+YpVyc5PPyRg==
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
   d="scan'208";a="291206695"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2026 09:34:59 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1D27A81673; Mon, 24 Aug 2026 09:34:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2DFEC80F45
	for <cocci@sympa.inria.fr>; Mon, 10 Aug 2026 08:31:09 +0200 (CEST)
X-CSE-ConnectionGUID: tVV9gxsNQuqgmLf+F8cHvQ==
X-CSE-MsgGUID: BZGKN3xAT3+h7c/s4CWXKg==
IronPort-SDR: 6a79702c_iFeRaeciwpdSOqGRwQl/R8+OK1OiDf/gflFA8omJ/fOFqkH
 dFmQ8bO7+EZ135rIjUgBUxk7eaGOcLFDLGGBD6g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E1ADOlbnlqhRJEz2haHQEBAQEJARIBBQUBTIEyBgELA?=
 =?us-ascii?q?YJAgQpfMwcISYgnhSuIXB0DnhsUgWgCDwEDAQ1ECwIEAQEBAgEDhH4CTxWNA?=
 =?us-ascii?q?wIfBgEEMgcOAQIEAwIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECE?=
 =?us-ascii?q?AEBAQFASYZPDYJiATOCFiwNfQEBAQECAScTBgEBLgkBDwsYHBIQRgYTgwIBg?=
 =?us-ascii?q?iIHJCcDEQUBxGZ4gQEzgQGCDAEBBoEI3RMDBhQBgTgBiFwBhXhEglVpeicVB?=
 =?us-ascii?q?kCBTYEVgys+hCmGX4ESgRSBDIF4iwiFZlJ4HANZLAFVExcLBwWBI0MDgQYjS?=
 =?us-ascii?q?wUtHYEMFyEdFxceWBsGBRIgKkFEIwM+HUMFgU4CgXQ/Ixk2fIEJXoErKmQBA?=
 =?us-ascii?q?hAXRi4VgjUCgnaBLQQRC209NxQZBI8qIII/BgEBVyMJCgEFJlANgSABIT+Sf?=
 =?us-ascii?q?JAngiGBNYpDlReEKIwhlgeqbC6YWowQgXqKHotKhVGBbw4lgVwzGggwgyJQA?=
 =?us-ascii?q?xkPjiEZhCqDEchnJDUCOwIHAgcOAwuFQ4EDi1ZsYAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:s2opcqnMXyJBtEhkAhAS/uJhWBfpDfIG3DAbv31ZSRFFG/FwWf
 rBoB0+726StN9xYgBFpTnkAsO9qBznmKKdjbN8AV7mZniBhILKFvAG0aLHyz3kXwL58+tay7
 t4N5V5YeeAbmSS7/yb3ODQKb9Jq+VvsprY59s2pE0NcegFUc5dB1gQMHfjLnFL
X-Talos-CUID: 9a23:fSJnuW2isGGInqqm2boYJrxfBv4bI3LN11HpPla3DEJnC5PFQn+OwfYx
X-Talos-MUID: =?us-ascii?q?9a23=3ATQ7MRQ6g7s2GDabARuyVvW/rxoxC0YuNLhsduKl?=
 =?us-ascii?q?d+MnbPmtrZxyivBe4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,215,1779141600"; 
   d="scan'208";a="153946945"
X-IronPort-Outbreak-Status: No, level 1, Phish - Phish
X-MGA-submission: =?us-ascii?q?MDFyUEMYm7RwKiBR+gwfu+k7/soOpVAFrURkFf?=
 =?us-ascii?q?ROgyui/c8iDnB9/s5eFlbG3KrAQeRmiIKlPnI849iIrNWIjX4h4cHwWT?=
 =?us-ascii?q?pD+BnEEXAY/plh6ap6h7dJCTZ2A5sUyNr6cJSjfM4Uj4H1ASv4u8ROwy?=
 =?us-ascii?q?mjLZMXHScPSzUkAqqnxdfr/A=3D=3D?=
Received: from out-93wp-a18.jellyfish.systems ([104.207.68.18])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 08:31:08 +0200
Received: from gurudas.dev (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hJPyh74zcz2x9F;
	Mon, 10 Aug 2026 06:30:52 +0000 (UTC)
Date: Sun, 9 Aug 2026 23:30:47 -0700
From: Guru Das Srinagesh <linux@gurudas.dev>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	cocci@inria.fr, Brian Masney <bmasney@redhat.com>,
	linux-clk@vger.kernel.org
Message-ID: <anlwF9n1KVaYcnH1@gurudas.dev>
Mail-Followup-To: Julia Lawall <julia.lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	cocci@inria.fr, Brian Masney <bmasney@redhat.com>,
	linux-clk@vger.kernel.org
References: <20260803-cocci-clk-register-v2-1-22e789f75f98@gurudas.dev>
 <b351e95-b3e5-b947-ccd3-64be2971e835@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b351e95-b3e5-b947-ccd3-64be2971e835@inria.fr>
X-Envelope-From: linux@gurudas.dev
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2] coccinelle: Detect clk_register()
 anti-pattern
Reply-To: Guru Das Srinagesh <linux@gurudas.dev>
X-Loop: cocci@inria.fr
X-Sequence: 3694
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/yBqMACJpJBj3b7fosOWu8Q>

On Sun, Aug 09, 2026 at 10:00:22PM +0200, Julia Lawall wrote:
> 
> 
> On Mon, 3 Aug 2026, Guru Das Srinagesh wrote:
> 
> > Enforce commit 12a0fd23e870 ("clk: Print an error when clk registration
> > fails"): clk_register(), clk_hw_register(), and their devm_/of_ variants
> > log their own error on failure, so driver-side error prints after these
> > calls are redundant.
> >
> > Two independent match families, one per return-value convention:
> > pointer return checked via IS_ERR() (clk_register()/devm_clk_register()),
> > and int return checked via a nonzero value (clk_hw_register()/
> > devm_clk_hw_register()/of_clk_hw_register()).
> >
> > In "patch" mode, removing the redundant message also collapses the
> > enclosing braces when only one statement remains, and deletes the whole
> > "if" when the message was already the only (braceless) statement.
> >
> > Assisted-by: Claude:claude-sonnet-5 coccinelle
> > Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> > ---
> > Add a Coccinelle semantic patch enforcing commit 12a0fd23e870 ("clk:
> > Print an error when clk registration fails"): flags, and in "patch"
> > mode removes, driver-side error prints that are now redundant after
> > clk_register()/clk_hw_register() and their devm_/of_ variants.
> >
> > Two independent match families, one per return-value convention.
> >
> > Pointer return, IS_ERR()-checked (clk_register()/devm_clk_register()),
> > e.g. drivers/clk/clk-xgene.c:152-157:
> >
> >     clk = clk_register(dev, &apmclk->hw);
> >     if (IS_ERR(clk)) {
> > -       pr_err("%s: could not register clk %s\n", __func__, name);
> >         kfree(apmclk);
> >         return NULL;
> >     }
> >
> > Int return, nonzero-checked (clk_hw_register()/devm_clk_hw_register()/
> > of_clk_hw_register()), e.g. drivers/clk/meson/meson-clkc-utils.c:49-54:
> >
> >     ret = devm_clk_hw_register(dev, hw);
> > -   if (ret) {
> > -           dev_err(dev, "registering %s clock failed\n",
> > -                   hw->init->name);
> > +   if (ret)
> >         return ret;
> > -   }
> >
> > Already-braceless single-statement case: the whole "if" is deleted
> > instead of just the message, e.g. drivers/clk/ux500/clk-sysctrl.c:171-175:
> >
> >     clk_reg = devm_clk_register(clk->dev, &clk->hw);
> > -   if (IS_ERR(clk_reg))
> > -           dev_err(dev, "clk_sysctrl: clk_register failed\n");
> >
> >     return clk_reg;
> >
> > Testing:
> > - Baseline: coccinelle 1.3.1, the Torvalds tree at v7.2-rc5.
> > - "make coccicheck COCCI=<path> MODE=report M=drivers/clk" produced 73
> >   hits and verified to have zero false positives.
> > - "MODE=patch" verified separately on scratch copies of affected files
> >   to confirm minimal, correct diffs.
> >
> > checkpatch flagged that this new file needs a MAINTAINERS entry, and I'd
> > like to maintain it, so this adds a standalone entry rather than leaving
> > the file uncovered. There's no direct precedent for an individual .cocci
> > file getting its own entry - the only other named .cocci file in
> > MAINTAINERS, scripts/coccinelle/api/string_choices.cocci, was added to
> > the existing GENERIC STRING LIBRARY entry by that subsystem's
> > maintainer, not as a new one. Happy to fold this into COMMON CLK
> > FRAMEWORK or drop it entirely depending on what the maintainers prefer.
> > ---
> > Changes in v2 (Julia):
> > - Use a literal function-name disjunction instead of a regex identifier,
> >   enabling spatch's file pre-filter optimization.
> > - In "patch" mode, drop braces when only one statement remains, and
> >   delete the whole "if" when the message was the only (braceless)
> >   statement.
> > - Drop two never-observed condition variants (IS_ERR(clk) == 1, ret !=
> >   0); keep the one with real precedent (ret < 0).
> > - Link to v1: https://patch.msgid.link/20260802-cocci-clk-register-v1-1-df68afcb1eef@gurudas.dev
> > ---
> >  MAINTAINERS                               |   5 +
> >  scripts/coccinelle/api/clk_register.cocci | 153 ++++++++++++++++++++++++++++++
> >  2 files changed, 158 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 716acfc3d7c1..26788ccbf98c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6363,6 +6363,11 @@ L:	linux-clk@vger.kernel.org
> >  S:	Maintained
> >  F:	include/linux/clk.h
> >
> > +CLK_REGISTER() COCCINELLE CHECK
> > +M:	Guru Das Srinagesh <linux@gurudas.dev>
> > +S:	Maintained
> > +F:	scripts/coccinelle/api/clk_register.cocci
> > +
> 
> I don't think there needs to be a specific maintainer for this file.

Removed.

> 
> >  CLOCKSOURCE, CLOCKEVENT DRIVERS
> >  M:	Daniel Lezcano <daniel.lezcano@kernel.org>
> >  M:	Thomas Gleixner <tglx@kernel.org>
> > diff --git a/scripts/coccinelle/api/clk_register.cocci b/scripts/coccinelle/api/clk_register.cocci
> > new file mode 100644
> > index 000000000000..86a8be92f2a2
> > --- /dev/null
> > +++ b/scripts/coccinelle/api/clk_register.cocci
> > @@ -0,0 +1,153 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/// Remove error messages after clk registration failures, because
> > +/// clk_register(), clk_hw_register(), and their variants already log
> > +/// an error when they fail. See commit 12a0fd23e870 ("clk: Print an
> > +/// error when clk registration fails").
> > +//
> > +// Confidence: Medium
> > +// Options: --include-headers
> > +
> > +virtual patch
> > +virtual context
> > +virtual org
> > +virtual report
> > +
> > +@depends on context@
> > +expression clk;
> > +identifier voidfn =~ "^(dev_err|dev_warn|pr_err|pr_warn)$";
> > +@@
> > +
> > +clk = \(clk_register\|devm_clk_register\)(...);
> > +if ( IS_ERR(clk) )
> > +{
> > +...
> > +*voidfn(...);
> > +...
> > +}
> 
> This will only match an if with a then branch, no else branch.  There is
> actually one case in the kernel where there is a relevant if with an else
> branch, so you may as well extend this to match that cas too.  If you just
> add else S, where S is a statement metavariable that is not used
> elsewhere, then it will match either the case with an else or the case
> with a then branch only.
> 
> Likewise for the other rules.

Done, thank you for catching the edge case which I'm guessing is
drivers/media/platform/microchip/microchip-isc-clk.c.

> 
> [...]
> 
> > +@script:python depends on report@
> > +p1 << r1.p1;
> > +@@
> > +
> > +msg = "line %s is redundant because clk_register() already prints an error on failure" % (p1[0].line)
> > +coccilib.report.print_report(p1[0], msg)
> > +
> > +@script:python depends on org@
> > +p2 << r2.p2;
> > +@@
> > +
> > +cocci.print_main(p2)
> 
> This code is not correct. print_main seens a string as the first argument
> and a position (which you have) as the second argument.  You can make a
> string in the same was as in the report rules.
> 
> The same is true for the other org mode rule.  If you don't have org mode,
> you can still check that the code works by testing the semantic patch with
> -D org.  It's just a text format.

Done, sorry for the oversight.

> 
> julia
> 
> > +
> > +@script:python depends on report@
> > +p2 << r2.p2;
> > +@@
> > +
> > +msg = "line %s is redundant because clk_hw_register() already prints an error on failure" % (p2[0].line)
> > +coccilib.report.print_report(p2[0], msg)
> >
> > ---
> > base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
> > change-id: 20260802-cocci-clk-register-951d94251af4
> >
> > Best regards,
> > --
> > Guru Das Srinagesh <linux@gurudas.dev>
> >
> >
> 
