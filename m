Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F615C48260
	for <cocci@archiver.kernel.org>; Sat, 10 Feb 2024 13:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Lqs4Ns6AvMb0i3RnXTWD/+RZRkw322bgMHwfnzRK8cM=;
  b=WJ6rsU0Svi8c+9uKfr+BLwBuNm+0vGN9KokV+PSd0ffTnK70s+AmthYf
   cpx+xkfEwHB8MZxye/4QCGucEKmfNGmQB7XQBPEDFdfvYq162sMMcmppQ
   54MN2vcMxX6rEwv9uJbuxlf2nAHon4N3I/KhqrC4r0XcXwspa3BWrXTwT
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="151312321"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2024 14:22:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 74590E0CD5; Sat, 10 Feb 2024 14:22:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DE305E008A
	for <cocci@sympa.inria.fr>; Sat, 10 Feb 2024 14:22:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Lqs4Ns6AvMb0i3RnXTWD/+RZRkw322bgMHwfnzRK8cM=;
  b=Z86BJI6iUx9HI/M/OLzlLpfivI9TlA6cmSVCeSRqwzLyIFzcdMWg9clr
   dkaTxef0ZsDSqI6WtGzqnvu3aS/rpkIDsyVt92+Adh3PieIRozi7w6dqb
   9YAqAD9HTbJ563G7/8f5tSZqxRS+tOeW4A2bxftB2NRLmTywcWzt5PeWC
   o=;
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="151312320"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 14:22:10 +0100
Date: Sat, 10 Feb 2024 14:22:10 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <501ef7d8-223c-4647-a302-7aeee083af14@web.de>
Message-ID: <alpine.DEB.2.22.394.2402101421490.53569@hadrien>
References: <d4abffb5-6221-4109-9316-acb5c3720c31@web.de> <alpine.DEB.2.22.394.2402100936350.53569@hadrien> <1c2bfc73-cf2e-4949-bf60-6fc432ef67a8@web.de> <alpine.DEB.2.22.394.2402101124030.53569@hadrien> <501ef7d8-223c-4647-a302-7aeee083af14@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1150546292-1707571330=:53569"
Subject: Re: [cocci] Extending handling of position information for SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1537
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402101421490.53569%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1150546292-1707571330=:53569
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 10 Feb 2024, Markus Elfring wrote:

> >> * Can a position metavariable be reused in the same SmPL rule?
> >
> > Yes.
>
> Such a variable was assigned (or do you prefer the wording “was bound”?)
> somewhere in a SmPL rule.
> How would later SmPL code refer to the previous variable name without repeating
> a companion metavariable identifier?

I don't understand how you plan to use something without referring to it.

julia
--8323329-1150546292-1707571330=:53569--
