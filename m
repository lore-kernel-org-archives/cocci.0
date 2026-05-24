Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45549CD5BAB
	for <cocci@archiver.kernel.org>; Sun, 24 May 2026 06:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0VCQskGFImrDCGHP1KdIQVrcZgXcTYno9sd44x5rD2k=;
  b=Ca2yLX8VoIv+hH0jRtN+3YPIu9GGoRwJdwrDh1vfvv7UzXRURcXaUvrH
   0uT63r5D6grJldjy7LCGkqWlSqLLfAaEUbbkJxapUHABIt6yRc2h4rxfb
   idDpZUh1xL4f66qWu1sDTZMbUXO4AdTj7mGlorRbgwo6PgbCzPyI6CDr4
   0=;
X-CSE-ConnectionGUID: 1ZWFa/ZRSjCTDvjiR/XSBA==
X-CSE-MsgGUID: 97WJH+OPSH6CqEUcVfWF7A==
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
X-IronPort-AV: E=Sophos;i="6.24,165,1774306800"; 
   d="scan'208";a="277994139"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 May 2026 08:37:23 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 45301804B7; Sun, 24 May 2026 08:37:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 728FB804B7
	for <cocci@sympa.inria.fr>; Sun, 24 May 2026 08:37:16 +0200 (CEST)
X-CSE-ConnectionGUID: /hWyVikQRfebPmBXm1Tm2w==
X-CSE-MsgGUID: utVmvBS7SXqVQD3jwoBvEQ==
X-IronPort-AV: E=Sophos;i="6.24,165,1774306800"; 
   d="scan'208";a="147426289"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 08:37:16 +0200
Date: Sun, 24 May 2026 08:37:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, vulab@iscas.ac.cn
In-Reply-To: <dd4fa876-fe40-43ec-8184-05da70579973@web.de>
Message-ID: <7cd8b09f-eb9a-c4f7-81a-6a2968c1c02@inria.fr>
References: <47a6aeca-6c58-4be6-9a4e-a1d6726b5a0a@web.de> <8397220-4b66-acd4-32e2-cfa72ee7ac66@inria.fr> <25fb88dd-4573-4897-98ae-f5904a2324cd@web.de> <85a837b7-8a6-5fb8-eeb-1e70c5f77b2e@inria.fr> <1da11354-3d73-4158-aa0b-98a143471a3b@web.de>
 <dac0391-4aa-f02-f8fc-2168c118e3ef@inria.fr> <dd4fa876-fe40-43ec-8184-05da70579973@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-787626873-1779604636=:33802"
Subject: Re: [cocci] Checking evaluation of another SmPL script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3508
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/7sMqxAQE6UEhCIClLyGU0g>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-787626873-1779604636=:33802
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 23 May 2026, Markus Elfring wrote:

> >>> Maybe try --no-gotos.
> >> Where is such a program parameter explained?
> >
> > spatch --help.  Like all the other command line arguments.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d827b8b9627a841c85c9/enter.ml#L650-651
>
> Would you expect that a more detailed explanation will appear also in the document “spatch_options.tex”?

I added an entry to this file.

julia

>
> Are we still looking for more helpful guidance than the hint “drop all jumps derived from gotos - unsafe”?
>
> Regards,
> Markus
>
--8323329-787626873-1779604636=:33802--
