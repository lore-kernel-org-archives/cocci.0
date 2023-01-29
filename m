Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED2CC61D97
	for <cocci@archiver.kernel.org>; Sun, 29 Jan 2023 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=toyVX7QnBTRWIL/oNFiSlB5zbKcMFy8lQDK/dpHjZYE=;
  b=mTHW0kFbReYJAwEWYbEDzUf3Qox4B34cr5ls9PvcFwTBRVvChO2tdGlD
   hzl/I1n+3xjv+zCCwrCvPRThumUh+8HqTXb7CCpLZ3F2xg1wUlM79HKs+
   562M1PZl6gGaImpKkyuEF42iycA1GQFvDrLZB1CI+/ZLSuzRFRG9wObyt
   0=;
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
   d="scan'208";a="89939558"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2023 21:10:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 579ACE743F; Sun, 29 Jan 2023 21:10:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B2AF2E743E
	for <cocci@sympa.inria.fr>; Sun, 29 Jan 2023 20:11:24 +0100 (CET)
IronPort-SDR: 63d6c4dc_039X7hf5ibsB+KvqNruF0PFZwWCvjmTAvHshP29ceIVNIjm
 FCChjjHlrC/ifyOtk+AFIrx8B+v/GYhBre64sSA==
X-IPAS-Result: =?us-ascii?q?A0GzAwDDw9Zj/0YpCbBaHQEBAQEJARIBBQUBQIFPgi2BC?=
 =?us-ascii?q?FYrAwQLhRSIfogkEZtWg1QPAQMBDTkLBAEBBoIOgnMChSYeBgY0EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECgQYThWgNgjcpAYF9AQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECgVYBAQEBAgEjV?=
 =?us-ascii?q?gULCxgCAiYCAlcGAYMRgn8jBwELp0x6gTKBAYRzmmaBYQaBFCyJEYNOF4QwQ?=
 =?us-ascii?q?4INhA8wPogcgmcEk1qICgqBOXWBJQ6BRoEPAgkCEUgsQDcDGSsdQAMLOzIKP?=
 =?us-ascii?q?zULC0orGhsHgQYqKBUDBAQDAgYTAyICDSgxFAQpEw0nJmkJAgMiYgMDBCgtC?=
 =?us-ascii?q?SAfBxURJDwHVjcBBQIPHzcGAwkDAh9Pci4REwUDCxUqRwQINgUGGzYSAggPE?=
 =?us-ascii?q?g8GJkMOQjc0EwZcASkLDhEDUIFNBC+BYgYpJp0Zgh6BDyyBRYEywniDf4FSi?=
 =?us-ascii?q?gqVDjKBRKdrl08gjTCVCoU5gXkmgVkzGggwO4JoTgMZD5NQkRI/bwIHAQoBA?=
 =?us-ascii?q?QMJjCMBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:K1YzA6z3V0vTmHMzA+a7KrPwE71zdoMgy1knxilNoNJuHfBw8P
 re/sjztCWE6wr5N0tPpTntAsS9qDbnlKKdgrNhWYtKPjONhILAFugLhrcKgQeBJ8SUzJ8k6U
 4PScRD4ZHLfD1HZN7BkW6F+swbsb+6Gb6T9J7j80s=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="46289878"
X-MGA-submission: =?us-ascii?q?MDHlTqp98ho5rZzSLodpRcqJMrWq0DkrdSNCSN?=
 =?us-ascii?q?hnghIMTND0TQmdVGonVEDP7bRkx0JX+StN0XVa3PXMJrulrdmqPMXRZ2?=
 =?us-ascii?q?pK84IZgdkVKiVbr8aXrFCdsvJtagTtieWpQ2SKwt7yn/nOGLlvFtSEhN?=
 =?us-ascii?q?FkVCj/4c+vmDnYMlUk63duzQ=3D=3D?=
Received: from paleale.coelho.fi (HELO farmhouse.coelho.fi) ([176.9.41.70])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 20:11:24 +0100
Received: from 91-155-255-60.elisa-laajakaista.fi ([91.155.255.60] helo=[192.168.100.137])
	by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <luca@coelho.fi>)
	id 1pMD5F-005zi8-1m;
	Sun, 29 Jan 2023 21:11:22 +0200
