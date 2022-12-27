Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0723DC4332F
	for <cocci@archiver.kernel.org>; Tue, 27 Dec 2022 11:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=bbnmJa2FLBNpLsDSRN53QPmjFKbRLV8i60HOv/Qy/K0=;
  b=vORmBlXD0/Q4tDEvabZZzH6QldRT3v5c3URafynT9ax1nizZUlNry7kA
   sQFPpCOAgMQsB7gDjqYmtAGnHV5ETa8tXA5/xTquF1k9wiJ8X+JqIvHFJ
   2iLtxA9ikfVgsKiTx4USxUzgDp0MnXwedhrPJLa1y1GNnLGsojmIj31J+
   8=;
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
   d="asc'?scan'208";a="85148306"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2022 12:25:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 078C3E0145; Tue, 27 Dec 2022 12:25:56 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 15F5BE0128
	for <cocci@sympa.inria.fr>; Tue, 27 Dec 2022 10:55:27 +0100 (CET)
IronPort-SDR: 63aac10f_HL7YHjU/wk7Xm4Q6MvI1UBPAv6pEgaRQ9puxEeqGccEt6B7
 InmBMxrv4nese//HH88Cm/A6EptCQx0v7ecVyrg==
X-IPAS-Result: =?us-ascii?q?A0GyAACjwKpjjEel3FVaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YFaKiiBB1ctBAtFk0mCJQOaZX6BaoFyBwEDAQgFOQgBAgQBAQMBAgGDfoYSA?=
 =?us-ascii?q?h0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEBG?=
 =?us-ascii?q?ScQEyKFaA2COCkBUhNmAQEBAQEBAQEBAQEBAQEBASACAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECCFJ8AQECAgEnUgULCxguV?=
 =?us-ascii?q?wYugmMBgn8jBAMMrkJ4gQEzgQGDZkGbcYEXCgaBQAGBU4VnD2eIcieCKYJRg?=
 =?us-ascii?q?TcHMD6CYgOBRYZYBIwsjGoKgT19gScOgRsDRB1AAws7MgpBNQsMSysaGweBC?=
 =?us-ascii?q?iooFQMEBAMCBhMDIgINKDEUBCkTDScmawkCAyJhBQMDBCgtCUAHFREkPAdWN?=
 =?us-ascii?q?wEEAwIPHzcGAwkDAiFRgSAmBQMLFSpHBAg2BQYbNhICCA8SDwYmRA5CNzYTB?=
 =?us-ascii?q?lwBKgsOEwNQgU8EL16BCQYpKJptggAfYkkOAntKOCJYkkGwHgeCIoFPi1OUc?=
 =?us-ascii?q?0yXBJIgl0aNRpRAOoU+gXgkgVxxgzZPAxkPjiwWgQQBCIJ2gQuJIUEzAgE4A?=
 =?us-ascii?q?gcBCgEBAwmCOoMNAQGGWgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:TiHmuqPuU8JVVcBcTiKjsMiBIKoaSvp037Dk7SFMoDhuA6ulfq
 GV7ZAmPHDP5Ar5NEtOpTnEAtjnfZq+z+8R3WByB8bAYOCOggLBR+sO0WKh+UyDJ8SUzI5gPM
 lbHZRWOZnIMGk/q9377gm+G9Nl+9WM8LmpieDCpk0dNz1CWuVbx0NUGwaeVmdxQw5LD4d8NK
 P03Ls/mxOQPU4+KuirBn1Ae+DCopnlj5TjCCR2fyIP2U21pXeF+b7/VyKT1hAYXz4n+8ZYzV
 T4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,278,1665439200"; 
   d="asc'?scan'208";a="85139793"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDGhzZD7oKgFn2pBfqetOv7EaS7lCO5xkgMT+0?=
 =?us-ascii?q?TcZToim/PKkGzIw1oR1UsldXNooT8FeobsfCUuKqTLgeDyOpSUsVLLTu?=
 =?us-ascii?q?qoMZQda9QO2VBmf/YMkY2UjX2UXtb1yAcI8ejImRO7zLVYkPdD1iWjKH?=
 =?us-ascii?q?qtqZ7Tmq46IyghgbJIKXq3bQ=3D=3D?=
Received: from metis.ext.pengutronix.de ([85.220.165.71])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 10:55:27 +0100
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1pA6g7-00084I-Km; Tue, 27 Dec 2022 10:55:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pA6g4-0022i6-Lq; Tue, 27 Dec 2022 10:55:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pA6g3-008GVS-Rf; Tue, 27 Dec 2022 10:55:19 +0100
Date: Tue, 27 Dec 2022 10:55:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, cocci@inria.fr
Message-ID: <20221227095517.mzjmqse5wvaielev@pengutronix.de>
References: <20221224115657.kqyocti356cwm7hc@pengutronix.de>
 <alpine.DEB.2.22.394.2212241326310.2711@hadrien>
 <20221225212011.6il5egocxtx5zupa@pengutronix.de>
 <be39f7d-31ab-24c-61c5-6daabdef9267@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t4ou3e5qjzu7togz"
Content-Disposition: inline
In-Reply-To: <be39f7d-31ab-24c-61c5-6daabdef9267@inria.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: cocci@inria.fr
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] coccinelle: How to remove a return at the end of a void
 function?
Reply-To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-Loop: cocci@inria.fr
X-Sequence: 799
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/20221227095517.mzjmqse5wvaielev%40pengutronix.de>


--t4ou3e5qjzu7togz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Julia,

