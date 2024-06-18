Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDC1C27C4F
	for <cocci@archiver.kernel.org>; Tue, 18 Jun 2024 15:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=FTO8kZ29ZK5sGlqhzhnu1b/nuYykOCaZLbbzLwCVj94=;
  b=Gr21y2+Sf7DnCJtV/PSdKwsca+Kd7srVpVA1g5QwrCnDJ9CP825P4vVe
   J52AXGngs0k7N1ZTh9/2VKznVkHlRFIXx6y+2IUMqtat341tm44JiX3Hk
   p1F6cwbKKnivz4WdhSq2M/MoLyKIGMkBSKteZlphoS0DaJfjeS6QRqs9e
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sang-engineering.com
X-IronPort-AV: E=Sophos;i="6.08,247,1712613600"; 
   d="asc'?scan'208";a="171296114"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Jun 2024 17:46:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6E800E0AF6; Tue, 18 Jun 2024 17:46:47 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6EFF5E0157
	for <cocci@sympa.inria.fr>; Tue, 18 Jun 2024 17:46:43 +0200 (CEST)
IronPort-SDR: 6671abe2_vbMLtw8DIniDHHRRDsPDica3PLc33ad0ycTJ659iCrLu3VQ
 dl68iEXqYfUm8qfQpXkj+Q2zFbC56sj7w46JnDg==
X-IPAS-Result: =?us-ascii?q?A0FqDQD5qnFmkCH+dcJagQmBT4JEgVUxAwcISI1SiHGSZ?=
 =?us-ascii?q?YsngX4IBwEDAQgFRAQBAQMBA4R/Aoh6IAYBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEIAQEFAQEBAgEBAgQGAQIQAQEBAQEBIB4QCgQnhXQNgmCBDYENAQEBAQEBA?=
 =?us-ascii?q?QEBAgEBASIrAoEJAQEBA0ABATgPCxguViGCeAGCZAevI4E0gQGCDAEBBtwdg?=
 =?us-ascii?q?VwHCYFIgVeGTwsBgVOIaYJPhD8+hRCFVSKZXIwSJguNIlSBGQNZIRMBSwo1R?=
 =?us-ascii?q?xYCFgMbGDAPCQsHHyoGOQISDAYGBlk0CQQjAwgEA0IDIHERAwQaBAsHOD+Bc?=
 =?us-ascii?q?YE0BBNEA4E3iW8Mgy+BdCeEZWyEA4FrDGGIbIJOgWeDBYEYhD0hHUADeD01F?=
 =?us-ascii?q?Bunby+BFIUwAWAuKcg7hB2hSEkDg1yTVpJxmGWifIYOgWU6gVwzGiODN08DG?=
 =?us-ascii?q?Q+OOoNhyx1EMjsCBwsBAQMJiSKBSAEB?=
IronPort-PHdr: A9a23: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
 NPIkfCrQAo=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:17zEnaowiAsWXza6JNJd3rUaV5obeYIsimQD101hICG9Vvbo8P
 xG/c5rsSMc7Qx7ZJhOo7+90cW7L080sKQFh7X5Xo3SOTUO2lHYT72KhLGKq1eMJ8S9zJ8+6U
 4KSchD4bPLbGRSvILHzU2DF8s4hOOK6rqpg+C29RtQcT0=
X-Talos-CUID: 9a23:7DYHX2Ef1Uej+vCHqmI4pVZLAukUUUee913xAHbjE2lSD+CsHAo=
X-Talos-MUID: 9a23:BJBazAu04iRn4JUui82nhgMhL+psuoGXC1kGvIoLg+eLDTB8EmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,247,1712613600"; 
   d="asc'?scan'208";a="90011718"
X-MGA-submission: =?us-ascii?q?MDFYIqo0DOb0Aa+qF/W8lk9DBlFMGv24aNoTqS?=
 =?us-ascii?q?v+5ddhVwyOdfxt5wUyakd8zXvPQbdBM//clh5ZRA+LoK5SYcf9aGhg9l?=
 =?us-ascii?q?XevspRMSJHUOmV/44GeTk86nDwNDcV9sdLoTWs/UkF0Dl/KW+hERCW35?=
 =?us-ascii?q?2uWdw7Jwd0ZWIgFBSSSHBmKQ=3D=3D?=
