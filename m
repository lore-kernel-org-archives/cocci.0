Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899BBC43334
	for <cocci@archiver.kernel.org>; Mon, 13 Jun 2022 18:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=VqY83WnLw7div7bHBckfXUAQw7tvsKCYYD/az4YNkks=;
  b=hSFOl/sFMPQueE1J5Ar5L9Rz4+NDy+ODs308BTktTvqFR7UEVstx+pxm
   xYDgXfL9gbv3ejVDslFD+fBHhQuM7wUFuYCEXFFZ/LSo2AVgCpBPSUZrg
   9x4SIPyTKvnvN7IVUyKAOO2DfDdhJ7CdUCFav1z/RXXoEAysCcNwoQEZf
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.91,297,1647298800"; 
   d="scan'208";a="40819470"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jun 2022 20:11:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2A7C0E0152; Mon, 13 Jun 2022 20:11:11 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A8830E0038
	for <cocci@sympa.inria.fr>; Mon, 13 Jun 2022 20:11:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VqY83WnLw7div7bHBckfXUAQw7tvsKCYYD/az4YNkks=;
  b=ccto52SXTNLktM2HN5wWPjSk5suoL+b9mSX3/OhvWR/B9cbON+o7ULlY
   y3xpVrfKgPytt6ZzLB2B9a1rgKbBy6fLElwBqH0stLaxoOmv7qkmz2RC5
   NBZumE2lXPoQtu9fyHMNLelXWK5TmBHvpT1X4qXuZtYpdYcR9bUShG1IF
   k=;
X-IronPort-AV: E=Sophos;i="5.91,297,1647298800"; 
   d="scan'208";a="40819465"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 20:11:08 +0200
Date: Mon, 13 Jun 2022 20:11:08 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
cc: Markus Elfring <Markus.Elfring@web.de>, "cocci@inria.fr" <cocci@inria.fr>, 
    "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, 
    Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <AS8PR03MB76031920B2F9E7A0A7A6A97893AB9@AS8PR03MB7603.eurprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2206132010200.2902@hadrien>
References: <AS8PR03MB76033CF2848D03651D6E189093A69@AS8PR03MB7603.eurprd03.prod.outlook.com> <a8c3479c-c8f1-da57-23fe-657c2f13872b@web.de> <AS8PR03MB76031920B2F9E7A0A7A6A97893AB9@AS8PR03MB7603.eurprd03.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1457815613-1655143868=:2902"
Subject: Re: [cocci] [PATCH v3] coccinelle: Extend address test from ifaddr
 to every test expression
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 440
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/alpine.DEB.2.22.394.2206132010200.2902%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1457815613-1655143868=:2902
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 8BIT



On Mon, 13 Jun 2022, Jérémy LEFAURE wrote:

> > A)
> > I would like to point out once more that no questionable places were marked
> > by the software “Coccinelle 1.1.1” (OCaml 4.14.0) in the following source code.
> > https://lore.kernel.org/cocci/da86bc36-36af-7bd7-6bee-861e160ba6a4@web.de/
> > https://sympa.inria.fr/sympa/arc/cocci/2022-06/msg00017.html
> >
> >
> > void check(void)
> > {
> > int s = 1;
> > bool t = (&s);
> > }
> >
> >
> > Thus I propose to add another case distinction by the means of
> > a SmPL disjunction.
> >
> >
> > *\( &x || ... \| &x \)
> >
>
> Unfortunately this creates false positives as it matches address-of
> operator outside of test expressions such as in this code:
>
> void foo(int *a);
>
> void call_foo(int a)
> {
>   foo(&a);
> }
>
>
> > B)
> > I imagine that generated diff output should be wrapped by a source block
> > for the operation mode “org”.
> > https://orgmode.org/quickstart.html#blocks
>
> This patch does not change the "org" mode output, it only changes the
> matching part. Anyway, I am not sure that coccilib supports blocks, I
> did not find any reference to block in the code [1]. Do you have an
> example were it is used?
>
> [1]: https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/master/python/coccilib/org.py

No, I don't think that blocks are supported and the org mode code should
be fine as it is.  In any case, it's not relevant to this patch.

julia

--8323329-1457815613-1655143868=:2902--
