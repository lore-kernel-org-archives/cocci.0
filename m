Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68213C27C47
	for <cocci@archiver.kernel.org>; Sat, 28 Oct 2023 08:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=I3tryYVVfW0RZw2Tvdm0C7JglY1RUHB3ZuTWGu1zhXU=;
  b=NsqfSTe/n51OP9QO5iAwFj0xvTyG+UVDxVpotZskYcEQms4vaXuUVEjQ
   u6L4a/aVwMjotM1CWj8/4ZlQyEGAcMHUUGQ41/AZ/dcZldscnX6CiSkM1
   QSxH/NUGNHBi3d03pxR7Uo22kThvflvdN8Lk8DEn16b5IdYXxCoP0gVky
   M=;
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
X-IronPort-AV: E=Sophos;i="6.03,258,1694728800"; 
   d="scan'208";a="133678501"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Oct 2023 10:44:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 35FD8E0205; Sat, 28 Oct 2023 10:44:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 10E74E00B7
	for <cocci@sympa.inria.fr>; Sat, 28 Oct 2023 10:44:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=I3tryYVVfW0RZw2Tvdm0C7JglY1RUHB3ZuTWGu1zhXU=;
  b=PXE/g+F52wLrni/odCuzHF54QmqNB89hZYZHwo/C/mRYMJ9Q5P3+otl8
   afCoRBiFkius5bdlWacgCsM/4WAylbsvhd6h8okQ9w6i7hl2LLhbnRpWs
   XtIPjHZh7cnlLYtVXl77QkEovjHUNh6XRnsTao2EPazOadqhxO2U8cAu1
   w=;
X-IronPort-AV: E=Sophos;i="6.03,258,1694728800"; 
   d="scan'208";a="133678494"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 10:44:21 +0200
Date: Sat, 28 Oct 2023 10:44:21 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <7f3e9676-0d1a-4fc2-83cb-8b77f6dd0a56@web.de>
Message-ID: <alpine.DEB.2.22.394.2310281043270.3096@hadrien>
References: <7f3e9676-0d1a-4fc2-83cb-8b77f6dd0a56@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1272035608-1698482661=:3096"
Subject: Re: [cocci] Improving support for Coccinelle data formats with
 parse expression grammars (or Packrat)
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1284
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/alpine.DEB.2.22.394.2310281043270.3096%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1272035608-1698482661=:3096
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 28 Oct 2023, Markus Elfring wrote:

> Hello,
>
> The Coccinelle software provides customised data formats for its application domain.
> Data conversions are needed accordingly.
>
> The following information is published.
> https://github.com/berke/aurochs
> “
> Aurochs is a parser generator that uses the parse expression grammar (PEG) or "packrat" approach.
> …”
>
>
> Would you like to benefit more from it
> (instead of using tools like ocamlyacc and Menhir)?

Me personally no.  But if you would like to implement something and show
that it is somehow better than the current implementation, them please go
ahead.

julia
--8323329-1272035608-1698482661=:3096--
