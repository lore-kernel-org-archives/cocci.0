Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3275C4345F
	for <cocci@archiver.kernel.org>; Fri, 12 Apr 2024 06:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=e+cU6nPc+objhGhKe67fhrRVv2JfokGkvnOo8coph58=;
  b=kkrqM44moE6+evChlUq5JWajd8+YEkjmcxQhRnSecAFLbQ6/mIVvamkk
   QSZ6ERYythFeEBqgOLlrJ65tLmhT4KY62h/KEDMgWb2vaJEpU9ljZWFOW
   49FmIASAye0irDmULjuDfZCtq1XIcQVsQcz6I1uoCOhVwA+NAZdSroH6F
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@sang-engineering.com
X-IronPort-AV: E=Sophos;i="6.07,195,1708383600"; 
   d="asc'?scan'208";a="161186581"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Apr 2024 08:31:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D7D03E0AF1; Fri, 12 Apr 2024 08:31:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 16D7CE0AF1
	for <cocci@sympa.inria.fr>; Fri, 12 Apr 2024 08:29:15 +0200 (CEST)
IronPort-SDR: 6618d4ba_6jAy6t5NcjTOKlj9NV4j8vdRHHvM1gfRU8o8ZoLy+u0eX8s
 4H0X44DDtgPJ5qnf/bC8UfiKqM1HAe5m4Hp8PYg==
X-IPAS-Result: =?us-ascii?q?A0FEAAA01BhmmCH+dcJaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDgVEwAwcISIxzX4hvkmGLJ4F+CAcBAwEIBUQEAQEDAQOEfwKIG?=
 =?us-ascii?q?CAGAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBAQEBA?=
 =?us-ascii?q?QEBHhkFEAoEJ4VtDYJnAYEFgQ0BAQEBAQEBAQECAQEBIisCgQkBAQECAUABA?=
 =?us-ascii?q?TcBBAsLRlYGG4J4AYI8IwexWoE0gQGCCgEBBtwdgVoHCYFIAYFWhkoLAYFTg?=
 =?us-ascii?q?wSEZ3qCT4Q/PosGoVxUgRkDWTIBSwo0CToPDBoCLw0kIwIsSgoQAhYDHRgyE?=
 =?us-ascii?q?QkLBx8DKgY2AhIMBgYGWyAWCQQjAwgEA1ADIHARAwQaBAsHOD2BfoE9BBNEA?=
 =?us-ascii?q?4FCihcMgzMpgVAphD9CcYQgfANEHUADeD01FBsoAZxUEM4hhB2hREkDg1wBk?=
 =?us-ascii?q?1OSbphionmGDIFkOoFcMxojgzdPAxkPjiAZg2GfZEQyOwIHCwEBAwmJIoFIA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 bILQ75fEk44C+hCUQJpEY5bSKo=
IronPort-Data: A9a23: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
 Qov
IronPort-HdrOrdr: A9a23:VZqxY6AIWoRe6gDlHema55DYdb4zR+YMi2TDGXoQdfVwSL3/qy
 nOpoV96faQsl0ssR4b9uxoVJPvfZqYz+8N3WBzB8bHYOCFghrLEGgK1+KLqVDd8m/Fh4tgPM
 xbAstD4bPLbGRSvILHzU2DF8s4hOOK6rqpg+C29RtQcT0=
X-Talos-CUID: =?us-ascii?q?9a23=3A/R04/moPguZOEIPGSurWVEzmUc0aVGHDjyvPGn2?=
 =?us-ascii?q?fMH1AapiVQHG5+ooxxg=3D=3D?=
X-Talos-MUID: 9a23:2ReQpgYcgODij+BTqh2xoG5YbstUva2FAVxXtZg245mbHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,195,1708383600"; 
   d="asc'?scan'208";a="161186223"
X-MGA-submission: =?us-ascii?q?MDH3IqsTfi8Ryuf4UhvsdOmHw2B4bwy/KVCwVp?=
 =?us-ascii?q?Mf3yMtt0kqvnL7ZuwPLfH0A3v2wTQI6EUodBB3HEmwINSv9rW1NpOc44?=
 =?us-ascii?q?mb7ZOOJ0IB+/fRb30lq3E5auRNL5YHekgZGZWQc7OWjeoewy7affjTT2?=
 =?us-ascii?q?tUpNL24XiSWIND9Rb8qrkqaA=3D=3D?=
