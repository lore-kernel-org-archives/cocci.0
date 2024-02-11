Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B191C4829A
	for <cocci@archiver.kernel.org>; Sun, 11 Feb 2024 13:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=unXP5cKOwzPg6juVvdbl35VXUxQ9DkyK64g62UIyHR0=;
  b=XAOPGNkvt874UsYo9zoD1numEcq3+0ko0NPmKCwUmdoNlSLPfKWmUhyJ
   3/WLLJjBh21D+xLr2hRpRZM7oHsfIApZBFt7d2la2TDdmkkcKAZtoCQ+O
   v8EYbZovisUWMxEtnefRqENWeWXTg0P9IzHJmlOtaFQsPtJjgxAFDEGsA
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.05,261,1701126000"; 
   d="scan'208";a="151358663"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2024 14:27:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C0102E00B7; Sun, 11 Feb 2024 14:27:57 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DDE47E008A
	for <cocci@sympa.inria.fr>; Sun, 11 Feb 2024 14:27:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=unXP5cKOwzPg6juVvdbl35VXUxQ9DkyK64g62UIyHR0=;
  b=mm1DOCHFdXFEGgw9Bnfs9KqHB9srYEwtRrc60HJWbLo7nJeGjQOa70oH
   nwZKfIwyu9TK/OyCjbKchIJqgHvgkrmWmwysxjTIbq+HMsdVNEnzeb3vq
   BFIxOX0xUOesVOSU8yl/sC4JYv2JW7dPrq+vRZVmaIvlXA/+urViVWr3t
   U=;
X-IronPort-AV: E=Sophos;i="6.05,261,1701126000"; 
   d="scan'208";a="79313669"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 14:27:55 +0100
Date: Sun, 11 Feb 2024 14:27:54 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <400ced6a-bf8b-4ddc-afea-a5d0bb49234b@web.de>
Message-ID: <alpine.DEB.2.22.394.2402111426580.53569@hadrien>
References: <d4abffb5-6221-4109-9316-acb5c3720c31@web.de> <alpine.DEB.2.22.394.2402100936350.53569@hadrien> <1c2bfc73-cf2e-4949-bf60-6fc432ef67a8@web.de> <alpine.DEB.2.22.394.2402101124030.53569@hadrien> <501ef7d8-223c-4647-a302-7aeee083af14@web.de>
 <alpine.DEB.2.22.394.2402101421490.53569@hadrien> <836e2ebd-a9cf-4644-9619-2526bddae0bd@web.de> <alpine.DEB.2.22.394.2402101554070.53569@hadrien> <400ced6a-bf8b-4ddc-afea-a5d0bb49234b@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1308828553-1707658074=:53569"
Subject: Re: [cocci] Extending handling of position information for SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1546
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402111426580.53569%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1308828553-1707658074=:53569
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 11 Feb 2024, Markus Elfring wrote:

> > Just like for any other metavariables.  For example, if x is a metavariable,
> > you can say f(x,x) with no special notation for either of them.
>
> How do you think about to extend corresponding advices?
>
>
> @rename@
> identifier f;
> position x;
> @@
> -f
> +g
>   (x,x)
>
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch --parse-cocci test1-position-20240210.cocci
> …
> minus: parse error:
>   File "test1-position-20240210.cocci", line 7, column 3, charpos = 47
>   around = 'x',
>   whole content =   (x,x)

I didn't mean if x was a position.  For f(x,x), x should be an expression
or an identifier.  A position variable has to be attached to something.
And anyway, there is no hope that the two arguments of a function will be
in the same position.

julia
--8323329-1308828553-1707658074=:53569--
