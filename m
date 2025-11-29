Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5F9CFD2F6
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 20:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=rvqCo4qY6Tx4z1bE1iGoizNeKIfGFP1uS2yhG1HMCW0=;
  b=AZo/y0rsSDLdfe0GmW9b2wjNE6wpfWMHgQydkN0HKtuX8LLE24XbRhqy
   8v9bXxtQn+in0Ue6EA1CZTamy91jDlPPQeE/rWGLWguOAA6J/IvPwceaH
   CgcxGkW/0OPpuykTt4SXzNtWGK8tsRuk5yiwHhkh0jRCmMS8YuwqCAR2H
   8=;
X-CSE-ConnectionGUID: KjucYWnERUyQo+FXxJ6EiA==
X-CSE-MsgGUID: Mh0JX858RkyecgA7vSkAsg==
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
X-IronPort-AV: E=Sophos;i="6.20,237,1758578400"; 
   d="scan'208";a="251906266"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 21:10:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7FFE2E02E4; Sat, 29 Nov 2025 21:10:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D785FE0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 21:10:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rvqCo4qY6Tx4z1bE1iGoizNeKIfGFP1uS2yhG1HMCW0=;
  b=W1JCzHML88F3Q9OQOR3wH3elEGnX3MYLvAW+mxCO8CYLK2yqFdcJGmQP
   L0QGAlk/9wKp+MJEf3du3SA7+U9tUov47A4922FArsfVAqqt1pFm2cu5m
   SwZ9po5p0TF9rnEnFbOQ2SXw5YHf94JaaUNOLwzPRpLuIQGOYayaxc9ft
   o=;
X-CSE-ConnectionGUID: K/qDqx3VQ26BhLBBUzEPlg==
X-CSE-MsgGUID: 1O8Ru9YrTFWxBnyaLngPBg==
X-IronPort-AV: E=Sophos;i="6.20,237,1758578400"; 
   d="scan'208";a="251906265"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 21:10:17 +0100
Date: Sat, 29 Nov 2025 21:10:16 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Tobias Deiminger <tobias.deiminger@posteo.de>
cc: cocci@inria.fr
In-Reply-To: <ded004b275d73e35c46c3d30c057d58e@posteo.de>
Message-ID: <50ab756b-f81c-bc24-fcd5-4eea4e01f78@inria.fr>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de> <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr> <2897bda0c438111e967017f6bb3422f0@posteo.de> <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr> <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
 <67f9e0f2-fa4e-c7a-d388-3732d8aec1e6@inria.fr> <67d1e00d2e22a4655cb10ec55d1a99db@posteo.de> <83c8a7aa-9b98-8ac1-d563-e8fe2588f9a@inria.fr> <fd7307f8024706d4bd128d0b7f43bb96@posteo.de> <29c204aa0f1f08074279425b7de42dd7@posteo.de> <825ab32a-2544-d2a8-bc48-38f26c62bc@inria.fr>
 <ded004b275d73e35c46c3d30c057d58e@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3222
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/50ab756b-f81c-bc24-fcd5-4eea4e01f78%40inria.fr>



On Sat, 29 Nov 2025, Tobias Deiminger wrote:

> Hi,
>
> Am 29.11.2025 18:59 schrieb Julia Lawall:
> > Sorry, I don't think it is going to work with the attribute in the short
> > term.
> >
> > I succeeded with the following:
> >
> > .cocci
> >
> > @r@
> > symbol SYSCALL_DEFINE1;
> > identifier fn;
> > type t;
> > position p;
> > @@
> > fn(int SYSCALL_DEFINE1, ...) {@p ... }
> >
> > // or put the corresponding python code
> > @script:ocaml@
> > p << r.p;
> > @@
> >
> > Printf.printf "line: %d\n" (List.hd p).line
> >
> > ----------------------------------------------
> >
> > standard.h
> >
> > #define SYSCALL_DEFINE1(func, t1, a1) \
> >     int func(int SYSCALL_DEFINE1, t1 a1)
> >
> > ----------------------------------------------
> >
> > .c
> >
> > SYSCALL_DEFINE1(foo,int,x) { return 0; }
> >
> > ----------------------------------------------
>
> yep, that worked. Thanks a lot. What also works is to fake the return type to
> syscall_define_t in standard.h, and then do 'type t =~ "syscall_define_t";' in
> the rule.
>
> This is good enough for my experiments *). Sure it would be nice if coccinelle
> could match on "known macros" somehow, maybe during the preprocessing run. But
> as said, I'm not in a position to make such suggestions and believe I
> understand how it's not well suited if the engine is designed to match on the
> AST.

In general, Coccinelle does not expand macros.  So you can match them
with no problem.  The problem here is tha there is no way to parse the
code without expanding the macro.

julia

>
> Tobias
>
> *) There's an ongoing effort to add testable code expectations / requirements
> to important functions in the Linux kernel [1]. I'm involved, and one thing
> that IMO would help is if we could quantify what "important" exactly means,
> i.e. how many functions are to be documented (100? 10000? 1000000?), and where
> exactly are they. So I'm looking for something that can find all syscalls, all
> exported symbols, all sysfs functions, subset of internal APIs, and so on. Raw
> grep is obviously not well suited. Coccinelle is already used for similar
> tasks, so it's an obvious candidate. tree-sitter queries could also work.
>
> [1] https://lpc.events/event/19/contributions/2085/contribution.pdf
>
