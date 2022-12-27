Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F469C10F1B
	for <cocci@archiver.kernel.org>; Tue, 27 Dec 2022 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=hlR1c86SVn0gXYe1uzOw/yvpeDC7AH0uOBr/oJEylv4=;
  b=nP1G/AJ/14jHjQ1UajajRbv44NPkSCB3qz+Zv3IuXLaWxeu/Rs0POGly
   M4kqggGSmyxrX9Ca8GAlZnLt31xZrlLE4HGweaSro8Z6TAOWQru8m4f+c
   FwGPIInS6XIA0zdnVjC+d9Ij8IC8NpU/oQPQd9FzCvDXYmxvGRiAVbsIL
   Y=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.96,278,1665439200"; 
   d="scan'208";a="85139268"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2022 10:47:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 27CE0E0138; Tue, 27 Dec 2022 10:47:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 261ACE0128
	for <cocci@sympa.inria.fr>; Tue, 27 Dec 2022 10:47:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hlR1c86SVn0gXYe1uzOw/yvpeDC7AH0uOBr/oJEylv4=;
  b=u15Kh0z9XAG05LBbGGGw8nhd001sSGsFPc4OW1ZP4nWUdSmxAMf6uN01
   YqsW/vlvbW8k1nOVxpr4bcHaw1W4cD4Bf161GzOQa/auF9p5HzqLk4B0O
   lrii0uUTP3cSrS6GS+7BhJhvz1w8Y5bt6MqMT1szpJWvGwz3cw+02fp/L
   c=;
X-IronPort-AV: E=Sophos;i="5.96,278,1665439200"; 
   d="scan'208";a="43687106"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 10:47:54 +0100
Date: Tue, 27 Dec 2022 10:47:52 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <29059e41-6c8e-56d9-48c0-d4cc61e02e77@web.de>
Message-ID: <alpine.DEB.2.22.394.2212271047470.2927@hadrien>
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de> <alpine.DEB.2.22.394.2212260740380.2980@hadrien> <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de> <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr> <29059e41-6c8e-56d9-48c0-d4cc61e02e77@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Another extension for the software documentation
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 798
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/alpine.DEB.2.22.394.2212271047470.2927%40hadrien>



On Tue, 27 Dec 2022, Markus Elfring wrote:

> > Lists can be empty.
>
>
> Are you going to add this information to the SmPL manual?
>
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/87350d742df39d847b15af39865329c2fe23460d/docs/manual/cocci_syntax.tex#L315

OK
