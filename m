Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB502C4332F
	for <cocci@archiver.kernel.org>; Wed,  9 Nov 2022 11:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=w3Bna5ibdc3+BUXVbrKZPp0eEUsKlkePRjTB8RXTQzg=;
  b=YL/V+SDiaRYDjHUWhWUJwjhQ3hHiBmJPgTL9ENw5o1DbDYKou+V7LNgr
   BG093wAh3bBtHpePNSgA69B1z9fkA9MPFFg9QSobrJXboKHKfdP0K6bHu
   NuG/lQaWf2dHiUJxibWiKKEofxOHNMA6yaF7w3uXLw7acdnwcEsuWDhgT
   Y=;
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
   d="asc'?scan'208";a="77446417"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2022 12:48:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A6DBBE039C; Wed,  9 Nov 2022 12:48:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0663CE0157
	for <cocci@sympa.inria.fr>; Mon,  7 Nov 2022 19:11:49 +0100 (CET)
IronPort-SDR: 63694a64_Uf02BBl+c+f9WR4w8dWGjuMOC5YaFm3H2u1UZt1UmLZ0RQ4
 yqziX+sS68sSYG00ly41b9aLUUhzhUZHVEw2ssw==
X-IPAS-Result: =?us-ascii?q?A0DDAgClSWljkEel3FVaHQEBAQEJARIBBQUBQIFPgVtSg?=
 =?us-ascii?q?QJXLQQLRZVoA4ETlkGHZAEDAQgFNQwBAgQBAYNyhg0CHQcBBDQTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQEBARYJHhAOBSKFaA2CNSkBg?=
 =?us-ascii?q?2QBBXkQIy5XBhMbgmIBgyEEA6oXgTSBAaAWgRcKBoFAgVSFVQ4PV4RFgkSBY?=
 =?us-ascii?q?yeCKYEVgTyBN3WLAgSBB4swixQDRB1AAws7Mg1KGzEnDgkfHA4XDQUGEgMgb?=
 =?us-ascii?q?gVBDygvZyscGweBDCooFQMEBAMCBhMDIgINKTEUBCkSDSsnbwkCAyJlBQMDB?=
 =?us-ascii?q?CgsAwlAByckPAdXOgUDAhAiOgYDCQMCIhNEgSQmBQMNFyUIBU4ECDkFBlMSA?=
 =?us-ascii?q?goRAxIPLEcOSj45FgYnRAEzDg4UA16BbQSZdIIaAXoTLIF9kxWSHp1wB4Ieg?=
 =?us-ascii?q?UygOEyWe5IaLYccj2iiOTmFBYF5I4FbcYM2TwMZD45Xg26KLEEzOwIHAQoBA?=
 =?us-ascii?q?QMJgjqDDQEBfoQfAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:3VE02ai8uGjXmxY9JIMLjSy1X161gBQKZh0ujC45NGQN5FlHY01je
 htvWDvUOP+CYTH9Ltt3PI20800P75LcxtIySFFrqn8wFSpjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UqicUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYpdDNKg06/gEk35q6r4WtH5gZWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv4+lpTWhRiro/6ZWBiuFIOM0SRqkQqShgJ70oOHKF0hXG7JNm+t4sZJ
 N1l7fRcQOqyV0HGsLx1vxJwS0mSMUDakVPKCSDXjCCd86HJW3/A8ftUNGcNBJMZueBoOHsWr
 P1HDy9YO3hvh8ruqF66YuxhmsU4asT7IMUHt3dv0C3DCvAnUdbPTs0m5/cIgXFq3JgIRKiDI
 ZVAAdZsREyojxlnJ1QTIIozmui1mmP4dTxI7l6YzUYyyzOClVYggeWxWDbTUtyuXJxlklijn
 E7L9F3HBSAdOoWawyXQpxpAgceWwHmrBthCfFGizdZhh1aYx0QIGRgOXB26p+O4gwiwQbpix
 1c8/ycyrLN0+Vy3CMHwWRKlvGSDuB8MHdZdewEn1O2T4q740QijPk4/dyBAK9o5jdVuHD118
 UDcyrsFGgdTmLGSTHuc8JKdojWzJTUZIAc+WMMUcecWy4Wy+tts03ojWv4yTv/p3rUZDBmpm
 2jSxBXSkYn/muYn+s1XF3jkniqiq4LbQwoxjuk8dj35sFgkDGJJT6ah5VXdqMldNpqFQ1yLs
 WIL8/VyAcgLAI2Mj2qAUPlLBLyv6OuZKjragE4pE5RJG9WRF5yLI9s4DNJWfh8B3iM4ldnBO
 h67VeR5vs47AZdSRfUrC79d8uxzpUQaKfzrV+rPcv1FaYVreQmM8UlGPBDOgD+wwRR2zP1nY
 f93lPpA615EVMyLKxLoF48gPUMDn3hWKZ77HMyjkk39uVZgTCfMF+9t3KSyghARtf7e8FuPo
 76zxuOPyF1ZXfHsbija95UPIBgFKHI7Td6+oMsRPu2MSjeK60l+Y8I9NYgJItQ/94wMz7eg1
 izjBidwlQSu7VWZcl/iQi44N9vSsWNX8S5T0doEZgzzihDOoO+HsM8iSnfAVeB9rbIynKYuH
 qZtlgfpKq0ndwkrMg81NfHVxLGOvjzy7e5XF3r0PGoMbNR7ShbX+9TpWALq+WNcRmC0rMYy6
 fnonA/SXZNJFUwoAdf0ecCf6Qq7nUEcv+ZuAGrOAN1YI3v3/KZQdifes/4QIuM3Eyvl+Ae07
 QisPEonlbH/mLNtqNjtroKYnritCNp7TxZ7HXGEzLOYNhv632uEwK1fYtnVezztbnL+ovi6a
 M4IzMPHEeYmmWxSuNFWCIdbzqMZ5vruqYRFzw9iIm75UlSzBp5kIViExcNqtJAR9oRGuACzZ
 F2DyuNaNZqNJsnhNlwbfyghUciuytAWnWP0wckuAUCn+hJywqWLYX9SMzaIliZZCrl/a6Eh4
 OU5vf8p+x6NsQUrPvmGnxJr2Ty1dFJYaJoet7YeHIPPoSgowAsbYZXjVwnH0KvWYNBIakQXM
 juYgZTZvItlx23ATSsXNWPM1u9jl5gxqEh07FsdFW+oxPvBpNEKhSN0zxpmbz577Bt918BLB
 lNKLGxwfKWHwCdpjpNMXkeqAABwOyea8U3QlXoPvmnTSkXxWkzvMmc4Pbqp+Xod0mNDfwp0+
 KOT53blXA3LIuDw/HoWcmx0p8PzSede8lX5p/mmOMCeDr8GYTbBqY2/V1oi8hfIL5s4uxzam
 LNM4u11V5zeCQcRhK8KU6+hyrUaTUG/FlxoGP1O0vsAIjDBRWuUxzOLFkGWf/FNLdzs9WuTK
 ZRnBuBLZiSE+Be+lBIpLo9SHOYsh98s3sQIRZ3zL21fs7e/kCtggKiNygfA3l0UU/dcuudjD
 LOJbD+TMH2itV0NkU/3kcR0EG6ZY94FWQ7C4N6I4Ng5T5ItjMw8cGUZ8KeFgHGOAQ42ozOWp
 FziYoHV/cxDyKNtvZfeIp9bDBTpLd7TbfmD3z6ugY9wNdjKYNrHhwwImHbaPiB9H7gYa/Jon
 5uj7f/120Lkuu4tcmb7wpOuKYhA1f+QbsF2bP3lCWZ8tjSTfvPs7z8o2XGKGbYQnPxzvsCYF
 haFMu2uftsravJh7XxyaRkGNS0CCq7yP5zSlQnko9uiUhEigBH6dvW5/nrUbEZeRC8CG7v6L
 iTW4/+OxNRpnL5gNS8+JcNNIsFHeQf4eK4cadfOmyGSDTCojnO8q7LSr0ccxg+ROEaUMvTRw
 MzjdkHyei3n7euMhJtcvpdptxIaMGdljKNiNggB8tpxkHahAHRAMe0ZNo4cB4pJljDpkqv1f
 yzJcHBoHBCVse6oqvkgyI+Lssaj6u0y1hPRIzE1/ljSZjeqQpuNBrR86j1n5XZmPDfupA1ix
 Rfy5VWoViVdALkwLQrQ2hB/qf9qwPzH2mgP/0Ht1cD/a/rbKatfz2RvRWKhSgSee/wgVyz3y
 awdXW1CT1ynU0n3ENYmd3M99NT1et/w521AUBpjC+ozd2lWICOsBRE/1yzOPmU/Ufk3
