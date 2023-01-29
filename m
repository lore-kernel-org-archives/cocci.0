Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60092C61D97
	for <cocci@archiver.kernel.org>; Sun, 29 Jan 2023 17:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=RoTIGWsRRruKiH1hUh8Y+FxT1ysTpPGYzaFF4cOvuWI=;
  b=q8ysxSZ/rUFk79NqYlDlCN3BNh9t/033oPv3xVtDjcw8SeISzgg6VmhP
   30r9xk7HY7fsPeSlSrCWzweZfIfPn2eP8AF5zEuXuWjpKwu8jKwZ/RCK9
   1xI9H+RWZ+uTUVERHaapjA4qXZByTGrILUw6UsVsGHC6FEvSthIr8vW9V
   U=;
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
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="89933543"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2023 18:28:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8BA43E743F; Sun, 29 Jan 2023 18:28:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C5A9AE743E
	for <cocci@sympa.inria.fr>; Sun, 29 Jan 2023 18:28:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RoTIGWsRRruKiH1hUh8Y+FxT1ysTpPGYzaFF4cOvuWI=;
  b=tTSdRHFNlXg4EmD46jpYuGHbg5f/VlYqd8W7IFIuNTal7IO+4bLPQvSK
   B32IBceBCGEGdy+X4tYCbRMYr4uuhfxwkQp0TE+nmZUuy7bP4EBxMs702
   rY6Zr7c8mIP2jO8I/9KjwQ9vZUVyDEAO+uxrYMnBKdMY0jbUOkxsVjIoi
   I=;
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="46287573"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 18:28:46 +0100
Date: Sun, 29 Jan 2023 18:28:46 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Luca Coelho <luca@coelho.fi>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
Message-ID: <alpine.DEB.2.22.394.2301291826510.2852@hadrien>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>   <alpine.DEB.2.22.394.2301272148570.4094@hadrien>   <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>   <808cd549-f96d-872d-a4db-30ea33095207@web.de>  
 <alpine.DEB.2.22.394.2301281048270.2822@hadrien>  <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>  <alpine.DEB.2.22.394.2301281432120.2822@hadrien> <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 835
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/alpine.DEB.2.22.394.2301291826510.2852%40hadrien>

> After mangling a lot with the rules, I can see that this now works, but
> only if I select the vlv_dsi.c file alone, like this:
>
> spatch --sp-file ~/dev_priv_i915.spatch -I drivers/gpu/drm/i915/display \
>  --all-includes --in-place ./drivers/gpu/drm/i915/display/vlv_dsi.c
>
>
> If I try to run the rules in all files in that directory, only the
> intel_display.c file is affected:
>
> spatch --sp-file ~/dev_priv_i915.spatch -I drivers/gpu/drm/i915/display  \
>  --all-includes --in-place ./drivers/gpu/drm/i915/display
>
>
> Of course, I can work around this by using find and running spatch
> individually in every file... But not ideal.

OK, so perhaps the problem is not actually the rules, but rather the way
in which the header files are being collected.

What version of Coccinelle do you have?  Someone (Kees?) reported a
problem with the collecion of header files at one point fairly recently,
and I think I fixed it.  It should be available in the github version of
Coccinelle.

julia
