Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1984EF3C241
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2026 12:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=EAED+Tu6yd+64PBTA0ArEd4LjUz2cIaluXHQ8ZsNgdI=;
  b=IbJl81bb3Ww7VWpFz3anixTSKK2RgM8rgFVuh5QPLNMCMttsBcVpG22A
   mEmHraUw2zO5UtW4IO2QO+tS135z1jHY8vpDRZcrifOygdbLzMJgj07tZ
   KB7HW+1Wt8U4tlW5nRRVBIzwjfH2vX11w0nn3zzrx3m6izYYNXJrfz/7J
   I=;
X-CSE-ConnectionGUID: SADZ88h1TH+pIdSdDzD93g==
X-CSE-MsgGUID: VCx2fyvOTeaYA1QBi3FFkQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="asc'?scan'208";a="266890474"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2026 13:55:25 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 863B6830C7; Mon,  9 Mar 2026 13:55:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 06C6D805D7
	for <cocci@sympa.inria.fr>; Mon,  9 Mar 2026 13:27:42 +0100 (CET)
X-CSE-ConnectionGUID: z1GYzJYqSLehnB/gkAWrFw==
X-CSE-MsgGUID: OwAtyVIGRtGKM7YzzL+Fig==
IronPort-SDR: 69aebcbd_Yk0T9D2RTQ2svBaL2JPohz5pG7y6CwcYqmhYKoeWw91gDgd
 bDOkGpS0a631KuPKkQA1dpDamBg+v14h3zj0oXg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HrAgDau65phR/86qxahRqBB18zBAtJhFiDT4UshlhbA?=
 =?us-ascii?q?QEGgT4DhXqFeoZbHItDgWkCCAcBAwEIBTcaBAEBAwEDhQACjSECHgcBBDQTA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBQEmGTw2CY?=
 =?us-ascii?q?gEzcYElAQEBAQEBAQEBAQEBAR0CDX4BAQECASMdAQE3AQQLC0ICAhBGBoMVA?=
 =?us-ascii?q?YIiByMnA61QgTKBAYIMAQEGgQjbIoFeCQMGFYE4gViGcAwBgV2IF3onG32BE?=
 =?us-ascii?q?IQ/PoQpg3WCaYImgQ6Bf4cNig9SgRQDWSwBSwo1DDMrRUMDgSlLBTdlEj8hH?=
 =?us-ascii?q?Q8cHzkCOAcFEiERGYFKeIIBD4ZqeQMjC14aDiICOlxKPmUFgiQDeD03FBsEj?=
 =?us-ascii?q?FEQIQ2CDj6CSmUTASuBfQYBARrHD4QmojiDcY0ThjuTGS6YWKlBgX8jgVwzG?=
 =?us-ascii?q?ggoCIMiTwMZD446hGKEGMNzQjU8AgcBCgEBAwmSHmtgAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 k8bi4dAD656F5DTVWYUVwoVvJJJ
IronPort-HdrOrdr: A9a23:6hUjyq8AF0898DxSSJBuk+DXI+orL9Y04lQ7vn2ZhyY1TiW9rb
 HIoB17726RtN91YhwdcL+7VJVoLUmyyXcx2/h2AV7AZniChILLFvAA0WKK+VSJcEfDH6xmpM
 VdmsNFaOEYY2IVsfrH
X-Talos-CUID: 9a23:UdMJc2BSZAgP4M/6Ezs+238GOPE8SVnQzHH6ZEC7IFlzZqLAHA==
X-Talos-MUID: 9a23:J0CbwwUxKO6YU+Pq/BjzrS1zCuZH2biBK2VSoIcUn4qqNCMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="asc'?scan'208";a="266882919"
X-MGA-submission: =?us-ascii?q?MDHNy6R7/A96F3JI8N2oWnt6VK0B082UX0vaZr?=
 =?us-ascii?q?rEmF5V8TYN9x/gZvMQdajUM4XtFvzOrNIlpDQtanRmY5Q+MS6ND+P+JR?=
 =?us-ascii?q?463ha9WmSbhT3YcmTMCYJUyb/U3bp/o4SpUwT0rXi8+IOIlEdaZslrxC?=
 =?us-ascii?q?KNHUab/u2Lx0pq8Rwu35AdTg=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 13:27:41 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AA7704053C;
	Mon,  9 Mar 2026 12:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070EEC4CEF7;
	Mon,  9 Mar 2026 12:27:37 +0000 (UTC)
Date: Mon, 9 Mar 2026 13:27:35 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr, 
	Nicolas Palix <nicolas.palix@imag.fr>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Kees Cook <kees@kernel.org>
Message-ID: <aa677-Ag_KU8QHjh@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <f1c9dff525752dc5a839760269a1c96d6e0870b4.1772752564.git.alx@kernel.org>
 <cab3d2a8-4c3f-45e6-9e7f-8bdca48a6209@web.de>
 <aa6vSvsp4J6InmiB@devuan>
 <f950c541-1c21-7d5-b7d7-1a14bb6e8a4@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2cd5ltaszjzcae4y"
