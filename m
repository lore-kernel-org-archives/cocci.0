Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F38C48BC4
	for <cocci@archiver.kernel.org>; Sun, 18 Feb 2024 19:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=eGjAO8mrcDeAukLXRSaLJ0P4J72MHiGixXLJpmEM9RQ=;
  b=gS3Atz3KXyBPVMb+N4LAF0FFEwYcdcxdHJsHxQICKtw56juNWmHOsyBJ
   kGNn1P3Q9MK5HWdijNzVNpWjvcqLZyjt+kW1ttv2eHMFPfhcuE/NWJ8w0
   ilA5EYhFFK4knNF2hFeYgy1wPQmhmK0SGdrzdQg4jCkV0WkwmOS/RmPnA
   8=;
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
X-IronPort-AV: E=Sophos;i="6.06,169,1705359600"; 
   d="scan'208";a="152520076"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Feb 2024 20:43:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4AF3AE0CD6; Sun, 18 Feb 2024 20:43:35 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4B850E008A
	for <cocci@sympa.inria.fr>; Sun, 18 Feb 2024 20:43:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eGjAO8mrcDeAukLXRSaLJ0P4J72MHiGixXLJpmEM9RQ=;
  b=RBKNBAdzXeUtagkiv19b0Ka9lJvedS8+A3NzU0gfx61sh83Y3wZpKD70
   9i0163tkZ+XZ2asGoLOHUh6IFpNcVDZJd5l/RRrWFpNy+LcCb2VnRFnxJ
   h9oVRcNiWn+kEltFsPz4lTwINa2JfAdOGOHWxCSL27IAmI4nKLqQHoVe+
   U=;
X-IronPort-AV: E=Sophos;i="6.06,169,1705359600"; 
   d="scan'208";a="79956877"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 20:43:33 +0100
Date: Sun, 18 Feb 2024 20:43:32 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <69055964-fc08-430d-a620-70e02d20de16@web.de>
Message-ID: <alpine.DEB.2.22.394.2402182043200.3095@hadrien>
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de> <6d5d2b50-2878-4d39-b1f3-ae894f880dc4@web.de> <alpine.DEB.2.22.394.2402171623280.3095@hadrien> <7a9ea69a-2699-4fb3-9863-2eddadb5670b@web.de> <69055964-fc08-430d-a620-70e02d20de16@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Fixing the SmPL search for a bit of duplicate code
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1582
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402182043200.3095%40hadrien>



On Sun, 18 Feb 2024, Markus Elfring wrote:

> > Will any collateral evolution become more appealing accordingly?
>
> How good does the next contribution fit into the discussed development story?

Not at all.

julia

>
> account for the fact that binops and assignops are now stripped
> 2023-02-18
> https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/b916699c924986392e876d30f0b838602fdd9ec1
> https://github.com/coccinelle/coccinelle/commit/b916699c924986392e876d30f0b838602fdd9ec1
>
>
> Which adjustments will become more interesting?
>
> Regards,
> Markus
>
