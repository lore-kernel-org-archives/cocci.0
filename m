Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6C7F3C241
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2026 12:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=aU2Hi1s2xEgEwdxkTkIWEfRUA920pnYvd6OQyz9nDYM=;
  b=Nbv+vA8y9144ZR0UhWaF7VR72nJ7BtqwGOnMTtN457z9NsLakxHGwzaa
   YYTnc0PVOC20NRUcjz5Xu3En10SP9kYMefUZF1M+poSdep7zzz/GDBeAn
   jDo5DK0gFix/uhjNsRsU6Cc5R6VtjXQ1buFONkR6Krdd3VNL3wHZwVdts
   I=;
X-CSE-ConnectionGUID: p4/49IxVSO6GpFihXHOF8Q==
X-CSE-MsgGUID: y5i6XQ/XRLqscAIId4BAuQ==
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
   d="asc'?scan'208";a="266890383"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2026 13:55:20 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id CF530830C2; Mon,  9 Mar 2026 13:55:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D0B5483083
	for <cocci@sympa.inria.fr>; Mon,  9 Mar 2026 13:10:29 +0100 (CET)
X-CSE-ConnectionGUID: ACd1HbgPRKOLb5OR6UGKoQ==
X-CSE-MsgGUID: GvAN+EsCRBSGldC8o7hhyw==
IronPort-SDR: 69aeb8b5_KOfXT3FGeNOsSU6EIemHuyH2Qlw++0amGfUzsbnDZMO7ypa
 6DchNTS6/eYNtN8NAiqoqAH5NEH7zB/VL/J+NWg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F4BACYt65phR/86qxaglmCQYEHXzMEC0kDhFWDT4Ush?=
 =?us-ascii?q?liCIQNphRGFeoZ3iy8UgWkCCAcBAwEIBUoHBAEBAwEDhDpGAo0hAh4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQFASYZPD?=
 =?us-ascii?q?YJiATNxgSUBAQEBAQEBAQEBAQEBHQINfQEBAQECASMdAQE3AQQLCxgqAgIQR?=
 =?us-ascii?q?gaDFQGCIgcjJwMRrEd6gTKBAYIMAQEGgQjbIoFeCQMGFAGBOIFYhnAMAYFdh?=
 =?us-ascii?q?FuCU2l6Jxt9gRCEBzg+gkoXBBiBEQESAQeDdYJpgiaBDoF/hw2KD1KBFANZL?=
 =?us-ascii?q?AFLCjUMMytFQwOBKUsFN2USPyEdDxwfOQI4BwUSIREZgUp4ggEPhmp5AyMLX?=
 =?us-ascii?q?hoOIgI6XEo+ZQWCJAN4PTcUGwSMURAhDYIOPoFSeGUvEIFNMAcBGhNIknGeL?=
 =?us-ascii?q?JUXhCaMHpYag3GNEwSGN5MZLphYjgmWGYUfgW8LKGxwMxoIKAiDIk8DGQ+OO?=
 =?us-ascii?q?oRihBjDZ0I1AgEBDCwCBwEKAQEDCZIea2ABAQ?=
IronPort-PHdr: A9a23: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
 BMyzAxkbrZ0nN8Jy1Q6PFzHoG03ikZjwb3Y
IronPort-Data: A9a23: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
 bjLq6dhLoxYNrH/eUfkhj7xvZJJNA==
IronPort-HdrOrdr: A9a23:k1IEAKordA6xsBUkOaAft+YaV5okeYIsimQD101hICG9vPb4qy
 mLpoV96faUskd0ZJhEo7290ca7LU80maQb3WBVB8bFYOCEghrMEGgB1/qA/9SIIUSXnYRgPO
 VbAspD4bbLbWSS4/yV3DWF
X-Talos-CUID: 9a23:mULyUWHwoUoZW5bFqmJO30JNOsoqSkf+61PafmiCV1tGa7qsHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3Au3NCogwE0CHwXeoiOTfJY0a+LbOaqIuwIWZOvI4?=
 =?us-ascii?q?tgeO/Gih8EGea0zS3U5Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="asc'?scan'208";a="140798166"
