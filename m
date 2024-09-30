Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56436CDD1D5
	for <cocci@archiver.kernel.org>; Mon, 30 Sep 2024 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ujTyDhBMMqsklqJP5qI1U/l4esLl1W79pywxgx+ES8Q=;
  b=D7hg+5uXLFqB10WIqXAK7B3kkVl2u89W2MrZJQsS3sF8dc8czllY4y0/
   P3emCEIb3efCTKoGvjhiomSNUvk0E9u/7xsaeZoMolxBxGJGd1/4IhXyO
   WutdNpQhl8V7wcnOWl8cJZocNVPUBnvNdaOc4zNyFGthwLtBK980bG9ZQ
   w=;
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
X-IronPort-AV: E=Sophos;i="6.11,166,1725314400"; 
   d="scan'208";a="186068243"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2024 21:59:09 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A831CE0CD0; Mon, 30 Sep 2024 21:59:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DFFE1E0035
	for <cocci@sympa.inria.fr>; Mon, 30 Sep 2024 21:59:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ujTyDhBMMqsklqJP5qI1U/l4esLl1W79pywxgx+ES8Q=;
  b=QZXDGxZqfF63hh5pX7w8gli5/imsPRMKnKBtgB2LAk8QTC4TnqoFj744
   l4JsxbkGQ888iQ36d35G5WRGYpbX+1zVgMJ6nK4q5/PiXa0IpECNPKO3Z
   TT5dN1K9yk7UNy1GMm/kCdk31EKiNk1/zu9sFUsAD43i04RIbGGKxogYs
   M=;
X-IronPort-AV: E=Sophos;i="6.11,166,1725314400"; 
   d="scan'208";a="186068232"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 21:59:07 +0200
Date: Mon, 30 Sep 2024 21:59:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr, 
    Denis Efremov <efremov@linux.com>, 
    Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
In-Reply-To: <CACzwLxiFrQx81F_NWDjWSEseu=ePn5PoPt59c74ud9-eUWCfFw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2409302157190.3482@hadrien>
References: <CACzwLxiohvUHUxm2XM8B08RwY6VCLuK1p32Ek2Y0M+t1wTfX8g@mail.gmail.com> <d3f5836b-9a4e-5974-b649-e6f75c5183f8@inria.fr> <CACzwLxiaXLLSZH=rufJkkyr07u45W40ENd=BXqU4B1NoyS1iag@mail.gmail.com> <fbd705ff-2c6d-4b96-aa71-114ed8789b99@web.de>
 <CACzwLxiFrQx81F_NWDjWSEseu=ePn5PoPt59c74ud9-eUWCfFw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Assistance in Coccinelle script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1903
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/alpine.DEB.2.22.394.2409302157190.3482%40hadrien>

> Thanks for the suggestions. I've modified it like this
> and now have much better matches, though there are several cases
> left like this one:
> https://elixir.bootlin.com/linux/v6.11-rc7/source/drivers/infiniband/core/uverbs_cmd.c#L2038
>
> Going to improve the script further or it's much easier to filter out cases.
>
> // __user exists in parent function parameter.
> @r1 exists@
> identifier f, param, addr;
> attribute name __user;
> expression E2;
> position p;
> type T;
> @@
> f(..., T __user *param, ...)
> {
> ... when any
> copy_from_user@p(...,
> ( param
> | param + E2
> | &param->addr
> ) , ...)
> ... when any
> }
>
> // __user exists inline copy_from_user() casting.
> @r2 exists@
> identifier f, ptr, addr;
> expression E2;
> attribute name __user;
> position p;
> type T;
> @@
> f(...)
> {
> ... when any
> (
> T __user *ptr = ...;
> ... when any
> copy_from_user@p(..., ptr, ...)

You can also just say <+...ptr...+>.  That will check if ptr is a
subexpression of an argument.

julia


> |
> T __user *ptr = ...;
> ... when any
> copy_from_user@p(..., ptr + E2, ...)
> |
> T __user *ptr = ...;
> ... when any
> copy_from_user@p(..., &ptr->addr, ...)
> |
> copy_from_user@p(..., (T __user *)ptr->addr, ...)
> |
> T __user *ptr;
> ... when any
> ptr = ...;
> ... when any
> copy_from_user@p(..., ptr, ...)
> |
> copy_from_user@p(..., (T __user *)ptr, ...)
> |
> copy_from_user@p(..., u64_to_user_ptr(...), ...)
> )
> ... when any
> }
>
> @missing@
> position p != {r1.p, r2.p};
> @@
> copy_from_user@p(...)
>
> @script:python@
> p << missing.p;
> @@
> msg = "match !!!"
> coccilib.report.print_report(p[0], msg)
>
