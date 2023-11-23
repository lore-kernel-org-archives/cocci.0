Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B178C61D97
	for <cocci@archiver.kernel.org>; Thu, 23 Nov 2023 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=sLAS8R4hNTKolupJeNyT5whU5PiUx9/Se4I2xUSuHUg=;
  b=A9THR+jlos0aoKAJhTnI4NIgzdsoFu5dt6nGzk2JZ02qEyBaFu6UYg6L
   No5uFZzxEd4Sj6iA4NUC9yCQqz/HaYY/vaqH5ji4vcN6AMOFcGs4Zleim
   4ageP6axf7gS+NYTyjZYKCk2UhDvZIiBXxZ8z87SPAHfd1g1XDxp3F5F4
   I=;
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
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="138192168"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Nov 2023 18:46:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A0E07E004E; Thu, 23 Nov 2023 18:46:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 81102E004E
	for <cocci@sympa.inria.fr>; Thu, 23 Nov 2023 18:46:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sLAS8R4hNTKolupJeNyT5whU5PiUx9/Se4I2xUSuHUg=;
  b=kEZoC9zPtH83FYBeQdnjXQZkVIbCev+n+OHMAmAj8XkxSq++JnV4QPRb
   z3YZgInKtmdExkS6OsEQpjYiGLRwOnVLXh0tkFfm/jBCSSgvMmT5T1tXZ
   Zu7ImsbUWSLkPAFP6Bt3G+lY4RIeWq0AcxhTpCefhsWA7VIihKxO/zmN2
   M=;
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="138192162"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 18:46:43 +0100
Date: Thu, 23 Nov 2023 18:46:43 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <fabb554b-d109-4a77-96c1-a96f31d107d1@web.de>
Message-ID: <alpine.DEB.2.22.394.2311231846240.3125@hadrien>
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de> <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr> <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de> <alpine.DEB.2.22.394.2311222131120.3262@hadrien> <471b38f1-fc2d-482b-ba0a-8c7982ba9618@web.de>
 <alpine.DEB.2.22.394.2311222158000.3262@hadrien> <fabb554b-d109-4a77-96c1-a96f31d107d1@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-411871259-1700761603=:3125"
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1318
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/alpine.DEB.2.22.394.2311231846240.3125%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-411871259-1700761603=:3125
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 23 Nov 2023, Markus Elfring wrote:

> >> How do you think about to count involved if statements?
> >
> > You can put a position variable on a matched if (if@p) and then use python
> > code to add the length of p to some variable.
>
> There are programming interfaces supported to some degree.
> Scripting code can be used to construct customised metavariables
> which can be applied in subsequent SmPL rules.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8d66511d00b27de44e5c21b60d41938d32321b1a/docs/manual/cocci_syntax.tex#L655
>
> A position variable needs probably be applied to mark a source code place
> as unique for desirable adjustments.
> A function like “make_position” is available for such a purpose.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8d66511d00b27de44e5c21b60d41938d32321b1a/docs/Coccilib.3cocci#L226
>
> How do you think about to provide a function variant which can copy relevant data
> from a previous position object directly?

I don't see why it would be useful.  But if it is, you can define such a
function.

julia
--8323329-411871259-1700761603=:3125--
