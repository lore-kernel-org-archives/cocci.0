Return-Path: <SRS0=e0oP=24=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E9AC33C99
	for <cocci@archiver.kernel.org>; Tue,  7 Jan 2020 10:30:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E583207E0
	for <cocci@archiver.kernel.org>; Tue,  7 Jan 2020 10:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E583207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 007ATx8M004122;
	Tue, 7 Jan 2020 11:29:59 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F2EF577DB;
	Tue,  7 Jan 2020 11:29:58 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CD0A23784
 for <cocci@systeme.lip6.fr>; Tue,  7 Jan 2020 11:29:56 +0100 (CET)
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 007ATtRp010560
 for <cocci@systeme.lip6.fr>; Tue, 7 Jan 2020 11:29:55 +0100 (CET)
Received: from localhost (p5486CF8B.dip0.t-ipconnect.de [84.134.207.139])
 by pokefinder.org (Postfix) with ESMTPSA id 134CD2C05BA;
 Tue,  7 Jan 2020 11:29:55 +0100 (CET)
Date: Tue, 7 Jan 2020 11:29:54 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <20200107102954.GB1135@ninjato>
References: <20200107073629.325249-1-maxime@cerno.tech>
 <alpine.DEB.2.21.2001071106420.3004@hadrien>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001071106420.3004@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 07 Jan 2020 11:29:59 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 07 Jan 2020 11:29:55 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: michal.lkml@markovi.net, Gilles.Muller@lip6.fr,
        Mark Brown <broonie@kernel.org>, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>, Julia.Lawall@lip6.fr,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinnelle: Remove ptr_ret script
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1635304484=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


--===============1635304484==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 11:06:56AM +0100, Julia Lawall wrote:
>=20
>=20
> On Tue, 7 Jan 2020, Maxime Ripard wrote:
>=20
> > The ptr_ret script script addresses a number of situations where we end=
 up
> > testing an error pointer, and if it's an error returning it, or return 0
> > otherwise to transform it into a PTR_ERR_OR_ZERO call.
> >
> > So it will convert a block like this:
> >
> > if (IS_ERR(err))
> >     return PTR_ERR(err);
> >
> > return 0;
> >
> > into
> >
> > return PTR_ERR_OR_ZERO(err);
> >
> > While this is technically correct, it has a number of drawbacks. First,=
 it
> > merges the error and success path, which will make it harder for a revi=
ewer
> > or reader to grasp.
> >
> > It's also more difficult to extend if we were to add some code between =
the
> > error check and the function return, making the author essentially reve=
rt
> > that patch before adding new lines, while it would have been a trivial
> > addition otherwise for the rewiever.
> >
> > Therefore, since that script is only about cosmetic in the first place,
> > let's remove it since it's not worth it.
> >
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>=20
> Acked-by: Julia Lawall <julia.lawall@inria.fr>

Convincing patch description, good catch!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4UXaIACgkQFA3kzBSg
KbZSJA//eaZ9Y30oBx4dvR9MAfnqJNL8vx1eaSQyTcuwrb1agcOSP2yBfkZE+sH4
Co+Zly+1IjKpRE6r9zLFbv83rFFK4Lt6JA/L5tXTBIMxEXXA3Cb2plnpfsMbDq8I
ah6RUroz4n46w1Kd5cU78RB813tchIizvvhdWIbuSUqgeE6FurBJOW0ybrNOYO+8
L9q9tM5rKGZIfEs68rxMIZnL+MkcO+47jykNqrJOrqsX87pVJtoiY7uuH36OvuUn
7bgC8LWQJvRG3U7wKyugqZhqkLCfqUN1dAtYCEZC0IcrzUfZO6HNOK4dzOg9W8Xd
nVcLA7z0PEFDYdP1uMyprUT9HnwN4zktCF6Bm+xIMgMSI0ukiOaYnx4bFXMVecl0
JudONZisFLHZ9KzOfSzXhfv/Pltwzs0KUul8k6KYqRrHuC+lmFiV7juKccPX6Y3g
FIjd2K5S3ITQDXrbixxfEhRFaqhOflgtvYoNnHZYs4F7SoSJx3iR7RLpyNdlKXjp
fJWOohJo9xoOiphmueC6QO2hG18UXMEfP0CcJFUfU4WCGS//3rLlH9O/XZp2V/rU
9taGESdnSAubzx72/mvsi7fkYC/p5gvFFqRxOwFpDcOoaN0yrQ/2WlQ5//AazC0O
ZwinD8thAFb1EA7fGSYeVv6+37e8EnAX0T2M6YPs30UBW4yYczo=
=kiKB
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--

--===============1635304484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1635304484==--
