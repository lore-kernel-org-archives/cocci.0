Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692CAC0218A
	for <cocci@archiver.kernel.org>; Thu, 30 Jan 2025 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Z/+WmW10ukH4k7xzk2Hy5QBq2NZ92ExyFwm53TIQP/o=;
  b=nLFZVW+qqA1nBLeJS2n2DCCILdqSWj78f3Q8hvk0D5kpcJw9clYkxXu4
   NTtHVBeXZMH/pCGOKaB+KPGixMFk6AyE5DEKkYBeyauYkTCCB0Skm/WUC
   UMdRJjwxntKHdwjbgfzfKN7XskSSvcRFfC4YYl7TBqX7dvD3GgKTwQpka
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.13,245,1732575600"; 
   d="scan'208";a="205815878"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2025 16:53:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DBFEEE0D1D; Thu, 30 Jan 2025 16:53:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EE7CCE0260
	for <cocci@sympa.inria.fr>; Thu, 30 Jan 2025 16:53:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Z/+WmW10ukH4k7xzk2Hy5QBq2NZ92ExyFwm53TIQP/o=;
  b=Y2ZlHrz7dfgcj/u5ws8W/Z1qemckzQYSGSH2uXBlaQXXZOC7NewzrlA2
   xVLMT8+TjtL4WgdFzR9bgLJ0yUiZFaF1hgZJFxv+lfl2U1CDHE428K3U4
   PpwIH9H5VHXiwXRbApS/EchJRE+1chZ6aEzF2Q/FUq11CjmqKJZJQtCyI
   g=;
X-IronPort-AV: E=Sophos;i="6.13,245,1732575600"; 
   d="scan'208";a="107781869"
Received: from unknown (HELO hadrien.lan) ([172.59.114.59])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 16:53:47 +0100
Date: Thu, 30 Jan 2025 10:53:45 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Maxime Ripard <mripard@kernel.org>
cc: cocci@inria.fr
In-Reply-To: <dmpq6u4xhcmog2ugsrggn7lts7w4iiczmy3pzomjqchzbtey3g@s5d2afdhbsa7>
Message-ID: <b2b1e1bf-af3f-c7b4-e278-798578b02442@inria.fr>
References: <dmpq6u4xhcmog2ugsrggn7lts7w4iiczmy3pzomjqchzbtey3g@s5d2afdhbsa7>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Help to match variables with different names
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2323
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/b2b1e1bf-af3f-c7b4-e278-798578b02442%40inria.fr>



On Thu, 30 Jan 2025, Maxime Ripard wrote:

> Hi,
>
> I've been trying to make a coccinelle script for some API change in DRM.
>
> Two good examples for what I'm struggling with are drivers/gpu/drm/bridge/panel.c and
> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
>
> I want to make a script that will modify the
> drm_bridge_funcs.atomic_enable prototype to take a drm_atomic_state
> pointer instead of the drm_bridge_state one.
>
> Both of these files use an indirection to retrieve the drm_atomic_state
> pointer from the drm_bridge_state one. Since the drm_atomic_one is going
> to be a parameter, I need to remove the assignment, and set the
> parameter name to whatever was used in the function before.
>
> Basically, I'd like the following diff:
>
> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> index 0d1ac3edcab4..e41bc58fbeb6 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> @@ -47,13 +47,12 @@ static int imx8mp_hdmi_pvi_bridge_attach(struct drm_bridge *bridge,
>  	return drm_bridge_attach(bridge->encoder, pvi->next_bridge,
>  				 bridge, flags);
>  }
>
>  static void imx8mp_hdmi_pvi_bridge_enable(struct drm_bridge *bridge,
> -					  struct drm_bridge_state *bridge_state)
> +					  struct drm_atomic_state *state)
>  {
> -	struct drm_atomic_state *state = bridge_state->base.state;
>  	struct imx8mp_hdmi_pvi *pvi = to_imx8mp_hdmi_pvi(bridge);
>  	struct drm_connector_state *conn_state;
>  	const struct drm_display_mode *mode;
>  	struct drm_crtc_state *crtc_state;
>  	struct drm_connector *connector;
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 6e88339dec0f..b84dcf1b709b 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -127,14 +127,13 @@ static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>
>  	drm_panel_prepare(panel_bridge->panel);
>  }
>
>  static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
> -				struct drm_bridge_state *old_bridge_state)
> +				       struct drm_atomic_state *atomic_state)
>  {
>  	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
> -	struct drm_atomic_state *atomic_state = old_bridge_state->base.state;
>  	struct drm_encoder *encoder = bridge->encoder;
>  	struct drm_crtc *crtc;
>  	struct drm_crtc_state *old_crtc_state;
>
>  	crtc = drm_atomic_get_new_crtc_for_encoder(atomic_state, encoder);
>
> Here's the script I have so far:
>
> virtual patch
>
> @ bridge_atomic_func @
> identifier helpers;
> identifier func;
> @@
>
>  static struct drm_bridge_funcs helpers = {
>  	...,
>  	.atomic_enable = func,
>  	...,
>  };
>
> @ stores_old_state_for_state_only depends on bridge_atomic_func @
> identifier bridge_atomic_func.func;
> identifier bridge, old_state;
> identifier state;
> @@
>
>  void func(struct drm_bridge *bridge, struct drm_bridge_state *old_state)
>  {
>  	...
>  	struct drm_atomic_state *state = old_state->base.state;

Sorry, I misdiagnosed the problem due to having an old kernel.  The
problem is in the line that should match here, which has the following for
panel.c:

        struct drm_atomic_state *atomic_state = old_bridge_state->base.state;

You have made state a metavariable so the declared variable name has to be
the same as the field name.  Probably you want to use something other than
state as the indentifier metavariable name.

julia


>  	... when != old_state
>  }
>
> @ depends on bridge_atomic_func && stores_old_state_for_state_only @
> identifier bridge_atomic_func.func;
> identifier bridge, old_state;
> identifier state;
> @@
>
> -void func(struct drm_bridge *bridge, struct drm_bridge_state *old_state)
> +void func(struct drm_bridge *bridge, struct drm_atomic_state *state)
>  {
>  	...
> -	struct drm_atomic_state *state = old_state->base.state;
>  	...
>  }
>
> While it works great for imx8mp-hdmi-pvi.c, it seems to not work at all
> for panel.c unless I call the identifier atomic_state instead of state.
> My understanding was that identifier was meant to match any identifier
> name, so I'm a bit confused as to why changing its name would affect the
> patch.
>
> Any suggestion to improve my script?
>
> Thanks!
> Maxime
>
