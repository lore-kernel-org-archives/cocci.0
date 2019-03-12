Return-Path: <SRS0=3qPg=RP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9135C43381
	for <cocci@archiver.kernel.org>; Tue, 12 Mar 2019 08:32:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD2E214AF
	for <cocci@archiver.kernel.org>; Tue, 12 Mar 2019 08:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD2E214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2C8VlXk011932
          ; Tue, 12 Mar 2019 09:31:47 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EE3337719;
	Tue, 12 Mar 2019 09:31:46 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3AFA37714
 for <cocci@systeme.lip6.fr>; Tue, 12 Mar 2019 09:31:45 +0100 (CET)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2C8ViEV025850
 for <cocci@systeme.lip6.fr>; Tue, 12 Mar 2019 09:31:44 +0100 (CET)
X-pt: isis.lip6.fr
X-Originating-IP: 90.88.150.179
Received: from localhost (aaubervilliers-681-1-31-179.w90-88.abo.wanadoo.fr
 [90.88.150.179]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E4FA620010
 for <cocci@systeme.lip6.fr>; Tue, 12 Mar 2019 08:31:43 +0000 (UTC)
Date: Tue, 12 Mar 2019 09:31:43 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: cocci@systeme.lip6.fr
Message-ID: <20190312083143.sko2syivudpawqk7@flea>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 Mar 2019 09:31:48 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 12 Mar 2019 09:31:44 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Substitution of function call to structure parameter
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
Content-Type: multipart/mixed; boundary="===============0385751388=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


--===============0385751388==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3ohcm2e32qk5jt3k"
Content-Disposition: inline


--3ohcm2e32qk5jt3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to do an API rework of DRM, and that rewrite involves
patching a number of drivers to use a structure field instead of a
funtion call.

There's a bunch of cases that need to be covered, and I can't get all
of them to work.

So far, my current script is, with the current shortcomings as comment
below each rule.

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
=2E..
- drm_format_num_planes(cmd->pixel_format)
+ info->num_planes
=2E..
}

// This on works on most cases, ie:
// https://elixir.bootlin.com/linux/v5.0/source/drivers/gpu/drm/armada/arma=
da_fb.c#L87
// However, for some reason unknown to me, it doesn't match:
// https://elixir.bootlin.com/linux/v5.0/source/drivers/gpu/drm/tegra/fb.c#=
L129

@@
identifier fb;
@@
=2E..
struct drm_framebuffer *fb;
=2E..
- drm_format_num_planes(fb->format->format)
+ fb->format->num_planes

// This one seems to work properly

@@
expression arg;
identifier fb;
@@
=2E..
struct drm_framebuffer *fb;
=2E..
- drm_format_num_planes(arg)
+ fb->format->num_planes

// This one seems to work in some cases, such as
// https://elixir.bootlin.com/linux/v5.0/source/drivers/gpu/drm/vc4/vc4_pla=
ne.c#L490
// But it also matches in cases where fb hasn't been properly assigned befo=
re, such as:
// https://elixir.bootlin.com/linux/v5.0/source/drivers/gpu/drm/tegra/fb.c#=
L142

@@
identifier info;
@@
=2E..
struct drm_format_info *info;
=2E..
- drm_format_num_planes(info->format)
+ info->num_planes

// This one seems to work too

I'm pretty new to coccinelle, so I'm not quite sure how to fix these
errors properly, even though that looks pretty simple.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3ohcm2e32qk5jt3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIdubwAKCRDj7w1vZxhR
xRflAQCUpWV+EyW5zMMnoR1kV4AMIw5QMDHwwUe4Si4rTmzBFAD/SjwqKbh7EMYM
SNNDc1WuhkxhbkonacnME9ytHTqTeQ4=
=ptQ/
-----END PGP SIGNATURE-----

--3ohcm2e32qk5jt3k--

--===============0385751388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0385751388==--
