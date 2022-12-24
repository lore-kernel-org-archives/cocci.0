Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF15EC4332F
	for <cocci@archiver.kernel.org>; Sat, 24 Dec 2022 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=1Z9YLR2JqLPQh2rckSBbLv4SFOL59xfWsVOORGPmx8k=;
  b=Ui7Zmf/1theXnescCKAlUmI8ofvwNCGiQMz9uAB2alV0RhjB5iJGQknX
   gQCNrPGRCM54wzauvMurPnOGugr2eAdlX3RXSXzJAcLeO1IOVtlFcqIEQ
   mHSHfRFUlfcV9PY5XrHFSt2GeMVThCKuGk4q7YbTD7n5WpVcA/F0R2vXc
   I=;
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
X-IronPort-AV: E=Sophos;i="5.96,271,1665439200"; 
   d="asc'?scan'208";a="84925543"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Dec 2022 13:13:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B3E95E0133; Sat, 24 Dec 2022 13:13:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 339E4E0128
	for <cocci@sympa.inria.fr>; Sat, 24 Dec 2022 12:57:02 +0100 (CET)
IronPort-SDR: 63a6e90e_WBjsVU2xpVfOhjPg7YF36tlnU8ec4qxjHCHDlUfTi+UdYKh
 TiyKS4XT1um4Oh7UXufd7TbxLJKjaB1smph4+PA==
X-IPAS-Result: =?us-ascii?q?A0FCAwAZ6KZjjEel3FVagQmDKlKBB1ctBAuUDp0NfoFqg?=
 =?us-ascii?q?XIHAQMBCAU1DAECBAEBAwEDg36GEQIdBwEENBMBAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBQEBAQIBAQIEBAEBAhABAQEBGScQEyKFaA2COCkBUhNmAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBASArAghSgSpSgT4BLYJjAYMiBAOyAYEBM4EBhHKbJoEXCgaBQIFUh?=
 =?us-ascii?q?WcPD1iJGYIpglGBPm6EKoZYBIwujGgKgT18gScOgRgDRB1AAws7MgpBNRdLK?=
 =?us-ascii?q?xobB4EKKigVAwQEAwIGEwMgAg0oMRQEKRMNJyZrCQIDImYDAwQoLQlAByYkP?=
 =?us-ascii?q?AdWNwUDAg8fNwYDCQMCH1CBICYFAwsVKkcECDYFBlISAggPEg8sQw5CNzYTB?=
 =?us-ascii?q?lwBKgsOEwNQgU8EgQ2BCS8ommqDWoFDOnqSRLAbB4IigU+KMZYVTJcEkiCXR?=
 =?us-ascii?q?iChZjqFPoF5I4FccYM3TgMZD44sFoQDiixBbgIHAQoBAQMJgjqDDQEBhloBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:bRoU/aHkC774zGyapLqEH8eALOsnbusQ8zAXPo5KKCC9Vvbo8/
 xG/c5rsCMc5wx8ZJhNo7+90cq7MBHhHPxOkOos1N6ZNWGM0gaVxepZjbcKrQePJwTOstdh5O
 NHaKhxCNr5CBxAgcz7+Qm1FMtI+qj+zImYwd33i1t9TQUvQadm6AtyF0K6KyRNNW57LKt8Lr
 LZyttGo36FcXQTKuuhAH1tZZmkm/T70KjPJTIWBxpi0gOHijSl5dfBYmGl4is=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,271,1665439200"; 
   d="asc'?scan'208";a="84924384"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDGaBExlHK8XYRy6+UCGCKRcpcEOXrkczgcDIB?=
 =?us-ascii?q?73G9tvdVQSoGF8bA1/maEq8fmu8qeRWeZYRJkd3hhkJtZ78OdFNYfFbB?=
 =?us-ascii?q?xtCalP2G6P/3Y4mO0y1UpRrnDc8FboQLbYUNK0S79XxLP+SrNGnXpcqe?=
 =?us-ascii?q?QJBOCSp9RAF4WsDMRHgp8tyA=3D=3D?=
