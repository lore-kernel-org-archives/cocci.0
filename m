Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64346C433EF
	for <cocci@archiver.kernel.org>; Sat,  2 Apr 2022 21:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lw+/324nKBf2mB+qfSVFBqShkEyFtQyaoeoEG4OtPdw=;
  b=G+8KwLxEfJ7RSJCpladR8Ix6jLlAcuPza7Km/NWP/SYeg8ZkmcXdLjaU
   qx/FVkiRhBW3G/nMjA2dJfHWbEqd3dvQ4L89+SDA4KkwwT+zSmrbUaHPz
   0PS3DA/QqgfPIrw7j5fAF8N4u1TFKX0RMylfMO+GHqIZmuCC8d9eG8o1J
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29701498"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Apr 2022 23:26:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C115FE033B; Sat,  2 Apr 2022 23:26:10 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AB546E00A8
	for <cocci@sympa.inria.fr>; Sat,  2 Apr 2022 23:26:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lw+/324nKBf2mB+qfSVFBqShkEyFtQyaoeoEG4OtPdw=;
  b=pt/R82MwDhd2nlz2FYruEcWWoo2hQpMO2PS4HmpzNz6mepLSNq1NYLOo
   6fmTPjGv5xgkTxSmElIBB0faTbteqB7mWPQy3IX2jMuPv5AEADO5MzIQE
   HP8J61W++kvW1NWgPkavdJKzaDQXsZ5SORwfQxY/f+0mA2IjjzDKalBiK
   A=;
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="10381985"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 23:26:07 +0200
Date: Sat, 2 Apr 2022 23:26:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <4f40e17b-67ed-97f0-10ca-41285d7c3d1a@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2204022320520.3208@hadrien>
References: <4f40e17b-67ed-97f0-10ca-41285d7c3d1a@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] How do you concatinate string constants in SmPL with
 python?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 340
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/alpine.DEB.2.22.394.2204022320520.3208%40hadrien>



On Sat, 2 Apr 2022, Eric Wheeler wrote:

> Hello all,
>
> I would like to do something like this:
>
> @ r @
> constant C;
> @@
> -perror(C);
> +pr_err(C ": %s\n", strerror(errno));
>
> Thus in python I need something like C = C + C ": %s\n".

I don't understand this.

>
> I've tried a few things, but I don't think I'm anywhere close to getting
> it right.  Can someone help with how this should be setup?
>
> Also is there a reference for the `coccinelle.` and `cocci.` python calls
> that seem to be available in a script:python section?

There is Coccilib.3cocci, but that is for ocaml.

My understanding is that there are reflective features in python that let
you find out what functions are available.  python/python_documentation.md
in the source tree also has some information.  Or look at the code in
python/coccilib.

julia
