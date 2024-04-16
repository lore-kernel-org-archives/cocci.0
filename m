Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6C3C4345F
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 12:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=SNLFDDQWGCZfWjolMisp83Rvz0++EKyab/LRktBdHeg=;
  b=gYCZ+KMKII4MiWLBUsPJojBberx4V8/I3h0cITagpsxNyGAkGKyD+O5N
   jDtXn+nY0UA3nbsBua/BWZtc7W1A7pep8tR+45/+8Bz9qTfX8FCozwsIA
   RepfuvX73XIQ11E8Pxy2isWwDqjPyNTMjwIPexXM12+8/JLHMEuBjO3T7
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
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="asc'?scan'208";a="161853553"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 14:23:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1CFA8E0CD1; Tue, 16 Apr 2024 14:23:53 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2CDBAE0141
	for <cocci@sympa.inria.fr>; Tue, 16 Apr 2024 14:23:47 +0200 (CEST)
IronPort-SDR: 661e6dd2_kn9sfRkHq87LqyQ9xzp7ThQSuT6BgTpbtQVVNZehSJ9Wu3V
 fdG8Gi0ZZdZRZIrgnjqt7rior+CVq2Y3saRIDkg==
X-IPAS-Result: =?us-ascii?q?A0GIAAAnbR5mkCH+dcJaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YJDgVExAwcISIxzX4hvkmGLJ4F+CAcBAwEIBUQEAQEDAQOEdQoCiBsgBgEEM?=
 =?us-ascii?q?AkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEBAQEgHhAKB?=
 =?us-ascii?q?CeFbQ2CZwGBBYENAQEBAQEBAQEBAgEBASIrAoEJAQEBAgFAAQE3AQQLC0ZWB?=
 =?us-ascii?q?huCeAGCPCMHtAGBNIEBggoBAQbcHYFaBwmBSAGBVoZMCwGBU4dveoJPhD8+i?=
 =?us-ascii?q?waUbocNhiVUgRkDWTIBSwo1DwwaAi8NJCMCKUoKEAIWAx0YMBEJCwcfAyoGN?=
 =?us-ascii?q?gISDAYGBlsgFgkEIwMIBANQAyBwEQMEGgQLBzg9gXyBPQQTRAOBQooVDIMxK?=
 =?us-ascii?q?YFOKYR9cYQcgWEDRB1AA3g9NRQbKAGcXjCEWMkuhB2hREkDg1wBk1OSbphio?=
 =?us-ascii?q?nk5hVOBZDqBXDMaI1CCZ08DGQ+OIBmDYZZARDI7AgcLAQEDCYkigUgBAQ?=
IronPort-PHdr: A9a23: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
 IEHTLAeWVo6F/UXB15kGtNEK5ByDGtMrA==
