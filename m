Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872AFCE835E
	for <cocci@archiver.kernel.org>; Mon, 30 Sep 2024 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=I2VHN464UgFw4dxzw8eKf9F1oWp3bu8uc4bW7mFC8ew=;
  b=kR4XVVqGWsfdVuuc+DrE+vIEgtbng7X89TXyavHBRAdTTmGjQg2Id2Vm
   0xAUPvo0z3i0fcYLYBoR8rLkDt9BTqaQx8GDG9BkTkb0d5LNLF3kEtZor
   Kmodui6R2oUKmePufHa4f1KFGNbn2pIhv9HcP6pwI9my3jWUH3j/k1LPJ
   0=;
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
   d="scan'208";a="186033022"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2024 17:41:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D3EF9E0CD1; Mon, 30 Sep 2024 17:41:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F1A7CE0035
	for <cocci@sympa.inria.fr>; Mon, 30 Sep 2024 17:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=I2VHN464UgFw4dxzw8eKf9F1oWp3bu8uc4bW7mFC8ew=;
  b=uDj26TZIt3TnNtKKLSP0V62JMTVbZ89yk3VYWcQ20imZZccvNuHoTepl
   jfj9HHStJybtsHlf4iAILOZyIylmlpU8o7KAvwRHkglVxI2p/CucC30AY
   duvBd+dNHuv2VFBHaGh/+6ZZELS77eRFHV9SeIyTjnDh0Zzv5PfdnMouS
   4=;
X-IronPort-AV: E=Sophos;i="6.11,166,1725314400"; 
   d="scan'208";a="186033017"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 17:41:38 +0200
Date: Mon, 30 Sep 2024 17:41:37 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
cc: cocci@inria.fr, efremov@linux.com
In-Reply-To: <CACzwLxiohvUHUxm2XM8B08RwY6VCLuK1p32Ek2Y0M+t1wTfX8g@mail.gmail.com>
Message-ID: <d3f5836b-9a4e-5974-b649-e6f75c5183f8@inria.fr>
References: <CACzwLxiohvUHUxm2XM8B08RwY6VCLuK1p32Ek2Y0M+t1wTfX8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Assistance in Coccinelle script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1898
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/d3f5836b-9a4e-5974-b649-e6f75c5183f8%40inria.fr>



On Mon, 30 Sep 2024, Sabyrzhan Tasbolatov wrote:

> Hello,
>
> In the scope of task [1], I'd like to use Coccinelle as grepping tool
> to find in Linux mainline tree code where the 2nd parameter "from"
> to copy_from_user(..., from, ...) is passed without __user compiler
> attribute. Please advise with the attached inline at the end of email,
> as I, seem, can't figure out per reading the documentation myself.
>
> $ spatch --version
> spatch version 1.2 compiled with OCaml version 4.13.1
> Flags passed to the configure script: --enable-opt --enable-ocaml
> --enable-python --enable-pcre-syntax --enable-pcre --prefix
> /home/user/.opam/default --libdir /home/user/.opam/default/lib
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expressions: PCRE
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=206267
>
> I've crafted the following script with Denis assistance,
> though it still doesn't work as expected.
>
> There are several cases how parameter can be passed to
> copy_from_user:
> 1. in parent function parameter (@r1@)
> 2. in parent function body as the variable with __user attr
>    or via u64_to_user_ptr() helper
>
> There are candidates for missing such as constraints:
> https://elixir.bootlin.com/linux/v6.11/source/arch/powerpc/math-emu/lfd.c#L12
> https://elixir.bootlin.com/linux/v6.11/source/arch/powerpc/math-emu/lfs.c#L23
>
> It does find the separate cases (r1 and r2 both conditions),
> however on `@missing depends on !r1 && !r2@` rule, I expect
> that it should match only results with missing r1 and r2 rules, yet
> it still matches the false-positive. Here is an example:
>
> $ spatch --sp-file copy_from_user.cocci kernel/user_namespace.c
> init_defs_builtins: /home/user/.opam/default/lib/coccinelle/standard.h
> SPECIAL NAMES: adding __user as a attribute
> HANDLING: kernel/user_namespace.c
> SPECIAL NAMES: adding DEFINE_MUTEX as a declarer
> kernel/user_namespace.c:1231:5-19: copy_from_user match !!!
>
> , where in kernel/user_namespace.c:
>
> 1215 ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
> 1216 size_t count, loff_t *ppos)
> 1217 {
> ....
> 1231 if (copy_from_user(kbuf, buf, count)) // <--- this is false-positive match
>
> Attached inline Coccinelle script:
> ---
> // __user exists in parent function parameter.
> @r1 exists@
> identifier f, param;
> position p;
> type T;
> @@
> f(..., T __user param@p, ...)
> {
> ...
> copy_from_user@p(..., param, ...)
> ...
> }
>
> // __user exists inline copy_from_user() casting.
> @r2 exists@
> identifier f, ptr;
> position p;
> type T;
> @@
> f(...)
> {
> ...
> (
> T __user *ptr = ...;
> ...
> copy_from_user@p(..., ptr, ...)
> |
> copy_from_user@p(..., u64_to_user_ptr(...), ...)
> )
> ...
> }
>
> @missing depends on !r1 && !r2@
> identifier f =~ "copy_from_user";
> position p;

Hello,

I haven't studied it in detail, but I have the impression you want:

position p != {r1.p,r2.p};

and not depends on !r1 && !r2.  The depends on will check that the rules
r1 and r2 match nowhere in the file.  The fact that the position variables
are all called p doesn't mean there is any connection between them.

julia

> @@
> f@p(...)
>
> @script:python@
> f << missing.f;
> p << missing.p;
> @@
> msg = f + " match !!!"
> coccilib.report.print_report(p[0], msg)
>
> Thanks in advance
> --
>
> Sabyrzhan
>
