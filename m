Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F3CC433EF
	for <cocci@archiver.kernel.org>; Fri,  1 Apr 2022 20:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3aMVnsf/HGCxlu8euKNzlv/W8eyswKssJYg8SEFPA84=;
  b=i75/cFgD/ty55RcUqsdWPGgoK6ND9QiSbZbX424PofusWTZ6xGR9C/4e
   2aSG//iVXEtr/MsHcPGkhl1o0O82WnP3RFQUY8pCk7A67L7D3eDv3uSzb
   RDyrWgwVdaQ1q+y73ykajiHri0HIVvyO6haYqw+OX+boHSBdtGamws9iJ
   M=;
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
X-IronPort-AV: E=Sophos;i="5.90,228,1643670000"; 
   d="scan'208";a="29630629"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Apr 2022 22:28:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1F732E033A; Fri,  1 Apr 2022 22:28:20 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C0B15E00A8
	for <cocci@sympa.inria.fr>; Fri,  1 Apr 2022 22:28:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3aMVnsf/HGCxlu8euKNzlv/W8eyswKssJYg8SEFPA84=;
  b=kFbtruHCcOjdnBwAfkndON2wIaPeOYVa+vuCsVuQunEpURWT6271zDX7
   66gj/VJn+2oW0HM1QC5m7ukbQZlwOEyL7e6j7awYVnNq1g3lhsdz/EXqw
   2pBgzBhlQHogg4eMNTMWx0A/g5/pR+cc/w9mfNiQ/0d8vI6vVm3Ik8GNN
   Q=;
X-IronPort-AV: E=Sophos;i="5.90,228,1643670000"; 
   d="scan'208";a="29630622"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 22:28:17 +0200
Date: Fri, 1 Apr 2022 22:28:17 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <ac254b9c-3923-5b7b-5d56-564d50e06760@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2204012224060.3048@hadrien>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net> <alpine.DEB.2.22.394.2203192038220.3204@hadrien> <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net> <alpine.DEB.2.22.394.2203200732590.3429@hadrien>
 <ac254b9c-3923-5b7b-5d56-564d50e06760@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Using `parallel` to run over lots of .c files and
 avoiding stack overflows.
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 329
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/alpine.DEB.2.22.394.2204012224060.3048%40hadrien>



On Fri, 1 Apr 2022, Eric Wheeler wrote:

> On Sun, 20 Mar 2022, Julia Lawall wrote:
> > On Sat, 19 Mar 2022, Eric Wheeler wrote:
> > > On Sat, 19 Mar 2022, Julia Lawall wrote:
> > > > On Sat, 19 Mar 2022, Eric Wheeler wrote:
> > > > > Just a quick tip for others (like me) who are new to Coccinelle:
> > > > >
> > > > > You might already use this, but if not, here's a hint for doing lots of
> > > > > replacements in parallel:
> > > > >
> > > > > 	parallel -j24 spatch --sp-file smpl.cocci {} --in-place ::: *.c
> > > > >
> > > > > If the SmPL depends on interactions between files then `parallel` won't
> > > > > work, but if the changes work per-file then it runs much faster with lots
> > > > > of big .c files.
> > > > >
> > > > > In cases where you do need to run over lots of files and they _do_
> > > > > interact, you might get a Stack Overflow error.  In this case set
> > > > > something like this for 1GB of stack space:
> > > > > 	ulimit -s $((1024*1024))
> > > > >
> > > > > In my case spatch needed 1GB of stack and 2.4GB of RAM.  It took a few
> > > > > minutes and finished thousands of replacements!
> > > > >
> > > > > Julia, you might add this to documentation if you think it would be
> > > > > useful.
> > > >
> > > > I'm not sure what you are trying to do.  You can give spatch the name of a
> > > > directory and the argument -j N for a number for cores N, ad it will run
> > > > in parallel on the files in the directroy.
> > >
> >   --jobs          the number of processes to be used
> >   -j              the number of processes to be used
>
> Running `top` shows spatch at 100% cpu: it is not parallelizing, though
> the rules and files are completely independent of eachother (no
> inter-SmPL-rule dependencies).

I don't understand what you mean by spatch at 100%.  I think you should
have 24 spatches?

On the other hand, you should not put a bunch of files on the command
line.  The intended behavior is for that not to be parallel.  Coccinelle
makes no effort to figure out whether parallelism is useful.

Normally, one runs spatch on a directory, and then it takes care of
working on the different files in parallel.

It seems that you don't want to process resources.c.  Maybe the semantic
patch should be adjusted so that the code in resource.c is not matched?

With python or OCaml you can also cause Coccinelle to exit on a file you
don't want to process.

julia

>
> Not sure if this is an spatch bug or not, but its ~3x faster to use
> `parallel` as follows:
>
> ]# time parallel -j24 -- spatch --sp-file cocci/printf-refactor.cocci  :::  `ls src/*.c|grep -v resources.c` &> /dev/null
> real	0m1.224s
>
> ]# time spatch -j24 --sp-file cocci/printf-refactor.cocci `ls src/*.c|grep -v resources.c` &> /dev/null
> real	0m4.852s
>
>
> Here is the SmPL:
> 	@ p4 @
> 	expression list EL;
> 	constant C =~ "BUG";
> 	@@
> 	-printf(C, EL);
> 	+BUG(C, EL);
>
> 	@ p3 @
> 	expression list EL;
> 	constant C =~ "warn";
> 	@@
> 	-printf(C, EL);
> 	+pr_warn(C, EL);
>
> 	@ p @
> 	expression list EL;
> 	constant C;
> 	@@
> 	-printf(C, EL);
> 	+pr_info(C, EL);
>
> 	@ p2 @
> 	expression list EL;
> 	constant C;
> 	@@
> 	-fprintf(stderr, C, EL);
> 	+pr_err(C, EL);
>
>
> The .c files are from here:
> 	https://github.com/KJ7LNW/xnec2c
>
> --
> Eric Wheeler
>
>
> >
> > julia
> >
>