IronPort-Data: A9a23:9aMryK+EHmKzdHpiwBVxDrUD3XWTJUtcMsCJ2f8bNWPdYAuX7wSz/
 BJcAD7Ya7vPIDfrKpolWDmFhRgB6paAy9BiHgNqqSo8F3xBp8eaXoTIIxf7ZX3Kf8GZFh5rs
 58QN4mecZ5oFHGG+R30aeWwpnAs2/CBTbOnVuCs1kydPeNBYH5JZUVLy7Vi6mIRveWEPu+th
 T/Ti8eGYFb/hTMoP2lMsPna+Bpm56+q4G9A5Q1jbK8U5AfQvnREV5h3yYOZfyKpGNEMdgKZb
 7+el+/hpjuxEzMFUI7NfmPTKxVSKlLqFVHSzCAQAcBOuzAazgQqyKE3KfEAXklejjSNjrhZx
 c5E3XCKYV5B0pbkxqJFDHG0LwkkZfcaoOOefyDl2SCu5xSun0XEk60G4H4eZtVwFtZfWQlm6
 fEeITYRWRGP78reLGWTF4GALux6RCXaFNt3VkNIlVk1Pt56KXz3eJgm0PcDtNsGam+iKt6FD
 yYRQWIHgB0t+HSjMH9PYH41tL/AanUS71S0Ab9azEY6yzG78eB/7FTiGNvFdvqUecBVpVSd+
 SHq/k/ZBkkQGsPKnFJp8lr07gPOtSbyWYZUBrCl7aYxxlGeroARIERHCR3i+Kb/0BPiHYkEQ
 6AX0nJGQawa61eiDcPwWRCjqWWspRcaVJ9dFeI77gyA0KvS7ECSAW1sojtpMYJ/5JJtGGV2v
 rOPt/7VVWRDnKGecnCcx4rL9TOgI3EwMnBXMEfoSiNcs4K7/Nlj5v7Vdf5oF6W+j/XuCDToy
 naLqjI/jvMdl6Y2O76T4k/YxSChu4ORFUg56207Q15J8Ct4dIKDebCt6WPJ6KkDAIeybl3Zt
 lYbzp32AP81MbmBkymEQeMoFb6v5uqYPDC0vbKJN8V6n9hK0yL4Fb288A1DyFFV3tEsVRKBX
 aM+kRxO+9lBMWaxNfQxb4/Z5yUWIUrIS4mNuhP8NIEmjn1NmOmvpnoGiam4hDqFraTUuftjU
 ap3iO71ZZrgNYxpzSCtW8AW2qIxyyY1yAv7HM+ilE7/j+LDNC/LFt/p1WdiiMhlt8toRy2Jq
 L5i2zeikn2zrcWnPXiNmWLtBQ5TRZTEOXwGg5UHLbbfeloO9JAJFvOZxL4teoUtkKFflo/1E
 oKVBydlJK7ErSSfc22iMykzAJuxB8YXhSxgZ0QEYw33s0XPlK7zsM/zgbNsJ+J2nAGipNYoJ
 8Q4lzKoWKsTEm2apGV1gFuUhNUKSSlHTDmmZ0KNCAXTtbY6L+AQ0o60IFnc52MVAzCptMAzh
 bSl20mJCdAAXgluRoKeIv6m01r77zBXlfNQTnn4BIBZWHzt14x2dA33rPs8eP8XJTv5mzC16
 gexADUjn9frnbMbytfyqJ6hk5aICMp7R0pTIHna5+25NA7c5WuS/rVDW+epIxHYDWP9x7q/a
 OBrlvruGe8jmWxOkotjEoREybA1yMvvqoR7kCVlPiTvRHa6BoxwJkKp2ZF0iZRM4btCqy6aZ
 E6r0ftLC4WjYc/KPgYYG1s4U76ly/oRpAj30d00B0fLvAlM47uNVBRpDSmm0SByAuN8D9I4/
 L0HpsUT1g2YjygqOPagigR/1TyFDl4EYpUdmqAqOq3ZoSt19Qgaer3ZMDH837+XYdYVMkUKH
 C6dtJCfu5tinHj9Y1gBPlmT+9FChKY+mgFAl34DAFWrpuDrpNEK2D9pzDBmaTgNkztm1bpoN
 3lJJn9FA/yE3w1VifhpW0GuHAB8ByOlxHHh9mtRqkrnSxiHa2+cCkw8JueHw24B+U1+YDVw3
 e+V2UTlYxnQbeDz2So5A2B4me26SdZ0+hXInf6jFMGBAqsrPDjv2PevQUEqqBLXJ9w7q2Oah
 Ott/cd2MbbaMwxJqYIFKoCq75YiYzHaG35jG9RPpLgoG0PYcxGMgQm+EVi7IJ5xFqab4H2GB
 NxLDeMRcRaHjQKljC0RXIwIKJ9KxM8Z3sIIIO7XFDRXoomkj2RbtbzL/XLDn04tedJllPg9J
 q73dz6vFm+xh2Neq1TSrftra3aJXt0ZWDLShOyF0v0FN5YmgtFedUsf1riVvXLMFCBF+xmSn
 h3IZo6I7uhE5LlvobDREfR4N13pEe/waeWGyxDsktJsadiUD9zCmTlIoXbaPiNXH4ArZfJJq
 Zq3vuXa5nj15IQNbziBmr2qNbV42sGpbe8GbuP1NCZ7mAWBau/N4jwC2XKJFsFPtOxj+/v9Q
 xaKV/WhfOFIXfNY4mNfUAlFMhMnE6+sRLzRlSC8iPWtCxYmzg3MKu28x0LpdW12ciwpOYX0L
 w3FpMaV+dFTqbpTCC8+B/1JB4FyJHnhU/AEc+LdmCa5DG7ypH+/oZrnyAQd7A/UBkm+EMrV5
 YzPQj78fk+QvIDK1NRojJxgjCYIDXpSgfgCQWxFwoRY0wuFNW8hKfgRFb4kCZsOyyz768zeV
 QH3NWAnDX3wYCRAfRDC++/cZwa4BNEVG9LHNzcsrlK1aSC3Odu6O4Ff1BxculV4Rjiy69ucC
 4AuyiWldFz5iJRkXv0a6fGHkP9qjKGSjG4B/Ufm1df+GVACCLENz2ZsBxdJSTeBKczWiUHXP
 iIgcAiomq1gpZLZSq6MukK5GS31eBvqxjQsKzWC3c2H4MOXwYWsDdXhbvrr3ORrgNsifdYzq
 bHfHgNhIFx6HlQIsK0m/t8vjq5yBP+RH861aqTkQGX+Womuv38/MZpqcTUnFakfFc02L78Zv
 iKl5Xd7CUKKKUZc1aeXzwpP8JV0Op7J4/clkyanzQL7fdcFIxQ1tvRkIM8X6X09lkQ7g3hlf
 Q==
