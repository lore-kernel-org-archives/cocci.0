Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48F9C98324
	for <cocci@archiver.kernel.org>; Sun, 27 Sep 2026 11:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=FyBAhIm/gY7Dsn6+Xqu8udWAM9Qk0tV2T62COzPyKuY=;
  b=ftDk0F0UCa5qY1DLzQ0NZTauKgM+P9az6ma4O7ZOr5sGRs+XcmiS7lxy
   Ef1bV97LYgxezZU5wWBFkMUswzeeYUmlFAjMsDhtA0LJia/h4jfhoBNst
   ijM9eckM5vGDNbYVyIDNDSnGfAx5g6rpDnTs5MkBJ4yjdxvl55ITeS4H1
   E=;
X-CSE-ConnectionGUID: NFuGgwbJS3KT+QWKpiNHZQ==
X-CSE-MsgGUID: BwImzegmTZKLsVw6clT2cw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.27,126,1787004000"; 
   d="asc'?scan'208";a="297140596"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Sep 2026 13:12:23 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 308A88183C; Sun, 27 Sep 2026 13:12:23 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D67048131F
	for <cocci@sympa.inria.fr>; Sun, 27 Sep 2026 12:48:55 +0200 (CEST)
X-CSE-ConnectionGUID: 4f1txMPOSu6H6/YJiRwC7w==
X-CSE-MsgGUID: R7v+abdDSTGmfDSIOZzxjQ==
IronPort-SDR: 6ab8f497_tEcJqSlmQ49HEfe3Dvprr3zs2zH0qHJhboHBIQ/MFLtmYJv
 SoDctf/rIAcBoTZxOhCkblDdFUIRsxTq6k2Prtg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EUAACI87hqjx/86qxaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBgkCBC2EzBAtJhFiDT4RMX4ZYggQdA4EThGeFeoZ2izAUgWgCCAcBA?=
 =?us-ascii?q?wEIBTcaBAEBAQIBA4R+Ao4KAh4HAQQwCQ4BAgQDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QEEAQEBAgEBAgQDAQEBAQIQAQEBAQEBOQUOO4ZPDYwaATNxgSUBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQINfQEBAQECASMdAQE3AQQLCxQBAyoCAhBGBhODAgGCIgcRAxAnA?=
 =?us-ascii?q?74KeoEygQGCDAEBBoEJ2iwiXYFiCQMGFAGBOAGBV4NogxINAYFehBtEglVpe?=
 =?us-ascii?q?icbfYEQgRWCczg+hAYjOoM7gmqCERWBDIFak0BSgRQDWSwBSwo1DDMrRUMDg?=
 =?us-ascii?q?SlLBTdlEj8hHQ8ZHjkCOAYFEiARGUFDXVOBBz8jGTZ6gQlecDspYAECJUZBg?=
 =?us-ascii?q?gcCglSBIwdXAgFJQw4HRVMJJUsSRyYiCBIJARMaMAuBIThKKHg9NxUZBI5zE?=
 =?us-ascii?q?CENgiwegmQBWTURG4ERB4EHkx6QRKMwhCiiPJdAkxwumFqkI4UggWg6gVwzG?=
 =?us-ascii?q?ggoCIMiUAMZD44iGSWEP4QYxwhCNT0CBwIHDgMLkhyBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nNsMJ6skftJI7CkVHVRmdiN27skDedV00zEX/kB9WHVpmwKj9v
 xGuM5rsiMc6QxhPE3I/OrsBEDuex/hHPJOjrX5eI3SOjUO21HYSb2Kj7GSoAEIcheWnoU26U
 4jSdkdNDSaNzhHZKjBjjWFLw==
X-Talos-CUID: 9a23:rNsPcG5vsT7KEahdkdssqEBNBtAASlrm0SnwfQiJK2dTV5bKVgrF
X-Talos-MUID: 9a23:xQ+MegsuFSoyRnqgcM2nvm58d85i74iVNG8In7k9mu62JzxyAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,126,1787004000"; 
   d="asc'?scan'208";a="297139488"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDG2ydEWoOitYSWawtkSZjC0ZLK+rMhbIbIEUV?=
 =?us-ascii?q?NB36Jb09rzEBJ02Qak9OOW7IqIxRqvMToJ5k78I2FyQtVIyOXYSQgDAh?=
 =?us-ascii?q?nUlI8yyV+JPUDgX1Rjkiww1NMjYWakuHEUqoNaWtGSJ+RgQ10lLZQ5Sv?=
 =?us-ascii?q?BgKesm5bK2HY1Sk1mnrlXFvw=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 12:48:54 +0200
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 89E0A43853;
	Sun, 27 Sep 2026 10:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A353F1F000FF;
	Sun, 27 Sep 2026 10:48:48 +0000 (UTC)
