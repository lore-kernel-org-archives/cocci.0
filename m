Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7DCC4167B
	for <cocci@archiver.kernel.org>; Tue, 27 Dec 2022 12:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=uzhl1YJj5aQ+NS8gOUuqVvf4lgYJ10mMtqEuH+AmyUA=;
  b=R0gYFBftvUTem8bP2fHjXqPY/noWt34p6iCrIVkjX4ZhVubCH8WWjv72
   waeKAuhHH+oBjOsIkL0Db0xd6vOcc3CsURfhXqg3PPsooUrPE0kRXzTBx
   2MxFq+qwAzJpy+yGuctSYYmedsKWPrW4TZPd9jAwCSvKGuuxrcyTdXr2a
   g=;
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
X-IronPort-AV: E=Sophos;i="5.96,278,1665439200"; 
   d="asc'?scan'208";a="85153761"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2022 13:51:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9C012E0138; Tue, 27 Dec 2022 13:51:34 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 033FEE0128
	for <cocci@sympa.inria.fr>; Tue, 27 Dec 2022 12:55:13 +0100 (CET)
IronPort-SDR: 63aadd21_u9y5Y1+1iF+agxBXL+xaiP6M21Vsp1H78GRrS35VVYhEwwd
 l1AT5vcu5H0kmj5YyMyx6bINFDj7MCQD99td32A==
X-IPAS-Result: =?us-ascii?q?A0E1AgBh26pjjEel3FVaHgEBCxIMQIFEC4FbUoEHVy0EC?=
 =?us-ascii?q?5QOgiiaZX6BVoIGBwEDAQgFNQwBAgQBAQMBA4N+hhICHQcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBAQEZJxATIoVoDYI4KQFSE?=
 =?us-ascii?q?2YBAQEBAQEBAQEBAQEBAQEBICsCCFJ9AQV5EAsYLlcGLoJjAYMiBAOvEYE0g?=
 =?us-ascii?q?QGgGIEXCgaBQIFUhWcPZ4hyJ4IphAgHMD6LAgSEG5R1CoE9fIEnDoEbA0QdQ?=
 =?us-ascii?q?AMLOzIKQTULDEsrGhsHgQoqKBUDBAQDAgYTAyICDSgxFAQpEw0nJmsJAgMiY?=
 =?us-ascii?q?QUDAwQoLQlABxURJDwHVjcBBAMCDx83BgMJAwIhUYEgJAUDCxUqRwQINgUGG?=
 =?us-ascii?q?zYSAggPEg8GJkMOQTc2EwZcASoLDhMDUIFOBC9egQkGKSiaZoNagX3DWQeCI?=
 =?us-ascii?q?oFPoEZMg2aTHpIgl0aiBjqFPoFiOoFccYM3TgMZD44sFoQDiixBbgIHAQoBA?=
 =?us-ascii?q?QMJgjqDDQEBfoVcAQE?=
IronPort-PHdr: A9a23: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
 8TVk6TyOHFO/oCMlfY=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:le4CgaHFMDR8i+e5pLqEC8eALOsnbusQ8zAXPo5KKCC9Vvbo8P
 xG/c5rsSMc5wx8ZJhNo7+90ey7MBXhHP1OkOws1NWZLWrbUQKTRekIh+bfKn/bak/DH4VmtZ
 uIHZIRNPTASWFGvILd+wm3E9EpxZ29/KqpnOfTyGoFd3ARV4hQqz1QTiqLEkkzbg9AApYyCd
 6936N81kOdUEVSVOz+KmgEW6zmr93P0L38ZxpuPW9e1CC+yQmBrJLqExzd5B0XVDRCzN4ZgB
 P4rzA=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,278,1665439200"; 
   d="asc'?scan'208";a="85150154"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDHqnNjiyKlLZ1YVhR7bPSRmLPu3BlMRKU7T6F?=
 =?us-ascii?q?cdfD3MLzO6f327svhY8STGrt9SIFm8DtVGk4LA6FZ1MxmTeE/8oI/Sym?=
 =?us-ascii?q?04n97jQkweXAGv7Trk1NFwgBUdcI4AjLlfh+NxmUMbx2Icsy8d6rNhUl?=
 =?us-ascii?q?AahC9Nd1cSUDbteVDIdJjHfQ=3D=3D?=
Received: from metis.ext.pengutronix.de ([85.220.165.71])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 12:55:12 +0100
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1pA8Y0-0002mr-VL; Tue, 27 Dec 2022 12:55:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pA8Xy-0023lf-8G; Tue, 27 Dec 2022 12:55:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pA8Xx-008Hfk-Gq; Tue, 27 Dec 2022 12:55:05 +0100
Date: Tue, 27 Dec 2022 12:54:31 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, cocci@inria.fr
Message-ID: <20221227115431.rugxkddjfn3p7edw@pengutronix.de>
References: <20221224115657.kqyocti356cwm7hc@pengutronix.de>
 <alpine.DEB.2.22.394.2212241326310.2711@hadrien>
 <20221225212011.6il5egocxtx5zupa@pengutronix.de>
 <be39f7d-31ab-24c-61c5-6daabdef9267@inria.fr>
 <20221227095517.mzjmqse5wvaielev@pengutronix.de>
 <e39bbae4-7929-b1b0-ea42-11825d98e43e@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6sndfywr47jhjoeu"
Content-Disposition: inline
In-Reply-To: <e39bbae4-7929-b1b0-ea42-11825d98e43e@inria.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: cocci@inria.fr
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] coccinelle: How to remove a return at the end of a void
 function?
Reply-To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-Loop: cocci@inria.fr
X-Sequence: 802
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/20221227115431.rugxkddjfn3p7edw%40pengutronix.de>


--6sndfywr47jhjoeu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Julia,

On Tue, Dec 27, 2022 at 12:26:50PM +0100, Julia Lawall wrote:
> > @p2@
> > identifier pdev;
> > @@
> >  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
> >  ...
> > -Return();
> >  }
>=20
> You need when any on the ... to allow there to be Returns();s along the
> way.

\o/ that works fine, thanks

(i.e.

	... when any

instead of ...)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6sndfywr47jhjoeu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOq3O8ACgkQwfwUeK3K
7AmZvgf/bnJvLM+V7hpUZUd/mPatguX/S3blr/i0Vjmyl9F4yBYr5+BiFAgV4f37
gn4VTf4uqjgnq0jNjtQ7SesGX5ErJyEfMpxDgSYkLanMMro7qRyyAjpDEsqxrcC1
j3N8B1W0YoMVbELgS6Vznl4mCQONU/y/BfUsFWX240zn41NVqZck6rugsPl0dM+a
K8ZUYKm9nZ2+9JvoO2PyZmpVw7WiaNIkH0+zfIXzFzNi95/0WkQkKSNnatn5CXFn
PBOTN8Nc2+WtchbP1PM6jf7c4+MXFjHrdcgRgFaWrFNjh0NMaKZacJM8AI+KmRl2
qMMk/rD+qZ/49QsU8crG5N9jkSFedA==
=UJAR
-----END PGP SIGNATURE-----

--6sndfywr47jhjoeu--