IronPort-HdrOrdr: A9a23:rX1vCqOI9A0MHcBcTiKjsMiBIKoaSvp037Dk7SFMoDhuA6ulfq
 GV7ZAmPHDP5Ar5NEtOpTnEAtjnfZq+z+8R3WByB8bAYOCOggLBR+sO0WKh+UyDJ8SUzI5gPM
 lbHZRWOZnIMGk/q9377gm+G9Nl+9WM8LmpieDCpk0dNz1CWuVbx0NUGwaeVmdxQw5LD4d8NK
 P03Ls/mxOQPU4+KuirBn1Ae+DCopnlj5TjCCR2fyIP2U21pXeF+b7/VyKT1hAYXz4n+8ZYzV
 T4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,145,1665439200"; 
   d="asc'?scan'208";a="39129954"
X-MGA-submission: =?us-ascii?q?MDH+C9YQ6yjKKCWLIlzA2gEBSVPcDEdKAH7ZSY?=
 =?us-ascii?q?Tw2uDY+blIX/ZxfskR5NvCliAGGIp9+VWN3lO0VzTeMNTurqTqVwuXGy?=
 =?us-ascii?q?KsjzrQwJZcGEjwlt5u/VLSWS+NChdH5OJq/QheJlY2oLn9u5HiKfJ2Kj?=
 =?us-ascii?q?mGtFbF5EmNJvKypF5qKmzfTw=3D=3D?=
