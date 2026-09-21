Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB37C982FA
	for <cocci@archiver.kernel.org>; Tue, 22 Sep 2026 07:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=q1Vuqg/RoOl/cHPXrzRjwCuYQXO1j3Aet+10a30hMMM=;
  b=JwueKbkYJ1MywFdUMVtSQJtLZnLkirPvofSPV+0ovDb+MyY9UCEfBWMo
   Ob9t1drd5H3D8NudBaQaIjLZpIUVh3hWphyuHWuc9hCAlOYnlqzOZ9jz8
   lfQX/JoUJnimbtKjauzSrtUkm4tcNSJVG7g4ag8mpy6E4WWE6xMHbNw6H
   E=;
X-CSE-ConnectionGUID: t+V3MXKXTAKFsoy5USTN5g==
X-CSE-MsgGUID: ZiDgrjN/T7C4hc+b5cKHew==
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
X-IronPort-AV: E=Sophos;i="6.27,116,1787004000"; 
   d="asc'?scan'208";a="296196396"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2026 09:06:12 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 562AF82109; Tue, 22 Sep 2026 09:06:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 23F8B8046E
	for <cocci@sympa.inria.fr>; Mon, 21 Sep 2026 15:28:04 +0200 (CEST)
X-CSE-ConnectionGUID: aqlcemTCT06CzVvlgiW3zg==
X-CSE-MsgGUID: 50Y0vCS1QmGVFGQCNWQ8pg==
IronPort-SDR: 6ab130e3_N5laCAbElTmDTYH/wjzf+T287JNevW1Q1dg0lB25ni0IP7v
 OTwYOsdIWaRPdNaiWetXdvZOGYYP7/A0dMx5fvA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EEAACSL7Fqjx/86qxaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF8BgEBAQsBgkCBC2EzBAtJhFiDT4RMX4ZYggQdA4EThGeFeoZ3iVuBV?=
 =?us-ascii?q?RSBaAIIBwEDAQgFNxoEAQEBAgEDhH4CjggCHgcBBDAJDgECBAMCAwEBAQEBA?=
 =?us-ascii?q?QEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEBAQE5BUmGTw2MGgEzcYElA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAR0CDX0BAQEBAgEjHQEBNwEECwsUAS0CAhBGBgESgwIBg?=
 =?us-ascii?q?iIHEQMQJwPFCHqBMoEBggwBAQaBCdosIl2BYgkDBhQBgTgBgVeDZ4MSDQGBX?=
 =?us-ascii?q?YQbOwmCVWl6Jxt9gRCBFYJzOD6EBiM6gzuCaoImgQyBWpJrUoEUA1ksAUsKN?=
 =?us-ascii?q?QwzK0UQMwMqL1BLBTdlEgwMJxIPHQ8ZHjkCOAYFEiARGUFDIwM+VIEHPyMZN?=
 =?us-ascii?q?nqBCV5wOylgAQIlRkGCCAKCVIEjB1cCAUlDDgdFUwknSxJHKSIIEgkBExowC?=
 =?us-ascii?q?4FrPTcGDxkEjhUQIQ2CKh+CWgGBDiyBEaRwozCEKKI8l0CTGi6YWiOkAIUgg?=
 =?us-ascii?q?Wg6gVwzGggoCIMiUAMZD44iGYRkhBjHCEI1PQIHAgcOAwuSHIFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RH0i0UD6I+5xIy9FVFYJcjlO368b57UMwz0sQ==
IronPort-HdrOrdr: A9a23:a+MLc6lsIyf09/5DuCateM4Qwn3pDfIS3DAbv31ZSRFFG/Fw9v
 rEoB11726RtN98YhAdcJO7UpVoIkmskqKdg7NhWItKNTOO0FdASrsSjrcKqAeQeREWmNQ86U
 /2GZISNDURZWIVse/KpC2jA8xl6MCGmZrFuQ9VpU0DcT1X
