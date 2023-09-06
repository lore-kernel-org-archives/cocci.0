Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C5DEB8FA5
	for <cocci@archiver.kernel.org>; Wed,  6 Sep 2023 07:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Rvkb+SWShVRyzMtv3nHwbJNHcbKyhVcjmuHiZuvVUsA=;
  b=Pa62SKmPPHvP9l3cl52UZEcO3+wtmNLVLrs/r1w24v4SjUvQhZoFvWI6
   Yf55RqVRMRSACQtVL4854xzAp5fEm7vUbnYldlUBUzenUQhw5Tcr0cYN6
   1fgDobaX5Qtr18o/REj+jbR7LbFe05Ytd9HHHoeMiccLcL7qqIqyBVdrX
   0=;
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
X-IronPort-AV: E=Sophos;i="6.02,231,1688421600"; 
   d="scan'208";a="124541216"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2023 09:14:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EA030E004E; Wed,  6 Sep 2023 09:14:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E5695E004E
	for <cocci@sympa.inria.fr>; Wed,  6 Sep 2023 09:14:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Rvkb+SWShVRyzMtv3nHwbJNHcbKyhVcjmuHiZuvVUsA=;
  b=lTkOVFVVEC5f+rxMCY0xrREzYHL6AZAmFSByz6ooDr90yNP97fBqawsc
   n88XwRreAY1mp5BKtwXzkKF+IusFVYy4CVLhzw13N6EDBjVDL+iwB1s87
   No0c/KgBcdPLXbi3IovC1V50h0GrBtIwPqsfVYlrlBBs99r+8MLGBc+Pn
   g=;
X-IronPort-AV: E=Sophos;i="6.02,231,1688421600"; 
   d="scan'208";a="124541212"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 09:14:55 +0200
Date: Wed, 6 Sep 2023 09:14:54 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Thomas Adam <thomas@fvwm.org>
In-Reply-To: <0bd30d22-162c-487e-a4a2-4592cb6f2a24@web.de>
Message-ID: <d5bb984b-8b43-5aba-7275-4b6fb5e44c63@inria.fr>
References: <7e3fdd0f-e691-4ebd-9de9-4fbdb6ece973@web.de> <alpine.DEB.2.22.394.2309022008310.3175@hadrien> <205fad47-dbef-4cfe-885b-69a2a0d4b09b@web.de> <alpine.DEB.2.22.394.2309022032260.3175@hadrien> <1326a929-8a48-4113-981c-df6dc3220474@web.de>
 <alpine.DEB.2.22.394.2309022101230.3175@hadrien> <852c86a4-403b-49f5-b307-c47fcf6da68a@web.de> <a9c2e240-eb0d-449c-ace2-d723a891500b@web.de> <0bd30d22-162c-487e-a4a2-4592cb6f2a24@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1107966199-1693984494=:3367"
Subject: Re: [cocci] Checking an analysis approach for the avoidance of
 duplicate code
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1239
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-09/d5bb984b-8b43-5aba-7275-4b6fb5e44c63%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1107966199-1693984494=:3367
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 6 Sep 2023, Markus Elfring wrote:

> > Will any case distinctions be adjusted in the implementation of the Coccinelle software?
>
> Would you like to discuss data processing consequences any more for the use case
> if multiple metavariables are specified with the same type?
>
> Are there any special constraints to consider for the safe application
> of the semantic patch language if a type like “statement” was chosen for some
> variable names?

None of the above questions make any sense to me, but I did spend some
time yesterday looking at the problem, and I don't have a solution for the
moment.

julia
--8323329-1107966199-1693984494=:3367--
