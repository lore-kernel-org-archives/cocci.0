Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81280CD98C5
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2026 15:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xb4Fj8HAdbXsYzqO88CDHqrvxZD+9jy4utG4NYXIZhg=;
  b=uQjeh0hK2DUNXXMQCx+5+XcIGpscGCLLE+vg6am9qRYrJwudvnzS/NLM
   LrwliRXijLyd0K9bf/pxn1QNQBzL7Njk4l4B7QeyQl7xxCLPP9H/jz6Tv
   L1Arcm4gpIHGz1lfz6bAFkz+0bWKR3yNYJ4q1eKECJlfnQ3cxc6NVunPB
   M=;
X-CSE-ConnectionGUID: T+/YsfgdS8OJCfR3bGyBUw==
X-CSE-MsgGUID: RA7fhv5NQj2j50468CzZEA==
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
   d="scan'208";a="281642407"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Jun 2026 17:21:01 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9F09F82209; Mon, 15 Jun 2026 17:21:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id E5A0080097
	for <cocci@sympa.inria.fr>; Mon, 15 Jun 2026 17:20:57 +0200 (CEST)
X-CSE-ConnectionGUID: aKzsk8g0Qn2BOlYYoEazBg==
X-CSE-MsgGUID: QqOUB9wGRjasWogw+hQAfQ==
X-IronPort-AV: E=Sophos;i="6.24,206,1774306800"; 
   d="scan'208";a="281642387"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 17:20:57 +0200
Date: Mon, 15 Jun 2026 17:20:57 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <2e28798b-a09e-48ad-89d8-b44c5c49bb4d@web.de>
Message-ID: <5c6fba-d5cd-bea-a7ec-f5fa4bc0a912@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de> <bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr> <fe461478-4479-4384-a6fc-bce86f338707@web.de> <7c8b2f73-224a-6b6-5154-5d913bca7bfb@inria.fr>
 <2342f3b4-989f-4a4b-a208-f827a9add0f9@web.de> <37939c7b-ad18-ab42-20a-4b4bb3be7bad@inria.fr> <2e28798b-a09e-48ad-89d8-b44c5c49bb4d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3572
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/JgcpZFP6khAfr3G9lR6jCA>



On Mon, 15 Jun 2026, Markus Elfring wrote:

> >> I am trying to determine once more how plausible the mentioned data processing results are.
> > It would be better to look at them yourself.
>
> I started to take another look at a few of the mentioned function implementations.
>
>
> Examples:
> info|arch_xen_unpopulated_init|regs|rc
> first|./arch/arm/xen/enlighten.c|410|2
> tail|./arch/arm/xen/enlighten.c|410|2
>
> https://elixir.bootlin.com/linux/v7.1-rc7/source/arch/arm/xen/enlighten.c#L307-L413
> False positive

I already explained how to solve this problem.  You should forbid a goto
before at least one of the kfrees.  You may need two rules to forbid a
goto before each one.

julia

>
>
>
> info|kvm_eiointc_create|s|ret
> first|./arch/loongarch/kvm/intc/eiointc.c|642|3
> tail|./arch/loongarch/kvm/intc/eiointc.c|656|3
>
> https://elixir.bootlin.com/linux/v7.1-rc7/source/arch/loongarch/kvm/intc/eiointc.c#L614-L658
> Appropriate update candidate
>
>
>
> info|device_str_attr_create|s|NULL
> first|./arch/powerpc/perf/hv-24x7.c|506|2
> tail|./arch/powerpc/perf/hv-24x7.c|506|2
>
> https://elixir.bootlin.com/linux/v7.1-rc7/source/arch/powerpc/perf/hv-24x7.c#L470-L507
> Questionable
>
>
> Regards,
> Markus
>
