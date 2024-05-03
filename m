Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F12DC4345F
	for <cocci@archiver.kernel.org>; Fri,  3 May 2024 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5Ofc/RhSykCYFC5Xqqq3aqTSG5ZGIM5Zjxx4FPqMF1U=;
  b=E0Wq1RZpcY/b58grQhGG/fOTd5b6aEsm4TG4n9y/uYKX6fhbjqC+wiJL
   /Mmy82Iyx1/f7OE4yjFz/5kAlIGmoTgVa+mHVLoFrYyzFj0ZgFBgHdWLb
   s8gcnMKHbZJqIacvDacY2l49gB2u8lg8yjxnEeIzK7+WknH6ZBPJhVGWF
   w=;
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
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="164429293"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 May 2024 17:50:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 771CCE0D5A; Fri,  3 May 2024 17:50:33 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id ADCA9E0035
	for <cocci@sympa.inria.fr>; Fri,  3 May 2024 17:50:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5Ofc/RhSykCYFC5Xqqq3aqTSG5ZGIM5Zjxx4FPqMF1U=;
  b=R9b7rwlCYmZTd1SvRFqvuw1HrCZZlCkfX9AJprtNhYel9QSA1ZriQNJs
   ulNJKtBAtBGnvgG8aao0044MWECmpnoRkmbkjT+3VDpc3C0GlKiECkGhw
   eUNIJ746MQzH2yObyOTWMtbIsJUoA6T0SPjDkQ1MjabaVpDV9v1DVolTK
   s=;
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="164429262"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 17:50:28 +0200
Date: Fri, 3 May 2024 17:50:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: "Richard W.M. Jones" <rjones@redhat.com>
cc: cocci@inria.fr
In-Reply-To: <20240503121530.GV7636@redhat.com>
Message-ID: <6e1424a2-5c65-93e7-998e-8d90dc84dffc@inria.fr>
References: <20240502085433.GA30267@redhat.com> <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr> <20240502163131.GC30267@redhat.com> <6881602e-5f8e-db48-323d-139673441398@inria.fr> <20240502164958.GD30267@redhat.com> <eb315099-ed3a-d2fe-a353-5fd1b3edacfb@inria.fr>
 <20240503121530.GV7636@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1698
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/6e1424a2-5c65-93e7-998e-8d90dc84dffc%40inria.fr>



On Fri, 3 May 2024, Richard W.M. Jones wrote:

> On Thu, May 02, 2024 at 07:02:30PM +0200, Julia Lawall wrote:
> >
> >
> > On Thu, 2 May 2024, Richard W.M. Jones wrote:
> >
> > > On Thu, May 02, 2024 at 06:39:34PM +0200, Julia Lawall wrote:
> > > >
> > > >
> > > > On Thu, 2 May 2024, Richard W.M. Jones wrote:
> > > >
> > > > > On Thu, May 02, 2024 at 11:44:00AM +0200, Julia Lawall wrote:
> > > > > >
> > > > > >
> > > > > > On Thu, 2 May 2024, Richard W.M. Jones wrote:
> > > > > >
> > > > > > > OCAMLOPT  parsing_cocci/parser_cocci_menhir.ml
> > > > > > >
> > > > > > > This single file takes a very long time to compile, about 34 minutes
> > > > > > > on my 2 year old Intel laptop.  It's quite large too ...
> > > > > > >
> > > > > > > 139201 ./coccinelle-1.2/parsing_cocci/parser_cocci_menhir.ml
> > > > > > >
> > > > > > > I've observed in the past that the OCaml compiler doesn't handle
> > > > > > > single large files well.  It seems to have some O(n^k) behaviour.
> > > > > > >
> > > > > > > Is this a known issue?
> > > > > >
> > > > > > I agree that it's slow, but I haven't seen it take 34 minutes.
> > > > >
> > > > > I just tried it on a much faster AMD desktop machine, but essentially
> > > > > the same OCaml and menhir, and it still takes a very long time to
> > > > > compile this one file: 17:35 minutes
> > > > >
> > > > > I tried it on a (different) machine with OCaml 4.11.1 and that was
> > > > > considerably faster, taking under a minute.
> > > >
> > > > I tried it on an Intel server and it takes a few seconds.  OCaml version
> > > > 5.1.1.  menhir, version 20200123
> > >
> > > Interesting, thanks Julia.  I'll poke this further to see
> > > if I can find out what the causative factor is.
> >
> > wc -l parser_cocci_menhir.ml gives 139201 parser_cocci_menhir.ml
>
> It turns out this happens because Fedora enables "flambda" in the
> OCaml compiler (ie. ./configure --enable-flambda).
>
> flambda is "a series of optimisation passes provided by the native
> code compilers as of OCaml 4.03" which "make it easier to write
> idiomatic OCaml code without incurring performance penalties".  It's
> not enabled by default, which probably explains why this problem is
> not seen on Debian.
>
> More here:
> https://ocaml.org/manual/5.1/flambda.html
>
> Anyway it's not a cocci problem!
>
> I will discuss with Fedora if we want to keep this option enabled or
> drop it.  It's not a show-stopper that Coccinelle takes a long time to
> compile, just a bit annoying.  It doesn't seem to affect Coccinelle in
> any other way (eg. making it faster/slower at runtime) as far as I can
> tell.

Thanks!

I can at least add a comment to the build instructions.

I don't know if it is worth notifying the OCaml developers.  Maybe they
know already that this can be a problem.

julia

>
> Rich.
>
> --
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> nbdkit - Flexible, fast NBD server with plugins
> https://gitlab.com/nbdkit/nbdkit
>
>
