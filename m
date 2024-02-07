Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3136BC4828D
	for <cocci@archiver.kernel.org>; Wed,  7 Feb 2024 20:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nLWRbUafL72zsb5AE25NYMH+54/bjeBHPxL9q8KoULo=;
  b=L/EdqyWbtX2sArhkRd5W3bYI2jiJYCG/Uy2PujJ6W7DTTQzDZ3YfhtMf
   IgMoD7r7kjgXh4SeMgzVvZQV6XMQHOGWghFnB9OT/+JfdfCI8y8wkrK4q
   Y8xCxlamSstizhnShHXGB5lGGm3UdOT5Gu5AaRgYp0n76VQqwKmKMMcVT
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
X-IronPort-AV: E=Sophos;i="6.05,251,1701126000"; 
   d="scan'208";a="150839233"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Feb 2024 21:10:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3A1DBE0CD7; Wed,  7 Feb 2024 21:10:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 62A02E008A
	for <cocci@sympa.inria.fr>; Wed,  7 Feb 2024 21:10:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nLWRbUafL72zsb5AE25NYMH+54/bjeBHPxL9q8KoULo=;
  b=KZ2xTMWFbaKSu3166suE98Ls76MYm+oDdjyTTkq/XSKl1773L6Jhr+y9
   Bh/74zwvg9gKYb+u1jTl27/JAn7NSs1urFBFqIhSLABe7RC7JjRI1ynE0
   IVRsfKgsGqwsqZfVCmkB6F35tpq6lWikkHaQj+sOeC54I2lVvXXWSgxgU
   0=;
X-IronPort-AV: E=Sophos;i="6.05,251,1701126000"; 
   d="scan'208";a="150839223"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 21:10:00 +0100
Date: Wed, 7 Feb 2024 21:10:00 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <289a052b-86ff-4ecd-ae55-89fc0238373e@web.de>
Message-ID: <alpine.DEB.2.22.394.2402072108500.3138@hadrien>
References: <41052adc-2065-4cf2-9160-2e986de1bf9b@web.de> <289a052b-86ff-4ecd-ae55-89fc0238373e@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-570308338-1707336600=:3138"
Subject: Re: [cocci] Supporting transformations better according to reduced
 number of function call parameters
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1510
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402072108500.3138%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-570308338-1707336600=:3138
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 7 Feb 2024, Markus Elfring wrote:

> > Corresponding change possibilities can depend then on the detail
> > if references to previous data items would occur in subsequent control flow
> > (or not).
> > I got the impression that the data processing with the semantic patch language
> > has got special algorithmic properties.
>
> Update candidates will be searched by an initial SmPL rule.
> The search pattern needs to refer to variable declarations
> so that their positions can be reused for subsequent queries.
>
> Selected variable identifiers will be specified for an “appendix”
> which indicates the potential for further usage of them in another SmPL rule.
> How do you think about to support a software extension so that the complete
> SmPL code from the first rule can be applied once more (as a known submatch)
> without repeating it?
>
> The submatch probably contains statements which should also be reusable
> for desired change specifications including the deletion of variable declarations
> that would not be needed any more in a function implementation.
> Will development interests grow accordingly?

I don't really understand what you are asking about, but there are files
iteration.cocci and python_iteration.cocci in the demos directory.  This
makes it possible to rerun some semantic patch code.

julia
--8323329-570308338-1707336600=:3138--
