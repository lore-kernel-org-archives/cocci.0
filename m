Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D326C88E5C
	for <cocci@archiver.kernel.org>; Wed, 16 Sep 2026 09:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5gPYh1PILLBPua+4FUFKvlxAAj8zmZ69ciB5o+SLKtw=;
  b=WsJYuJ2SfX5OZMXIwGgVl9J2HQUl05fLMQOOsma5S5bl+9Nhqa5FPemS
   CWuYn6El/hongWlOUB2IMtTmh6i6Psdy6LVe9k8qgV+lhfzHcYoophURP
   JexAAvZ/dKGMaMNjbwi0okmyixgf+GGBKbH3AXhqpoNPjl9mrqx6eN3Zb
   M=;
X-CSE-ConnectionGUID: fe5aHbXMT2yaNrPqKu17jg==
X-CSE-MsgGUID: xZ2sUV1WRxCPNQp/Lb6qHQ==
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
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="295242842"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Sep 2026 11:25:34 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A11EB81817; Wed, 16 Sep 2026 11:25:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C104B827E2
	for <cocci@sympa.inria.fr>; Wed, 16 Sep 2026 11:25:28 +0200 (CEST)
X-CSE-ConnectionGUID: ixZEMsjWTpqqRP/tFEQe/g==
X-CSE-MsgGUID: 9YN/MSkWSSeYMCYm06vuyQ==
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="157066679"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 11:25:28 +0200
Date: Wed, 16 Sep 2026 11:25:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Johan Hovold <johan@kernel.org>
cc: Joshua Crofts <joshua.crofts1@gmail.com>, 
    Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org, 
    cocci@inria.fr
In-Reply-To: <aqpflCAorrufh1i0@hovoldconsulting.com>
Message-ID: <2267e5c2-2ebc-398b-b95-a92dac549ce5@inria.fr>
References: <20260915064327.1377-1-joshua.crofts1@gmail.com> <aqpflCAorrufh1i0@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v2] coccinelle: api: add a checker for
 pm_runtime_use_autosuspend() usage
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3735
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/vgKOyvTkO12jj0EQCsKkJg>



On Wed, 16 Sep 2026, Johan Hovold wrote:

> On Tue, Sep 15, 2026 at 06:43:27AM +0000, Joshua Crofts wrote:
> > Add a checker for ensuring that pm_runtime_dont_use_autosuspend() is
> > called in a file if pm_runtime_use_autosuspend() is called and its
> > devm_* counterpart isn't present.
> >
> > Without _dont_use_autosuspend(), removing devices causes resource leaks.
>
> No, as I've explained repeatedly elsewhere, it does not cause any
> resource leaks. [1][2]
>
> The autosuspend setting leaks if you will, but that only matters in the
> theoretical corner case of someone rebinding a different driver (which
> will soon also taint the kernel).
>
> So don't exaggerate the impact, this is essentially just a cleanup,
> which is fine in itself.

Thanks for the feedback.  Joshua, please update the patch accordingly.

julia

>
> > Assisted-by: LLM
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Johan
>
> [1] https://lore.kernel.org/all/aqpd3viN1UoZBkgL@hovoldconsulting.com/
> [2] https://lore.kernel.org/linux-iio/aow51Nk-cet9qaUQ@hovoldconsulting.com/
>