Received: from metis.ext.pengutronix.de ([85.220.165.71])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2022 12:57:01 +0100
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1p9399-0003j1-3j; Sat, 24 Dec 2022 12:56:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1p9397-001QLS-P6; Sat, 24 Dec 2022 12:56:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1p9397-007ZoX-4H; Sat, 24 Dec 2022 12:56:57 +0100
Date: Sat, 24 Dec 2022 12:56:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Message-ID: <20221224115657.kqyocti356cwm7hc@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2doephs5xxov5shz"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: cocci@inria.fr
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] coccinelle: How to remove a return at the end of a void
 function?
Reply-To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-Loop: cocci@inria.fr
X-Sequence: 782
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/20221224115657.kqyocti356cwm7hc%40pengutronix.de>


--2doephs5xxov5shz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I work on a patch set that eventually makes the function
rtsx_usb_sdmmc_drv_remove() return void:

A simplified spatch looks as follows:

-------->8--------
virtual patch

@p1@
identifier pdev;
@@
-int
+void
 rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
 <...
-return 0;
+return;
 ...>
 }
-------->8--------

This results in:

-------->8--------
diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_=
sdmmc.c
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1379,13 +1379,13 @@ static int rtsx_usb_sdmmc_drv_probe(stru
        return 0;
 }

-static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
+static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
 {
        struct rtsx_usb_sdmmc *host =3D platform_get_drvdata(pdev);
        struct mmc_host *mmc;

        if (!host)
-               return 0;
+               return;

        mmc =3D host->mmc;
        host->host_removal =3D true;
@@ -1416,7 +1416,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
        dev_dbg(&(pdev->dev),
                ": Realtek USB SD/MMC module has been removed\n");

-       return 0;
+       return;
 }

 #ifdef CONFIG_PM
-------->8--------

which is as intended. Now I want to remove the useless "return;" at the
end of the function, however adding

-------->8--------
@p2 depends on p1@
identifier pdev;
@@
 void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
 ...
-return;
 }
-------->8--------

to the spatch doesn't (only) do the intended:

-------->8--------
diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_=
sdmmc.c
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1379,13 +1379,13 @@ static int rtsx_usb_sdmmc_drv_probe(stru
        return 0;
 }

-static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
+static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
 {
        struct rtsx_usb_sdmmc *host =3D platform_get_drvdata(pdev);
        struct mmc_host *mmc;

        if (!host)
-               return 0;
+               {}

        mmc =3D host->mmc;
        host->host_removal =3D true;
@@ -1415,8 +1415,6 @@ static int rtsx_usb_sdmmc_drv_remove(str

        dev_dbg(&(pdev->dev),
                ": Realtek USB SD/MMC module has been removed\n");
-
-       return 0;
 }

 #ifdef CONFIG_PM
-------->8--------

It's obvious to me, why coccinelle also removes the first return, but
it's not obvious to me, how to prevent this and only drop the 2nd one.

Do you have a hint for me?

Thanks in advance and happy holidays,
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2doephs5xxov5shz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOm6QAACgkQwfwUeK3K
7AmXNQgAn8kqiII1CT3EGLBgDhKHQWo+UUdO6Pxetus5Rf82aH3v1AzZQ2bxLZgX
F3/xoYQv4LY5qrIHOqKqCW1eNHALfZkUNaxStMSzmlae3hJARQNBb6pTVAxkBFv+
FTHeHARe+G8sj68xM2nJrliZwuPh/hRhyYCfHK/Pji02xVAYb4LdXFWH5FiPkyxG
qamoM/NnEOsnRpN/IEKTpr9RNnEEfEaC+kMP74rqJNj6iBduapPFqnJRxRuYLGRE
jQUa/avGzA2TSkPiqv7bK/CH9iYoDQgI3q5gxDF/ATH/vzuTtrGQUeEkooG6qFho
kozxAy9EPPVYs2Wx3heFWe71mb34aQ==
=Te/w
-----END PGP SIGNATURE-----

--2doephs5xxov5shz--
