Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0066ACCF9F8
	for <cocci@archiver.kernel.org>; Wed, 12 Nov 2025 13:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=4dk3o5ylcPWpjCHP4jQhm+Ovuw4HSwrs0+5UhYLqnKI=;
  b=c3OZ5lUi0osWMR0CbwWCNJA7SUpOiECA9EdQFXezd3VhXEtRYH+RpsUU
   vqfrR4ZK8nH/pcOX6CLB+fSD6Co1PD44INXJX0HMoP0iw51/r12mnN+3y
   LjXhEypXDfgjNfJkH3a5NxGnOhwBP64wd1EYU/xY3Xg/SLgNnH+0gzcqS
   w=;
X-CSE-ConnectionGUID: WOHEuL2nROquajnthpCoWg==
X-CSE-MsgGUID: TvjQLQyyTFufvyDlpET/tA==
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
X-IronPort-AV: E=Sophos;i="6.19,299,1754949600"; 
   d="scan'208";a="248767314"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2025 14:10:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 02695E0BE9; Wed, 12 Nov 2025 14:10:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 352EDE0172
	for <cocci@sympa.inria.fr>; Wed, 12 Nov 2025 14:10:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4dk3o5ylcPWpjCHP4jQhm+Ovuw4HSwrs0+5UhYLqnKI=;
  b=Vb1U4Mi/bIP6PSeMauPkS0/wHkAQTLn8exZEwwtBPmDZvmaiRst68noc
   5NZfPmNmY+DAmPyGEExEbWMHmM9XGFoKkDlsePwj6zAWsvTq7AZsOOn6b
   C3AjG0NDdzPpc+HlWPLZuqrqoXQnprOk0ZUNc50VtqK7UtB+BIVDSGeUQ
   0=;
X-CSE-ConnectionGUID: H/V6KdfmRyqEiYOaQjxkQw==
X-CSE-MsgGUID: YDOSfGiGQO2tGxSL+4qFpw==
X-IronPort-AV: E=Sophos;i="6.19,299,1754949600"; 
   d="scan'208";a="248767296"
Received: from c-76-123-3-165.hsd1.va.comcast.net (HELO hadrien) ([76.123.3.165])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 14:10:11 +0100
Date: Wed, 12 Nov 2025 08:10:08 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <2c82cd3e-6190-4f6e-ab86-5eb047349f04@web.de>
Message-ID: <9ccbf656-3d48-afbf-3e7b-2ad2157240db@inria.fr>
References: <ca1862a2-8a84-49b8-bbfd-fca9f15c6787@web.de> <c5aa7f4a-4efc-5384-3295-823dea0ea10@inria.fr> <92736910-a93f-4a91-9356-f6f6c1aebd8b@web.de> <3177bcc9-773-393d-edf4-8fb67a59115@inria.fr> <2c82cd3e-6190-4f6e-ab86-5eb047349f04@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Checking SmPL support for two special expressions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3167
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/9ccbf656-3d48-afbf-3e7b-2ad2157240db%40inria.fr>



On Wed, 12 Nov 2025, Markus Elfring wrote:

> >>> Coccinelle doesn't know these types.  You have to declare them with typedef.
> >>
> >> Are type definitions really required for the handling of casts?
> >
> > Yes.  There is a potential parsing ambiguity otherwise, I believe.
>
> How interesting is it that I can recognise casts also without extra type definitions?

Not interesting.  Sometimes it can infer them.

julia


>
> Regards,
> Markus
>
