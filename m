Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E750C61CE8
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Rgc71Kb6mJGkxp6HX6zV7UUAgypQqm2SBjicxRnJc+U=;
  b=BIdomzTmljFWbRL2kuW/8GaJHDTSdktpIYiPaK34IiPGzFaz2r4iKpYN
   6s7FtGBaxIItSvRO/C4826xEgyjXYbg+J/6f7phPsm0We7Y4kCztEqGX5
   hE9fk59Qgj1H2S/kCnSZDW0fdxMzggo6eaPiwZfbqFqq02qTc82ulyiPp
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.16,230,1744063200"; 
   d="scan'208";a="226882420"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:02:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C09AFE0AF6; Thu, 12 Jun 2025 15:02:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2DD0CE0131
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 15:02:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Rgc71Kb6mJGkxp6HX6zV7UUAgypQqm2SBjicxRnJc+U=;
  b=ldumDumEGgIr1lbqIDgu38hREY+nnDsjKtV61xs7qA4Zjmo2eh5zSR7T
   I5pRTj80iM6GdQ3HbJSCa32LNavlZpEDo3qv9p43YYpqt5dBIO2Gk83n8
   ay40ch8bg8qf2PUDqH3wVHRi6vSeaqX7Y46tb1a00BlpShz/aAX/CDMmg
   I=;
X-IronPort-AV: E=Sophos;i="6.16,230,1744063200"; 
   d="scan'208";a="118894871"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 15:02:38 +0200
Date: Thu, 12 Jun 2025 15:02:36 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <45eb943d-1ae3-439c-8b05-7c355a54c48d@web.de>
Message-ID: <cc827ab9-6e22-89f2-2e79-a844c7e1f1a2@inria.fr>
References: <90822099-5434-4421-a611-785511926ecb@web.de> <alpine.DEB.2.22.394.2506101739440.4658@hadrien> <9eeab48f-1bc7-4395-b998-6a49330cfc2b@web.de> <45eb943d-1ae3-439c-8b05-7c355a54c48d@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1499871865-1749733357=:3462"
Subject: Re: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2763
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/cc827ab9-6e22-89f2-2e79-a844c7e1f1a2%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1499871865-1749733357=:3462
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 12 Jun 2025, Markus Elfring wrote:

> >> 2) The proper scientific method is to cange only one thing at a time.
> > Can any software developers determine the concrete command which would perform
> > the indicated “Grep query”?
>
> I got the impression that a function like “interpret” contains interesting
> implementation details.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/582d2ebd4543dd7febf0670f4a104679ec8bbc2d/parsing_cocci/git_grep.ml#L9-35
> https://github.com/coccinelle/coccinelle/blob/4093aad2da23ea5c86916de0a71f43032fc2bb2f/parsing_cocci/git_grep.ml#L9-L23
>
> Some data processing results can be produced accordingly.
>
> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Linux/next-analyses/drivers/infiniband/hw/cxgb4> git grep -l -w kfree '*.c' | rg -v .in | rg device
> device.c
>
> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Linux/next-analyses/drivers/infiniband> git grep -l -w kfree '*.c' | rg -v .in | rg cxgb4/device
> hw/cxgb4/device.c
>
> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Linux/next-analyses/drivers> git grep -l -w kfree '*.c' | rg -v .in | rg cxgb4/device
>
>
> Would you become interested to clarify why I do not see another search result here
> (while the program “spatch” would still generate an expected diff output for
> the selected directory)?

I have no idea what is the program rg, but the problem is already fixed.

julia
--8323329-1499871865-1749733357=:3462--