X-MGA-submission: =?us-ascii?q?MDFi1v3B8r9NSDE8gDthejMNLERJnWiVMs4h9e?=
 =?us-ascii?q?1mXEs6ox0H1CrqpVrNFbp31o5xQxkPtQ3V8zstF9hU8myDLB0S8FxvlG?=
 =?us-ascii?q?FhelduqXF4QePjG62Fh9O8tiyYuFGNbeZ7LAOHdi3iK5Bl2q86kG4bLc?=
 =?us-ascii?q?zfHxWeQalrEw9vQlooqbQchQ=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 13:10:29 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 23084441A5;
	Mon,  9 Mar 2026 12:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3D0C2BC86;
	Mon,  9 Mar 2026 12:10:24 +0000 (UTC)
Date: Mon, 9 Mar 2026 13:10:22 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Kees Cook <kees@kernel.org>
Message-ID: <aa6vSvsp4J6InmiB@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <f1c9dff525752dc5a839760269a1c96d6e0870b4.1772752564.git.alx@kernel.org>
 <cab3d2a8-4c3f-45e6-9e7f-8bdca48a6209@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvowzgf7khn6nplo"
Content-Disposition: inline
In-Reply-To: <cab3d2a8-4c3f-45e6-9e7f-8bdca48a6209@web.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Alejandro Colomar <alx@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3356
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/jhrlcFM0hA2E_s4Hw-t5bg>


--cvowzgf7khn6nplo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [cocci] [PATCH] scripts/coccinelle: Add script for using
 ARRAY_END()
Message-ID: <aa6vSvsp4J6InmiB@devuan>
References: <cover.1772752564.git.alx@kernel.org>
 <f1c9dff525752dc5a839760269a1c96d6e0870b4.1772752564.git.alx@kernel.org>
 <cab3d2a8-4c3f-45e6-9e7f-8bdca48a6209@web.de>
MIME-Version: 1.0
In-Reply-To: <cab3d2a8-4c3f-45e6-9e7f-8bdca48a6209@web.de>

Hi Markus,

On 2026-03-09T12:17:00+0100, Markus Elfring wrote:
> =E2=80=A6
> > This script makes it easy to find more places where that macro should be
> > used.
>=20
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv7.0-rc3#n94

Thanks!

> =E2=80=A6
> > +++ b/scripts/coccinelle/misc/array_end.cocci
> > @@ -0,0 +1,93 @@
> =E2=80=A6
>=20
>=20
> > +// Confidence: ???
>=20
> I hope that a more reasonable value can be determined for this informatio=
n.

I don't know how the scale works.  I know the script has a few false
negatives, and AFAIK there are no false positives.  To what level of
confidence would that belong?

Is that field a keyword, or may I be explicit such as with this?:

// Confidence: no false positives, but a few false negatives

Or maybe I should write that in Comments...

> =E2=80=A6
> > +// Comments:
>=20
> Please omit such an empty field.

Ok; thanks!

$ grep -rh '^// Comments:' scripts/coccinelle/ | sort | uniq -c
     34 // Comments:
      2 // Comments: -
      1 // Comments: -I ... -all_includes can give more complete results
      1 // Comments: Comments on code can be deleted if near code that is r=
emoved.
      1 // Comments: Some false positives on empty default cases in switch =
statements.
      1 // Comments: requires at least Coccinelle 0.2.4, lex or parse error=
 otherwise
$ find scripts/coccinelle/ -type f | wc -l
76


It seems around half of the existing scripts have that.  You may want to
remove those empty comments.  I added it because the scripts I looked at
do have it.

> =E2=80=A6
> > +@i@
> > +@@
> > +
> > +#include <linux/kernel.h>
>=20
> I doubt that such an SmPL rule would be required.

Okay, I'll remove it.  Thanks!

> > +
> > +//----------------------------------------------------------
> > +//  For context mode
> > +//----------------------------------------------------------
> > +
>=20
> Please omit such extra comment lines.

Agree.  BTW, you may want to remove such lines from existing scripts:

$ grep -r '^//.*For context mode' scripts/coccinelle/
scripts/coccinelle/null/deref_null.cocci:// For context mode
scripts/coccinelle/misc/boolconv.cocci://  For context mode
scripts/coccinelle/misc/array_size.cocci://  For context mode
scripts/coccinelle/misc/struct_size.cocci://  For context mode
scripts/coccinelle/misc/newline_in_nl_msg.cocci://  For context mode
scripts/coccinelle/misc/badty.cocci://  For context mode
scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci://  For context mode
scripts/coccinelle/api/alloc/zalloc-simple.cocci://  For context mode
scripts/coccinelle/api/alloc/alloc_cast.cocci://  For context mode
scripts/coccinelle/api/pm_runtime.cocci://  For context mode
scripts/coccinelle/api/resource_size.cocci://  For context mode
scripts/coccinelle/api/vma_pages.cocci://  For context mode

