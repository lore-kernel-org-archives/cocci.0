Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0252AC433FE
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 18:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=KqfZo408McmS91KuTIhNya7aCTF87XoT3P3hCx2Mlz8=;
  b=GizobBW67CRjWyrFc0TVwSBaGDGnBibsOlzmKPLbDhC3VrKr6xHb1AYX
   UYeZ0UM5GdApLm5U2BSC4V9jEr+pQCy7mA/fsL8cOjQCu0EYhiw2AiyRL
   mBFoN3TRV4o1i/LWYCAbGK9kznnhNWExdGa5Q8CQ+mbGDyqobD4W05KDQ
   Q=;
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
   d="scan'208";a="56688165"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 20:02:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3DB6CE0290; Sun,  9 Oct 2022 20:02:30 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C2D9DE0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 20:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KqfZo408McmS91KuTIhNya7aCTF87XoT3P3hCx2Mlz8=;
  b=jMXR/GtZpiwdKdJpAgLxpC6NH7QkEDlWYzW7BxuEORE7wRGDkOvIWTxI
   gp7kRZz7H6pTEVHrG0tDgy4ZeEw5PBYmJC/1ogF4yu55FtOeEm5lKdxEh
   DTg+/qA345tNonuAhFivzNTRA0mlT5UTLVdams7s3RPJ/geMRknl1wACA
   E=;
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="25894527"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 20:02:24 +0200
Date: Sun, 9 Oct 2022 20:02:24 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: cocci@inria.fr, "Jason A. Donenfeld" <Jason@zx2c4.com>
In-Reply-To: <202210091035.7D63B5FB@keescook>
Message-ID: <alpine.DEB.2.22.394.2210092001520.21609@hadrien>
References: <202210071600.078A2101@keescook> <alpine.DEB.2.22.394.2210080942250.3287@hadrien> <202210090808.AFE4016@keescook> <202210091035.7D63B5FB@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] how to check a for "don't care" state of a variable?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 636
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210092001520.21609%40hadrien>



On Sun, 9 Oct 2022, Kees Cook wrote:

> On Sun, Oct 09, 2022 at 08:10:16AM -0700, Kees Cook wrote:
> > On Sat, Oct 08, 2022 at 09:43:52AM +0200, Julia Lawall wrote:
> > > - x = e;
> > >   ... when != x
> > > ? x = e';
> > >
> > > The ? will stop the match if the thing is found, but won't require the
> > > presence of that thing for the match to be successful.
> >
> > Thank you! This worked perfectly. :)
> >
> > I'm starting to realize I should document my set of "with cocci, how do
> > I ...?" answers somewhere.
>
> Okay, initial dump is here:
>
> https://github.com/kees/kernel-tools/tree/trunk/coccinelle

Thanks.  I have added a link from the documentation page.

> And I've sent a PR for some missing docs in Coccinelle itself:
>
> https://github.com/coccinelle/coccinelle/pull/290

Could you send it by email please?

thanks,
julia

>
> (BTW, it looks like there are some other github PRs that can be closed?)
>
> --
> Kees Cook
>
