Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C01C433FE
	for <cocci@archiver.kernel.org>; Wed,  2 Nov 2022 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ECpukvRfSlSAAS6C+BReorcNu7ueqnIy1mSWR/nYm6c=;
  b=g4Z8CYEgCrbtjdDAfdxIk8Y/PNLu86GwvH7c7wuTSRhE0WtbMOxloVLE
   3hRM7w1AxfvyWHwJcl57Sivwp34ZXkdBZ1tYYlB7HDhLKx+6UECUDre7M
   oRDShcXQ5LIS0toyVI838DpReKzCxT1/Jtd8UsLauXW9uF4582c1MM8w5
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.95,234,1661810400"; 
   d="scan'208";a="72703400"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Nov 2022 18:30:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4B386E0307; Wed,  2 Nov 2022 18:30:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3F9D6E002A
	for <cocci@sympa.inria.fr>; Wed,  2 Nov 2022 18:30:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ECpukvRfSlSAAS6C+BReorcNu7ueqnIy1mSWR/nYm6c=;
  b=qkWMmb25a+Y6+oSFwUaPh2XtTVVZ6qj98G13/jnxgs+nvxXYmo/U7MDV
   azMvc5UgT3SDR7NHF66NkYBBdKLzgJutjKAsbIANfI97oZaV/7QTTbv1r
   E7JPQvoS86MTk9P7DtcQjdBsmKQLoXlJ29AGPR5TVROO3JWDNvC7dj1IN
   Y=;
X-IronPort-AV: E=Sophos;i="5.95,234,1661810400"; 
   d="scan'208";a="36292523"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 18:30:24 +0100
Date: Wed, 2 Nov 2022 18:30:23 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sebastiano Miano <mianosebastiano@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAMENy5qK-KB1_D-zgh=UyLarKVaup-J0yRdZwTL-fkyn_gQhJg@mail.gmail.com>
Message-ID: <af27585c-14bc-922e-73bf-b4e1dd83533d@inria.fr>
References: <CAMENy5qK-KB1_D-zgh=UyLarKVaup-J0yRdZwTL-fkyn_gQhJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Replace custom function multiple times
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 699
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/af27585c-14bc-922e-73bf-b4e1dd83533d%40inria.fr>



On Wed, 2 Nov 2022, Sebastiano Miano wrote:

> Hello,
>
> I am trying to use Coccinelle to replace a function that is called
> multiple times in the code with a different version whose name is
> taken from the string variable that is passed as the second parameter.
>
> To explain better, my C code is the following:
>
> #include <string.h>
>
> static int process(__u64 off) {
>   MERGE_FUNCTION_OPENED("file.c", "ping_pong", arg1, arg2, arg3, arg4, NULL);
>   MERGE_FUNCTION_OPENED("file2.c", "ping_pong2", arg1, arg2, arg3, NULL);
>   return 0;
> }
>
> I want my code to be transformed into the following version:
>
> #include <string.h>
> #include "file.h"
>
> static int process(__u64 off) {
>   ping_pong(arg1, arg2, arg3, arg4, NULL);
>   ping_pong2(arg1, arg2, arg3, NULL);
>   return 0;
> }
>
> where the string that is passed as the second parameter is used as the
> function name, and all the other arguments are copied as they are.
>
> I managed to write a working cocci script (listed below) that is doing the job.
>
> @merge_annotation@
> expression path, fn;
> @@
>
> MERGE_FUNCTION_OPENED(path, fn, ...);
>
> @script:python merge_p@
> path << merge_annotation.path;
> fn << merge_annotation.fn;
> new_fn;
> include_name;
> @@
> print "Obtained path: %s and file name: %s" % (path,fn)
> coccinelle.new_fn = cocci.make_expr(fn.strip('\"'))
>
> import os
> pre, ext = os.path.splitext(path.strip('\"'))
> p = "%s.h" % (pre)
>
> coccinelle.include_name = cocci.make_ident("\n#include \"%s\"" % (p))
>
> @c@
> expression merge_p.new_fn;
> expression E1, E2;
> expression list E3;

The problem is here.  You don't put any constraints on the arguments of
MERGE_FUNCTION_OPENED, so both new variables (ping_pong and ping_pong2)
affect both calls.  You should use merge_annotation.path and
merge_annotation.fn to be sure to get only the calls that are related to
the new names you have made.

julia

> @@
> - MERGE_FUNCTION_OPENED(E1, E2, E3);
> + new_fn(E3);
>
> @add_include depends on c@
> identifier merge_p.include_name;
> @@
>
> #include <...>
> + include_name
>
> Unfortunately, this script works only when a single instance of the
> MERGE_FUNCTION_OPENED(...) function is used. When I use both of them I
> get a "c: already tagged token:" error.
> Using "++" instead of "+" removes the error, but produces a code that
> contains 2 calls to the ping_pong function, and 2 calls to the
> ping_pong2 function.
> Any ideas on how to solve this issue?
>
> Thanks in advance,
> Sebastiano
>
