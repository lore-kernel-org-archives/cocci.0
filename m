Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7212FC43334
	for <cocci@archiver.kernel.org>; Sat, 16 Jul 2022 13:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3PoS8DpyWBhSXgTxWQ64LeSKe0HdDSvLwvADW+ITtb4=;
  b=WLADriEHKImkLz+CzhtSykqGFS1ZBBzRL5JIKPszwTdH5nyeDZKbb7K5
   SbdKh3cSu3baoYVnc8iSpJyLBYDttbhhDgB851RnVCU1SPZJLwHptkftz
   hqyQ4tKepZ4wOqs3XHMdz3ZZgIxIGFYG4ao+pI6NDQnOwBBFapsFGY77M
   g=;
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
X-IronPort-AV: E=Sophos;i="5.92,276,1650924000"; 
   d="scan'208";a="45761692"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jul 2022 15:02:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2E8FFE0261; Sat, 16 Jul 2022 15:02:35 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1B803E0260
	for <cocci@sympa.inria.fr>; Sat, 16 Jul 2022 15:02:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3PoS8DpyWBhSXgTxWQ64LeSKe0HdDSvLwvADW+ITtb4=;
  b=V8phYbgvlrPEin/5K6ImIjb0H74PT2YHJJSFM75aylGw2p8CzgiI6+1B
   ByO4qI8y6DuEOhQ2cl7uFMSAy1AmUzlwje63r9bDAF5WIpe85AZTM8D8O
   LRoXVvwGRp6NHCcp5tN4stq9Bb5ZU53oIZ2qzHhhZS/QgRQteVmPG5SqR
   M=;
X-IronPort-AV: E=Sophos;i="5.92,276,1650924000"; 
   d="scan'208";a="19464325"
Received: from 150.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.150])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 15:02:33 +0200
Date: Sat, 16 Jul 2022 15:02:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: cocci@inria.fr
In-Reply-To: <7d52b5cd-9b7a-e966-ee3d-f3343c8dcfb6@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2207161502150.3842@hadrien>
References: <7d52b5cd-9b7a-e966-ee3d-f3343c8dcfb6@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-249963643-1657976552=:3842"
Subject: Re: [cocci] spatch errors out with "not supported"
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 495
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/alpine.DEB.2.22.394.2207161502150.3842%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-249963643-1657976552=:3842
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Thu, 30 Jun 2022, Ilpo Järvinen wrote:

> Hi all,
>
> I tried to find a particular pattern with coccinelle, but it seems to give
> me an error. Here's a trimmed down version highlighting the problem:
>
> $ make C=2 MODE=patch CHECK=scripts/coccicheck COCCI=scripts/coccinelle/cleanups/write_verify2.cocci drivers/ata/sata_mv.o
>   CHECK   scripts/mod/empty.c
> /usr/bin/spatch -D patch --very-quiet --cocci-file
> scripts/coccinelle/cleanups/write_verify2.cocci -I ./arch/x86/include -I
> ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I
> ./arch/x86/include/generated/uapi -I ./include/uapi -I
> ./include/generated/uapi --include ./include/linux/compiler-version.h
> --include ./include/linux/kconfig.h scripts/mod/empty.c
> not supported
> coccicheck failed
> make[1]: *** [scripts/Makefile.build:250: scripts/mod/empty.o] Error 255
> make: *** [Makefile:1199: prepare0] Error 2
> $
>
> Here's write_verify2.cocci:
>
> virtual patch
>
> @@
> identifier writefunc =~ ".*write.*";
> identifier readfunc =~ ".*read.*";
> identifier rval;
> expression wval, reg;
> @@
> -       do {
> -               writefunc(wval, reg);
> -               rval = readfunc(reg);
> -               udelay(...);
> -       } while (...);

do while should be supported now.

julia

>
> If I comment out those do and while lines, coccinelle picks up the
> relevant fragments (but the loop is important part of the full construct
> I'm looking for). Why does it fail with do {} while ()? I've checked the
> grammar and according to it "do single_stmt while (dot_expr);" should be
> a valid construct.
>
> $ spatch --version
> spatch version 1.1.0 compiled with OCaml version 4.11.1
> Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc
> --libdir=/usr/lib --enable-ocaml --enable-python --enable-opt
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expressions: PCRE
> $
>
> I feel I've seen that "not supported" other times too. I don't know if
> it's easy to make it more verbose where things go wrong (I could find any
> option which would have told me more than that). Such an error message
> isn't that helpful like you can imagine.
>
>
> --
>  i.
>
>
--8323329-249963643-1657976552=:3842--
