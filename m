Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F18C87FD2
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=UHiQeswobuOwnbuPwdajPTCZVuDZIrspO3ZQOpE0zvM=;
  b=FlpVD2hHjp1fzc4LCbTXS/P1PBiNDSppRbzkn4qFwxZRgIAvMnQ1nOS8
   C5UfMGHC3om4ST6ech/xIJBQL5Fr0/m+yvsjKBKW8sd2AEofUVajXomEZ
   NVljw26Lquo35/SnHJTG/jTy+RdelERR3610q28sy23rsOmo1ca5tpjr/
   Y=;
X-CSE-ConnectionGUID: 4lkqjFqMTr6pwKun0Qj9qA==
X-CSE-MsgGUID: jVbBtxrMTm+JxIkc/0ecpw==
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
   d="scan'208";a="233958775"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 15:45:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3AB3BE0C55; Sat,  2 Aug 2025 15:45:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1EA4BE0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 15:45:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UHiQeswobuOwnbuPwdajPTCZVuDZIrspO3ZQOpE0zvM=;
  b=HCuRMLalqbr8faHb4tDQui+orUxSyrHiCJPDgCKlFy3Sv3Rt53H6lrTq
   0mapZSvNeSqb31u/lAEnCmVmFPrTgcHJKQA7AaVwyQlCsHnM6WyvCNAdS
   v1WESIoIVV4m+XPFvd+qxFooeccwjjiGQa8awfs6RLYo9gr3F8yj/dSyG
   M=;
X-CSE-ConnectionGUID: Jgms2utOSGWpw+ilP/AIdg==
X-CSE-MsgGUID: 53g5SYgsRdOb6V/RhQb/YA==
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233958772"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 15:45:32 +0200
Date: Sat, 2 Aug 2025 15:45:31 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Erick Karanja <karanja99erick@gmail.com>
In-Reply-To: <04403bf5-82f6-4c23-a217-0063f802e8ed@web.de>
Message-ID: <alpine.DEB.2.22.394.2508021541010.3428@hadrien>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de> <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr> <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de> <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr> <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de> <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr> <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de> <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de> <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de> <alpine.DEB.2.22.394.2508021353080.3428@hadrien> <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de> <alpine.DEB.2.22.394.2508021409080.3428@hadrien> <c5042d2d-43df-4276-9611-da4f30763940@web.de>
 <alpine.DEB.2.22.394.2508021502250.3428@hadrien> <04403bf5-82f6-4c23-a217-0063f802e8ed@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-762617535-1754142332=:3428"
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2935
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/alpine.DEB.2.22.394.2508021541010.3428%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-762617535-1754142332=:3428
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 2 Aug 2025, Markus Elfring wrote:

> >>>>>> May I expect that only a single call should be marked for such a test case?
> >>>>>
> >>>>> No, I already explained why two calls are marked.
> >>>>
> >>>> I see further challenges with this explanation approach.
> >>>>
> >>>>
> >>>>> The shortest path constraint is that for A ... B, the ... doesn't contain
> >>>>> A or B.
> >>>>
> >>>> This is generally fine.
> >>
> >> How does the “shortest path” fit to the statement “action_lock(&blockage2);”
> >> from the if branch in your software view?
> >
> > I explained it already.  If you have A ... B, Coccinelle doe not allow A
> > or B to occur in the code matched by ...
>
> How does the second lock call fit to these criteria?

In the two matches I mentioned earlier there was no intermediate lock
call.

> > A problem that you see to insist on causing is that by using * you have
> > no idea which matches involve which pieces of code.
>
> Partly, yes.
>
> The source code search patterns can occasionally be constructed with more
> unique context data.
> I hope still that undesirable data processing confusion can be reduced further.
>
>
> >                                                      If you would print
> > the line numbers of the involved calls then things would be clear.
>
> I hope still that a better consensus can be achieved also for safer applications
> of the SmPL asterisk functionality.

I have no idea what is considered to be unsafe. In any case, * is only
intended as a convenience.  It works well with emacs to jump to the
affected region of code.  Then you can study it and see what you really
want to do.

>
>
> >> Can the path distance be determined anyhow?
>
> I would appreciate a more helpful answer here.

No idea what this means nor why exact path distance is relevant.  The
point is that there may be some longer paths that start and end with A and
B, but that also contain instances of A and/or B.  By default Coccinelle
doesn't return them.

But * doesn't reflect the result of a single match.  It reflects the
result of all possible matches.  So they can overlap.

>
>
> …>>> independent.  There is no guarantee that one match will not cross another
> >>> one.  Furthermore, (just in case this is the concern) when you mentin two
> >>> different metavariables, there is no guarantee that they are not bound to
> >>> the same term.
> …>> Will it become more desirable to distinguish metavariable contents in an
> >> unique way?
> >
> > If you want something you have to express it in Coccinelle.
> >
> > foo(A)
> > ...
> > (
> > foo(A)
> > |
> > *foo(B)
> > )
> >
> > ensures that the marked foo(B) involves a different argument than the
> > matched foo(A).
>
> Would you like to provide a “guarantee” here?

Sure, it is guaranteed.

julia
--8323329-762617535-1754142332=:3428--
