Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DFEC4345F
	for <cocci@archiver.kernel.org>; Thu,  2 May 2024 16:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=THBB7bhWRgYh8wof+z1B8FlSLm6kulzlqitfPQ12nI8=;
  b=MDUOwBPGGYOYj6WyMkkQbc3MPm5kPNP162Iw+ZU3juZszFErppvpX7Ol
   yTfeFhtgn3MHawrTfcLsap0XzI7KC9CAo/L2Z1Z2EJOd9q+fyOyMsZZv5
   m+ENX6FW4hBm9l1RxicuST5VNIrM3zKYQGF2KwB+Q89rkB1+hwPx3uI3M
   E=;
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
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164273881"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 May 2024 18:39:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B7387E0141; Thu,  2 May 2024 18:39:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 60957E0035
	for <cocci@sympa.inria.fr>; Thu,  2 May 2024 18:39:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=THBB7bhWRgYh8wof+z1B8FlSLm6kulzlqitfPQ12nI8=;
  b=tm4w4st2c8hbyP021NPi9xpZ3KQN8dGqt0ZV3XNCB8CHoNHlzMeIu26K
   uJiaTkTA7zyB5lW4BaQ+ry7BSY0Lmfznwb8qjXkTv5lj6/6XbX/lm6eFe
   riHaRp5E83jpigGcNd3T6nAFZvcKil2MtPbUUIM/6ebe7Zhu4EdAyYHZ2
   0=;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="86250522"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 18:39:35 +0200
Date: Thu, 2 May 2024 18:39:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: "Richard W.M. Jones" <rjones@redhat.com>
cc: cocci@inria.fr
In-Reply-To: <20240502163131.GC30267@redhat.com>
Message-ID: <6881602e-5f8e-db48-323d-139673441398@inria.fr>
References: <20240502085433.GA30267@redhat.com> <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr> <20240502163131.GC30267@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1682
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/6881602e-5f8e-db48-323d-139673441398%40inria.fr>



On Thu, 2 May 2024, Richard W.M. Jones wrote:

> On Thu, May 02, 2024 at 11:44:00AM +0200, Julia Lawall wrote:
> >
> >
> > On Thu, 2 May 2024, Richard W.M. Jones wrote:
> >
> > > OCAMLOPT  parsing_cocci/parser_cocci_menhir.ml
> > >
> > > This single file takes a very long time to compile, about 34 minutes
> > > on my 2 year old Intel laptop.  It's quite large too ...
> > >
> > > 139201 ./coccinelle-1.2/parsing_cocci/parser_cocci_menhir.ml
> > >
> > > I've observed in the past that the OCaml compiler doesn't handle
> > > single large files well.  It seems to have some O(n^k) behaviour.
> > >
> > > Is this a known issue?
> >
> > I agree that it's slow, but I haven't seen it take 34 minutes.
>
> I just tried it on a much faster AMD desktop machine, but essentially
> the same OCaml and menhir, and it still takes a very long time to
> compile this one file: 17:35 minutes
>
> I tried it on a (different) machine with OCaml 4.11.1 and that was
> considerably faster, taking under a minute.

I tried it on an Intel server and it takes a few seconds.  OCaml version
5.1.1.  menhir, version 20200123

julia

>
> Rich.
>
> > The point is that it is a parser, so the code is generated.  I use OCaml
> > 4.13.1 or 5.0, not 5.1.1.  I have the same version of menhir as the one
> > you mention.
> >
> > I can try to make it smaller.
> >
> > julia
> >
> > >
> > > Rich.
> > >
> > > coccinelle 1.2 from tarball
> > > ocaml-5.1.1-4.fc40.x86_64
> > > ocaml-menhir-20231231-3.fc40.x86_64
> > >
> > > --
> > > Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> > > Read my programming and virtualization blog: http://rwmj.wordpress.com
> > > virt-top is 'top' for virtual machines.  Tiny program with many
> > > powerful monitoring features, net stats, disk stats, logging, etc.
> > > http://people.redhat.com/~rjones/virt-top
> > >
> > >
>
> --
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> virt-top is 'top' for virtual machines.  Tiny program with many
> powerful monitoring features, net stats, disk stats, logging, etc.
> http://people.redhat.com/~rjones/virt-top
>
>
