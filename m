Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FC3C4332F
	for <cocci@archiver.kernel.org>; Tue,  8 Nov 2022 05:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=1HubRRhB6cxc/AfZ0UEFi9xKEIcI6WCKn+E6yV0GZfY=;
  b=Eyle4cHLDbD8+oRYNm9YhJHQ0RgBQw+kMD8poUecRBdcblm3+/GOqgNg
   J8jpGbOO1CASjQ0P3dTQ7EisbzcvH3jMcHg8q2UgxlFsn5aMq5ysd/+Cg
   s/H/ujo8YEkIMc42pGb4/SisYgu9fpXHjezmpzxurrXpxRDyocV4ufMYZ
   M=;
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
X-IronPort-AV: E=Sophos;i="5.96,145,1665439200"; 
   d="asc'?scan'208";a="77134539"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2022 06:52:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8F7E3E0236; Tue,  8 Nov 2022 06:52:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B63B7E0157
	for <cocci@sympa.inria.fr>; Mon,  7 Nov 2022 21:08:20 +0100 (CET)
IronPort-SDR: 636965b4_/odTlh5r7hOpbSVf3GR2GSMaCP0byK3VKmuoKFSA7pJnQ+c
 N6Ykah/yyvlagBSXx6Uu/3+bqO/gVgCUoGxn9Lw==
X-IPAS-Result: =?us-ascii?q?A0ADAAC3ZGljkEel3FVaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBgXsFAQEBAQsBgVpSgQJXLQQLRYROiB+IewOXVIVXgg0BAwEIB?=
 =?us-ascii?q?TUMAQIEAQGDcoYNAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBAETAQEBAQEBFgkeEA4FIoVoDYI1KQGDZAEFI1YQCxgjBwICVwYugmIBg?=
 =?us-ascii?q?yEEA0+pZYEygQGgFoEXEIFAAYFThWOFK4QnJ4IpgRWDKj6IG4JnBIEHlkoDR?=
 =?us-ascii?q?B1AAws7Mg1KGzEnDgkfHA4XDQUGEgMgbgVBDygvZyscGweBDCooFQMEBAMCB?=
 =?us-ascii?q?hMDIgINKTEUBCkSDSsnbwkCAyJlBQMDBCgsAwlABxYRJDwHVzoBBAMCECI6B?=
 =?us-ascii?q?gMJAwIiE0SBJCYFAw0XJQgFTgQIOQUGUxICChEDEg8GJkcOSj45FgYnRAEzD?=
 =?us-ascii?q?g4UA16BbQQ1Z5h1ghtfGxMsgRFaGQ8okleCfI8inXAHgh6BTItMlGxMg3iBU?=
 =?us-ascii?q?YsChjA3jkCDIy2HHI9ooj2FOoFiOoFbcYM2CUYDGQ9djXqDboY+g25BMzsCB?=
 =?us-ascii?q?wEKAQEDCYI6gw0BAX6DQl0BAQ?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:IvNRMa0NVIJ1pqtv9sQzsAqjBFEkLtp133Aq2lEZdPWaSK2lfu
 SV7ZMmPH7P+VIssR4b9exoVJPufZqYz+8S3WBzB8bGYOCFghrKEGgK1+KLqFeMJ8S9zJ8+6U
 4KSchD4bPLY2RSvILC3Tj9Nc0hztmB+KXtvuvVz25sQQZ2ApsQlTtRO0KgOglbVQlDQbA+E5
 2R7NcChwPIQwVvUu2LQkMsG8TTp9mOsJrnZFooHBgigTP+9Q+A2frBO1y1zxcbFwlEybAk/W
 WtqX2D2pme
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,145,1665439200"; 
   d="asc'?scan'208";a="39135143"
X-MGA-submission: =?us-ascii?q?MDEuYuH5XwEBJrr2E9Up+h54O8iZpcw95wzm8K?=
 =?us-ascii?q?HDL8CzotnHbM8GEJQEZGR9ujEkvnyrCOTQKArGoQzGK/Yya0kVxEFoHc?=
 =?us-ascii?q?0CD1A1cmDApW8X2cr6uucnaq3n47wpUCa/A/fTF7lg+6fIajWIO9rQ65?=
 =?us-ascii?q?TZ7fI3714y2mpZiJyepXyFVA=3D=3D?=
Received: from metis.ext.pengutronix.de ([85.220.165.71])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 21:08:20 +0100
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1os8Pr-0004hl-2U; Mon, 07 Nov 2022 21:08:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1os8Po-002uxE-Hn; Mon, 07 Nov 2022 21:08:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1os8Po-00F2U1-Q7; Mon, 07 Nov 2022 21:08:16 +0100
Date: Mon, 7 Nov 2022 21:08:15 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>,
	kernel-janitors@vger.kernel.org,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Message-ID: <20221107200815.u7hcwejileeabnct@pengutronix.de>
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
 <bd13da2d-6d18-4f33-0987-a193e3c9b761@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2znbbrzwbbfnunan"
