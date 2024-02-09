Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD66C48297
	for <cocci@archiver.kernel.org>; Fri,  9 Feb 2024 09:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=aat7cuFgMmJk5bB2kPR82MW4YxZgj8vGN56UG0YtAA8=;
  b=Nd8caShTcVcdbXpv9j5Cjx1MhbVAGnia7PDlc2V5+Wbq48kohsAGPFUV
   5bAgnCE3+L4t19FkOmMgfgRZUtQanLr5MWTI13/esIRWSebVza/srn0il
   91xtRwjwmqWjg1kvSEDaUa7UL2cW2LX2bIPWDWmar5A12jzpS7myGUjM7
   s=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.05,256,1701126000"; 
   d="scan'208";a="151140651"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Feb 2024 10:30:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 97F6AE00B7; Fri,  9 Feb 2024 10:30:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 47ECAE008A
	for <cocci@sympa.inria.fr>; Fri,  9 Feb 2024 10:30:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aat7cuFgMmJk5bB2kPR82MW4YxZgj8vGN56UG0YtAA8=;
  b=oLjj2Ku8DCVH8fnaaVRuCz7yvaOdl7pYogV+f84RPnR+gfvq/jb8id//
   OYVJ9ym+jPCDIO2uWjCIddhDs9MT4HPpxf1MlRnIe1VxjgpqimhtwFqsC
   fMW6Tqw+DKv+QGH8CanowaGf3VB49dn69pxfuF2mYAN/rVCcqBW+c1+FF
   M=;
X-IronPort-AV: E=Sophos;i="6.05,256,1701126000"; 
   d="scan'208";a="151140622"
Received: from unknown (HELO hadrien) ([163.173.89.5])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 10:30:43 +0100
Date: Fri, 9 Feb 2024 10:30:43 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <70dc14fc-5e21-4eee-be17-c9fd30b99cef@web.de>
Message-ID: <856ae5f3-f31a-2661-90ae-6041c3318893@inria.fr>
References: <41052adc-2065-4cf2-9160-2e986de1bf9b@web.de> <289a052b-86ff-4ecd-ae55-89fc0238373e@web.de> <alpine.DEB.2.22.394.2402072108500.3138@hadrien> <d983ec62-2e0e-4102-bddc-4c420a75601b@web.de> <51feebc2-751d-4e1b-bf72-28dc8ed975c9@web.de>
 <eb10beb1-c8b-47e5-ab28-5c1bba502d2a@inria.fr> <70dc14fc-5e21-4eee-be17-c9fd30b99cef@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Supporting transformations better according to reduced
 number of function call parameters
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1528
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/856ae5f3-f31a-2661-90ae-6041c3318893%40inria.fr>



On Fri, 9 Feb 2024, Markus Elfring wrote:

> >>> Will the understanding improve also together with a script variant
> >>> (like the following) for the semantic patch language?
> >> @selection disable decl_init@
> >> expression action;
> >> identifier var;
> >> position call_pos, declaration_pos;
> >> type t;
> >> @@
> >> (t * var@declaration_pos;
> >>  ... when != var
> >>      when any
> >>  action@call_pos(..., &var, ...)
> >>  ... when exists
> >>  var
> >> |
> >> *t * var@declaration_pos;
> >>  ... when != var
> >>      when any
> >> *action@call_pos(..., &var, ...)
> >> )
> >>
> >>
> >> Are there any opportunities left over to increase the avoidance of duplicate
> >> data processing also together with the application of SmPL disjunctions?
> >
> > I think you would want the disjunction to start with the call to action.
>
> No, not for this use case.
>
> The case distinction is essential here that a variable declaration
> must be preserved for one function/macro call while it may eventually
> be considered for deletion according to an other function/macro call variant.
>
> The semantic patch language supports some metavariable types.
> Special restrictions can be achieved by combining them with the means of conjunctions.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/4965f42eb94d2d67f7375c66b268997457cbcefb/docs/manual/cocci_syntax.tex#L1041
>
> Can it be that a branch of a SmPL disjunction can not directly benefit from
> metavariable matches in previous branches by reusing their contents so far?

I don't think it is useful to do anything for this.

It may be simpler to just make a change, and then delete all variables
that are never used in a separate rule, given that normally all variables
are used, so unused ones are likely ones that you made be unused.

julia
