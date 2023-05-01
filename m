Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FCDC77B7C
	for <cocci@archiver.kernel.org>; Mon,  1 May 2023 21:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Q+gDkpN8GlUd/G0WIY1NhxFdSL05Mkfo1IvVkjACMmo=;
  b=B1j0AkCMsSiMoHmqU+UYF5TQGalEYoQ5dLNAlcKc6k5mHAuUHuEc/A85
   jus2vS+4gwbhQi8mTYR22HBQQ/oWfcf1AoNEugIThh/JI2HjGJmO5e9Fd
   qwo9O5DJKYNLxsfOHP1UmDyh0GOWrMCMpOM/pHVkp8HwBZr9ZqODVrplx
   g=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="5.99,242,1677538800"; 
   d="scan'208";a="105692402"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 May 2023 23:27:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D647BE0D45; Mon,  1 May 2023 23:27:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9EEA1E0D40
	for <cocci@sympa.inria.fr>; Mon,  1 May 2023 23:27:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q+gDkpN8GlUd/G0WIY1NhxFdSL05Mkfo1IvVkjACMmo=;
  b=MckIDEUte51HGSaUj3vMKtLN4sHCo2a288Ktpz/BTyfuruNS+lwU59Dw
   Ox9VuWgnAtkQYchgPpVvzuThFRL3lW/fEPZvaDehDRUH4pyS/495Z92Ev
   /YpVsdI37b+9EzFflMCiWiSZJEZYmoaWtWkWtoIxqKvdeny7cypqjNoiR
   o=;
X-IronPort-AV: E=Sophos;i="5.99,242,1677538800"; 
   d="scan'208";a="105692400"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 23:27:43 +0200
Date: Mon, 1 May 2023 23:27:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <645026ea.620a0220.f1a4f.8a79@mx.google.com>
Message-ID: <alpine.DEB.2.22.394.2305012327350.2911@hadrien>
References: <644ae01c.170a0220.77675.8ed2@mx.google.com> <alpine.DEB.2.22.394.2304291516550.2899@hadrien> <645026ea.620a0220.f1a4f.8a79@mx.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] metavariables in added attribute arguments
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1137
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/alpine.DEB.2.22.394.2305012327350.2911%40hadrien>



On Mon, 1 May 2023, Kees Cook wrote:

> On Sat, Apr 29, 2023 at 03:17:40PM +0200, Julia Lawall wrote:
> > > [...]
> > > @annotate@
> > > type COUNTER_TYPE, ARRAY_TYPE;
> > > identifier allocated.STRUCT;
> > > identifier allocated.ARRAY;
> > > identifier allocated.COUNTER;
> > > attribute name __counted_by;
> > > @@
> > >
> > >  struct STRUCT {
> > >         ...
> > >         COUNTER_TYPE COUNTER;
> > >         ...
> > >         ARRAY_TYPE ARRAY[]
> > > +       __counted_by(COUNTER)
> > >         ;
> > >  };
> > >
> > > This fails like so:
> > >
> > > $ cocci element_count.cocci net/packet/af_packet.c
> > > plus: parse error:
> > >   File "element_count.cocci", line 33, column 15, charpos = 593
> > >   around = 'COUNTER',
> > >   whole content = +     __counted_by(COUNTER)
> > >
> > > But I can produce (nonsense) output if I change the replacement to:
> > >
> > > 	ARRAY_TYPE ARRAY[
> > > +	COUNTER
> > > 	]
> > > +	__counted_by
> > > 	;
> > >
> > > Explicitly using "attribute name __counted_by;" didn't seem to help.
> > > What am I missing?
> >
> > The problem is fixed.  Actually, attributes in this position were just not
> > supported at all.  Thanks very much for the report.
>
> Hurray! Thank you; the latest git works as I'd expect now. :) Now to get
> my patch for the Linux kernel split up...
>
>  153 files changed, 157 insertions(+), 157 deletions(-)

:)

julia