X-Talos-CUID: =?us-ascii?q?9a23=3Az6NsD2tSaU+si4XzpEzRVJC+6Issa3nWwXLsCHP?=
 =?us-ascii?q?gV017dqORRl6vo7Frxp8=3D?=
X-Talos-MUID: 9a23:tSbE8QsQ6Ln7j5Y5ts2n2WlTbNlD2P2XDW8zv7o/kO+7DHxoNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,114,1787004000"; 
   d="asc'?scan'208";a="157531957"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDF6Wmtiasd2HBllQeFFj/JGAFoWtSB4i84Ksp?=
 =?us-ascii?q?kTzAxFZN87+uqLgtcsxj1dldG8fjTFARbyw0GzdfrF1xL9LIHQNBsy30?=
 =?us-ascii?q?K3B7Fm8Ew5y6VVB1GFIwdDJguyZHW4YV5bY/rZAmz/J7AEIsedaYZm4n?=
 =?us-ascii?q?n7v+2ocZziMBbjuukn92KAQA=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 15:28:03 +0200
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4E59A403F2;
	Mon, 21 Sep 2026 13:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D8E1F000FF;
	Mon, 21 Sep 2026 13:27:56 +0000 (UTC)
Date: Mon, 21 Sep 2026 15:27:53 +0200
From: Alejandro Colomar <alx@kernel.org>
To: cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>, 
	Kees Cook <kees@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, 
	Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <arEwYlADtpPqQ41P@debian>
References: <cover.1772752564.git.alx@kernel.org>
 <2ae22f8b73f6424020a6fe876cf2120c7d75b552.1773612610.git.alx@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="alzubz4tizoor3gy"
Content-Disposition: inline
In-Reply-To: <2ae22f8b73f6424020a6fe876cf2120c7d75b552.1773612610.git.alx@kernel.org>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Alejandro Colomar <alx@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3739
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/qNrfMBpZz2ROm6EjGUSUNA>


--alzubz4tizoor3gy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>, 
	Kees Cook <kees@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, 
	Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [PATCH v3] scripts/coccinelle: Add script for using ARRAY_END()
Message-ID: <arEwYlADtpPqQ41P@debian>
References: <cover.1772752564.git.alx@kernel.org>
 <2ae22f8b73f6424020a6fe876cf2120c7d75b552.1773612610.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <2ae22f8b73f6424020a6fe876cf2120c7d75b552.1773612610.git.alx@kernel.org>

Hi Julia, Kees,

Just a gentle ping on this patch.  Is there anything else I should do to
get this merged?


Have a lovely day!
Alex

