Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD6BC54EE9
	for <cocci@archiver.kernel.org>; Tue, 27 Sep 2022 21:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ilzOAwwEg6TC1q7vvzzyjmsxNXIZNeuSxB9QCEEBLEI=;
  b=eycSSEC7HvdY+0k87clL6mJ+TaHJzon9MLKxoSZM/qM44jUhY5WVupV4
   vFOm0c85jFlj0xse4eojeUl5WQSzVaEOs4sX85ss3Z3WV/2J+9YXQuNou
   lJ8Pu6472J2nxWJcEzXLLV8wLkXFOKSD0ucxoriuqooc4b40mbBsixS0g
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
X-IronPort-AV: E=Sophos;i="5.93,350,1654552800"; 
   d="scan'208";a="54823984"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Sep 2022 23:09:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 47663E027C; Tue, 27 Sep 2022 23:09:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 76F22E0076
	for <cocci@sympa.inria.fr>; Tue, 27 Sep 2022 23:09:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ilzOAwwEg6TC1q7vvzzyjmsxNXIZNeuSxB9QCEEBLEI=;
  b=s0KK1GnbposXSLi9IZpvn4t5nk/fDCHcR46B5Ly8X8kaizTFDJvzjN/z
   tPp94LkZMi7VTYGcCp0wbgKqutfLC3xifohF1ddB7uK3oXxn94TiXZgj0
   0dSmSfmpQ0fe/Ww2UuWBHCZX/9ot27Xt+EAlA1N7XU9sqozXSbAtvlUsz
   A=;
X-IronPort-AV: E=Sophos;i="5.93,350,1654552800"; 
   d="scan'208";a="24847573"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 23:09:36 +0200
Date: Tue, 27 Sep 2022 23:09:35 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: cocci@inria.fr, linux-hardening@vger.kernle.org, 
    "Gustavo A. R. Silva" <gustavoars@kernel.org>
In-Reply-To: <alpine.DEB.2.22.394.2209272235060.2842@hadrien>
Message-ID: <alpine.DEB.2.22.394.2209272304030.2842@hadrien>
References: <202209260912.8DCCD70@keescook> <alpine.DEB.2.22.394.2209262259030.2915@hadrien> <202209261505.9AE38B8@keescook> <alpine.DEB.2.22.394.2209272235060.2842@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] spatch --jobs N missing matches?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 593
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209272304030.2842%40hadrien>

The running time is cut in half for the command line:

spatch ~/linux-next/fs/dlm flex2.cocci -I ~/linux-next/include

Where flex2.cocci is:

------------

#spatch --recursive-includes --include-headers

// match memcpy() which has a composite flexible array struct as the destination
@memcpy_compflex_dest@
identifier outer, compflex;
struct outer *PTR;
expression SRC, SIZE;
@@

  memcpy(
       &PTR->compflex
  , SRC, SIZE)

// "level2" matches a composite flexible array struct (struct ending with "level1")
@level2@
identifier inner;
identifier memcpy_compflex_dest.outer, memcpy_compflex_dest.compflex;
@@
        struct outer {
                ...
                struct inner compflex;
        };

// "level1" matches a struct ending in a flexible array.
@level1@
identifier level2.inner, flex;
type T;
@@
        struct inner {
                ...
                T flex[];
        };

// match memcpy() which has a composite flexible array struct as the destination
@depends on level1@
identifier memcpy_compflex_dest.outer, memcpy_compflex_dest.compflex;
struct outer *memcpy_compflex_dest.PTR;
expression SRC, SIZE;
@@

  memcpy(
*       &PTR->compflex
  , SRC, SIZE)

------------

Actually, there are not that many memcpys in the considered code.  Then
there are not that many that refer to the last element of a structure.  If
level2 produces nothing, then level 1 should not be applied.

In the original rule order, all of the pairs of a flexible structure and
any structure are considered, regardless of whether any memcpys are
present.

julia
