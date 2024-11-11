Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F102D3ABCE
	for <cocci@archiver.kernel.org>; Mon, 11 Nov 2024 16:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5PIFLMUMfC6yOv4D/rghJ1AanKRpuk8Fl4hqQI/P+u8=;
  b=nj1v85iAL6+R6abZ0vdZO/sgmnRQsb5kdk3NH/x9QAznTpgXmajmPCYh
   SaiuboZjd/JT9yuH6fomhhqSbLMMjKJJfdzTo6FqWcf187KtSeATCpKUC
   I4kz2SDhhRTndEd5yqusA0pNn8Y9i6u0uz4lEq3XKpP2LgxxE7cx8KiVr
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="asc'?scan'208";a="193197052"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2024 17:24:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 86DB0E0D1C; Mon, 11 Nov 2024 17:24:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2C2A5E00B7
	for <cocci@sympa.inria.fr>; Mon, 11 Nov 2024 17:24:17 +0100 (CET)
IronPort-SDR: 67322fb0_wRjOLkZNCaaC8wQrsJTacFh3H7/aGwoflw8h2bycyLH/Fq7
 T2wAFN44zI2eZS20uOOpfPr3m0DaVKL2ATfldtg==
X-IPAS-Result: =?us-ascii?q?A0EzAACDLjJnhY4kQ7laHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkOBVzMEC4UeiB1fiDBFEZwugVaBfggHAQMBCAVCAgQBAYITgnQCi?=
 =?us-ascii?q?jsCHgwFKwkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQ?=
 =?us-ascii?q?EmGCIJiAYQAAQEBAyNWEAsYKgICVgaDFAGCZAcBsEOBMoEB3jOBXRCBSAGBV?=
 =?us-ascii?q?4QSgkgPCwEFbWiJBicbgUlEgRWDKj6IHjqCDSIEgkOFHCWJFZhZUoEXA1kyA?=
 =?us-ascii?q?UsKExcLBwU4cSIsA4JRf4E5gVEBglVKSoM8gV4FN0mCSmlNEAMDAwMDGAINA?=
 =?us-ascii?q?jaCDxVeH4JPhR2BC4Nkg06BGYFyMR1AAwttPTUUGwabGwhKgRyHZAEKyRaEJ?=
 =?us-ascii?q?IFjDIMAnFBNE4NeAZNbkwCYd6NOE4VCgWc6gVwzGi6DLU4DGQ+OOskvQ3ACB?=
 =?us-ascii?q?wEKAQEDCYVpE4k7gUsBAQ?=
IronPort-PHdr: A9a23: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
 kxt4jY=
