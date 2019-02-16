Return-Path: <SRS0=17+G=QX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069F1C43381
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 09:07:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C698222D9
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 09:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C698222D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1G974Lw011255
          ; Sat, 16 Feb 2019 10:07:04 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2FCA976FA;
	Sat, 16 Feb 2019 10:07:04 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1591576F4
 for <cocci@systeme.lip6.fr>; Sat, 16 Feb 2019 10:07:03 +0100 (CET)
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1G972Xs010720
 for <cocci@systeme.lip6.fr>; Sat, 16 Feb 2019 10:07:02 +0100 (CET)
X-pt: isis.lip6.fr
Received: from localhost (unknown [195.52.228.164])
 by pokefinder.org (Postfix) with ESMTPSA id 01D5C2C0509;
 Sat, 16 Feb 2019 10:07:01 +0100 (CET)
Date: Sat, 16 Feb 2019 10:06:58 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20190216090658.lsfhvtllwnzj3675@ninjato>
References: <201902161633004137519@zte.com.cn>
 <alpine.DEB.2.21.1902160934400.3212@hadrien>
 <992b8c6f-614d-b379-6352-30b36ac9d0d8@web.de>
MIME-Version: 1.0
In-Reply-To: <992b8c6f-614d-b379-6352-30b36ac9d0d8@web.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 16 Feb 2019 10:07:04 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 16 Feb 2019 10:07:02 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [Cocci] [v5] coccinelle: semantic code search for
 missingput_device()
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
Content-Type: multipart/mixed; boundary="===============0292795928=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


--===============0292795928==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mpidk2alepylbuio"
Content-Disposition: inline


--mpidk2alepylbuio
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 16, 2019 at 09:57:54AM +0100, Markus Elfring wrote:
> > We don't need perfection.
>=20
> I guess that you noticed in the meantime that I dare to propose
> more software development efforts in such a direction.

Yes, this is noticable. It is your choice, however, other people may
have their reasons for other choices...

> > We need more to eliminate the memory leaks.

=2E.. like this one.

> Will this view evolve into further helpful and constructive clarification=
s?

Given my above, what is the evaluation of the same question to yourself?

Regards,

   Wolfram


--mpidk2alepylbuio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxn0q4ACgkQFA3kzBSg
Kba8qxAAje15NT5l07pf3Vrh13e+9aiL+22EMykTDGEPH9HgeOP58Dnw/DgFFo/W
eoIuw7fR0cK33MI/L0yOyWkfWPa0Eg86acVtArgevil07PcObuT/2MGOXhN+MWKW
2Ecy7yj/LzcUmT2f1p+NGF8DCggMZjscKvj3InRttSJlhMuCVxsT6gg+3LOMonl7
L72gYrGdh+CMG+To7bkf0RCpwJbK4k3h11Ay7R0OUAr57yTJ3H1aYl+V7glXdBvm
Oiw/BwyNPF9gRIzQBuAeBn2mI2VioU3/Cfj2dtwNxy6duAJb11KNKK8xWLpjbZFY
bFswd5OGiCJY4EuVW3CofkPsQKo0eSPGQwB6whUsQYe4qAY5XwZr/FS2bczN1xtM
u9Ya7zWHrFfmhc7b2lE4eO/Cw85kpNfnoy2SPi1Sn/8yjoPTvzvhinqlaWJido10
zcMLc/pukHX/cOTK0Oqwqgq2Tp2C0Z2XdWAUDHfcKzSjkR4fW8FZs8a78TMAmBKX
hlEseUygcYpq9QxBJIb7LMO7sv4WwY/Hq1Ac/EPw6rNzDSlAC/rFHVU/2uNHWTgi
CsGt2twijdYlGEEbtIxi8MF6yCtGr8H5ARr4Uz6oyl+hmSrmWl0cMWJ/TuRGbkj0
SnU4KkwP3GCZjm9RnmKyCLLE5sCvvxvd9ODDTcZ/wW0aYETGv7o=
=IqtW
-----END PGP SIGNATURE-----

--mpidk2alepylbuio--

--===============0292795928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0292795928==--
