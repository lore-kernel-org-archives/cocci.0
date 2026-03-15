Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F005F46421
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2026 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=gJ2NmnTGbsBEaikoAjMv8Sl3/5B3pum4oLHZ0BFUUEs=;
  b=iqT3UoHkINRPHpUVDadxP+n5JXLjlYtPFMJr9O5VnPs76F1U49d2rAqB
   RTOLxQft5XE7FLTUVk/d4nBm7BT0U2PO0LcRpZsAO7n5kiybSweA9QT3l
   St0avUhRm9tFYJaIoXP2mBq46Qwrtn8WM3/MG4OIAlv5E5ObsZuAiW3z+
   4=;
X-CSE-ConnectionGUID: 6SrTbbY4RbG9CNu8hp+uJQ==
X-CSE-MsgGUID: 9fi8mEpkQDSmDeZR0vGOYg==
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
X-IronPort-AV: E=Sophos;i="6.23,123,1770591600"; 
   d="asc'?scan'208";a="267915620"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Mar 2026 10:29:34 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0BBD181F2F; Mon, 16 Mar 2026 10:29:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5306A80E67
	for <cocci@sympa.inria.fr>; Sun, 15 Mar 2026 23:12:21 +0100 (CET)
X-CSE-ConnectionGUID: DXk5Bs5YS4WiQOCiLzPW2A==
X-CSE-MsgGUID: 6cspcxQTTDufZeyTrpdAgA==
IronPort-SDR: 69b72ec4_8MUUmIJlhlj+hP3TAEqMkAssSj73bWU1WRhTyqHPXVVbz9p
 4RkeAaSU2B4kInW9oKDEGX7dL828Eos8fEkubQg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FwAQBzLrdphf4EaaxaglmCQYEHXzMEC0mEWINPhSyGW?=
 =?us-ascii?q?IIhA4EThGeFeoZ3iVqBVRSBaQIIBwEDAQgFNxoEAQEDAQOFAAKNIwIeBwEEM?=
 =?us-ascii?q?AkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBQEmGT?=
 =?us-ascii?q?w2CYgEzcYElAQEBAQEBAQEBAQEBAR0CDX0BAQEBAgEjHQEBNwEPCxgqAgIQR?=
 =?us-ascii?q?gYBEoMCAYIiBxEDDycDs1Z6gTKBAYIMAQEGgQjaJyJZgV4JAwYUAYE4gViGc?=
 =?us-ascii?q?AwBgV2EFzsJglNpeicbfYEQgRWCcjg+hAYjg3WCaYImgQ6JB4olUoEUA1ksA?=
 =?us-ascii?q?UsKNQwzK0VDAyovUEsFN2USPyEdDxwfOQI4BwUSIREZgUR4ggEPhmp5AyMLX?=
 =?us-ascii?q?hoOIgI5XEo+XQWCLQInA3g9NxQbBIxfECENghA9gjMBgQ4sgRGkbqMvhCaiO?=
 =?us-ascii?q?Jc/kxkumFgipACFH4FoOoFcMxoIKAiDIk8DGQ+OOoRihBjEAkI1PQIHAgcNA?=
 =?us-ascii?q?wuSHIFLAQE?=
IronPort-PHdr: A9a23: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
 h07kA1zZaIq7ji+uj8K
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:I4C/jqAE1/vBZ37lHemj55DYdb4zR+YMi2TDGXoRdfVwSL3+qy
 nOpoV+6faQslsssR4b9exoVJPufZqYz+8S3WBzB8bGYOCFghrKEGgK1+KLqFfd8m/Fh4xgPM
 xbE5SWZuefMWRH
X-Talos-CUID: 9a23:iT8PEW23NyizUpadukQLxLxfNvAmL1fGkUbrf3C5MEFCSZmHcWDK0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3ATpKtwg+MwAeCIp7EdlV3aNiQf5lj+LylGHkxrbk?=
 =?us-ascii?q?btfuJJBBqIzu0gx3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,122,1770591600"; 
   d="asc'?scan'208";a="141379336"
