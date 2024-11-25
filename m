Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31813D58D64
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=MPrKq6yQTLv+Rpzq6evVtFLawduQlfAWnWF5gKX9/r0=;
  b=ht68AaNPL+M8y0+sKGffhr44h4CUvrYlZfD4JzFx2NnBOHmG+5E4MMEN
   dJTrpJlP7TAAr+LZaiSEDmQ/ahfkcKtvqFp+K6A3Sn5f9M+rSpOHflJx3
   30l9Su8aP4djUrmFWDnI0bHFeYK4RXXyIclutWDOc2SBJ643WrM267Nym
   c=;
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
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195716527"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:23:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A6910E0D1D; Mon, 25 Nov 2024 17:23:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4D0C1E00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 17:23:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MPrKq6yQTLv+Rpzq6evVtFLawduQlfAWnWF5gKX9/r0=;
  b=YmRAmYLPlVeo01oKHjrACiUq0ZJjeziiBWKAN9KwBSPv3jzLn2Lya7WD
   iKlNcfGLOvskMSZVKoKkYRW1r825DIt+ukj3s/qTedFmi3yYEC6QfsKSL
   RoagVpdNxyVVQPzCCc49DbzJ4hVR5R+zbFtpfZvHSRye52dZvbyPUB/1u
   U=;
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195716521"
Received: from unknown (HELO hadrien) ([137.54.125.254])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 17:23:06 +0100
Date: Mon, 25 Nov 2024 11:23:05 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <100663c2-6281-49cb-bb9f-55656dff80ca@web.de>
Message-ID: <d05cde6b-6189-4c2-a452-a0851430dcb@inria.fr>
References: <434d257c-f0a5-483d-9fcb-3303301ad867@web.de> <9e8d6626-f8a2-19a7-33d3-b0cc48d2fa68@inria.fr> <100663c2-6281-49cb-bb9f-55656dff80ca@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-474768664-1732551787=:3314"
Subject: Re: [cocci] Reconsidering application of selected SmPL isomorphisms
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2101
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/d05cde6b-6189-4c2-a452-a0851430dcb%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-474768664-1732551787=:3314
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 25 Nov 2024, Markus Elfring wrote:

> > The generated code indeed does not look ideal.  But it won't cause any
> > wrong matches.
>
> I got the impression that I would need to disable the isomorphism “paren”
> for the desired use case.
>
>
>
> >                 The isomorphisms are applied on the ASTs, not on the soure code.
>
> I remember other description approaches.
> Are isomorphisms usually mapped to SmPL disjunctions?

Yes.  That is orthogonal to what I am saying.  My point is that the way
that you see the code printed does not correspond to the actual internal
parse tree.  The internal parse tree is the same as the original one, but
with the parentheses removed.  There is no C source code that generates
such a parse tree, so the generated disjunction branch will not match
anything.

Some effort is made to accomodate !, but only when the isomorphism
contains ! applied to a metavariable, not for ! applied to more
complicated things.

>
>
> >        So there will be a tree with a ! at the root and a || as the
> > argument that will not match any possible source code.
> >
> > Maybe it would be better to add isomorphisms for the de Morgan laws rather
> > than adding some hacks into the generic isomorphism transformation to take
> > this issue into account.
>
> I am looking for further software extensions.
>
> * I would occasionally like to restrict the source code search to pointer expressions.

expression *e;

> * Specifying a varying (or even unlimited) number of items for discussed boolean operators

  e1 || ...

julia
--8323329-474768664-1732551787=:3314--
