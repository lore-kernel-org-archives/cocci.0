Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD831CCD184
	for <cocci@archiver.kernel.org>; Sun, 19 Oct 2025 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=BHHWjxZUjUjpJSnyNshgiAJWYwCDdnonExrdefTFXfE=;
  b=gYRnl7bfs0vlOi+PnJka0aEVBDpF7ZPB7rNc2G/kInTE1hSHO988xgcx
   tl+A37gJWKhVgem3Az2TNUfQOdz1zEOvA/YoQztNeN8MFELKxJAuxGLyF
   XLQ2N4ZYLSO9LlzNHyYf99UOBR1y2dcSUuH0kL0mMJsNHmGzmcJrivX56
   8=;
X-CSE-ConnectionGUID: eGa6MTDsRsKfXsludQ1bhg==
X-CSE-MsgGUID: n/zE6LAbR3aJ6NlenKGTvw==
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
X-IronPort-AV: E=Sophos;i="6.19,240,1754949600"; 
   d="scan'208";a="245013068"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Oct 2025 16:30:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 56544E0C55; Sun, 19 Oct 2025 16:30:27 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 540A6E0171
	for <cocci@sympa.inria.fr>; Sun, 19 Oct 2025 16:30:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BHHWjxZUjUjpJSnyNshgiAJWYwCDdnonExrdefTFXfE=;
  b=BVGA0ybxEzfK0EfZvKdJEKXhoxLG8H301reySponIPns0ZAUfDL+Z6Jj
   ZE1IWKgE3Vh0jMQkp9Wb9tIUFvjkFfA5AmO4HWvEyyigmK9IsROMNfQZu
   vHE8AI+xnHVBavt6TQI51hbdfE8iANx43jD36ggaJGStWuFWFK9JPKsTq
   g=;
X-CSE-ConnectionGUID: P6wQD+bbSZWcrjj2rNGR0Q==
X-CSE-MsgGUID: sNfcFsrPSBGReTbzmr/gOg==
X-IronPort-AV: E=Sophos;i="6.19,240,1754949600"; 
   d="scan'208";a="128611023"
Received: from unknown (HELO hadrien) ([202.187.229.14])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 16:30:22 +0200
Date: Sun, 19 Oct 2025 22:30:19 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <c55ea172-2c1b-4bbf-b5d4-e2d421e18b1f@web.de>
Message-ID: <e5b2ceef-31a0-a54-dd74-c4dcdfcba5a@inria.fr>
References: <4afdfd37-3177-4480-9648-ab0d7f59097c@web.de> <d1b6d33d-cfc0-ff6b-47de-7bbc28e8a7d@inria.fr> <c55ea172-2c1b-4bbf-b5d4-e2d421e18b1f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Analysis challenges with SmPL for pass-through
 functions?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3079
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/e5b2ceef-31a0-a54-dd74-c4dcdfcba5a%40inria.fr>



On Sun, 19 Oct 2025, Markus Elfring wrote:

> >> Will further clarifications become more interesting for corresponding case distinctions?
> > There is no guarantee that two metavariables don't match the same thing.
>
> Will such information become helpful for better software documentation?

I guess documentation doesn't usually invalidate all random wrong
hypotheses that users may have...

>
>
> > If you don't want them to match the same thing, then you need to use a
> > disjunction.  In the first branch, the same metavariable should be used
> > twice, and then in the second branch there would be the two different
> > metavariables.  The match should only be indicated for the second branch.
>
> Does such a solution approach indicate a data processing requirement
> for multiple source code searches so that anything would be excluded finally?

No idea what this means.

julia
