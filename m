Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52571D116EA
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 15:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=7KIh3W2ITNN95w8/Gw4RtgHV8IdMbnPTXJ68mhIcPzU=;
  b=ak7jxRMaToFGo0ojRuJRz92YeSwShDfN3weYKntMYTPti+pfAq3x4UOa
   1EIQXRtYjD1VuRdEixbwFzx5dm71haVzvcaqTW0wH/Yij9+om9uGX42k/
   jBjaPkYBFCjyBi5XuUJ93C2+o4S6ezMs6I7vS2r9siA0nXey2Lzt3CAkR
   U=;
X-CSE-ConnectionGUID: g/vLL9n6TcG7km6wm4Nfqg==
X-CSE-MsgGUID: E6O3tBvFTliYJ4b6GJQ1+Q==
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251895583"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 16:59:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CF24DE01A8; Sat, 29 Nov 2025 16:59:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C63BAE0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 16:59:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7KIh3W2ITNN95w8/Gw4RtgHV8IdMbnPTXJ68mhIcPzU=;
  b=DIE1ZK52rtO9QP+nqnaJd1qUKjABT4J2Oh9u8s856l190GZPMp5TDtK0
   NJtozbE2ObJDFvJqOS9fpcSbTYegLMk0kwIpOSA0+t1L+tSP5horlo3GE
   15gFy9mRHYM+4hxLoldp2fJKPteBjRmn49BmMmg9GaEvcsch9mr/UwQ2B
   c=;
X-CSE-ConnectionGUID: 0RZmmIgvRrm16rZQ4kHi9g==
X-CSE-MsgGUID: cU16rxKeQ0O3SUOJ3MQjhQ==
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251895581"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 16:59:21 +0100
Date: Sat, 29 Nov 2025 16:59:21 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Tobias Deiminger <tobias.deiminger@posteo.de>
cc: cocci@inria.fr
In-Reply-To: <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
Message-ID: <67f9e0f2-fa4e-c7a-d388-3732d8aec1e6@inria.fr>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de> <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr> <2897bda0c438111e967017f6bb3422f0@posteo.de> <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr> <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3213
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/67f9e0f2-fa4e-c7a-d388-3732d8aec1e6%40inria.fr>



On Sat, 29 Nov 2025, Tobias Deiminger wrote:

> Am 29.11.2025 14:51 schrieb Julia Lawall:
> > On Sat, 29 Nov 2025, Tobias Deiminger wrote:
> >  [...]
> > The return type for the function is required in this case:
> >
> > @r@
> > attribute a;
> > identifier fn;
> > types t;
> > @@
> >
> > * t a fn(...) { ... }
>
> @Julia
> Thanks, almost there...
>
> The rule with return type you suggested works when I put the expanded form
> directly in my.c
>
>   asmlinkage unsigned long __SYSCALL_DEFINE0 mysyscall(void) { return 0; }
>
> *and* additionally add '#define __SYSCALL_DEFINE0 MACROANNOTATION' to
> standard.h. Without MACROANNOTATION I would get semantic error.
>
> But if I put the macro form to my.c (which is my original use case)
>
>   SYSCALL_DEFINE0(mysyscall) { return 0; }
>
> and add either only this
>
>   #define SYSCALL_DEFINE0(func) \
>         asmlinkage unsigned long __SYSCALL_DEFINE0 func(void)
>
> , or additionally the MACROANNOTATION hint to standard.h, I always get parse
> errors, even with return type. Any ideas what's going on?

There is no macro expansion in the semantic patch.

julia

>
>
> @Markus
> > You might point remaining improvement possibilities out for this evolving
> > software.
>
> Thanks also for your pointers. I've started learning about Coccinelle
> yesterday evening and think I'm not in a position to make improvement
> suggestions :D What Julia suggested would suite my case, once it works.
>
> Tobias
>
