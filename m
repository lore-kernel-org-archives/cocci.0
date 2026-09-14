Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5D6C88E75
	for <cocci@archiver.kernel.org>; Mon, 14 Sep 2026 15:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nw3JdVVxhS3CaRpnvLvEKJ55A6VPfmg8Te1wru8Z/pA=;
  b=dytDbtWpz+60ZdUAvG4x5OGXVsM1RNK8NYiV+nzFyCX6GO4Ac6znTWvX
   fhM1A0M90jhVdKHQV3tuA9bEOWosEMAjuGwCMgYPxZ0phuJftT8scf+j9
   YYWS+uGt3ghy25Sb3NSTcmEnt5O3CJQQ8zEQhjN/CTwX8zuLyUX7rIZCP
   o=;
X-CSE-ConnectionGUID: nkORiBFSR+ufClOKvzKtSg==
X-CSE-MsgGUID: Akdc64ScTTqoeDsOp4fYkA==
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
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="294886064"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Sep 2026 17:17:47 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E314E81E1A; Mon, 14 Sep 2026 17:17:46 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 6963C81DEA
	for <cocci@sympa.inria.fr>; Mon, 14 Sep 2026 17:17:44 +0200 (CEST)
X-CSE-ConnectionGUID: Ca7JoidZRAi4Kc2aX3gJqA==
X-CSE-MsgGUID: OTWdthLKTcmIwUpd8ZGk8g==
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="294886045"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 17:17:44 +0200
Date: Mon, 14 Sep 2026 17:17:44 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Joshua Crofts <joshua.crofts1@gmail.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org, 
    cocci@inria.fr
In-Reply-To: <20260914151145.1328-1-joshua.crofts1@gmail.com>
Message-ID: <c737384a-aad6-8ebd-a633-4ab354991c28@inria.fr>
References: <20260914151145.1328-1-joshua.crofts1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] coccinelle: api: add a checker for
 pm_runtime_use_autosuspend() usage
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3730
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/IyhIavuAKReXB1Q9MdQF8w>



On Mon, 14 Sep 2026, Joshua Crofts wrote:

> Add a checker for ensuring that pm_runtime_dont_use_autosuspend() is
> called in a file if pm_runtime_use_autosuspend() is called and its
> devm_* counterpart isn't present.
>
> Without _dont_use_autosuspend(), removing devices causes resource leaks.
>
> Assisted-by: LLM
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  scripts/coccinelle/api/pm_autosuspend.cocci | 62 +++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 scripts/coccinelle/api/pm_autosuspend.cocci
>
> diff --git a/scripts/coccinelle/api/pm_autosuspend.cocci b/scripts/coccinelle/api/pm_autosuspend.cocci
> new file mode 100644
> index 000000000000..2354396d9344
> --- /dev/null
> +++ b/scripts/coccinelle/api/pm_autosuspend.cocci
> @@ -0,0 +1,62 @@
> +//SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Confidence: High
> +// Copyright: (C) 2026 Joshua Crofts
> +// URL: https://coccinelle.gitlabpages.inria.fr/website
> +// Options: --no-includes
> +
> +virtual context
> +virtual org
> +virtual report
> +
> +//----------------------------------------------------------
> +// Detection
> +//----------------------------------------------------------
> +
> +@has_use@
> +expression dev;
> +position p;
> +@@
> +
> +pm_runtime_use_autosuspend@p(dev);
> +
> +@has_dont@
> +expression dev;
> +@@
> +
> +pm_runtime_dont_use_autosuspend(dev)
> +
> +@has_devm@
> +expression dev;
> +@@
> +
> +devm_pm_runtime_enable(dev)
> +
> +//----------------------------------------------------------
> +// Context mode
> +//----------------------------------------------------------
> +
> +@depends on context && has_use && !has_dont && !has_devm@
> +expression dev;
> +position has_use.p;
> +@@
> +
> +* pm_runtime_use_autosuspend@p(dev)

I don't think you need the position variable here.


> +
> +//----------------------------------------------------------
> +// Org and report mode
> +//----------------------------------------------------------
> +
> +@script:python depends on org && has_use && !has_dont && !has_devm@

In this rule and the next one, you don't need to depend on has_use.  That
happens already due to the inheritance of the metavariable.

julia

> +p << has_use.p;
> +@@
> +
> +msg = "WARNING: pm_runtime_use_autosuspend() called without matching pm_runtime_dont_use_autosuspend or devm_pm_runtime_enable()"
> +cocci.print_main(msg, p)
> +
> +@script:python depends on report && has_use && !has_dont && !has_devm@
> +p << has_use.p;
> +@@
> +
> +msg = "WARNING: pm_runtime_use_autosuspend() called without matching pm_runtime_dont_use_autosuspend or devm_pm_runtime_enable()"
> +coccilib.report.print_report(p[0], msg)
> --
> 2.47.3
>
>
