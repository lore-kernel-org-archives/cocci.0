Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6099C433FE
	for <cocci@archiver.kernel.org>; Wed,  9 Nov 2022 11:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3W2yMyaWHwkqRHXiF3mAJsTVvVNMGelc/EOD4bA2eVk=;
  b=hsJjs54HdtRe+oPOp1DaSc/tkjA8yA7MXCrJlii39UCiyvM41C2J5G1N
   FOBvOGpIFlCmsjNtCvpRobdecqC5bKKZhm18x8D9eg80JMGETvHZSKFmR
   iKJ8vRppnIUSjIB/ilJOwhxJFiYKn0VCPKTdm/5HHi6wKzayy027xzUy/
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.96,150,1665439200"; 
   d="asc'?scan'208";a="77446437"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2022 12:48:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8B084E03A1; Wed,  9 Nov 2022 12:48:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 08061E0076
	for <cocci@sympa.inria.fr>; Tue,  8 Nov 2022 10:54:37 +0100 (CET)
IronPort-SDR: 636a275c_xG2d7CD/1R18fAvvhrYy7inFymDq1aR2hF/kfI0fYFcqLAp
 QPOgroL0/wCw2t+WL6EqL6L2FOUjWGFjnwoUyVQ==
X-IPAS-Result: =?us-ascii?q?A0EDAAAhJmpjkEel3FVaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYFaUoECVy0EC40zhlaCJQOXVYMDfoFWggYHA?=
 =?us-ascii?q?QMBCAU1DAECBAEBAwEDg2uGDgIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAQBAQIQAQEBAQEBFgkeEA4FIoVoDYI1KQFSE2UBAQEBAQEBA?=
 =?us-ascii?q?QECAQEBAQEgKwIIUmwBBSdEDhALGCMLVwYugmIBgyEEA6pmgQEzgQGgFoEXC?=
 =?us-ascii?q?gaBQAGBU4VVDg9XiGwngimBFYMqPosCBIEHlk0DRB1AAws7Mg1LGzEnDgkfH?=
 =?us-ascii?q?A4XDQUGEgMgbgVBDygvZyscGweBDCooFQMEBAMCBhMDIgINKTEUBCkTDSsnb?=
 =?us-ascii?q?wkCAyJlBQMDBCgsAwlABxYRJDwHVzoBBAMCECI6BgMJAwIiE0SBJCYFAw0XJ?=
 =?us-ascii?q?QgFTgQIOQUGUxICChEDEg8GJkcOSj45FgYnRAEzDg4UA16BbQQ1aph9gnobP?=
 =?us-ascii?q?4EbKhURUAKSVh+DBI57nXEHgh6BTIorlg9MlnuSGi2HHI9poX86E4UrgWI6g?=
 =?us-ascii?q?VxxgzdOAxkPjleDboosQW4CBwEKAQEDCYI6gw0BAX6EHgEB?=
IronPort-PHdr: A9a23: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
 sNmdw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:C9LwtKNWIwa9m8BcTiKjsMiBIKoaSvp037Dk7SFMoDhuA6ulfq
 GV7ZAmPHDP5Ar5NEtOpTnEAtjnfZq+z+8R3WByB8bAYOCOggLBR+sO0WKh+UyDJ8SUzI5gPM
 lbHZRWOZnIMGk/q9377gm+G9Nl+9WM8LmpieDCpk0dNz1CWuVbx0NUGwaeVmdxQw5LD4d8NK
 P03Ls/mxOQPU4+KuirBn1Ae+DCopnlj5TjCCR2fyIP2U21pXeF+b7/VyKT1hAYXz4n+8ZYzV
 T4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,147,1665439200"; 
   d="asc'?scan'208";a="39187636"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDEQwwXueV88Lkmsx3fTO46vuX2ox6Vmd05QVF?=
 =?us-ascii?q?VCv5sHxbTcLquUvSzQcfs7ceH1OvJYL0YpAkuBE7s91752a5cbQsIj8Z?=
 =?us-ascii?q?f2nIATIEeU09eehfTIgI+BN8s+myj8xbAVto6hShTIpqSoXQ7uLUOtGK?=
 =?us-ascii?q?4i9r7GQY4SU+Ev8nOARdppEw=3D=3D?=
