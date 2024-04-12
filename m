Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4845FC4345F
	for <cocci@archiver.kernel.org>; Fri, 12 Apr 2024 07:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=cTbP3NvdzTX8IA4KyvWvgaaRDZRoqWmZCXctjzAms4w=;
  b=O09+WPfoRd4MdPTjapwlwQ3rB7baJuGHYlr9K0nG+3XRHPQ0g4tmY1yt
   T5QmD7/PEF+oRJrzg6ISEdRA7UMvr1tnX9XqA9lzUymafz0M4F2L4Zzkd
   m9PRoWb/5FTGb/NVR/me1rhcjVqflfiCnNwW/ueAeT0K5PH/E78CA9WeZ
   I=;
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
   d="asc'?scan'208";a="161192162"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Apr 2024 09:00:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 728D3E0CCE; Fri, 12 Apr 2024 09:00:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C8B1CE0AF1
	for <cocci@sympa.inria.fr>; Fri, 12 Apr 2024 08:50:23 +0200 (CEST)
IronPort-SDR: 6618d9af_wEIy3jsYQw3hq47xr23jhXJFyfZh/cUIrC/ze9HKrRIZfq+
 DikJKx0wqZ/OsK3Pu812VkCwwPx/Cn/hOIWSGwA==
X-IPAS-Result: =?us-ascii?q?A0HEBQCk2BhmmCH+dcJaH2qBT4JEgVEwAwcISI1SiG+SY?=
 =?us-ascii?q?YsngX4IBwEDAQgFRAQBAQMBA4R/AogYIAYBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEIAQEFAQEBAgEBAgQGAQIQAQEBAQEBAQEeGQUQCgQnhW0NgmcBgQWBDQEBA?=
 =?us-ascii?q?QEBAQEBAQIBAQEiKwKBCQEBAQIBQAEBNwEECwtGVgYbgngBgjwjB7FegTSBA?=
 =?us-ascii?q?YIKAQEG3B2BWgcJgUiBV4ZKCwGBU4dreoJPhD8+iwaRDIVainZUgRkDWTIBS?=
 =?us-ascii?q?wo0CToPDBoCLw0kIwIsSgoQAhYDHRgyEQkLBx8DKgY2AhIMBgYGWyAWCQQjA?=
 =?us-ascii?q?wgEA1ADIHARAwQaBAsHOD2BfoE9BBNEA4FCihcMgzMpgVAphD9CcYQgfANEH?=
 =?us-ascii?q?UADeD01FBsoAZxUEIUxExyuXpljhB2hREkDlzCSbphionk1hVeBZDqBXDMaI?=
 =?us-ascii?q?4M3TwMZD44sDQmDWJ9aRDI7AgcLAQEDCYkigUgBAQ?=
IronPort-PHdr: A9a23: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
 7IVQ7lUEVEzGfIcB0l/HdoNZpxwW2F9+YM=
