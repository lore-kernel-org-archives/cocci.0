Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BC1C61DA4
	for <cocci@archiver.kernel.org>; Mon, 30 Jan 2023 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vFc0D7CNUFVFV/JsI7OjIWXfFD0yITO63Vzta3Dj0SM=;
  b=NI37T951Exl2zn+pcGzIo/whqk68EEzm/9V58+WYLFn0dCC2pLo5WBwU
   15gAvXIcWmsBydnr8uZSbFLw5HJPj/+Q49Ap9GMys2e/RZ7kZ0rP18RIr
   PwHMUwZnZTxRXMpyI88Ba24m2nn1ye8vDsOqBUi124stA2OfJNCsLC2gu
   I=;
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
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="90027370"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2023 10:41:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 27FCCE7443; Mon, 30 Jan 2023 10:41:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 44DE8E743E
	for <cocci@sympa.inria.fr>; Mon, 30 Jan 2023 10:41:39 +0100 (CET)
IronPort-SDR: 63d790d2_9Jjc9j/fEtTKmSkJuYP+Lvk70NYiv/JW+EPxqb2KdDUO/gl
 AxIGgUJLgU2vL1uIpHo6Z2Wwj1rcVG98b+jhQwQ==
X-IPAS-Result: =?us-ascii?q?A0GYAADCj9djjEYpCbBaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YIsgQhWKwMEC0UmhCmIfogkEZtWg1QPAQMBDTkLBAEBAwEDgUuDNQJrhDseB?=
 =?us-ascii?q?gYzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEBQEWFa?=
 =?us-ascii?q?A2CNykBZw6BBgIBAQEBAQEBAQEBAQEBAQEBAQEBFgINUncBAQEBAgEjVgULC?=
 =?us-ascii?q?xgCAiYCAlcGAYMQAYJ/IwcBC6hDeoEygQGEc5pmgWEGgRQsAYkQg2WEMEOCD?=
 =?us-ascii?q?YQ/PoJLgXmDWIJnBJtkCoE5dYElDoFGgQ8CCQIRSCxANwMZKx1AAws7Mgo/N?=
 =?us-ascii?q?QsLShAbGhsHgQYqKBUDBAQDAgYTAyICDSgxFAQpEw0nJmkJAgMiYgMDBCgtC?=
 =?us-ascii?q?SAfBxURJDwHVjcBBQIPHzcGAwkDAh9Pci4REwUDCxUqRwQINgUGGzYSAggPE?=
 =?us-ascii?q?g8GJkMOQjc0EwZcASkLDhEDUIFNBC+BYgYpJp0ZgSyCLYFFWsNQg3+BUooKl?=
 =?us-ascii?q?Q4ygUSna5dPII0wmkOBeCSBXDMaCDA7gmhOAxkPiEqFYg0Jg1CFFI08PzQCO?=
 =?us-ascii?q?QIHAQoBAQMJjCMBAQ?=
