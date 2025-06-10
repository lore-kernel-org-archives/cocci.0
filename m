Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9642AC5B543
	for <cocci@archiver.kernel.org>; Tue, 10 Jun 2025 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=r6BCGMJUmEcvd4dvWWkP336Otga0QjX6WDqDsnfNnIg=;
  b=DqIrzAPZu3TayqoXp1PpFLHxCIbAppKnfM/RzWRLKrgkK30Pr1Vi/nCj
   VNq4rBElJfgHIy149zyJruTQLeIqn1K8ZEnUJsYqjtXwrmtrITxS6Y3O4
   9KtwYTISpjRfarJ9W5n2j65GVdZIESxfkqTcAclnCuQG1X1vrnzLKvqXm
   k=;
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
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="226163105"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2025 18:32:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 742C9E0157; Tue, 10 Jun 2025 18:32:17 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 50166E0131
	for <cocci@sympa.inria.fr>; Tue, 10 Jun 2025 18:32:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=r6BCGMJUmEcvd4dvWWkP336Otga0QjX6WDqDsnfNnIg=;
  b=cioaJy4BOAKKFZltfZoWWwmV6dis5Cwua5TKN0jqbXPykzkSYrYwkJ6G
   fxwSMeOxYPtOG7C+LluFV21fgbPJHkP/PoGtMPfxPabVVPtPSeNFXp86z
   jp5gZDcsC9iasINU1HhRBqvZxDlNhXGpCktOiJ01iRQqx15k3Edc/PZ6/
   s=;
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="118683594"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 18:32:12 +0200
Date: Tue, 10 Jun 2025 18:32:11 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <629fa64c-ccd0-46ba-907c-97bebc00fa0c@web.de>
Message-ID: <alpine.DEB.2.22.394.2506101831510.4658@hadrien>
References: <90822099-5434-4421-a611-785511926ecb@web.de> <alpine.DEB.2.22.394.2506101739440.4658@hadrien> <629fa64c-ccd0-46ba-907c-97bebc00fa0c@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1590221269-1749573131=:4658"
Subject: Re: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2755
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/alpine.DEB.2.22.394.2506101831510.4658%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1590221269-1749573131=:4658
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 10 Jun 2025, Markus Elfring wrote:

> > Could yo uplease make a small effort to make your reports understandable?
>
> Why do the presented test commands trigger undesirable understanding difficulties?
>
>
> > 1) I don't ned to know the paths of your files?  This adds a lot of
> > clutter that makes it hard to find the important information.
>
> I find the mentioned test data relevant for further clarifications.
>
>
> > 2) The proper scientific method is to cange only one thing at a time.
>
> There are two data processing results to compare.
>
>
> > You seem tohave changed two things 1: in one case you give the specific file name
>
> Something looks reasonable.
>
>
> > andin the second case you use the whole Linux kernel directory,
>
> Yes.
>
> The mentioned log file contains the following information then:
> “…
> 7675 files match
> …”
>
> May I expect that a file name like “./drivers/infiniband/hw/cxgb4/device.c”
> should occur there?
>
>
> > and 2; in one case you are using linux-next from a specific date andin the
> > other case there is no information about what kernel version you are
> > using.
>
> The mentioned test cases refer to the same Linux development repository.

Did you check for the HANDLING comment as requested?

julia
--8323329-1590221269-1749573131=:4658--
