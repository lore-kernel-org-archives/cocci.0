Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD899C433EF
	for <cocci@archiver.kernel.org>; Fri, 22 Jul 2022 19:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=t+VnFPW68jI0u3QZ2xYGlLlN9Mr/t8USAD+i5Krxavs=;
  b=LiFLlkrp/bgOBssCCQl/fVY+9hdE8XnSJdDQ/DZbchvCSaI+FJTTCvK8
   UmYPjP6HoBJbX6PexuKC1wm36jTeYuY9R7Oj15zHJRvpFDPh6ldnvuAy+
   wJnuQqbN6JHCYZLNIZmdo1i1I6Rn5TypitEXRidzGfidUqXHtTHqJ01Nt
   0=;
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
X-IronPort-AV: E=Sophos;i="5.93,186,1654552800"; 
   d="scan'208";a="46628054"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jul 2022 21:30:54 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6EAF5E02D7; Fri, 22 Jul 2022 21:30:54 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DF7BCE0260
	for <cocci@sympa.inria.fr>; Fri, 22 Jul 2022 21:30:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=t+VnFPW68jI0u3QZ2xYGlLlN9Mr/t8USAD+i5Krxavs=;
  b=FRwSAVBgEWzVyjHC/0At1/U6+AWs8XFVGFo2HW0oporSui19MFxDNk/i
   D+hz5BDFzDzT0h1ETgE9xD7D3FdnEeFgNPSyu7y7hMJ0ktsFWHPURLzTd
   kEH2p1aCVw8GjKcCDbs0d0W9MaW9CSrpTDDeAydiJeGQd06pKYs2IhNil
   8=;
X-IronPort-AV: E=Sophos;i="5.93,186,1654552800"; 
   d="scan'208";a="46628053"
Received: from unknown (HELO hadrien) ([87.129.180.234])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 21:30:48 +0200
Date: Fri, 22 Jul 2022 21:30:44 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: "Richard W.M. Jones" <rjones@redhat.com>
cc: cocci@inria.fr
In-Reply-To: <20220722192327.GA28597@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2207222129160.2321@hadrien>
References: <20220722192327.GA28597@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] pcre vs pcre2
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 498
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/alpine.DEB.2.22.394.2207222129160.2321%40hadrien>



On Fri, 22 Jul 2022, Richard W.M. Jones wrote:

> PCRE (not PCRE2) is end of life: http://www.pcre.org/
>
> and may be removed from Fedora:
>
>   https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/message/K3BUC6T5VIG7LXOV4RVFO7IUPE2LGA2J/
>
> It seems as if coccinelle has an optional dep on PCRE enabled/disabled
> through ./configure --enable-pcre-syntax.  It's not entirely clear to
> me what Fedora would lose by disabling this.
>
> Does coccinelle plan to move to PCRE2?
>
> I have moved a few projects over to PCRE2.  It's definitely not an
> automatic conversion, although it also wasn't especially difficult.
> Here's libguestfs.  This is mostly C and we maintain our own PCRE
> bindings for OCaml which are not based on Markus Mottl's bindings, but
> it should give you an idea of the changes:
>
>   https://github.com/libguestfs/libguestfs/commit/82493579f38f39769861f31403ccfb8e97b41f96
>   https://github.com/libguestfs/libguestfs-common/commit/0b244f2b0cfc920f2432f5df45e108583f0d2901
>
> We decided not to support alternate PCRE or PCRE2 compiles since all
> distros have provided PCRE2 for a long time.
>
> Also:
>
>   https://github.com/mmottl/pcre-ocaml/issues/25

Thanks for the warning.  I don't think Coccinelle (the implementation)
actually uses PCRE in any important way.  It just makes PCRE availble to
the user for writing semantic patches.  I will look into how we can
convert (or at least make PCRE2 available as an additional option).

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
