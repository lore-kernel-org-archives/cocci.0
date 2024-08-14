Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C765C3DA4A
	for <cocci@archiver.kernel.org>; Wed, 14 Aug 2024 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=YTjbuL0N/qhuAuFoUQnM9CwLf7UQC3k54sc3GpwUBQk=;
  b=o1LSrFVceJoQ9uvaGK/L3vFi7vdABpIfvT7V/Fhb3QZ5TBUJfRG9KTKh
   Zlc2M3pCZcLXW5+9vtHHWLoq2wxK3eMH/+5tU+HjcVdh8xj5aJBBaM4F+
   AsRo/JG4hqLc0mVstI1kfiAYiLUhBa4eJtlH1pCK3fl150b+dYm3tcNwp
   k=;
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
X-IronPort-AV: E=Sophos;i="6.09,288,1716242400"; 
   d="scan'208";a="178976939"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Aug 2024 11:45:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 984C1E013D; Wed, 14 Aug 2024 11:45:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9AAACE0035
	for <cocci@sympa.inria.fr>; Wed, 14 Aug 2024 11:44:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YTjbuL0N/qhuAuFoUQnM9CwLf7UQC3k54sc3GpwUBQk=;
  b=EdTXSU3zW7GAp4oTnaiuC6LKa7d19nhvmaesPkFUlv4u9/K+DaMJrQjF
   qdqc2qJN5cghtF0HWytBUV1kZY13AyGeu8j6lqfn2kqJWluZj6pB9Wawn
   WWsAhjb6bhaxQfqhP651pfWJhrpruMWZap7shq3Yvkzh278jicwfxSbrp
   Q=;
X-IronPort-AV: E=Sophos;i="6.09,288,1716242400"; 
   d="scan'208";a="94076639"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 11:44:58 +0200
Date: Wed, 14 Aug 2024 11:44:57 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Peter Senna Tschudin <peter.senna@linux.intel.com>
cc: cocci@inria.fr
In-Reply-To: <25273c09-ded5-4f43-82ee-956f66a8cd0e@linux.intel.com>
Message-ID: <766ee243-508e-8fe6-c1f8-247486368613@inria.fr>
References: <25273c09-ded5-4f43-82ee-956f66a8cd0e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Iterator macros
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1858
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/766ee243-508e-8fe6-c1f8-247486368613%40inria.fr>



On Tue, 13 Aug 2024, Peter Senna Tschudin wrote:

> Dear List,
>
> I am trying to make changes to a macro iterator from igt-gpu-tools*, and I am failing to use Coccinelle. My current attempt only captures about 1/2 of call sites, and I am not really sure how to ask Coccinelle to make the changes I want. Here is the pattern I am trying to change:
>
>
> From:
>
> const struct intel_execution_engine2 *e2;
> ...
> for_each_ctx_engine(i915, ctx, e2) {
>     execbuf.flags = e2->flags;
>     gem_execbuf(i915, &execbuf);
> }
>
>
> To:
>
> struct intel_engine_data ied;
> ...
> for_each_ctx_engine(i915, ctx, ied) {
>     execbuf.flags = ied.current_engine->flags;
>     gem_execbuf(i915, &execbuf);
> }
>
> Changes I want:
> 1. From `const struct intel_execution_engine2 *e2` to `struct intel_engine_data ied`.
> 2. Replace the last argument of for_each_ctx_engine() following the change on previous step.
> 3. Change references from `e2` to `ied.current_engine` inside the iterator statement.

I think that this gets at what you want.  It gives many warnings, but you
can ignore them:

@@
iterator name for_each_ctx_engine;
identifier e2;
symbol ied;
@@
- const struct intel_execution_engine2 *e2;
+ struct intel_engine_data ied;
  <+...
  for_each_ctx_engine(...,
-                      e2
+                      ied.current_engine
  ) { <...
-       e2
+       ied
      ...>
    }
  ...+>

julia
