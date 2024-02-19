Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3E6C48BF8
	for <cocci@archiver.kernel.org>; Mon, 19 Feb 2024 21:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=H68DaCLuSRxX8ZS5a9TS8+v7114fOPAMZzwN9elBWlA=;
  b=WXrGzwcEYHjLe1AtRdt1PFalsVMKRNnSlH/zXPkEA3IEdQekWVuKNqIt
   9B5gzGth2fGBpjtSd+8oEn7Mjd/XZaN/1S/WGPei65fr+GnFd3FiJdO/k
   gRBA/d5Tm1nqi9l7nIHJFIZeq+YOXJZZH8/tMuC1+MLUgRzRQwqEo0ONI
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.06,171,1705359600"; 
   d="scan'208";a="152724320"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Feb 2024 22:12:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 73033E0CD6; Mon, 19 Feb 2024 22:12:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3B226E008A
	for <cocci@sympa.inria.fr>; Mon, 19 Feb 2024 22:12:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=H68DaCLuSRxX8ZS5a9TS8+v7114fOPAMZzwN9elBWlA=;
  b=Y+nld/uLVU1i2BKUQkYylrfXwbu/acfCQfBTLn1WMS+wTwQPn6ttB4S0
   wQkxaarC2p+b+rVtjM0RmBrKGX4bfgaqFALJ74j+Y+FMnPDV17AwRLbqG
   wGXCCbcBD4FUkjZ0fxOpv4q4BKS1rsB/6AzeJZgwURPEIeyGAKjnBZ2aw
   c=;
X-IronPort-AV: E=Sophos;i="6.06,171,1705359600"; 
   d="scan'208";a="152724317"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 22:12:10 +0100
Date: Mon, 19 Feb 2024 22:12:10 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: cocci@inria.fr, Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <202402191257.843BC9BC@keescook>
Message-ID: <alpine.DEB.2.22.394.2402192208110.3358@hadrien>
References: <202402191257.843BC9BC@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Excluding file paths
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1587
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402192208110.3358%40hadrien>



On Mon, 19 Feb 2024, Kees Cook wrote:

> Hi!
>
> I keep running into this, and figured I should just ask: how do I
> exclude certain directories (or files) when using "--dir"? For example,
> we've been working on removing the ambiguous/fragile C string APIs in
> the kernel and replacing them with alternatives, but we can't do this
> for userspace programs, since the alternatives only exist in the kernel
> code base itself. Mainly, this is about excluding tools/ but there are
> also parts of arch/um/ that are built against userspace libraries.
>
> I tried using "--ignore" but it doesn't seem to work. What's the right
> solution here? For example, this trivial replacement:

You put the constraint in the initial @@ of the semantic patch.  Try

depends on !file in tools && !file in samples

Maybe parentheses would b needed, eg !(files in tools)

julia



>
>
> @@
> @@
>
> -snprintf
> +scnprintf
>  (...);
>
>
> I don't want this to touch anything in tools/ or samples/.
>
> Thanks!
>
> -Kees
>
> --
> Kees Cook
>
