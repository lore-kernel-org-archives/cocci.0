Return-Path: <SRS0=D53n=GQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FF1C433E0
	for <cocci@archiver.kernel.org>; Wed, 13 Jan 2021 09:49:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A160F233F6
	for <cocci@archiver.kernel.org>; Wed, 13 Jan 2021 09:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A160F233F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10D9mjIw013412;
	Wed, 13 Jan 2021 10:48:45 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5E95874B6;
	Wed, 13 Jan 2021 10:48:45 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DACA07B6
 for <cocci@systeme.lip6.fr>; Wed, 13 Jan 2021 10:48:43 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10D9mgHr028055
 for <cocci@systeme.lip6.fr>; Wed, 13 Jan 2021 10:48:43 +0100 (CET)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id E126E5C01C4
 for <cocci@systeme.lip6.fr>; Wed, 13 Jan 2021 04:48:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 13 Jan 2021 04:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:subject:message-id:mime-version:content-type; s=
 fm1; bh=IkkAcK15M9Mk+CGcwQmHaeD1oIH2R2DnVMImi3Zjjlw=; b=GkviCF9O
 RTPb56ydMppV78EdwNxlCneviEUOHYH3pQm6Qd5s/5oYxDXEgLjj79E1homjMMPz
 np73ZOW7Xs7un4HPdxr89ilwPeHqxQApgQ4NymI1G/oGe/wkP/k4nsChPYSjsDej
 pmhQZOQmFFpvih1tCE5AeIrbpNMnGZr5bmLZkne2M3uKl9/L9khtjMP4jgwi9XRv
 5yHpbC7KHnM6amHrOpbaygflBNY10eGxqTPb3GRVcXb6aswDa8bzWAUCA9sXtlyr
 BhR9h1wvLXpY0ew1TCg3cvojvdtNqn7WYCxQwKUAsfQflu8CxI+teQbRtxF3LQKM
 1QxvBhRSRs4IIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=content-type:date:from:message-id
 :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; bh=IkkAcK15M9Mk+CGcwQmHaeD1oIH2R
 2DnVMImi3Zjjlw=; b=W/u758yrnaA5vWWpfPagx8bBftaGYPwOaFIKggs9UpUB4
 UOT9U+lFShvbA9soCX7g/+ejLriNw1qpXx/qf67aS486M0xCeEbUCoUj+6C0+iXv
 Q7ZPa2W9dOJ9im6zZuVsELEO8ZH2jsypMSgJYPXJTBbTjejwx5RYYS+ClJF5e3pc
 4k2tkOBdtiv6ezKqBLpUDiLbhwtioskiMgP0xpbFZR9kqR/AY/MCYd3WqRug3dhR
 piDCChNwog5NkIWJpU9dfwHSXUoaY5wx+SbHmDhHVK5TCBGtgJZokZv5JfdjiW3S
 eddVxgmW8U7uThOid8BCzGSDDkU8GCepizgqsL2aA==
X-ME-Sender: <xms:-MH-X7t2V_KWezCuMYgwr_IowRszGKR-kVxOryDXKOxURVbHWPlFdw>
 <xme:-MH-X8erQ6p43DaWw8OABDk8HK9Pko0qKAVLNbTj9wXDH9NvKpwuAJByKb_gYM3Nc
 -YdDWekjj8uLG__h_0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdefgddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
 dvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhho
 rdhtvggthheqnecuggftrfgrthhtvghrnhepgeehvddvffelveeiuefggfeiueduvdfhfe
 euhffgleejleeghfdvgedtveegleeknecukfhppeeltddrkeelrdeikedrjeeinecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvse
 gtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:-MH-X-xF-S-SJpsDop8_JFbPqiRoY264IUHpPezwg_7Ur0lFXLZccQ>
 <xmx:-MH-X6M5aMS68l9vvqlT52etG1l8DJ34sf_oYGbMxiZ2R39RrPes1Q>
 <xmx:-MH-X7_AsPxx9NRcFjlFPuWUTdzIeiKrlmcQ9dB9bvgXb_eN3UZWZQ>
 <xmx:-MH-X-LdW2qgHFM9CLVkvTT8FtAQrOd9DRCgo7Raa_PMESntzcKAFg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 47299240057
 for <cocci@systeme.lip6.fr>; Wed, 13 Jan 2021 04:48:40 -0500 (EST)
Date: Wed, 13 Jan 2021 10:48:39 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: cocci@systeme.lip6.fr
Message-ID: <20210113094839.n5uym2ymhhnykzzt@gilmour>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 13 Jan 2021 10:48:46 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 13 Jan 2021 10:48:43 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Performance issue with quite simple patch?
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
Content-Type: multipart/mixed; boundary="===============0942566740=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


--===============0942566740==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gycikrzsyuh3oc5a"
Content-Disposition: inline


--gycikrzsyuh3oc5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I've been trying to get a patch to rename any variable called "state" in
a given set of callbacks.

This is the patch that I've come up with:

@ plane_atomic_func @
identifier helpers;
identifier func;
@@

(
 static const struct drm_plane_helper_funcs helpers = {
 	...,
 	.atomic_check = func,
	...,
 };
|
 static const struct drm_plane_helper_funcs helpers = {
 	...,
 	.atomic_disable = func,
	...,
 };
|
 static const struct drm_plane_helper_funcs helpers = {
 	...,
 	.atomic_update = func,
	...,
 };
)

@@
identifier plane_atomic_func.func;
symbol state;
expression e;
type T;
@@

 func(...)
 {
 	...
-	T state = e;
+	T plane_state = e;
 	<+...
-	state
+	plane_state
 	...+>
 }

However, it seems like at least on a file (in Linux,
drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c), it takes quite big
performance hit with one CPU running at 100% until the timeout is hit.

Replacing <+... by ... makes it work instantly, but doesn't really do
what I'm expecting, so I guess it's a matter of the patch being
subobtimal?

Is there a more optimal way of doing it?

Thanks!
Maxime

--gycikrzsyuh3oc5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX/7B9wAKCRDj7w1vZxhR
xaU7AQDMyXQ0RQLQa0kjj70mPV/Duv6JFfoQGQMBe/WoW3omowD+I6Xd+63TRc26
UaaaobKSpHx1230TYFabU0uitpq52wQ=
=iBbi
-----END PGP SIGNATURE-----

--gycikrzsyuh3oc5a--

--===============0942566740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0942566740==--
