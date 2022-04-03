Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922A7C433EF
	for <cocci@archiver.kernel.org>; Sun,  3 Apr 2022 08:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=DH8YP/376e5catfGE6en4r8bmYZVE0NHfAWv3Q5uKxw=;
  b=TMcEZkd8iAaAvjvbiEzb20oEjk9ylvWmR6gBYLKKJFLULPIYN3fwEd+v
   RRjJP/aNKP2OF5OiIc8NRRqhWGDe7u0FgwGWuXBcw/ngLzt21By6NgVbw
   GrlXPY0cryDXlettoI8Oc1iQRQW6pqxaL1h0v65yt4YUNXothI+xsp1UP
   o=;
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
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29726993"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2022 10:06:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E28F6E033B; Sun,  3 Apr 2022 10:06:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B4899E00A8
	for <cocci@sympa.inria.fr>; Sun,  3 Apr 2022 10:06:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DH8YP/376e5catfGE6en4r8bmYZVE0NHfAWv3Q5uKxw=;
  b=TYeyS0ovI+cE9mCmHhkjliTYO/puVwwL2wtTzxiILtFR2CH78aXTuOzX
   BPTqrkTG13XZHuZe9HKlrDpeGUmDfEO+x4s1MehC/TjKpeuAGNdgBJyJL
   y9U9UIqqp/hmwgEb/Ujk5KkTKHHKACAZZ5jtLfTwGSTrofqrOT8jvjv7U
   g=;
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29726991"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 10:06:47 +0200
Date: Sun, 3 Apr 2022 10:06:46 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <794e98d4-931f-d19f-c821-274dec65dbf4@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2204031005110.3114@hadrien>
References: <4f40e17b-67ed-97f0-10ca-41285d7c3d1a@ewheeler.net> <alpine.DEB.2.22.394.2204022320520.3208@hadrien> <794e98d4-931f-d19f-c821-274dec65dbf4@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] How do you concatinate string constants in SmPL with
 python?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 345
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/alpine.DEB.2.22.394.2204031005110.3114%40hadrien>



On Sat, 2 Apr 2022, Eric Wheeler wrote:

> On Sat, 2 Apr 2022, Julia Lawall wrote:
> > On Sat, 2 Apr 2022, Eric Wheeler wrote:
> > > I would like to do something like this:
> > >
> > > @ r @
> > > constant C;
> > > @@
> > > -perror(C);
> > > +pr_err(C ": %s\n", strerror(errno));
> > >
> > > Thus in python I need something like C = C + C ": %s\n".
> >
> > I don't understand this.
>
> For example:
>
> -perror("unable to open file");
> +pr_err("unable to open file: %s\n", strerror(errno));
>
> I'm trying to append ": %s\n" to the original string (C) so we can process
> the error using pr_err() instead of perror().  Since SmPL does not support
> string concatination (so far as I am aware), I would need to use python.
>
> But I'm not sure how to structure the python bits so they interact with
> cocci.  I've looked at some examples but I don't see how to change the
> value of C to something else, such as C = C + ": %s\n" where + is the
> append operator in python.

You should check demos/pythontococci.  You need to make three rules, one
to match, one to use python to create the new string you want (in the
place of "something" in the demo), and one to rematch and generate the
code.

julia



>
> --
> Eric Wheeler
>
>
> >
> > >
> > > I've tried a few things, but I don't think I'm anywhere close to getting
> > > it right.  Can someone help with how this should be setup?
> > >
> > > Also is there a reference for the `coccinelle.` and `cocci.` python calls
> > > that seem to be available in a script:python section?
> >
> > There is Coccilib.3cocci, but that is for ocaml.
> >
> > My understanding is that there are reflective features in python that let
> > you find out what functions are available.  python/python_documentation.md
> > in the source tree also has some information.  Or look at the code in
> > python/coccilib.
> >
> > julia
> >
>
