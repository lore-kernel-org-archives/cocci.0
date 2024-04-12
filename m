Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304B0C4345F
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 12:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=iFecdicIWoqWHNlvSwayziWDvP8qsP7PlVvJvbUPyoI=;
  b=YcYlWQid3ulGdjgVKDjCQbLO6QNbH0q8UQOkcFghY3JmLXgHERc+Hz6e
   Q/vXZXB7kfhgxRU3JzOoRfxTX48atFCoK8+OUhVlXcfkNnRgDL7YxmHEy
   cS6MmJEzEwJkT0EVnT2tk/WrS19QN4WeQ/Ryug3HvtiElWmW7tJBOCIoc
   4=;
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
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="asc'?scan'208";a="161851012"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 14:14:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 750FCE0133; Tue, 16 Apr 2024 14:14:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8767AE004E
	for <cocci@sympa.inria.fr>; Fri, 12 Apr 2024 10:23:18 +0200 (CEST)
IronPort-SDR: 6618ef75_FIw4gyePwqT/lLHm0C8j3wDn3kWbi/syqTjrETSMA2I4Quz
 WAG5+tXSL5FuWv4Kx7I57KaVMmcBls7YUY7jGSg==
X-IPAS-Result: =?us-ascii?q?A0FTAABT7hhmmCH+dcJaHAMDBxYEBEKBOwcNAYJDgVEwA?=
 =?us-ascii?q?wcISI1SiG+SYYsngX4IBwEDAQgFRAQBAQMBA4R/AogYIAYBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBAQEBAQEeGQUQCgQnhTsIK?=
 =?us-ascii?q?g2CZwGBBYENAQEBAQEBAQEBAgEBASIrAoEJAQEBAgFAAQE3AQQLC0ZWBhuCe?=
 =?us-ascii?q?AGCPCMHsWGBNIEBggoBAQbcHYFaBwmBSAGBVoZKCwGBU4dreoJPhD8+iwahX?=
 =?us-ascii?q?FSBGQNZMgFLCjQJOg8MGgIvDSQjAixKChACFgMdGDIRCQsHHwMqBjYCEgwGB?=
 =?us-ascii?q?gZbIBYJBCMDCAQDUAMgcBEDBBoECwc4PYF+gT0EE0QDgUKKFwyDMymBUCmEP?=
 =?us-ascii?q?0JxhCB8A0QdQAN4PTUUGygBnFQQh1zGRYQdoURJA4Nck1SSbphionmGDIFkO?=
 =?us-ascii?q?oFcMxojgzdPAxkPjC6CC4Nhn1pEMjsCBwsBAQMJiSKBSAEB?=
IronPort-PHdr: A9a23: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
 ZwBS7lWWUY0EPxcAUNgToRqHQ==
IronPort-Data: A9a23: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
 O8uUXus
IronPort-HdrOrdr: A9a23:nA+uPq+XPKbKmNW7+Vxuk+DuI+orL9Y04lQ7vn2ZhyY0TiW9rb
 HJoB17726StN91YhodcL+7V5VoLUmzyXcx2/hpAV7AZniDhILLFvAB0WKK+VSJcUDDH6xmpM
 JdmsNFeb7N5DZB7PrS0U2FPpIbxMSftJqln/3fyXAFd21XV50=
X-Talos-CUID: =?us-ascii?q?9a23=3A6p1mbWnG/EPsjI2dy8vci36dFHvXOS3bnFfLJ3e?=
 =?us-ascii?q?/M0RkepvOTkSppfpmj+M7zg=3D=3D?=
X-Talos-MUID: 9a23:y5CeIwhs7vNWbwifzXyZjMMpCuUr5eOVEmE3ypw0qsahay8vHSi8g2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,195,1708383600"; 
   d="asc'?scan'208";a="84574248"
X-MGA-submission: =?us-ascii?q?MDH7KKUoPa/R0k5Hr/V6ibnsSZFU1TYytKBI+J?=
 =?us-ascii?q?fyjrAmRV7gZESatUXiMvBeod3/8NQFT+qhugluynuGSIhLpn2WBWxZ2p?=
 =?us-ascii?q?tQXc9cT+5bBjHdbB+JeRjswhJ5p7psrDK7dnJun5a+A5QMsTwmxu0kiS?=
 =?us-ascii?q?EXwpiDs0iXbnXZyCcOpOkoDg=3D=3D?=