X-MGA-submission: =?us-ascii?q?MDF9b4eDX2Mvh75zDS3s2XJ+6sYKcLT2ZACIiY?=
 =?us-ascii?q?TRMhYFljg5Ou58HSH7W0tqQRuGjVAUDBs+fa0GJYvmlL/3kQ40VKYijX?=
 =?us-ascii?q?Y5lWub34TSu/fMwaQth3vpuArRVcBJqdXBTX5qgQuBu5F6crSah6rcxd?=
 =?us-ascii?q?XWL1HiQ6EHdbracPujpu8sxA=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 23:12:19 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 602E161861;
	Sun, 15 Mar 2026 22:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C24C4CEF7;
	Sun, 15 Mar 2026 22:12:16 +0000 (UTC)
Date: Sun, 15 Mar 2026 23:12:14 +0100
From: Alejandro Colomar <alx@kernel.org>
To: cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, Kees Cook <kees@kernel.org>, 
	Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <abcusyeK0YEyYcOa@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <2ae22f8b73f6424020a6fe876cf2120c7d75b552.1773612610.git.alx@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5jjfmo73qf2vidfg"
Content-Disposition: inline
In-Reply-To: <2ae22f8b73f6424020a6fe876cf2120c7d75b552.1773612610.git.alx@kernel.org>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Alejandro Colomar <alx@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3437
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/m5oRf3HRL0DN83oWkqO-GA>


--5jjfmo73qf2vidfg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, Kees Cook <kees@kernel.org>, 
	Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [PATCH v3] scripts/coccinelle: Add script for using ARRAY_END()
Message-ID: <abcusyeK0YEyYcOa@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <2ae22f8b73f6424020a6fe876cf2120c7d75b552.1773612610.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <2ae22f8b73f6424020a6fe876cf2120c7d75b552.1773612610.git.alx@kernel.org>

On 2026-03-15T23:11:03+0100, Alejandro Colomar wrote:
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

Oops, actually, only the range-diff.

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

--5jjfmo73qf2vidfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmm3Lr4ACgkQ64mZXMKQ
wqnrsw/9G3wnBpashhburlsSNbUzzhZcn9yDOedHmUQ2qcQ/OlG4RcpISopKWV5E
pZnUawavXdMLGp+0In+2yf4nEK9+bo0Ib4G5W6U79zoY1gt4xus3QTRr1FiBT5Lg
dZI9UZDBhzvyUmZluTjUHxNttMSN5dsX4TSM2HOyOoSSd4r13qkFSoaMAH9A9rUX
81D76k3yxIrVvHGDMEq6flYY0cFeohigym20LH2A0v5T8I1ygCgbhyTVRhUOewPo
Uvy25Bhd2Q1MAnkClDTAOi/7Z0ofVe/osBUoV056Vk0p5VueIDhN3U2BHktqrI/P
cpW6regft6NO8Fmef662hcANBrPEGdXv44ViuhGWCFr//oR6Cfrvg247b/ZCEGeB
2uyvwihZUKBen6m2XspC9XDagHItPvQiGP54YNmAlv6Sjf7s2YMyuOn+ApRipSir
NNS6/nRrF9bReGzstOCYHf3yiN6l6dY+bZ12OF4/9swmixScpTiA7UusucShUWd1
aimc9uVZgCxfqjALbAnqQyV8hLDHJmhUfROORz1RZ0+TGk5knCjFMmOTMwx6g2rN
QvP58nGvCS4TaVAy3NuhRdwCqkXCjwJHvBm8QtEFfOdsWKbNFuLFU6vVNHCR1Rsg
e18WZWfYneNwR7IEDkKSjxn0csdbOSUeo35yPmxtUH6VmrEw800=
=V6hG
-----END PGP SIGNATURE-----

--5jjfmo73qf2vidfg--