Received: from zeus03.de (HELO mail.zeus03.de) ([194.117.254.33])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 17:46:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=FTO8
	kZ29ZK5sGlqhzhnu1b/nuYykOCaZLbbzLwCVj94=; b=dT+hqDRKi4m8+MDpGXGE
	ljiWzYr3XNiPq8oRJ20imeKgVQv1LmQdowYOVG5lY3358TWEDS8MqwSh1xNowG9e
	pSBjW52Qz6JIHuZcgGkLV2VSTvkDKUurS2n7SPy8O7c6FmaRxP6S8H0DbTuDLXJZ
	A0OZIOn89x6OkKhXS/1AaeKmevBlNG6kntdDiO7PB0P1ZsJvYyl8GCYDb241X5Vu
	cq1bpWES4IOD0Pdbb5sm6mvSRzTmIrtzM2RmL25rxTs+TS/GISD035Y4oqhlvZpq
	KU8MEXvjNh4HT6R7oCSp0wAhBXqqQQUiSPxHsryx4OjxBA1BMD0OAI3KmhviV3qf
	6Q==
Received: (qmail 278204 invoked from network); 18 Jun 2024 17:46:41 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Jun 2024 17:46:41 +0200
X-UD-Smtp-Session: l3s3148p1@AX/x/CsbXMBehh9j
Date: Tue, 18 Jun 2024 17:46:40 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: cocci@inria.fr
Message-ID: <pe4gn5qayxyjairmpfiscsq73pr5uv4ayn7pj7eoojt6wx2sf6@mhtdngdsth2h>
References: <20240413065726.2197-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="atocvp2fwrsspge6"
Content-Disposition: inline
In-Reply-To: <20240413065726.2197-1-wsa+renesas@sang-engineering.com>
Subject: Re: [cocci] [PATCH 0/2] docs: updates to hevea handling
Reply-To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Loop: cocci@inria.fr
X-Sequence: 1795
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/pe4gn5qayxyjairmpfiscsq73pr5uv4ayn7pj7eoojt6wx2sf6%40mhtdngdsth2h>


--atocvp2fwrsspge6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 08:57:24AM GMT, Wolfram Sang wrote:
> When compiling coccinelle on my own, I didn't have hevea installed.
> Since it is not needed for the PDF docs I was interested in, I rewrote
> the Makefile a little in patch 1 to move its dependency to HTML docs
> only. In patch 2, I added it hevea to install.txt as optional for HTML.
>=20
> Wolfram Sang (2):
>   docs/manual/Makefile: check xxdate only for HTML builds
>   install.txt: mention 'hevea' as dependency for HTML docs
>=20
>  docs/manual/Makefile | 17 +++++++++--------
>  install.txt          |  2 ++
>  2 files changed, 11 insertions(+), 8 deletions(-)

Not interesting patches?


--atocvp2fwrsspge6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZxq9wACgkQFA3kzBSg
Kbb5yg//b8bRR3/VGzOaFmiLuEWRZH5PYopOY+S68B/eR7lXm9nsiqwqSrNfdgBu
uSAeXp4cHKVt+sIy3K854xJPwjOYQLgYypjPq7mcE1CC6O0xSrOQjywK/fb4oHwf
swjs32LN5ftLCE3oQSA1bclALYLOIZq3voRSRV6EtzvuAMqVy5EFALyP3rHMfzT/
n/fgbaOwFzE3LScsulHfjwUSHpKg11xLBy/kyUr/V3mXJAuNT0H0neQC46F3KlbF
hS9cHU+2mdg56lD3vxmqvlb/IMserZLs0Yxq1tP63yBnv1OQM2EbSq03TTEsN9QB
IQReYCy0U0WPk11sWw9BV4C+GdCqcA4TAdM9wG+ZtdaGtiLJYkUxFyLEpxS28O3q
b46RRRisgHrurwa/w3u81QPZEI4+4yNYi4rvSH4DFUCYK+radqQf7ZVc0uIIzwAz
9/GI4C/bFOdGvYmzEwIGvMiTLxmXnihkwcoxBuwp5YYOYbd8xr9n9JQgUQm63pog
ea1fFTMfXgaRsudwl9S7b/mNhvJJ8qjlaWC+ALpTA1JvjTSWOhvqgbfnD7ipCq73
VCtv5m9eH2psjw5Ehisc0j4ZEzf2DQFUQ6KGhoSVMWkLppM0llUDkAwexE4I0C3u
Hs6vZyCaEUF21yDrnk/usu0ykJ4XPXzoc6pMxiW7tMvmb6FuyZg=
=YSZI
-----END PGP SIGNATURE-----

--atocvp2fwrsspge6--
