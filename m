Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D5AD29C33
	for <cocci@archiver.kernel.org>; Mon, 19 Jan 2026 15:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Odm9EynJwnC2c0Qw33OjqYiHJ7/bP95EZih0yNLZM/s=;
  b=lo5xeQPU9zWloaWtAqltDwe1z18RQ10DvbTW+ikFSjtBh96yG3cn96OF
   gy03/RiYLhvCV+QIIXOWWvyAjVY9gY1Mtc1ZbMFCqPVghXWNM1goGpRjT
   o1WIcFtoHYei0MIm8KQU2nnnyv9bp+Y2LOK/D1d2pBWJsyJxp8DR4fRFV
   k=;
X-CSE-ConnectionGUID: +XLJo0LyTKau+qfwYW9mFQ==
X-CSE-MsgGUID: NSbA0DcFRAWkicYIxe6Hew==
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
X-IronPort-AV: E=Sophos;i="6.21,238,1763420400"; 
   d="scan'208";a="259301211"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jan 2026 16:23:38 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 31CF283841; Mon, 19 Jan 2026 16:23:38 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id BBD708383D
	for <cocci@sympa.inria.fr>; Mon, 19 Jan 2026 16:23:31 +0100 (CET)
X-CSE-ConnectionGUID: yqYbOn5gSWq/PNhJCUsNVw==
X-CSE-MsgGUID: wHV5APdYQWybnF3vV3eX+w==
X-IronPort-AV: E=Sophos;i="6.21,238,1763420400"; 
   d="scan'208";a="136416191"
Received: from unknown (HELO hadrien) ([4.26.64.170])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 16:23:30 +0100
Date: Mon, 19 Jan 2026 10:23:29 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de>
Message-ID: <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr>
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3271
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/WRMvf-Ttl6aYd7NPxD92hQ>



On Mon, 19 Jan 2026, Markus Elfring wrote:

> Hello,
>
> Felix Gu pointed also another software correction out.
>
> [PATCH] regulator: fp9931: Add missing memory allocation check
> https://lore.kernel.org/lkml/tencent_5FCF2108621C51007E5526A7C60A5CC1F306@qq.com/
> https://lkml.org/lkml/2026/1/18/129
>
>
> Such an update candidate can be found also by the following tiny SmPL script.
> https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/regulator/fp9931.c#L441-L442
>
> @display@
> expression action, action2, pointer;
> identifier member;
> @@
> *pointer = action(...);
> *pointer->member = action2(...);
>
>
> May I expect that the same data processing result can be achieved together with
> the application of an SmPL nest construct?
>
> @display@
> expression action, pointer;
> identifier member;
> @@
> *pointer = action(...);
> *<+... pointer->member ...+>
>  ;

Since you haven't told me what happens when you run this, I don't know
what the issue is.
But it may work better with () around the <+... ...+>, to avoid a parsing
conflict.

julia


>
>
> Regards,
> Markus
>
