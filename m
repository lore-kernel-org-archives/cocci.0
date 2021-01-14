Return-Path: <SRS0=JC9F=GR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AB9C433DB
	for <cocci@archiver.kernel.org>; Thu, 14 Jan 2021 13:25:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DBFA23A58
	for <cocci@archiver.kernel.org>; Thu, 14 Jan 2021 13:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBFA23A58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10EDP3gZ010422;
	Thu, 14 Jan 2021 14:25:03 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B1F437539;
	Thu, 14 Jan 2021 14:25:03 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9093C37BB
 for <cocci@systeme.lip6.fr>; Thu, 14 Jan 2021 14:25:01 +0100 (CET)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10EDP031007107
 for <cocci@systeme.lip6.fr>; Thu, 14 Jan 2021 14:25:00 +0100 (CET)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 14EA415F5;
 Thu, 14 Jan 2021 08:24:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 14 Jan 2021 08:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=V8k7Cn0TsF3tH2xLXFrK7dCtsvA
 8MAFGDnQ20uWptTw=; b=KOzwBNUMgy1lipVPrgbPYtzRCt+YHw1BWGeChAkicTJ
 GRo+QmsIJXqmK9NpE35mmqztuyO6B3wPP2LRW1UBLkRIxbyOwhto0c7KRnY87LIg
 K42XEfs/PeCAf5I0TaZi8qo6U+0LMwkRYRO5SBasKLC479QyTV0w9orxB5s2pCbB
 cexQixJjcO06D3mp3EFT+yXVIV3G1+LbXpUxyfaL0sBnjhQ+3VLEFxNJVZOKjRpT
 19F2SEOT5N20X8mdhrObVRgt9+euvMb1NQIAKX/vjVUhfpVfBMMiBfq16+dDcMjn
 A1kYziBSVLuLsF1CKvJFW8/nYGDSWFsZ5OkjEivbHJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=V8k7Cn
 0TsF3tH2xLXFrK7dCtsvA8MAFGDnQ20uWptTw=; b=fM3zisYer6H4DsbG45whJw
 mw+rMtaOsuqnOww4RVAxH07ApJVQp9DlJb2+xRLiLgp7KqEaQEFJhurH0g5tSnXX
 x3ux9aIbiVqg31J63Cy9+b8tQ+ORAE6THyNSB4Goh+I5NJs0sJxO0nTAqrv05MAK
 N1SFLF03leVOzyfCVGTxX3x1qS2Zzwumd+9ZSW32sRVQuTKAQtfzvRQ0yB57BYu8
 y1c1dLiJAG1ETayibXUU33GMwwbEossMqLwMyO6CtFenymMBE0x9kTh4AiMeGdYL
 thfVIAkYm/uSnRE8T+bEBT8iguI/EqJR9ODpy6zrnD+5Xz9bdXVkdb4+swE8IS2Q
 ==
X-ME-Sender: <xms:KEYAYGpCt4Y8JlKc5t0i_fThgtdCjMcE9Xj04stoiz1t65onJWO_og>
 <xme:KEYAYEkE4I88I8jOkeeqtEKp2iFFUsXZeQ1SimEt392jDW_pBkQM5mHu_BnY9JXoc
 YoIiorNo-D1g9eiUdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddtgddvhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
 udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:KEYAYIFerGgCUV1ObSlJ9VobVJO1dwm_so9fBlTGpj4LxMCWH-1wUw>
 <xmx:KEYAYNoP4yxtJfR5AAmIba-3E015FDtEBpi0lKUB1QctFSxNnSYZ9A>
 <xmx:KEYAYE6l4tQ3NMP9JZfXuz3QBgi8kS9aVyPPAg0USWEWt_aadK91NA>
 <xmx:KEYAYDwCvIU4ondh5ORH_cEd_3jc5n2Hf6ycSQ19Gu8R8ZGPWhaRtA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 06FFB240057;
 Thu, 14 Jan 2021 08:24:55 -0500 (EST)
Date: Thu, 14 Jan 2021 14:24:53 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <20210114132453.trvqsjhx4j6gqbmj@gilmour>
References: <20210113094839.n5uym2ymhhnykzzt@gilmour>
 <alpine.DEB.2.22.394.2101131152470.2930@hadrien>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2101131152470.2930@hadrien>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 14 Jan 2021 14:25:04 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 14 Jan 2021 14:25:00 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Performance issue with quite simple patch?
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
Content-Type: multipart/mixed; boundary="===============0509986727=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