Date: Sun, 27 Sep 2026 12:48:43 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, Markus Elfring <Markus.Elfring@web.de>, 
	Kees Cook <kees@kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <arj0PChwFU6aWtRE@debian>
References: <arLXllXUgeG7jdpw@debian>
 <127f7c71-6ab7-5b4-2540-2e2dc3313a@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="traq7q34eepzu4uk"
Content-Disposition: inline
In-Reply-To: <127f7c71-6ab7-5b4-2540-2e2dc3313a@inria.fr>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v3 (resend)] scripts/coccinelle: Add script for
 using ARRAY_END()
Reply-To: Alejandro Colomar <alx@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3743
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/Ysj29z6VoPnqDuYhWhnPjg>


--traq7q34eepzu4uk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, Markus Elfring <Markus.Elfring@web.de>, 
	Kees Cook <kees@kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [cocci] [PATCH v3 (resend)] scripts/coccinelle: Add script for
 using ARRAY_END()
Message-ID: <arj0PChwFU6aWtRE@debian>
References: <arLXllXUgeG7jdpw@debian>
 <127f7c71-6ab7-5b4-2540-2e2dc3313a@inria.fr>
MIME-Version: 1.0
In-Reply-To: <127f7c71-6ab7-5b4-2540-2e2dc3313a@inria.fr>

Hi Julia,

> Date: 2026-09-27 11:21:54+0200
> From: Julia Lawall <julia.lawall@inria.fr>
>
>=20
>=20
> On Tue, 22 Sep 2026, Alejandro Colomar wrote:
>=20
> > Recently, we added an ARRAY_END() macro to simplify finding a pointer
> > one past the last element in an array.  Such a pointer is often called
> > the 'end', and thus the macro name.
> >
> > Make it easy to find more places where that macro should be used.
> >
> > See also:
> > 436debc9cad8 ("array_size.h: add ARRAY_END()")
> > 8118f197b7b7 ("mm: fix benign off-by-one bugs")
> > a9e5620c9a9e ("kernel: fix off-by-one benign bugs")
> > 61e9210e2392 ("mm: use ARRAY_END() instead of open-coding it")
> >
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Markus Elfring <Markus.Elfring@web.de>
> > Cc: Julia Lawall <Julia.Lawall@inria.fr>
> > Cc: Nicolas Palix <nicolas.palix@imag.fr>
> > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > ---
> >
> >
> > Hi Julia,
> >
> > Resent the patch now, as you asked me to do.
>=20
> Applied, thanks.
>=20
> Afterwards, I made two changes:
>=20
>     * Add disable zero_multiple_format to each rule to avoid considering
>     the possibility that an array index is expressed using '\0'
>=20
>     * Omit outer parentheses on context and org/report rules that
>     only match ubt don't transform, since matching a subterm gives
>     the same result whether or not the parentheses are present.

Thanks!!

I'll look at the patch to see how it changed, out of curiosity.  :)


Have a lovely day!
Alex

