Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86584C02196
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2025 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=rpma31dvf3awixoF2VBqiQhqmFXL4W4xucUOhS/9MSw=;
  b=hNYUPAGstyGBvZktMJ6EdlqGdSZyHl2Ou0aLM8XPsSZUaKp4ta9yrG1S
   yRVWVr9moS5y6gnrB6OzEtMg4Wt4xlEpwGtRn2KXoVRD1MnErJWeLCido
   C8mJ1xgA6gAPd5NRzt8/yak35SJaF9Cgb0XfNMgMEItBoyjyE9a4Gk/9k
   g=;
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
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="asc'?scan'208";a="206976523"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2025 15:44:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 00726E0261; Thu,  6 Feb 2025 15:44:16 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 48138E0260
	for <cocci@sympa.inria.fr>; Thu,  6 Feb 2025 15:44:12 +0100 (CET)
IronPort-SDR: 67a4cabb_HE00JrM0qJ5/nc1XAA4/Q//G72qpixgS1BOYOxEuA5vlhBn
 b3dVBDOiN7l3rd7qefT6NxdBAUzZ4eISO7jueZg==
X-IPAS-Result: =?us-ascii?q?A0EPAABNyaRnj9lUsotaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIjHNfhlOCJJJMHIssgX4IBwEDAQgFRAQBAQMEhQACi?=
 =?us-ascii?q?wECHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBA?=
 =?us-ascii?q?QEBOQVJhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDJxkBATcBDwsYL?=
 =?us-ascii?q?lYGgxUBgmQDsFaBATOBAYIMAQEG3CCBXgcJgUgBgVeGbAsBgVqIDnonG4FJR?=
 =?us-ascii?q?IJQgT4xPosHgjOBb4NAiWuIb5AcUoEXA1ksAUsKNQw5KEhIA4E0gSMFNXuCD?=
 =?us-ascii?q?YEyOgINAoJAcB+ES4I6hEODN4EWgWeDdIISgWIDAxYQAYMhehyDIUwdQAN4P?=
 =?us-ascii?q?TcUGwaaahx8gzyEF4EQG4FVOBKjWKMkhCWhYUWXMJMPmHylMoN8gWc6gVwzG?=
 =?us-ascii?q?ggoCIMiTwMZD44hDA0JiGvCXUI1PAIHCwEBAwmQMYFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Cg6NC6snrFdiNcoSfSSeBjWSpxrzPz9zUX5bx0=
IronPort-HdrOrdr: A9a23:QjvFWavWnd21xKnqsac99sRl7skDedV00zEX/kB9WHVpmwKj9v
 xGuM5rsiMc6QxhPE3I/OrsBEDuex/hHPJOjrX5eI3SOjUO21HYSb2Kj7GSoAEIcheWnoU26U
 4jSdkdNDSaNzhHZKjBjjWFLw==
X-Talos-CUID: =?us-ascii?q?9a23=3A9hyIY2rV2tOjrZleQgWlmlbmUcwIUFLQlkfWGBD?=
 =?us-ascii?q?iBElxGaGsRwaz5qwxxg=3D=3D?=
X-Talos-MUID: 9a23:TuWiUAUmwKWsd8nq/GTgpWA+HZtS2PWnI11TiKktpOWpDBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="asc'?scan'208";a="108398171"
X-MGA-submission: =?us-ascii?q?MDGexf0C3FxepWw+EJ5QBwXb61BBYrtCX/bPB6?=
 =?us-ascii?q?TkpsHsnJsbS+VAOYZ3evt+5aY12pVTdJp64jAFguGVRNp6pqFg9GBU0/?=
 =?us-ascii?q?BBlbe3fjp7IvaeZVOJcXwrh47wTtdsHFoW05u1bJxcNM6Y5v8qXzKWSH?=
 =?us-ascii?q?uC+FfEBu9+qkoX3srl0uraFw=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 15:44:11 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E0E645C0754;
	Thu,  6 Feb 2025 14:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1423EC4CEDD;
	Thu,  6 Feb 2025 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738853048;
	bh=Bb6wvSham5PIZ5EIwErsxExayH+zc3pDKZVB6PKMf8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=auWuflaqq+sPMuExvn6amZYCk9EYMtnlvH119rNYwRCGe71TrmSVEWKOS1wXi+uQd
	 vfUZTWBAOvEjUnu0dk37iPurqDKiAGA/BW5jHQIAe3aV6vHKC4QrYS+5+6vzVAm2Bg
	 hzn5yX/DfLGPwGpXlLJoDjOIskIw3uLKHfAG0jgKNl0l91dSu+pQXWPi3u3gYjAGVi
	 1rPFBWGIo2KiEbdH2mMOYN5Fi3E5dJ7AQ+hPqeUHO0oaJ4s61jnOzp3O6og/oMCnvw
	 7QgMWLbWQGQc9ZV9NCgEotFAMHQUi6peWm7x7nz9STV3phaTGaRhXRQfycR4noqa8E
	 lS0jTm6Nsrn9Q==
Date: Thu, 6 Feb 2025 15:44:06 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <20250206-psychedelic-annoying-earwig-a518ea@houat>
References: <dmpq6u4xhcmog2ugsrggn7lts7w4iiczmy3pzomjqchzbtey3g@s5d2afdhbsa7>
 <b2b1e1bf-af3f-c7b4-e278-798578b02442@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="4u7fldkde3opw6ux"
Content-Disposition: inline
In-Reply-To: <b2b1e1bf-af3f-c7b4-e278-798578b02442@inria.fr>
Subject: Re: [cocci] Help to match variables with different names
Reply-To: Maxime Ripard <mripard@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2364
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250206-psychedelic-annoying-earwig-a518ea%40houat>


--4u7fldkde3opw6ux
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Help to match variables with different names
MIME-Version: 1.0

On Thu, Jan 30, 2025 at 10:53:45AM -0500, Julia Lawall wrote:
>=20
>=20
> On Thu, 30 Jan 2025, Maxime Ripard wrote:
>=20
> > Hi,
> >
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
>=20
> Sorry, I misdiagnosed the problem due to having an old kernel.  The
> problem is in the line that should match here, which has the following for
> panel.c:
>=20
>         struct drm_atomic_state *atomic_state =3D old_bridge_state->base.=
state;
>=20
> You have made state a metavariable so the declared variable name has to be
> the same as the field name.  Probably you want to use something other than
> state as the indentifier metavariable name.

It works like a charm now, thanks a lot for your help :)

Maxime

--4u7fldkde3opw6ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ6TKsQAKCRAnX84Zoj2+
dvV4AX97jAaFOaOAnSWLrdw5fToptDjZYa1vyqButZlNnUDZxMbitUwnNCAR8suU
MXVUJfYBfRsainpaHeaQNPQrlmrrDX+YxFpo09f+duqnCddrjmWpyjk4jaW2/6Sz
tp+XxsF2rg==
=OTwD
-----END PGP SIGNATURE-----

--4u7fldkde3opw6ux--
