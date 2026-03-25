Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF80FEA835
	for <cocci@archiver.kernel.org>; Wed, 25 Mar 2026 08:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=aOJreweHRPqU9SJaTwWCRDu3hAene1kMhDQswwfJk4U=;
  b=QzaSdUr7KyrPLPm3hf1BtEArDaDklg6bns2FqIwfrkzFAJB/lX063d3o
   tRtAwXBQRGt9JbdYTUnamsKyOyzFQR+Lw89OceaFMyidnhcqg75Qqmwcr
   0hnkTMP6Kbrdj6+pHn0/PnLdvGPbYElGNYjsjeB93l7w0ynwhaGgn/uA4
   E=;
X-CSE-ConnectionGUID: HbFxVJrHQ7ucn4wDjmTylQ==
X-CSE-MsgGUID: OT31Hs4jTOmUZaiKQZc3tQ==
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
   d="scan'208";a="269383741"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2026 09:52:38 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id EF31181717; Wed, 25 Mar 2026 09:52:37 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 92E748066F
	for <cocci@sympa.inria.fr>; Wed, 25 Mar 2026 09:52:34 +0100 (CET)
X-CSE-ConnectionGUID: 3rtjJb+3Q2qxYqVkvIM5NQ==
X-CSE-MsgGUID: dH1EqKDBQ/aVInrV8iW82g==
X-IronPort-AV: E=Sophos;i="6.23,139,1770591600"; 
   d="scan'208";a="269383718"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 09:52:34 +0100
Date: Wed, 25 Mar 2026 09:52:34 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <1f5a4f0b-ed5e-4e16-a39d-f1289b7a50aa@web.de>
Message-ID: <73d88351-640-62a8-189-4e9f8a8a24db@inria.fr>
References: <1f5a4f0b-ed5e-4e16-a39d-f1289b7a50aa@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for function calls with known parameters (by
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3450
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/1-2chAO_a7trjIf34pQnxA>



On Wed, 25 Mar 2026, Markus Elfring wrote:

> Hello!
>
> A function like pm_request_autosuspend() has got the property that it needs
> a single input parameter.
> https://elixir.bootlin.com/linux/v7.0-rc5/source/include/linux/pm_runtime.h#L460-L483
>
> Such an implementation detail can be easily determined also by the means of
> the semantic patch language.
> I imagine that corresponding data processing would become more challenging
> if it should be determined that a varying number of parameters would be passed
> to other function calls at the beginning.
> Can function calls be restricted to known parameters accordingly?

I still have no idea what you are asking about.  What is the connection
between a function call being placed at the beginning of a function and
the number of parameters that that function call requires?

julia
