Return-Path: <SRS0=J+fH=FT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353C6C2BB48
	for <cocci@archiver.kernel.org>; Tue, 15 Dec 2020 12:57:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EEC2246B
	for <cocci@archiver.kernel.org>; Tue, 15 Dec 2020 12:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EEC2246B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BFCuUwX000575;
	Tue, 15 Dec 2020 13:56:30 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3C1EB77A4;
	Tue, 15 Dec 2020 13:56:30 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 41ABC3A53
 for <cocci@systeme.lip6.fr>; Tue, 15 Dec 2020 09:48:32 +0100 (CET)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BF8mT8W025040
 for <cocci@systeme.lip6.fr>; Tue, 15 Dec 2020 09:48:30 +0100 (CET)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 00F0058031C;
 Tue, 15 Dec 2020 03:48:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 15 Dec 2020 03:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=h3oX4m+4ODPAKvjAZ8mPFFy+Fof
 Mm7MXA7iosatUhIk=; b=OgUjprAOYhN//F1okcQ4nTCrVhyxKU5xsiNau5e66qW
 +t6CuLhGUWHyjZT74sUpzcUYijXl1OCN8EkrRIMRBdyAIS6olS/OI/d9+Blm5NaO
 +hfQb13hDwGBq+I/g8cmhMA7992HQodZfGGG5sNm/qS7rLqSnKpgRKFDs0ND/ddI
 9Yo2pZngYVlzLSaoTESBqLXmiUcvfEjH4VMFz0JR+rNhLDog8xFkfN799FNkAZJ7
 571DCXHUNocasYuEA3x2hPCDOoQmMuw7V2iBJdNVw0MEAZBaurZI09eH/PcC/rI/
 JyWJOEK+80iZtM8cqpMwjoQsoh2QXVE1EPQtHGLOv6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=h3oX4m
 +4ODPAKvjAZ8mPFFy+FofMm7MXA7iosatUhIk=; b=YhH7M/nmtAjifJbYmBndvn
 omJdvYhisqniJaNBMDAWGVaSH0a+rsOsbEVV/7CVkbPPPEa9rjEHa+y3PPHQUsdi
 GoGsvQTSpxJ+yNsiNwJqoLgYjRoLdDaZNNN1u39Wrh+VFdHXOxvpMV0p2FFtE8ut
 ZaqGd6QlwtVtLYW1ylL7oHY80cf9ZXjQHyjteOCqyfFeNjWXxPUfLCB7rURL60QL
 NyEM1Obo2sPRS4zlOZ5cplfLNyjXbL2F0QmY+zPDfnVSuuAryyTl4lw73B2qc9zh
 g+UccDpWC3K2t3rrvLwkNJNIY5088ErTKQQHu4iHDs/tEDZNX20npkRPBIiVY5/w
 ==
X-ME-Sender: <xms:WXjYX3fdpxXJ8YSNybISgc0GBGBxSodmiGxScC4ptUBYShZwyQMmYw>
 <xme:WXjYX9NRHK2DAhFy4in9fkw6TycHtX2m45zUim0eQIOOeNU8odjY_kwQ3anJnWH2q
 yVkMt1GaIwH40g5_zI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekledguddviecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
 mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
 htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
 heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:WXjYXwjBdoZ8NLSK_XtDzWipTIm-TQsGSP4hkkyIFO0nOUDc8IDL7g>
 <xmx:WXjYX4_MQBpmuUJkJXgPr-PjFqzgYD8qBqsQ0EvBQdOLH78qqNaGtA>
 <xmx:WXjYXztXdzemIllbe0wdF5s4Ri5875dk-KSXtFYhpAaqzUrxuhsXYA>
 <xmx:WnjYXxIv7pnco1dkdFFLXrdr3ShKE36Z1m-LgWRLq8AXGuqc03qS2A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 3744924005D;
 Tue, 15 Dec 2020 03:48:25 -0500 (EST)
Date: Tue, 15 Dec 2020 09:48:23 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: Wolfram Sang <wsa@the-dreams.de>
Message-ID: <20201215084823.towbaqay5tgdh7dw@gilmour>
References: <20200107073629.325249-1-maxime@cerno.tech>
 <alpine.DEB.2.21.2001071106420.3004@hadrien>
 <20200107102954.GB1135@ninjato>
MIME-Version: 1.0
In-Reply-To: <20200107102954.GB1135@ninjato>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 15 Dec 2020 13:56:30 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 15 Dec 2020 09:48:30 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 15 Dec 2020 13:56:28 +0100
Cc: michal.lkml@markovi.net, Gilles.Muller@lip6.fr,
        Tomi Valkeinen <tomi.valkeinen@ti.com>, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>, Julia.Lawall@lip6.fr,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>, cocci@systeme.lip6.fr
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
Content-Type: multipart/mixed; boundary="===============1388844960=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


--===============1388844960==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5hw66wsxl6qicpm2"
Content-Disposition: inline


--5hw66wsxl6qicpm2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 07, 2020 at 11:29:54AM +0100, Wolfram Sang wrote:
> On Tue, Jan 07, 2020 at 11:06:56AM +0100, Julia Lawall wrote:
> >=20
> >=20
> > On Tue, 7 Jan 2020, Maxime Ripard wrote:
> >=20
> > > The ptr_ret script script addresses a number of situations where we e=
nd up
> > > testing an error pointer, and if it's an error returning it, or retur=
n 0
> > > otherwise to transform it into a PTR_ERR_OR_ZERO call.
> > >
> > > So it will convert a block like this:
> > >
> > > if (IS_ERR(err))
> > >     return PTR_ERR(err);
> > >
> > > return 0;
> > >
> > > into
> > >
> > > return PTR_ERR_OR_ZERO(err);
> > >
> > > While this is technically correct, it has a number of drawbacks. Firs=
t, it
> > > merges the error and success path, which will make it harder for a re=
viewer
> > > or reader to grasp.
> > >
> > > It's also more difficult to extend if we were to add some code betwee=
n the
> > > error check and the function return, making the author essentially re=
vert
> > > that patch before adding new lines, while it would have been a trivial
> > > addition otherwise for the rewiever.
> > >
> > > Therefore, since that script is only about cosmetic in the first plac=
e,
> > > let's remove it since it's not worth it.
> > >
> > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >=20
> > Acked-by: Julia Lawall <julia.lawall@inria.fr>
>=20
> Convincing patch description, good catch!
>=20
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

It looks like this patch was never applied, whose tree should it go
through?

Thanks!
Maxime

--5hw66wsxl6qicpm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9h4VwAKCRDj7w1vZxhR
xZ0BAQD1ZXa/ItFHIo5NWZRARYGbuSbkRWYbcCsQVw+HHg7aEQD/RquZR/W23qaA
8bVm4Koy2o1u3VAH53EEpY7lm2cs9wY=
=/ffb
-----END PGP SIGNATURE-----

--5hw66wsxl6qicpm2--

--===============1388844960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1388844960==--
