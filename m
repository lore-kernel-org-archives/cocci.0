Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1819EC83F22
	for <cocci@archiver.kernel.org>; Sun, 20 Jul 2025 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/sEk5AcMiIJ+94Kwx8kra5uHPHJD9+r19p4W7KnqR3U=;
  b=quU+Wq+FRdx+T3vOKIb1Y9lL0mO2Z6yh+Fe6F0WE6209BfbyEkqu3pd5
   m9QJHlE5tLy20XMb8M4bO7QsfTz+6fFSl6+hbIOHwRrq10ATW8OpTg0Fr
   MEUEys6OOs+MnmMTaVBtEZuD6qonVn/NVH3mDLiiGH25oI72Fh5VJeu/O
   w=;
X-CSE-ConnectionGUID: sNlY94BpQzieoucQwjpyrg==
X-CSE-MsgGUID: pzxfkohbRji4/2QmdAGX6Q==
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
X-IronPort-AV: E=Sophos;i="6.16,327,1744063200"; 
   d="scan'208";a="232356668"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jul 2025 16:10:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1B952E0172; Sun, 20 Jul 2025 16:10:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6B224E0171
	for <cocci@sympa.inria.fr>; Sun, 20 Jul 2025 16:10:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/sEk5AcMiIJ+94Kwx8kra5uHPHJD9+r19p4W7KnqR3U=;
  b=SAlkaD2VPkW6ZoDjYuykamd2dCSjLOPlVXtEEqLTCPfDjcp0r4qnUDK+
   AaqHv0XqgHGjfFMMbTtQ1L86UM0MlnZ+bxYris0SaK+S3BVLykBjk10Vr
   sdLpid5sJ2GPPj+ai783X1E9IVAi82o5uT0YQeemUuxX7YrlOKbNJQuHW
   s=;
X-CSE-ConnectionGUID: SX9xTy6KRqyh9xVwJjn4dQ==
X-CSE-MsgGUID: 8fF1gLIWTPWmtbxxbFjtyg==
X-IronPort-AV: E=Sophos;i="6.16,327,1744063200"; 
   d="scan'208";a="121787528"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 16:10:09 +0200
Date: Sun, 20 Jul 2025 16:10:08 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de>
Message-ID: <alpine.DEB.2.22.394.2507201608390.3477@hadrien>
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de> <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr> <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-50656197-1753020609=:3477"
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2879
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/alpine.DEB.2.22.394.2507201608390.3477%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-50656197-1753020609=:3477
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 20 Jul 2025, Markus Elfring wrote:

> >> Another corresponding file contains a todo tag.
> >> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/2548098a0c8b148555f4bf11a12898ecaf023dea/standard.iso#L382-397
>
> How do you think about to discuss corresponding imaginations?

Te TODO has to do with sizeof.  Why is it relevant to the general problem
of reducing parentheses?

It's not clear whether you want to reduch parentheses in the semantic
patch (the only thing that is affected by an isomorphism) or in the C
code.

julia

 >
>
> >> It seems that some conditions should be reconsidered.
> >>
> >> I would occasionally like to capture detailed expression code by metavariables.
> >
> > What conditions?
>
> I came also along recurring development concerns according to selected
> source code transformations.
>
>
> >                   What detailed expression code?
>
> The complexity can vary for found expressions, can't it?
>
>
> >                                                   It is not possible to
> > understand this without more information.
> …>> I am unsure about the properties of the found expressions which should be reused somehow.
> >> Thus I would tend to enclose such data by extra parentheses.
> >> A manual inspection would indicate then for an adjusted code place that this
> >> addition would occasionally be redundant.
> >> Can this aspect be better supported automatically?
>
> Will any information from this clarification approach get more attention?
>
> Regards,
> Markus
>
--8323329-50656197-1753020609=:3477--
