Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14454C4345F
	for <cocci@archiver.kernel.org>; Thu,  2 May 2024 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=DVt8i+iXDts+XDNw/dAkISLI789CymjHgmcEJv/Z078=;
  b=ifVq8zPgjye5h8jyH/z0hZSjKryc4hGXYDm07A2oHOq8s4eE/8LOG93z
   pl1UDlOJwI8UK0LFAVqEBNf0ieXltStL/JhWc6u/NbB4qDsbtqfD3nlvv
   O9AtrQ9h9kGUI9LCGYtth/BlDI/AU7WHYNpslXjVozkm7r/xMiy8mR2R/
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164275042"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 May 2024 18:50:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 79DEBE013D; Thu,  2 May 2024 18:50:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 88714E0035
	for <cocci@sympa.inria.fr>; Thu,  2 May 2024 18:50:16 +0200 (CEST)
IronPort-SDR: 6633c43a_Wbfbfq6v5KGf6sfEhAEP4NkPFpV8ZyRciQ/sO0nDeQFgwcu
 WcDjaPELCIMZo/0eOhcLZMFm2L7+MGCzMpVj0XQ==
X-IPAS-Result: =?us-ascii?q?A0EDAADhwzNmh3yFCqpaFgQBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUCBOwUBAQEBCwGCGyh8gQoEC0iMc1+GSoIiA5gvhVuBQD4PA?=
 =?us-ascii?q?QMBCwEBOQsEAQEDBIR/AoguAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBAQEiFwcOECeFcA2CZxGBDmUJOAEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBGAINewEBAQECARIoBgEBNwEECwsYLhRINYJeAYJBIwMRqWkBjHUBA?=
 =?us-ascii?q?QF2gTSBAYIMAQEGgmbbGQmBSAGILQGJQnonFQaBSUSEPz6BUoEPA4FHhC2CL?=
 =?us-ascii?q?4USlFhBjD1UfRwDWSECEQFVExcLPgkWAhYDGxQEMA8JCyYDKgY2AhIMBgYGW?=
 =?us-ascii?q?SAWCQQjAwgEAxA0AyBvEQMEGgQLB3WBfIE1BBNHgTiJfQyBfYE0KYFOKYQhS?=
 =?us-ascii?q?2yEC4F4DmKDYYIqHUADC209NRQbBiIBoGiCUoFwASkBITYbYJNoEp1jlQMHA?=
 =?us-ascii?q?4QTjA6VHgQWM4QFgVaRXQw5kjcuh1iQXI10h06TGwIKBxeBZTqBXHAVgyIJR?=
 =?us-ascii?q?gMZD1eNSRmBFQEJgkKFFJgqQjUCOQIHCwEBAwmJIoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:HHNvSqjpnVYsD+RlJ+EpwXLGX1611BQKZh0ujC45NGQN5FlHY01je
 htvCmnVPKuNM2XzL4pyPIuz8E4Fv5OAy4JmSgo4rSBmEChjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UqieUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDpLg06/gEk35qiq5WtC5gZWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv4+lpTWhRiro/6ZWBiuFIOM0SRqkQqShgJ70oOHKF0hXG7JNm+t4sZJ
 N1l7fRcQOqyV0HGsLx1vxJwS0mSMUDakVNuzLfWXcG7liX7n3XQL/pGNhoKPaETxcdNRjtX8
 NNAIi1OV0vcrrfjqF67YrEEasULMdKuJ4YDojRswDXYE/s8UNWaGfmM4N5d0Tw5ndwIFvHbD
 yYbQWMwNFKZO1sWYQxRUchi9AurriGXnzlwslCSo6csy3LewAx4zP7mN9+9ltmiHJsJxBnE9
 zOXl4j/KhIAO9qu22G1yGOXlsvFxQDRA5tCPqLto5aGh3XImzVCV01HPbehmtGyjUW1WvpEO
 kkM82wvq7Iz/QqlVLHAswaQvWXBpRsAQ59cHuk79gyX2++NuVrfA2kBQzVIc8Bgv8gzLdA36
 rOXt+myOTxDu4K0czXH77K79TmvehFOckZXMEfoUjA5y9XkpYgyiDfGQdBiDLO5g7XJ9dfYn
 GDiQM8W2Ot7sCIb65hX62wrlN5Fm3QkZhMuox7SQnrg4g59ZZCofZ3tsAKHq/NBKYuSR0Kd+
 nMDnqByDdzi77ndyURho81UTdlFAspp1hWB3TaD+LF8rFyQF4aLJ9w43d2HDB4B3jw4UTHoe
 lTPngha+YVeOnCnBYcuPNvtVpR6lvm+TIm4PhwxUjaoSscqHONg1H40DXN8I0i2+KTRufhlY
 8fLGSpSJSpLVcyLMwZat89GjOZ6mXBvrY8ibZX6yhms2KGCLHiSU6sFeFKLY/o456rMoQPem
 +uzxOPVoyizpNbWO3GNmaZKdQ5iBSFiWfje9ZcNHsbdeVUOJY3UI6SMqV/XU9c5xPs9eyah1
 i3VZ3K0P3Kl1CWdd1XROyw+AF4tNL4mxU8G0eUXFQ7A8xAejUyHvM/zrrNuJeF5pt9wh+V5V
 ecEcMimC/FCAGaPsTcEYJW36MQoeB23jEjcd2CocRouTa5GHgbpw97Dehew1S8sCiHsi9Ayj
 Yf93SzmQL0CZT9YMuDoVNyVwWmM4EctwNBJYxOQI/14Wlndz4xxGimg0t41O54tLDvA9Bu71
 iGXIwYqmtPKkr8M7eiT1LylrpioIcR6DEF1D2nW1pfoFCj4r06I455Mb/aMRh/ZDFjLwaSFY
 f5E6c38PNksvkd4g6AlH5lFlasBtsbS/ZlExQFaLVD3RlWMCII4BEKZ3MNK55Z/9pUAtSSYA
 kuwq8RnY5OXM8bYEXkUFgovTsKH8do2wjDyz/AEEH/W1R9N3oiscBttZkGXqSlnMrFKHpsvw
 r4htO4o+gWPsEcWHejcvB9E1VanDyImaLomhKE4EYWwqwsMy3N+W7L+JBLywqmyb4RrDhF3D
 B6S3LHPlpZN9HrkKnATL0XA7cBZpJYJuS1J8mM8GkS0qoLFqMMajBx12hYrfztR1SRCgr5SO
 HA0FkhbJpeu3jZPheoaVHH1CQtxPgK9xXb1wXQNzl/pbRSMakHcCkZgJe+ypUQoqUxOchMG/
 rvCkGfBehTpdfHXwSEddxNEqfvibNop7SzEupmtMPqkFqkAQwjOo/GRd0tRjDD4W+UzvVbit
 8Aw2MpRNYjqKj82sak3L6K4xIYgYkmIC0IaSM4w4Z5TO3/XfQ+D/ASnKmezX5hoDOPL+0rpM
 P5eDJtDeDrm3Rnfsw1BI7AHJoJ1u/sb5NAiXLfPDkxeupu9qgtZir7hxhLctkQKHeo3yd0cL
 7nPfQ2sCmaT3HtYu1Hcpfl+Z1aXX4M2Wx3e7suUrsMyCJMxgMN9exoT05y1nUmvHilJwha2h
 D7HNojql7FM6II0hIb9MLRxNyPtI/PJaem42gSSsdNPUNDxDfnzpz4l8lnKAgAHEoYSCvJWl
 KuMuuHZxEnqnqg7eEGHloijF5tm39STXu1WOcfJL3B1s3OmXeny6SAi4EG9E4RCy/lG1/mkR
 iy5Scq+TsEUUNFj309oazBSPhIeKqbvZILimH+NlOuNAR0jzgD3FtOr2nv3Z2V9dCVTGZnBJ
 iLrmvSpvPZ0kZ9tAUIaOvRYHJNIGl/vdq84fdnXtzPDLG2JgEuHi4Tyhygb9jDHJXmVIvnUu
 aufaEDFSy2zn6XUwPVykY945EQXBUkgp9gARBsW/touhg2qCGIDE/8mDqwHLZNpiQ336oDzY
 WDcTWklCBilZw9+TzfH3I3BUDucV8s0AfWoFgxxqgnQI22zCZibCbRsyjZ47j0kMnH/xeWgM
 pcF9me2IhG1xYpzSP0O4uCgx91q3e7e2mlC7HWVfxYe2PrCKe5iOL1d8AtxuejvDtqIj0DXP
 S05SGRFXkyhWAuoS5omfn9QFRoQpy+pxDItBctKLBAzpK3DpNCsCtWmUw0w7lHHRN4HKL4HW
 TX8QG7lD6W+xCkIoaVw0z42qfYcNB9Id/RW6If5SAESlr324WMiVy/HcezjU+l6kDNi/5jhe
 vVALpTw6Ilp6Kyc5VFO9Tg0xg==