Received: from metis.ext.pengutronix.de ([85.220.165.71])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 19:11:48 +0100
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1os6b3-00065f-Ia; Mon, 07 Nov 2022 19:11:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1os6b1-002uN5-8c; Mon, 07 Nov 2022 19:11:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1os6b1-00F1sJ-8Q; Mon, 07 Nov 2022 19:11:43 +0100
Date: Mon, 7 Nov 2022 19:11:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: kernel@pengutronix.de, Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org, cocci@inria.fr
Message-ID: <20221107181135.tm2wmwiulepsyrmk@pengutronix.de>
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
 <28e17fb9-cec1-4a89-1492-cd3ece7a9487@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="br76c7q2m6ekdpo6"
Content-Disposition: inline
In-Reply-To: <28e17fb9-cec1-4a89-1492-cd3ece7a9487@inria.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: cocci@inria.fr
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Reply-To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-Loop: cocci@inria.fr
X-Sequence: 726
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/20221107181135.tm2wmwiulepsyrmk%40pengutronix.de>


--br76c7q2m6ekdpo6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalent to
the shorter devm_platform_ioremap_resource(pdev, index).

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
---
On Mon, Nov 07, 2022 at 08:45:38PM +0800, Julia Lawall wrote:
> On Mon, 7 Nov 2022, Uwe Kleine-K=F6nig wrote:
>=20
> > devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalent=
 to
> > the shorter devm_platform_ioremap_resource(pdev, index).
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >
> > a potential improvement is to check for invocations of
> > devm_platform_get_and_ioremap_resource() where the res parameter isn't
> > used afterwards, but my coccinelle foo isn't strong enough for that.
>=20
> ... when !=3D res
>=20
> I'm not sure where you wanted to put it though.

I tinkered a bit further and even succeeded to remove the declaration if
it's otherwise unused.

I failed to test the report mode, my spatch tells me some error about
python2?!

Best regards
Uwe

 .../api/devm_platform_ioremap_resource.cocci  | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resource.c=
occi

diff --git a/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci b/=
scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
new file mode 100644
index 000000000000..485dfa6ea0aa
--- /dev/null
+++ b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Don't use devm_platform_get_and_ioremap_resource with NULL as third pa=
rameter
+// Confidence: High
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@r1@
+position p;
+@@
+ devm_platform_ioremap_resource(...) {
+	...
+	devm_platform_get_and_ioremap_resource@p(...)
+	...
+ }
+
+@depends on patch@
+expression pdev,index;
+position p !=3D r1.p;
+@@
+
+-  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
++  devm_platform_ioremap_resource(pdev, index)
+
+@depends on patch@
+expression pdev,index;
+identifier res;
+type T;
+@@
+-  T res;
+   ... when !=3D res
+-  devm_platform_get_and_ioremap_resource(pdev, index, &res)
++  devm_platform_ioremap_resource(pdev, index)
+   ... when !=3D res
+
+@depends on patch@
+expression pdev,index;
+identifier res;
+@@
+
+-  devm_platform_get_and_ioremap_resource(pdev, index, &res)
++  devm_platform_ioremap_resource(pdev, index)
+   ... when !=3D res
+
+@r2 depends on !patch exists@
+expression pdev,index;
+position p;
+@@
+
+*  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
+
+@script:python depends on org@
+p << r2.p;
+@@
+
+cocci.print_main("WARNING opportunity for devm_platform_ioremap_resource",=
 p)
+
+@script:python depends on report@
+p << r2.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for devm_platform_=
ioremap_resource")
+
+@r3 depends on !patch exists@
+expression pdev,index;
+identifier res;
+position p;
+@@
+
+*  devm_platform_get_and_ioremap_resource@p(pdev, index, &res)
+   ... when !=3D res
+
+@script:python depends on org@
+p << r3.p;
+@@
+
+cocci.print_main("WARNING opportunity for devm_platform_ioremap_resource",=
 p)
+
+@script:python depends on report@
+p << r3.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for devm_platform_=
ioremap_resource")
--=20
2.38.1


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--br76c7q2m6ekdpo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNpSksACgkQwfwUeK3K
7AkVLgf/Rft3yyIkDXUecuNVqIMeOI150FeS5ugDchiUalYpbmdntH6DabihECa8
RvYGAuCfnvvmHeQzfPf0g4b2ysQaZcWqzLWnBoq33vuUMsea9jsz9cGuCwx1Csv5
9FgmNg7Iqg9fIpuiAoJaAWYmcU8ftjgqq4euXQQnp2i/Wucnwtyl8EoeSJ1DGAMI
mDSjEkYO/oAfIlWQJGXqbwf70JWrZqnyLTch86IuZPSQj0MOMj1tKHxcL9zxWUAY
/m/49N4jcK9yGL+F3gSAx5chSewiqkv8Ob1I5P2sbJNgZ3iKJoEM+yD5S6futd/g
AUHkYT/VvaLwJ1FEmda6p7m6qBYWfg==
=53Fs
-----END PGP SIGNATURE-----

--br76c7q2m6ekdpo6--