IronPort-HdrOrdr: A9a23:Cz8EFq77ejQAR9/LAQPXwP7XdLJyesId70hD6qm+c3xom+ij5q
 aTdZUgpHjJYVMqM03I9uruBEDtex3hHNtOkPAs1NSZLW3bUQmTXeNfBOLZqlWLdhEWtNQtsJ
 uIGJIOa+EYY2Iase/KpDWUV+wl3cDCyqyzn+fZyB5WIT1XVw==
X-Talos-CUID: =?us-ascii?q?9a23=3AQbPHpWrTpnmZygsq6jnKfSTmUcE1flvD8HLQGF2?=
 =?us-ascii?q?9ViVFSZa1TQea1rwxxg=3D=3D?=
X-Talos-MUID: 9a23:/rthbwh7CkSD+8FdxDs8FcMpGfs4u4iCFEs2k5Q3hpbcNT5qYhKCk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="asc'?scan'208";a="161853514"
X-MGA-submission: =?us-ascii?q?MDHKNmyzjGwbBJtMX6pwsAv3otbuNdLAHVmhp+?=
 =?us-ascii?q?2Pfmi6zXaFY5XKSfXV7cmZERw784Q64B/8FR5se+cuBOZBkGBoBin8rx?=
 =?us-ascii?q?/O5PMq8HkB+PRtQ7FVpdDD7zL2MmLVk103PiEQ/Bam3qNBvFZj+WUyuU?=
 =?us-ascii?q?wcHI3nQXFuOHckiFC4zQbdVQ=3D=3D?=
Received: from www.zeus03.de (HELO mail.zeus03.de) ([194.117.254.33])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:23:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=SNLF
	DDQWGCZfWjolMisp83Rvz0++EKyab/LRktBdHeg=; b=EO8NlwXmNd+nu4b9EVMO
	oQHySlYTg577XObA9m6Vpj4jFg8OJB1r41LXZ7mcKfJNLKYcZOYcaYGPj/jCp/jz
	nEPtpcXqwlr52fpDfE03jvlB+zKx1Np6bM/nBY0GqRkK8HAzphMwYS9JaIR9Y3Pe
	52FOfh+ZQ9rI9YQqacygtX/K7ZdQ++9VG030BIMe2p7tFGNbCI92ueeucDCC2jEI
	RyKL/kiPB7BVB9Ci3LUQYHfWOnE/6daLNEBAMROFWLrI2M9FRn2D9WBNfcllH7Q9
	iNB5n4kHHTkQ2VGDFit0kOQaxu4xfHpIUYioy8qFdsFpHNOhaLf6a2YDSem+aKmO
	nw==