Received: from metis.ext.pengutronix.de ([85.220.165.71])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:54:37 +0100
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1osLJM-0002jj-PL; Tue, 08 Nov 2022 10:54:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1osLJK-0031l1-1Z; Tue, 08 Nov 2022 10:54:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1osLJK-00F9gI-40; Tue, 08 Nov 2022 10:54:26 +0100
Date: Tue, 8 Nov 2022 10:54:25 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
Cc: Julia Lawall <julia.lawall@inria.fr>,
	nicolas palix <nicolas.palix@imag.fr>,
	kernel-janitors <kernel-janitors@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Markus Elfring <Markus.Elfring@web.de>, kernel@pengutronix.de,
	cocci@inria.fr
Message-ID: <20221108095425.6x6hkyzzm3yuofi6@pengutronix.de>
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
 <bd13da2d-6d18-4f33-0987-a193e3c9b761@web.de>
 <20221107200815.u7hcwejileeabnct@pengutronix.de>
 <257596884.6156222.1667886713273.JavaMail.zimbra@inria.fr>
 <2fcd7fdb-7984-a2b7-7995-d164754c5eb2@univ-grenoble-alpes.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cdhqfdpr3heexpnd"
Content-Disposition: inline
In-Reply-To: <2fcd7fdb-7984-a2b7-7995-d164754c5eb2@univ-grenoble-alpes.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: cocci@inria.fr
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Reply-To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-Loop: cocci@inria.fr
X-Sequence: 727
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/20221108095425.6x6hkyzzm3yuofi6%40pengutronix.de>


--cdhqfdpr3heexpnd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Nov 08, 2022 at 08:55:04AM +0100, Nicolas Palix wrote:
> On 08/11/2022 06:51, Julia Lawall wrote:
> >=20
> > > After uninstalling python2 this ends in:
> > >=20
> > > 	Cannot find Python library
> > > 	coccicheck failed
> > > 	make: *** [Makefile:2076: coccicheck] Error 255
> > >=20
> > > Didn't try to debug that any further. Is that worth a bug report agai=
nst
> > > coccinelle (which is shipped by my distribution)?
> > >=20
> > > I tried to adapt the org and report modes from other patches in the s=
ame
> > > directory. So a critical glimpse by someone more knowledgable than me=
 is
> > > recommended. However I don't know how to react to "I doubt ... is
> > > appropriate", I'd need a more constructive feedback to act on.
> >=20
> > I'm not a python expert, so I'm not sure what to do about this python2 =
vs python3 problem.  Is there some strategy for printing that works in both=
 of them?
>=20
> It sounds like a missing dependency in the package system of the
> distribution. Coccinelle has been build with Python support, but
> some libraries are missing.
>=20
> Which distribution is it ?
> Can you install some packages that provide the two missing shared librair=
ies
> ?

After installing python-is-python3 (which provides a symlink
/usr/bin/python -> python3) it works. This is on Debian testing.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cdhqfdpr3heexpnd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNqJ0UACgkQwfwUeK3K
7AmXgQgAmcFJy9aUUaIHGku6gDZHfpePz+YMl0P0TPx1x32DxEa2gFjL3i2Nore7
UR03MaxJhZ979jgWfOdleSA8knnVHVNud+qy2hs74WCw4fn62fr6LaWkPbL5Hh0g
WD2FoSetO5UG+LPv5YjL8LcrVlMLTMwbNAZQvmIxMNusc1EkGvAAGou4T4r5yzl5
BUHBfBdXPXfhENAUgQuvx9z+TO0RReJ0OP/YywnrcVF9owFrtR4P7amYuNbrN3at
G4YcU+7DeuTPlJ/ahkRxuFA4ghlQOeiRRDYmwkCDxg9/XYDbsDvo41CgNtHbEgNF
YSZeSf+GxaaT6jPh8Mn39t2teV8Zlg==
=0w7O
-----END PGP SIGNATURE-----

--cdhqfdpr3heexpnd--
