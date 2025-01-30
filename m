Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACB4C0218F
	for <cocci@archiver.kernel.org>; Thu, 30 Jan 2025 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=haXGRx/c86Cw2ppnSc3G2/4WRAB9nh4gdFosVWGsROc=;
  b=FKogY0Ww7s/S7SqJqsoydTzlytHZFxBC4oL92k0fIxw4tEY3yfTCx62A
   KhMNEm2ww9hZWYkcN0Q+4yNNJnRUU2i6yO3elMTOL2ZgjYLZTVIovrUUZ
   +bdK13dqLN0iSjW4NjVawTmfbu6Y5aiFZrWp1zJW35bKipvE8dLKnGkR/
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.13,245,1732575600"; 
   d="asc'?scan'208";a="205791624"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2025 15:19:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5F0D5E0D1D; Thu, 30 Jan 2025 15:19:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 85091E0260
	for <cocci@sympa.inria.fr>; Thu, 30 Jan 2025 15:19:11 +0100 (CET)
IronPort-SDR: 679b8a5e_cz6qguMz7+0P3F07AwoWYQoLATqT229HznFs3fhP7YTcvM3
 tmf5j0r1vjy+ShFWX96AoW/bR+SmMtl4zXf+QIw==
X-IPAS-Result: =?us-ascii?q?A0GGAwD1iJtnj9lUsotagQmEF4FXMwQLSI1ShlOVDo0rC?=
 =?us-ascii?q?AcBAwEIBUQEAQEDBI93Ah4HAQQ0EwECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBAQEBOQUOO4V7DYJbgSyBJgEBAQEBAQEBAQEBAR0CDYErG?=
 =?us-ascii?q?QEBOIFXgnoBgmQDuASBATOBAYIMAQEG3B+BXgcJgUiBWIZrCwGBWokvG4FJR?=
 =?us-ascii?q?IJQgT4BAYt0gjNKhGmJc4h3jm2BaQNZLAFLCjUMOSiBEAOCWoNCgTI3Ag0Cg?=
 =?us-ascii?q?kBwHzGGWIRFgzuBFoFpg3SCFIIRhxAdQAN4PTcUG5o4HHuDM4QFgRAbgg0Sa?=
 =?us-ascii?q?KJtoyOEJQWhWEkDly6TD5h8qS2BfiMugS4zGggoCIMiTwMZD44tDQmIa8MvQ?=
 =?us-ascii?q?jU8AgcLAQEDCZADgUsBAQ?=
IronPort-PHdr: A9a23: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
 rAne4rwJS1E/taS+tETVZG8FQ==
IronPort-Data: A9a23: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
 AovUQ==
IronPort-HdrOrdr: A9a23:BGZ+mq0amlyVxGCVMQuetQqjBSFyeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5AEtQ4exoS5PwOk80lKQFqLX5WI3PYOCIghrNEGgP1+rfKnjbalTDH41mpO
 9dmspFebrN5DFB5K6UjjVQUexQpuVvm5rY5ts2uk0dKD2CHJsQjTuRZDz6LmRGAC19QbYpHp
 uV4cRK4xC6f24MU8i9Dn4ZG8DeutzijvvdEFQ7Li9izDPLoSKj6bb8HRTd9AwZSSlzzbAr9n
 WAuxDl55+kr+qwxnbnpiLuBtVt6ZfcI+l4dYKxY/suW3TRY8GTFcRcsoi5zX8ISSeUmRUXeZ
 f30lUd1o9ImgnslymO0GbQMk/boX0TAjbZuCOlqGqmrsrjSD0gDc1dwYpfbxvC8kIl+Mpxya
 RRwguixu5q5D777VbADuLzJmRXv1vxpWBnnf8YjnRZX4dbYLhNrZYH9EcQFJsbBir15I0uDe
 ErVajnlYBrWELfa2qcsnhkwdSqUHh2FhCaQlIassjQ1zRNhnh2w0YR2cRalHYd85A2TYVC+o
 3/Q9NVvaALStVTYbN2Be8HT8fyAmvRQQjUOGbXOljjHLFvAQO/l3c22sRE2AiHQu148HJpou
 W/bLpxjx9NR37T
X-Talos-CUID: 9a23:4jbx+W0Fpkeiglow5i7rorxfFcsmd3Dlw3HrJ0KKD3kxEaCzFXCc5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3A+LmVbQ0GivjrfsM00i73wtWSyDUj35qXVUMRmpY?=
 =?us-ascii?q?/gubfLDQrNDaNsRnqXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,245,1732575600"; 
   d="asc'?scan'208";a="205791603"
X-MGA-submission: =?us-ascii?q?MDHXscuS2WvDusNDg+sJ2wF+h0PYPGnd2SEe0w?=
 =?us-ascii?q?OsYi1Kp8eqSWSWBCPfCFblbtQG3XAArMZxyE0zWM5sLUgF00uQ3PKaL9?=
 =?us-ascii?q?CHiXPXSfijOxm+uw3PKBGj88W7LCZQIsRkZ1Zqiu0nfNs+9Bjr8Z0a0w?=
 =?us-ascii?q?3QqenTdn3o4gFtMUPI9f1JvA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 15:19:10 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 69B6F5C5D63
	for <cocci@inria.fr>; Thu, 30 Jan 2025 14:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD610C4CED2
	for <cocci@inria.fr>; Thu, 30 Jan 2025 14:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738246749;
	bh=LyjaauSD8ARr0WT4UTLVsWo1pnYvYhFuC5lNkDFonZ0=;
	h=Date:From:To:Subject:From;
	b=A3ZS2TTv6XUiW5aYH27xLvUGo3jO7mbYz5o/ONv1TWCA/1NBunjBvjPvd7gIg1lKa
	 12au9UlL+SWZ2e+C8bQhdO0AKlomhQjmdsytXWJLwBSoTTRDbD3lXbcQhKThk8Vkub
	 kb5RybG47lklFVKxpPJTNRGqBkNGuEybM63ZUTzYcsPnpSKr5dor+shAopcN9jBtmq
	 r/wPWlFx0c/Rjg3QkqX1BYk0rPrVWRxXVjHpF7tAXGkc4jt87wW//tBOV/py7/SJVN
	 o9O5Lxnx9kijl/+g3nS2Wr8PBNt+8AWRUJ9LtSBD75b1x03x3sQRyMjJFwiI/5u1Gk
	 OCXkUhaTdrm2g==