Content-Disposition: inline
In-Reply-To: <f950c541-1c21-7d5-b7d7-1a14bb6e8a4@inria.fr>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Alejandro Colomar <alx@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3359
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/KQpuHW2Uf9Qj-i7_qlOiKA>


--2cd5ltaszjzcae4y
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr, 
	Nicolas Palix <nicolas.palix@imag.fr>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [cocci] [PATCH] scripts/coccinelle: Add script for using
 ARRAY_END()
Message-ID: <aa677-Ag_KU8QHjh@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <f1c9dff525752dc5a839760269a1c96d6e0870b4.1772752564.git.alx@kernel.org>
 <cab3d2a8-4c3f-45e6-9e7f-8bdca48a6209@web.de>
 <aa6vSvsp4J6InmiB@devuan>
 <f950c541-1c21-7d5-b7d7-1a14bb6e8a4@inria.fr>
MIME-Version: 1.0
In-Reply-To: <f950c541-1c21-7d5-b7d7-1a14bb6e8a4@inria.fr>

Hi Julia,

On 2026-03-09T13:21:23+0100, Julia Lawall wrote:
[...]
> > > > +// Confidence: ???
> > >
> > > I hope that a more reasonable value can be determined for this inform=
ation.
> >
> > I don't know how the scale works.  I know the script has a few false
> > negatives, and AFAIK there are no false positives.  To what level of
> > confidence would that belong?
>=20
> Probably high would be fine.  The goal is mostly to indiacte whether the
> results are most likely correct or whether they will require a lot of
> study to know if everything is ok.

Thanks!  I've put high with a comment about the false negatives.

[...]
> > > > +// Comments:
> > >
> > > Please omit such an empty field.
> >
> > Ok; thanks!
> >
> > $ grep -rh '^// Comments:' scripts/coccinelle/ | sort | uniq -c
> >      34 // Comments:
> >       2 // Comments: -
> >       1 // Comments: -I ... -all_includes can give more complete results
> >       1 // Comments: Comments on code can be deleted if near code that =
is removed.
> >       1 // Comments: Some false positives on empty default cases in swi=
tch statements.
> >       1 // Comments: requires at least Coccinelle 0.2.4, lex or parse e=
rror otherwise
> > $ find scripts/coccinelle/ -type f | wc -l
> > 76
> >
> >
> > It seems around half of the existing scripts have that.  You may want to
> > remove those empty comments.  I added it because the scripts I looked at
> > do have it.
>=20
> I don't require taht an empty comments field be removed.

Ok.

> > > =E2=80=A6
> > > > +@i@
> > > > +@@
> > > > +
> > > > +#include <linux/kernel.h>
> > >
> > > I doubt that such an SmPL rule would be required.
> >
> > Okay, I'll remove it.  Thanks!
>=20
> I'm lacking context.  You maye need this if the file doesn't already have
> it.  But it is hard to know if it could be include indirectly...

Hmmm, this macro is defined together with ARRAY_SIZE() in
<linux/array_size.h>.  I guess even if a file isn't including that
already (including indirectly), it would do well in including it for
using the macro, so I guess it's okay to remove it here.

The only concern would be files that *can't* possibly include it (maybe
tools/?).


> julia

Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--2cd5ltaszjzcae4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmuvLEACgkQ64mZXMKQ
wqn6uhAAhRxwUq+7FMbWfJuKkdY+WdePvmNeYDMlxXAfzK17buNcjfTj3Z1ZzIBk
ZcuW9hxVH5UhWn5lFlSmY6+/8rmUB9K/EI2pERtbIlG7qEwOuCLxDLxuxsqyX7Yc
Tw0c7kLWDlOm9yRfrLzFiQHKzD+i8pq0XyInERaoi9rY3D7mezQ2vzb2hxtFUStt
kwnw1lvxzzLG7f47h4MfdNT/N5Cjct09rg/Smd5CkWmR135OwqcvorA2SKXUCH5s
N3ttS469atteNtxMdSYsaJkkBhUwUXMnt97l4PJp/u406Y8O0lnDvUV1zD9PrFXn
iDLl+lEJ2d1drJDXxkVbf2jvHodqCSIdPSN5jzFgUTW2UfShItCjS7hbM9SgJjmZ
5Q+4kNMRs5qWdZ2duWiOIb3vB1b1AhICEOZLlu2WL2cNRiQseWZFYYSGlCIwSRvk
xxuicHNf/w4pZvAIJCuSkbBnqbbbiDJVgFtUh28Ex22CHHIvlXGpyc7TBAT3Z3PV
Qnd5HyEoYgX8fNpYkl/tg8i06ftakB6uA6S165MiehYZ4/VyAupSyMYYzFjRIURl
2hRkrwvhAST3PNnbS91TQLljOO7U25rid+mlVP8J7v+FlJUyKIn4C438NpUmBeSD
i5y3lX+nk3J05Jq6PB4p0htMORILogUCjbY4Nu0cXzqgQxb2IfI=
=J0wJ
-----END PGP SIGNATURE-----

--2cd5ltaszjzcae4y--
