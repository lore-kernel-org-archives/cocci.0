Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9999FC4345F
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 19:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0ual1VXj9lIi0lF2m9VbpOEMEUBW0JKRoV7Vbdr/NC0=;
  b=BTDGiFkCyLBkyywXmZnbnV3b9hMSMeweT1gd5l16pz0IoxMwOisY0NlX
   AtywPpL3Cj9Bc5bkTqXJum9lip50iMGOyeB9ll3tiKdrlYZnYTsKyLukP
   bqpo9H27JBYaxZom03ovjLWtFRwEPs7gissJ6zCUgd9w7z+gbn93Kv6ar
   0=;
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
   d="asc'?scan'208";a="161925304"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 21:29:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3B392E013D; Tue, 16 Apr 2024 21:29:53 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 59C60E0035
	for <cocci@sympa.inria.fr>; Tue, 16 Apr 2024 21:29:50 +0200 (CEST)
IronPort-SDR: 661ed1ad_mLDdMaodSbqh7+ZMyvMYkAM4jL1wdBAgk5LYgZvIy4yDwyc
 tv0q5S+zjQllobUEPt9qUORIqovxuIwT4B6Ev0g==
X-IPAS-Result: =?us-ascii?q?A0GJAADa0B5mkCH+dcJaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YJDfFUxAwcISIxzX4hvkmGLJ4F+CAcBAwEIBTkLBAEBAwEDhH8CiBwgBgEEM?=
 =?us-ascii?q?AkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEBAQEgHhAKB?=
 =?us-ascii?q?CeFbQ2CZwGBBRl0AQEBAQEBAQEBAgEBASICAQEBAQEBAQEBAQEBHQINfAEBA?=
 =?us-ascii?q?QIBQAEBNwEECwtGVgYbgngBgjwjBw2zNIE0gQGCCgEBBtwdgVoHAwaBSAGBV?=
 =?us-ascii?q?oZMCwGBU4dveoJPhD8+gmEEiCGMEY9shidUgRkDWSETAUsKMw8MGgIvDSQjA?=
 =?us-ascii?q?ilKChACFgMdGDARCQsHHwMqBjYCEgwGBgZbIBYJBCMDCAQDUAMgcBEDBBoEC?=
 =?us-ascii?q?wc4PYF8gT0EE0QDgUKKFQyDMSmBTimEfnGEHYFzA0QdQAN4PTUUGygBnGowg?=
 =?us-ascii?q?RkBgz59gUUzDUXFZ4QdjA6VNkkDg1yTVJJumGKNdJUFhgyBZDqBXDMaI4M3T?=
 =?us-ascii?q?wMZD44gDA0Jg1iFFJNBRDI7AgcLAQEDCYkigUgBAQ?=
IronPort-PHdr: A9a23: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
 BwNk+uQEA==
IronPort-Data: A9a23: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
 dvKUHusng==
IronPort-HdrOrdr: A9a23:Zdw77aAtpUcCGMnlHehLsceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+VAssQIb6Km90ci7MAThHPtOjbX5Uo3SODUO1FHIEGgA1/qV/9SDIVyYygc178
 4JHMZD4bbLfDtHZLPBkWyF+qEbsbu6Gc6T5dv2/jNId0VHeqtg5wB2BkKwCUttXjRLApI/Cd
 61+tdHjyDIQwVeUu2LQl0+G8TTrdzCk5zrJTQcAQQ81QWIhTS0rJbnDhmj2AsEWT8n+8ZozY
 GFqX2y2kyQiYD29vbu7R6d032Qoqqu9jJ3Pr3AtiHSEESstu/nXvUgZ1TIhkFMnAjm0idQrD
 CLmWZoAy070QKqQkil5RTqwAXuyzAo9jvrzkKZm2LqpYjjSCs9ENcpv/MqTvL10TtRgDhH6t
 M540uJ855MSR/QliX04NbFExlsi0qvuHIn1eoelWZWX4cSYKJY6dV3xjIgLL4QWCbhrIw3Gu
 hnC8/RoP5QbFOBdnjc+m1i2salUHg/FgqPBkICpsuW2T5Lm20R9Tps+OUP2nMbsJ4tQZhN4O
 rJdqxuibFVV8cTKblwAe8QKPHHe1AlgSi8Tl56DW6Xa53vYUi91qIfyI9FmN2XRA==
X-Talos-CUID: 9a23:Br/WuWHwj43vjGfLqmJOzWg/OOE0Y0T2526XEUKkFmNJapOsHAo=
X-Talos-MUID: 9a23:zywEhwUGn/fAxJ/q/CHwj2E6PZ4r2vqRCmYttZEfgJGhERUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="asc'?scan'208";a="161925303"
X-MGA-submission: =?us-ascii?q?MDF2PqsiuYOAa9X0EqvUE8CWpfkRkEsDfg25P8?=
 =?us-ascii?q?jvo4iQufCoxi5LqK0W6n0w/Yvq8fF+SmRNO54/h3KOlmVJGZfjUoIlEw?=
 =?us-ascii?q?ALKNW2UNo8zhx0j5jpMhUalgu+C+nxNQyOC5ylQoJv7sZ9DpdHb2+lwA?=
 =?us-ascii?q?DqCr3k/CLvUIsYp9nA4F+Smg=3D=3D?=