IronPort-Data: A9a23:wdAwVKJxygg9Fs82FE+Ri54lxSXFcZb7ZxGr2PjLsTEM7AuW5UVEl
 zVBCC3DeKqUMyGmS21FGNjgo0oPvcSHn4VnGwFtry8wHi5AosbIWIzGdB2hNijDIsTIRU84s
 s8VMtWcJ8s/RyeGrUn9a+C/oHIlifHQHbOU5IIoQsxUbVYMpHAJ2Uk48wJAvrNVvDSZP++sk
 Y34+MaOMQGs0jd5bjgf4Pvf8xhh7f+jtG9EsldjO60WlVKPzHN94LA3dfjgdSOgKmV3NrfnH
 LiblOnREkfxpUpF5gaNy+6jGqEyaueOe1LI0BK6YoD66jBavCs+z60nA/QVbEZTml2hkst4o
 Dl3ncXYpTwBYOuUx4zxbzECS3siZfEfoueeSZSCmZX7I3PuIyOEL8pGVxle0b0woo5fHWxI/
 PoEHzEBBjjrazWendpX4sE17igSBJGD0LE34hmM/hmFZRoSeq0vdo2RjTNuMJjcsegVdRrWT
 5JxhTOC930saTUXUrscIMpWcOtFGhAT2tCXwb6YjfNf3oTd8OB++LbrKsjIVe2tf/pQgW+kt
 Hrnr1z8Og5PYbRzyRLdmp6trurGnCe9So8PD+XjsPJn6LGR7jVCVFtPDAT9+6TlzBXlMz5cA
 xR8Fi4GsrM7t1amSNTmVgaQu3eCsVsRXdVRFeA38gCLxezf5APx6m0sF2AYMY1+75dnLdAs/
 mKzpdTgGD43jJqcc0Pe17iYkzKuNBFAeAfuYgddHVBdv4GzyG0ptTrESd1oEYaun9jtEHfxx
 SqLpW4wnd0uYdUjyLqku0LKnin0/d7FQ2bZ+zk7QEqr6BlreaGUQLaX7Efy0eRYDdahS2Ge6
 S1sd9el0MgCCpSElSqoSeoLHa206/vtDNE6qQI1d3XG32j2k0NPbbxtDCdCyFBBHutsRNMES
 FDMpkVD6YJIZCDsYaIfj2ON5yYCk/SI+TfNDKu8gj9yjn5ZLlDvEMZGPhf44owVuBJw+ZzTw
 L/CGSpWMV4UCL580B29TPoH3Lkgy0gWnDyKH8Cll0/6juHOPBZ5rIvp1nPSNIjVC4vY+23oH
 yp3bqNmNj0GD7ykCsUp2dBKRbz1EZTLLcmm8JQLLr7rzvtOBW1pDvLdwLppdIlvn8xoehTgo
 xmAtrtj4AOn3xXvcFzSAlg6MeOHdcgl/RoTY3d2VX72gCdLXGpaxPpFH3fBVeN5pLULID8dZ
 6RtRvhs9dwWFWSboG9GNMKjxGGgHTzy7T+z0+OeSGBXV/Zdq8bhprcIpyO+pHdcPTn9rsYkv
 byr2yXSRJdJFUwoD9/bZLjrhxm9tGQU0rA6FUbZAMhhSGO1+qhTKgv1kqAWJeMIIk793Te07
 VudLioZgujvmLUL1uf1q5qKlKqTKNsmLHFmRzHayZ2UKRjl+nGSxN4cceSQIhHYemDG2ISjQ
 uR33cDDbfsjo2hXgdB4DoRU87M32Ibpg7p80A5fPW7qam6zAehKOUi23shot4xMyIRGuACwZ
 Fm9x9lCNZiNO+LnCFQ0Jjs6Xt+c1PoRpCbe3c41LGr++iVz2riNCmdWADWhlw1fK+FTHL4+4
 OJ8pvMT1ROzuiAqPvmCkCpQ0WaGdV4Ecqc/s6AlEJ3ZsRUqxn5CcK7jJHfPur/XUOp1M24uP
 jOwr4jBje4FxkP9LlwCJUKU1u9Z3ZkzqBRGyWEZHGuwm/3Hu+QW2SNA+jFmXyVXyRR6i9hIA
 FZJDHEsB6uy/GZPvvNhDkSMAABKASOL9nPhk2UpkHLrdGj2d2jvAlBkB8Oz0hE4yV9MRhla4
 7CS90j9WxnIYsza/3U/SGxlmdPZXP1z8QzIp+6/Fe/YQasKXyjAroqzV0U1qj/MI8A4tGvYr
 8ZEocdybqzaM3YLgqsZUoO165UZeCqmFkdjH85z2bwvIznHWTeQ3TOuFRiASvlVLaaXzX7iW
 t1cGM1fcj+figCMl2k/LowRKeZWmPUJ2oIzSonzLzRbj4rF/ytbi7OOxC3Qn2Rxfs5Pl/w6I
 Ybvdz6vNGycqH9Xum3Vpvl/JWuKTogYVTL4wdyK3r0FJ7AbvMFoVHMC4L++knGWEQlgpja/n
 gfIYY3IxO1Dl6VouabREZt4OgblEuOrCdy08z2yve9eMvLJE8PF7D0OpnfdYg95ALo2WvZMr
 4qrjuLZ5k3/gesJYzjroKXZT6htzueubdVTKfPyfSV7nzPdecrC4Ckj2mGfKL5boewA4O2Ye
 RaKMs+tR+ErSt5imXtxbg5AGS08EIXyVL/r/gmmnsSPCz8c8A3JF8ym/nnXdlNmdjcEFpn9K
 w3ssdOs189ol5tNDxo6GP1WOZ90D1v9U68Addeqlz2nIkS3o1GF4J3OqAEB7GzVN3y6D8rK2
 5LJaRzgfhCUuquT7tV4sZR3jyIHHkRGnug8UUIMyeFY0wngIjY9Et0cFpEaBrV/sC/4jsj4b
 Q6QSloSM3z2WDAcfCjs5NjmYBykOdUPHdXEPR0swVKfbnanJYGHAYY5zBxa3VVNRmLBwt2ke
 PYkwV+hDijpl9stDawW6+egiOhq+uLCyzhasQrhmsj1GFAFDa9MyHVlGxFXWDfaF93W0n/GP
 nUxWXsOVXTTpZQdyiq8UyU99NAlUDLTI/EAaC6OxJDNtpiAlLYGxPCX1yTbzOgYdMpTTFIRb
 SqfeodPyzn+Nr8vVW8BoNsvjup5D/2KGMW3Nq7lSksZmKTYBqEPIZYZhSRWJC090Fc3Lr4e/
 wVAJ1AlDUKKbU1X17yQxAgT+pR+FHkLClklSeI5SSDuyXQE8jQSR/RmIM8X5309R2gPcni0m
 AsvUXs=
