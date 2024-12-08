Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C396E77173
	for <cocci@archiver.kernel.org>; Sun,  8 Dec 2024 19:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=qBgyykTX5j1Jbm9UotQeMB/1Fbbb/+PgTp56R0AbndM=;
  b=FDWh08+lM45+EEzDEsq+noTWaN7kx1GFFb1Ym4VxmhL0AVK1+q9zFI3m
   lvi2C2JzSBzvR4F/KuT3ZPnSF7G/cyamN74LGrVs5Fp8ApSJqLwUD4Mz9
   jNZx/XSb5U9eWAoPtASLr9w6rbJL82m06p0Jbdg1A8c0LJoJdwcIVq4LO
   c=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.12,217,1728943200"; 
   d="scan'208";a="197982839"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Dec 2024 20:16:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 11A97E0D3D; Sun,  8 Dec 2024 20:16:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AF3D6E00B6
	for <cocci@sympa.inria.fr>; Sun,  8 Dec 2024 20:16:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qBgyykTX5j1Jbm9UotQeMB/1Fbbb/+PgTp56R0AbndM=;
  b=Xcgvk+ANZ5Bchd0O4Inzv+pPH8Zk5fdXrFcaftg97jmcgeF8/uoEo7Qy
   LLPOWER1Q6ZQVS0uIflb+jg5xER6F1CAyUrpoUpkq+p+WSq59wefltSUH
   PrhWi+VjyrLInw9h8OicxwClJF4xKxvu0/zYcs5wWdRy1CvrM1Ir2HT9B
   s=;
X-IronPort-AV: E=Sophos;i="6.12,217,1728943200"; 
   d="scan'208";a="197982788"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:16:47 +0100
Date: Sun, 8 Dec 2024 20:16:47 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Zack Rusin <zack.rusin@broadcom.com>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <CABQX2QMwBGJHnehxy4j0gHgmUWBBuFqncLWbDZWEdENtGOrZ3w@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2412082014130.3332@hadrien>
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com> <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr> <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com> <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de>
 <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com> <1995b696-6825-a144-fcb-c5f9f3b1094@inria.fr> <CABQX2QOb9C4G3Kejo_ght3Dgo0qxHW5A6it4GB6TdgoU0Bo7sQ@mail.gmail.com> <alpine.DEB.2.22.394.2412081042370.3332@hadrien>
 <CABQX2QMwBGJHnehxy4j0gHgmUWBBuFqncLWbDZWEdENtGOrZ3w@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Replacing type names
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2169
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/alpine.DEB.2.22.394.2412082014130.3332%40hadrien>

> > Function name:
> >
> > @r1@
> > identifier i : script:python(t) { needs_rename(i) };

Oops, this should be

identifier i : script:python() { needs_rename(i) };


> > @@
> >
> > i(...) { ... }
> >
> > @script:python adjustment_fnname@
> > ...
> > @@
> > ...
> >
> > @@
> > identifier r1.i, adjustment_fnname.updated;
> > @@
> >
> > - i
> > + updated
> >   (...) { ... }
> >
> > Parameter name:
> >
> > @r2@
> > identifier fn;
> > type T;
> > identifier i : script:python(t) { needs_rename(i) };

Same here.

> > @@
> >
> > fn(..., T i,...) { ... }
> >
> > @script:python adjustment_paramname@
> > ...
> > @@
> > ...
> >
> > @@
> > identifier r2.i, adjustment_paramname.updated;
> > @@
> >
> > fn(...,
> >    T
> > -  i
> > +  updated
> >    ,...) { ... }
>
> Ah, that moved the conversion quite a bit. The "identifier" doesn't
> seem to accept the script:python, but I was able to reuse position p
> with it. Based on that I added type replacement for parameters:
> https://gist.github.com/zackr/85ab3864fb70905738cdead35d787f9f
> is the most complete version of the script but it's not there yet. It
> renames quite a bit of the sample_case.c - misses the struct
> declarations and the struct accesses. I was trying to fix struct
> declaration matching with:
> @r6@
> identifier i, i2;
> position p : script:python(i) { needs_rename(i) };
> @@
>
> typedef struct i@p {...} i2;
> but that results in parse_error around i2.

I think i2 needs to be a type.

> Also while the above linked
> script works on sample_case.c when I point it at actual source code I
> get:
> ocaml exception: <capsule object "ocaml-capsule" at 0x76b7c27ec4b0>
> failed to parse type const brc_device_params *
> Error in Python script, line 96, file "camel_to_snake.cocci": Python failure.
>
> I'm going to give up on this for now. Pure regex camel-to-snake works
> well enough for me and even in its current form the cocci script is
> pretty complex and it's still not handling all the cases so the odds
> of anyone else on the team being able to maintain it are very slim. I
> do appreciate your help! It helped me understand quite a bit more
> about Coccinelle in the process. Thank you.
>
> I'm going to leave the
> https://gist.github.com/zackr/85ab3864fb70905738cdead35d787f9f up in
> case anyone would like to continue down this road

OK thanks for the effort.

julia
