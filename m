Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B16CA1012
	for <cocci@archiver.kernel.org>; Sat,  6 Sep 2025 12:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0hzEHVsKkNtjUE6Xj+8UTwEJ+n6ikr7LGnStC5XsXm4=;
  b=FU2LFgdagSbfuUf8f5WD+4qpE/NJ66ypz3k9eUDEh/pIz2HLKYhybZEA
   hB9TzgE1muZvxEeq+0XfTMqv0WkHfTzyneRUHRnDmAAkJW9uorpcA6+yG
   ZolOhCUQ3TgOH6JR6GJzhYPGRvgD3Dd9eJaPHG+NQJ2O9lI7e8RXPiy2h
   4=;
X-CSE-ConnectionGUID: hYtzU54lT0eMU6PUhDJc9w==
X-CSE-MsgGUID: 2KhdPPjqTV2C4bQYiMhA1w==
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
X-IronPort-AV: E=Sophos;i="6.18,244,1751234400"; 
   d="scan'208";a="237814356"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2025 14:36:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 417C7E0BE9; Sat,  6 Sep 2025 14:36:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3304BE0171
	for <cocci@sympa.inria.fr>; Sat,  6 Sep 2025 14:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0hzEHVsKkNtjUE6Xj+8UTwEJ+n6ikr7LGnStC5XsXm4=;
  b=SH+x3mFx8ZY6mbvpqATMOsDWYkfZ2hfTP9KaWNz9wVgplVWiAIWHIGdh
   TWSZ6AcX8ThTQrfmP3fNL3RNUhI08Pzm4tUu8czSiNLUBWGRY+NkLNh5H
   6cbRhjNUeB29uw8rdOaGG8pKCBntPcNewNEYV5O6pBMI5eqcwQc47CHES
   M=;
X-CSE-ConnectionGUID: aRaXWgs+TEqbrsPr8xhDIw==
X-CSE-MsgGUID: zdzhruOrR8SSXd7uHaCPbQ==
X-IronPort-AV: E=Sophos;i="6.18,244,1751234400"; 
   d="scan'208";a="237814355"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 14:36:35 +0200
Date: Sat, 6 Sep 2025 14:36:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <360bb5e1-9a03-42dd-a009-818021ade0a3@web.de>
Message-ID: <a848fd8e-78c5-db39-ea78-4b5570a52666@inria.fr>
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de> <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de> <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr> <b0221946-43a5-43c0-8573-32c12e149681@web.de> <ba87aeca-594d-10b6-960-cd4aa1fcd1e6@inria.fr>
 <d28c6f76-6708-4dba-a446-910170e27572@web.de> <b2e58328-97f3-4f1-e588-4647c6ff30d3@inria.fr> <13ed7845-6fd9-4a8e-9670-3d2b7e7a0f4e@web.de> <ce7a7254-bbb3-4666-8a57-2e6cccaa51fc@web.de> <4959806f-e03e-9a59-63eb-f71b6bf6f954@inria.fr>
 <469a978c-5b6f-4cfd-99c6-69671de653ad@web.de> <e630c74d-c125-9d12-6bf8-59d1f5bbaafe@inria.fr> <360bb5e1-9a03-42dd-a009-818021ade0a3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for selected variable assignments (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3008
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/a848fd8e-78c5-db39-ea78-4b5570a52666%40inria.fr>



On Sat, 6 Sep 2025, Markus Elfring wrote:

> >>>> @find@
> >>>> expression e;
> >>>> position place;
> >>>> type t;
> >>>> t * pointer;
> >>>> @@
> >>>>  pointer = e(...);@place
> >>>>
> >>>> @display@
> >>>> position find.place;
> >>>> statement s;
> >>>> type find.t;
> >>>> t * find.pointer;
> >>>> @@
> >>>> *;@place
> >
> > This line certainly doesn't work.  It is searching for an empty statement
>
> I would like to interpret it in the way that there is an end of a known statement.
>
>
> > at a place where there is an assignment statement.
>
> The first SmPL rule determined that this can not be empty.
> Is it possible to avoid duplicated SmPL code here?

You can put an expression metavariable e.  But you can't put nothing.

julia
