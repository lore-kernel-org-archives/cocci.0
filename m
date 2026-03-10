Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D60EFD2D6D
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 12:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=CYE/HV7EYizpiAYX6Lz6xzxADa1AFKYBU1J/zOcqJyk=;
  b=KXs+drfwWAc5dK/2p0oJtI5l19pup055y2VN8+0bgNOCNPj9dFdjprX0
   zSwPvPPpDU7VVivbrgm9c1hEoaa1AK8+PYioNeAW/gXMLfTRwJG9Z4QXy
   zuxtf3wkIyLIj6zvkLLKy+nYrZrhsYNqcAoffIZIkZAdOyPaki/eqJs2s
   w=;
X-CSE-ConnectionGUID: hJXOdeRpSjiRxYfG7fgXIQ==
X-CSE-MsgGUID: s/eFK2zGT/uHjp5GnuWevA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="asc'?scan'208";a="267090129"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 13:46:08 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 37E4C833D5; Tue, 10 Mar 2026 13:46:08 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4DAA68339C
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 13:28:37 +0100 (CET)
X-CSE-ConnectionGUID: 5kC30pkXRFCAr7hp1yIB+g==
X-CSE-MsgGUID: q1PZGO3bQRqwCaEXwNgFlA==
IronPort-SDR: 69b00e75_O/1CrpulTKYe7ULEszhZYYGnihpRiL4APiHFOpNUXBcUmIx
 l81qVh85/ANtFCKujl32zXI1fFbsaS2kEYZDCug==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EmAAC0DbBphR/86qxQCh0BAQEBCQESAQUFAUCBPQcBC?=
 =?us-ascii?q?wGCQIFmMwQLSY1ThlhdBoFBi3SSJoF9AggHAQMBCAVRBAEBAwSFAAKNIQIeB?=
 =?us-ascii?q?wEEMQgOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBQ?=
 =?us-ascii?q?EmGTw2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfgEBAQNAAQE3AQ8LDgouVgaDF?=
 =?us-ascii?q?QGCIgdKA609gTSBAYIMAQEG3ggJCRWBOAGBV4ZwDAGBXYN9GoQAeicbfYEQg?=
 =?us-ascii?q?RUnCwOCdT6EFoZxgzSJCooWUoEUA1ksAVUTFwsHBV5FQwOBBiNLBS0dgSMhH?=
 =?us-ascii?q?RcUH1gbBwUSISqBSXiCAQ+GankDLl4aDiICOlxKPgtaBYI/AgELbT03CQsbj?=
 =?us-ascii?q?F4QIQ2CDz6CLQiDa5ZcAa1bgkSEJoRwnG0GDwQbFIQEjROGO5MZLodlkHOpQ?=
 =?us-ascii?q?YFqAzWBXDMaCCgIgyJPAxkPjiEZiHrDfkM1PAIHCwEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
 5dISbJBUlExUPQABRY9dOE=
IronPort-Data: A9a23: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
 b7Kq7Ox3l2r
IronPort-HdrOrdr: A9a23:pezrAKpfX1aMCneTcD9hEqAaV5oSeYIsimQD101hICG9Afbo7v
 xG/c576faQslx+ZJhOo6HiBEDtewKlyXcx2/hrAV7AZniFhILLFuFfBOLZqlWKd0LDH6xmpM
 FdmsNFebnN5DZB/KHHCUWDYrMdKQa8nZyVuQ==
X-Talos-CUID: 9a23:xSbLv2AGjwBHhoj6E3Rk3xVMAsMVSFP25W2PI1fhGEdDC7LAHA==
X-Talos-MUID: 9a23:5TAKFAvj2qGPaJtTIM2nnWhaBuhPuK6XMlkSupwri9aiOgJ0EmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="asc'?scan'208";a="267086743"
X-MGA-submission: =?us-ascii?q?MDHNmRTS3Vd4b17MC0tXSaMWinfJFbJw5114oJ?=
 =?us-ascii?q?oas1lVjh7AWUP9kL3pg53oFFURnc2W54i+VaW40+rC6lVb6/okxBUZet?=
 =?us-ascii?q?L/0ct2uG6VhZlBFlpTUSkErfynotxiN6eW4fQzsVYJAc5pqEMiKe4uAT?=
 =?us-ascii?q?KU9Yd2UFZhuYJLcmZ8eIDrMA=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:28:36 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 337BD43449;
	Tue, 10 Mar 2026 12:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8179C19423;
	Tue, 10 Mar 2026 12:28:23 +0000 (UTC)
Date: Tue, 10 Mar 2026 12:28:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Max Filippov <jcmvbkbc@gmail.com>
Message-ID: <19aa26fc-8570-492e-8e17-23d6950676f0@sirena.org.uk>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-18-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7JjDB+7CEHk89uTh"
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-18-bd63b656022d@avm.de>
X-Cookie: A fool and his honey are soon parted.
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 18/61] sound: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Mark Brown <broonie@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3372
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/-HeYdHHLIyhwVZrGRASJ3g>


--7JjDB+7CEHk89uTh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2026 at 12:48:44PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.

I can't tell what the dependency story is here, it looks like there's
none?  If that's the case you shouldn't send things as a single series,
send separate patches to the various subsystems.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--7JjDB+7CEHk89uTh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmwDmMACgkQJNaLcl1U
h9D4VAf/VCpoXjivQsq8mL1i6sHdID6byBqwG7egrwiRCrsZav80JlvY/F+1fWQl
Fe3Ct+yRv1pWeNy67wSCZD3mtHtNH0JpwRTNxS1XQrnXc7CLjzKunCldDfzTbfom
+QmXWHQB3Qo9ie1ugoAGet9gx/vkV0z+cv9sVHg1o1R7/AKqfgov7xnuP9Hlv9Uk
p1pkMya/NhbXBsrh+BFbktLgp+7sAOMjWgtGZ3NfHzwju9n4Jdbl1JcPxgDl0SHp
6z8kP2+oskOspesqLWw62mZF+bN32Ycjt1N7/EFjtPBdJKIcQJLICoACzxyQBZYg
+i50s/oSRL1HiP4US2lxoy8BqxaqrQ==
=U6jW
-----END PGP SIGNATURE-----

--7JjDB+7CEHk89uTh--
