Return-Path: <SRS0=J+fH=FT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C412BC4361B
	for <cocci@archiver.kernel.org>; Tue, 15 Dec 2020 12:56:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D1D2246B
	for <cocci@archiver.kernel.org>; Tue, 15 Dec 2020 12:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D1D2246B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BFCuVnM015129;
	Tue, 15 Dec 2020 13:56:31 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id ED22377A4;
	Tue, 15 Dec 2020 13:56:30 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EA8283A53
 for <cocci@systeme.lip6.fr>; Tue, 15 Dec 2020 13:25:33 +0100 (CET)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BFCPWVT002642
 for <cocci@systeme.lip6.fr>; Tue, 15 Dec 2020 13:25:33 +0100 (CET)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.west.internal (Postfix) with ESMTP id B0ED2776;
 Tue, 15 Dec 2020 07:25:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 15 Dec 2020 07:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=Lbs/pZx5+qBrDLnzX3CWHVYvMex
 qit5xS8jqaq5OH9U=; b=QWHd7RmXkL+WNk4fHPT9BGI3Ammq9BX97bm4KA/eOqz
 pJQWWjTay/q7wfGMYq7M8v+XCewaIT40SBv+32FFt7nl2IWmcovRrS3BsIGHrX+f
 ak1CIOY/JAk2tFzaKfeZ3NOo/YWK1s/FoHEj997YOPkRzAG2FN3r/tK465SjS/Ib
 Yt/mce+zMFTiPaRMpOkQgvNi2IvCuUhBnZ5W0Da4xHe6u8bEcv1DsF56I2E3McKz
 /LuMJ0EkZw0pBSd0jtALbpcQvnc/5hyI9SxYFQj9kiHT0w4cnc814q2jJg5hFnFr
 V90mZWFIPzySx6FXZyD6X4Q6mH8HypWfQXWYkTk2MDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Lbs/pZ
 x5+qBrDLnzX3CWHVYvMexqit5xS8jqaq5OH9U=; b=aLH/ArrmHm70UogR/g/LKL
 K665tvYCoVNvMqm/cshALLFff3/eLzcaEcTDLblmmKq+n0vy+jZTCu/G4A7yD+up
 J+HtgjGLzvahRjRQip8DaSUCGcDGeLJrKGG3c36f7gHpSCZhp/2bsUCbo86+7r9u
 ENwIYHZgPUGXbC7z5Da54+XEIDBz9be3jZZJNqYqoMYLvtRkBA/90bPXYMMC3HCx
 hcJsaPzJWl1K0xlc5Dj8LvRnygFCYnd/OcVzDfbpc6/C/Iws5cFidr+ccpGAfnwr
 dZcm3z1/6A63/J+buiCoM7Qd/5Y49rbm2vSboSxkhGtMr7lz5Skxtk6/ZVSAUZqw
 ==
X-ME-Sender: <xms:OqvYX3-JDfj00tdT1o0M4STf1NoVmEF2164j9Oxm9vIaqUNKRSOwnw>
 <xme:OqvYXzvBVfJDntZMB1pQwkX8MKYXOre6GtZqO9VqGm2UyGdjHBf85E6_DsU539Fse
 j1KQOggTNba1RfQkQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeltddggedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
 htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
 gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:OqvYX1Cg4n1RxgwTuYq29QiUdTWKuk9w44UxBCIzHirhtyBB9og-5A>
 <xmx:OqvYXzeOKaR_aPsHjBaGZb95jRYv8-UmwrVpqb8Xk0UdEtB-jHn3DA>
 <xmx:OqvYX8O7bkSS__k3VFZqyfgiJttMnd3MsePNAk0gFN_kfjYRMqgmgg>
 <xmx:O6vYX7qqqi_DTj_Wi4iRNZJjOxzaf_SWHjAujANkpZQbMmQYagm8ZEiWaT0>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 7C4AB24005A;
 Tue, 15 Dec 2020 07:25:30 -0500 (EST)
Date: Tue, 15 Dec 2020 13:25:28 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <20201215122528.tvkess3nav3uc4uy@gilmour>
References: <20200107073629.325249-1-maxime@cerno.tech>
 <alpine.DEB.2.21.2001071106420.3004@hadrien>
 <20200107102954.GB1135@ninjato>
 <20201215084823.towbaqay5tgdh7dw@gilmour>
 <alpine.DEB.2.22.394.2012150950440.2879@hadrien>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2012150950440.2879@hadrien>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 15 Dec 2020 13:56:31 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 15 Dec 2020 13:25:33 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 15 Dec 2020 13:56:29 +0100
Cc: michal.lkml@markovi.net, Gilles.Muller@lip6.fr,
        Tomi Valkeinen <tomi.valkeinen@ti.com>, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>,
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
Content-Type: multipart/mixed; boundary="===============0235594616=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


--===============0235594616==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5lcstcw72h33y6eo"
Content-Disposition: inline


--5lcstcw72h33y6eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 15, 2020 at 09:52:36AM +0100, Julia Lawall wrote:
>=20
>=20
> On Tue, 15 Dec 2020, Maxime Ripard wrote:
>=20
> > Hi,
> >
> > On Tue, Jan 07, 2020 at 11:29:54AM +0100, Wolfram Sang wrote:
> > > On Tue, Jan 07, 2020 at 11:06:56AM +0100, Julia Lawall wrote:
> > > >
> > > >
> > > > On Tue, 7 Jan 2020, Maxime Ripard wrote:
> > > >
> > > > > The ptr_ret script script addresses a number of situations where =
we end up
> > > > > testing an error pointer, and if it's an error returning it, or r=
eturn 0
> > > > > otherwise to transform it into a PTR_ERR_OR_ZERO call.
> > > > >
> > > > > So it will convert a block like this:
> > > > >
> > > > > if (IS_ERR(err))
> > > > >     return PTR_ERR(err);
> > > > >
> > > > > return 0;
> > > > >
> > > > > into
> > > > >
> > > > > return PTR_ERR_OR_ZERO(err);
> > > > >
> > > > > While this is technically correct, it has a number of drawbacks. =
First, it
> > > > > merges the error and success path, which will make it harder for =
a reviewer
> > > > > or reader to grasp.
> > > > >
> > > > > It's also more difficult to extend if we were to add some code be=
tween the
> > > > > error check and the function return, making the author essentiall=
y revert
> > > > > that patch before adding new lines, while it would have been a tr=
ivial
> > > > > addition otherwise for the rewiever.
> > > > >
> > > > > Therefore, since that script is only about cosmetic in the first =
place,
> > > > > let's remove it since it's not worth it.
> > > > >
> > > > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > > > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > > > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > > > Cc: Mark Brown <broonie@kernel.org>
> > > > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > > >
> > > > Acked-by: Julia Lawall <julia.lawall@inria.fr>
> > >
> > > Convincing patch description, good catch!
> > >
> > > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > It looks like this patch was never applied, whose tree should it go
> > through?
>=20
> Sorry.  I can take it.  I'm not sure that I still have the original
> message, though.  If you have it handy, that would be helpful.

Sure, I just sent a new version with all the tags

Thanks!
Maxime

--5lcstcw72h33y6eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9irOAAKCRDj7w1vZxhR
xdyZAQDzVBVndsiZlVl3kpwfpz/3+6pNB1QKT7x6IGkV57YMrgD7B53xu+cJtvNE
4AYbaLHVlIe4o746cPMHUAdOZviNxgY=
=xT3J
-----END PGP SIGNATURE-----

--5lcstcw72h33y6eo--

--===============0235594616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0235594616==--
