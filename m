Return-Path: <SRS0=3qPg=RP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE30BC43381
	for <cocci@archiver.kernel.org>; Tue, 12 Mar 2019 11:01:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206EC206DF
	for <cocci@archiver.kernel.org>; Tue, 12 Mar 2019 11:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206EC206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2CB1HOu007923
          ; Tue, 12 Mar 2019 12:01:17 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 71BF17719;
	Tue, 12 Mar 2019 12:01:17 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9E4807714
 for <cocci@systeme.lip6.fr>; Tue, 12 Mar 2019 12:01:16 +0100 (CET)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2CB1Fib018402
 for <cocci@systeme.lip6.fr>; Tue, 12 Mar 2019 12:01:15 +0100 (CET)
X-pt: isis.lip6.fr
X-Originating-IP: 90.88.150.179
Received: from localhost (aaubervilliers-681-1-31-179.w90-88.abo.wanadoo.fr
 [90.88.150.179]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 1676C2001E;
 Tue, 12 Mar 2019 11:01:14 +0000 (UTC)
Date: Tue, 12 Mar 2019 12:01:14 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <20190312110114.i4cdrtaznc4phacn@flea>
References: <20190312083143.sko2syivudpawqk7@flea>
 <alpine.DEB.2.21.1903120950170.2728@hadrien>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1903120950170.2728@hadrien>
User-Agent: NeoMutt/20180716
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 Mar 2019 12:01:18 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 12 Mar 2019 12:01:15 +0100 (CET)
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
Content-Type: multipart/mixed; boundary="===============0417305081=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


--===============0417305081==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c7j3oa7lydenz664"
Content-Disposition: inline


--c7j3oa7lydenz664
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Julia,

Thanks a lot for your answer,

On Tue, Mar 12, 2019 at 10:03:57AM +0100, Julia Lawall wrote:
> > @@
> > expression arg;
> > identifier fb;
> > @@
> > ...
> > struct drm_framebuffer *fb;
> > ...
> > - drm_format_num_planes(arg)
> > + fb->format->num_planes
> >
> > // This one seems to work in some cases, such as
> > // https://elixir.bootlin.com/linux/v5.0/source/drivers/gpu/drm/vc4/vc4=
_plane.c#L490
> > // But it also matches in cases where fb hasn't been properly assigned =
before, such as:
> > // https://elixir.bootlin.com/linux/v5.0/source/drivers/gpu/drm/tegra/f=
b.c#L142
>=20
> OK, it looks like what you want is:
>=20
> @@
> struct drm_framebuffer *fb;
> expression e.
> @@
>=20
> fb =3D e;
> <...
> - drm_format_num_planes(arg)
> + fb->format->num_planes
> ...>
>=20
> That is, you find an assignment of fb, and then anywhere after that you
> have a call, you can replace it.  This is <... ...> rather than <+...
> ...+> so that it can match several 0 or more occurrences.

It looks however that there's a difference between a variable
declaration and assignment, and only an assignment.

The snippet above doesn't match
https://elixir.bootlin.com/linux/v5.0/source/drivers/gpu/drm/vc4/vc4_plane.=
c#L490

Whereas using

@@
identifier fb;
expression arg;
expression e;
@@

  struct drm_framebuffer *fb =3D e;
  <...
- drm_format_num_planes(arg)
+ fb->format->num_planes
  ...>

Work for example. Is there a way to match both an assignment and a
declaration + assignment?

The following script covers all cases now:

@@
identifier fn;
identifier dev, cmd;
@@

fn (struct drm_device *dev,
    ...,
    struct drm_mode_fb_cmd2 *cmd,
    ...)
{
+ const struct drm_format_info *info =3D drm_get_format_info(dev, cmd);
  <+...
- drm_format_num_planes(cmd->pixel_format)
+ info->num_planes
  ...+>
}   =20

@@
struct drm_framebuffer *fb;
@@

- drm_format_num_planes(fb->format->format)
+ fb->format->num_planes

@@
identifier fb;
expression arg;
expression e;
@@

  struct drm_framebuffer *fb =3D e;
  <...
- drm_format_num_planes(arg)
+ fb->format->num_planes
  ...>

@@
struct drm_format_info *info;
@@

- drm_format_num_planes(info->format)
+ info->num_planes

@@
identifier val;
expression arg;
@@

{
+ const struct drm_format_info *info;
  <+...
- val =3D drm_format_num_planes(arg);
+ info =3D drm_format_info(arg);
+ val =3D info->num_planes;
  ...+>
}

@ rfunc @
identifier f =3D drm_format_num_planes;
identifier fourcc;
typedef uint32_t;
@@

- int f(uint32_t fourcc)
- {
- ...
- }

@@
identifier rfunc.f;
declarer name EXPORT_SYMBOL;
@@

- EXPORT_SYMBOL(f);

Thanks again!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--c7j3oa7lydenz664
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIeRegAKCRDj7w1vZxhR
xU7wAQCE5Pe+2PRBJoQiS5YJSXlJhhc5K8gxlP1DCdB6JUmdLQEA6B7RF96inSoy
curgdoa0W7HCfSXtW22QpZYwjipfuwY=
=iLJV
-----END PGP SIGNATURE-----

--c7j3oa7lydenz664--

--===============0417305081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0417305081==--
