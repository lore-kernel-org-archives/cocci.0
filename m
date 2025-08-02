Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B787BC87FC9
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 11:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=hFPjIXpOdcDvr7R23VjBMiIUkqIDPDn91BxiS5bVNnM=;
  b=jZwyrL8MMAqLIJCz0QCeqR8DJNoVfZPUpQNsJrU0zOPLQB6qt9rpFgC1
   hJ4OLDp9q9YyGszqy7Cajw31f8W1JQbw3oGvLPtFeH+TDD7W6Qbcb37XE
   DctMsWH1Mkdz7dgjw2Lx5SIqXf3d4c1g0ZrijiL6RS8pc+EV3EVeRKVAq
   k=;
X-CSE-ConnectionGUID: OuH56d7iRQqxYopP4Pszkg==
X-CSE-MsgGUID: EGhrFvurQXGwDk/8q3gi9A==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
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
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233953042"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 13:54:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EBF09E0C55; Sat,  2 Aug 2025 13:54:25 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E42AAE0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 13:54:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hFPjIXpOdcDvr7R23VjBMiIUkqIDPDn91BxiS5bVNnM=;
  b=i2tKS+s9FpE1BFsDSHYxCUIOPc6IKfmBJQQ1do6LxnxvGNHfj6lhMlj9
   DggWJT7Jb/A8yTB7x1EU1MBFpwg7h1ZwMsn6qztmzU/d4lA9q42lYrj/Q
   7sSAl0DIYxP9/V1rc7WjeQmsOmpZWES36aJVgTx44pqBftOVYUabXCYEa
   s=;
X-CSE-ConnectionGUID: i/h+TkX8SSC7HWsSnj1nkw==
X-CSE-MsgGUID: G+0KN2OSQPCkCxwROXkVug==
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233953037"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 13:54:23 +0200
Date: Sat, 2 Aug 2025 13:54:22 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr, 
    Erick Karanja <karanja99erick@gmail.com>
In-Reply-To: <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de>
Message-ID: <alpine.DEB.2.22.394.2508021353080.3428@hadrien>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de> <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr> <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de> <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr> <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de> <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr> <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de> <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de> <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-749026857-1754135662=:3428"
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2929
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/alpine.DEB.2.22.394.2508021353080.3428%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-749026857-1754135662=:3428
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 2 Aug 2025, Markus Elfring wrote:

> >>> Would you get into the mood to clarify data processing challenges better
> >>> for another source code search pattern (like the following)?
> >>
> >> How reasonable would you find a test result for another source code search approach?
> >
> > Completely reasonable.
>
> I got an other understanding for the functionality of the Coccinelle software here
> so far.
>
>
> >                         You match pairs of subsequent locks, but you only
> > mark the second one in the pair.  So you match two pairs:
> >
> > action_lock(&blockage1); and action_lock(&blockage2);
> >
> > and
> >
> > action_lock(&blockage2); and action_lock(&blockage2);
> >
> > and you mark the second one in each case.
>
> It seems that our data processing expectations differ once more.
>
>
> > It would greatly help communication if you would also provide the answer
> > that you expect.
>
> A “shortest path constraint” is mentioned for the usage of the SmPL ellipsis.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/3aa9a6ab3b035e31292be31399b99a8857480aef/docs/manual/cocci_syntax.tex#L1035-1043
>
>
> …>> @display@
> >> expression x, y;
> >> @@
> >>  action_lock(x);
> >>  ... when != action_unlock(x);
> >> *action_lock(y);
>
> May I expect that only a single call should be marked for such a test case?

No, I already explained why two calls are marked.

The shortest path constraint is that for A ... B, the ... doesn't contain
A or B.  It doesn't mean that the rule can't match at multiple places in
the function.

julia
--8323329-749026857-1754135662=:3428--
