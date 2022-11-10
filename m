Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09A0C4332F
	for <cocci@archiver.kernel.org>; Fri, 11 Nov 2022 01:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Mw7pBNpvHRgXr2Yk8WwQ49E1jCM9yunYtIp25EIt+2U=;
  b=W2WjWntt5s10EXHUsw5MFD0Pi4yLae5E0n9cY++9VMRiFRXWVYK7qSh+
   d0oy7FlpdOWfIR85hrssHdRMFG1tD6y1DGJ0eGNSxeQWXFyPyGWmEv3es
   7L04dNxQ/mKCFiyYLYlchHK42I/IakFO5EpzP3q2YCyPbbtrCIKBFiMzW
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.96,155,1665439200"; 
   d="asc'?scan'208";a="77751966"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2022 02:25:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6DBBBE0236; Fri, 11 Nov 2022 02:25:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 36A3BE0092
	for <cocci@sympa.inria.fr>; Thu, 10 Nov 2022 16:07:36 +0100 (CET)
IronPort-SDR: 636d13b7_ZdDDPcxhEZM3KtR57hCTw8q/BKHw44Wb7Bg8NC3awA670vn
 gaKtKkD4B8xgJ4yAnpzcWz9mlrofS+aEl3721/g==
X-IPAS-Result: =?us-ascii?q?A0GtAACjEm1jkEel3FVaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YFaUoECVy0EC0WVaQOXWYMDfoNcBwEDAQgFNQwBAgQBAQMBA4NrhhECHQcBB?=
 =?us-ascii?q?DMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBAQEBARYJH?=
 =?us-ascii?q?hAOBSKFaA2CNSkBUhMQVgEBAQEBAQEBAQIBAQEBASACAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARYCCAVNBXgBBXkQCxguVwYTG4JiAYMhBAOsEYE0gQGDUAGcRYEXC?=
 =?us-ascii?q?gaBQAGBU4VcDg9XiGwngimBFYMqPosCBIEHlwoDRB1AAws7Mg1KGzEnDgkfH?=
 =?us-ascii?q?A4XDQUGEgMgbAVBDygvZyscGweBDCooFQMEBAMCBhMDIAINKTEUBCkSDSsnb?=
 =?us-ascii?q?wkCAyFlBQMDBCgsAwlABxYRJDwHVzoBBAMCECI6BgMJAwIiE0SBJSYFAw0XJ?=
 =?us-ascii?q?QgFTQQIOQUGUxICChEDEg8GJEgOSj45FgYnQwEzDg4UA16BagQ1Z5okgh16P?=
 =?us-ascii?q?4FFJxGTGR+SAJ13B4IegUyKK4EilG1MlnySGi2HHY9pjUOUPTqFPoF4JIFcc?=
 =?us-ascii?q?YM2TwMZD45Xg26EYYVLQTM7AgcBCgEBAwmCOoMNAQF+hC0BAQ?=
IronPort-PHdr: A9a23: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
 pseDLNWBgRdKw==
IronPort-Data: A9a23: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
 dvKUHusng==
IronPort-HdrOrdr: A9a23:9VhJnKFwmuVql0WVpLqE7ceALOsnbusQ8zAXPo5KJyC9Vvbo8P
 xG+85rsyMc6QxhPE3I9ursBEDtex/hHNtOkPAs1NSZLWzbUQmTTL2KhLGKq1aLJ8S9zJ8+6U
 4HSdkcNDSaNzlHZKjBjzWFLw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,154,1665439200"; 
   d="asc'?scan'208";a="39455527"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDH2HgBQm5RQU+zadKYbrS29OdBF08yfdtgSf0?=
 =?us-ascii?q?a8OsuusdLtqTsMoRJ6LLCBpTT4+ZnMibd5XVlHJL5o/1jmDxI+9AXYRs?=
 =?us-ascii?q?Uf4LRXWtrcEMiVCgynb2S4JPLrR7H13Q6fGvbtBw8oRclt8s1AUSii4N?=
 =?us-ascii?q?pkUzrL22XdBHPj34Ks1P+eaw=3D=3D?=
Received: from metis.ext.pengutronix.de ([85.220.165.71])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 16:07:35 +0100
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ot99P-0007vO-NI; Thu, 10 Nov 2022 16:07:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ot99N-003TlX-9E; Thu, 10 Nov 2022 16:07:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ot99N-00Ff53-BG; Thu, 10 Nov 2022 16:07:29 +0100
Date: Thu, 10 Nov 2022 16:07:29 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, cocci@inria.fr
Message-ID: <20221110150729.afctso5mtl3y5lf4@pengutronix.de>
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
 <28e17fb9-cec1-4a89-1492-cd3ece7a9487@inria.fr>
 <20221107181135.tm2wmwiulepsyrmk@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="apoiwhxzieqvvybw"
Content-Disposition: inline
In-Reply-To: <20221107181135.tm2wmwiulepsyrmk@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: cocci@inria.fr
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Reply-To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-Loop: cocci@inria.fr
X-Sequence: 733
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/20221110150729.afctso5mtl3y5lf4%40pengutronix.de>


--apoiwhxzieqvvybw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Nov 07, 2022 at 07:11:35PM +0100, Uwe Kleine-K=F6nig wrote:
> devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalent to
> the shorter devm_platform_ioremap_resource(pdev, index).
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> On Mon, Nov 07, 2022 at 08:45:38PM +0800, Julia Lawall wrote:
> > On Mon, 7 Nov 2022, Uwe Kleine-K=F6nig wrote:
> >=20
> > > devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivale=
nt to
> > > the shorter devm_platform_ioremap_resource(pdev, index).
> > >
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > >
> > > a potential improvement is to check for invocations of
> > > devm_platform_get_and_ioremap_resource() where the res parameter isn't
> > > used afterwards, but my coccinelle foo isn't strong enough for that.
> >=20
> > ... when !=3D res
> >=20
> > I'm not sure where you wanted to put it though.
>=20
> I tinkered a bit further and even succeeded to remove the declaration if
> it's otherwise unused.
>=20
> I failed to test the report mode, my spatch tells me some error about
> python2?!

For the record, that is a problem with Debian's coccinelle, bugreport=20
at https://bugs.debian.org/1023653

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--apoiwhxzieqvvybw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNtE64ACgkQwfwUeK3K
7AnvVgf9GKKPPyISBHKDpcKOzc1KNYOlBfxOfqfr4+tZTm1r3//Q8dvjheB0c2Ke
a+tjXHqDCmfS0a5zj/iLGVoTJ5xZM78fuvmS+CfnvZexrrrYp/OZM7xHXwmRNItA
9y99JjQ3veo+G31AUYEzron7qslnWUCbqiQoNI7bc6wm3z+rjzKhEJSYD/jsgp5L
ycstaNQKo7zqRfNmIJ8wpkHn2qs+0H15S/VjMz6AeV3INdsl0tebAx9C6brrBqVt
wGhGQ0cV/dlfHSsvKM8xZzgIrO5rBPLmWwx0qRtFmZri9LGuCgvOOwQAovRo7U0U
+omTn7ykFlSRADOxtZSmp894lJZ+Pw==
=vJuU
-----END PGP SIGNATURE-----

--apoiwhxzieqvvybw--
