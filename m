Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ED4C77B7F
	for <cocci@archiver.kernel.org>; Sat,  6 May 2023 19:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Fqp/i6VH/gWACqtowUESEsdyce+qRmHk4+sMGleMRmY=;
  b=qkTP47pnnFg2Ri+xYTcwLB8ywrpZBwaOUq8h8rWcIDbcmyzB0ZlzvByb
   mDgmGzD4EO6If0Zp9ctMaNGIu1K521aPBf3U3NteQap2d9ePrpDzTben7
   QP8s3T6izRSeO/ZUq3GHvLaKpmJjjP2F93lEmH00kagyB2bNG9CiGvy97
   4=;
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
X-IronPort-AV: E=Sophos;i="5.99,255,1677538800"; 
   d="scan'208";a="106667704"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 May 2023 21:01:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4F746E0D44; Sat,  6 May 2023 21:01:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 457DCE0D40
	for <cocci@sympa.inria.fr>; Sat,  6 May 2023 21:01:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Fqp/i6VH/gWACqtowUESEsdyce+qRmHk4+sMGleMRmY=;
  b=KPHt0niaCMz2HnNyQKcDrK3o0s4z30R/Q/u8raPi3c3qhXCjQoi/TL9L
   /ejlbISJ9Vh/yhOD05hLR6bWD5Pq766KjKJWDeWU0XHsIQhUUbNT5mDPn
   0k4WO8d6cq+8Isr0q9qw1K3vs2604JCQIoHu2rVhGaMqC8xyEgF9ZGmnV
   U=;
X-IronPort-AV: E=Sophos;i="5.99,255,1677538800"; 
   d="scan'208";a="106667698"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 21:01:00 +0200
Date: Sat, 6 May 2023 21:00:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: cocci@inria.fr
In-Reply-To: <6452fcc1.050a0220.ab3f.2321@mx.google.com>
Message-ID: <alpine.DEB.2.22.394.2305062100440.2951@hadrien>
References: <6452fcc1.050a0220.ab3f.2321@mx.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] variable declarer?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1141
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/alpine.DEB.2.22.394.2305062100440.2951%40hadrien>



On Wed, 3 May 2023, Kees Cook wrote:

> Hi,
>
> I can't figure out how to match a declarer in a struct definition. For
> example:
>
>     struct foo {
>         int bar;
>         DECLARE_FLEX_ARRAY(u8, array);
>     };
>
> using:
>
> declarer name DECLARE_FLEX_ARRAY;
>
> doesn't work, without it, I get errors at "u8" since, I assume, it's not
> expecting parens. :)
>
> The full script I'm trying to use is a variation on the prior one:
>
>
> // Options: --include-headers
>
> @allocated@
> identifier STRUCT, ARRAY, COUNTER, CALC;
> expression COUNT;
> struct STRUCT *PTR;
> identifier ALLOC =~ "(devm_)?[kv][cvzm]alloc";
> @@
>
> (
>         CALC = struct_size(PTR, ARRAY, COUNT);
>         ...
>         PTR = ALLOC(..., CALC, ...);
> |
>         PTR = ALLOC(..., struct_size(PTR, ARRAY, COUNT), ...);
> )
>         ...
>         PTR->COUNTER = COUNT;
>
> @annotate@
> type COUNTER_TYPE, ARRAY_TYPE;
> identifier allocated.STRUCT;
> identifier allocated.ARRAY;
> identifier allocated.COUNTER;
> attribute name __counted_by;
> declarer name DECLARE_FLEX_ARRAY;
> @@
>
>  struct STRUCT {
>         ...
>         COUNTER_TYPE COUNTER;
>         ...
>         DECLARE_FLEX_ARRAY(ARRAY_TYPE, ARRAY)
> +       __counted_by(COUNTER)
>         ;
>  };

Should be working now.

julia
