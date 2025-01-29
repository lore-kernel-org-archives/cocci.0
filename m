Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B44EC0218D
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 11:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=EHWivDYWF4y7ba+zH92u1jVSetPKPOsiJHaqx7tsOwU=;
  b=a6GEJcCwhzjWhxBBaSHadJg4JNowWMoePpKyxXiEna69+ahqd/my7pKz
   MuQn6tCwZ35hCulWpr/dDLaNFh+DPwWZIwiCyPPADCHPQJiR7VaT+cW9Z
   cRa6M/82kMWSozTT8I93LPvv7LbjSHYci4TWV4LZnyCNNKv/xtmaeQl5G
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.13,243,1732575600"; 
   d="asc'?scan'208";a="205567353"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 12:28:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 82D1DE0260; Wed, 29 Jan 2025 12:28:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CAE4BE0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 12:28:34 +0100 (CET)
IronPort-SDR: 679a10e2_dVirP3zLQvqIOSzr+PAuJpiH7WlFj/gOtzZQrS7ODjBUT+q
 G9RNJcNIeYLzvjUZnkPJGJ+cZYaM9QDFpHyik+Q==
X-IPAS-Result: =?us-ascii?q?A0EvAACuD5pnhVvBS5NaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIjHNfhlNbAQEGgREwi3OSJIF+CAcBAwEIBUQEAQEDB?=
 =?us-ascii?q?IUAAop1Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBAQFASYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAg1+AQEBA0ABATcBDwsOC?=
 =?us-ascii?q?i5WBhODAgGCZAO1FIE0gQGCDAEBBt18BwmBSAGBV4ZrCwGBWoQRg316Jxt9g?=
 =?us-ascii?q?RCBPA6CdT6LB4IzgXODQKE6UoEXA1ksAVUTFwsHBWFISAOBESOBJgU1Cjc6g?=
 =?us-ascii?q?g1pSToCDQI1gh58gitrBAWBLYI7hEVgLwMDAwODNoVbghSBZQMDFhABgyd4H?=
 =?us-ascii?q?IIsHUACAQttPTcJCxuaIBx7gnQ8hjiUPINPAbAAhCWEb5xcBg8EGxSDcQGTU?=
 =?us-ascii?q?pMPLodkkGqpLYFnOoFcMxoIKAiDIk8DGQ+IAIYhGYh0xHtDNTwCBwsBAQMJk?=
 =?us-ascii?q?BeBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 PwugIp9brFYWPYIZdWzixjDmmG6PA==
IronPort-HdrOrdr: A9a23:7R3mPKxTe5sIiM3UvOsUKrPwEb1zdoMgy1knxilNoNJuE/Bws/
 re+8jztCWE7Ar5PUtMpTnuAsW9qB/nmqKdpLNhW4tKPzOW3VdATrsSjrcKqgeIc0aVygce79
 YDT0EUMr3N5DZB4/rS0U2TFdAjwNXvytHQudvj
X-Talos-CUID: =?us-ascii?q?9a23=3A9SgNd2n18JDZBJbf+6aqz0ZfHlfXOV/x4Hj9JHe?=
 =?us-ascii?q?zM0lKbqa1e3GrwfhjsMU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AwBpPHA0dMAuStkh5MumU6kdqLTUjyfSUDgcrjZE?=
 =?us-ascii?q?6o8COEBRhGwWNkWmVTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,243,1732575600"; 
   d="asc'?scan'208";a="205567338"
X-MGA-submission: =?us-ascii?q?MDEbuzHz024+/KvnWTyrVqOrqs40AIo6ie2wzg?=
 =?us-ascii?q?3ItemkTpTeNHxGrCeL2bE0d/Ckuv3cr3U1Qds0UyDkToFbVm7TK+fu5z?=
 =?us-ascii?q?z/TBu0rwcYJY7OjhY3YyYZPTTejJK5d1diPtet1lJstAwSOnEcn464CT?=
 =?us-ascii?q?Kvespwpr60N1J9TsAcY3qn9Q=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 12:28:33 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 93864A4182F;
	Wed, 29 Jan 2025 11:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4990C4CED3;
	Wed, 29 Jan 2025 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738150112;
	bh=0afCP9tpAob285d2+c3DFTpCZwuw1x7xRMd+0cAY7dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=keXqYgpBqSxQiFVgp6ssrhizY4Du1eWNsvvQf4/NWW+oCjoyMXSVpfZ5Bn1PdB/ED
	 9wv1wBuRchQxQ0CuW4u8FMVzwJ8rB0L5vRFiLUUNtPD9wj9Bn+/Va+Q9Z6mxgIymwQ
	 JLqQeOEbqULVQhG02Pj+7zzB2MlkL8R3oKJEeNxyMF67Vwg78zTFJsO4OZ7KbIbgaP
	 YP9spZdl67qiwH0u1r8P2FYAPgdnGwinuVWEYrFRtCSPzqRNfIEkTTNBeG18dRI+F6
	 TAaVqoYmML/+XRYt7G2+YbCO7gYobpmwRSUYyDEsvRA3IA3F3pdig8YUD/h8psjWYU
	 PeniPeunBQVTw==
Date: Wed, 29 Jan 2025 11:28:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yaron Avizrat <yaron.avizrat@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Frank Li <Frank.Li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	cocci@inria.fr, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Message-ID: <61d507a3-ca37-4eb9-b2cd-100298ffeeb6@sirena.org.uk>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-12-9a6ecf0b2308@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wxS6hvAU6Vp1PxGO"
Content-Disposition: inline
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-12-9a6ecf0b2308@linux.microsoft.com>
X-Cookie: The world is not octal despite DEC.
Subject: Re: [cocci] [PATCH 12/16] spi: spi-fsl-lpspi: convert timeouts to
 secs_to_jiffies()
Reply-To: Mark Brown <broonie@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2308
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/61d507a3-ca37-4eb9-b2cd-100298ffeeb6%40sirena.org.uk>


--wxS6hvAU6Vp1PxGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 28, 2025 at 06:21:57PM +0000, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

Acked-by: Mark Brown <broonie@kernel.org>

--wxS6hvAU6Vp1PxGO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeaENIACgkQJNaLcl1U
h9Dwlwf/b75reI0uh7UpxNuw1Dgg2fl7hJn3m8DCJwfdhTb1pyNP6o2VB7PJ1FPR
zu8lccVGi/iZRranIOtvGjKtg5SrDhrF9CChAbwxk2f26lvF27Srdn7mHycwzkEm
h579H3K/1ri3X0oWXziH3KBnzKNBR3TB6h7Rp5na27mnWR9gKqZncog+7Qvr1aP1
3ufuZYWQ3RTFLp/IcPgBRYYjA/Ev1i7qKuqRS8qugS1d1vtZ7Js396WlV3r1KtgJ
qKDie5bMyU16q7C+SJERETYIrFvtYKXn3bERyeN2wpSjyOtEYM2awuQ3XRDFvz05
lMz/vFonoSs3p3TPlosZHyaOSE/Vdg==
=JJPM
-----END PGP SIGNATURE-----

--wxS6hvAU6Vp1PxGO--
