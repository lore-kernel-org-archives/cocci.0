Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20544C83F1A
	for <cocci@archiver.kernel.org>; Mon, 21 Jul 2025 05:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/LY19pskLTNoJmcjY19VCINTiOI7Asoxfm3vAv5Opis=;
  b=M+NnhKAFUBQF4Wrhn12NKqWLl0nQvR5hKOwo0YbaLFggFrEkKFTs2fCm
   4iRpoWAVumqrr1vxdKB2c1YF10SWp1ZWXUHWeESAk0+9wBChaxzwNNmSm
   yGgb+lwMTcKJ/wWVghwfBDRcg2T8L7JGKfI8/5VL8b5xlYnM+Uql1H6G4
   U=;
X-CSE-ConnectionGUID: OQOmVpLVTImf0zmQnOr+4g==
X-CSE-MsgGUID: nvGYeVEGQqOFs1T4aHc0CQ==
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
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232388598"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jul 2025 07:48:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8B03BE0CD5; Mon, 21 Jul 2025 07:48:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 90045E0171
	for <cocci@sympa.inria.fr>; Mon, 21 Jul 2025 07:48:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/LY19pskLTNoJmcjY19VCINTiOI7Asoxfm3vAv5Opis=;
  b=OMlbIqLjlvL9V37KfFNtiCXmE/mKR5Vg+4HaeH1WqpS5EQC5rpWrx8pG
   bG4O/nQSEaRog7mYeBK6xP+7/PKfsoHi4yFoajlfCsXlZ062C2QFRJ7TW
   Kyo2yJQt3pwySNaxTSOYFMoe/slZnTFo/pGlQmuS7K8nv3r7EzuKL8bD7
   o=;
X-CSE-ConnectionGUID: D8NdM6ZISLupSbxu5xyLlQ==
X-CSE-MsgGUID: tK+TeODcTHK+qy1j08w/cw==
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232388596"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 07:48:24 +0200
Date: Mon, 21 Jul 2025 07:48:24 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
Message-ID: <alpine.DEB.2.22.394.2507210747070.18950@hadrien>
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de> <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr> <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de> <alpine.DEB.2.22.394.2507201608390.3477@hadrien> <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-190398625-1753076904=:18950"
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2882
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/alpine.DEB.2.22.394.2507210747070.18950%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-190398625-1753076904=:18950
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 21 Jul 2025, Markus Elfring wrote:

> > It's not clear whether you want to reduch parentheses in the semantic
> > patch (the only thing that is affected by an isomorphism) or in the C code.
>
> We got used to the order of operations to some degree.
>
> https://en.wikipedia.org/wiki/Order_of_operations
> https://en.cppreference.com/w/c/language/value_category.html
>
>
> How will the support evolve further for safe transformations of expressions?
>
> The entity “expression” is supported by the semantic patch language in
> a limited way so far.
> It is mapped to a single metavariable type. Metavariables matter at different places.
>
> * They can match some source code from context (or minus slice) specifications.
>
> * Metavariable contents can be reused for plus slice specifications.
>   Desirable source code adjustments should be “expressed” here.
>   Which control can we get on the advanced handling of parentheses then?

I have no idea what you are trying to do, and you are never going to
succeed with your strange way of expressing yourself.  If you want to know
how to do something, please provide a concrete and minimal example of C
code and show what you would like it to be transformed into.  That is the
only thing I can precisely understand.

julia
--8323329-190398625-1753076904=:18950--
