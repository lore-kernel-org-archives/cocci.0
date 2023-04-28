Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77597C77B61
	for <cocci@archiver.kernel.org>; Fri, 28 Apr 2023 08:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=XIefcdrOyGEbEBZaCVdCC5QeV6QdvR1COeTpCigDH5w=;
  b=reZ6IWNohPvwujnXH2c3nVpQ0Lb60IzcRzQeNm4HCac7sT3rhLgHEzMH
   gGhX947FkYy+xVjinYzAfdPnGRzKBBNVP2r6yfmG//vqmSZnGQiiIPJo0
   /ho2EIMcHiDJTN1wZjem9c+L8p4ql3dwYxNnRRZaxOU7DKIN/sKXR28CP
   0=;
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
X-IronPort-AV: E=Sophos;i="5.99,234,1677538800"; 
   d="scan'208";a="105370247"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Apr 2023 10:18:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9ECEFE0D49; Fri, 28 Apr 2023 10:18:51 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5A402E0D40
	for <cocci@sympa.inria.fr>; Fri, 28 Apr 2023 10:18:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XIefcdrOyGEbEBZaCVdCC5QeV6QdvR1COeTpCigDH5w=;
  b=PDPyr7Ni0bIOiN3NFkVqD+XYAKO5Nj067AApfWUXIsRECGyyTwErFPeg
   Lv//TJmK/D8S9+rAHISILytalaz/3I3LL9KtvLaGFz+BOjestEQSeqsP3
   cDT1yGwR8294LXIs/0EEmwvjZB9DXQvRKJlPHxIqv5Lf23ts0Rd328Brj
   s=;
X-IronPort-AV: E=Sophos;i="5.99,234,1677538800"; 
   d="scan'208";a="105370231"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 10:18:47 +0200
Date: Fri, 28 Apr 2023 10:18:47 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Kees Cook <keescook@chromium.org>
cc: cocci@inria.fr
In-Reply-To: <644ae01c.170a0220.77675.8ed2@mx.google.com>
Message-ID: <b8857825-199f-cdbd-93cb-83703ea78385@inria.fr>
References: <644ae01c.170a0220.77675.8ed2@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] metavariables in added attribute arguments
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1134
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/b8857825-199f-cdbd-93cb-83703ea78385%40inria.fr>



On Thu, 27 Apr 2023, Kees Cook wrote:

> Hello,
>
> I am trying to annotate structures with a new attribute that identifies
> which struct member contains the count of elements for a given flexible
> array member:
>
> struct foo {
> 	...
> 	size_t element_count;
> 	...
> 	int element_array[];
> };
>
> becomes:
>
> struct foo {
> 	...
> 	size_t element_count;
> 	...
> 	int element_array[] __counted_by(element_count);
> };
>
> From the grammar doc, I found this note: "Attribute metavariables are
> only allowed in context or minus code, and not in added code". I would

Sorry, but the documentation is quite out of date in that regard.
Attribute metavariables are supported everywhere now.

> expect that to only apply to the name of the attribute itself, but
> that's not what I'm trying to do. Here is the .cocci file:
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
> @@
>
>  struct STRUCT {
>         ...
>         COUNTER_TYPE COUNTER;
>         ...
>         ARRAY_TYPE ARRAY[]
> +       __counted_by(COUNTER)
>         ;
>  };
>
> This fails like so:
>
> $ cocci element_count.cocci net/packet/af_packet.c
> plus: parse error:
>   File "element_count.cocci", line 33, column 15, charpos = 593
>   around = 'COUNTER',
>   whole content = +     __counted_by(COUNTER)
>
> But I can produce (nonsense) output if I change the replacement to:
>
> 	ARRAY_TYPE ARRAY[
> +	COUNTER
> 	]
> +	__counted_by
> 	;
>
> Explicitly using "attribute name __counted_by;" didn't seem to help.
> What am I missing?

I'll look into it.  There has been a lot of work on attributes recently,
but I was focusing on individual names, and not things with arguments, so
something may have been overlooked.

julia

>
> Thanks!
>
> -Kees
>
> --
> Kees Cook
>
