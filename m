Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F263D35176
	for <cocci@archiver.kernel.org>; Wed,  1 Apr 2026 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=mGy8tMpAfMiubaziJ0XtiJUP+20dEecWntdqMK56tYw=;
  b=U6YeZn4z5yUeoVsbd+uJloVJXUGrthyIcsvpWful2nRXduX8mDP+glth
   G2v3IXc1rK7wTHcx2JMxOO9cMEMEbm87EpQ/rVouk2EiqqUyJDHzKUZAU
   LYY1qRY5JfPwMO9tg6RFEe8Y+pANggAH9IwWq/PSXUpGj9yTr4Ds97Ixc
   4=;
X-CSE-ConnectionGUID: 6AlEa5OETuSQEELdtsXZZA==
X-CSE-MsgGUID: 5AUX2ReNR9unHxEizlfBnQ==
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
X-IronPort-AV: E=Sophos;i="6.23,153,1770591600"; 
   d="scan'208";a="270523620"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Apr 2026 12:59:16 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 29BEF81FAA; Wed,  1 Apr 2026 12:59:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id E921881FA2
	for <cocci@sympa.inria.fr>; Wed,  1 Apr 2026 12:59:13 +0200 (CEST)
X-CSE-ConnectionGUID: AU2qIE6PSrugEGXuL253vQ==
X-CSE-MsgGUID: qO1YfXiFTMOb5XaOG6EWaA==
X-IronPort-AV: E=Sophos;i="6.23,153,1770591600"; 
   d="scan'208";a="270523590"
Received: from c-76-123-3-53.hsd1.va.comcast.net (HELO hadrien) ([76.123.3.53])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 12:59:13 +0200
Date: Wed, 1 Apr 2026 06:59:11 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <b3686b73-09a8-4b10-b860-5a49b9462b11@web.de>
Message-ID: <628489f5-4d5a-b1c5-fcbc-278648b52462@inria.fr>
References: <51b9e38a-7e91-4c39-86d1-25da2c6af376@web.de> <5c3257fb-1e91-46c0-ab00-f105ccb437d4@web.de> <b3686b73-09a8-4b10-b860-5a49b9462b11@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Logical consequences for applications of SmPL
 conjunctions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3470
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/r8EPVxuPyo3BVSdMJxschw>



On Wed, 1 Apr 2026, Markus Elfring wrote:

> Would you find SmPL code (like the following) not so useful in comparison to
> indicated software functionality according to another published test case?
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d827b8b9627a841c85c9/tests/andid.cocci
>
>
> @duplicate_metavariable_type@
> identifier x, y;
> @@
> (x
> &y
> )

Certainly it does not seem very useful.  But maybe there is some need to
have two names for the same thing.

In the test you refer to (that you could have easily included in the mail
instead of making me wait to have to load a link) the identifier
metavariables have different constraints, so the pattern is useful.

julia


>
>
> Regards,
> Markus
>