IronPort-PHdr: A9a23:lMh9ixzbAt9dIqrXCzIiwVBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 hGZvK43xweXFazgqNt6yMPu+5j6XmIB5ZvT+FsjS7drEyE/tMMNggY7C9SEA0CoZNTjbig9A
 dgQHAQ9pyLzPkdaAtvxaEPPqXOu8zESBg//NQ1oLejpB4Lelcu62/6y9pHJfglFiiSxbbxuI
 Bi3sA7cqtQYjYx+J6k+zRfEvmFGcPlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3Q
 qBWAzogM2Au+c3krgLDQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VSik4
 qx2UxLjljsJOCAl/2HWksxwjbxUoBS9pxxk3oXYZJiZOOdicq/BeN8XQ3dKUMRMWCxbGo6yb
 IsBAfQfMOhWrYb9qUcBoxSwCgajGe3i0SNIhmbs0KEmz+gsCwPL0Qo9FNwOqnTUq9D1Ob8UX
 +Co0KbH1yjIYu1R2Tjj7IjIchchquyLULJ0bMre1VMgGhjZgVWXt4PlOzOV1uMXv2iV7uptT
 OSigHMopA9tuDag3NssipXXiYIPzFDJ7Sp3zYI6KNO2R0N1YcOoHZVMuiyYOIZ7TMAvT39qt
 SonybAKp561cSkJxZkkxxPSb+GKfoaG7xzjW+icJTh1iXxjdbmiiRiy9k2gxff9VsmyyFtFt
 S1Fkt7QtnAJ1hzT7NKLRed6/kekwTqP1B7c6vtCIU8qkarXMZkhwqQ/lpcVrE/NHTf2lV3rg
 KKUd0go4Oyl5/7ob7n7vJORNZN4hhn6P6gzgMCzHOQ1PwgUU2SF+emx1Kfv8EzlTLhMk/Y4i
 LPWsIrAKsQevqO5AxFa0oIk6xunATepys4YnXwHLFJCZRKHlJbmN0vSL/D/E/i/h1SskDBxy
 /DIP73tGpTNLn7dn7f9Zbtx9kxRxQspwd1b/Z5ZBawNLOjxV0PtrNDYCwU2Mw2ww+bpEtV90
 YYeVHqLAq+ELKzdq0SF6f4oI+aSYI8VuDH9J+Ir5/7vlXM5n0QScrGz3ZQLcHC4AuhmI0KBb
 HbymtsBC3sFvhIiTOz2j12PSTpTaGy8Xq0m4jE7DJmrDIbCRoCom7OBxj20EodXZmBAEFCME
 G3ne5+KW/cWcC6SONNukiQYVbi9TI8szQ2htAjmxLV7L+rZ4TYYtJLm1Nht/eLfjxAy9TpuD
 8ScyW6BVW90nnlbDwMxiYV2u09g0R+u1aZigvpXXYh27ulKTxx8GJrS1e18BPjtVwiHctrfD
 B6EX9GnCHkVR804x9tGN0RgH9SryBTKwCOuB5cUkaaKDdo66PSP8WL2IpNZ1n3PnIImgl0mR
 YMbMXCtj4Z08AXXB4mPnUTPxPXiTrgVwCOYrDTL9mGJpkwNFVcoCc0tPFgab0rS9pHi41/aC
 qSpEfIhOxdAzsiLLu1LbMfohBNIXqSrI8zQNkS2nWr4HhOU3vWUdoO/f3gW1Q3WD0UAkwdV8
 3fVfRMmCHKHpGTTRCdrCUqpZkrt9edkr3buSlI/ximBaEBl173z9B9GzeeERaY12bQJ8Dwkt
 y0yHFu52IfODMGcogN6YKhGSd00+lJH0n/Cukp2OZGkL6ckiF92nx1fmUTo2l03D4xBlZNvt
 3Y21E9pLrre1lpddjSe1JS2O7vNK2C08gr9I6jRkkrT1tqb4MJtoLwxtknjsQe1F0Ej72Qv0
 t9b1GGZ74nLCwxaWIz4U0I+/Rx377/AZSx164TR3Hxqea66112Kk9Y0D+INwRGte9dYdq2FV
 UfzH8AcG8myObkygVH6JhkAPe1U6Os1J5b/KKXAiej3ZaA/xGHD7ywP+o1230OS+jApT+fJ2
 81A2PSExk6cUC+6il69s8fxkIQCZDcIH2P5xzK3YewZLqB0Y4sPDn+jZsOtwdArzZrwUHdw/
 1muA1MBnsGoM0nafxnm0Atc2F5C63i6kiKQxDt5lzEu6KSeln+roayqZF8MPWhFQ3NnhFHnL
 N2vjtwUa0OvahAgiBqv4UuSK7FzgqN5IiGTRE5Je3OzNGR+Su6rsaLEZcdT6ZQuuCERUeKmY
 FncRKSv6x0dmzjuGWdT3lVZP3mjp4n5khpmiWmcMGc7rXzXftt1zAve49qUTOBY3z4PTi11w
 TfNAV30M96s9NSS35DN14L2H2a8XZR7ei7myYOH8iW6pCVrDRC5g/Gvi4jiGAk+3zX80ooiX
 iHJoRDgJ4jzgv3lb6Q2OBUxQgCkuK8YUslkn4A9hY8dwy0fj5SRpj8clHvrdM5cweT4ZWYMQ
 jgCx5jU5hLk0QttNCHspcqxW3ODz89mf9T/bHkR33d3691BAY+f67FAnSwzrFvy/krBJONwm
 DsQ065k7GMRiskCvwcpziLbDLFYTiw6dWT80h+P6d65tqBeYm2iJKOx2ERJltekFLieowtYV
 R4VY78EGil9poV6OVPIizjo7538PcLXdZQVvwGVlBHJi65ULogwn7wEn3gvP2W1pnAjx+Mh6
 H4mlZinoIiKLXls96OlE1ZZMDPyfcYa5jDqi+5XgM+X24mlGpgpFC8MWdPkSvehETRasvqCV
 U7GCDontnKSAqbSByeR4V1jr3XSCJ3tPHaaIHkei9tjBVGcKEFZnAEITWA6k5o+RWXIjITqd
 EZ04CxU50at80QSjLMua0C5DT+MwWXgIi05Q5WeMhdMuwRL5kOOdNeb8vo2BCZAuJuosA2KL
 GWfIQVOF2AAHEKeVDWBdvGj48fN9++AC6+wNfzLNP+KtOdXf/yPyJav1c1o/nzfU6fHdmknF
 PA91kdZCDphHN/FnjwUVyENvyzEdcubowqn92t8qc278POtVgOltu7tQ/NCdN5o/R6xm6KKM
 eWd0T14JThv3ZQJ3XbUybIb0Tb6bgllcDSpEbNGuy+fFMo4e4dZBgQeayRuL8YO5KUx2glKf
 8Da2IudPlFQhfk4D1dCE1LgyJnBWA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:gCcXeKq/s5gylvEpenOmAogaV5oUeYIsimQD101hICG9vPb2qy
 nIpoV46faUskdzZJhOo7690cW7LE80sKQV3WBzB8bHYOCFggGVxehZhOOI/9SjIU3DH4VmpN
 9dmsZFZOEYQWIK6PoS+DPIdOrI2uP3lpxAm92utktQcQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="46334008"