Content-Disposition: inline
In-Reply-To: <bd13da2d-6d18-4f33-0987-a193e3c9b761@web.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: cocci@inria.fr
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Reply-To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-Loop: cocci@inria.fr
X-Sequence: 722
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/20221107200815.u7hcwejileeabnct%40pengutronix.de>


--2znbbrzwbbfnunan
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 08:00:33PM +0100, Markus Elfring wrote:
>=20
> > devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalent=
 to
> > the shorter devm_platform_ioremap_resource(pdev, index).
> =E2=80=A6
> >  create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resour=
ce.cocci
> =E2=80=A6
> > +@depends on patch@
> > +expression pdev,index;
> > +position p !=3D r1.p;
>=20
>=20
> Why do you think that different source code positions would be required f=
or
> your transformation approach?

That is important that the implementation of
devm_platform_ioremap_resource isn't adapted.

> > +@@
> > +
> > +-  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
> > ++  devm_platform_ioremap_resource(pdev, index)
>=20
> I suggest to use the following SmPL code variant instead.
>=20
> -devm_platform_get_and_ioremap_resource@p
> +devm_platform_ioremap_resource
> =C2=A0(pdev, index
> - , NULL
> =C2=A0)

I don't care much, but IMHO my variant is easier to read. Might be
subjective, though.
=20
> > +@r2 depends on !patch exists@
> > +expression pdev,index;
> > +position p;
> > +@@
> > +
> > +*  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
>=20
>=20
> I doubt that the usage of the SmPL asterisk is appropriate for the operat=
ion
> modes =E2=80=9Corg=E2=80=9D and =E2=80=9Creport=E2=80=9D.

I have no idea about org and report modes. When I try these I get a
python2 error message:

	uwe@taurus:~/gsrc/linux$ make coccicheck
	You have not explicitly specified the mode to use. Using default "report" =
mode.
	Available modes are the following: patch, report, context, org, chain
	You can specify the mode with "make coccicheck MODE=3D<mode>"
	Note however that some modes are not implemented by some semantic patches.

	Please check for false positives in the output before submitting a patch.
	When using "patch" mode, carefully review the patch before submitting it.

	/usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scrip=
ts/coccinelle/api/alloc/alloc_cast.cocci --no-includes --include-headers --=
dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I=
 ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/=
uapi -I ./include/generated/uapi --include ./include/linux/compiler-version=
=2Eh --include ./include/linux/kconfig.h --jobs 4 --chunksize 1
	Py.find_library: unable to find the Python library [libpython2.7m.so retur=
ned libpython2.7m.so: cannot open shared object file: No such file or direc=
tory] [/usr/bin/../lib/libpython2.7m.so returned /usr/bin/../lib/libpython2=
=2E7m.so: cannot open shared object file: No such file or directory] [libpy=
thon2.7.so returned libpython2.7.so: cannot open shared object file: No suc=
h file or directory] [/usr/bin/../lib/libpython2.7.so returned /usr/bin/../=
lib/libpython2.7.so: cannot open shared object file: No such file or direct=
ory]
	coccicheck failed
	make: *** [Makefile:2076: coccicheck] Error 255

After uninstalling python2 this ends in:

	Cannot find Python library
	coccicheck failed
	make: *** [Makefile:2076: coccicheck] Error 255

Didn't try to debug that any further. Is that worth a bug report against
coccinelle (which is shipped by my distribution)?

I tried to adapt the org and report modes from other patches in the same
directory. So a critical glimpse by someone more knowledgable than me is
recommended. However I don't know how to react to "I doubt ... is
appropriate", I'd need a more constructive feedback to act on.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2znbbrzwbbfnunan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNpZawACgkQwfwUeK3K
7Anu5Af/bCL4Ho3MLIFESvBK68u9hFLkpJHSnfsw/IgXyv4nTFjhkLKs8M2/NBJP
OXeNBO9lptRWcG9lUswYJnppG5ffuxrDzodLORNKqGLww9lJdkjfw7OnUuD+s6jl
m1YlOOl/GZ1uyW6kJuh1l0opoMiyoCwFybVm2tjC27aQs9c0hepcBqJft1dHYrPQ
gkMfYlTx5Ug3df3BHg9KwQlr3QmwayF5d9bYpRz82k//PTsDL95bKMDSGjdxiCcl
4thhdak2QFekeg4iI/tmPDOuaNtjZRJBRdD9Z6KtfmU0xiXSla/9v6nQt9v9iBWQ
xKGrDfpuV0g5Jxi0bUqAeRZ7Au4lkA==
=6M80
-----END PGP SIGNATURE-----

--2znbbrzwbbfnunan--
