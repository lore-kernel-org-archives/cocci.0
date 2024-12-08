Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B6CE77173
	for <cocci@archiver.kernel.org>; Sun,  8 Dec 2024 09:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=daK7Lkba+oTZKWTxiVYOMctUZUOnDf3MCXSzieKXU68=;
  b=lBTA0wpUP9CRdkqL6cA1xpHUg7/wqzcP2Tm8veMQAJguzhkMlZC2jaoe
   kZCjoOGI5PLATMQ+NkPW9BhAmfRUUfTlu4ik+z3obm96DeaAj9XTzQoHV
   iCzgjHnONuZHfkwh0GVH7fQlBCxUb5V74SBknWF23J/MRk1KM765wakqE
   A=;
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
X-IronPort-AV: E=Sophos;i="6.12,217,1728943200"; 
   d="scan'208";a="197934079"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Dec 2024 10:47:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6EFE0E0D1D; Sun,  8 Dec 2024 10:47:21 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D0948E00B6
	for <cocci@sympa.inria.fr>; Sun,  8 Dec 2024 10:47:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=daK7Lkba+oTZKWTxiVYOMctUZUOnDf3MCXSzieKXU68=;
  b=Pog5A6Z7QuIO0eVITfcG5myjsIjCeH8XthbkLxboidly/6K5TJX37ZyZ
   fNkHzIPNFvLvfsCrlUXsM/GZz2pSlR8USgJchI/d3IMdDfUD1mRuA0/dJ
   gdGAU7UBIymjBNoY0QW1FVTMPaOlX8BNXrSiWCEemakCWfDGQKhFvJqgk
   s=;
X-IronPort-AV: E=Sophos;i="6.12,217,1728943200"; 
   d="scan'208";a="197934076"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 10:47:16 +0100
Date: Sun, 8 Dec 2024 10:47:16 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Zack Rusin <zack.rusin@broadcom.com>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <CABQX2QOb9C4G3Kejo_ght3Dgo0qxHW5A6it4GB6TdgoU0Bo7sQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2412081042370.3332@hadrien>
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com> <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr> <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com> <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de>
 <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com> <1995b696-6825-a144-fcb-c5f9f3b1094@inria.fr> <CABQX2QOb9C4G3Kejo_ght3Dgo0qxHW5A6it4GB6TdgoU0Bo7sQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Replacing type names
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2165
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/alpine.DEB.2.22.394.2412081042370.3332%40hadrien>

> No worries, like I said, it's not a big issue. I don't quite
> understand what you mean by "match the function definition". I need to
> match basically every non-keyword in a c file, because everything
> needs to be renamed: types (i.e. struct names and typedefs), variables
> (global, local, static, const...), struct members, function names
> (both in the definition and declaration) plus all parameters (types
> and variable names) in signatures of those files. Every one of them
> needs to be renamed.
>
> With:
> @types@
> type t;
> position p : script:python(t) { needs_rename(t) };
> @@
>
> t@p
>
> @script:python adjustment@
> input << types.t;
> p << types.p;
> updated;
> @@
> coccinelle.updated = cocci.make_type(camel_to_snake(input))
> @replacement depends on types@
> type adjustment.updated, types.t;
> position types.p;
> @@
>
> -t@p
> +updated
>
> structs are replaced three times, which is the first issue. Then:
>
> @vars@
> idexpression func;
> fresh identifier func_name = script:python(func) { camel_to_snake(func) };
> position p : script:python(func) { needs_rename(func) };
> @@
>
> -func@p
> +func_name
>
> doesn't match the function name in definition/declaration or the names
> of parameters in signatures. And even if it did I'm unclear how would
> I go about replacing it (i.e. I'm assuming this is where the
> metavariable would come in because there's no cocci.make_parameter so
> I'd probably have to use cocci.make_expr or such and then somehow
> replace the parameter list with a metavariable that's really an
> expression?)

Function name:

@r1@
identifier i : script:python(t) { needs_rename(i) };
@@

i(...) { ... }

@script:python adjustment_fnname@
...
@@
...

@@
identifier r1.i, adjustment_fnname.updated;
@@

- i
+ updated
  (...) { ... }

Parameter name:

@r2@
identifier fn;
type T;
identifier i : script:python(t) { needs_rename(i) };
@@

fn(..., T i,...) { ... }

@script:python adjustment_paramname@
...
@@
...

@@
identifier r2.i, adjustment_paramname.updated;
@@

fn(...,
   T
-  i
+  updated
   ,...) { ... }


julia
