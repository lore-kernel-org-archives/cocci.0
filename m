Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E58C3ABA9
	for <cocci@archiver.kernel.org>; Wed, 30 Apr 2025 15:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=eiPMETxgY1gU8DdYBCO0gsYAQflV/cIsmu25u555dXA=;
  b=EQWwBmug25gFK6J9pW40gzYbb23sRI+3hAM4TZTDLv3v07cT2DwSCNZ1
   j9lnM0D/NFMkYPrEyf9d4AmDp/1WsWcpS+43mqZ9OF9Z/nap54kgktD8P
   R382fZo9OumQLfbzsouO7iz651aUVVYO6mhUPSEZFjCq0d+8dzynQEaE5
   8=;
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
X-IronPort-AV: E=Sophos;i="6.15,252,1739833200"; 
   d="scan'208";a="220222099"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Apr 2025 17:59:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C2BCEE0D1D; Wed, 30 Apr 2025 17:59:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 754AAE007A
	for <cocci@sympa.inria.fr>; Wed, 30 Apr 2025 17:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eiPMETxgY1gU8DdYBCO0gsYAQflV/cIsmu25u555dXA=;
  b=G0UEJL4il4mhWmkmAf8eZTxB9qSz976PyeZSOwdNExgrv6/AX75zi+U8
   RoI/IWOFtdYQ8A4qPsTQDAyroIyzINLazODFGowGgHuJXezSgtyCpsawM
   bCuBzMk1xFzL/uqrZj8dINkZ0k9wFb2j1IBP+fUuF27WomJDmXdDoUdPZ
   o=;
X-IronPort-AV: E=Sophos;i="6.15,252,1739833200"; 
   d="scan'208";a="115593217"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 17:59:29 +0200
Date: Wed, 30 Apr 2025 17:59:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
cc: cocci@inria.fr
In-Reply-To: <5ed0ac32-bb11-4faf-8f70-76431df289ec@fastmail.fm>
Message-ID: <474ce813-bcd-53e4-fa69-64379dc97f9@inria.fr>
References: <5ed0ac32-bb11-4faf-8f70-76431df289ec@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Fatal error: exception
 Coccinelle_modules.Common.Impossible(126)
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2734
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/474ce813-bcd-53e4-fa69-64379dc97f9%40inria.fr>



On Fri, 25 Apr 2025, Bernd Schubert wrote:

> Bonsoir,
>
> we just found a simple reproducer for an issue that was affecting a few
> of our files. At least I hope that this is the only issue
>
>
> bschubert2@imesrv6 red>spatch --sp-file find_bug.cocci --c++=17 coccinelle_bug_example.cpp
> init_defs_builtins: /usr/lib/coccinelle/standard.h
> Starting the test...
> HANDLING: coccinelle_bug_example.cpp
> Fatal error: exception Coccinelle_modules.Common.Impossible(126)

Thanks for the report.  The problem was that the : in : public base_type_t
was not being accounted for.  I didn't use the provided patch as is, but
rather made something more specific to this case.  But using the provided
patch will also not cause any harm.  I will update the version in github
shortly.

julia

>
> Issue is here:
>
> // This struct definition with combined variable declaration fails Coccinelle parsing
> struct example_struct_t : public base_type_t {
>     example_struct_t() : base_type_t()
>         { }
>
>     void do_something() {
>         REDTRC(0, 0, 0, "Testing %s %d", member1.c_str(), member2);
>     }
>
>     std::string member1 = {"test"};
>     int member2 = {42};
> } global_instance1;  // This form causes Coccinelle to fail
>
>
> It works fine if we rewrite it as:
>
> // This struct definition with combined variable declaration fails Coccinelle parsing
> struct example_struct_t : public base_type_t {
>     example_struct_t() : base_type_t()
>         { }
>
>     void do_something() {
>         REDTRC(0, 0, 0, "Testing %s %d", member1.c_str(), member2);
>     }
>
>     std::string member1 = {"test"};
>     int member2 = {42};
> };
> struct example_struct_t global_instance1;  // This form works fine
>
>
> bschubert2@imesrv6 red>spatch --sp-file find_bug.cocci --c++=17 coccinelle_bug_example.cpp
> init_defs_builtins: /usr/lib/coccinelle/standard.h
> Starting the test...
> HANDLING: coccinelle_bug_example.cpp
> coccinelle_bug_example.cpp:18: Found REDTRC
> coccinelle_bug_example.cpp:32: Found REDTRC
> coccinelle_bug_example.cpp:8: Found REDTRC
>
>
>
> We are using Agument AI and without knowing myself anything about
> coccinelle, I just let the Agent go over it and it suggested this
> change, which indeed fixes the issue for me
>
> diff --git a/parsing_c/type_c.ml b/parsing_c/type_c.ml
> index 70da45b089a4..d77ac6658ace 100644
> --- a/parsing_c/type_c.ml
> +++ b/parsing_c/type_c.ml
> @@ -224,7 +224,9 @@ let structdef_to_struct_name ty =
>            qu, attr, Ast_c.mk_tybis (StructUnionName (su, s)) [i1;i2]
>        | None, _ ->
>            ty
> -      | x -> raise (Impossible 126)
> +      (* Handle the case of combined struct definition with variable declaration *)
> +      | Some s, _ ->
> +          qu, attr, Ast_c.mk_tybis (StructUnionName (su, s)) (Common.take 2 iis)
>        )
>    | _ -> raise (Impossible 127)
>
>
>
>
> Thanks,
> Bernd
>
