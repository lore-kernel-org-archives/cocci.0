Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074FDC27C40
	for <cocci@archiver.kernel.org>; Wed, 22 Nov 2023 20:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=bUTnoExY9ksa6VPCtCEqXGoBqB9cPfWLVFoXf3CH0UE=;
  b=RWO6WUrD8eIb0qHUDEBV/Cj+dRl5RivkyFkbK11cwMJeGYEQrXxRLSjr
   zNtQUQ6o+/iZv6kOT/ZwpniLEQeC1020CM/jfPYzYAKwqYHfzHKDTheTs
   CvhXfLompE6S31lDbzl4snrzkNtC65k0n+yu34y9QCasRYojKqD4ZxOed
   o=;
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
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="137977878"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Nov 2023 21:59:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C8D0CE0CCA; Wed, 22 Nov 2023 21:59:09 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D33EFE004E
	for <cocci@sympa.inria.fr>; Wed, 22 Nov 2023 21:59:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bUTnoExY9ksa6VPCtCEqXGoBqB9cPfWLVFoXf3CH0UE=;
  b=raAYmjxFJGpaq0t1YRxhbBtC21XiJNPcSWg9tmdloi9MD770BSEZthG8
   Ja+J5kG+Kqnqr2p772puoeRZWvjgeHseT/4I0kE/g3uhkeGjAjoRblkj+
   yfN0HuY1GQiHbxDQDsBbdYjQmSgPnPTkj7rhCxWFIGGf6CO90Dn/gyda1
   4=;
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="72302014"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 21:59:05 +0100
Date: Wed, 22 Nov 2023 21:59:04 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <471b38f1-fc2d-482b-ba0a-8c7982ba9618@web.de>
Message-ID: <alpine.DEB.2.22.394.2311222158000.3262@hadrien>
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de> <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr> <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de> <alpine.DEB.2.22.394.2311222131120.3262@hadrien> <471b38f1-fc2d-482b-ba0a-8c7982ba9618@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1311
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/alpine.DEB.2.22.394.2311222158000.3262%40hadrien>

> > If you don't want any subsequent ifs, then you can put ... after th } and put
> > when != if (...) S1 else S2
>
> How do you think about to count involved if statements?

You can put a position variable on a matched if (if@p) and then use python
code to add the length of p to some variable.

julia
