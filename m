Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B372C7EE22
	for <cocci@archiver.kernel.org>; Thu, 11 May 2023 12:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=H3Ie6VFObdtyjO5I3krgxZ9Wvpw4P0htASq9cDykexI=;
  b=IJHGCQQzVzA1Fix10DwHw5ayhn4Zk8BUkhVlOXkD/LtrsinEU610h/+H
   CoGW47VOkA7cjMnvhh5RRyOmqfJ6q3OUJb2wSrwqO5adbX2yn8h2BjBde
   bMLkV+5tnRnyOi2rDQJOEptzPweq2TsQCuQztY9AlANBkcOsqZrFaXEsZ
   I=;
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
X-IronPort-AV: E=Sophos;i="5.99,266,1677538800"; 
   d="scan'208";a="107457619"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2023 14:51:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5345EE0D4D; Thu, 11 May 2023 14:51:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B060BE0D4A
	for <cocci@sympa.inria.fr>; Thu, 11 May 2023 14:51:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=H3Ie6VFObdtyjO5I3krgxZ9Wvpw4P0htASq9cDykexI=;
  b=lP12vCh2GobaZfZQqGHH9ytM6rwTNRQ7FrHlp4uxhqic7gTwbpfgpIs5
   giajqSNRALmofx/IjA+jNof0mu+KDPLH6/d/zTzKdCIA/NsyGaYtlABTq
   6KMjWuS9G1O5F3Bbb0aEFbogDPMXmzpKJAkKMPR+lrZySFcfPQdx2/3qZ
   Y=;
X-IronPort-AV: E=Sophos;i="5.99,266,1677538800"; 
   d="scan'208";a="55754491"
Received: from unknown (HELO hadrien) ([77.39.233.140])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 14:51:24 +0200
Date: Thu, 11 May 2023 14:51:23 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <20230511143209.23065a5e@nbbrfq>
Message-ID: <d054a7bd-913-1672-4c7f-923f6b651dd3@inria.fr>
References: <20230511143209.23065a5e@nbbrfq>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] parser error with loops
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1144
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/d054a7bd-913-1672-4c7f-923f6b651dd3%40inria.fr>



On Thu, 11 May 2023, Bernhard Reutner-Fischer wrote:

> Hi!
>
> I'm encountering parser errors with loops.
> Is this a known limitation that is maybe fixed already or am i doing
> something wrong?
>
> $ for i in /tmp/dummy-1.cocci /tmp/dummy.c ;do echo "# $i";cat $i;echo EOF;done
> # /tmp/dummy-1.cocci
> @ rule179 @
> expression V, IX, INDEX, VAL;
> @@
> - for (IX = 0; (IX >= vec_safe_length (V)) ? false : (((void) (VAL = (*V)[IX].value)), (INDEX = (*V)[IX].index), true); (IX)++)
> + FOR_EACH_CONSTRUCTOR_ELT (V, IX, INDEX, VAL)

Coccinelle only supports complete statements (extrassions, types, etc).
This is not a complete statement.  It is just the header of the for loop.

If you are targeting actual uses of loops, then you should be able to
solve the problem by declaring a statement metavariable S and putting a
single line wit S after your + line.

>
> EOF
> # /tmp/dummy.c
> int i;
> EOF
> $ spatch --c++=11 --smpl-spacing --in-place --sp-file /tmp/dummy-1.cocci /tmp/dummy.c
> init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
> minus: parse error:
>   File "/tmp/dummy-1.cocci", line 7, column 0, charpos = 221
>   around = '',
>   whole content =
>
> $ spatch --version | sed 1q
> spatch version 1.1.0 compiled with OCaml version 4.11.1
> # off debian
>
>
> PS: i get a similar error for other kinds of loops:
> @ rule428 @
> expression NODE, VAR;
> @@
> - do { tree var_ = (VAR); SSA_NAME_CHECK (NODE)->ssa_name.var = var_; SSA_NAME_IS_VIRTUAL_OPERAND (NODE) = (var_ && TREE_CODE (var_) == VAR_DECL && VAR_DECL_IS_VIRTUAL_OPERAND (var_)); } while (0)
> + SET_SSA_NAME_VAR_OR_IDENTIFIER (NODE, VAR)

If you are targeting a use of a do while loop, then just put a ; after
this, and all will be fine (you may need to compile the github version of
Coccinelle though).  If you are targeting the body of a macro definition,
then maybe it will work if you put the #define part first, but I odn't
know.  That is supported in the .c code, but I'm not sure if it is
supported in the semantic patch code.

julia