Received: from www.zeus03.de (HELO mail.zeus03.de) ([194.117.254.33])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 21:29:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=0ual
	1VXj9lIi0lF2m9VbpOEMEUBW0JKRoV7Vbdr/NC0=; b=CcsRNEsOQnCRnpvfXi2U
	/caGSIAWSDWG2tVe71V+C0lIX7RwihR6cDCCQ+z1UkYaGMgc6vw3IXraRoUtaJDn
	cy/U2tTANHJ+AkP5qqLAnYY5q8lgAPW0lN5rU4NAORtBbJOi3ibqMe/AkYsDu0vg
	BBIww8ml9jjRrZw8NlHATM+R6+iOcQ005Ns7EyJtjWiTY2pVSFBZAUBTb+KI4jca
	qXBBbmyvSbTj0ZCbKkodJyLqIoDlHWHHoMvpLuemZ/SDem261jP9JiiIYmK3gZqT
	6mX2NM9ItBm1pXLlTW5T2h/tNQTDDK83DVCFy/gNDfkl2K9NPkY2A4xLMmctD1ix
	ZQ==
Received: (qmail 2507839 invoked from network); 16 Apr 2024 21:29:48 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Apr 2024 21:29:48 +0200
X-UD-Smtp-Session: l3s3148p1@VXuGwjsWTJFehhrd
Date: Tue, 16 Apr 2024 21:29:42 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Wolfram Sang <wsa@kernel.org>, cocci@inria.fr
Message-ID: <ntvebql752m4fxp4whbpeuyqrg26gfoqo5tvzi7ouxxp2z5qrq@cpoe42jvto77>
References: <ZhhO29XtBmBkyuQo@shikoro>
 <alpine.DEB.2.22.394.2404112304250.3048@hadrien>
 <x5daefdxp7afett3nq6j56dn3t33xwl5ul7ys4xa2u2rc7yhub@nz6zhf6yhgsd>
 <alpine.DEB.2.22.394.2404120831160.3229@hadrien>
 <4em54bibxo6t6cjv2uifnuqpmpubrtm6htfac2iiyhp76txmh7@o6qzyvdxm5dz>
 <alpine.DEB.2.22.394.2404120857440.3229@hadrien>
 <cdn5ct3pmn3l4yuohu6ulfndv7iy3pl5ycrdgxrgrqnd6czijn@tmoibbjtofa7>
 <fa25ff69-acf1-baa0-31f-936116b3cc57@inria.fr>
 <5rctzuo7ynserxtyhsikkc4zhglcdqoysnt4kd3odethcv6f2o@2crrvxx6bx2b>
 <762b29b1-c2ba-e9e6-1054-5d4bf54b6843@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="efwjf5hayh7qaqcb"
Content-Disposition: inline
In-Reply-To: <762b29b1-c2ba-e9e6-1054-5d4bf54b6843@inria.fr>
Subject: Re: [cocci] new version 1.2
Reply-To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Loop: cocci@inria.fr
X-Sequence: 1671
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/ntvebql752m4fxp4whbpeuyqrg26gfoqo5tvzi7ouxxp2z5qrq%40cpoe42jvto77>


--efwjf5hayh7qaqcb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> requires a cd to the specified directory.  With the CDPATH variable set,
> cd to a relative path prints the full path of the destination to standard
> output.  That is collected as part of the standard output of the command

Ah, that explains.

> I can redirect the output of cd to /dev/null.

Yep, I do this in my scripts as well.

And for all current/future users: Set CDPATH, but don't export it[1].
That would also have avoided the problem. I did this now :/

[1] https://mywiki.wooledge.org/BashPitfalls#pf48

Thank you, Julia!


--efwjf5hayh7qaqcb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYe0aIACgkQFA3kzBSg
Kbazcw/8CZE/AA5xB8AbiItljx0DH5E9uNzL9XXye81mn9uDNJdYQjzRQBqnh8tV
obyplzNp6xHH2AdCzc7utL1D8JCDQiXz4S4Kc9ihXewkzyug2kNhjZTjrUVd/sgE
oT/+RcTFVi8SAgGqPpXlP98eNt1m0TIV16/duZVkGhHXwwIshYmQ0PcMGNxTJeP4
niA3r5bfXBNVAVwu22SKyQL4HnaxGTShxNwk094BPJYSIF8NVlJs0zqX3ZmBvn5C
NjszZZ3EUE9We3qJSvJx7JLIi/M6n0tJgTiOtQCMqpTe5/RD8tQHENRGl28fEkY4
kyTABKsLA9YCpc1vvKEz+LZMfQS3cUswUor3t0t4FINmeMKMMnbfob5ldjRHlUIx
1GBGauafCM85OJImonmcH6AwgxjnbVfBmOa5QwkhcgqgMldWQktZ7PTT7dNWXDEn
9fBXrwj0WP2VerKwziaQkV9rtCg5n07D2i8mDLlS/hmlZNWQDQJCVnevSpf00Np4
ExqPGycTHM+n3tiVLWGIz7xx8eU8JNXOfK+/qxWQpIfAbqa9HaqIVeks7yRhVvcF
knfCtb6X25+eSWpQdUTTA9k8c8R+JOfl2PVvVKEB9smKNmHgf37Bf1Kdy5upldy9
Hnw0wn7/Oh3PMSeIbOC0jy29ybtEGe31oBMjIAWJPsQign5udsQ=
=aLuD
-----END PGP SIGNATURE-----

--efwjf5hayh7qaqcb--
