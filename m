Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C063CD5BB1
	for <cocci@archiver.kernel.org>; Sun, 24 May 2026 11:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=wqbW3+N4Jfepj8367xJ7eow22egLWqRVUuNAK7e2XIs=;
  b=X58fgLrKYU/rEQKswDmKcDqSieYhdn4f+vzm6Z0oBSfc2BruGvCQyD6M
   I3qhDoQyDyqV3K3TNVsya/YmzfHnKYjNjjSPbTqlakJEPZVo2/1MR0MgU
   NiEcRQ0fmGXDsaCf5pUPI2/tZGggGD8FjKTnEeAu5XTAVvd4Hq8enQdQh
   g=;
X-CSE-ConnectionGUID: 9Z0/ifP4Ru+cJG2UzINNuA==
X-CSE-MsgGUID: qOJajchxTlCT+GPBMO7VcQ==
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
   d="scan'208";a="278009746"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 May 2026 13:47:45 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E71C1812B7; Sun, 24 May 2026 13:47:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4C13D8125C
	for <cocci@sympa.inria.fr>; Sun, 24 May 2026 13:47:38 +0200 (CEST)
X-CSE-ConnectionGUID: QwHGv16jTxW8NVl0EHnfkw==
X-CSE-MsgGUID: usSY0PPZQGuuwHpfDix+9g==
X-IronPort-AV: E=Sophos;i="6.24,165,1774306800"; 
   d="scan'208";a="278009729"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 13:47:38 +0200
Date: Sun, 24 May 2026 13:47:38 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr, vulab@iscas.ac.cn
In-Reply-To: <4d68182d-dd59-46b2-9254-30c8a16cfc0b@web.de>
Message-ID: <8ca35446-f68b-4664-dddf-b6de2b2c811@inria.fr>
References: <47a6aeca-6c58-4be6-9a4e-a1d6726b5a0a@web.de> <8397220-4b66-acd4-32e2-cfa72ee7ac66@inria.fr> <25fb88dd-4573-4897-98ae-f5904a2324cd@web.de> <85a837b7-8a6-5fb8-eeb-1e70c5f77b2e@inria.fr> <1da11354-3d73-4158-aa0b-98a143471a3b@web.de>
 <dac0391-4aa-f02-f8fc-2168c118e3ef@inria.fr> <dd4fa876-fe40-43ec-8184-05da70579973@web.de> <7cd8b09f-eb9a-c4f7-81a-6a2968c1c02@inria.fr> <c9941a16-38e8-ccb5-c07c-54ac1718a398@inria.fr> <f68596ce-db2c-40a7-9e79-e9448ad460e5@web.de> <84111447-1b1b-98e4-afb2-fae89bc79d5b@inria.fr>
 <eb4b825e-b849-40fd-ab79-dce3852ccfce@web.de> <4222b953-360-6e52-9952-14b4ce9e613@inria.fr> <4d68182d-dd59-46b2-9254-30c8a16cfc0b@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1674376045-1779623258=:33802"
Subject: Re: [cocci] Checking evaluation of another SmPL script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3512
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/UGO6uC-cZcQzPzcyZtrj1w>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1674376045-1779623258=:33802
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 24 May 2026, Markus Elfring wrote:

> >> How will development ideas evolve accordingly?
> >
> > I don't know what the above is supposed to do.  The semantic patch looks
> > completely wrong to detect a use after free.  One would expect thta a
> > detection of use after free would mention free somewhere.
>
> The following SmPL script variant expresses a known implementation detail explicitly.
>
>
> @display@
> identifier i;
> expression e;
> @@
> *i = malloc(...);
>  ... when != i = e
> *free(i);
> *i->x = e
>
>
>
> >                                                            But the
> > obtained result looks completely correct for the provided semantic patch
> > (as well as a hypothetical semantic patch that would check for use after
> > free).
> The result for this reduced test shows so far that a single diff hunk
> is generated (while additional ones occurred according to the bigger implementation
> of the function “pnfs_update_layout”).
> Function sizes probably influence hunk generation.
> Will such case distinctions become more interesting?

If you want me to comment on something, you have to include both the
semantic patch and the C code.  I can't guess whether you have used again
the C code that you provided in a previous email (where obtaining a single
huk seemed fine).  Please also provide precise information about the
result you expect.

julia
--8323329-1674376045-1779623258=:33802--
