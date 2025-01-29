Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D619BC02190
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 11:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+LlRpnDAicJ8OxCQD89sCWT8NZ3A3z4q2lUUi96t0Os=;
  b=Bjaj+kJBq+TraXw/R64F/HeidbZwoMibFzMi9FpDVxvK1igHHS1MkIYq
   4FrbGuvWjljJxeG/Kjs+WlaTY1v/4mFSUntZAQ33UzxWGHuA6w1qrvQDX
   8hbcfCx1RCf+b3+HSbtCayIxPVYn7nxvd837qFEkNScdtOg5aTFVzJ/2S
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
   d="asc'?scan'208";a="205567756"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 12:30:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5AE5BE0D1E; Wed, 29 Jan 2025 12:30:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EC761E0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 12:30:42 +0100 (CET)
IronPort-SDR: 679a115f_SMqEzMNwzP4VmLCebt3AaLFiT8CHB6tN/1N4jqIuE/yEwtE
 mAk7bX03pELD2+Oa+Quqak9BstedJQe8zMY/uVQ==
X-IPAS-Result: =?us-ascii?q?A0EeAACrEJpnj9lUsotaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIjHNfhlNcAQaBETCLc5IkgX4IBwEDAQgFRAQBAQMEh?=
 =?us-ascii?q?QACinUCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBAQEBOQUOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAg1+AQEBA0ABATcBD?=
 =?us-ascii?q?wsOCi5WBhODAgGCZAO1KIE0gQGCDAEBBt18BwmBSAGBV4ZrCwGBWoQRg316J?=
 =?us-ascii?q?xt9gRCBPAsDgnU+iweCM4Fzg0ChOlKBFwNZLAFVExcLBwVhSEgDgREjgSYFN?=
 =?us-ascii?q?Qo3OoINaUk6Ag0CNYIefIIrawQFgS2CO4RFYC8DAwMDgzaFW4IUgWUDAxYQA?=
 =?us-ascii?q?YMneByCLB1AAgELbT03CQsbmiAce4J0PIY4lDyDTwGwAIQlhG+cXAYPBBsUg?=
 =?us-ascii?q?3EBk1KTDy6HZJBqqS2BZzqBXDMaCCgIgyJPAxkPiACGIRmIdMUDQzU8AgcLA?=
 =?us-ascii?q?QEDCZAXgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 F8vUapan7FaWPYIa9WzWjT3a2Fr2f0sKEQ=
IronPort-HdrOrdr: A9a23:wOXiqqhnp/ktSMw/NFDLG1TKWXBQXucji2hC6mlwRA09TyVXra
 GTddAgpHjJYVcqKRUdcLW7VZVoLkmxyXcY2+Ys1PKZLW/bUQiTXeRfBOnZsl7d8kTFn4Y3v5
 uIMZIOauEYZmIbsS+V2meFOudl6t+A8qCl7N2utktQcQ==
X-Talos-CUID: 9a23:zeoAyWAFy6/z1Af6EwZBrkcRRJgCSSzywnXrIEuhETlUdrLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AiILQww2ZH1fSyPAIrxFxbQhWFDUj4bytIV1dl68?=
 =?us-ascii?q?9tYqiEA5oEG25sgyxa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,243,1732575600"; 
   d="asc'?scan'208";a="107645422"
X-MGA-submission: =?us-ascii?q?MDFBqFmye9FKs52UA4wsaDn/KtkOxfOjtJm3Ga?=
 =?us-ascii?q?DuqNiRF+yddea3bru5SpZIg7izFy4ujikfc/w3f+kZqBfxqOUqJBpL5J?=
 =?us-ascii?q?gTAIis4hTpKF5EiIrboKvd5vme8O8QFaQOvzJab4BRXSHRW5DrV5qC+Z?=
 =?us-ascii?q?Z5pV1Y+msC40beZ5yCJTACbA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 12:30:39 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 548DD5C48E9;
	Wed, 29 Jan 2025 11:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08219C4CED3;
	Wed, 29 Jan 2025 11:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738150236;
	bh=PGzhPhIGvedo1hUSZOhnBkmZDQESU8tumG/s6DUxvXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZtI67GZDUwmVObMXVDnkn0JrT90mq1FWzZPJfX54LEnSuCkHcZegr9yD+nONZRlzB
	 NdTLLdl6vn6f8UrE+u4ErdIRAJ08ob0Xby74NcltekuNw+jlEhZ/ccP0QNf7C6JcXf
	 SwqH2i3Gs/sVoWSH1fgadm8LkE8QOh8sim2YzKEDtprzZ8ObXHa24pw/dQvs2U98RF
	 Tr6DWrDeNAfZAaOGR1I0I3HG51Uw66JRtlaZH0NKwMSzMvf3IVfb4NrYOydkdw8khx
	 9vzabwvkyLvROFag7yIgVq22runc6+02aDA3ULJ93boFRdvIIutHM5yGGI5/dCwLO/
	 rGjfk6o1HfewA==
Date: Wed, 29 Jan 2025 11:30:21 +0000
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
Message-ID: <003cc629-1969-432b-9d9a-e17a315a0407@sirena.org.uk>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-13-9a6ecf0b2308@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqw+F9EZKY3y+n+J"
Content-Disposition: inline
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-13-9a6ecf0b2308@linux.microsoft.com>
X-Cookie: The world is not octal despite DEC.
Subject: Re: [cocci] [PATCH 13/16] spi: spi-imx: convert timeouts to
 secs_to_jiffies()
Reply-To: Mark Brown <broonie@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2309
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/003cc629-1969-432b-9d9a-e17a315a0407%40sirena.org.uk>


--nqw+F9EZKY3y+n+J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 28, 2025 at 06:21:58PM +0000, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

Acked-by: Mark Brown <broonie@kernel.org>

--nqw+F9EZKY3y+n+J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeaEU0ACgkQJNaLcl1U
h9DZyQf/T/OK8ZWxSzh3dJWsLr99J2XEq+bjv9e7IU0AU/eyO6YeJOJ5PzHFHkPr
Zk1IUnGI0OF8pcUXyBzuUL5L6xn4D2+l7+ChMN1V94Q0KWuPSEf7bJL7lo+UBq4k
BDHHE1Qs7qag4DrPoQb4K+6qXX46HvTIJKamPKtm4VAw0BAVoK/N6pSPKtK+yRC8
TmfWRcS+046vsaFWuQF1aS3hy1eiY0eFjv3+XLhta71PFbIfQ8sBZtX+gzPu8/t8
w8BgXrldeDtBpKhtizRNkmlu9WoicVeENDpjYOAf3CeC08eHyRT/GrS4iYwRP26k
HKKCEB2NvAkAB5bvQXqsqFPC+Nzgmg==
=CTWt
-----END PGP SIGNATURE-----

--nqw+F9EZKY3y+n+J--