IronPort-HdrOrdr: A9a23:qM4XzKOT85pfQcBcTvejsMiBIKoaSvp037Dk7SBMoDhuA6qlfq
 GV7ZMmPHrP4wr5N0tOpTntAse9qDbnhOdICOoqTNOftWvdyQmVxehZhOOJrgEIWReOk9K1vp
 0QEJSWZueQMXFKyfrWpDO9Ds9l+tWc6qCvgo7lo0tQcQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AL+g7UmgiDs9y4My3tvsaxnbnBDJufHvH3mr/Emi?=
 =?us-ascii?q?CNmN2YYGHUX7AwKZcjJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A56mntwyErx7+Zl0LD8i3dpySRZuaqJmUMkcEjJd?=
 =?us-ascii?q?eh+6NDx0zGjiRsjWrT7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,195,1708383600"; 
   d="asc'?scan'208";a="161190309"
X-MGA-submission: =?us-ascii?q?MDH5jFRIEH2f3uT2kPWls+xAzKwR4fKyLCfulX?=
 =?us-ascii?q?uT52X94ofx/Ff7m+g0ND+4hhxVXFDBzttgKcVfAQ1uSIhlb5kILcCm2M?=
 =?us-ascii?q?cD5T7++f1oJTPoC1oibk7vR0Je71q684ZsmKkdCQbtQMGNNhCRTj54Oy?=
 =?us-ascii?q?jXejozZAJH8evAVJWvFfYPlQ=3D=3D?=
Received: from www.zeus03.de (HELO mail.zeus03.de) ([194.117.254.33])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:50:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=cTbP
	3NvdzTX8IA4KyvWvgaaRDZRoqWmZCXctjzAms4w=; b=T0FToMqVH/3kNRIjNnKY
	8sRYWTXD+TJbyeblEuumOpXeV7rkZxisCh1ujis/7qPuQCPAl16hr4lK1bD70fvl
	MfA6jdNJ25L5xbf+4HKrxdVD2+JgU4aIDmuYwcPT1tG9xtnLuYSDVgQ2GbKyGzcC
	hfQvNgyDlLlXkagmGrGs0xiiw1qZqACFq0F18UoplJyJ11tAw/fHlYKxA1dNeEVN
	L2/zxnMp/tPCsF4VI7R0N9nTl+ni9a9HPXWakLKvQLwtyABOK09QeL+KumDM3OWJ
	lRT8Ikc8LEYlxRsaihhjB3xfY60048jh6pxYTMtb5LF+ZWdXnJGpGQu+pzgTJ7qB
	qg==
