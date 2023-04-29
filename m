Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC51C77B7C
	for <cocci@archiver.kernel.org>; Sat, 29 Apr 2023 13:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=yLEDInCcGAly2RGG+jVvgxmq7Afgkgu0mpk0j7JFRXQ=;
  b=jpzxc0UYZmrPQx5kRHu3BcLTx+qxo639jAXRwacjfPH5NS7sTFUv7lNJ
   QLvEgvcsyn9GoiNQB3OyCMJIk6KFVV4AWMZ8H8fDK17xcvSaHvTu3jw1Q
   8UaqaBD8HZeoUL+Cl8t92DG4yrb4HramJAE03vpav/qG/oWSMW07IqOYt
   w=;
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
X-IronPort-AV: E=Sophos;i="5.99,237,1677538800"; 
   d="scan'208";a="105523768"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Apr 2023 15:17:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5F55DE0D49; Sat, 29 Apr 2023 15:17:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 57018E0D40
	for <cocci@sympa.inria.fr>; Sat, 29 Apr 2023 15:17:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yLEDInCcGAly2RGG+jVvgxmq7Afgkgu0mpk0j7JFRXQ=;
  b=t7yPKCS6DyQXzYx8kE7835AlAiezc6se6RTTXCEMyi4+TUDLCZ4EQcPM
   Ja0E9/p5h1NCVC7iEHqwj+gPYb4xGQjy+GWp7HIol5mCTlRxrsGlsx4Z6
   SPEbb8sMyqmhor7b4OsegUy09YfrT4/C6FdsmIsWA1oSmlUpOO+VtKaX7
   8=;
X-IronPort-AV: E=Sophos;i="5.99,237,1677538800"; 
   d="scan'208";a="54696261"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 15:17:42 +0200
Date: Sat, 29 Apr 2023 15:17:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: cocci@inria.fr
In-Reply-To: <644ae01c.170a0220.77675.8ed2@mx.google.com>
Message-ID: <alpine.DEB.2.22.394.2304291516550.2899@hadrien>
References: <644ae01c.170a0220.77675.8ed2@mx.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] metavariables in added attribute arguments
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1136
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/alpine.DEB.2.22.394.2304291516550.2899%40hadrien>



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

The problem is fixed.  Actually, attributes in this position were just not
supported at all.  Thanks very much for the report.

julia
