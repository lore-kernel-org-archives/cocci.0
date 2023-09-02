Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335A4C83F2C
	for <cocci@archiver.kernel.org>; Sat,  2 Sep 2023 18:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=WgzL9ofYR/vCkr5SVJT4L1/CrbJuCWfZhmf8g8nhtXU=;
  b=VbQFC7+J/TGw9SI4+cQjXt7eNUBXvRAnk3DOrcoQ1Nt6/OU18V8+jh9b
   ac3cJWr5GcU/a44BA42yRMonayHe+Ab/rB7fGlVM5N5uFEbQX75/GiVhL
   r0uJyFVyxf1W5fDLDgXxvMhdaU6CqJGiwdHMkgTEa/9xQgZt1L3l7ya6K
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.02,222,1688421600"; 
   d="scan'208";a="124032095"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Sep 2023 20:33:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4015CE0CCA; Sat,  2 Sep 2023 20:33:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D9D6AE004E
	for <cocci@sympa.inria.fr>; Sat,  2 Sep 2023 20:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WgzL9ofYR/vCkr5SVJT4L1/CrbJuCWfZhmf8g8nhtXU=;
  b=IOVKdt9mmY6CfZjoKUNLBnaqrD/XCbJV8y9/+KzjIZbUlHz5cIKj4YK0
   rcGUKa+nwHT5bpyhFzQsggLGrX0+sqKvh/z9XJ+/uCqSPl6SWj7T8g16R
   OAxa2itGjgsZX9XBzNkwf4QlPjLTowwpq2tTlG5CpRM408+25HiO09Ehr
   c=;
X-IronPort-AV: E=Sophos;i="6.02,222,1688421600"; 
   d="scan'208";a="64933439"
Received: from 228.66.136.77.rev.sfr.net (HELO hadrien) ([77.136.66.228])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 20:33:46 +0200
Date: Sat, 2 Sep 2023 20:33:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Thomas Adam <thomas@fvwm.org>
In-Reply-To: <205fad47-dbef-4cfe-885b-69a2a0d4b09b@web.de>
Message-ID: <alpine.DEB.2.22.394.2309022032260.3175@hadrien>
References: <7e3fdd0f-e691-4ebd-9de9-4fbdb6ece973@web.de> <alpine.DEB.2.22.394.2309022008310.3175@hadrien> <205fad47-dbef-4cfe-885b-69a2a0d4b09b@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-61890595-1693679626=:3175"
Subject: Re: [cocci] Checking a transformation approach for the avoidance of
 duplicate code
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1232
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-09/alpine.DEB.2.22.394.2309022032260.3175%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-61890595-1693679626=:3175
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 2 Sep 2023, Markus Elfring wrote:

> >> I constructed another SmPL script variant for a desirable transformation.
> >>
> >>
> >> @replacement@
> >> statement s1, s2, s3;
> >> @@
> >> -if (tint != NULL)
> >> -{
> >> - s1
> >> - s2
> >> - cs->tint = GetColor(tint);
> >> - s3
> >> -}
> >> -else if (tint == NULL)
> >> -{
> >> - s1
> >> - s2
> >> - cs->tint = GetColor(black);
> >> - s3
> >> -}
> >> +s1
> >> +s2
> >> +cs->tint = GetColor(tint ? tint : black);
> >> +s3
> >>
> >>
> >> Now I wonder why a corresponding patch is not generated by the software
> >> “Coccinelle 1.1.1-00478-g0afff7fa” (OCaml 5.0) at the moment.
> >> I would appreciate further advices.
> >
> > Probably because in each branch, the first line is a declaration, not a statement.
>
> How does this feedback fit to other software documentation according to declaration statements?
> https://en.cppreference.com/w/cpp/language/statements#Declaration_statements

Whatever.  In Coccinelle, we decided to do it that way I said it is done.
This makes it easy to search for the first statement that is not a
declaration in a function.

julia
--8323329-61890595-1693679626=:3175--