IronPort-Data: A9a23:ChgnYq1zLXX0cvOMSfbD5ax6kn2cJEfYwER7XKvMYbSIYQITYwd3j
 TtIBzjCf73ffDO2KOnCW/2yph4AsMOAztc3HgE++ysyEC8V9pGYWt7FJxv+YS/Dc8OTHRttt
 pkSNNXJfZ9pEieNqkr3b7W/9nAmhfvXTOaiYAKo1lidYCc9IMt2oUsyxobV+7JVvOVVIz9hm
 Pv78p2HYAf5hmUlOD0e4fvZ+EMw5K77sWNFtFA1aK0V5nbTxiIfZH49DfHofiGgGuG4PcbjG
 r2dlOnhlo/9101wYj9wuu+jKiXmepaLYU7UzCA+t5GK2nBqvjY13rswKM0SYEJWjyTht91qw
 b2hj7TpIesSFvOKwb51vyVwSXkkYfQfoeafeBBTjOTKp6H4Wyu0qxlRJBpuVWEo0r4fKX1D8
 /UeNAcMYnir7w5h6O/TpkFE36zPHeGzVG8tkikIIQLxUZ7Kdav+r5Divre06tufavdmRp4yb
 +JBAdZmgY+pjxdnYj/7A7pm9Auka+WWn5S1Zzt5qIJui1U/wjCd35DWD8feYoalbvlc3Wuo9
 m/Erzv8MzwFYYn3JTqtqhpAh8fKmj7nANhUDLqj6vNtxlGeroARIERGCB3l/r/i1AjnB4g3x
 088okLCqYA39UerQ93wWhSivHmCszYBQNdKCKsh7xyXwafa5ByWCy4CQyIphNkO7ZdvH2N6j
 ADV9z/vLTxdtfqfd3uCzIqzvBWfMxBWd28nSxZRGGPp5PG4+NBp0UKSJjp5K4a+idb+GBnr0
 jWSpW4/ga8ShIgFzc2GEUvvhjWxusCTCBYy/RnaWSSp42uVebJJeaST1kXQ9axvB7qQDXSx7
 HUGy5eb3c0RWMTleDO2fM0BG7Sg5vCgOTLagEJyE5RJy9hL0yD7FWy3yG8nTHqFIvo5lSnVj
 Fj7lS452XO+FH6tcLMvOcSpDN82wK+mGdmNuhHogjhmPcIZmOyvpnsGiausM4bFyxZEfUYXY
 sfzTCpUJSxGYZmLNRLvLwvn7Zclxzol2UTYTo3hwhKs3NK2PSHOEO1bawbRMLxit8toRTk5F
 f4Bb6NmLD0BCYXDjtX/q+b/0HhTdSJnbXwIg5YOHgJ8HuaWMDp5WqWOke5Jl31Nh6NOiurPt
 nz7WQkw9bYMrSOvFOl+UVg6MOmHdc8m/RoTY3d2VX72gCdLXGpaxPxEH3fBVeJ8rLQ7pRO1J
 tFZE/i97gNnE26Yp2pFMcOh9eSPtn2D3GqzAsZsWxBnF7YIeuAD0oaMktLHrXFXUniEpoElr
 qe+1wjWZ5MGSk4wRIzVcf+jhRf593QUhOs4DQOCL8hxaXfc1tFgCxXwqfsrfOAKCxHInQWB2
 yisXBw3mOjqoq0Oyufvu5yqlYmSPtFFLhJoJFWDtbeSHgvGz1Wn2r5FAbqpfyiCdWba+5eCR
 ORyztOlO6c5jV1b7ph2SIh6/PgA4tG0hblo9Vl5LkXybnCAKLBpEl+Z1+Zh64xPwb54v1Ote
 0Sto9N1B5SACPnHInUwejU3S/uk/u4FvAXS4dAeAlTI1AUu8JWpCUxtbgSx0gpDJ75LAaYZ6
 OYGuv9OzTegixAvY+20vgoN+0uidnU/Arga7LcEC4rWiy0u+FFIQbrYLgTUuJivSdF9AnMGE
 w+uppjppupjnxLZUn8JC3Ly8/JXhs0OtDB03VYyHQm1teSftMAn/i960GoRdRtU/CVlwugoG
 2lMNm9JH4us0QpspvB+WzGLJ1kcKjyfolf82nkYpl3/FkOIbFHAHEc5GOSK/X0azV5iQyhmz
 Omm71jhABnXf5DX/yotWERaheTpYv5v+ybjxs22PcS3MKMrQDjig6OeQ24DrT76Cplg3UbCg
 +1Y+bdhW/fGKCQVnfUaCpab55sUWhurNGxPetA/3aIrTEX3WiC+5iiKEG+1IvhyHv3t9VSqL
 uBhPedNakiO7zmPpTUlGqI8Gb94s/o37t4keLmwB2o5n5aAjzhu6rT8yzPfgTI1ftBQjsoNE
 IPdWDacGGi2h3EPuWvsrtFBC1Woc+s/ewzw8+CkwtonT6tZnrlXTngz9b+os1G+EghtpUuUt
 TyeQZ7m9bVpzIA0krb8FqlGOR6PFuryc+a16yG2jcVFaILeEMXJtj5NkGLdASZtAeIzVeh0x
 JO3i/ym+GPevb0zbXLVpInZKYlN+veJfbR2NuDZESBkuBWsCe7W3gs72mGnKJZ2vstXyeu5S
 iCZNsahV94ndO1M5X9SaiJhQk8RJ43mSqHKuyjmlfCGG0Ue4zfmN/Kiz2fiNktARx8LOrr/K
 w76gOmv7dZmt7ZxBAcIKvVlIp1gKnrxcPMCW+yqkAKHH0+Ugl+mkZnzpyoKsD3kJCGNL5fn3
 MjjWBP7SiWXhIjJ69No66pJoRwdCSdGs9kaJ04y1YZ/tGGnMTQgM+8YDJQhD6NUmAzU0LXTR
 mnETEkmOBXHcQV0SzfOy/W9YV7HHc0LAMnzGRIx9UDNayuWOpKJMIE8ygheuUVJahnR58D5D
 +oB+0/AHAm7mbBoYucx2saVo8lawtHi+3ZZ3nylzuLTBU8SD4xfgTYlVEBIWDfcGs7AqFTTK
 CJnDSpYSUW8UgjqHdwmZ3dRHwoDsSjyyykzKx2C28vbp57R2dgoJCcT4A0v+uZrgAU2yL8yq
 bffQmyQ/zjMnGQUorckvJQljMeYzB5N8teSdMfeqc86xslcKVjL++sfhicVV4c5/xNFGF7Tk
 SOj7j44CVjtxIV5xuiN0QtQk35ueilkMtwK5TITYRfbihEj1J7CfAWwxw/1Lov/pu7lslkwr
 PL+qqqOiwX+iQYIbgWSehjWSpJrzC3R+bT5vvgUc67P
