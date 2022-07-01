Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965FFCCA480
	for <cocci@archiver.kernel.org>; Fri,  1 Jul 2022 20:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9qe0nxZOvaLCIaz/3pAduL5jl2eURbi0JuFP6K7ELe0=;
  b=RAUi6OK1TWYuc9HJ9ui/SwH1gZakDvK6mkRcvrrq9nnar/4Xpkl6Nny3
   x5lYL61nq5REVy/X+dvQwjbFBc+7h5VlkfC4cMO+hlgsdSvzsvcTI4MZO
   AaTVxeiWwjgPY7nD4KvUVCDPJIqi5JrQ+WQB3lS2YWHmLEQ7rPzSQyK5K
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.92,238,1650924000"; 
   d="scan'208";a="43896050"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2022 22:49:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 62EAAE015F; Fri,  1 Jul 2022 22:49:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 37B8BE0092
	for <cocci@sympa.inria.fr>; Fri,  1 Jul 2022 22:49:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9qe0nxZOvaLCIaz/3pAduL5jl2eURbi0JuFP6K7ELe0=;
  b=dO7uEw7XEMMBA5FaGbr8jQyjYIcnPhrfMfcICRD7rCD4uovaghWfuX11
   Cn+shkSCiWUWj7o//Rw2PsqrKwF5r0TKWIU1U40qtQuYHp7RJaRITVTDn
   L2p4zYrW9eE8H7iVuqY0oxFWjF5kIrmf9q5+bmdZXqVIH9KzqBo+mdj75
   g=;
X-IronPort-AV: E=Sophos;i="5.92,238,1650924000"; 
   d="scan'208";a="18339685"
Received: from unknown (HELO hadrien) ([206.121.37.170])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 22:49:33 +0200
Date: Fri, 1 Jul 2022 16:49:26 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: =?ISO-8859-15?Q?J=E9r=E9my_Lefaure?= <jeremy.lefaure@netatmo.com>, 
    cocci@inria.fr, kernel-janitors@vger.kernel.org, 
    Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <632c81ca-3d53-4ff5-505e-f8da998e47db@web.de>
Message-ID: <alpine.DEB.2.22.394.2207011647580.4779@hadrien>
References: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com> <632c81ca-3d53-4ff5-505e-f8da998e47db@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1538089997-1656708574=:4779"
Subject: Re: [cocci] [PATCH v5] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 474
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/alpine.DEB.2.22.394.2207011647580.4779%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1538089997-1656708574=:4779
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 1 Jul 2022, Markus Elfring wrote:

> > This change aims at detecting an address test in more complex conditions
> > and not only in if statements.
> …
> > v4 -> v5: Change semantic patch to match explicit tests to NULL +
> > improve commit message
> …
> >  scripts/coccinelle/misc/{ifaddr.cocci => test_addr.cocci} | 4 +---
> …
> > @@ -14,12 +14,10 @@ virtual context
> >
> >  @r@
> >  expression x;
> > -statement S1,S2;
> >  position p;
> >  @@
> >
> > -*if@p (&x)
> > - S1 else S2
> > +*\(&x@p == NULL \| &x@p != NULL\)
>
> …
>
>
> Can another SmPL code example help with the clarification of proposed
> implementation details?
>
> @display@
> expression x;
> binary operator bo = { ==, != };
> @@
> * &x bo NULL

Markus, did you actually try this?  Please try things before suggesting
them.  The whole point of the proposed change is to trigger some
isomorphisms.  I really doubt that any isomorphisms will be triggered with
this suggestion.

julia
--8323329-1538089997-1656708574=:4779--
