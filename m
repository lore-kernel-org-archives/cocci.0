Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7056C4345F
	for <cocci@archiver.kernel.org>; Fri,  3 May 2024 12:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3CqPH0BrQj/7Z7Bfo4PAffhzirA/aYKHYxaQHEATR5o=;
  b=BL4PoDIbr/RAA4clWO43lF30rMt26ekvSiCAmb4zLxGd26YWdUPaMFru
   HGJ2Cv4AFLn40zYYIlzjuZfrNbS9FURzFBWbA7NeqrlzOBASoQ+OL14fM
   C62CVvZcamU7N8VZmtvbWkbR7qm5wyHEzYdMAqA4DZaoqOmMiWKm15XZD
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="164390723"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 May 2024 14:15:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E3488E0133; Fri,  3 May 2024 14:15:49 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 56241E0133
	for <cocci@sympa.inria.fr>; Fri,  3 May 2024 14:15:46 +0200 (CEST)
IronPort-SDR: 6634d567_Pmp7l6YwulSYi7446k3hF4TLk1TFchjdaOnxIHHJk7rY35U
 haOeBOhGFKtybYseO8MJRuGPXn4YxXyJOJXfAMA==
X-IPAS-Result: =?us-ascii?q?A0EDAAD81DRmh3yFCqpaFgQBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUCBOwUBAQEBCwGCQ3yBCgQLSIxzX4ZKgiIDmC+FW4FAPg8BA?=
 =?us-ascii?q?wELAQE5CwQBAQMEhH8CiC4CHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEBASIXBw4QJ4V0DYJnEYEOZQk4AQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBFwINfAEBAQMSKAYBATcBDwsYLhRINYJeAYJkAxEGpUQBjHUBAQF2g?=
 =?us-ascii?q?TSBAYIMAQEGgmbbGQmBSAGILQGJQnonFQaBSUSEPz6BUoEPA4FHhlyFEpJmg?=
 =?us-ascii?q?XJBjHBUfRwDWSECEQFVExcLPgkWAhYDGxQEMA8JCyYDKgY2AhIMBgYGWSAWC?=
 =?us-ascii?q?QQjAwgEAxA0AyBvEQMEGgQLB3WBfIE1BBNHgTiJfQyBfYE0KYFOKYQhS2yEC?=
 =?us-ascii?q?4F4DmKDYYJbHUADC209NRQbBiIBoQiCVoFwASkBASBRVIE1kj8SnWOVAwcDh?=
 =?us-ascii?q?BOMDpUeBBYzhAWBVpFdDDmSNy6HWJBcixaBdWmHTo18hR8CCgcXgWU6gVxwF?=
 =?us-ascii?q?YMiCUYDGQ9XjUkZg2GFFJR0QjUCOQIHCwEBAwmJIoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 9VsD7UD6Jy5FX1s
IronPort-HdrOrdr: A9a23:2HM0bahQiccU49Vma5XHEDWIZ3BQXvkji2hC6mlwRA09TyVXrb
 HMoB0+726JtN9xYgBcpTnkAsK9qBznm6KdjbNxAV7mZniBhILKFvAE0WKB+UyEJ8SWzIc0v8
 sOT0E9MqyVMbEQt7eZ3ODXKbYdKZW8gdmVbUq09RpQpYYAUdAb0++sYTzraXGfKGR9dOIEKK
 Y=
X-Talos-CUID: 9a23:62CSnm37nEghjNZllBUW27xfAMQndnz01W7sLkKnBGw4d4CQEHG75/Yx
X-Talos-MUID: 9a23:AGuZwwlnpj4gY62hyL+ddnpFLf5j7o2tNHsQnK4tuPGbOy1IIRqC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="86313518"
X-MGA-submission: =?us-ascii?q?MDFnXqqgc6vQLeM6XmCIpo7vZXeaJYayKWHcJk?=
 =?us-ascii?q?j8jKfdWOAbra3X5uWRMG03Swv1P1oj7GPyHGOjmyTYwq5kCfWwyPvXjQ?=
 =?us-ascii?q?f2byZTVz/ncPFEBiV/Tyl6HoIPsxzfc63qkOlnPZo2+XAmE7yPFsqELX?=
 =?us-ascii?q?VS7O/fH8RmS1tdKjDvO1hq5g=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 14:15:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714738533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CqPH0BrQj/7Z7Bfo4PAffhzirA/aYKHYxaQHEATR5o=;
	b=EDAWO2ATTCY8admsOpBJAMsCCnxm7GaqwsRNVkrOqINTDGIOxJMboOKWhlwOiS2FaTkpB2
	U8OK0UtYil8kTGwnrfBcMRwWuIpKkyXdbUAKETuh8lQqPdNSgYGPvmgCZX1hpJLPj6aVh4
	W+XBKG7mJp0RFMeKnU/t7bWMAPtfRqw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-DgXpHPzzNm2GdqL2jlI8MA-1; Fri,
 03 May 2024 08:15:31 -0400