IronPort-HdrOrdr: A9a23:AhqzT690G2PVGhUk6Zxuk+DRI+orL9Y04lQ7vn2ZhyY6TiW9rb
 HLoB17726QtN9/YhwdcLy7VJVoBEmskqKdgrNhX4tKPjOHhILAFugLhuHfKn/bak7DH4VmtJ
 uIHZIQNOHN
X-Talos-CUID: =?us-ascii?q?9a23=3AFbbXTWvfLKpbzKzJNID+IU8F6IseTWDW1C3/CHO?=
 =?us-ascii?q?xSktZGLCXGQCVyY57xp8=3D?=
X-Talos-MUID: 9a23:deMqowl+BolYnSuZ60bhdnpiBsIv6ZqnF3owtoQglsO8dnZwHhmk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="asc'?scan'208";a="101278274"
X-MGA-submission: =?us-ascii?q?MDGHBfVYs4Agp/pm7+kTnTvD9VSIIu0tJTmo12?=
 =?us-ascii?q?rPYo1uy9KE0KdYuap0YaCBbWoVZC4uQ5wXOCTrS+cydDq+3mHqByE81F?=
 =?us-ascii?q?8Y3wcs/ZhCpR/EwjYv3TolTf78cpz5GHN53Fwh8EJUq0v56X8W7ZFwGw?=
 =?us-ascii?q?1Axp67CppN9fIBOkx18rO/vg=3D=3D?=
Received: from mout02.posteo.de ([185.67.36.142])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 17:24:16 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 282F3240101
	for <cocci@inria.fr>; Mon, 11 Nov 2024 17:24:15 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4XnFHL4VDSz6tvw;
	Mon, 11 Nov 2024 17:24:14 +0100 (CET)
Date: Mon, 11 Nov 2024 16:24:13 +0000
From: Michele Martone <michelemartone@users.sourceforge.net>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Message-ID: <20241111162413.GD10291@localhost>
References: <2406a49d-1609-4af1-9af9-ee3496e48606@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <2406a49d-1609-4af1-9af9-ee3496e48606@web.de>
Subject: Re: [cocci] EBNF for Coccinelle file formats?
Reply-To: Michele Martone <michelemartone@users.sourceforge.net>
X-Loop: cocci@inria.fr
X-Sequence: 1987
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241111162413.GD10291%40localhost>


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20241109@14:14, Markus Elfring wrote:
> Hello,
>=20
> The Coccinelle software is using some customised file formats.
> Will grammar descriptions become available as extended Backus=E2=80=93Naur
> form for involved input files?

Such descriptions would have half a thousand of productions
and still be incomplete, because missing token-level
manipulations, which escape that notation.

Would that be desirable?

Can you point to a project serving as an example?=20

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQdu1Va6jWbiq8Ma4jg5mnI7xJYuAUCZzIvqgAKCRDg5mnI7xJY
uIGRAJ9WX7JkpVK6WWGFiIgDUjVgrrudAACfcf3ToofjfVIa0G7DKR5E+kKgOqE=
=RGGl
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
