Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4B7C46467
	for <cocci@archiver.kernel.org>; Mon, 26 Dec 2022 07:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=zr1XZONSFzaNonx0zbMKWzkNph60kNsvOrfysrwwvxY=;
  b=BzTskeAqDXgXCh/VkIbPdINu7SeCEZa7dz0psbEEs4dByklCy+Ucm83Y
   wND2OqrRVBwFqUvQByQyr59UQYpX9sAwnXMIOy/Ernq/9jhYO3z8D7iGI
   RFucSv3Bnx7J3T4Rk8i13fubgMthGjRqhakgcgBasonvTvB8mKRhOzsp0
   E=;
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
X-IronPort-AV: E=Sophos;i="5.96,274,1665439200"; 
   d="asc'?scan'208";a="85059685"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2022 08:18:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 782D0E0141; Mon, 26 Dec 2022 08:18:41 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DE206E0128
	for <cocci@sympa.inria.fr>; Sun, 25 Dec 2022 22:20:20 +0100 (CET)
IronPort-SDR: 63a8be94_iE3It9LgaOlNx1sOeeMkNbi+u6oOXdEsCEYOowBCCpOAL2E
 Kg1bJmAPe0dgZQTRX4W2zrItXPwnbg5eyNz+BiA==
X-IPAS-Result: =?us-ascii?q?A0FeBADrvahj/0el3FVagQmDKiooB4EAVy0EC5QOgiUDm?=
 =?us-ascii?q?mV+gWqBcgcBAwEIBTUMAQIEAQEDAQODfoYRAh0HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQEAQECLUoPE4VoDYI4KQFSE2YBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBICsCCFJ9AQUnUhALGC5XBi6CZIMiBAOwMoEBM4EBoBiBFwoGgUCBV?=
 =?us-ascii?q?IVnD2eIcieCKYJRgTcHMD6EKoZYBIQbiBKMZQqBPXyBJw6BGANEHUADCzsyC?=
 =?us-ascii?q?kE1CwxLKxobB4EKKigVAwQEAwIGEwMiAg0oMRQEKRMNJyZrCQIDImEFAwMEK?=
 =?us-ascii?q?C0JQAcVESY8B1Y3AQQDAg8fNwYDCQMCH0+BICYFAwsVKkcECDYFBhw2EgIID?=
 =?us-ascii?q?xIPBiZDDkI3NhMGXAEqCw4TA1CBTgQvXoEJBikommuCH4EPLIFFOAF5wl8Hg?=
 =?us-ascii?q?iKBT6BGTJcEkiCXRqIGOoU+gXkmgVlxgzdOAxkPjiwWgQQBCIJ2iixBbgIHA?=
 =?us-ascii?q?QoBAQMJgjqDDQEBfoVcAQE?=
IronPort-PHdr: A9a23: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
 tXJm7/vMjBE8sKS8cZOX6Dp
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:v9/MZq/dh1d063SSDgpuk+A7I+orL9Y04lQ7vn2ZhyY1TiW9rb
 HIoB17726RtN9/Yh0dcLy7V5VoBEmsk6KdgrNhWItKPjOW21dARbsKheCJrgEIWReOlNK1vp
 0BT0ERMrPNJGk/tPvKpC+iE9ghx9GDtJulj+fGz3trUGhRGttdxjY8MC7ePlx3QE1tA50/GJ
 CAoup/zgDQAEg/X4CALj0oTujG4/nClJejTgUBA3ccmXGzpALt0pa/PwmZ2lMlWTtJxrsumF
 K16DDE2g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,273,1665439200"; 
   d="asc'?scan'208";a="43630778"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDHx2IApUDe2eG/4fAfZuCTImcFewd6gLx+rPF?=
 =?us-ascii?q?f7j4FuCRXolkWm6b9D0ekrhFXqjIXBg/MGMGO/+c3Cy5RTwQlDp8DBas?=
 =?us-ascii?q?yABfMByuZ0Kk8nTCZLNbUOvKqIa7Kmv9H1RwUFSjuootEtWTt4e4MIGO?=
 =?us-ascii?q?qCJJ230LfRcb7wgLDKeFNHcw=3D=3D?=
Received: from metis.ext.pengutronix.de ([85.220.165.71])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2022 22:20:20 +0100
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1p9YPo-0005qL-Hn; Sun, 25 Dec 2022 22:20:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1p9YPn-001j9R-2u; Sun, 25 Dec 2022 22:20:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1p9YPm-007tzD-Eq; Sun, 25 Dec 2022 22:20:14 +0100
Date: Sun, 25 Dec 2022 22:20:11 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: kernel@pengutronix.de, Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org, cocci@inria.fr
Message-ID: <20221225212011.6il5egocxtx5zupa@pengutronix.de>
References: <20221224115657.kqyocti356cwm7hc@pengutronix.de>
 <alpine.DEB.2.22.394.2212241326310.2711@hadrien>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ki4pjegaar3myre7"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2212241326310.2711@hadrien>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: cocci@inria.fr
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] coccinelle: How to remove a return at the end of a void
 function?
