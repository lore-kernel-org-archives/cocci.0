Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E66C27C40
	for <cocci@archiver.kernel.org>; Wed, 22 Nov 2023 20:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ru2R+NQ/o3/uCEPJ5UFpMMak81DPIyJ/voK9B2TQhRs=;
  b=gssCgTkxeiOw1UXas31qhCRX5SBtbSBBEX/7LJzwQI+l+PF5VRQwIE4y
   SkOiJtTrcM+WmIVLKBWLkMGmhqUE/86oxFvAjfo+Ej99/Tjhmv29BMJzT
   Wdxzt5idmBqMBzH9gGXkvrVWymHu29tKwrPzbvri39wZwoj0BwGAVfGPp
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="137975908"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Nov 2023 21:33:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 14C9EE0CCC; Wed, 22 Nov 2023 21:33:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D05C7E0AF1
	for <cocci@sympa.inria.fr>; Wed, 22 Nov 2023 21:33:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ru2R+NQ/o3/uCEPJ5UFpMMak81DPIyJ/voK9B2TQhRs=;
  b=StJrD3EFL8A0qVf/we7g+Y96F2MaQR2EWKQKhyKh1NLrG5e5nf9VzdqX
   5rcv+mqDpVF/5ktDX6J4v/4YVW7N4ep3nJXZGttsI+stVbhxjAGtdIs7w
   1ZpfpsvNfOQNMtAHPdTqqUAW3EeafAlDzsS/eq60+b+UpDF7bC08+Up/3
   w=;
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="72301159"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 21:33:02 +0100
Date: Wed, 22 Nov 2023 21:33:02 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de>
Message-ID: <alpine.DEB.2.22.394.2311222131120.3262@hadrien>
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de> <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr> <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1309
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/alpine.DEB.2.22.394.2311222131120.3262%40hadrien>



On Wed, 22 Nov 2023, Markus Elfring wrote:

> >> Some statements in if branches correspond to exception handling approaches.
> >> Would you become interested to detect a few statements from the last if branch
> >> in a generic way (with the means of the semantic patch language)?
> >
> > Normally that would be an if without an else that ends in a return.  So
> >
> > if (...) {
> >   ...
> >   return ...;
> > }
>
> I would interpret such a simple source code search approach in the way
> that some if branches can be found.
> But it would be uncertain then if this code block would be really
> the last one within a selected control flow.

It would seem that it would be the last one, because there is no else.
But one could have a different optinion abou what "last one" means.  If
you don't want any subsequent ifs, then you can put ... after th } and put
when != if (...) S1 else S2

>
> > The ... on the second line will be allowed to go over gotos.
>
> A goto statement can occasionally also occur instead of the suggested
> return statement.

As I said, the ... will go over the goto onward to the return.

julia
