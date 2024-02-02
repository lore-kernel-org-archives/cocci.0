Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2214C48291
	for <cocci@archiver.kernel.org>; Fri,  2 Feb 2024 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+a5n7GtU3mL6it4Rn8kBr07aymb6TULs/prZ1lNiGms=;
  b=FoI6xyzIcBM6j7GzwVTEOr6R8fs63ssia3GYo6x+6jOyyxYq4kgzK8NV
   BiMrTdBDUQ4DCnxZRnjfk2JusWToQ8UR8MosczIsMemygJ8/cJ14HTvft
   az6CHbLK1rf7rUe5p0H228bz8eB5NkTW4c1Kw1F6uMbRn3HH3dTaWfEGB
   s=;
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
X-IronPort-AV: E=Sophos;i="6.05,238,1701126000"; 
   d="scan'208";a="150038069"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Feb 2024 18:22:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 99249E0CD7; Fri,  2 Feb 2024 18:22:05 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 59F57E008A
	for <cocci@sympa.inria.fr>; Fri,  2 Feb 2024 18:22:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+a5n7GtU3mL6it4Rn8kBr07aymb6TULs/prZ1lNiGms=;
  b=D0RnXtBDEi/E7/PEudpxXQ0k4hwF1RE5HOarp1ozmbN6GY3qE7Fgdl1d
   3gmZveVw2wRbWyKVWNlpT9dfkiRZVUEV8abHvVTgWyyIbxcSjyBFOGJQL
   HWLjqYvkbW9kNze4Nf/ugPbzPHQCH67VzJrjy/8jpvCA+QfUlru53kbJX
   U=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701126000"; 
   d="scan'208";a="78602497"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 18:22:03 +0100
Date: Fri, 2 Feb 2024 18:22:01 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Lorenz Bauer <lorenz.bauer@isovalent.com>
cc: cocci@inria.fr
In-Reply-To: <CAN+4W8jQeU70dRrEokYxomCBdM3cFmbxBe2mXnsTg4nijTJ3Sg@mail.gmail.com>
Message-ID: <bc9490c0-4998-c1d8-4971-7093902e3756@inria.fr>
References: <CAN+4W8jQeU70dRrEokYxomCBdM3cFmbxBe2mXnsTg4nijTJ3Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Refactoring C preprocessor using cocci?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1496
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/bc9490c0-4998-c1d8-4971-7093902e3756%40inria.fr>



On Fri, 2 Feb 2024, Lorenz Bauer wrote:

> Hi,
>
> I work on a codebase which has a fair amount of preprocessor usage
> (https://github.com/cilium/cilium). I'm trying to figure out whether
> we could use coccinelle to automate refactoring of said code. For
> example:
>
> #ifdef ENABLE_IPV4
> static __always_inline bool identity_from_ipcache_ok(void)
> {
>     return SECCTX_FROM_IPCACHE == SECCTX_FROM_IPCACHE_OK;
> }
> #endif
>
> Here I'd like to strip the ifdef and add an attribute __maybe_unused
> to the function definition.
>
> A more complicated example:
>
> void foo() {
> #ifdef ENABLE_SRV6
>     if (!from_host) {
>         if (is_srv6_packet(ip6) && srv6_lookup_sid(&ip6->daddr)) {
>             /* This packet is destined to an SID so we need to decapsulate it
>              * and forward it.
>              */
>             ep_tail_call(ctx, CILIUM_CALL_SRV6_DECAP);
>             return DROP_MISSED_TAIL_CALL;
>         }
>     }
> #endif /* ENABLE_SRV6 */
> }
>
> Here I'd like to remove the ifdef and transform the wrapped "natural"
> if to something like
>
>     if (is_defined(ENABLE_SRV6) && !from_host) ...
>
> Are such transformations possible with coccinelle?

I don't think so, sorry.  Coccinelle currently only allows adding #ifdefs,
but not removing them.

>
> A colleague has pointed me at --ifdef-to-if. From the description of
> the flag it sounds like I wouldn't be able to distinguish a real if
> from an ifdef?

That's only useful for #ifdefs inside a function, to get the proper
control flow (actually, Coccinelle also tries to get the proper control
flow without this option, so I'm not sure what this option does
additionally).

julia

> Thanks for your work on coccinelle!
> Lorenz
>
