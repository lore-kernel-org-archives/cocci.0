Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A559C87FD2
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 13:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=EwggF85N/14wyiNosZFuXt0YdJown4d3nVQ/L6lWKcA=;
  b=ahILY6rx5eEs9mAEll+JQobphhqVEc0t1vSKpV0hX1y2pGtyUXrg7tIC
   5lYdBeal/71IXoE1J05/eafVuFCxVgLGeUwcRokUU1zRavHqWiW/UxbSG
   lY9YXq0NxxZUqAmK1fsY6IK9CJpmyyREQa3QP0jy5RKoocVVgoynBoUfM
   U=;
X-CSE-ConnectionGUID: V1xAIvseRtyWIX8l0AvvmA==
X-CSE-MsgGUID: Rc/bowIsRX2CBRHvNM2IkA==
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
   d="scan'208";a="233956242"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 15:05:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1BBE4E0BE9; Sat,  2 Aug 2025 15:05:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E67CBE0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 15:05:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EwggF85N/14wyiNosZFuXt0YdJown4d3nVQ/L6lWKcA=;
  b=TjHnQYmJzP/I/DqeRT2KzWU2VtD9tP/qpIMvQc07cyS7hOz12l+jd/1F
   +4ESRGgG08uWf3/dKE0vHVijj1I0d+jMOTQnjqVATR25vaEZ5WaEI1gxs
   EMHn9H13cfG7aHK+FvY+eiPNAm2TiysUNh7bVZEG9lr9liSi9z1/utu4Q
   E=;
X-CSE-ConnectionGUID: ABTSTleVQj6cRCvQZHUuOQ==
X-CSE-MsgGUID: SLTbt4NoQoeDeYVgK5MIwQ==
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233956241"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 15:05:12 +0200
Date: Sat, 2 Aug 2025 15:05:11 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Erick Karanja <karanja99erick@gmail.com>
In-Reply-To: <c5042d2d-43df-4276-9611-da4f30763940@web.de>
Message-ID: <alpine.DEB.2.22.394.2508021502250.3428@hadrien>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de> <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr> <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de> <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr> <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de> <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr> <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de> <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de> <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de> <alpine.DEB.2.22.394.2508021353080.3428@hadrien> <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de> <alpine.DEB.2.22.394.2508021409080.3428@hadrien> <c5042d2d-43df-4276-9611-da4f30763940@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1350981493-1754139911=:3428"
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2933
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/alpine.DEB.2.22.394.2508021502250.3428%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1350981493-1754139911=:3428
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 2 Aug 2025, Markus Elfring wrote:

> >>>> May I expect that only a single call should be marked for such a test case?
> >>>
> >>> No, I already explained why two calls are marked.
> >>
> >> I see further challenges with this explanation approach.
> >>
> >>
> >>> The shortest path constraint is that for A ... B, the ... doesn't contain
> >>> A or B.
> >>
> >> This is generally fine.
>
> How does the “shortest path” fit to the statement “action_lock(&blockage2);”
> from the if branch in your software view?

I explained it already.  If you have A ... B, Coccinelle doe not allow A
or B to occur in the code matched by ...

A problem that you see to insist on causing is that by using * you have
no idea which matches involve which pieces of code.  If you would print
the line numbers of the involved calls then things would be clear.

>
> Can the path distance be determined anyhow?
>
>
> >>>          It doesn't mean that the rule can't match at multiple places in
> >>> the function.
> >>
> >> I find that this information will need further clarifications.
> >
> > Coccinelle considers every node in the control-flow graph and checks
> > whether the pattern can be matched at that point.  Each mach is
> > independent.  There is no guarantee that one match will not cross another
> > one.  Furthermore, (just in case this is the concern) when you mentin two
> > different metavariables, there is no guarantee that they are not bound to
> > the same term.
>
> I am looking for further clarifications also according to such general information.
> How will related technical details be represented in an improved software documentation?
>
> Will it become more desirable to distinguish metavariable contents in an
> unique way?

If you want something you have to express it in Coccinelle.

foo(A)
...
(
foo(A)
|
*foo(B)
)

ensures that the marked foo(B) involves a different argument than the
matched foo(A).

julia
--8323329-1350981493-1754139911=:3428--
