Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B3BC52D7B
	for <cocci@archiver.kernel.org>; Tue, 13 Aug 2024 06:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Uw0ylVY4I+eh0GREwHkQ7WyD9AW6njpG0cIUswxQSXI=;
  b=faAfZpFQvEkM32UlNcyZBX33ToOI5tX7i8Gw6n0MPDlVAM64CmQlBPuD
   vcqmluk5wHffXAWaZGZ/Z9dKoPQVY6Z/j5Ovc197qb1pKIoswHpAOAx7O
   vyFYPAyAMtOumsLk9vEbqe0J7PdAQ5XC9cTJPHosT0vo+hRHVe6alEbts
   E=;
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
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="178838733"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Aug 2024 08:19:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E4C98E0133; Tue, 13 Aug 2024 08:19:45 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7198DE0035
	for <cocci@sympa.inria.fr>; Tue, 13 Aug 2024 08:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Uw0ylVY4I+eh0GREwHkQ7WyD9AW6njpG0cIUswxQSXI=;
  b=r4EKvOhuR7rFfV+O7GgCdn49Ppg70PpfX9DV5Jk3n7V1EzCeIDakpwUd
   afpvfRjMrRyTo8jMS2FdHuMfxcRBME2I8VUefou8VY8V9gw342Cq4/LPj
   N5/5/LrW+Jgnvx6H5OqLqSNoZ8ByVOlxYyhBeNVw3jG2r47kppA8SgvfW
   Y=;
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="178838730"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 08:19:43 +0200
Date: Tue, 13 Aug 2024 08:19:42 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Peter Senna Tschudin <peter.senna@linux.intel.com>
cc: cocci@inria.fr
In-Reply-To: <25273c09-ded5-4f43-82ee-956f66a8cd0e@linux.intel.com>
Message-ID: <a474269f-f8b9-e7eb-90c5-fdbc4f3495a4@inria.fr>
References: <25273c09-ded5-4f43-82ee-956f66a8cd0e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Iterator macros
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1848
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/a474269f-f8b9-e7eb-90c5-fdbc4f3495a4%40inria.fr>



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
>
> Here is my starting point that finds about half of the call sites:
>
> @r1@
> iterator I =~ "for_each_ctx_engine";
> statement S;
> @@
> * I(...)
> S
>
> I assume that I should create other rules and import I from r1 as the
> core of the changes I want. Can you point me to an example to help me
> here?

Are you just looking for

iterator r.I;

If you have only one iterator name, you don't need the regexp.  Just put

iterator name for_each_ctx_engine;

julia

>
> Thank you,
>
> Peter
>
> * - https://gitlab.freedesktop.org/drm/igt-gpu-tools
>
