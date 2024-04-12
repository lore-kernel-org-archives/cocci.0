Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFEEC04FF6
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=098G5N61nWt83OGxDhVZKRdNnLnld56bB1oiCwISygE=;
  b=mnX3BnbxSQo+OT4cLPjcYb5s7dRkAIOnA9p0NkDQnhr0ZJcg8KtKQQ5U
   wQjkBVokGuikiAYPcTOdPXyPQ9+M7pkpUa8eJUWQ5JJCrIYk9/sHSkQZl
   nxJYQmuVEOwndj+D1+Ax/FuSH8NPnG6rbYW3Y2BWQ50pLGDemQqJMyGw5
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
   d="asc'?scan'208";a="161851029"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 14:14:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 67326E0141; Tue, 16 Apr 2024 14:14:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1E2E9E004E
	for <cocci@sympa.inria.fr>; Fri, 12 Apr 2024 12:42:15 +0200 (CEST)
IronPort-SDR: 66191006_F7/BdGMU/s0W1MFzMvrMNrchotClhXVS6VKqPATgACNJJpY
 kUSCSt/x7MJxp5Gt0GQO2B+lEHye2VOtn4ebgZQ==
X-IPAS-Result: =?us-ascii?q?A0FEAAAVDxlmmCH+dcJaHAECAgEHARQBBAQBQYE7BwEMA?=
 =?us-ascii?q?YJDgVEwAwcISIxzX4hvkmGLJ4F+CAcBAwEIBUQEAQEDAQOEfwKIGCAGAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBAQEBAQEBHhkFE?=
 =?us-ascii?q?AoEJ4VtDYJnAYEFgQ0BAQEBAQEBAQECAQEBIisCgQkBAQECAUABATcBBAsLR?=
 =?us-ascii?q?lYGG4J4AYI8IweyCoE0gQGCCgEBBtwdgVoHCYFIAYFWhkoLAYFTh2t6gk+EP?=
 =?us-ascii?q?z6LBqFcVIEZA1kyAUsKNAk6DwwaAi8NJCMCLEoKEAIWAx0YMhEJCwcfAyoGN?=
 =?us-ascii?q?gISDAYGBlsgFgkEIwMIBANQAyBwEQMEGgQLBzg9gX6BPQQTRAOBQooXDIMzK?=
 =?us-ascii?q?YFQKYQ/QnGEIHwDRB1AA3g9NRQbKAGcVBCGEIElgTLFOoQdoURJA4NcE5NBN?=
 =?us-ascii?q?5I3mGKieYISg3qBZDqBXDMaI4M3TwMZD44sDQmDWJ9/RDI7AgcLAQEDCYkig?=
 =?us-ascii?q?UgBAQ?=
IronPort-PHdr: A9a23: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
 5sIR7JBVVo6UPgdDxY9dOE=
IronPort-Data: A9a23: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
 Pr+rKpcnrFOiAbZmA==
IronPort-HdrOrdr: A9a23:Fg8Gw6AFwYR1dunlHema55DYdb4zR+YMi2TDGXoQdfVwSL3/qy
 nOpoV96faQsl0ssR4b9uxoVJPvfZqYz+8N3WBzB8bHYOCFghrLEGgK1+KLqVDd8m/Fh4tgPM
 xbAstD4bPLbGRSvILHzU2DF8s4hOOK6rqpg+C29RtQcT0=
X-Talos-CUID: =?us-ascii?q?9a23=3AtF6OPmp85qoA79MeibcLZkPmUc0gdVeaymbqGUi?=
 =?us-ascii?q?fEld7aq+ZUGCB47wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AAaU3mgwjJYl8CiK018j16njmAE6aqOekI2MwzMo?=
 =?us-ascii?q?ngMCvPDMhBxyTjWmPZ7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,195,1708383600"; 
   d="asc'?scan'208";a="161250347"
X-MGA-submission: =?us-ascii?q?MDEgk7WqsLoeHY1grtZbK1D/OAYZR+nOLxfimF?=
 =?us-ascii?q?vsK0PB/lPcTEXuD9PT0EwefcbtyxO1+SBqq2CPcvQd9aCxHfWlOSFkid?=
 =?us-ascii?q?BvBk7I6SQ21ajcOZghWYlhUrnxJ/os9fHxY9ldvD+AZauI4MZz6QtQzf?=
 =?us-ascii?q?Vl0E9/3PSqMV/zOGQq+7ZZig=3D=3D?=
