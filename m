Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53C7C05027
	for <cocci@archiver.kernel.org>; Sun, 29 Jan 2023 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+h+G+WhrysBqQAsEpYvn2KKSbj+JY+j1LApgMqEPUbk=;
  b=OjFYjWwDa4oAj12Y6OXZ+51AarBqrUQVcobEePGTav+GewV5CHm1N1vE
   w59+gk6c60YCHnKYBbFXR2aCBBZxSzhQRW/5gLPlFIF6RuRCh+wGa6pKP
   edC4mDxeSGJTyBVoXtEayAnwegVgD2bO+WRf0Pfi8MmbHefA66BBjKe0t
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="89933427"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2023 18:26:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 42BBAE743E; Sun, 29 Jan 2023 18:26:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A0265E743E
	for <cocci@sympa.inria.fr>; Sun, 29 Jan 2023 17:41:39 +0100 (CET)
IronPort-SDR: 63d6a1c3_tyuGyekHynEar7Ak16xSZQfIBQVuivDfNA6YZ+bjfwttx3p
 2oQrBlszIgITW0NAVVWAHYbmoL6VSLoi6pDwK7w==
X-IPAS-Result: =?us-ascii?q?A0EIBACMoNZj/0YpCbBaHgEBCxIMQIN8gQhWKwMEC0Umh?=
 =?us-ascii?q?CmIfogkEZtWgWqBag8BAwENNQ8EAQEDAQOBS4M1AmuEOx4GBjQTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQKBBhOFaA2CNykBZw6BBgIBAQEmA?=
 =?us-ascii?q?g1SeAEFIwRSEAsYAgImAgJXBgGDEYMiBwELqCB/M4EBhHOaZoFhBoEULIkRg?=
 =?us-ascii?q?2WEMEOCDYQ/PoQPARIBg3mCZwSBCJpcCoE5dYElDoFGgQ8CCQIRSCxANwMZK?=
 =?us-ascii?q?x1AAws7Mgo/NQsLShAbGhsHgQYqKBUDBAQDAgYTAyICDSgxFAQpEw0nJmkJA?=
 =?us-ascii?q?gMiYgMDBCgtCSAfBxURJDwHVjcBBQIPHzcGAwkDAh9Pci4REwUDCxUqRwQIN?=
 =?us-ascii?q?gUGGzYSAggPEg8GJkMOQjc0EwZcASkLDhEDUIFNBC+BYgYpJp0ZgiAFgQkrg?=
 =?us-ascii?q?gKTJ45ioWSDf4FSigqVDjKBRKdrl08gjTCaQ4F5JmlwMxoIMIMjTgMZD5ISk?=
 =?us-ascii?q?lA/NAI5AgcBCgEBAwmMIwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:W/Lf2qEOfB8WCOOkpLqE18eALOsnbusQ8zAXPo5KJiC9Ffbo9f
 xG/c5rtiMc5wx+ZJhNo7290ey7IE80lqQFhbX5X43JYOCOggLBR72Kr7GD/9SKIVyHygcy78
 tdmuRFebjN5EBB/KHHCRODYrAdKce8gdmVuds=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="89931344"
X-MGA-submission: =?us-ascii?q?MDGZWTi0C+dE4b5JegczNivdh6IEkswRd1eRA6?=
 =?us-ascii?q?Wd2/c7IHEhlPyOKdUkU60Er/7xS/XDFk7hwdMTUFlgfGCyE/qAOmK4Tf?=
 =?us-ascii?q?l4lpBf/ghJ5OAVb9pKV6dv7P1IQYjNDwQThtQkfbsWgcELPOHCzPxnAQ?=
 =?us-ascii?q?bsmad39lNPkNmjn6MOkbThxg=3D=3D?=
Received: from paleale.coelho.fi (HELO farmhouse.coelho.fi) ([176.9.41.70])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 17:41:38 +0100
Received: from 91-155-255-60.elisa-laajakaista.fi ([91.155.255.60] helo=[192.168.100.137])
	by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <luca@coelho.fi>)
	id 1pMAkK-005zdU-5A;
	Sun, 29 Jan 2023 18:41:38 +0200
Message-ID: <ec785e8b99b513594f894fd7a546423c87fc829a.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Markus Elfring <Markus.Elfring@web.de>, Julia Lawall
 <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Date: Sun, 29 Jan 2023 18:41:35 +0200
In-Reply-To: <a47bc3c9-0d72-6fc6-03c3-2c124381bd81@web.de>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301272148570.4094@hadrien>
	 <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
	 <808cd549-f96d-872d-a4db-30ea33095207@web.de>
	 <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
	 <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
	 <a47bc3c9-0d72-6fc6-03c3-2c124381bd81@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Luca Coelho <luca@coelho.fi>
X-Loop: cocci@inria.fr
X-Sequence: 834
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/ec785e8b99b513594f894fd7a546423c87fc829a.camel%40coelho.fi>

On Sat, 2023-01-28 at 14:43 +0100, Markus Elfring wrote:
> > @@
> > identifier nested_macros.nm;
> > identifier dev_priv, f;
> > expression e;
> > @@
> > f(...) {
> > 	...
> > -	struct drm_i915_private *dev_priv =3D e;
> > +	struct drm_i915_private *i915 =3D e;
> >=20
> > 	<+...
> > 	nm(...)
> > 	...+>
> > }
>=20
>=20
> You would like to rename a local variable.
> How do you think about to check if the chosen variable name will
> actually be used?
>=20
>=20
>=20
> > +++ b/intel_display.c
> > @@ -3943,7 +3943,7 @@ static bool bxt_get_dsi_transcoder_state
> > =C2=A0					 struct
> > intel_display_power_domain_set *power_domain_set)
> > =C2=A0{
> > =C2=A0	struct drm_device *dev =3D crtc->base.dev;
> > -	struct drm_i915_private *dev_priv =3D to_i915(dev);
> > +	struct drm_i915_private *i915 =3D to_i915(dev);
> > =C2=A0	enum transcoder cpu_transcoder;
> > =C2=A0	enum port port;
> > =C2=A0	u32 tmp;
>=20
> Which function-like macros should be found in such an implementation?
> https://elixir.bootlin.com/linux/v6.2-
> rc5/source/drivers/gpu/drm/i915/display/intel_display.c#L3991
>=20
>=20
>=20
> > Many other files are handled, but there are no matches, though I
> > believe there should be.
>=20
> Would you like to split the SmPL search patterns for another test
> so that your expectations can be clarified better?

Hi Markus,

Thanks for all the input.  I explained what I want to do (hopefully) a
bit more clearly in reply to Julia's latest email.

--
Cheers,
Luca.