Received: from www.zeus03.de (HELO mail.zeus03.de) ([194.117.254.33])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:23:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=iFec
	dicIWoqWHNlvSwayziWDvP8qsP7PlVvJvbUPyoI=; b=ZAooxSXa/8QaXFgjuY3u
	3fRHNCPTslvif44VfdGCX8q0JsNaFBH+7R8mOhYrIK3PjZmFRyNVf3MXpINV32Zd
	lTLqw3xP/fCNgYuLGwcsaHtThqRYjh32ozHfrnOCNDMxaxBeOre7Wu9OcJ2pOPdZ
	FysbMMs+eDxhI1uQMtRO+b8Yj7/8rCAVLqn5mOonxVhSWF81r1jx/6zVIDCTJiCq
	y8YgNTzrMd3q7XD8XiFJy7wuljZC8mLix7JHGXWoXFUutW5/CPqbWFn9omQzTitR
	0O8OV0gPCDt+yV8TJLKjYyTlpu+Ua7Yf4XlTgScgJuJ1amWQR88MIlrK4W/Ua1b7
	Lw==
Received: (qmail 1147153 invoked from network); 12 Apr 2024 10:23:16 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Apr 2024 10:23:16 +0200
X-UD-Smtp-Session: l3s3148p1@gKbG++EVnpBehhrd
Date: Fri, 12 Apr 2024 10:23:16 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Wolfram Sang <wsa@kernel.org>, cocci@inria.fr
Message-ID: <ah7vkz72r3f336kerqzr4w7plrmsoakivd5ys6wej3wienmsvw@jnxgnv26jpoh>
References: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr>
 <ZhhO29XtBmBkyuQo@shikoro>
 <alpine.DEB.2.22.394.2404112304250.3048@hadrien>
 <x5daefdxp7afett3nq6j56dn3t33xwl5ul7ys4xa2u2rc7yhub@nz6zhf6yhgsd>
 <alpine.DEB.2.22.394.2404120831160.3229@hadrien>
 <4em54bibxo6t6cjv2uifnuqpmpubrtm6htfac2iiyhp76txmh7@o6qzyvdxm5dz>
 <alpine.DEB.2.22.394.2404120857440.3229@hadrien>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x6pm4xelfk5zhhg6"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2404120857440.3229@hadrien>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] new version 1.2
Reply-To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Loop: cocci@inria.fr
X-Sequence: 1657
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/ah7vkz72r3f336kerqzr4w7plrmsoakivd5ys6wej3wienmsvw%40jnxgnv26jpoh>


--x6pm4xelfk5zhhg6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> then I went to my linux directory, and I ran:
>=20
> spatch --linux-spacing --include-headers --in-place -sp_file ~/misc/wet-u=
l_l.cocci drivers/i2c/busses
>=20
> and all worked as it should (diff output plus the same output from git
> diff).

I took your same spatch and ran the same commandline and got no output
but still the same sys_error. I have a train travel ahead of me. I'll
try to find out what is so different on my system. For the record, I run
Debian testing, but the sys_error was there for a long time for me.
Alyways Debian, though. And mostly coccinelle from Debian. I just
switched to the top-of-head self-compiled version.


--x6pm4xelfk5zhhg6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYY73AACgkQFA3kzBSg
KbbDXA//fLxff5Jxeol/P7clGGvS5zzCRkyBpSb5lCR34vM0qPlLrVrraQzhjBkU
hlW4+V6fdUa4VWyN/fslJcKqbTyyOj5MNyGPgAbJxLx1QBugt6xcIX0ZTUGVBiIz
f+m1hrwqEf2EnFcFJRBX2CkHs5zqXT2DRUtT4y55R7ahPuVJSEEuTAILdYuAJdHV
4HGEV6Dp1VY3T8+qtAD+zZZsytih6R3ouJvNK8cF6mCnXB2Z08pO3whRjHSTfrE6
pcvvL3hn4t4y+tIhKdUzgkUfD3fYwVGnPi1wyOcRHFZfYlK/I5neDlPaOEqr+Ytr
1axHrxOC5jmPMeYWge7oobbE/TMEydyrytiWRkWwf9Hdo2xjuvoZMr5Jbb8h6pgD
abkgQ2ShK7v4CTZll6SFunOsVX/6n3bKeCKYyoTfc5F53TD47N3KjbpNRY2I1H6u
NSL5gDchn9JeEQswyQlNHJ12M5IQxKlbK3jYvvNP4IZZgCf9q0FRyUdTFlrzqVEi
sDy8LDgWROn1Zs0E+FJd/aE5TDr7y/6rLPz6Fp908M4nngfB36NG7q2pb5qOf0tp
ypQTNr0les+25cYF6zdsErykos5bxR8ipR4OwNeH/dSdiWWNNTShm/7WNWa7csx9
MTuVrgYXWMS9CU6KKt7T+vsm3ScY7RT5qZkLSrSQgLPb14wdByk=
=54UF
-----END PGP SIGNATURE-----

--x6pm4xelfk5zhhg6--
