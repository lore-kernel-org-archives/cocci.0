Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A06C433F5
	for <cocci@archiver.kernel.org>; Fri, 28 Jan 2022 09:16:56 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,323,1635199200"; 
   d="scan'208";a="18410016"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2022 10:16:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0063EE0290; Fri, 28 Jan 2022 10:16:54 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9A028E00CE
	for <cocci@sympa.inria.fr>; Fri, 28 Jan 2022 10:16:52 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.88,323,1635199200"; 
   d="scan'208";a="18410010"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:16:52 +0100
Date: Fri, 28 Jan 2022 10:16:52 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <d6cf70b7-84b2-5078-f9f7-81ca8acad349@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2201281013590.9718@hadrien>
References: <d6cf70b7-84b2-5078-f9f7-81ca8acad349@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] How do you match complex double's in Coccinelle?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 118
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-01/alpine.DEB.2.22.394.2201281013590.9718%40hadrien>



On Wed, 26 Jan 2022, Eric Wheeler wrote:

> Bonjour!
>
> I'm having an issue, perhaps you can help.  When I try to use the
> following Coccinelle patch I get an error:
>
>
> ```
> @ rule1 @
> double complex dst;
> expression a1, a2, b1, b2, c1, c2;
> @@
> -dst += (a1)*(a2) + (b1)*(b2) + (c1)*(c2);
> +vec_fma3(&dst, &a1, &a2, &b1, &b2, &c1, &c2);
> ```
>
> It gives this error while parsing the .cocci file (not when evaluating
> matrix.c because it doesn't get that far):

What version of Coccinelle do you have?  Because for me it works fine.  If
you are using a version from a Linux distro, perhaps try getting the
latest one from github.

julia

>
> ```
> init_defs_builtins: /usr/lib64/coccinelle/standard.h
> meta: parse error:
>   File "vec_fma3.cocci", line 2, column 15, charpos = 25
>   around = 'dst',
>   whole content = double complex dst;
> ```
>
> Strangely, it works if I change the type to just `double` instead of
> `double complex` and it does produce the following patch from
> matrix.c[1] even though `*cmx` and friends are all `complex double`'s.
>
>
> Questions:
>  - The Coccinelle grammar[2] says it supports `double complex` so am I
>    missing something?
>
>  - Relatedly, does it support `complex double` as well as `double complex` ?
>
>
> It does what I want if I specify only `double`, but I would like to be
> more strict about the datatype being `complex double` when spatch'ing the
> code:
>
> ```
> -            cmx[k+(jl-1)*nrow] +=
> -              dataj.exk* cabi+ dataj.eyk* sabi+ dataj.ezk* salpi;
> -            cmx[k+jl*nrow]     +=
> -              dataj.exs* cabi+ dataj.eys* sabi+ dataj.ezs* salpi;
> +            vec_fma3(&cmx[k + (jl - 1) * nrow], &dataj.exk, &cabi, &dataj.eyk,
> +                     &sabi, &dataj.ezk, &salpi);
> +            vec_fma3(&cmx[k + jl * nrow], &dataj.exs, &cabi, &dataj.eys,
> +                     &sabi, &dataj.ezs, &salpi);
> ```
>
> Thanks for your help!
>
> --
> Eric Wheeler
>
>
>   [1]: https://github.com/KJ7LNW/xnec2c/blob/f7373f11551b963a78cc27b11692f41abac28615/src/matrix.c#L451
>   [2]: https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.pdf
>
