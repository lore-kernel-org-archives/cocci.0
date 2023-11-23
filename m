Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65211C5AD4C
	for <cocci@archiver.kernel.org>; Thu, 23 Nov 2023 17:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9pDsC4HO03rAS9fiaU3t55qEnb583ppMaLs4YSQwidY=;
  b=Vt9PGyIYIzQnjlCgEne0E21MxcpNw6u7Ydl183gTs9+dteuNkb4eColR
   NloO/UPYhuubm2LmxqStSBxn07kIC/SW+LPnbiZZstC/fCERcx4uiAYog
   xdylkg/Q5CP3BTddgDzXgeNkAP+NDs0gnkd4PZGTpbZcbPuPq0chG82ik
   8=;
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
   d="scan'208";a="138191552"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Nov 2023 18:45:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 69191E0CCE; Thu, 23 Nov 2023 18:45:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 28E64E004E
	for <cocci@sympa.inria.fr>; Thu, 23 Nov 2023 18:45:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9pDsC4HO03rAS9fiaU3t55qEnb583ppMaLs4YSQwidY=;
  b=sOpAl/YS/oQJVxWGMgK0sZQkZfl1BiWxwHTJBpGRtU/HDHl/CF4w2w2y
   EFxisjoZ3gVB9UA8l46Fw5YPd3siha6CjW/SrK+FU5v9OI+H23b908VJB
   gDuJY0tDe8Wp1QFxg9XaZuFGXDimDMogA7O6ZGj/2Za6txbf0aESCBTEk
   o=;
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="138191551"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 18:45:45 +0100
Date: Thu, 23 Nov 2023 18:45:44 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <09a9b132-5cbc-44df-b445-d8adcac7571e@web.de>
Message-ID: <alpine.DEB.2.22.394.2311231845210.3125@hadrien>
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de> <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr> <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de> <alpine.DEB.2.22.394.2311222131120.3262@hadrien> <471b38f1-fc2d-482b-ba0a-8c7982ba9618@web.de>
 <alpine.DEB.2.22.394.2311222158000.3262@hadrien> <09a9b132-5cbc-44df-b445-d8adcac7571e@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1317
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/alpine.DEB.2.22.394.2311231845210.3125%40hadrien>



On Thu, 23 Nov 2023, Markus Elfring wrote:

> > You can put a position variable on a matched if (if@p) and then use python
> > code to add the length of p to some variable.
>
> I would like to point another challenge out for the development of the discussed
> control flow analysis algorithm.
> I got the impression that script rules are evaluated as often as
> some source code matches according to a previous SmPL rule.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8d66511d00b27de44e5c21b60d41938d32321b1a/docs/manual/cocci_syntax.tex#L655
>
> I imagine then that it would occasionally be more helpful to execute a special
> script rule only once while it got complete position information.
> How will ideas evolve further here?

Script rules are executed once per unique match.  Nothing will change
about that.

julia
