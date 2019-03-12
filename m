Return-Path: <SRS0=3qPg=RP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1968AC43381
	for <cocci@archiver.kernel.org>; Tue, 12 Mar 2019 13:53:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B022A2147C
	for <cocci@archiver.kernel.org>; Tue, 12 Mar 2019 13:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B022A2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2CDr0CG004435
          ; Tue, 12 Mar 2019 14:53:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7E9277719;
	Tue, 12 Mar 2019 14:53:00 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8BD647714
 for <cocci@systeme.lip6.fr>; Tue, 12 Mar 2019 14:52:59 +0100 (CET)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2CDqvB7006501
 for <cocci@systeme.lip6.fr>; Tue, 12 Mar 2019 14:52:57 +0100 (CET)
X-pt: isis.lip6.fr
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr
 [90.88.22.102]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 91830C0008;
 Tue, 12 Mar 2019 13:52:57 +0000 (UTC)
Date: Tue, 12 Mar 2019 14:52:57 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <20190312135257.covmumxsrezrehka@flea>
References: <20190312083143.sko2syivudpawqk7@flea>
 <alpine.DEB.2.21.1903120950170.2728@hadrien>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1903120950170.2728@hadrien>
User-Agent: NeoMutt/20180716
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 Mar 2019 14:53:00 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 12 Mar 2019 14:52:57 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Substitution of function call to structure parameter
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
Content-Type: multipart/mixed; boundary="===============1522589738=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


--===============1522589738==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4r6bmarbh23u2jvs"
Content-Disposition: inline


--4r6bmarbh23u2jvs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 10:03:57AM +0100, Julia Lawall wrote:
> >
> > @@
> > identifier fb;
> > @@
> > ...
> > struct drm_framebuffer *fb;
> > ...
> > - drm_format_num_planes(fb->format->format)
> > + fb->format->num_planes
> >
> > // This one seems to work properly
>=20
> How about:
>=20
> @@
> struct drm_framebuffer *fb;
> @@
>=20
> - drm_format_num_planes(fb->format->format)
> + fb->format->num_planes
>=20
> That is, you don't need to insist on there being a local variable
> declaration, you just want an expression of the right type.  This will
> also be much more efficient.

I have an extra question on that one. Are function parameters also
considered expressions with that syntax?

Let's say for example, I want to replace the call to drm_format_info
by drm_get_format_info in that function:
https://elixir.bootlin.com/linux/v5.0/source/drivers/gpu/drm/omapdrm/omap_f=
b.c#L340

That snippet doesn't work:
@@
struct drm_device *dev;
struct drm_mode_fb_cmd2 *cmd;
@@

- drm_format_info(cmd->pixel_format)
+ drm_get_format_info(dev, cmd)

with spatch producing the following warnings and errors:

warning: rule starting on line 1: metavariable dev not used in the - or con=
text code
error: rule starting on line 1: dev appears only in + code

Does that mean I have to explicitly have the function prototype as
context?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4r6bmarbh23u2jvs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIe5uQAKCRDj7w1vZxhR
xXGhAP9WNfByYiV8KX24+PXunW0WCRRdx4Z++CBHYpUIfgc3MgD/Z+hwNXj3QC7a
iuhbltAY+Qb2/eX5v/xch9fEFGirzw8=
=pAil
-----END PGP SIGNATURE-----

--4r6bmarbh23u2jvs--

--===============1522589738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1522589738==--
