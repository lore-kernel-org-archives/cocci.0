Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DCEC4167B
	for <cocci@archiver.kernel.org>; Sat, 10 Dec 2022 09:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=CrWjgPfjOcTLBAfvYmk8MyXzZ5Sm6t506kEExRl0tKE=;
  b=dUD/vGjzp6zVvAQruChKg2udtF3P/Cd/cs2IfY4eG2D+GqIbAddVE7Z0
   +4BQfQ6gJXftmMM20+q8SWS+79ViR9f187nn3LVKAgpYc26zTq97jVyB2
   Z0dGVNOBPJ4MkIqgEOq970ZMgOClgOU4fUt2HpnOvrDJDOalXhsqaXsaK
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
X-IronPort-AV: E=Sophos;i="5.96,232,1665439200"; 
   d="scan'208";a="82734900"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Dec 2022 10:31:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F20B0E0128; Sat, 10 Dec 2022 10:31:58 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D9BCCE0128
	for <cocci@sympa.inria.fr>; Sat, 10 Dec 2022 10:31:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CrWjgPfjOcTLBAfvYmk8MyXzZ5Sm6t506kEExRl0tKE=;
  b=Slx3UrMUO47u09gXOnXmCX7ya/XtGzUwsvEYLt92HKC6kt5vdtOLvaCE
   QSckWbuYLK/6KMutar9rUQEPWv7uI6gfj0S6ikp6IuSzFmlfJT/4vlk+a
   DyYN+RK8KHurQbTcrtkRA2L4CDpbkmSm8j47xRWK7NXsDl5Wp6gyJgsh4
   Q=;
X-IronPort-AV: E=Sophos;i="5.96,232,1665439200"; 
   d="scan'208";a="42278394"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 10:31:56 +0100
Date: Sat, 10 Dec 2022 10:31:55 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jonathon Reinhart <jonathon.reinhart@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAPFHKzf2pDTK_O9_m23D4R0ryFknAy_bjSSdLsu+ujJcZYCcdg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2212101031141.3052@hadrien>
References: <CAPFHKzf2pDTK_O9_m23D4R0ryFknAy_bjSSdLsu+ujJcZYCcdg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Converting strncmp() to strcmp(): constraint on
 variable cannot be evaluated due to disjunction
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 773
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/alpine.DEB.2.22.394.2212101031141.3052%40hadrien>



On Sat, 10 Dec 2022, Jonathon Reinhart wrote:

> Hello, I've been using Coccinelle for about 2 hours :-)
>
> I'm trying to write a patch to convert strncmp() to strcmp() in the case where
> the author didn't actually want "starts with" behavior, e.g.:
>
>     - strncmp(foo, "literal", 7)
>     + strcmp(foo, "literal")
>
> (In fact I was quite excited to find
> https://github.com/coccinelle/coccinellery/blob/master/strsize/strsizeof.cocci
> but it didn't actually do what it claimed.)
>
> I was pleased to get something like this to work:
>
>     @initialize:python@
>     @@
>     def string_literal_len(sl):
>         if not (sl.startswith('"') and sl.endswith('"')):
>             raise Exception('String literal not enclosed with double quotes')
>         return len(sl) - 2
>
>
>     @@
>     expression x;
>     constant char[] literal;
>     constant int n : script:python(literal) { string_literal_len(literal) > 0 };
>     @@
>
>     - strncmp(x, literal, n)
>     + strcmp(x, literal)
>
> However, when I tried to adjust this to also handle the case where the literal
> is in the first argument:
>
>     (
>     - strncmp(x, literal, n)
>     + strcmp(x, literal)
>     |
>     - strncmp(literal, x, n)
>     + strcmp(literal, x)
>     )
>
> I get the following error which I can't really understand:
>
>     init_defs_builtins: /usr/lib/coccinelle/standard.h
>     rule starting on line 9: constraint on variable n cannot be evaluated in
>     line 15 due to disjunction
>
>     (
>     -strncmp
>       >>> strcmp(x, literal)
>     -(-x-, -literal-, -n-)
>     |
>     -strncmp
>       >>> strcmp(literal, x)
>     -(-literal-, -x-, -n-)
>     )
>
> Why can't the constraint apply to n in both cases?

Because the implementation of constraints is very conservative.  Just make
two rules.

julia

>
> Can someone let me know if I'm on the right path here? Examples with
> constraints are scarce, and I haven't found any examples of using Python script
> constraints on a normal (non-position) metavariable.
>
> I also have some other patches to handle arguments like strlen("foo") and
> sizeof("foo") (which is wrong).
>
> Thank you,
> Jonathon
>
