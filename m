Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B18606A324
	for <cocci@archiver.kernel.org>; Sun,  1 Nov 2026 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=WKCrL2X7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=iR1PkMCGioT83Lr22OKwS6xnbl0LkFIxtbGUSz+GNTs=;
  b=WKCrL2X7JDWCtC8DKEyFhGh6dB75XyFqH4liCybMsgRXO2cP3KXr7TjB
   PWcu5vBz5VswM9b7In9IiwINFgN1NtIjRRrwhf9RgoLYK3gxVEtaHf+l8
   mgYL8muN4b2Q2zwEdc69JEzr/pIqM3zgQhjPzhNpZtZ+V//fHpXUXR/RS
   A=;
X-CSE-ConnectionGUID: K6V60/NUQ/G/D0xNKJiB5Q==
X-CSE-MsgGUID: 0tbrSUS8RTK7DoSr30GNrw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,190,1787004000"; 
   d="scan'208";a="303208865"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Nov 2026 16:05:13 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 90FD580355; Sun,  1 Nov 2026 16:05:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D0A7E81434
	for <cocci@sympa.inria.fr>; Sun,  1 Nov 2026 16:05:08 +0100 (CET)
X-CSE-ConnectionGUID: aDNy7RhGQwqgoxsRYcHIHg==
X-CSE-MsgGUID: Kog4sLtsRzuUpZQ8Pdqaqg==
X-IronPort-AV: E=Sophos;i="6.27,190,1787004000"; 
   d="scan'208";a="303208856"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien-2.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 16:05:08 +0100
Date: Sun, 1 Nov 2026 16:05:08 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, tools@kernel.org, kernel-janitors@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <aefccf2d-3ca6-4d15-9026-649fb0a0f63c@web.de>
Message-ID: <b55ad049-86e0-f737-a96a-f3151db5012@inria.fr>
References: <aefccf2d-3ca6-4d15-9026-649fb0a0f63c@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [RFC] Distributed data processing for SmPL scripts
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3757
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/NpHgyHl8AfvOqJLghWq3Ww>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Sun, 1 Nov 2026, Markus Elfring wrote:

> Hello,
>
> Some developers got used to tools which support distributed data processing
> for compilation tasks.
>
> Examples:
> https://www.distcc.org/
> https://github.com/icecc/icecream

Maybe such things can just be used off the shelf, since Coccinelle can be
invoked from make.

In any case, I have no intention of working on this.  If you want to
contribute something, please go ahead.

julia

>
>
> Would you be looking for similar needs also according to source code analyses
> and transformations?
>
> Regards,
> Markus
>
>
