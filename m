Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A68C4345F
	for <cocci@archiver.kernel.org>; Thu,  2 May 2024 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=70wefJERquo/L0RI2Ucwuio+Ic5sQUyYS6AGK2wx8XE=;
  b=HswNss9V9ha8SHWphS/+c5Zr4avpcVRXQeBc/voAQvXW6VQlkBHAcSx2
   rDFok0wxkUlhG05TrG+D4fuXtZ4o027e16dDHCdBufi+IOn/JqeicpULZ
   V5ulZ29y3tRajtPBg54hwvfdvgMRiET4N0gU5+THP4WLmMfVe76IERWxp
   o=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
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
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164295225"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 May 2024 23:41:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A222EE013D; Thu,  2 May 2024 23:41:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 82780E0133
	for <cocci@sympa.inria.fr>; Thu,  2 May 2024 23:41:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=70wefJERquo/L0RI2Ucwuio+Ic5sQUyYS6AGK2wx8XE=;
  b=kCq8hCn+NOpUjIVq60f27QTPG6oHeFYeSlS8Wzcv2K5aIb0aDaSHDUGp
   Dlsdkc2cDH0KHamxAF6DVbXsgCSXrn9e3IHvjySZa5OxSVKyjskU5oR0I
   XA8FQrXTaD2R0SpSPdSKRBQsq9CZGDYSxRpqsQnFG5GY7c+ZRw5Lt4b8N
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="86265321"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 23:41:23 +0200
Date: Thu, 2 May 2024 23:41:22 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Richard W.M. Jones" <rjones@redhat.com>
cc: cocci@inria.fr
In-Reply-To: <20240502173148.GF30267@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2405022340080.3439@hadrien>
References: <20240502085433.GA30267@redhat.com> <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr> <20240502163131.GC30267@redhat.com> <6881602e-5f8e-db48-323d-139673441398@inria.fr> <20240502164958.GD30267@redhat.com> <20240502171930.GE30267@redhat.com>
 <20240502173148.GF30267@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1688
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/alpine.DEB.2.22.394.2405022340080.3439%40hadrien>



On Thu, 2 May 2024, Richard W.M. Jones wrote:

> On Thu, May 02, 2024 at 06:19:30PM +0100, Richard W.M. Jones wrote:
> > FWIW this is the flamegraph.  It's not very informative, but maybe
>
> ... except that 86% of the entire time is taken in these two functions
> (and stuff called from there):
>
> https://github.com/ocaml/ocaml/blob/e202de7439afaec4671da56b59dce240447ea174/middle_end/flambda/invariant_params.ml#L99-L108
>
> whatever that means.

I don't know what it means.  Do you want me to contact the OCaml people?
Or do you want to contact them?

I made another test on another machine and still can't reproduce the
problem.

julia


>
> > means a bit more to people familiar with the internals of the OCaml
> > compiler.
> >
> > http://oirase.annexia.org/2024-05-ocamlopt.svg
>
> Rich.
>
> --
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> Fedora Windows cross-compiler. Compile Windows programs, test, and
> build Windows installers. Over 100 libraries supported.
> http://fedoraproject.org/wiki/MinGW
>
>
