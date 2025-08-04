Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB806C87FCF
	for <cocci@archiver.kernel.org>; Mon,  4 Aug 2025 12:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=JnvP9i8tN94SfhOKz4+kPZvrlqpWafwQ2uAfjcu9saE=;
  b=Voy94lsv7lcabQs4uNPv77bx8SA/Oxr8j8ehfK6dHAlpC9NAmWVIpb65
   JZFITPAJF91YHmDA0VkDOir7ykSV6nhALOk6+M3BOM5VkGQhcr++VjBVR
   zYEg7JYPON/pEtUs7190v9R5kRFlPht95PcIPL9xi8NDlG89bpIlEQ3oI
   w=;
X-CSE-ConnectionGUID: xPULe5DsSYyyyn3O5Tastw==
X-CSE-MsgGUID: MJSrjPtpQr6Q2ATKYSwP/g==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="234105853"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Aug 2025 14:08:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 150A7E0C55; Mon,  4 Aug 2025 14:08:49 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5E1B7E0171
	for <cocci@sympa.inria.fr>; Mon,  4 Aug 2025 14:08:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JnvP9i8tN94SfhOKz4+kPZvrlqpWafwQ2uAfjcu9saE=;
  b=VjtiFBUdEgnVs5vt9U6obkKrENlxGxQvg/WKthRSkM3LG6kFdNe2FNQg
   UyRk4h2DK2nQ4EhBpeN31nLR5lQ/fXH3O9Sevk2np0OGeDswx+xZXYLPb
   A7ROdWPGsg8y18f32zsdpq0MflmCQ8CtUts/8eIe3yva89dWl9KHFS6gm
   o=;
X-CSE-ConnectionGUID: 9OT9PQCMSLKjzbGDCRG3Rw==
X-CSE-MsgGUID: u6ramkfZT8iJmE4NVF0sGA==
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="122740255"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 14:08:46 +0200
Date: Mon, 4 Aug 2025 14:08:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Lyude Paul <lyude@redhat.com>
cc: cocci@inria.fr
In-Reply-To: <4e009fd868cbb48aa802ce472715b5ffd7bcabac.camel@redhat.com>
Message-ID: <c48dac46-e4e6-ae5b-fa26-c9ab7cd52d50@inria.fr>
References: <4e009fd868cbb48aa802ce472715b5ffd7bcabac.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] spatch really could use a --keep-going
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2961
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/c48dac46-e4e6-ae5b-fa26-c9ab7cd52d50%40inria.fr>



On Mon, 28 Jul 2025, Lyude Paul wrote:

> An issue that I've hit with coccinelle a number of times now is that despite
> being a semantic patching tool, it actually can be really painful at times
> trying to get it to do transformations across the entire kernel source.
>
> One example:
>
> @depends on patch@
> @@
> (
> - local_irq_disable();
> + local_interrupt_disable();
> |
> - local_irq_enable();
> + local_interrupt_enable();
> )
>
> I've been trying to run this rule to run experiments with a potential new API
> we've been working on in the Linux kernel to make interrupt enable/disable
> refcounted. The problem is this rule fails in exactly one spot:
>
> EXN: Failure("./lib/locking-selftest.c: 199: try to delete an expanded token:
> local_irq_enable") in ./lib/locking-selftest.c
>
> Which happens because it gets tripped up on this line:
>
> #define HARDIRQ_DISABLE		local_irq_disable
> #define HARDIRQ_ENABLE		local_irq_enable
>
> Now - I'm sure there is a way I could actually properly fix the rule I've
> written. But - I don't think I actually should need to do that. The reality is
> I've hit quite a number of situations like this where I simply can't use the -
> -dir option in spatch across the kernel because a single file in the kernel
> tree breaks spatch. And a lot of times I hit this I'm trying do one-off
> conversions where I really do not do much but waste time trying to workaround
> issues like this since the rules I'm writing will probably never be run again.
>
> Which brings me to ask: could we have a --keep-going option? The idea is very
> simple: don't stop performing transformations if coccinelle hits an error,
> simply either ignore and continue - or simply skip the one file that failed
> and continue. I'd love to add something like this myself but despite doing
> kernel development for over a decade I honestly cannot wrap my head around
> ocaml source at all.

Are you using --in-place?

What version of Coccinelle do you have?

At one point, someone argued that if there was an error anywhere then
Coccinelle should refuse to do transformations everywhere.  This was
implemented for a time, but it is very inconvenient in practice.  So it
was removed for the oriinary behavior, but it seems that it may have been
maintained when the --in-place argument is used.

If you are currently using --in-place, maybe you can just stop using that
argument.  Standard output will be a patch, so you can put it in a file
and apply it (or remove any parts that seem unsuitable and then apply it).

In your specific case, the issue seems to be that some function was not
able to be parsed, and so the HARDIRQ_DISABLE or HARDIRQ_ENABLE was
expanded at some usage site.  The macro definition itself doesn't cause a
problem, but an occurrence of HARDIRQ_DISABLE() in a function that doesn't
parse could cause a problem.  I will take a look.

julia
