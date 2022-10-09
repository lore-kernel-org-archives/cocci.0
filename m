Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A705C433FE
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 18:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ejZzVMk7F8MXkeYMwOh7BtsUNQFpBRqjaQtCM+5S/PI=;
  b=q28TZUhUeaWM+7PARMLwafulMUTDiGZLQOYmgCUjt0Pc0kQJtK+5xbMn
   7SjUecDtbcw8HM8qQ17acCh0rh8CecmP4VbGhUZeRd4a0tPxcEeHGyKNY
   vcytvI9ElDXTNLPDDMYZL7fBG1hMOGkFtiCZjmTKo9q76r2mU/XWuB1qZ
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="56688738"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 20:19:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6E3ECE02A3; Sun,  9 Oct 2022 20:19:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B650DE0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 20:19:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ejZzVMk7F8MXkeYMwOh7BtsUNQFpBRqjaQtCM+5S/PI=;
  b=RHCQewu9WQNf8VU3R6+mqLPkkJv71rSRetuJlHfB95ngep5xcBUUhiru
   0gVWyNg8j+/GwREBNNzvIqBOQK6yEdDODfBNL4syxjBTw/BrojXILtRea
   iAHI8KCxRwAEAVSxPYPGW8Fl417LbGWRn0r9e38PrqkliLXEQ/oD0yVjD
   s=;
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="25894909"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 20:19:36 +0200
Date: Sun, 9 Oct 2022 20:19:36 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: cocci@inria.fr, "Jason A. Donenfeld" <Jason@zx2c4.com>
In-Reply-To: <202210091116.3CA9AFE@keescook>
Message-ID: <alpine.DEB.2.22.394.2210092018320.21609@hadrien>
References: <202210071600.078A2101@keescook> <alpine.DEB.2.22.394.2210080942250.3287@hadrien> <202210090808.AFE4016@keescook> <202210091035.7D63B5FB@keescook> <alpine.DEB.2.22.394.2210092001520.21609@hadrien> <202210091116.3CA9AFE@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] how to check a for "don't care" state of a variable?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 639
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210092018320.21609%40hadrien>



On Sun, 9 Oct 2022, Kees Cook wrote:

> On Sun, Oct 09, 2022 at 08:02:24PM +0200, Julia Lawall wrote:
> > Thanks.  I have added a link from the documentation page.
>
> Thanks!
>
> > > And I've sent a PR for some missing docs in Coccinelle itself:
> > >
> > > https://github.com/coccinelle/coccinelle/pull/290
> >
> > Could you send it by email please?
>
> Done now.

Thanks

> Is there a good place for finding this python documentation? I
> didn't see anything that really showed how to use it, and have mostly
> gone off of existing examples.

I'm not really an expert on what is supported in python.  Someone once
suggested that reflection could be used to find out what functions are
available.  Normally, they are the same as are supported for OCaml.

julia
