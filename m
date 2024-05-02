Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBE3C4345F
	for <cocci@archiver.kernel.org>; Thu,  2 May 2024 09:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=8o123koDaahzzjjwiyO+4CzVS4dKk0lcFOegpO2G/c8=;
  b=ORYJRzL7HVQ5lM6+6ZFknJn5LqEyLHW/2F/XwOcUlguQ2xJJoy3uJC7V
   8sunfAK2NaqzR5dq4yi5ccKZgg2oo5K8e5cqnXILKBzbxJzDYtiunOLB+
   wCOrI3DxZlDfI0dOyYN+H6OhIL5JV7h2iSVOD9MDNsoz+QiL6Icii5QQm
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@sang-engineering.com
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="asc'?scan'208";a="164179826"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 May 2024 11:01:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2077CE0145; Thu,  2 May 2024 11:01:24 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 96CFEE0035
	for <cocci@sympa.inria.fr>; Thu,  2 May 2024 11:01:20 +0200 (CEST)
IronPort-SDR: 6633565d_fCx8Bznp7YVz3dkSRwRbYQHkLl72J5OSk1Y5FSOxlYdz5hb
 uyAACrEeQrjh4KtrZIMFLQyimRvQZYmoyKhRV+Q==
X-IPAS-Result: =?us-ascii?q?A0G4AACjVTNmkCH+dcJaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYJDgVIxAwcISI1SiG+SY4VMhVuBfggHAQMBCAVEBAEBAwEDhH8Ci?=
 =?us-ascii?q?C8gBgEEMgcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEBA?=
 =?us-ascii?q?QEgHhAKBCeFcA2CZwGBBYENAQEBAQEBAQEBAQEBAQEiKwKBCQEBAQIBQAEBN?=
 =?us-ascii?q?wEECwtGVgYbgngBgkEjB7gZgTSBAYIMAQEG3B2BWwcJgUgBgVaGTAsBgVOHb?=
 =?us-ascii?q?3qCT4Q/PosHlASFZkGDeYgiVIEZA1khEwFLCjVHFgIWAxsYMA8JCwcfAyoGN?=
 =?us-ascii?q?gISDAYGBlkgFgkEIwMIBAMQNAMgbxEDBBoECwc4PYF8gTUEE0QDgTiJfQyBf?=
 =?us-ascii?q?YE0KYFOKYRsbIQLgXgOYoNhggsdQAN4PTUUGygBnlswhlKzDpUDhB2hQ0kDg?=
 =?us-ascii?q?1wBk1OSbi6HWJBconqGDYFsDCeBXDMaI4M3TwMZD44gDA0Jg1iZQkQyOwIHC?=
 =?us-ascii?q?wEBAwmJIoFIAQE?=
IronPort-PHdr: A9a23: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
 pVIQbheBgRd/hIyD01kGJoQLYpsBmhinbPJ1aY1
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:BvOYbKgts2f1wo87gIAi5rcHdnBQXuwji2hC6mlwRA09TyVXra
 CTddAgpHnJYVcqKRYdcLW7U5VoLkmyyXcY2+cs1PKZLXDbUQiTXeVfBOnZsl/d8kTFn4Y2uJ
 uIMZIObeEYZmIK7voSjjPYL/8QhOWrtJqtmP6b9Xt2VwFtbMhbgztENg==
X-Talos-CUID: 9a23:EIEjp2CGM9IQyx36Ey9uyFQ+F+I3S1jQwCjJH3OVKUwuYZTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A4bMnfA+nxrOsXO+ZjvZL49SQf/tW2/2nBmADqrs?=
 =?us-ascii?q?bhM+fFXQzOHCg1g3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="asc'?scan'208";a="86201430"
X-MGA-submission: =?us-ascii?q?MDG2dEM05CUdE92mNX/WJSxwclWio8ebpz+OdQ?=
 =?us-ascii?q?bx/03yg6iyFMVOymwd2AhOa10ca0/aLZYJlCsWS6eUa7KMhJUA7hirrl?=
 =?us-ascii?q?0j49l0iZywDo9Fu+zWXGFOOHEjJdhM6xBlHrv8KhtTxGvXnEpMrgvA6j?=
 =?us-ascii?q?pt5g3fsYRvXPy6CAJeZU9CCg=3D=3D?=
