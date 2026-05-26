Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3C3CD5BC8
	for <cocci@archiver.kernel.org>; Tue, 26 May 2026 08:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=7D8JrSEt+gFRrSXhZEjQC/P2GbPkkIAdBGcLYwRFTzg=;
  b=C0kT1JwEMzFZk4uig5SI603Ovl3vkay6aLj3sjBSTh/xb7Bj1ePDRumN
   cZz86SAJ8N5aux3zXV0JXxZEIBgswtJBQUxc/JSNcQ5Jrz2Uq2pKEMCaI
   oiPLjyH+aghLGhy16XMOxLcPlCOnuSeTFmLpq5s9XFoevmMD2Zy3iQQr3
   g=;
X-CSE-ConnectionGUID: G2sOwtM4Qh6BhfRqNhja1Q==
X-CSE-MsgGUID: jFrS79efRO+Jxe7W5g+ULQ==
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
X-IronPort-AV: E=Sophos;i="6.24,169,1774306800"; 
   d="scan'208";a="278192976"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 May 2026 10:53:15 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 81683862E4; Tue, 26 May 2026 10:53:15 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2A684862D8
	for <cocci@sympa.inria.fr>; Tue, 26 May 2026 10:53:11 +0200 (CEST)
X-CSE-ConnectionGUID: phoVzL+9StSdLjKBy9Ib0w==
X-CSE-MsgGUID: JjIhWlxDRnydT3rjP+qJtA==
X-IronPort-AV: E=Sophos;i="6.24,169,1774306800"; 
   d="scan'208";a="278192935"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 10:53:11 +0200
Date: Tue, 26 May 2026 10:53:10 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, vulab@iscas.ac.cn
In-Reply-To: <aa7e5643-3329-4fd2-9237-f85b9b9ba152@web.de>
Message-ID: <ef608d64-25d-b769-752f-774498a7cb52@inria.fr>
References: <47a6aeca-6c58-4be6-9a4e-a1d6726b5a0a@web.de> <85a837b7-8a6-5fb8-eeb-1e70c5f77b2e@inria.fr> <1da11354-3d73-4158-aa0b-98a143471a3b@web.de> <dac0391-4aa-f02-f8fc-2168c118e3ef@inria.fr> <dd4fa876-fe40-43ec-8184-05da70579973@web.de>
 <7cd8b09f-eb9a-c4f7-81a-6a2968c1c02@inria.fr> <c9941a16-38e8-ccb5-c07c-54ac1718a398@inria.fr> <f68596ce-db2c-40a7-9e79-e9448ad460e5@web.de> <84111447-1b1b-98e4-afb2-fae89bc79d5b@inria.fr> <eb4b825e-b849-40fd-ab79-dce3852ccfce@web.de>
 <4222b953-360-6e52-9952-14b4ce9e613@inria.fr> <4d68182d-dd59-46b2-9254-30c8a16cfc0b@web.de> <8ca35446-f68b-4664-dddf-b6de2b2c811@inria.fr> <0e6c3048-5bd7-411e-9151-1280050293de@web.de> <d06c1fd-8672-7d2d-6841-1954904ca4bc@inria.fr> <0d2d8fa3-ff1c-4c49-aecc-f599a9193ccf@web.de>
 <c68ba8b0-9be8-2531-8473-b88030aba527@inria.fr> <9adb6e2c-ea49-44ab-8d9f-fcd811cd7844@web.de> <f62fea9-d1c9-9dc5-79c0-7cdec44825a7@inria.fr> <aa7e5643-3329-4fd2-9237-f85b9b9ba152@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Checking evaluation of another SmPL script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3519
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/wj0EI6fIeo53TqRwNrF4kw>



On Tue, 26 May 2026, Markus Elfring wrote:

> >> How would anybody get such an information from the software documentation
> >> with sufficient certainty (according to usage of SmPL asterisks)?
> >
> > Well, * puts a - on every line that contains a matched token.
>
> Fine.
>
> The clarification is continuing.
>
>
> >                                                                - is a
> > single character and there can be multiple matches, so it seems pretty
> > obvious.
>
> The discussion is evolving around the source code search for a selected
> pair of function calls.
> Did you notice that more code was marked than intended because of long lines?
> Are other application concerns more relevant here?

When there is a token that is matched by *, the whole line is marked with
-.  In the patch notation there is no way to mark only part of a line.
It is done this way ebcause in emacs it is possible to jump directly from
a diff line to the affected line in the code.  If you want a different
behavior, you can use position variables to print information about the
precise matched position.

>
> > --no-loops doesn't introduce non existent paths.  It only removes the
> > back edges in loop operators.
> Did you indicate uncertainty about corresponding software functionality?

No uncertainty.

julia
