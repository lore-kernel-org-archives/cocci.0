Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404FCC4829E
	for <cocci@archiver.kernel.org>; Sun, 18 Feb 2024 07:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=LJGbsh9aMGfeEUkobyWwnw7Ly15bb6EBkx8i7yJjueU=;
  b=St+omwaHsLSqGSA2lrHi/RhbGtJcsao6Fjk3C8lkPnqjUATNQ9bwAcUN
   qFosCxfXyFJ/vQik0v2Ph4pTvzzTo13pJRO7zSGX+CsINt9JdS3n1YBus
   QC8ncx8J2aoI6IqZAbcQAo6cuG24qB6Q2/Gvq+RR3s4udGmKw2TNMTt8W
   o=;
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
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="152481155"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Feb 2024 08:44:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 60D1DE00B7; Sun, 18 Feb 2024 08:44:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9DF96E008A
	for <cocci@sympa.inria.fr>; Sun, 18 Feb 2024 08:44:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LJGbsh9aMGfeEUkobyWwnw7Ly15bb6EBkx8i7yJjueU=;
  b=XMZd9yunUrSz8UcY+p8BnjSGO1WNKmKfVFN33ZEA0jDiA537nQNEE35S
   X8rlq+JewaToQOA/umEC135sXlPsqCLsvgQ1UYjUXEIkTaokaFmIy//Qz
   V6qJ2qpxSdY63lzU3HM8ybNCZQtaCLmZ72Y3xRMl/LWyJlajPbLXdzAcG
   g=;
X-IronPort-AV: E=Sophos;i="6.06,168,1705359600"; 
   d="scan'208";a="152481150"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 08:44:36 +0100
Date: Sun, 18 Feb 2024 08:44:36 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <e4d59a7f-94f2-47b4-8a63-0d0775c4a133@web.de>
Message-ID: <alpine.DEB.2.22.394.2402180843300.3095@hadrien>
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de> <6d5d2b50-2878-4d39-b1f3-ae894f880dc4@web.de> <alpine.DEB.2.22.394.2402171623280.3095@hadrien> <7a9ea69a-2699-4fb3-9863-2eddadb5670b@web.de> <e4d59a7f-94f2-47b4-8a63-0d0775c4a133@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-185989504-1708242276=:3095"
Subject: Re: [cocci] Fixing the SmPL search for a bit of duplicate code
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1574
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402180843300.3095%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-185989504-1708242276=:3095
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 18 Feb 2024, Markus Elfring wrote:

> > binops and assignops need to be stripped before being put into metavariables
> > 2024-02-17
> > https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/cf3ea16c48751708ab468919c736acb06f7e1ff7
>
> How do you think about to explain the influence of the mentioned “stripping”
> on desired data processing a bit more?

Stripping removes line and column numbers and allow metavariables bound in
two different places to be considered to have consistent values.

>
> Applications of the metavariable type “binary operator” were occasionally
> discussed before.

But probably no one ever tried two matches of the same one.

julia

> Another example topic:
> Complete support for data processing with binary operators
> 2020-09-29
> https://github.com/coccinelle/coccinelle/issues/227
>
> Regards,
> Markus
>
--8323329-185989504-1708242276=:3095--
