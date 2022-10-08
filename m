Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27015C433F5
	for <cocci@archiver.kernel.org>; Sat,  8 Oct 2022 09:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xoXc/TRiT5i2aa4fLqqCMF9VoSzzVwQ3L8kdSbgYNoA=;
  b=MO66HQHDbth2WQM2D0XCZ5VskgvBcsoagMK5OahnnLCCJ1hpiR1D4mHT
   F7LGXejBzzSDIXDqYOMToJaocddQvNeY+QC8bY0h4ZtxKkZY1rqJYc2Oe
   P23VdWpEczeTrIXlCUQ6igS68MU1QxSxbedoa1W9jzNdRme8ZDbSvHFXt
   c=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.95,169,1661810400"; 
   d="scan'208";a="56598554"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Oct 2022 11:00:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7BDD8E02A3; Sat,  8 Oct 2022 11:00:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 769ACE0121
	for <cocci@sympa.inria.fr>; Sat,  8 Oct 2022 11:00:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xoXc/TRiT5i2aa4fLqqCMF9VoSzzVwQ3L8kdSbgYNoA=;
  b=Ltb8r9LRK1KwcyMxD0zi0QhS990oGfz9S+Y4X95s6Ea5pSQaaoBcIIgc
   o4E1Lul3JBZDdEXdmHd82Voh/ef4c2yr6vR4l1T36Yg0R8IqWFb31v4DW
   v1QuF2l8jHTawtzUirZL5CCzGHhRjGkphqWB7xuoD0pDlF7RswCAwL5HX
   c=;
X-IronPort-AV: E=Sophos;i="5.95,169,1661810400"; 
   d="scan'208";a="25834918"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 11:00:23 +0200
Date: Sat, 8 Oct 2022 11:00:22 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Kees Cook <keescook@chromium.org>, cocci@inria.fr, 
    "Jason A. Donenfeld" <Jason@zx2c4.com>
In-Reply-To: <e7757758-6882-9f3e-749e-276a0e972a5d@web.de>
Message-ID: <alpine.DEB.2.22.394.2210081059500.3287@hadrien>
References: <202210071600.078A2101@keescook> <alpine.DEB.2.22.394.2210080942250.3287@hadrien> <e7757758-6882-9f3e-749e-276a0e972a5d@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] how to check a for "don't care" state of a variable?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 620
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210081059500.3287%40hadrien>



On Sat, 8 Oct 2022, Markus Elfring wrote:

> >> I was looking at doing some conversions for this[1], and I wasn't sure
> >> how to check for removing a variable assignment if there was either no
> >> more uses or the next use was an assignment itself.
> >>
> >> i.e.:
> >>
> >> 	var = 1;
> >> 	other = func(var);
> >>
> >> turns into:
> >>
> >> 	other = func(1);
> >>
> >> but this would not:
> >>
> >> 	var = 1;
> >> 	other = func(var);
> >> 	report(var);
> >>
> >> without getting confused by:
> >>
> >> 	var = 1;
> >> 	other = func(var);
> >> 	var = 5;
> > - x = e;
> >   ... when != x
> > ? x = e';
> >
> > The ? will stop the match if the thing is found,
>
>
> Does such an SmPL code indicate a need for a double check of the affected C source code?

No idea what the question means.  But there should not be any extra
overhead for using ?

julia

>
>
> > but won't require the presence of that thing for the match to be successful.
>
> Can such an advice trigger further improvements for the software documentation?
>
> Regards,
> Markus
>
