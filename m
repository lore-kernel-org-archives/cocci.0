Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EACCD98C5
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2026 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=IAqd+XnYEJ5cvPTXidFhzTZLAB5vxvkD6OTYfdSPI38=;
  b=DDG4MrM3frEyI9qVgrMlmijYkUaH3FXVTjQNOp3cMZmsPWaM5trN5xcl
   qFaALXPLGVHoMevvdOAJfjdGB0ryFFpJrbFPOcRbuaC/AcdKTCZ8iP53p
   3n4q+vJGAMOQOGK6VgAzxQhrURFU4naSZ/z4Ou2vhvfys6Ur58QVfAwoS
   I=;
X-CSE-ConnectionGUID: 85LQSN1uS5+4r7UzqmHJmw==
X-CSE-MsgGUID: f9s93nqMRhmwivNfuGRIoA==
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
   d="scan'208";a="281653086"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Jun 2026 18:05:28 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9BEF88221E; Mon, 15 Jun 2026 18:05:28 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id E09188221E
	for <cocci@sympa.inria.fr>; Mon, 15 Jun 2026 18:05:26 +0200 (CEST)
X-CSE-ConnectionGUID: HTpd3OrnQlmdlRobVqhpag==
X-CSE-MsgGUID: n2/MNKldSFCZ5RWhz4mmtA==
X-IronPort-AV: E=Sophos;i="6.24,206,1774306800"; 
   d="scan'208";a="281653073"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 18:05:27 +0200
Date: Mon, 15 Jun 2026 18:05:26 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <ed858c6f-8001-4ac6-87f0-4aaaff7a7843@web.de>
Message-ID: <df2ae6d0-61f1-6022-7ef0-8a13bb6914ec@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de> <bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr> <fe461478-4479-4384-a6fc-bce86f338707@web.de> <7c8b2f73-224a-6b6-5154-5d913bca7bfb@inria.fr>
 <2342f3b4-989f-4a4b-a208-f827a9add0f9@web.de> <37939c7b-ad18-ab42-20a-4b4bb3be7bad@inria.fr> <2e28798b-a09e-48ad-89d8-b44c5c49bb4d@web.de> <5c6fba-d5cd-bea-a7ec-f5fa4bc0a912@inria.fr> <7ef40ec3-66d6-4cd3-b083-dcfaabc157b7@web.de> <39717f14-7775-55c3-dbb1-dcee855985de@inria.fr>
 <ed858c6f-8001-4ac6-87f0-4aaaff7a7843@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2000011710-1781539526=:3490"
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3574
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/dm0b1Rs0MegnzJ17V4LwZw>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2000011710-1781539526=:3490
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 15 Jun 2026, Markus Elfring wrote:

> >>>> info|device_str_attr_create|s|NULL
> >>>> first|./arch/powerpc/perf/hv-24x7.c|506|2
> >>>> tail|./arch/powerpc/perf/hv-24x7.c|506|2
> >>
> >> Should it be avoided anyhow that the mentioned source code positions become the same?
> >
> > Coccinelle has nothing built in to do that.
>
> I suggest to reconsider such a view in more detail.
>
> I would appreciate more clarity about corresponding software functionality.
>
> How can separately specified if branches be “merged” into the same place?
>
>
> >                                              If you want some effect you
> > have to express that yourself in the rule.
> I can try to avoid known open issues by additional OCaml/Python scripting.
>
> But it seems that I need to know some technical details better accordingly.

Do whatever you want.  It seems that the problem is that gotos lead to the
same place where a single kfree is found.  So forbidding gotos on the path
would avoid false positives.  Perhaps it is not a perfect solution.  A
more perfect solution may require a dedicated tool.

julia
--8323329-2000011710-1781539526=:3490--