IronPort-HdrOrdr: A9a23:Lk5dU6sRLODKGtRMXgwtiY8B7skDVdV00zEX/kB9WHVpmwKj5q
 OTddAgpGPJYVcqKQwdcLW7U5VoLkmzyXcY2+gs1PKZLW/bUQiTXeZfBOnZsljd8kTFn4Y2uc
 hdmupFebnN5DNB/KTHCWeDc+rIjOP3iZxBKIzlokuEympRGttdB9MTMHfhLqUbKTM2faYEKA
 ==
X-Talos-CUID: 9a23:H2kJqGHheIajyqoqqmJdr3IUNssaU0ealm7VDBeyFCVQE+K8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AwlQFFQ4cH73svsSb+EB5se4sxoxr+auoOVJWoa8?=
 =?us-ascii?q?XgNmgP3RTEWyE3B6oF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164274999"
X-MGA-submission: =?us-ascii?q?MDHwZ0g6gPdaDtvwY3/blQDBU/RY2Cqel2ZLR9?=
 =?us-ascii?q?9kUF3fyV6si+4hYK2FWxIBSXCCCwwdw/68bcWFLDctcnbSVtc1pb1EOU?=
 =?us-ascii?q?Krq4hb1dkIq95uHYjiLsIYBoxZ43sjTc0cVIJBcr21W5YEs1UxNy4hx7?=
 =?us-ascii?q?73cA+mgJ020U/aB+ywDjss4g=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 18:50:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714668600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVt8i+iXDts+XDNw/dAkISLI789CymjHgmcEJv/Z078=;
	b=VmJAUsUW/MI9xL+q+Rp21m5mojJFbNJfuj+03BkyILEfZ9gCtDi6I6GmFIsUlsoqR+K9HH
	lhslUw5HhyN2CbTYeqWeCNm8D6T4QbobikpupFjmFmy9NO5P3UbaBoSGZNm1DmbdNLEDWm
	EsXFFk0psW5KZ44jXctKk7v7Z3KvHQc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-kt4cFXNmOfaQg0pd4Rl2tQ-1; Thu,
 02 May 2024 12:49:59 -0400