X-MGA-submission: =?us-ascii?q?MDGR8qw1nNmmPpBlYU4xlu0rCDSNigF6u/3Rm8?=
 =?us-ascii?q?lhVMGSJYLMGVbcjdlGpyPuFAqDohYnT3KdmO/0q2pjjvvBRGWHgp+DEI?=
 =?us-ascii?q?Z8kMGYJAi7xrRnWVWLbjckzJQOxVp9L4MvNjW93jEB8R1u+gzmpkdapg?=
 =?us-ascii?q?ocp/2TmlzYHjZRss81tPoESA=3D=3D?=
Received: from paleale.coelho.fi (HELO farmhouse.coelho.fi) ([176.9.41.70])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 10:41:39 +0100
Received: from 91-155-255-60.elisa-laajakaista.fi ([91.155.255.60] helo=[192.168.100.137])
	by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <luca@coelho.fi>)
	id 1pMQfQ-0060C0-EK;
	Mon, 30 Jan 2023 11:41:38 +0200
Message-ID: <e1ebf2b582bd97d42e8573471fac83578d47ef17.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Markus Elfring <Markus.Elfring@web.de>, Julia Lawall
 <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Date: Mon, 30 Jan 2023 11:41:35 +0200
In-Reply-To: <23ba4681-0b9e-cf60-5422-64526cdf462a@web.de>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301272148570.4094@hadrien>
	 <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
	 <808cd549-f96d-872d-a4db-30ea33095207@web.de>
	 <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
	 <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301281432120.2822@hadrien>
	 <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301291826510.2852@hadrien>
	 <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>
	 <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301292109320.2852@hadrien>
	 <3f376cb31e9050d005417809a9fa51d92cdc57d6.camel@coelho.fi>
	 <dc9d939d-e1bb-8447-e950-deacc7a3645a@inria.fr>
	 <13bf65ac8504fa5ebcaf69539422fcd38bf157d1.camel@coelho.fi>
	 <23ba4681-0b9e-cf60-5422-64526cdf462a@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Luca Coelho <luca@coelho.fi>
X-Loop: cocci@inria.fr
X-Sequence: 848
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/e1ebf2b582bd97d42e8573471fac83578d47ef17.camel%40coelho.fi>

On Mon, 2023-01-30 at 10:34 +0100, Markus Elfring wrote:
> > Maybe I celebrated a bit too early.  There is still one instance
> > that
> > is not matching...
> >=20
> > I currently have these rules:
>=20
>=20
> You present an additional SmPL rule.

Yes, this is evolving.  Now I'm trying to catch other instances.


> > @@
> > identifier nested_macros.nm;
> > identifier dev_priv, f;
> > expression list el;
> > @@
> > f(..., struct drm_i915_private *dev_priv, ...) {
> > 	<+...
> > 	nm(
> > +	dev_priv,
> > 	el)
> > 	...+>
> > }
> >=20
> > And then we have this function in
> > drivers/gpu/drm/i915/display/intel_display.c:
> >=20
> > void vlv_wait_port_ready(struct drm_i915_private *dev_priv,
> > 			 struct intel_digital_port *dig_port,
> > 			 unsigned int expected_mask)
>=20
> =E2=80=A6
>=20
> See also:
> https://elixir.bootlin.com/linux/v6.2-
> rc5/source/drivers/gpu/drm/i915/display/intel_display.c#L497
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr
> ee/drivers/gpu/drm/i915/display/intel_display.c?h=3Dv6.2-rc6#n497
>=20
>=20
> > Any clues?
>=20
>=20
> Can it matter to omit the search pattern =E2=80=9C...,=E2=80=9D for the f=
irst
> function parameter?

I tried it, but it didn't help.


> Will any additional SmPL disjunctions become relevant?

I don't think the problem is in the rule, since this works on an
isolated version of the function and macro definitions.

--
Luca.
