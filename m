Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D20CDB470
	for <cocci@archiver.kernel.org>; Tue, 23 Jun 2026 19:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xSMOYqF4TW1oo/oaYbSE3DVzUFgoOWD1eXnNi5LbUlU=;
  b=UuEhJ884wplOYLNxaP3197nuUubSipeMgmCOUIawvdfujFF8Ph6J8a1w
   KYrAl1i+Hkt+y6B+pEXcFSDBXV8Y2Vr9gn9rgCCCaX5ojHGLrsyntBcwA
   DBUVZtsY8Z/CTkzqL7IUKg9JOrW1yidMoQwv0vhRD700xW59DdWTFS7qq
   U=;
X-CSE-ConnectionGUID: UhL57dwxTx+sMsDRttze9Q==
X-CSE-MsgGUID: 5eRA9Gx1RV2jNdGGv9hhVQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.24,221,1774306800"; 
   d="scan'208";a="283060073"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jun 2026 21:32:16 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id BC5D9803D6; Tue, 23 Jun 2026 21:32:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2EC5280508
	for <cocci@sympa.inria.fr>; Tue, 23 Jun 2026 21:32:15 +0200 (CEST)
X-CSE-ConnectionGUID: tcfxqqY4RxeIPU9LSvPA0Q==
X-CSE-MsgGUID: Fq/sMHOwSB+qDcGZs7RoUQ==
X-IronPort-AV: E=Sophos;i="6.24,221,1774306800"; 
   d="scan'208";a="283060064"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 21:32:15 +0200
Date: Tue, 23 Jun 2026 21:32:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Pierrick Philippe <pierrick.philippe@irisa.fr>
cc: cocci@inria.fr
In-Reply-To: <57ecbeab-69e1-4280-93e8-0bf8de707238@irisa.fr>
Message-ID: <3bfe7b1-612-71b4-9932-903f2820bd6@inria.fr>
References: <57ecbeab-69e1-4280-93e8-0bf8de707238@irisa.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-457161342-1782243135=:3943"
Subject: Re: [cocci] Adding an attribute to struct pointer in function
 parameter
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3585
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/b-wFUbAZJY7K6sYQqbGU-A>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-457161342-1782243135=:3943
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 17 Jun 2026, Pierrick Philippe wrote:

> Hi everyone,
>
> I recently send some mail on this mailing list, and my goal was to use
> Coccinelle to automatically annotate some variables or parameters for
> our analyzer.
>
> Just to recall, our attribute have an optional parameter corresponding
> to a field of interest when the annotated object is a structure.
> That parameter should also be a string.
> There was some limitations due to character escaping with Coccinelle to
> apply the following patch:
>
> ```cocci
> +struct foo f = {42, 42};
> -struct foo __attribute__((myattr("x"))) f = {42, 42}
> ```
>
> A workaround was to go through a python script to build the string
> holding the whole attribute (including the optional parameter between
> quotes).
> Unfortunately, I can't find a way to apply the same logic to a
> function's parameter.
> Here is the test code:
>
> ```C
> #include <string.h>
>
> struct foo {
>     int x;
>     int kdiedexko;
>     int y;
> };
>
> int foo(struct foo *ptr, int y) {
>     int z = memcmp(&ptr->x, &y, sizeof(int));
>     return z;   
> }
> ```
>
> And here is my patch:
>
> ```cocci
> @searching_struct_param_begin@
> expression E1, E2;
> identifier F, X;
> type T, T1;
> identifier S;
> parameter list[n = { 0 ... 7 }] p;
> @@
> T1 F(T *S, p)
> {
> ...
> (
> memcmp(&F->X, E1, E2)
> |
> memcmp(E1, &F->X, E2)

These are supposed to be S not F.  F is the name of the function.

> )
> ...
> }
>
> @script:python generation_struct_param_begin@
> s << searching_struct_param_begin.S;
> x << searching_struct_param_begin.X;
> content;
> @@
> coccinelle.content = cocci.make_ident("__attribute__((myattr(\"" + x +
> "\"))) *" + s)
>
> @replacement_struct_param_begin@
> expression searching_struct_param_begin.E1, searching_struct_param_begin.E2;
> identifier searching_struct_param_begin.F,
> searching_struct_param_begin.X, generation_struct_param_begin.content;
> parameter list[n = { 0 ... 7 }] searching_struct_param_begin.p;
> type searching_struct_param_begin.T, searching_struct_param_begin.T1;

The metavariable S is not declared here.  You should have gotten a warning
about this?

julia

> @@
> T1 F(
> -T *S,
> +T content,
> p)
> {
> ...
> (
> memcmp(&F->X, E1, E2)
> |
> memcmp(E1, &F->X, E2)
> )
> ...
> }
> ```
>
> The semantic patch is valid, but for some reason, no patch is generated
> by Coccinelle and I can't figure out why.
> Anyway, thank you for reading me again.
>
> Have a good day,
>
> Pierrick
>
>
--8323329-457161342-1782243135=:3943--
