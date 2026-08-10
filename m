Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FCAC5AD55
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2026 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=SK0uVMXKBvLDqzCJ0FaLrmDzbUdUESbnQv00OPAi1PI=;
  b=R5VE77WZNTaQCrydDx9iy5sSOlxfz9n6Dqo/KuLbXNDRSxw6griGnf6P
   xe/XANHhr4jGoH8mHyDg2XVrTUM+QZ2zXqNTA3YlfNHO112CwJFK6WEGr
   l3nDJ2y62ZYg+/exF9dKq6X0AguMgNwtsI/1OSN/bHC/XPJOR7Bora1/Z
   Q=;
X-CSE-ConnectionGUID: Sl8bDog0Rf2eDoxFZpY1sA==
X-CSE-MsgGUID: LUS0hyFjRxmwIcLJmvL8tw==
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
   d="scan'208";a="289686579"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Aug 2026 15:00:37 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 84B82816A6; Mon, 10 Aug 2026 15:00:37 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 788788169D
	for <cocci@sympa.inria.fr>; Mon, 10 Aug 2026 15:00:35 +0200 (CEST)
X-CSE-ConnectionGUID: FQ8tflZuTHia0pzZKhEHKw==
X-CSE-MsgGUID: ANVVolDBQC20/UPNcLuo6Q==
X-IronPort-AV: E=Sophos;i="6.25,215,1779141600"; 
   d="scan'208";a="153973074"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 15:00:35 +0200
Date: Mon, 10 Aug 2026 15:00:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, 
    Jani Nikula <jani.nikula@linux.intel.com>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20260806174953.401869-1-ekffu200098@gmail.com>
Message-ID: <429fd2aa-3447-e16c-63b9-20f501940c1@inria.fr>
References: <20260806174953.401869-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v2] coccinelle: misc: add
 cond_return_no_effect.cocci
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3675
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/-_DUbbrqF6IFKdpjqky2KA>

Jani,

Yes or no?  The resulting patches have mostly gotten a positive response
so far, but maybe this is something that one doesn't mind seeing from time
to time, but doesn't want to be bothered with on a daily basis?

It is possible to make all the rules depend on something that has to be
provided as a special argument on the command line.  This introduces a
small barrier to entry...

thanks,
julia

On Fri, 7 Aug 2026, Sang-Heon Jeon wrote:

> Add a new Coccinelle script which removes a conditional return that
> has no effect:
>
> 	if (ret)
> 		return ret;
> 	return ret;
>
> Both branches return the same value, so the check can be removed.
> The condition can also be a negation or a comparison with a
> constant. Such code is usually a leftover from removing a
> statement between the two returns.
>
> When a local variable is assigned right before the check, the
> assignment and the two returns turn into a single return of the
> assigned expression, and the declaration is dropped if nothing
> else uses the variable. Otherwise only the check is removed.
>
> The fold can delete comments between the check and the final
> return, so the generated patch should be reviewed.
>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
> Changes from v1 [1]
> - fix unexpected removal of global or static declarations, as Julia
>   suggested
> - send the patch separately from the treewide series, as Mark
>   suggested
>
> [1] https://lore.kernel.org/all/20260723184538.3888637-1-ekffu200098@gmail.com/
> ---
> In the v1 thread, Jani shared the history of removing a similar
> script that matched an explicit return 0 at the end [1].
>
> Current status of the cleanup patches, two weeks after v1:
> - 17/35 merged (2 sites changed to explicit return 0 as requested)
> - 3/35 reviewed
> - 15/35 no response yet
>
> [1] https://lore.kernel.org/all/0ee1ef4aa7daa908bf28397ccc639c89b6aabd9c@intel.com/
> ---
>  .../misc/cond_return_no_effect.cocci          | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/cond_return_no_effect.cocci
>
> diff --git a/scripts/coccinelle/misc/cond_return_no_effect.cocci b/scripts/coccinelle/misc/cond_return_no_effect.cocci
> new file mode 100644
> index 000000000000..334a9bcd2d6e
> --- /dev/null
> +++ b/scripts/coccinelle/misc/cond_return_no_effect.cocci
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Remove a conditional return that has no effect:
> +///
> +///	if (ret)
> +///		return ret;
> +///	return ret;
> +///
> +/// Both branches return the same variable, so the check has no
> +/// effect. It can also be a negation or a comparison with a
> +/// constant.
> +///
> +/// When a local variable is assigned right before the check, the
> +/// assignment and the two returns turn into a single return of the
> +/// assigned expression, and the declaration is dropped if nothing
> +/// else uses the variable. Otherwise only the check is removed.
> +///
> +// Such code is usually a leftover from removing a statement between
> +// the two returns.
> +//
> +// Confidence: High
> +// Copyright: (C) 2026 Sang-Heon Jeon
> +// Comments: The fold can delete comments between the check and the
> +//           final return, so review the generated patch.
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +//----------------------------------------------------------
> +//  For patch mode
> +//----------------------------------------------------------
> +
> +@collect depends on patch@
> +identifier ret;
> +expression E;
> +binary operator cmp = {<, <=, >, >=, ==, !=};
> +constant C;
> +@@
> +	ret = E;
> +	if (\(ret \| !ret \| ret cmp C\))
> +		return ret;
> +	return ret;
> +
> +@depends on patch@
> +local idexpression ret;
> +expression E;
> +binary operator cmp = {<, <=, >, >=, ==, !=};
> +constant C;
> +@@
> +-	ret = E;
> +-	if (\(ret \| !ret \| ret cmp C\))
> +-		return ret;
> +-	return ret;
> ++	return E;
> +
> +@depends on patch@
> +idexpression ret;
> +binary operator cmp = {<, <=, >, >=, ==, !=};
> +constant C;
> +@@
> +-	if (\(ret \| !ret \| ret cmp C\))
> +-		return ret;
> +	return ret;
> +
> +@depends on patch disable optional_storage@
> +type T;
> +identifier collect.ret;
> +declaration D;
> +statement S;
> +@@
> +(
> +-	T ret;
> +(
> +	D
> +|
> +	S
> +)
> +&
> +	T ret;
> +	... when != ret
> +	    when strict
> +)
> +
> +@depends on patch disable optional_storage@
> +type T;
> +identifier collect.ret;
> +constant C;
> +declaration D;
> +statement S;
> +@@
> +(
> +-	T ret = C;
> +(
> +	D
> +|
> +	S
> +)
> +&
> +	T ret = C;
> +	... when != ret
> +	    when strict
> +)
> +
> +
> +//----------------------------------------------------------
> +//  For context mode
> +//----------------------------------------------------------
> +
> +@depends on context@
> +idexpression ret;
> +binary operator cmp = {<, <=, >, >=, ==, !=};
> +constant C;
> +@@
> +*	if (\(ret \| !ret \| ret cmp C\))
> +*		return ret;
> +	return ret;
> +
> +//----------------------------------------------------------
> +//  For org and report mode
> +//----------------------------------------------------------
> +
> +@r depends on org || report@
> +idexpression ret;
> +binary operator cmp = {<, <=, >, >=, ==, !=};
> +constant C;
> +position p;
> +@@
> +	if@p (\(ret \| !ret \| ret cmp C\))
> +		return ret;
> +	return ret;
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +cocci.print_main("WARNING: conditional return with no effect (both branches return the same value)", p)
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +coccilib.report.print_report(p[0], "WARNING: conditional return with no effect (both branches return the same value)")
> --
> 2.43.0
>
>
