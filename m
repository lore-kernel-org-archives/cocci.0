Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B64FE5207
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2026 10:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=SPKZp0GZEaqUSXDFQVscZgn2nZy8LwKoY4lUzco+RBU=;
  b=uJVFUtqGvTZOYc/FlbKEp0Ry31/6zAytH/qFreijl4F5tU6hvkJB6i6M
   rzOm1AKZy0Y1TvbGneZP11xEo++a8Ze3kFyU2u0VcZVTMMmgWOM3QNByN
   JplpNXqJ1FRANICatV5G3IK8a8P09tT+4BQsU0AvsEr2d24HCQDMq/PsO
   k=;
X-CSE-ConnectionGUID: EHLgh0lJR1+MSHa6GI2p/Q==
X-CSE-MsgGUID: 6PMOJghhQGyTYgc+/l6zkg==
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
X-IronPort-AV: E=Sophos;i="6.23,196,1770591600"; 
   d="scan'208";a="273975800"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2026 12:58:49 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6BE95815F8; Fri, 24 Apr 2026 12:58:49 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 014FA812D5
	for <cocci@sympa.inria.fr>; Fri, 24 Apr 2026 12:58:46 +0200 (CEST)
X-CSE-ConnectionGUID: 2r7TIJXVRRq+f95lPZfm+Q==
X-CSE-MsgGUID: NTkVAqvwR+ivIA//CPpZTA==
X-IronPort-AV: E=Sophos;i="6.23,196,1770591600"; 
   d="scan'208";a="273975778"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 12:58:46 +0200
Date: Fri, 24 Apr 2026 12:58:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <138f6f86-b875-42fd-bc00-f0ad5e1f6f6b@web.de>
Message-ID: <f93c2682-64ef-7a25-239b-5e7e98144a6@inria.fr>
References: <138f6f86-b875-42fd-bc00-f0ad5e1f6f6b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Planning the next software release?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3482
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/8rwlwBje1po0rHW5UsHpAw>



On Fri, 24 Apr 2026, Markus Elfring wrote:

> Hello,
>
> Some software adjustments were published recently.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/commits/master?ref_type=heads
>
> Will any refinements be taken still into account for another software release?
> https://github.com/coccinelle/coccinelle/issues/337
> https://github.com/coccinelle/coccinelle/issues/308
>
> With which delay will known improvements become available for general applications?

What is a known improvement that you are concerned about?  I think that
everything that is considered to be working is in the master branch and
will be propagated to the next release when it is ready.

julia

>
> Regards,
> Markus
>