> Date: 2026-03-15 23:11:03+0100
> From: Alejandro Colomar <alx@kernel.org>
>
> Recently, we added an ARRAY_END() macro to simplify finding a pointer
> one past the last element in an array.  Such a pointer is often called
> the 'end', and thus the macro name.
>=20
> Make it easy to find more places where that macro should be used.
>=20
> See also:
> 436debc9cad8 ("array_size.h: add ARRAY_END()")
> 8118f197b7b7 ("mm: fix benign off-by-one bugs")
> a9e5620c9a9e ("kernel: fix off-by-one benign bugs")
> 61e9210e2392 ("mm: use ARRAY_END() instead of open-coding it")
>=20
> Cc: Kees Cook <kees@kernel.org>
> Cc: Markus Elfring <Markus.Elfring@web.de>
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>=20
> Hi!
>=20
> This v3 only has one change: I've removed the comment about the false
> negatives.  They were due to spatch(1) not being able to correctly parse
> unrelated code elsewhere.
>=20
> See range-diff and interdiff at the bottom.
>=20
>=20
> Have a lovely night!
> Alex
>=20
>  scripts/coccinelle/misc/array_end.cocci | 73 +++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/array_end.cocci
>=20
> diff --git a/scripts/coccinelle/misc/array_end.cocci b/scripts/coccinelle=
/misc/array_end.cocci
> new file mode 100644
> index 00000000..88c664de
> --- /dev/null
> +++ b/scripts/coccinelle/misc/array_end.cocci
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Use ARRAY_END instead of an expression derived from ARRAY_SIZE
> +//
> +// Confidence: High
> +// Copyright: 2026, Alejandro Colomar <alx@kernel.org>
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +@depends on context@
> +type T;
> +T[] a;
> +expression b;
> +@@
> +(
> +* (a + ARRAY_SIZE(a))
> +|
> +* (&a[0] + ARRAY_SIZE(a))
> +|
> +* (&a[ARRAY_SIZE(a)])
> +|
> +* (&a[ARRAY_SIZE(a) - b])
> +)
> +
> +@depends on patch@
> +type T;
> +T[] a;
> +expression b;
> +@@
> +(
> +- (a + ARRAY_SIZE(a))
> ++ ARRAY_END(a)
> +|
> +- (&a[0] + ARRAY_SIZE(a))
> ++ ARRAY_END(a)
> +|
> +- (&a[ARRAY_SIZE(a)])
> ++ ARRAY_END(a)
> +|
> +- (&a[ARRAY_SIZE(a) - b])
> ++ ARRAY_END(a) - b
> +)
> +
> +@r depends on org || report@
> +type T;
> +T[] a;
> +expression b;
> +position p;
> +@@
> +(
> + (a@p + ARRAY_SIZE(a))
> +|
> + (&a[0]@p + ARRAY_SIZE(a))
> +|
> + (&a[ARRAY_SIZE(a)]@p)
> +|
> + (&a[ARRAY_SIZE(a)@p - b])
> +)
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING should use ARRAY_END")
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING: opportunity for ARRAY_END")
>=20
> Range-diff:
> 1:  9fd8d3d1 ! 1:  2ae22f8b scripts/coccinelle: Add script for using ARRA=
Y_END()
>     @@ scripts/coccinelle/misc/array_end.cocci (new)
>      +//
>      +// Confidence: High
>      +// Copyright: 2026, Alejandro Colomar <alx@kernel.org>
>     -+// Comments: No known false positives, but has a few false negatives
>      +// Options: --no-includes --include-headers
>      +
>      +virtual patch
> --=20
> 2.53.0
>=20

--=20
<https://www.alejandro-colomar.es>

--alzubz4tizoor3gy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmqxMNIACgkQ64mZXMKQ
wqkjLw//cUyOyqKtrjcOX5kgBM5+o88LpuNlN1CEoDMhbLdD4Blo7SEtxyDLyDQW
uOKLdNtxsbhkfRhfuux6p9ElJarHhy5UbY/pzCYnOmFVLmt+2EL9lGJtxqVIqI9K
WG1aEP9NhTAOsdWH3WBt3WLCZNV6Upb2vrKLN/O/CkobOboxKCmRbU5LC/J/ANSF
rhtm/xwEtfRaqHb6xOPmVVDJKFbhcM+xOjwzkZMflJXz0tLdznrm5BuqFydpyLnz
il4kUyuyHfMzpuwYSNk+GT/gUzK3ismE+AKEzr/7u9pNNf0XM0QFe1qw607jaE8C
ueq+E3OnSVXRNj8R/C3vvcEFAFpNKDMJuZ2uMhOv6ziXVWa+2PC59Vpg3dcaTfc6
rdCTspFefRkMSKfmTcXSBWKyoyhIq8DzHgDYUv3QE++fJ8C0bQHHc0SYTUkVLwKL
3zrcHQ7cfcWBV+RT+aaPnakE8ADWMxDr/vvddEh9ueEvOLT8t+HorYmbgigKsIU4
KKM8lcmzGJ1dLtQlCU9atBgUPI1w43foXs/9zjpfL6AnBjfJrOXoLPVvg6nsZQ25
fdMFW/O7YUiAaMtHtT6509PjDjQGUxECEzfwV/IwuR+rtXhfClY3a0GTD29NPLbP
2XHb6JRGQYl+qaa7Ev93Mu03e6WZ39qYYh3WnWk0RkD4Hpfcwlw=
=ROPC
-----END PGP SIGNATURE-----

--alzubz4tizoor3gy--
