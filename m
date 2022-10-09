Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813ECC433FE
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 18:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=YonUpqGZOJje7hx/SBhREMoYVI43XAq5A+lwdyKuzJA=;
  b=Vzc5oVIyea6NRJh+asiqWQV519KnTB0kWGfobBiT7hZ+KhvmjDfri9Rb
   piNu+JtkSJhxVnPtK7RasZtqUehDhtg+t/J/YbpWRvQgrk8ssvVMlWdT7
   U6yI9+J/ItG70AadCqc3uUF1DCMcg54u7zN4trg+A1PjyPNRBH3vRJJ1/
   c=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="56688801"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 20:21:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B1DAAE0290; Sun,  9 Oct 2022 20:21:51 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5E36DE0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 20:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YonUpqGZOJje7hx/SBhREMoYVI43XAq5A+lwdyKuzJA=;
  b=bnisDE9kna97VhpkrXFG7dwbJpIjSzQh0XLdEFKBGTx05M0qaCLabNCS
   uB4aUxKtjNuZB5XGiTT1K1NB6yESC0ANnKZREAnKghlHD2AVJ2ujtxsb9
   6nJ9kNsPCVs4jJexrhL0wb8g2V7EXxbefg8OZkPhJPtiyDLMM9ymtFGiT
   Y=;
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="25894957"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 20:21:50 +0200
Date: Sun, 9 Oct 2022 20:21:49 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: cocci@inria.fr, linux-hardening@vger.kernel.org
In-Reply-To: <20221009181603.3242176-1-keescook@chromium.org>
Message-ID: <alpine.DEB.2.22.394.2210092021390.21609@hadrien>
References: <20221009181603.3242176-1-keescook@chromium.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] python: Add make_expr and include_match
 documentation
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 640
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210092021390.21609%40hadrien>



On Sun, 9 Oct 2022, Kees Cook wrote:

> Add the 'make_expr' and 'include_match' helpers in the Python
> documentation. Additionally cleans up a markdown-breaking line split.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thanks!

julia

> ---
>  python/python_documentation.md | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/python/python_documentation.md b/python/python_documentation.md
> index d0194d6c1391..1d933b9a3934 100644
> --- a/python/python_documentation.md
> +++ b/python/python_documentation.md
> @@ -11,13 +11,20 @@ file at the end of the execution of the Python script.
>
>  Example: tests/exitp.cocci
>
> +## cocci.include_match(state)
> +
> +If a python rule is running, it has matched. If the match should be
> +removed from consideration, this can be called with `state` set to
> +`False`.
> +
> +Example: tests/incpos.cocci
> +
>  ## cocci.has_env_binding(rule, name)
>
>  Returns `true` if the meta-variable `name` is bound in the rule
>  `rule`.
>
> -## cocci.add_pending_instance(files, virtual_rules, virtual_identifiers,
> -       extend_virtual_ids)
> +## cocci.add_pending_instance(files, virtual_rules, virtual_identifiers, extend_virtual_ids)
>
>  Internal function for the method iteration.register().
>
> @@ -28,9 +35,17 @@ Converts the string `id` to a C identifier.
>
>  Example: tests/python_mdecl.cocci
>
> +## cocci.make_expr(expr)
> +
> +Converts the thing `expr` to a C expression.
> +(Equivalent to Coccilib.make_expr in OCaml.)
> +
> +Example: tests/python_mdecl.cocci
> +
>  ## cocci.make_stmt(phrase)
>
>  Parses the string `phrase` as a C statement and returns the statement.
> +(Equivalent to Coccilib.make_stmt in OCaml.)
>
>  Example: tests/python_mdecl.cocci
>
> --
> 2.34.1
>
>
