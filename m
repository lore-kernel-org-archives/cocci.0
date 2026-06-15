Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46821CD98CF
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2026 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=w9V9s9oLhB+mQH9EmQTQwz5B+d/TA4Gxc4QuzmwoljY=;
  b=JUhBYsfpISiZpQe1Xw8hfuNkhCyY+k2Ml0q1v2TwiVUZoEQIRpGjUczA
   J8ZhfUMlhdR8BBnzYHvxhb8NIq/xmGLCr8YUK462igWsMw25p3pE7YL0n
   ff6Zkwa4i86rrY/6WKitwcKGNQNl3CKd90YMm7QmThHqjjv7/IRDy2gsF
   8=;
X-CSE-ConnectionGUID: /lqzJoTlRne9EpdRRI/HuA==
X-CSE-MsgGUID: AXRDsMXBTwOnTKqLPx276Q==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.24,206,1774306800"; 
   d="scan'208";a="281648970"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Jun 2026 17:50:15 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3DCF682224; Mon, 15 Jun 2026 17:50:15 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 6136180E57
	for <cocci@sympa.inria.fr>; Mon, 15 Jun 2026 17:50:11 +0200 (CEST)
X-CSE-ConnectionGUID: hKpG3ip+QVOEXCn5Mb3Ysw==
X-CSE-MsgGUID: 1aOElxOJTReHUrRZkeTduQ==
X-IronPort-AV: E=Sophos;i="6.24,206,1774306800"; 
   d="scan'208";a="281648919"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 17:50:11 +0200
Date: Mon, 15 Jun 2026 17:50:11 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <7ef40ec3-66d6-4cd3-b083-dcfaabc157b7@web.de>
Message-ID: <39717f14-7775-55c3-dbb1-dcee855985de@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de> <bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr> <fe461478-4479-4384-a6fc-bce86f338707@web.de> <7c8b2f73-224a-6b6-5154-5d913bca7bfb@inria.fr>
 <2342f3b4-989f-4a4b-a208-f827a9add0f9@web.de> <37939c7b-ad18-ab42-20a-4b4bb3be7bad@inria.fr> <2e28798b-a09e-48ad-89d8-b44c5c49bb4d@web.de> <5c6fba-d5cd-bea-a7ec-f5fa4bc0a912@inria.fr> <7ef40ec3-66d6-4cd3-b083-dcfaabc157b7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3573
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/HWz0yLeKvn97tAtjLpi1CA>



On Mon, 15 Jun 2026, Markus Elfring wrote:

> >> Examples:
> >> info|arch_xen_unpopulated_init|regs|rc
> >> first|./arch/arm/xen/enlighten.c|410|2
> >> tail|./arch/arm/xen/enlighten.c|410|2
> >>
> >> https://elixir.bootlin.com/linux/v7.1-rc7/source/arch/arm/xen/enlighten.c#L307-L413
> >> False positive
> >
> > I already explained how to solve this problem.
>
> I found your hint too terse.
> https://lore.kernel.org/cocci/b33f13ff-b2aa-22df-71-1d776789cf4@inria.fr/
> https://sympa.inria.fr/sympa/arc/cocci/2026-06/msg00012.html
>
>
>
> >                                                 You should forbid a goto
> > before at least one of the kfrees.  You may need two rules to forbid a
> > goto before each one.
>
> Will such a code exclusion influence the search for goto chains in special ways?
>
>
>
> >> info|device_str_attr_create|s|NULL
> >> first|./arch/powerpc/perf/hv-24x7.c|506|2
> >> tail|./arch/powerpc/perf/hv-24x7.c|506|2
>
> Should it be avoided anyhow that the mentioned source code positions become the same?

Coccinelle has nothing built in to do that.  If you want some effect you
have to express that yourself in the rule.

julia