Received: (qmail 1120468 invoked from network); 12 Apr 2024 08:50:22 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Apr 2024 08:50:22 +0200
X-UD-Smtp-Session: l3s3148p1@2BaPr+AViJlehhrd
Date: Fri, 12 Apr 2024 08:50:22 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Wolfram Sang <wsa@kernel.org>, cocci@inria.fr
Message-ID: <4em54bibxo6t6cjv2uifnuqpmpubrtm6htfac2iiyhp76txmh7@o6qzyvdxm5dz>
References: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr>
 <ZhhO29XtBmBkyuQo@shikoro>
 <alpine.DEB.2.22.394.2404112304250.3048@hadrien>
 <x5daefdxp7afett3nq6j56dn3t33xwl5ul7ys4xa2u2rc7yhub@nz6zhf6yhgsd>
 <alpine.DEB.2.22.394.2404120831160.3229@hadrien>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nrrxminemcyabj7u"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2404120831160.3229@hadrien>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] new version 1.2
Reply-To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Loop: cocci@inria.fr
X-Sequence: 1646
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/4em54bibxo6t6cjv2uifnuqpmpubrtm6htfac2iiyhp76txmh7%40o6qzyvdxm5dz>


--nrrxminemcyabj7u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Julia,

> In a commit in the past, someone suggested that spatch should do nothing
> if any error occurred in the treatment of any file.  I applied the patch
> proposed, but in the end it became too constraining, and I got rid of it.

Very good hint! That could be because of one bug I never reported :( I
often let coccinelle run only in my i2c-drivers directory, so this was
the commandline:

$ spatch --linux-spacing --include-headers --in-place -sp_file wet-ul_l.cocci drivers/i2c/busses

which (since ever?) caused an error:

EXN: Sys_error("drivers/i2c/busses/<my_kernel_path>/drivers/i2c/busses: No such file or directory") in drivers/i2c/busses/<my_kernel_path>/drivers/i2c/busses

I assume that coccinelle wrongly processes "." as a file when iterating
through a whole directory?

Sorry for not reporting earlier! Lazy me thought "Well, it works
nonetheless..."

All the best,

   Wolfram


--nrrxminemcyabj7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYY2a4ACgkQFA3kzBSg
KbaulQ//fUW8mKuTDalMvOzbiVpSfwvif7zQb/Sff0pxANHxF7xEmqwrSkQdgifE
Fh7QpInWQslDCFxtj/8MNHdTgIg85Pw7E5vyB0mxomYU6hjWEBWTjP7s3o8ixVv9
CBBOboAhvo419pFWxiWDh1A+Nxx7N61cuAFzmvUij3XEsTn8f4iXtSeRfuFavKKp
SsxPKv04XMWhCQ0ap0w+dgx84l+gkyil9LxexeMh2/TPuy/YBpG4b3uEPpw5Z94n
QCUb8Z9hPem08gq9J9EBa1DMKWPE5euttMhesTW9lGVdxA+czgjt/OHNtYf0OwIu
3vJzdl4X0uCAKJE1l8x6no0KZsOYBs8JwOygMdJ7BXlfmZl2CIL3r0XIe+7v8p5p
7qAcBRkN/ROi6ps22OqMpjWM1zrGpCMPbpf5HgslSzYBsZFgr6rQC80/s7XO82/v
DMu5B1COr5unIy97thwjNh9MgfGUlY7UcsmBuUjhee/aLovDPWMUh/g4VrNSSkAd
M9BVyOQG5BGyGMIH6INe3vNvYn4t2T3G48gOF0rEiafQK3o+nenoFarG5Stgyf4U
rgbfX9Lhtp91tBhvY7pUB6rMVHks/L9S031t0hS8WeVpQR/5p+5YVAk6X3lkvkQR
q9Epy4+mEx1k5dEype4g+Tk9b35Hh/stKjElLOjbSgPhnI05NDk=
=o+yK
-----END PGP SIGNATURE-----

--nrrxminemcyabj7u--
