Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08020C71153
	for <cocci@archiver.kernel.org>; Sat,  2 Sep 2023 19:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=V8e9p0L4sE9KopIU5eUN4GmGyVTRDhlo93xawVvkxFQ=;
  b=gUiGRLFCQcnlRhMBpe6PrdceJ1R72Gy6cZzX2OGu8dFw38TgAHd0vI1k
   oXWxeLfP6XKD2rLENndbmW5FfKuSbcym3lay2BmIRlx7eGhCDaxH6zhuv
   7ZznnMEDwS3B8RCoV2uG/NKBMnwQ0ystTnKyQPzlbKTSk2k44Bw58vUGL
   s=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.02,223,1688421600"; 
   d="scan'208";a="124032927"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Sep 2023 21:02:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E09BDE0AF1; Sat,  2 Sep 2023 21:02:01 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 07045E004E
	for <cocci@sympa.inria.fr>; Sat,  2 Sep 2023 21:02:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=V8e9p0L4sE9KopIU5eUN4GmGyVTRDhlo93xawVvkxFQ=;
  b=XkTdkLaCY3YyN1dO5tmyj0Oh3iLPk4NqiRz28/SHm7y/1Hx5154Zt0yI
   zOS4YbbQ/cWY4RCocq6AC5qGW3ho1zNkDLsOiU+cyJs0bYj7/NS6XUA12
   L52untaCuaoVbvNtJbRqZ6ULcXnMz2tgYRc5PsSPm2I/Hl/Bs2jLiT82f
   o=;
X-IronPort-AV: E=Sophos;i="6.02,223,1688421600"; 
   d="scan'208";a="64934011"
Received: from 228.66.136.77.rev.sfr.net (HELO hadrien) ([77.136.66.228])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 21:02:00 +0200
Date: Sat, 2 Sep 2023 21:01:58 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Thomas Adam <thomas@fvwm.org>
In-Reply-To: <1326a929-8a48-4113-981c-df6dc3220474@web.de>
Message-ID: <alpine.DEB.2.22.394.2309022101230.3175@hadrien>
References: <7e3fdd0f-e691-4ebd-9de9-4fbdb6ece973@web.de> <alpine.DEB.2.22.394.2309022008310.3175@hadrien> <205fad47-dbef-4cfe-885b-69a2a0d4b09b@web.de> <alpine.DEB.2.22.394.2309022032260.3175@hadrien> <1326a929-8a48-4113-981c-df6dc3220474@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-335845092-1693681319=:3175"
Subject: Re: [cocci] Checking a transformation approach for the avoidance of
 duplicate code
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1234
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-09/alpine.DEB.2.22.394.2309022101230.3175%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-335845092-1693681319=:3175
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 2 Sep 2023, Markus Elfring wrote:

> >>>> Now I wonder why a corresponding patch is not generated by the software
> >>>> “Coccinelle 1.1.1-00478-g0afff7fa” (OCaml 5.0) at the moment.
> >>>> I would appreciate further advices.
> >>>
> >>> Probably because in each branch, the first line is a declaration, not a statement.
> >>
> >> How does this feedback fit to other software documentation according to declaration statements?
> >> https://en.cppreference.com/w/cpp/language/statements#Declaration_statements
> >
> > Whatever.  In Coccinelle, we decided to do it that way I said it is done.
> > This makes it easy to search for the first statement that is not a
> > declaration in a function.
>
> The following SmPL script variant does also not produce an expected patch
> for the source file “fvwm/colorset.c”.
>
> @replacement@
> declaration d;
> statement s1, s2;
> @@
> -if (tint != NULL)
> -{
> - d
> - s1
> - cs->tint = GetColor(tint);
> - s2
> -}
> -else if (tint == NULL)
> -{
> - d
> - s1
> - cs->tint = GetColor(black);
> - s2
> -}
> +d
> +s1
> +cs->tint = GetColor(tint ? tint : black);
> +s2

OK the problem seems to be related to s2 matching an if.  I will look into
it.

thanks,
julia
--8323329-335845092-1693681319=:3175--