>=20
> julia
>=20
>=20
> >
> >
> > Cheers,
> > Alex
> >
> > Here's the original message that came with the patch:
> >
> > Hi!
> >
> > This v3 only has one change: I've removed the comment about the false
> > negatives.  They were due to spatch(1) not being able to correctly parse
> > unrelated code elsewhere.
> >
> > See range-diff and interdiff at the bottom.
> >
> >
> > Have a lovely night!
> > Alex
> >
> >  scripts/coccinelle/misc/array_end.cocci | 73 +++++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644 scripts/coccinelle/misc/array_end.cocci
> >
> > diff --git a/scripts/coccinelle/misc/array_end.cocci b/scripts/coccinel=
le/misc/array_end.cocci
> > new file mode 100644
> > index 00000000..88c664de
> > --- /dev/null
> > +++ b/scripts/coccinelle/misc/array_end.cocci
> > @@ -0,0 +1,73 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/// Use ARRAY_END instead of an expression derived from ARRAY_SIZE
> > +//
> > +// Confidence: High
> > +// Copyright: 2026, Alejandro Colomar <alx@kernel.org>
> > +// Options: --no-includes --include-headers
> > +
> > +virtual patch
> > +virtual context
> > +virtual org
> > +virtual report
> > +
> > +@depends on context@
> > +type T;
> > +T[] a;
> > +expression b;
> > +@@
> > +(
> > +* (a + ARRAY_SIZE(a))
> > +|
> > +* (&a[0] + ARRAY_SIZE(a))
> > +|
> > +* (&a[ARRAY_SIZE(a)])
> > +|
> > +* (&a[ARRAY_SIZE(a) - b])
> > +)
> > +
> > +@depends on patch@
> > +type T;
> > +T[] a;
> > +expression b;
> > +@@
> > +(
> > +- (a + ARRAY_SIZE(a))
> > ++ ARRAY_END(a)
> > +|
> > +- (&a[0] + ARRAY_SIZE(a))
> > ++ ARRAY_END(a)
> > +|
> > +- (&a[ARRAY_SIZE(a)])
> > ++ ARRAY_END(a)
> > +|
> > +- (&a[ARRAY_SIZE(a) - b])
> > ++ ARRAY_END(a) - b
> > +)
> > +
> > +@r depends on org || report@
> > +type T;
> > +T[] a;
> > +expression b;
> > +position p;
> > +@@
> > +(
> > + (a@p + ARRAY_SIZE(a))
> > +|
> > + (&a[0]@p + ARRAY_SIZE(a))
> > +|
> > + (&a[ARRAY_SIZE(a)]@p)
> > +|
> > + (&a[ARRAY_SIZE(a)@p - b])
> > +)
> > +
> > +@script:python depends on org@
> > +p << r.p;
> > +@@
> > +
> > +coccilib.org.print_todo(p[0], "WARNING should use ARRAY_END")
> > +
> > +@script:python depends on report@
> > +p << r.p;
> > +@@
> > +
> > +coccilib.report.print_report(p[0], "WARNING: opportunity for ARRAY_END=
")
> >
> > Range-diff:
> > 1:  9fd8d3d1 ! 1:  2ae22f8b scripts/coccinelle: Add script for using AR=
RAY_END()
> >     @@ scripts/coccinelle/misc/array_end.cocci (new)
> >      +//
> >      +// Confidence: High
> >      +// Copyright: 2026, Alejandro Colomar <alx@kernel.org>
> >     -+// Comments: No known false positives, but has a few false negati=
ves
> >      +// Options: --no-includes --include-headers
> >      +
> >      +virtual patch
> > --
> > 2.53.0
> >
> >
> > ----- End forwarded message -----
> >
> > --
> > <https://www.alejandro-colomar.es>
> >

--=20
<https://www.alejandro-colomar.es>

--traq7q34eepzu4uk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmq49IMACgkQ64mZXMKQ
wqm6GBAAg6jYpbOWqavwsozSyecAkrOhaEmNTizd/YH65HNgqWbD2TK7DRIU3ldf
QbDV9WN5uFuLb0s+F10JD+RigNr/jKZZbcCZSLQkaPlD1BZPhrAMIedMiDJJDjM1
AJM3kpFgJhWKzPlHNriOwpnLsxpRhtgNuGBVXfuCcEE4ODqGNUowUupouAFMXK0u
gBvHy+cPuURPZpRvQ7efb1D/1fQPq4MW5GS2uP6MeYe0tDgXwYaeLl+TEFQeuIvE
60PYG6K97XHKn3YPM+sSO6y4Gefl+hpa5G9Dw6IwtZCb2B1QjEdVeR15NW37IU6D
5l1X2naSz/tDDpCbnSIdrKD2RpDkN3u8tCw2BsmBjv3P8DtHUjjH/zMCuFn7rTK6
QBIXduYNbLxpo14zkYEleHL6zwljbjdFJ4EgJjceQDt1FpfajJFoX2mAkMtBLJpz
iqKtBPYqPOaHUcOsUmCzNMCPuDU8DWTBL9KHJbGGjEP9m0bvkgxoK1LFAaGciwQp
oj9c4BHfDEU7D6/rN/HBOLRF3zS3Nrifz8dDKhgdBDLz4RYwr/ZpC55fKQXJdDq1
kAZMLuUVcJKWbkqjhMmEpIAgOAGkjDAHu+8Yorh77fivqPNrglAMATzE22+Olz6e
Ms0J25iSft+M2+Rp/n4BfCyVb+Z2QSPpTy+C1Yi4R2b08blEywM=
=+HZX
-----END PGP SIGNATURE-----

--traq7q34eepzu4uk--
