Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A39BC433F5
	for <cocci@archiver.kernel.org>; Sun, 20 Mar 2022 22:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=tp7BaUuj0fxjnCXWtUdzI/53nUVBph+68xivB5E/UEg=;
  b=abCaU/Rw9ug9OEM2kbaQ69a2ksC6rEWLosQZ/NM1QiQ72Hvtx9RJuXw4
   wDHTYyGUzzk1f1appZhUEb2gzODULSaFBE+aiHfxpXdMLHji8JQvwWymu
   0ygZBg2as2dInesLEzZDIIgdkkCp7Euim2tcb7/mANzM73GjZF7Vwonj7
   4=;
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
X-IronPort-AV: E=Sophos;i="5.90,197,1643670000"; 
   d="scan'208";a="27107302"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Mar 2022 23:23:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7E008E0219; Sun, 20 Mar 2022 23:23:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 63442E0069
	for <cocci@sympa.inria.fr>; Sun, 20 Mar 2022 23:23:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tp7BaUuj0fxjnCXWtUdzI/53nUVBph+68xivB5E/UEg=;
  b=ZtyzaZLxaTPWbMtS+wNyztJdlT/2nhqEoPH/YuReqv9O//rCoUfV1t/S
   rG6WYitMfEWHDMShBy51qwqzD11totVr+jf3Si9EdLDxZZUBS5NXv7omZ
   j4VotK02AYcuKjj7h/91EX1LH4537ASTsi7/h9qEIUUJYyIGWfnOSyv3e
   E=;
X-IronPort-AV: E=Sophos;i="5.90,197,1643670000"; 
   d="scan'208";a="9079813"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 23:23:40 +0100
Date: Sun, 20 Mar 2022 23:23:39 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <e38ea5f9-ccc2-408f-6331-5f4ed643d199@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203202322570.2917@hadrien>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net> <alpine.DEB.2.22.394.2203192038220.3204@hadrien> <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net> <alpine.DEB.2.22.394.2203200732590.3429@hadrien> <21f037cf-d0b8-8b25-163d-1d46c3a1f1d0@ewheeler.net>
 <alpine.DEB.2.22.394.2203202224290.2917@hadrien> <e38ea5f9-ccc2-408f-6331-5f4ed643d199@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Using `parallel` to run over lots of .c files and
 avoiding stack overflows.
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 267
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203202322570.2917%40hadrien>



On Sun, 20 Mar 2022, Eric Wheeler wrote:

> On Sun, 20 Mar 2022, Julia Lawall wrote:
>
> > > hmm... is there a new version or does my OCaml not support the feature?
> > >
> > > ]# ./spatch.opt 2>&1 | grep jobs
> > >   <no output>
> > >
> > > coccinelle-git]# ./spatch.opt --version
> > > spatch version 1.1.1-00106-ge65a6dd compiled with OCaml version 4.05.0
> > > Flags passed to the configure script: --prefix=/usr/local/coccinelle-git/
> > > OCaml scripting support: yes
> > > Python scripting support: yes
> > > Syntax of regular expressions: PCRE
> >
> > You have to use the --help option to get the complete set of arguments.
>
> ]# ./spatch.opt --help 2>&1|grep jobs
>   --jobs          the number of processes to be used
>
> There it is!
>
> I find it strange that -h and --help behave differently. IMHO, -j is
> useful enough that you might consider adding it to the default output.

Maybe...  There are so many options.  I hate to move it out of a category
that it nicely fits into.

julia