Reply-To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-Loop: cocci@inria.fr
X-Sequence: 787
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/20221225212011.6il5egocxtx5zupa%40pengutronix.de>


--ki4pjegaar3myre7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Julia,

first of all thanks for your quick answer.

On Sat, Dec 24, 2022 at 01:28:04PM +0100, Julia Lawall wrote:
> On Sat, 24 Dec 2022, Uwe Kleine-K=F6nig wrote:
> > A simplified spatch looks as follows:
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
> >  <...
> > -return 0;
> > +return;
> >  ...>
> >  }
> > -------->8--------
> >
> > This results in:
> >
> > -------->8--------
> > diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_=
usb_sdmmc.c
> > --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> > +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > @@ -1379,13 +1379,13 @@ static int rtsx_usb_sdmmc_drv_probe(stru
> >         return 0;
> >  }
> >
> > -static int rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
> > +static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
> >  {
> >         struct rtsx_usb_sdmmc *host =3D platform_get_drvdata(pdev);
> >         struct mmc_host *mmc;
> >
> >         if (!host)
> > -               return 0;
> > +               return;
> >
> >         mmc =3D host->mmc;
> >         host->host_removal =3D true;
> > @@ -1416,7 +1416,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
> >         dev_dbg(&(pdev->dev),
> >                 ": Realtek USB SD/MMC module has been removed\n");
> >
> > -       return 0;
> > +       return;
> >  }
> >
> >  #ifdef CONFIG_PM
> > -------->8--------
> >
> > which is as intended. Now I want to remove the useless "return;" at the
> > end of the function, however adding
> >
> > -------->8--------
> > @p2 depends on p1@
> > identifier pdev;
> > @@
> >  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
> >  ...
> > -return;
> >  }
> > -------->8--------
> >
> > to the spatch doesn't (only) do the intended:
>=20
> The problem is that Coccinelle is following the control-flow through the
> function, and all of the returns are at the end of a control.flow path.
> The simple, hacky solution is to change the return;s into some function
> call Return();, then do like the above for Return(); and then change the
> Return();s back to return;s

OK, I tried, but somehow coccinelle refuse to work after I introduced
Return(), even replacing them by return; doesn't work:

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
+return;
 ...
 }
-------->8--------

results in

-------->8--------
$ /usr/bin/spatch --debug -D patch --very-quiet --cocci-file scripts/coccin=
elle/api/test.cocci --patch . --dir drivers/mmc/host/rtsx_usb_sdmmc.c -I ./=
arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86=
/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./i=
nclude/generated/uapi --include ./include/linux/compiler-version.h --includ=
e ./include/linux/kconfig.h --jobs 4 --chunksize 1
diff -u -p a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_=
sdmmc.c
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1385,7 +1385,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
 	struct mmc_host *mmc;

 	if (!host)
-		return 0;
+		Return();

 	mmc =3D host->mmc;
 	host->host_removal =3D true;
@@ -1416,7 +1416,7 @@ static int rtsx_usb_sdmmc_drv_remove(str
 	dev_dbg(&(pdev->dev),
 		": Realtek USB SD/MMC module has been removed\n");

-	return 0;
+	Return();
 }

 #ifdef CONFIG_PM
-------->8--------

Adding --debug doesn't give any hints.

(And if I add another hunk inbeetween removing Return at the end of the
function there is no effect either.)

Do I need to split that in two spatches to make coccinelle cooperate?

(If it matters, this is coccinelle as shipped by Debian, Version
1.1.1.deb-2)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ki4pjegaar3myre7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOovogACgkQwfwUeK3K
7AkDrAgAgRfDs2k7V4+HC3weOMPwPKgObjnDeQbPp/DLiOB56rRtLYow+Tdl1Vio
v0U5HR25ngVdGO1ZbSDm5lfg0QIgv17e7+3Ko6IS/oj4JHA10MWvMZ+dcrvhT8Kz
2bu+W2EMMbDBCYVh586E3BuoQrsVysn4BFh2QKpBWjjKS2giwPaAp7n5HgjMt3Ve
iA0YGlao8I1CK/gVCu7GzVW8n/wfpatYIVts1y+P3a8bZk+SylCYAjwl0GGHq9fO
OVQmhGjvHoXuBeTGRyvgjCr3Sc/LW93rOZnyu0SQUPBsLQVtiYTASyV/jBH19wu1
Dg1+GinznKY6cCeb7vDoL/1DHpo7+g==
=Kwk3
-----END PGP SIGNATURE-----

--ki4pjegaar3myre7--
