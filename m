Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B287C83F25
	for <cocci@archiver.kernel.org>; Mon, 21 Jul 2025 11:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=eaafLMOawvIPkzwul2QpOAG6HPk0BYO8LFYhHbBZAsY=;
  b=N8CmdY4IRqppG9pRm8qXli4F0TBaJWfz5nas3mkFsoTtXRuV9c1ApM21
   3DAg5TJHy1sUhVmk75ZGdmsbd/ALL3ht4ken6FPYt5H/oNPoElzazfzZy
   Mrm7k83hwE1ttZrspHXiXoehXiXv540FylzJWOmGOAv3+/hZ79eFIe/TQ
   4=;
X-CSE-ConnectionGUID: tGUTJNj3Q86erdEd+RfMdQ==
X-CSE-MsgGUID: vXhJqcgZRwyp4uhSwcVuUQ==
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
   d="scan'208";a="232448230"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jul 2025 13:00:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C9323E0C55; Mon, 21 Jul 2025 13:00:57 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C7C55E0172
	for <cocci@sympa.inria.fr>; Mon, 21 Jul 2025 13:00:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eaafLMOawvIPkzwul2QpOAG6HPk0BYO8LFYhHbBZAsY=;
  b=CryO7L0B/L2yVNJOhZ8VAW2boouKYVo+K1iSjU3TpgSNsc17hxBh2wHm
   yVyC5jjdM9Ty6XNLM6YuKOPrgXNY6LcUm2QIMgNNLNiBqpSAExRfbGxSS
   f4jiFQs7iBT37Br0T8vba60lLcTGIR+lH/sRm+jfvEnROYE89vEVE4uG7
   k=;
X-CSE-ConnectionGUID: sI6ljvq0T6mNqud3PBv6YA==
X-CSE-MsgGUID: XoFKV6JORgmbLTLRAU1G2w==
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="121838871"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 13:00:53 +0200
Date: Mon, 21 Jul 2025 13:00:53 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <9154fc36-842b-4797-9b55-397cfdcba283@web.de>
Message-ID: <2914d20-68da-a23d-6345-fd48f0b9bed8@inria.fr>
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de> <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr> <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de> <alpine.DEB.2.22.394.2507201608390.3477@hadrien> <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
 <alpine.DEB.2.22.394.2507210747070.18950@hadrien> <6fa377f7-0612-42aa-afbc-cdeab8bea314@web.de> <8a4b47e2-725e-769e-6bb-43e01113f9fa@inria.fr> <52ce78f5-8141-46dc-9ad0-5cbfedfd92a1@web.de> <cd40be57-cdef-7834-5c8d-eda49eb3a8b@inria.fr>
 <9083cb34-5f8a-43d9-b908-43a9fe2a4281@web.de> <4752963-ce2-3e23-fe61-9cbd1acbbdc1@inria.fr> <9154fc36-842b-4797-9b55-397cfdcba283@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2893
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/2914d20-68da-a23d-6345-fd48f0b9bed8%40inria.fr>



On Mon, 21 Jul 2025, Markus Elfring wrote:

> >> Would you find it really easier to clarify known data processing challenges
> >> with the help of another SmPL script example?
> > I at least understand th script.  But I don't kjnow what problem does it raise?
>
> Can you recognise development concerns better from another SmPL code variant?
>
>
> @adjustment@
> expression e;
> statement s;
> @@
> -if
> +my_result =
>     (e)
> +&& true;
> -   s

And what is the problem?

If you don't want the parentheses around e, then remove them.

julai