Received: from www.zeus03.de (HELO mail.zeus03.de) ([194.117.254.33])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 11:01:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=8o12
	3koDaahzzjjwiyO+4CzVS4dKk0lcFOegpO2G/c8=; b=K9DZePT6k5gi4JCyYCHa
	UYxd/hZXEehjCRcBGjKXtgw213D4oQ1ygy188f7Eoog5vxsk2L2F3rvZRymn2MQC
	t57qBDDx+wLEz5TKk4FRaXzzYiFUmCuUmPCTZDYPSq8xAwQyRENhwBOgCAgLFAbg
	UuFsQcjFqfbd4N/cId5GUysi5qrId130xaq/ME7VbkXHBLDygI3d7bVkfhrY+RZv
	9LwECj3d846MRRRAubLpWDP0liwI7NBKEfafxH5iEqEtuhpQuWFY+2FuafWnJzYt
	I98QjXAN+M621AkK8sS13u4Q/9QkqqAMatYMyAXuOgkJdC+PxEDr0CB5+zQZtfh6
	Gg==
Received: (qmail 3173215 invoked from network); 2 May 2024 11:01:15 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 May 2024 11:01:15 +0200
X-UD-Smtp-Session: l3s3148p1@5uFq2HQXPqRehhrT
Date: Thu, 2 May 2024 11:01:14 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: cocci@inria.fr
Message-ID: <4vbt6ijjdgqd23lyqgkydqvzvhqeq37a3uqmxvif3amur3ei7z@lokx6uszecfy>
References: <20240502085433.GA30267@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w4m7vkocc3wedcb2"
Content-Disposition: inline
In-Reply-To: <20240502085433.GA30267@redhat.com>
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Loop: cocci@inria.fr
X-Sequence: 1677
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/4vbt6ijjdgqd23lyqgkydqvzvhqeq37a3uqmxvif3amur3ei7z%40lokx6uszecfy>


--w4m7vkocc3wedcb2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rich,

> Is this a known issue?

I can't confirm. On my laptop from 2017 (2 cores, 8 GB RAM), compiling
=66rom latest git (after 'make clean') takes 90 seconds.

OCaml: The OCaml toplevel, version 4.14.1
Menhir: menhir, version 20231231

Both from Debian Testing.

Or did I miss a step?

Happy hacking,

   Wolfram


--w4m7vkocc3wedcb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYzVlIACgkQFA3kzBSg
Kbakzw//YkCvg+g06C9M3MIn45yjEEmFvZ10pvEbJ8o/DH8+gKPKN9gqpweu/Daz
G21BA93FdSwDivBEDtdNe8mkMR7htt8IzJniF7mIXCAmfDc6ASnkObEWnIRKlQsw
ENcKWP/8acIyyAbtk12pkjwFowJDil7jF726BlwWTbn069qdo4vQzVY4NxxUv1ta
sWCQwCymwftRJNoH4s/wgrW48bNqzggtNQhGNJywc4MwKdqtX7Fu3tXLdscLQQo9
jv8IpmZqFwRKzne+uitNwyeO//divLXE9gume97E7G1OM6tYO8ADp5N5y3J1k2xB
qBHc2xDELxRzXseCi+rrHwDZS8Fx0gh4AiK6+0PlFpUheUsGN/WL7LtPtXpvGVtM
WxndUhPHd/Zyun/Kj55rlvHNe7CIpDUIhHvDu2BWdVhquWBFvfMOSL9LmKQeEyhC
a1vwOzAXYCKoJNEcMoeCbh0g3bf6U1B7nkXyS3ze2zxKN8U5GI3v26hsuaqpVJcc
HICM4n273GTtdt+fymLzt8JVOPWks4HOfH7yahpRE2+fKfMg7VFHp8I9qGYmh8b9
mU7mVsM08t5p9NH/a0fT5t4Ad6GS/1AdR7dpIx5M5Q7p1oxkDVQ+F+oXVSpikDWV
2nGJ5L3C+cXmBkQ9wAWAiUj7ncCZTLR7QJw8Sys9MsylAekBLcg=
=oQJ5
-----END PGP SIGNATURE-----

--w4m7vkocc3wedcb2--