> > +@depends on i&&context@
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
>=20
> Extra space characters may be omitted directly after SmPL asterisks.

Good to know; thanks!

Although most scripts seem to be using white space (space (164) or
tab (26)) after the asterisk.  Please confirm if you prefer it removed
in new scripts.  Only 39 scripts don't have white space after it.

$ grep -rh '^\*' scripts/coccinelle/ | grep -o '^..' | sort | uniq -c
     26 *=09
    164 *=20
      4 *(
      1 *;
      1 *E
      1 *I
      1 *P
      2 *W
      1 *\
      1 *b
      1 *c
      3 *d
      1 *e
      4 *f
      1 *g
      2 *i
      1 *l
      4 *r
      2 *s
      1 *u
      2 *w
      5 *x
$ grep -rh '^\*' scripts/coccinelle/ | grep -o '^.\s' | sort | uniq -c | hd
00000000  20 20 20 20 20 32 36 20  2a 09 0a 20 20 20 20 31  |     26 *..   =
 1|
00000010  36 34 20 2a 20 0a                                 |64 * .|
00000016
$ grep -rh '^\*' scripts/coccinelle/ | grep -o '^.\S' | wc -l
39


> =E2=80=A6
> > +@r depends on (org || report)@
>=20
> You may omit parentheses here.

Ok.

> =E2=80=A6
> > +@script:python depends on report@
> > +p << r.p;
> > +@@
> > +
> > +msg=3D"WARNING: Use ARRAY_END"
> > +coccilib.report.print_report(p[0], msg)
>=20
> Would the following command variant be a bit nicer?
>=20
> coccilib.report.print_report(p[0], "WARNING: opportunity for ARRAY_END()")

Sounds good.

> By the way:
> How do you think about to omit a cover letter for a single patch?

Sounds reasonable.  I like the cover letter as it holds the range-diff,
which may become a bit confusing when it's in the same email as the
patch, but maybe that's just me.

I'll send v2 in a single email.

>=20
> Regards,
> Markus

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--cvowzgf7khn6nplo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmuuK0ACgkQ64mZXMKQ
wqkSzw/7BsY+QbHN9FP+p5Frj+Yh5Vr3bWpVw9TsBPrJ7Uq3JcaZHHDmXtIxZSj1
toOrlHkdfWlOLA+4QEec+PyFf3tTcAPu5jFYRazT9QjPwyj/vGSep6A4XKrZ/CQv
Mvgn/OLhoW0/0SGqYp6xMmJxcNIpo+7Idm7cVnwf8WQNvHOToQBLDdXIOv6z18tI
XFFQxayGDbK39nQldUB7j7c+lfO8w/Qpj9yrkrgLFrkRa3CDyeMUh/n/SIoepHPj
crYvb2C95hZFEHdI8UbWLlRtpMRj/ZbltH0MZn7Hn6xrh55kKQOVgQzjew39IkRW
J3xyGV5PejQZ3Ju2htZPcdOsHVksmcBLb1W5IXxJMBIIPuMeyGiqf6sl/tIR3l5Y
6jHJMIaKBy6zZRBOx80uyZEVhuTV43bEjePDfVLou7KWvBLNnCpDALUaLzlfhlaS
HVPJJdVtUEQ96v+3tPdefIL/+HYvopI+L4Cg3ob5eIAxYTjd0JduKvZHh22a5vYg
ccyVRtO9IOtY77z/5bw5r9lY8CqN/1rG/tHUQhS2RPd9337bkcFFprt0UTZxnBPP
4Szqx+KeeaODP4YaAVlPkWfNFWjbWk2+0m8MFfGWz79OkJZpI6zY7EbvQlDU1zXe
cmMZX5yhs8JJ1d2n0GE6H3R4SLVcjZn64tSDO7w+zjx9v7W/1+s=
=gFux
-----END PGP SIGNATURE-----

--cvowzgf7khn6nplo--