--===============0509986727==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="irposs5ctqnz2a2e"
Content-Disposition: inline


--irposs5ctqnz2a2e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Julia,

On Wed, Jan 13, 2021 at 11:58:41AM +0100, Julia Lawall wrote:
> On Wed, 13 Jan 2021, Maxime Ripard wrote:
>=20
> > Hi!
> >
> > I've been trying to get a patch to rename any variable called "state" in
> > a given set of callbacks.
> >
> > This is the patch that I've come up with:
> >
> > @ plane_atomic_func @
> > identifier helpers;
> > identifier func;
> > @@
> >
> > (
> >  static const struct drm_plane_helper_funcs helpers =3D {
> >  	...,
> >  	.atomic_check =3D func,
> > 	...,
> >  };
> > |
> >  static const struct drm_plane_helper_funcs helpers =3D {
> >  	...,
> >  	.atomic_disable =3D func,
> > 	...,
> >  };
> > |
> >  static const struct drm_plane_helper_funcs helpers =3D {
> >  	...,
> >  	.atomic_update =3D func,
> > 	...,
> >  };
> > )
>=20
> You don't need the ...s in the above.  For structure declarations
> Coccinelle is happy as long as what you specify is a subset of what is
> present.  The static and const aren't essential either.  If you remove
> them, the pattern will match whethe thy are present or not.

Oh, that's good to know, thanks!

> >
> > @@
> > identifier plane_atomic_func.func;
> > symbol state;
> > expression e;
> > type T;
> > @@
> >
> >  func(...)
> >  {
> >  	...
> > -	T state =3D e;
> > +	T plane_state =3D e;
> >  	<+...
> > -	state
> > +	plane_state
> >  	...+>
> >  }
> >
> > However, it seems like at least on a file (in Linux,
> > drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c), it takes quite big
> > performance hit with one CPU running at 100% until the timeout is hit.
> >
> > Replacing <+... by ... makes it work instantly, but doesn't really do
> > what I'm expecting, so I guess it's a matter of the patch being
> > subobtimal?
> >
> > Is there a more optimal way of doing it?
>=20
> In your rule, I donkt think that there is really any essential connection
> between the declaration and the use?  You just want to change state to
> plane_state when it occurs in one of the functions that you detected.

I'm sorry, I forgot to mention that I only want the change to occur if
it's a variable declared in the function, not an argument to it

> So you could at least try the following and see if it gives any false pos=
itives:
>
> @@
> identifier plane_atomic_func.func;
> symbol state;
> expression e;
> type T;
> @@
>=20
>  func(...)
>  {
>       <...
> (
> -     T state =3D e;
> +     T plane_state =3D e;
> |
> -     state
> +     plane_state
> )
>       ...>
>  }

I would never have thought of that, thanks :)

I tried to adjust it to match only on functions that have such a
variable defined:

@ plane_atomic_func @
identifier helpers;
identifier func;
@@

 struct drm_plane_helper_funcs helpers =3D {
 	.atomic_check =3D func,
 };

@ has_variable_state @
identifier plane_atomic_func.func;
symbol state;
expression e;
type T;
@@

 func(...)
 {
 	...
	T state =3D e;
 	...
 }

@ depends on has_variable_state @
identifier plane_atomic_func.func;
symbol state;
expression e;
type T;
@@

 func(...)
 {
 	<...
(
-	T state =3D e;
+	T plane_state =3D e;
|
-	state
+	plane_state
)
 	...>
 }

But it's still choking on that same file
(drivers/gpu/drm//atmel-hlcdc/atmel_hlcdc_plane.c). Every other file
that matches takes at most a few seconds though, so it seems a bit weird

Maxime

--irposs5ctqnz2a2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYABGJQAKCRDj7w1vZxhR
xbQKAP4rY9v+q/xNG9Nnk9ts5mLbUG2TExTKinwJd2tZ076s/QEAnlCdCfWAfNRX
S1fjEQZx8BqJlNiiiRafprfQHN4m8Qc=
=mt7K
-----END PGP SIGNATURE-----

--irposs5ctqnz2a2e--

--===============0509986727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0509986727==--
