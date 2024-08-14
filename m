Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56D0C3DA4A
	for <cocci@archiver.kernel.org>; Wed, 14 Aug 2024 06:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=LZvS8RBl/4ak+OpcrLQgUO9xv+QFT9R5lQscQtwrs1E=;
  b=Pg0SQCBKMcvTdxpUbTWKoqc6RZhSiQM71yLAJ90ETHMeUanQcyBJtZSd
   outuGpuMJP0M4rbzqqQYCJnveiLvLvQXmxWuSnCUmgvOfwFe2NfFtZXyu
   6F9at2ShNH95x0eDIvemJnwdmle1v3ZGSu0zvVxznVf63vJF/rd51E4pS
   g=;
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
   d="scan'208";a="178950288"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Aug 2024 08:22:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 98757E0145; Wed, 14 Aug 2024 08:22:44 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CB3F7E0035
	for <cocci@sympa.inria.fr>; Wed, 14 Aug 2024 08:22:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LZvS8RBl/4ak+OpcrLQgUO9xv+QFT9R5lQscQtwrs1E=;
  b=LoSq7W2xMfGr73YhrtoU6YsQ2qa1i6izUH1Z2pe1mWEEXBzj6BoiT2Ji
   amslB09GX18RdKtYMQKkpJpLAsPChYnNilUWZ10U5WICj+7XUgmJqnnPY
   dNcgq2AOZzWxsrRUZaroPLqOi6eU3IjQAYwov3Lfg+efoieHJxkkDYsRE
   8=;
X-IronPort-AV: E=Sophos;i="6.09,288,1716242400"; 
   d="scan'208";a="94063766"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 08:22:39 +0200
Date: Wed, 14 Aug 2024 08:22:37 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Peter Senna Tschudin <peter.senna@gmail.com>
cc: Peter Senna Tschudin <peter.senna@linux.intel.com>, cocci@inria.fr
In-Reply-To: <CA+MoWDqM33yLEsm2YB8WJeGmUunHaHXDHsT56pEOhLWK5-RHAQ@mail.gmail.com>
Message-ID: <3d767045-6e18-fb44-c5bd-1728425e7fd4@inria.fr>
References: <25273c09-ded5-4f43-82ee-956f66a8cd0e@linux.intel.com> <a474269f-f8b9-e7eb-90c5-fdbc4f3495a4@inria.fr> <CA+MoWDqM33yLEsm2YB8WJeGmUunHaHXDHsT56pEOhLWK5-RHAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1495628719-1723616558=:3440"
Subject: Re: [cocci] Iterator macros
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1853
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/3d767045-6e18-fb44-c5bd-1728425e7fd4%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1495628719-1723616558=:3440
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 13 Aug 2024, Peter Senna Tschudin wrote:

> Hi Julia,
>
>
>
> On Tue, Aug 13, 2024 at 8:19 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>       On Tue, 13 Aug 2024, Peter Senna Tschudin wrote:
>
>       > Dear List,
>       >
>       > I am trying to make changes to a macro iterator from igt-gpu-tools*, and I am failing to use Coccinelle. My current attempt only captures about 1/2 of call sites, and I am not really sure how
>       to ask Coccinelle to make the changes I want. Here is the pattern I am trying to change:
>       >
>       >
>       > From:
>       >
>       > const struct intel_execution_engine2 *e2;
>       > ...
>       > for_each_ctx_engine(i915, ctx, e2) {
>       >     execbuf.flags = e2->flags;
>       >     gem_execbuf(i915, &execbuf);
>       > }
>       >
>       >
>       > To:
>       >
>       > struct intel_engine_data ied;
>       > ...
>       > for_each_ctx_engine(i915, ctx, ied) {
>       >     execbuf.flags = ied.current_engine->flags;
>       >     gem_execbuf(i915, &execbuf);
>       > }
>       >
>       > Changes I want:
>       > 1. From `const struct intel_execution_engine2 *e2` to `struct intel_engine_data ied`.
>       > 2. Replace the last argument of for_each_ctx_engine() following the change on previous step.
>       > 3. Change references from `e2` to `ied.current_engine` inside the iterator statement.
>       >
>       > Here is my starting point that finds about half of the call sites:
>       >
>       > @r1@
>       > iterator I =~ "for_each_ctx_engine";
>       > statement S;
>       > @@
>       > * I(...)
>       > S
>       >
>       > I assume that I should create other rules and import I from r1 as the
>       > core of the changes I want. Can you point me to an example to help me
>       > here?
>
>       Are you just looking for
>
>       iterator r.I;
>
>       If you have only one iterator name, you don't need the regexp.  Just put
>
>       iterator name for_each_ctx_engine;
>
> Thank you! This is much faster but captures one instance less.

Which one are you missing?  I downloaded the code and tried it, and I got
exactly the same results with both semantic patches, with the one with
iterator name being 3x faster (19 seconds -> 6 seconds).

julia

>  
>
>       julia
>
>       >
>       > Thank you,
>       >
>       > Peter
>       >
>       > * - https://gitlab.freedesktop.org/drm/igt-gpu-tools
>       >
>
>
>
> --
>                          Peter
>
>
--8323329-1495628719-1723616558=:3440--