Date: Thu, 30 Jan 2025 15:19:05 +0100
From: Maxime Ripard <mripard@kernel.org>
To: cocci@inria.fr
Message-ID: <dmpq6u4xhcmog2ugsrggn7lts7w4iiczmy3pzomjqchzbtey3g@s5d2afdhbsa7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="mlrhmldxzdp5vex7"
Content-Disposition: inline
Subject: [cocci] Help to match variables with different names
Reply-To: Maxime Ripard <mripard@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2318
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/dmpq6u4xhcmog2ugsrggn7lts7w4iiczmy3pzomjqchzbtey3g%40s5d2afdhbsa7>


--mlrhmldxzdp5vex7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Help to match variables with different names
MIME-Version: 1.0

Hi,

I've been trying to make a coccinelle script for some API change in DRM.

Two good examples for what I'm struggling with are drivers/gpu/drm/bridge/panel.c and
drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c

I want to make a script that will modify the
drm_bridge_funcs.atomic_enable prototype to take a drm_atomic_state
pointer instead of the drm_bridge_state one.

Both of these files use an indirection to retrieve the drm_atomic_state
pointer from the drm_bridge_state one. Since the drm_atomic_one is going
to be a parameter, I need to remove the assignment, and set the
parameter name to whatever was used in the function before.

Basically, I'd like the following diff:

diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
index 0d1ac3edcab4..e41bc58fbeb6 100644
--- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
+++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
@@ -47,13 +47,12 @@ static int imx8mp_hdmi_pvi_bridge_attach(struct drm_bridge *bridge,
 	return drm_bridge_attach(bridge->encoder, pvi->next_bridge,
 				 bridge, flags);
 }

 static void imx8mp_hdmi_pvi_bridge_enable(struct drm_bridge *bridge,
-					  struct drm_bridge_state *bridge_state)
+					  struct drm_atomic_state *state)
 {
-	struct drm_atomic_state *state = bridge_state->base.state;
 	struct imx8mp_hdmi_pvi *pvi = to_imx8mp_hdmi_pvi(bridge);
 	struct drm_connector_state *conn_state;
 	const struct drm_display_mode *mode;
 	struct drm_crtc_state *crtc_state;
 	struct drm_connector *connector;
diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 6e88339dec0f..b84dcf1b709b 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -127,14 +127,13 @@ static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,

 	drm_panel_prepare(panel_bridge->panel);
 }

 static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
-				struct drm_bridge_state *old_bridge_state)
+				       struct drm_atomic_state *atomic_state)
 {
 	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
-	struct drm_atomic_state *atomic_state = old_bridge_state->base.state;
 	struct drm_encoder *encoder = bridge->encoder;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state;

 	crtc = drm_atomic_get_new_crtc_for_encoder(atomic_state, encoder);

Here's the script I have so far:

virtual patch

@ bridge_atomic_func @
identifier helpers;
identifier func;
@@

 static struct drm_bridge_funcs helpers = {
 	...,
 	.atomic_enable = func,
 	...,
 };

@ stores_old_state_for_state_only depends on bridge_atomic_func @
identifier bridge_atomic_func.func;
identifier bridge, old_state;
identifier state;
@@

 void func(struct drm_bridge *bridge, struct drm_bridge_state *old_state)
 {
 	...
 	struct drm_atomic_state *state = old_state->base.state;
 	... when != old_state
 }

@ depends on bridge_atomic_func && stores_old_state_for_state_only @
identifier bridge_atomic_func.func;
identifier bridge, old_state;
identifier state;
@@

-void func(struct drm_bridge *bridge, struct drm_bridge_state *old_state)
+void func(struct drm_bridge *bridge, struct drm_atomic_state *state)
 {
 	...
-	struct drm_atomic_state *state = old_state->base.state;
 	...
 }

While it works great for imx8mp-hdmi-pvi.c, it seems to not work at all
for panel.c unless I call the identifier atomic_state instead of state.
My understanding was that identifier was meant to match any identifier
name, so I'm a bit confused as to why changing its name would affect the
patch.

Any suggestion to improve my script?

Thanks!
Maxime

--mlrhmldxzdp5vex7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ5uKVQAKCRAnX84Zoj2+
dvsdAYDYQZu6TvbSkJNoSkMJTRBM8Prf3QtdwX2Ps/zcc1D29pmT4j0kK+xhvIUP
DXhsDqABgLjtE8mhdjmyQh/CsqmL9V2I+sB2iiqZNqZyBxUNs0nVMGgvdjpRAfl/
A8M6KQwQ0g==
=kRLK
-----END PGP SIGNATURE-----

--mlrhmldxzdp5vex7--
