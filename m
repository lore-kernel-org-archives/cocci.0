Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9A0C021BE
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=TVc9XhtGM1TLJ0eb+li7svXM1XPnWKs8qetqaDL3kIY=;
  b=KlgOz6pUeBToQPAWYTlIGnxiEiMgznMj3jEzppmgjBbcp5dZffJP/KGt
   OpqPYiSc11A/HT4yhaN2D0jgVvdNazpjzYaIQjflYXdKGDUyDmf+cDSXm
   AERgFfKdLYJCJoumobj1JNHFX9KDHbFwH+AvQB4keDGDk2PfDZD+rMcZ1
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="asc'?scan'208";a="210044199"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2D560E0D2B; Tue, 25 Feb 2025 21:28:05 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 02B8FE0260
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:27:48 +0100 (CET)
IronPort-SDR: 67be27c4_PV2fljQvLKuKJbq77xBGcY1u2Q1+U0MnTjhi22rcsQnF3y5
 E5gR5sZNHQuQLelm36s8mxOiD1/jpVjEVaLInSg==
X-IPAS-Result: =?us-ascii?q?A0EDAAAKJ75nhQfJy7laGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBgX8FAQEBAQsBgXFSfVwxBAtIhFaIHV+IdzCdZIF+CAcBAwEIB?=
 =?us-ascii?q?TUNAgQBAQMBA4UAAosSAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBAQFASYV7DYJiAYEHgREBAQEBAQEBAQEBAQEBASIrAggFf?=
 =?us-ascii?q?gEBAQMjVg4CCw4KHA4CAho8BhODAgGCZAQDsDOBMoEB4BIKBgWBQwGBV4MCg?=
 =?us-ascii?q?2oLAYFahBFEhDNCgUlEhD8+iB6CaQSCL4Fugz6aD41SUoEXA1ksAVUTFwsHB?=
 =?us-ascii?q?YEpSAOBDyOBIwU0Cjc6ggtpSToCDQI1gh58giuCHYI3hENcLwMDAwODKoVSg?=
 =?us-ascii?q?hGBYAMDFhCDH3cchH+DYx1AAwttPTcUG502GnyDEQE8hXV7lD2DUAGwA4I/g?=
 =?us-ascii?q?WahYzKXRA6TAy6HZZBqox6GEoFnOoFcMxoIHBSDIk8DGQ+IAIY6hBTLQkQzP?=
 =?us-ascii?q?AIHAQoBAQMJhUWKV4FLAQE?=
IronPort-PHdr: A9a23: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
 tXJm7/vMjBE8sKS8cZOX6Dp
IronPort-Data: A9a23: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
 Jqs7ug=
IronPort-HdrOrdr: A9a23:jUlDf6NXnT72EsBcTiKjsMiBIKoaSvp037Dk7SFMoDhuA6ulfq
 GV7ZAmPHDP5Ar5NEtOpTnEAtjnfZq+z+8R3WByB8bAYOCOggLBR+sO0WKh+UyDJ8SUzI5gPM
 lbHZRWOZnIMGk/q9377gm+G9Nl+9WM8LmpieDCpk0dNz1CWuVbx0NUGwaeVmdxQw5LD4d8NK
 P03Ls/mxOQPU4+KuirBn1Ae+DCopnlj5TjCCR2fyIP2U21pXeF+b7/VyKT1hAYXz4n+8ZYzV
 T4
X-Talos-CUID: 9a23:rfjA/G16sGgavZzi1g/sv7xfOMoIeF/783TsBEqyEmhQa+2URkKd9/Yx
X-Talos-MUID: 9a23:LAP+rQU2Grmn0WDq/AXKuTFTE8JX352RVlgAtakoh8mBbhUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="asc'?scan'208";a="110053646"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDEFLOaXz20GR0FD508Mw9QSXCyOiyG1T0mNVP?=
 =?us-ascii?q?wHy02JCBaxPnfDmD+37zhGApYE1zE3yv+vv6C5z2YXMYlmcjVNUVnfYZ?=
 =?us-ascii?q?LFu0HomA3R0HPoaRxEbNML/JFuAF3Glhf3nTaqH31GfucaevgFiuHRPc?=
 =?us-ascii?q?165DajV1hDsKf1c15BsIfYCw=3D=3D?=
Received: from metis.whiteo.stw.pengutronix.de ([185.203.201.7])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:27:49 +0100
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tn1Wc-00041b-Jz; Tue, 25 Feb 2025 21:27:30 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tn1WS-002pgM-2j;
	Tue, 25 Feb 2025 21:27:20 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 461863CBC72;
	Tue, 25 Feb 2025 20:27:20 +0000 (UTC)
Date: Tue, 25 Feb 2025 21:27:18 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>, 
	Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede <hdegoede@redhat.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
	Selvin Xavier <selvin.xavier@broadcom.com>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-xfs@vger.kernel.org, linux-nvme@lists.infradead.org, 
	cocci@inria.fr, linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-spi@vger.kernel.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-sound@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, ceph-devel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, imx@lists.linux.dev, linux-btrfs@vger.kernel.org
Message-ID: <20250225-cuddly-cobalt-hoatzin-e51fa3-mkl@pengutronix.de>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-13-a43967e36c88@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u45zipechepd67vw"
Content-Disposition: inline
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-13-a43967e36c88@linux.microsoft.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: cocci@inria.fr
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v3 13/16] spi: spi-imx: convert timeouts to
 secs_to_jiffies()
Reply-To: Marc Kleine-Budde <mkl@pengutronix.de>
X-Loop: cocci@inria.fr
X-Sequence: 2449
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-cuddly-cobalt-hoatzin-e51fa3-mkl%40pengutronix.de>


--u45zipechepd67vw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 13/16] spi: spi-imx: convert timeouts to
 secs_to_jiffies()
MIME-Version: 1.0

On 25.02.2025 20:17:27, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplicati=
on
>=20
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
>=20
> @depends on patch@
> expression E;
> @@
>=20
> -msecs_to_jiffies
> +secs_to_jiffies
> (E
> - * \( 1000 \| MSEC_PER_SEC \)
> )
>=20
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--u45zipechepd67vw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme+J6EACgkQDHRl3/mQ
kZxJmwgAjTBuQGjYsvjY3usfUGQlEX04CIIY/fXUbuNzg4k+rDZYBJVygyeWMSjH
P09FwLbjh/3LifMz41UC89WtofRA/pYz/koXNfKNHmOgy3F49mc9hZdB5bWYREeh
pt/7hAditNxNFMWvhHfZTFosdWI0f8QzpbcRF1N2bpFG+XIbVNCkzo7FD1IWzvtR
GOEwRfExkjtczf6yPcr0Lt5Fvh/Z2kD8uSH227AVm5XLZ9mTp9IzOmS6B2LTYfDi
YMDx5tD4fzYZ5KakPtBlEogWj3yg2pX6DpQETIHYrH7G5Or7uM9m8vWp9e29TGNH
hi/ia9fePGWAvvBB/1tngbAZUlNvSA==
=n4uD
-----END PGP SIGNATURE-----

--u45zipechepd67vw--