On Mon, Dec 26, 2022 at 05:02:35PM +0100, Julia Lawall wrote:
> On Sun, 25 Dec 2022, Uwe Kleine-K=F6nig wrote:
>=20
> > Hello Julia,
> >
> > first of all thanks for your quick answer.
> >
> > On Sat, Dec 24, 2022 at 01:28:04PM +0100, Julia Lawall wrote:
> > > On Sat, 24 Dec 2022, Uwe Kleine-K=F6nig wrote:
> > > > A simplified spatch looks as follows:
> > > >
> > > > -------->8--------
> > > > virtual patch
> > > >
> > > > @p1@
> > > > identifier pdev;
> > > > @@
> > > > -int
> > > > +void
> > > >  rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
> > > >  <...
> > > > -return 0;
> > > > +return;
> > > >  ...>
> > > >  }
> > > > -------->8--------
> > > >
> > > > This results in:
> > > >
> > > > -------->8--------
> > > > diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/r=
tsx_usb_sdmmc.c
> > > > --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> > > > +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > > > @@ -1379,13 +1379,13 @@ static int rtsx_usb_sdmmc_drv_probe(stru
> > > >         return 0;
> > > >  }
> > > >
> > > > -static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
> > > > +static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
> > > >  {
> > > >         struct rtsx_usb_sdmmc *host =3D platform_get_drvdata(pdev);
> > > >         struct mmc_host *mmc;
> > > >
> > > >         if (!host)
> > > > -               return 0;
> > > > +               return;
> > > >
> > > >         mmc =3D host->mmc;
> > > >         host->host_removal =3D true;
> > > > @@ -1416,7 +1416,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
> > > >         dev_dbg(&(pdev->dev),
> > > >                 ": Realtek USB SD/MMC module has been removed\n");
> > > >
> > > > -       return 0;
> > > > +       return;
> > > >  }
> > > >
> > > >  #ifdef CONFIG_PM
> > > > -------->8--------
> > > >
> > > > which is as intended. Now I want to remove the useless "return;" at=
 the
> > > > end of the function, however adding
> > > >
> > > > -------->8--------
> > > > @p2 depends on p1@
> > > > identifier pdev;
> > > > @@
> > > >  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
> > > >  ...
> > > > -return;
> > > >  }
> > > > -------->8--------
> > > >
> > > > to the spatch doesn't (only) do the intended:
> > >
> > > The problem is that Coccinelle is following the control-flow through =
the
> > > function, and all of the returns are at the end of a control.flow pat=
h.
> > > The simple, hacky solution is to change the return;s into some functi=
on
> > > call Return();, then do like the above for Return(); and then change =
the
> > > Return();s back to return;s
> >
> > OK, I tried, but somehow coccinelle refuse to work after I introduced
> > Return(), even replacing them by return; doesn't work:
> >
> > -------->8--------
> > virtual patch
> >
> > @p1@
> > identifier pdev;
> > @@
> > -int
> > +void
> >  rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
> >  ...
> > -return 0;
> > +Return();
> >  ...
> >  }
> >
> > @p2@
> > identifier pdev;
> > @@
> >  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
> >  ...
> > -Return();
> > +return;
> >  ...
> >  }
>=20
> The problem is that a control-flow path at this point can have multiple
> calls to Return();  You pattern only matches when every control-flow path
> through the code has exactly one Return().

Ah, ok. This wasn't clear to me from reading the documentation (e.g.
https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.html)
=20
> You should have one rule that removes the final Return();
>=20
>  @p2@
>  identifier pdev;
>  @@
>   void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
>   ...
>  -Return();
>   }
>=20
> Then another rule to remove the others:
>=20
>  @p2@
>  identifier pdev;
>  @@
>   void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
>   <...
>  -Return();
>  +return;
>   ...>
>   }

I now have

-------->8--------
virtual patch

@p1@
identifier pdev;
@@
-int
+void
 rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
 ...
-return 0;
+Return();
 ...
 }

@p2@
identifier pdev;
@@
 void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
 ...
-Return();
 }

@p3@
identifier pdev;
@@
 void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
 <...
-Return();
+return;
 ...>
 }
-------->8--------

But there p2 suffers from the same problem and only matches
code paths with exactly 1 Return(). So the above results in

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

and only if I remove the "if (!host) return 0;" block before patch
generation, the final return is also dropped.=20

I think this is good enough for me, as there are not too many cases like
the above. If there is spatch that does the desired change (i.e.

-------->8--------
diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_=
sdmmc.c
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1379,13 +1379,11 @@ static int rtsx_usb_sdmmc_drv_probe(stru
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
-
-       return 0;
 }

 #ifdef CONFIG_PM
-------->8--------
) I'd be happy to hear and learn about it.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--t4ou3e5qjzu7togz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOqwQIACgkQwfwUeK3K
7AlaUQf+Pcfi/G+8ytKf0fujae79ImbfP5j3cieCyCRmFZoysWDC1zzQhhu6+Lcn
1nwIypCsa9bW7LtZ+Zuu+r8rJMF+WMRoNtFZWyxLAlrkjmLNZTiTQlKUXamBHhMS
CtqPMluANCpVzsD2lc/bM/LhrZvqt+svIYMy/8SJj8ShqC8J+kJmi8PgP0ofpBlu
b5kqRUMdkNxz3/WppZ756D5rbdqyXHAydJZvavUbzU2eOFR61kOaydACjtRyr00w
OtezgQWgrDLzcwvsfSUVD9uEV74jpYEjM57l1C2jWWHHQMVBpK6w5CNwZj5Zn3kz
B9lljLL3ZPrrVw3VLAnnWl81308ydg==
=1Wto
-----END PGP SIGNATURE-----

--t4ou3e5qjzu7togz--