Message-ID: <e111e4c0ef6fc93576d41a625045ca282ab41bfb.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Markus Elfring <Markus.Elfring@web.de>, Julia Lawall
 <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Date: Sun, 29 Jan 2023 21:11:20 +0200
In-Reply-To: <0913ebfd-6ec2-722a-fc17-e609ce0b8770@web.de>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301272148570.4094@hadrien>
	 <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
	 <808cd549-f96d-872d-a4db-30ea33095207@web.de>
	 <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
	 <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301281432120.2822@hadrien>
	 <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
	 <0913ebfd-6ec2-722a-fc17-e609ce0b8770@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Adding a parameter for special macro calls with SmPL
Reply-To: Luca Coelho <luca@coelho.fi>
X-Loop: cocci@inria.fr
X-Sequence: 839
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/e111e4c0ef6fc93576d41a625045ca282ab41bfb.camel%40coelho.fi>

On Sun, 2023-01-29 at 19:01 +0100, Markus Elfring wrote:
> > @macros_noargs@
> > identifier m;
> > expression e =3D~ "dev_priv";
> > @@
> > #define m <+...e...+>
> >=20
> > @nested_macros@
> > identifier macros_noargs.m;
> > identifier nm;
> > identifier list il;
> > @@
> > #define nm(il) <+...m...+>
> >=20
> > @@
> > identifier nested_macros.nm;
> > identifier list il;
> > expression e;
> > @@
> > -#define nm(il) e
> > +#define nm(dev_priv, il) e
> >=20
> > @@
> > identifier nested_macros.nm;
> > identifier dev_priv, f;
> > expression e;
> > expression list il;
> > @@
> > f(...) {
> > 	...
> > (
> > 	struct drm_i915_private *dev_priv =3D e;
> > >=20
> > 	struct drm_i915_private *dev_priv;
> > )
>=20
>=20
> I suggest to another look at the isomorphism =E2=80=9Cdecl_init=E2=80=9D.
> https://gitlab.inria.fr/coccinelle/coccinelle/-
> /blob/b9603af4eca7f4c771d57a3861855332e9bb1c4c/standard.iso#L465

Thanks, I took a look, the optional initialization is better, indeed.

>=20
>=20
>=20
> > 	<+...
> > -	nm(il)
> > +	nm(dev_priv, il)
> > 	...+>
> > }
> >=20
> >=20
> > The idea is that all the macros that are implicitly using dev_priv,
> > will have a new argument where dev_priv is passed.
>=20
>=20
> Your description evolved for the desired transformation considerably.

Yes, sorry, I wanted to keep it as simple as possible, but leaving most
of the story out was indeed a problem, because it was lacking context.


> How do you think about to use the following SmPL script variant?
>=20
>=20
> @macros_noargs@
> identifier m;
> expression e =3D~ "dev_priv";
> @@
> #define m <+...e...+>
>=20
> @nested_macros@
> identifier macros_noargs.m, nm;
> identifier list il;
> @@
> #define nm(il) <+...m...+>
>=20
> @addition1@
> identifier nested_macros.nm;
> identifier list il;
> expression e;
> @@
> -#define nm(il) e
> +#define nm(dev_priv, il) e
>=20
> @addition2@
> identifier nested_macros.nm, dev_priv, f;
> expression list el;
> @@
> =C2=A0f(...)
> =C2=A0{
> =C2=A0...
> =C2=A0struct drm_i915_private *dev_priv;
> =C2=A0<+...
> =C2=A0nm(
> +=C2=A0=C2=A0 dev_priv,
> =C2=A0=C2=A0=C2=A0 el)
> =C2=A0...+>
> =C2=A0}

This is nice, I'll change it.


> > After mangling a lot with the rules, I can see that this now works,
>=20
>=20
> This understanding is nice.
>=20
>=20
>=20
> > but only if I select the vlv_dsi.c file alone, like this:
>=20
>=20
> This observation will probably need further explanations.
>=20
>=20
>=20
> > Of course, I can work around this by using find and running spatch
> > individually in every file... But not ideal.
>=20
>=20
> The Coccinelle software should take care of corresponding source file
> searches already.

It should, but it doesn't seem to be working properly.

--
Cheers,
Luca.