Received: from www.zeus03.de (HELO mail.zeus03.de) ([194.117.254.33])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 12:42:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=098G
	5N61nWt83OGxDhVZKRdNnLnld56bB1oiCwISygE=; b=XMgQLfRUaauRWJFf+VOh
	/+3iIeO61qQ3C6RR+Esc84dcVfVbgOPHz7a6MuLSXaYIvpn/P0jtxMxtqE89Y5XA
	CRh9/fJxJcozn29WKQUvRrGYeXtfT1dCnYNCunXyiLaDat32KCqBvRQ2PnWrDIo7
	mdV+ja3IyA0DVyXnM8TTCRQOi79/wYvJ7MbnrGqYEzsss3vaoBP8xq5U6ZgCI9/K
	FFCGvBGE5WOxvyPTUWw0uNsb4HlVI6qY6Jw8lpvsMcmqWaPUvNDYULadTz+0E1tM
	ojRAJmoEQT5iaunaRb2HqhEu9Vsz4WAT4R9QiIwj2Tr/l/J8L2+Xc6qgRuQwUKuI
	6A==
Received: (qmail 1188064 invoked from network); 12 Apr 2024 12:42:13 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Apr 2024 12:42:13 +0200
X-UD-Smtp-Session: l3s3148p1@cAVz7OMVMNgtnPBj
Date: Fri, 12 Apr 2024 12:42:08 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Wolfram Sang <wsa@kernel.org>, cocci@inria.fr
Message-ID: <cdn5ct3pmn3l4yuohu6ulfndv7iy3pl5ycrdgxrgrqnd6czijn@tmoibbjtofa7>
References: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr>
 <ZhhO29XtBmBkyuQo@shikoro>
 <alpine.DEB.2.22.394.2404112304250.3048@hadrien>
 <x5daefdxp7afett3nq6j56dn3t33xwl5ul7ys4xa2u2rc7yhub@nz6zhf6yhgsd>
 <alpine.DEB.2.22.394.2404120831160.3229@hadrien>
 <4em54bibxo6t6cjv2uifnuqpmpubrtm6htfac2iiyhp76txmh7@o6qzyvdxm5dz>
 <alpine.DEB.2.22.394.2404120857440.3229@hadrien>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lnwoqa2x6nyoudle"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2404120857440.3229@hadrien>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] new version 1.2
Reply-To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Loop: cocci@inria.fr
X-Sequence: 1658
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/cdn5ct3pmn3l4yuohu6ulfndv7iy3pl5ycrdgxrgrqnd6czijn%40tmoibbjtofa7>


--lnwoqa2x6nyoudle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I don't see this problem.  I made a silly semantic patch, wet-ul_l.cocci:

My gut feeling was correct. I use CDPATH (bash feature). If I unset
CDPATH, everything works as you said. I use 'CDPATH=.:<my_home_dir>' but
setting CDPATH to '.' alone will expose the issue already.

I can unset CDPATH in my scripts as a workaround. Dunno if you have time
to work on a fix. I also don't see how CDPATH affects iterating through
a directory. Sadly, I can't read OCaml.

Thank you for your help, Julia!


--lnwoqa2x6nyoudle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYZEAAACgkQFA3kzBSg
KbZ/Pw//URm/BGaUKY/ly58hY3YUYUfpqVZHp2n1B4wIC0ML8kKOE5AZ/3l28UoC
gHWIoU1TpxuDylTm61ky/DKW3BaW4wANCYGguRBDhcxpm7jXrVDVVNSfG6333Mmj
3UQWUxsH3qLwG3vcMBnG9AaYeaIsND1x7kUfkhlf3+ND0X4LcvDboKslNcH4RZdU
yz5UseulW+VquzI87jLvoOndsZJKTNGqA2eXX72o+j72vTjmAHWqZEKi5e4yf80y
GUqKvpmr/PTg++R2TavADGDJ8nRVMoon5NeWAO1MpOIsdbXGHZlbYicClJRC7zZ9
CfvjKLm+PyzIju2jVH07mufmQkdc8HGSxmuqu5WVMo9SGeeCtCQez+/czFjzTPZs
0LH9o+gv+QphCRge5jHaPQ0DDOUpANZdIJsed7t5IxaSKRFaZnNVonlTQ8aOKJUL
q09xiJu6zD0dg3vbSbdAC3YCxL4+6Js2jIuYKFwPlftAVU5E7E8rXMrkBWacb9VL
213rUWH05rkV+j+oEmiCSGlIlwT39sK1sqRHYJYuB/u/QaoujRKN4Fd/huvxSUWw
SaXyZ2fpZuhbzSmjC8Smh48ux37w0lPNSfZOJpcQwAdjX9ak8H3OC0MK9olkIE5Z
1ZIXKwuOW9zmHPgokvucxp3c1ztkVw0GVRkj6nh0zsII8DIyV9s=
=3JUT
-----END PGP SIGNATURE-----

--lnwoqa2x6nyoudle--