Received: from www.zeus03.de (HELO mail.zeus03.de) ([194.117.254.33])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:29:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=e+cU
	6nPc+objhGhKe67fhrRVv2JfokGkvnOo8coph58=; b=HirhhJDswvYJDUcuq3wY
	2olw/2mNQ6hSk8bRNOxa9j05YKbfh6O92qzxrbx1x9LVjWdF2nZaMQqc26YHFDMC
	NYUvqfu1xbzeVI56SA+0MWkboUDeHAmi9b07w3JSdsQWiBgpS7DQjrhhxK3SbC0o
	Tgu6hO+JTwo4Jl3Miz68OJ8fSsMrhfLxPDHa1rxOcrcO4KOxYc3wKnseSEyZuS5C
	qbem+my+FIXFpG70sAfF2J7KuFUlkFvyOEqotkXCkaNKRoe/7nSSfDMkgAiwbKtI
	LSH8v1pPbrJWnBd4cOnceUYFZ9Tp/E/CHV0orkH171E77PZlVMI8N9XL/OJBAzqM
	cQ==
Received: (qmail 1115149 invoked from network); 12 Apr 2024 08:29:13 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Apr 2024 08:29:13 +0200
X-UD-Smtp-Session: l3s3148p1@Co3oY+AVsJNehhrd
Date: Fri, 12 Apr 2024 08:29:12 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Wolfram Sang <wsa@kernel.org>, cocci@inria.fr
Message-ID: <x5daefdxp7afett3nq6j56dn3t33xwl5ul7ys4xa2u2rc7yhub@nz6zhf6yhgsd>
References: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr>
 <ZhhO29XtBmBkyuQo@shikoro>
 <alpine.DEB.2.22.394.2404112304250.3048@hadrien>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l4vazdscpyl3tc7s"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2404112304250.3048@hadrien>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] new version 1.2
Reply-To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Loop: cocci@inria.fr
X-Sequence: 1643
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/x5daefdxp7afett3nq6j56dn3t33xwl5ul7ys4xa2u2rc7yhub%40nz6zhf6yhgsd>


--l4vazdscpyl3tc7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I tried spatch test1.cocci test1.c --in-place and it worked...

Thank you, Julia. I'll try to debug...


--l4vazdscpyl3tc7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYY1LQACgkQFA3kzBSg
KbYD4Q/6A0c7PZtHDZGAEoe8u0lZe/chBPKWdwhXArv8xgLe240scBgOGM7GBIux
w6uE3JKJPM1WWkV7CTLjZ9omy6YNYoDhOnHHq0Yurgke52cX2wNtTav1+fry+hdJ
45WqESkzh2xy4IsZUdbJQ26IOIJaBS2eMPZc/BipF+Vsru/sEQeEBLpE/5C3mu+n
KryCJZKoKTFI4xmSbxs1ojemws1gW3OQ+zTFSDZRig/PoZ2zp3AsL+wVaT3r4W5S
axyobkglmZMbVHtMdMe98S3Q1ktRX1CVvk9M3IhonNSyKQ/BIDKJXWaap7mpdCBe
pDE16iIzD6T1rf6AvkfY9ABud/K2NC0h0sYmNgAFDuCYlCBgjLKLSw620/dre6m4
yZPAm2jXVhwtWLKh5X5dMDXIseELGEE2QfGk/FTxaBjEmEZ1iELnagobMeEGiJs3
Y9Uj98L9YCtjKM/VSuw/Q9Gzdl4GgDtqwH7GzqryGJQZID1sryKYTP4t+ldi9E59
UY+3ssDMz8peBdQNgZFAQ5d/gf1qFVD8qy3zWXH3moAzwvKsG0kCtWIilVYXmibB
9yCgC8Gr/y+RiGlaZ1fwZLh0pQF6W48CfID4nDWJCydnN7MJ2hcAESoFEiBDQfnO
YCDI9XIHHcYNRfV9KEQpiVymdjbjWDNGn0AiWRDgyMWL2a8ldgM=
=0UYo
-----END PGP SIGNATURE-----

--l4vazdscpyl3tc7s--