X-MC-Unique: kt4cFXNmOfaQg0pd4Rl2tQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE2CF3C025C7;
	Thu,  2 May 2024 16:49:58 +0000 (UTC)
Received: from localhost (unknown [10.42.28.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BE2932166B31;
	Thu,  2 May 2024 16:49:58 +0000 (UTC)
Date: Thu, 2 May 2024 17:49:58 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <20240502164958.GD30267@redhat.com>
References: <20240502085433.GA30267@redhat.com>
 <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr>
 <20240502163131.GC30267@redhat.com>
 <6881602e-5f8e-db48-323d-139673441398@inria.fr>
MIME-Version: 1.0
In-Reply-To: <6881602e-5f8e-db48-323d-139673441398@inria.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 1683
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/20240502164958.GD30267%40redhat.com>

On Thu, May 02, 2024 at 06:39:34PM +0200, Julia Lawall wrote:
> 
> 
> On Thu, 2 May 2024, Richard W.M. Jones wrote:
> 
> > On Thu, May 02, 2024 at 11:44:00AM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Thu, 2 May 2024, Richard W.M. Jones wrote:
> > >
> > > > OCAMLOPT  parsing_cocci/parser_cocci_menhir.ml
> > > >
> > > > This single file takes a very long time to compile, about 34 minutes
> > > > on my 2 year old Intel laptop.  It's quite large too ...
> > > >
> > > > 139201 ./coccinelle-1.2/parsing_cocci/parser_cocci_menhir.ml
> > > >
> > > > I've observed in the past that the OCaml compiler doesn't handle
> > > > single large files well.  It seems to have some O(n^k) behaviour.
> > > >
> > > > Is this a known issue?
> > >
> > > I agree that it's slow, but I haven't seen it take 34 minutes.
> >
> > I just tried it on a much faster AMD desktop machine, but essentially
> > the same OCaml and menhir, and it still takes a very long time to
> > compile this one file: 17:35 minutes
> >
> > I tried it on a (different) machine with OCaml 4.11.1 and that was
> > considerably faster, taking under a minute.
> 
> I tried it on an Intel server and it takes a few seconds.  OCaml version
> 5.1.1.  menhir, version 20200123

Interesting, thanks Julia.  I'll poke this further to see
if I can find out what the causative factor is.

Rich.

> julia
> 
> >
> > Rich.
> >
> > > The point is that it is a parser, so the code is generated.  I use OCaml
> > > 4.13.1 or 5.0, not 5.1.1.  I have the same version of menhir as the one
> > > you mention.
> > >
> > > I can try to make it smaller.
> > >
> > > julia
> > >
> > > >
> > > > Rich.
> > > >
> > > > coccinelle 1.2 from tarball
> > > > ocaml-5.1.1-4.fc40.x86_64
> > > > ocaml-menhir-20231231-3.fc40.x86_64
> > > >
> > > > --
> > > > Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> > > > Read my programming and virtualization blog: http://rwmj.wordpress.com
> > > > virt-top is 'top' for virtual machines.  Tiny program with many
> > > > powerful monitoring features, net stats, disk stats, logging, etc.
> > > > http://people.redhat.com/~rjones/virt-top
> > > >
> > > >
> >
> > --
> > Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> > Read my programming and virtualization blog: http://rwmj.wordpress.com
> > virt-top is 'top' for virtual machines.  Tiny program with many
> > powerful monitoring features, net stats, disk stats, logging, etc.
> > http://people.redhat.com/~rjones/virt-top
> >
> >

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

