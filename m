Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E24BCD98F0
	for <cocci@archiver.kernel.org>; Sun, 21 Jun 2026 08:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nMJTUoElN9dbve4BCvTcYbpvaViEGjO4pqxaFJ4TtBs=;
  b=npJ3xA8Df8i21HHODBrkLMqos8lDTs3rs+t3W+GeK9L1ckma1ItK2V7h
   rKQT7AXSCnuRXLfhWHOT+7fRl0xJIGx1hHpCPhAZ+8kIma8eRiypgB3gB
   FRq2KDxDM82HWrlNYMyBheTVO1g0WGhsrgCXrrI66C+rgE61UotWupJvP
   A=;
X-CSE-ConnectionGUID: l9obUp2dR7q1biGphp6d7Q==
X-CSE-MsgGUID: 7KkV/+JrSYS25yqnsgfx+w==
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
X-IronPort-AV: E=Sophos;i="6.24,216,1774306800"; 
   d="scan'208";a="282607394"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jun 2026 10:24:26 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id DC0C380505; Sun, 21 Jun 2026 10:24:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 95258803DB
	for <cocci@sympa.inria.fr>; Sun, 21 Jun 2026 10:24:18 +0200 (CEST)
X-CSE-ConnectionGUID: iZ+U3ZRGS4CNAMaA4Of+HA==
X-CSE-MsgGUID: KHuZDk3mRW2zBWdhNrzXxQ==
X-IronPort-AV: E=Sophos;i="6.24,216,1774306800"; 
   d="scan'208";a="150018825"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 10:24:18 +0200
Date: Sun, 21 Jun 2026 10:24:18 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <0eb4882d-3659-494a-b5ed-0c4a7e94df2b@web.de>
Message-ID: <e44e99c5-7665-d025-f169-f8abd6c5c5@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de> <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de> <eb219668-8de8-a61-f852-4f16328e1832@inria.fr> <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de> <bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr> <fe461478-4479-4384-a6fc-bce86f338707@web.de> <df229e71-6f2b-46e8-88b8-e5cdb321b2fb@web.de>
 <ab10711d-81ae-9254-215d-3676c361fde@inria.fr> <180730f8-bf12-4898-97d3-d209aac45e32@web.de> <308db487-90df-8ad9-4160-be6efd1bdf28@inria.fr> <e0f44b96-0509-4094-817a-7c28ac57db3c@web.de> <42bf9713-9c39-4163-98e5-bf92a4d97ef6@web.de>
 <d6f13137-9943-4177-8895-7f6ff5bc606c@web.de> <94ae57f9-ed91-42c3-b10c-753061276552@web.de> <dde6758-b236-fc5f-ebc2-e2a1323814@inria.fr> <0eb4882d-3659-494a-b5ed-0c4a7e94df2b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3584
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/jl76StaabBH1MsS9ARfB-w>



On Sun, 21 Jun 2026, Markus Elfring wrote:

> >> The last kfree() call is counted here despite of the implementation detail
> >> that it is actually not explicitly specified within a known if branch.
> >>
> >> How would you determine the incidence distribution for discussed if branches
> >> from all Linux source files then?
> > As now mentioned numerous times, you have to prevent the ... from matching
> > a goto.
>
> Does this suggestion indicate a known data processing conflict for which we would be
> looking for a better solution than a code exclusion?

No.  Its a nice and indtended feature of Coccinelle that if branch
patterns drift over gotos.  Because often you want to know what is
reachable from the if branch, not exactly what is between the {}.  If you
want something different, you have to specify that.

julia
