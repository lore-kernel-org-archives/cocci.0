Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA95CC02190
	for <cocci@archiver.kernel.org>; Thu, 30 Jan 2025 14:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=dc6bg9irmqSN+d8dDQWJrkjJqHxAt7oNbB3mYj00f2Q=;
  b=viXpWYdE+CffAmI03ge0bzdj8/XGnjPB4hP2F+Br4U/dJSkSZnKm7Xkg
   O+N9+QQczpuWlDzmofmtL0X3E36aTpk9w3g2I6BlidhCssKEe0yVRqtvv
   8FK/HAoR78TKHfnrZcw6yvrQh4gGvfvc6sMRqVdmLMnzSZ9yaU7Cikt4Z
   c=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
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
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.13,245,1732575600"; 
   d="asc'?scan'208";a="205802664"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2025 15:59:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4F54DE0D1E; Thu, 30 Jan 2025 15:59:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 17341E0260
	for <cocci@sympa.inria.fr>; Thu, 30 Jan 2025 15:59:16 +0100 (CET)
IronPort-SDR: 679b93c3_QVPxL8TY+aSju4IWAzktRRmbhIrQWfeC6lYcTR08HCNR/2n
 DPFa2oCtqjYyije+n83KahlJq1t214pRkHBHamg==
X-IPAS-Result: =?us-ascii?q?A0HRAgCJkptnj1vBS5NaHgEBCxIMQIQXgVczBAtIjVKGU?=
 =?us-ascii?q?4IhA5JqjSsIBwEDAQgFRAQBAQMEhQACinUCHgcBBDQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBARABAQUBAQECAQECBAYBAhABAQEBAQE5BUmFew2CYgGBJIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQINfQEBAQECAScZAQE3AQQLCxguVgYbgnoBgkEjA7cIeIEBM4EBg?=
 =?us-ascii?q?gwBAQbcH4FeBwmBSIFYhmsLAYFaiA56JxuBSUSCUIE+MT6LB4IzSoEpg0CJc?=
 =?us-ascii?q?4h3jm1SgRcDWSwBSwo1DDkoSEgDgTSBJgU1e4INgTI3Ag0CgkBwHzGEG4I9h?=
 =?us-ascii?q?EWDO4EWgWmDdIIUgWUDAxYQAYMneByCVB1AA3g9NxQbmjgce4Mzg38GWjUBG?=
 =?us-ascii?q?zCBXRJokkCQLaMjhCWhXUkDly6TD5h8o1uFUoF+I4FcMxoIKAiDIk8DGQ+OI?=
 =?us-ascii?q?QwNCYhrwxtCNTwCBwsBAQMJkAOBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Qr+p3p9b7FbWPUIaNW+WjkmSoS7PPws
IronPort-HdrOrdr: A9a23:BR3jp6o0gNLiZPh86txr3SIaV5okeYIsimQD101hICG9vPb4qy
 mLpoV96faUskd0ZJhEo7290ca7LU80maQb3WBVB8bFYOCEghrMEGgB1/qA/9SIIUSXnYRgPO
 VbAspD4bbLbWSS4/yV3DWF
X-Talos-CUID: 9a23:PYxIRmF2Aja3dKMRqmI+xWxTMe8qUkfZ3XHoOQyUEHpkZLyaHAo=
X-Talos-MUID: 9a23:DFiHkwqfGa2/fNu6O9MezxY6aMhyxar/MmUumL4ZofWEGXYzIg7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,245,1732575600"; 
   d="asc'?scan'208";a="205802652"
X-MGA-submission: =?us-ascii?q?MDGe8Wag1DFcKu2i3TcBgRvnmZe7npWwLLZHxR?=
 =?us-ascii?q?YzG5BQugey3r7o8Ycp5AS/FFWX464OWLhZ2F5+Mm9OlCPjEZAg3lus1l?=
 =?us-ascii?q?tgXI1KO6RSlo1ANAS/Nk+RxBml9vH6JO64we7VnKq4NYksFgLzP0anyy?=
 =?us-ascii?q?phZ93QOZ74+rqVq2OQl9YCNA=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 15:59:15 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 75FABA41DA0;
	Thu, 30 Jan 2025 14:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AA8C4CED2;
	Thu, 30 Jan 2025 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738249153;
	bh=l3zkY/ReQhqHmPYfmjaBWdjqYshdAF3oucDpP6+R+98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzxOkI2x+BEPWbx3iLwxo+Zz7Cfbwr/p7my+XMZ5Jztgx3yuWfpOSe7M5rUKiz0r1
	 XR1fZWpNSg6A2dyJ7gKMSAA+zCw8AADZOzIYBbYknttclx9NXU3lJQoKHgBsn5tzCu
	 WXyYHdDBrdEWp5X+BlbubUIm04KeATn9x2dbzMZ5Zb5OlU/YaoQyjKNMtpIRiojGCn
	 5dxMGXtgOcAwhVEZS/7n9gTgSXYqpcHjcDwz5gwCDRfuWLwq30PYowAp7HRKaWfcsu
	 xjUOC2qu2woJNG05eb7AfjX4ZknScetnT9FwHMGlEFLmjr1Ty16E1fyTNvtj5AXArx
	 D6M1i+T7EwWhw==