Received: (qmail 2404942 invoked from network); 16 Apr 2024 14:23:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Apr 2024 14:23:45 +0200
X-UD-Smtp-Session: l3s3148p1@2KYwzzUWAOsgAwDPXxiyACzheF6dGXh7
Date: Tue, 16 Apr 2024 14:23:45 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Wolfram Sang <wsa@kernel.org>, cocci@inria.fr
Message-ID: <5rctzuo7ynserxtyhsikkc4zhglcdqoysnt4kd3odethcv6f2o@2crrvxx6bx2b>
References: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr>
 <ZhhO29XtBmBkyuQo@shikoro>
 <alpine.DEB.2.22.394.2404112304250.3048@hadrien>
 <x5daefdxp7afett3nq6j56dn3t33xwl5ul7ys4xa2u2rc7yhub@nz6zhf6yhgsd>
 <alpine.DEB.2.22.394.2404120831160.3229@hadrien>
 <4em54bibxo6t6cjv2uifnuqpmpubrtm6htfac2iiyhp76txmh7@o6qzyvdxm5dz>
 <alpine.DEB.2.22.394.2404120857440.3229@hadrien>
 <cdn5ct3pmn3l4yuohu6ulfndv7iy3pl5ycrdgxrgrqnd6czijn@tmoibbjtofa7>
 <fa25ff69-acf1-baa0-31f-936116b3cc57@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nr2qgddagewuxffe"
Content-Disposition: inline
In-Reply-To: <fa25ff69-acf1-baa0-31f-936116b3cc57@inria.fr>
Subject: Re: [cocci] new version 1.2
Reply-To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Loop: cocci@inria.fr
X-Sequence: 1665
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/5rctzuo7ynserxtyhsikkc4zhglcdqoysnt4kd3odethcv6f2o%402crrvxx6bx2b>


--nr2qgddagewuxffe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I can just try it, but what is CDPATH for?

CDPATH is a list of directories for the 'cd' command. I have '.' and
"$HOME" in my CDPATH. So, when I type 'cd folder', then folder can
either be in the current dir or in $HOME and 'cd' will switch to
whatever is first in CDPATH. A bit dangerous, but I came to like it.

I still don't see why this affects dir parsing of coccinelle...


--nr2qgddagewuxffe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYebc0ACgkQFA3kzBSg
Kbap/g/9EmqrXShCEXUonupgwbrPbPN5fmOEjSF7P4XoXbfG0a3r2zs8DGE04SLf
9sX/baCnVUbYtVEI7GPxNuZkw8fqMOYUlnj6mDg5GyvSzLfAo6c2vsOpvBYKELI6
1H4etgvHBTJonagYIRZzw+p/vxECSNqWTG27mFtZ4FDwzfaIk9mYK4/24qFWeTlv
X2cyrNtFy3g0jOGryufpfUYJpAGlyW7RQj4Bm0dxpAd+SHmpZ6ZN7KqUGSYP7gmL
pSzxJRKZXkvEx1G7WBtNkCxmI63AgniTsqO3C0GISN0kj42/wz+8ETJxr231gMia
IShCA4S8RzRIdtFMHCIG5AnTgF2t7OZUrYlpyqul+WTFMYBEv+BYuLcWuUveTdMz
rPe+FT2/N2+5MY+/2YljVZSl5/u5no24abkEYgGZDLC/7ZAepdj8bbOhcPeqOSsr
oo9BQuQjFpQWHgrh8SFRnt7tlPZ3uofy7/9hHn7a3MLZP9M+UrPK89VqhXZ+eIEg
y4eJ7mXQDscg9unNDZuvl9JExtlOhhiTWyDGZTZTxgmLl7XW2k63IF1I3OI89b/Y
7aqDutZr/ls10w3ZC2Y3+tLs17V+1+kQ8G3lKiGEKM9AkB35H483g7IK58jZj0v4
SopfRkQqesx/Yj7VRm/+oS/EbPGiZQuOMfu8ulv6I3LkBFEoYnw=
=KV8h
-----END PGP SIGNATURE-----

--nr2qgddagewuxffe--
