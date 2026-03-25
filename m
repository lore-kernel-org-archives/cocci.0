Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB305FEA82C
	for <cocci@archiver.kernel.org>; Wed, 25 Mar 2026 07:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=o2dODzUM5Swfdhd53IJrgSxlPJEDppprX1kLs79FkXg=;
  b=o1rTofZDWC0Uk4Ls54BuE+h0AV90Ne0ZUivXm8+02GxKjubLvY48x5aX
   Ddp7QWJ7tm0Uu03t+DW1GyRD65SLeYzUqQT5Gmviegw8GOQOLLxoXJt8M
   OVZCbjeIjk8ubivwxuMTHNjQxyRQDkYJfkVk+kk73JWQc/ENnegQzoAt6
   c=;
X-CSE-ConnectionGUID: yEpyK76IR3KKTPFbkiygdQ==
X-CSE-MsgGUID: UpQjJnPuRRKw3TPB/+9/nQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,139,1770591600"; 
   d="scan'208";a="269363033"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2026 08:30:19 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id CCBEC80F20; Wed, 25 Mar 2026 08:30:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9FA20805D7
	for <cocci@sympa.inria.fr>; Wed, 25 Mar 2026 08:30:10 +0100 (CET)
X-CSE-ConnectionGUID: pd9zQrH6RwO87Gu05nOqew==
X-CSE-MsgGUID: vc7jHqSnTE+PMpi8eONLaQ==
X-IronPort-AV: E=Sophos;i="6.23,139,1770591600"; 
   d="scan'208";a="142254663"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 08:30:10 +0100
Date: Wed, 25 Mar 2026 08:30:10 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <d87a6e33-4c15-466d-b7a9-c7dac5d16146@web.de>
Message-ID: <e290d8c5-93a-744b-66a3-57b1ee941da6@inria.fr>
References: <d87a6e33-4c15-466d-b7a9-c7dac5d16146@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Adjustments for first statements from selected function
 implementations?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3447
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/zqGfyLmY0LWoZyhogiJUtw>



On Wed, 25 Mar 2026, Markus Elfring wrote:

> Hello!
>
> A contribution like the following shows how a statement can occasionally be added
> to the beginning of a function implementation.
>
> PM: runtime: Mark last busy stamp in pm_request_autosuspend()
> 2025-06-18
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=18c1fe53d186867243f4cf17f4eef60737a16c4c
>
> Such an adjustment triggers further opportunities for corresponding collateral evolution.
> The semantic patch language can help in the determination to some degree
> if the mentioned statement is still specified before a call of the known function
> at other source code places.
> A desire can evolve then to omit repeated statements before more selected function calls.
>
> Usual case distinctions trigger further development challenges.
>
> * How would you prefer to manage function names (for SmPL scripts)?
>
> * Several inline function implementations are also stored in header files.
>   Some header files tend to provide contents which are not really supported
>   by the Coccinelle software so far.
>
>
> Would you be looking then for further possibilities with improving affected
> data processing?

I looked at the link, but I really have no idea what any of this means.

As long as inline functions are parseable, it doesn't matter about the
other contents of header files.

julia