Date: Thu, 30 Jan 2025 15:59:10 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <3su6bfoiyc2t4gmouitdogr2xo4v6nvpf6j2jzpg2uvwgngtrr@h3naxtnwhyqk>
References: <dmpq6u4xhcmog2ugsrggn7lts7w4iiczmy3pzomjqchzbtey3g@s5d2afdhbsa7>
 <2f86f8-3345-7be0-71e3-47e3ba1c754@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="rkzm3jcmhcvnzcuz"
Content-Disposition: inline
In-Reply-To: <2f86f8-3345-7be0-71e3-47e3ba1c754@inria.fr>
Subject: Re: [cocci] Help to match variables with different names
Reply-To: Maxime Ripard <mripard@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2320
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/3su6bfoiyc2t4gmouitdogr2xo4v6nvpf6j2jzpg2uvwgngtrr%40h3naxtnwhyqk>


--rkzm3jcmhcvnzcuz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Help to match variables with different names
MIME-Version: 1.0

Hi Julia,

Thanks for your answer

On Thu, Jan 30, 2025 at 09:33:44AM -0500, Julia Lawall wrote:
> On Thu, 30 Jan 2025, Maxime Ripard wrote:
> > I've been trying to make a coccinelle script for some API change in DRM.
> >
> > Two good examples for what I'm struggling with are drivers/gpu/drm/brid=
ge/panel.c and
> > drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> >
> > I want to make a script that will modify the
> > drm_bridge_funcs.atomic_enable prototype to take a drm_atomic_state
> > pointer instead of the drm_bridge_state one.
> >
> > Both of these files use an indirection to retrieve the drm_atomic_state
> > pointer from the drm_bridge_state one. Since the drm_atomic_one is going
> > to be a parameter, I need to remove the assignment, and set the
> > parameter name to whatever was used in the function before.
> >
> > Basically, I'd like the following diff:
> >
> > diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c b/drivers/gpu=
/drm/bridge/imx/imx8mp-hdmi-pvi.c
> > index 0d1ac3edcab4..e41bc58fbeb6 100644
> > --- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> > +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> > @@ -47,13 +47,12 @@ static int imx8mp_hdmi_pvi_bridge_attach(struct drm=
_bridge *bridge,
> >  	return drm_bridge_attach(bridge->encoder, pvi->next_bridge,
> >  				 bridge, flags);
> >  }
> >
> >  static void imx8mp_hdmi_pvi_bridge_enable(struct drm_bridge *bridge,
> > -					  struct drm_bridge_state *bridge_state)
> > +					  struct drm_atomic_state *state)
> >  {
> > -	struct drm_atomic_state *state =3D bridge_state->base.state;
> >  	struct imx8mp_hdmi_pvi *pvi =3D to_imx8mp_hdmi_pvi(bridge);
> >  	struct drm_connector_state *conn_state;
> >  	const struct drm_display_mode *mode;
> >  	struct drm_crtc_state *crtc_state;
> >  	struct drm_connector *connector;
> > diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/pa=
nel.c
> > index 6e88339dec0f..b84dcf1b709b 100644
> > --- a/drivers/gpu/drm/bridge/panel.c
> > +++ b/drivers/gpu/drm/bridge/panel.c
> > @@ -127,14 +127,13 @@ static void panel_bridge_atomic_pre_enable(struct=
 drm_bridge *bridge,
> >
> >  	drm_panel_prepare(panel_bridge->panel);
> >  }
> >
> >  static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
> > -				struct drm_bridge_state *old_bridge_state)
> > +				       struct drm_atomic_state *atomic_state)
> >  {
> >  	struct panel_bridge *panel_bridge =3D drm_bridge_to_panel_bridge(brid=
ge);
> > -	struct drm_atomic_state *atomic_state =3D old_bridge_state->base.stat=
e;
> >  	struct drm_encoder *encoder =3D bridge->encoder;
> >  	struct drm_crtc *crtc;
> >  	struct drm_crtc_state *old_crtc_state;
> >
> >  	crtc =3D drm_atomic_get_new_crtc_for_encoder(atomic_state, encoder);
> >
> > Here's the script I have so far:
> >
> > virtual patch
> >
> > @ bridge_atomic_func @
> > identifier helpers;
> > identifier func;
> > @@
> >
> >  static struct drm_bridge_funcs helpers =3D {
> >  	...,
> >  	.atomic_enable =3D func,
> >  	...,
> >  };
> >
> > @ stores_old_state_for_state_only depends on bridge_atomic_func @
> > identifier bridge_atomic_func.func;
> > identifier bridge, old_state;
> > identifier state;
> > @@
> >
> >  void func(struct drm_bridge *bridge, struct drm_bridge_state *old_stat=
e)
> >  {
> >  	...
> >  	struct drm_atomic_state *state =3D old_state->base.state;
> >  	... when !=3D old_state
> >  }
> >
> > @ depends on bridge_atomic_func && stores_old_state_for_state_only @
> > identifier bridge_atomic_func.func;
> > identifier bridge, old_state;
> > identifier state;
> > @@
> >
> > -void func(struct drm_bridge *bridge, struct drm_bridge_state *old_stat=
e)
> > +void func(struct drm_bridge *bridge, struct drm_atomic_state *state)
> >  {
> >  	...
> > -	struct drm_atomic_state *state =3D old_state->base.state;
> >  	...
> >  }
> >
> > While it works great for imx8mp-hdmi-pvi.c, it seems to not work at all
> > for panel.c unless I call the identifier atomic_state instead of state.
> > My understanding was that identifier was meant to match any identifier
> > name, so I'm a bit confused as to why changing its name would affect the
> > patch.
> >
> > Any suggestion to improve my script?
>=20
> I have the impression that in panel.c the atomic_enable field is mentioned
> in some header file, and not in the .c file.

The function pointer is indeed defined in an header
(include/drm/drm_bridge.h) but I was trying to modify the functions
first before modifying the field itself. Is it an issue?

> An optimization of Coccinelle searches for the important words in the
> semantic patch, which in your case is probably only atomic_enable and
> drm_bridge_funcs, and only takes files that contain that. To avoid
> this optimization, you can use the command line argument:
>=20
> --disable-worth-trying-opt
>=20
> You may need to add some options line --all-includes to get to the
> header file that contains the needed definition.

None of them help, unfortunately :/

I just realized that the imx8 file isn't a good candidate actually, but
drivers/gpu/drm/meson/meson_encoder_dsi.c

I've been testing so far with:
spatch -D patch  --cocci-file test-ml-atomic.cocci \
       --disable-worth-trying-opt --all-includes \
       drivers/gpu/drm/bridge/panel.c drivers/gpu/drm/meson/meson_encoder_d=
si.c

And the output is:

--- drivers/gpu/drm/meson/meson_encoder_dsi.c
+++ /tmp/cocci-output-1376416-03d641-meson_encoder_dsi.c
@@ -42,10 +42,9 @@ static int meson_encoder_dsi_attach(stru
 }

 static void meson_encoder_dsi_atomic_enable(struct drm_bridge *bridge,
-					    struct drm_bridge_state *bridge_state)
+					    struct drm_atomic_state *state)
 {
 	struct meson_encoder_dsi *encoder_dsi =3D bridge_to_meson_encoder_dsi(bri=
dge);
-	struct drm_atomic_state *state =3D bridge_state->base.state;
 	struct meson_drm *priv =3D encoder_dsi->priv;
 	struct drm_connector_state *conn_state;
 	struct drm_crtc_state *crtc_state;

Panel.c not being considered (or not matching)

Maxime

--rkzm3jcmhcvnzcuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ5uTuQAKCRAnX84Zoj2+
dpHmAYC9gmRlbZV1QjNtu4k1gN6oKnoFMXGnML5Gm5I/vV3gU50/fuBl7d4v+2zv
CBHrPAMBf2EWeG0Kloq5tNSrg73y1tNDbWqfAx75//hb/g265JvtZMJ3Xz5goTnz
hLLuT/fmLQ==
=6MgI
-----END PGP SIGNATURE-----

--rkzm3jcmhcvnzcuz--