X-MC-Unique: DgXpHPzzNm2GdqL2jlI8MA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DB281C4C3E8;
	Fri,  3 May 2024 12:15:31 +0000 (UTC)
Received: from localhost (unknown [10.42.28.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F04F010000AD;
	Fri,  3 May 2024 12:15:30 +0000 (UTC)
Date: Fri, 3 May 2024 13:15:30 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <20240503121530.GV7636@redhat.com>
References: <20240502085433.GA30267@redhat.com>
 <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr>
 <20240502163131.GC30267@redhat.com>
 <6881602e-5f8e-db48-323d-139673441398@inria.fr>
 <20240502164958.GD30267@redhat.com>
 <eb315099-ed3a-d2fe-a353-5fd1b3edacfb@inria.fr>
MIME-Version: 1.0
In-Reply-To: <eb315099-ed3a-d2fe-a353-5fd1b3edacfb@inria.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 1695
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/20240503121530.GV7636%40redhat.com>

On Thu, May 02, 2024 at 07:02:30PM +0200, Julia Lawall wrote:
> 
> 
> On Thu, 2 May 2024, Richard W.M. Jones wrote:
> 
> > On Thu, May 02, 2024 at 06:39:34PM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Thu, 2 May 2024, Richard W.M. Jones wrote:
> > >
> > > > On Thu, May 02, 2024 at 11:44:00AM +0200, Julia Lawall wrote:
> > > > >
> > > > >
> > > > > On Thu, 2 May 2024, Richard W.M. Jones wrote:
> > > > >
> > > > > > OCAMLOPT  parsing_cocci/parser_cocci_menhir.ml
> > > > > >
> > > > > > This single file takes a very long time to compile, about 34 minutes
> > > > > > on my 2 year old Intel laptop.  It's quite large too ...
> > > > > >
> > > > > > 139201 ./coccinelle-1.2/parsing_cocci/parser_cocci_menhir.ml
> > > > > >
> > > > > > I've observed in the past that the OCaml compiler doesn't handle
> > > > > > single large files well.  It seems to have some O(n^k) behaviour.
> > > > > >
> > > > > > Is this a known issue?
> > > > >
> > > > > I agree that it's slow, but I haven't seen it take 34 minutes.
> > > >
> > > > I just tried it on a much faster AMD desktop machine, but essentially
> > > > the same OCaml and menhir, and it still takes a very long time to
> > > > compile this one file: 17:35 minutes
> > > >
> > > > I tried it on a (different) machine with OCaml 4.11.1 and that was
> > > > considerably faster, taking under a minute.
> > >
> > > I tried it on an Intel server and it takes a few seconds.  OCaml version
> > > 5.1.1.  menhir, version 20200123
> >
> > Interesting, thanks Julia.  I'll poke this further to see
> > if I can find out what the causative factor is.
> 
> wc -l parser_cocci_menhir.ml gives 139201 parser_cocci_menhir.ml

It turns out this happens because Fedora enables "flambda" in the
OCaml compiler (ie. ./configure --enable-flambda).

flambda is "a series of optimisation passes provided by the native
code compilers as of OCaml 4.03" which "make it easier to write
idiomatic OCaml code without incurring performance penalties".  It's
not enabled by default, which probably explains why this problem is
not seen on Debian.

More here:
https://ocaml.org/manual/5.1/flambda.html

Anyway it's not a cocci problem!

I will discuss with Fedora if we want to keep this option enabled or
drop it.  It's not a show-stopper that Coccinelle takes a long time to
compile, just a bit annoying.  It doesn't seem to affect Coccinelle in
any other way (eg. making it faster/slower at runtime) as far as I can
tell.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
nbdkit - Flexible, fast NBD server with plugins
https://gitlab.com/nbdkit/nbdkit

