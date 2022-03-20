Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CCAC433EF
	for <cocci@archiver.kernel.org>; Sun, 20 Mar 2022 06:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3cMSFCe83G8dlyM2dsICI5Xoiloj8TGrPJF7bUzKHR8=;
  b=pLD9P9k3/56FGtecxREee4mHvuNnfHMiJH2mbOvZNWjQ3pIDocQFpsZR
   NJPLE3+jzyR52qnQssNN4HglKBOMMbVr5qwY8KIOq0tXqWgoZ1msGiZR+
   GBxBosJAlhf0U4fNEcDt3F2/YpCWX7OSDxmvS8zcP25DOEMddWCMJmnPK
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
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27055127"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Mar 2022 07:33:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E679FE020F; Sun, 20 Mar 2022 07:33:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D7D1EE0069
	for <cocci@sympa.inria.fr>; Sun, 20 Mar 2022 07:33:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3cMSFCe83G8dlyM2dsICI5Xoiloj8TGrPJF7bUzKHR8=;
  b=Vj6yPmd1MPOZ9grB5YOkJTOfmpj0vNkURfAwElj61LJZAAjYcd2MRBkG
   yYTfK1rthk6c3BsI5cTSrIOg4Bx60alpg+dpMWw0M5q7JBQLhZQYw9fc/
   e1fxNyzOzzRg1iLP6Xc6aO7+mrbb6nr2RNY/ZCztJLUFc27Xacucp7OFa
   o=;
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="9049057"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 07:33:36 +0100
Date: Sun, 20 Mar 2022 07:33:36 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203200732590.3429@hadrien>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net> <alpine.DEB.2.22.394.2203192038220.3204@hadrien> <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Using `parallel` to run over lots of .c files and
 avoiding stack overflows.
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 258
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203200732590.3429%40hadrien>



On Sat, 19 Mar 2022, Eric Wheeler wrote:

> On Sat, 19 Mar 2022, Julia Lawall wrote:
> > On Sat, 19 Mar 2022, Eric Wheeler wrote:
> >
> > > Hi All,
> > >
> > > Just a quick tip for others (like me) who are new to Coccinelle:
> > >
> > > You might already use this, but if not, here's a hint for doing lots of
> > > replacements in parallel:
> > >
> > > 	parallel -j24 spatch --sp-file smpl.cocci {} --in-place ::: *.c
> > >
> > > If the SmPL depends on interactions between files then `parallel` won't
> > > work, but if the changes work per-file then it runs much faster with lots
> > > of big .c files.
> > >
> > > In cases where you do need to run over lots of files and they _do_
> > > interact, you might get a Stack Overflow error.  In this case set
> > > something like this for 1GB of stack space:
> > > 	ulimit -s $((1024*1024))
> > >
> > > In my case spatch needed 1GB of stack and 2.4GB of RAM.  It took a few
> > > minutes and finished thousands of replacements!
> > >
> > > Julia, you might add this to documentation if you think it would be
> > > useful.
> >
> > I'm not sure what you are trying to do.  You can give spatch the name of a
> > directory and the argument -j N for a number for cores N, ad it will run
> > in parallel on the files in the directroy.
>
> Oh really? Well, nevermind what I said then.
>
> However, that could be a documentation bug:
>
> I don't see -j in the `spatch --help` output.

It's there, but there are many other options, so you may have missed it:

  --jobs          the number of processes to be used
  -j              the number of processes to be used

julia
