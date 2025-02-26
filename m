Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765C0C021B8
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=7EYxlfHbLZCWaPFmZ91Op7xY0YZ2F9pCKdATjf1lZ7k=;
  b=ewd6XgW2fsFYVpeM3Bmhue5l6bzjEB/vpn9WqV0m1C9CsF08SoF5s9Pj
   43MkhpFe3YipSPipdFsWoCg/MCBjbkhXipH268JYKOeneJqgATC2h6GKl
   Nz/3QihS0WHImOpmq9jRH0DznMSSV41hyuP2XQVM5Eto2PYDxRjRpE/jB
   8=;
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
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="asc'?scan'208";a="211070582"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 829D0E18C2; Tue,  4 Mar 2025 10:58:48 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C3945E0260
	for <cocci@sympa.inria.fr>; Wed, 26 Feb 2025 23:27:11 +0100 (CET)
IronPort-SDR: 67bf9536_N3CN/6AYCSLm+qCYH5BXNXMN8EhYZz5lCipfFsz8qO54C+j
 XXFki0RJaqAExqzziKJQc2moN1c3sYWZqSICyaQ==
X-IPAS-Result: =?us-ascii?q?A0GQAADclL9nhf4EaaxaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAQGCQoFXMwQLSI1ShlOBdC0Di3OSIYF+CAcBAwEIBUQEAQEDBIUAA?=
 =?us-ascii?q?osSAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBA?=
 =?us-ascii?q?QFASYVBBjQNSQEQAYIHAYEkgSYBAQEBAQEBAQEBAQEdAg19AQEBAQIBQAEBN?=
 =?us-ascii?q?wEECwsOCi5WBhODAgGCQSMDr2B4gTSBAYIMAQEG3X4HCYFIAYFXCYZjCwGBW?=
 =?us-ascii?q?oQRg316Jxt9gRCBPA6Bc4ECPosHhCGDPqgrUoEXA1ksAVUTFwsHBWFISAOBD?=
 =?us-ascii?q?yOBIwU0Cjc6ggtpSToCDQI1gh58gitqBAWBKoI3hENcLwMDAwODKoVSghGBY?=
 =?us-ascii?q?AMDFg8BgjBvdxyEf4QoHUACAQttPTcJCxudZxp8gxU8gx2BGYELJoELMx81d?=
 =?us-ascii?q?ZYRAbADhCWEb5xeBg8EGxSEA40HhjqTES6HZZBqo2KFToFoATiBXDMaCCgIO?=
 =?us-ascii?q?4JnTwMZD4dMhlUZiHTFEEM1PAIHCwEBAwmNYoI6gUsBAQ?=
IronPort-PHdr: A9a23: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
 dWJl6/pLjpGtdXO8plEb/U=
IronPort-Data: A9a23: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
 tsNRB75nmB6fwcIadWzWjr3a7BH7Qws+aH4bx0V
IronPort-HdrOrdr: A9a23:2ENXhawWTmeijEqSyBFWKrPwEb1zdoMgy1knxilNoNJuE/Bws/
 re+8jztCWE7Ar5PUtMpTnuAsW9qB/nmqKdpLNhW4tKPzOW3VdATrsSjrcKqgeIc0aVygce79
 YDT0EUMr3N5DZB4/rS0U2TFdAjwNXvytHQudvj
X-Talos-CUID: 9a23:sfqVt2D+j9ZsPm/6E3k6xm8XAd8qSSfQkCrucxTpGWNveYTAHA==
X-Talos-MUID: 9a23:vyTgPAj5S5psyJNvc0R2pcMpJPdZ0YrpDn80r4wohs/HNhMtOjyyg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,318,1732575600"; 
   d="asc'?scan'208";a="110157094"
X-MGA-submission: =?us-ascii?q?MDFO/Wv/0guaqEF7TAFSM5nMOmFRg3fagU9wUm?=
 =?us-ascii?q?UCe8eFTcrdEOuaoFa4VEWgxCnbKDRR8KFxfecimX0ZYSYkqjjD3WU45z?=
 =?us-ascii?q?dU0YHUcR3PDBlcrqknlIVeHdGCBVNhtU2SzDRas5UHO7G7/BIoT63WE8?=
 =?us-ascii?q?0LoKlcxY95/CGavSDQ19P5eg=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 23:27:03 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 91E77612A4;
	Wed, 26 Feb 2025 22:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D179C4CED6;
	Wed, 26 Feb 2025 22:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740608820;
	bh=O5zZ7g63I+0ZeYH00JZerlvbNik71qO0CgwvkTnWcIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqYqpdVVpkD5NJn6jpo0cdClxOspwzsi8RCKpRnA88J5OPdmx1mMru31LZxBFgp96
	 SZb3oRy0Fxzg1qr18ZQYO7NtEHrnW1kSYRo35qghO1/ESXhb4R4oAXKE6PoHpaKtQk
	 rw/ltpwe8XfbrUtfiq6lveoAbVX0jopaapPwU3slyk58T6gzgfoVr9fY71ajwj3kUT
	 xvbk1I9lC3b2larN7+jztDKNXSrFhP0QhpXpDklrqd7y0o0NsfVUuwegc/GYneM1Nf
	 LoD2swB/LWax0rd/I8YAe0yQ9kMiS9zB3fdg0qmIVaFo3k/1cDqwlB1rT1yn4zBMcR
	 ST+zf0908vWAA==
Date: Wed, 26 Feb 2025 22:26:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
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
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Carlos Maiolino <cmaiolino@redhat.com>
Message-ID: <594169fd-5ba6-42d5-ad35-bb8c7720904b@sirena.org.uk>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <79b24031-5776-4eb3-960b-32b0530647fb@sirena.org.uk>
 <20250226123851.a50e727d0a1bfe639ece4a72@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ktE/+HW2BMMja6u3"
Content-Disposition: inline
In-Reply-To: <20250226123851.a50e727d0a1bfe639ece4a72@linux-foundation.org>
X-Cookie: I've been there.
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 00/16] Converge on using secs_to_jiffies()
 part two
Reply-To: Mark Brown <broonie@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2526
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/594169fd-5ba6-42d5-ad35-bb8c7720904b%40sirena.org.uk>


--ktE/+HW2BMMja6u3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 12:38:51PM -0800, Andrew Morton wrote:
> On Wed, 26 Feb 2025 11:29:53 +0000 Mark Brown <broonie@kernel.org> wrote:

> > Please don't combine patches for multiple subsystems into a single
> > series if there's no dependencies between them, it just creates
> > confusion about how things get merged, problems for tooling and makes
> > everything more noisy.  It's best to split things up per subsystem in
> > that case.

> I asked for this.  I'll merge everything, spend a few weeks gathering
> up maintainer acks.  Anything which a subsystem maintainer merges will
> be reported by Stephen and I'll drop that particular patch.

> This way, nothing gets lost.  I take this approach often and it works.

I've only started seeing these in the past few weeks, but we do have a
bunch of people routinely doing cross tree stuff who split things up and
it seems to work OK there.

> If these were sent as a bunch of individual patches then it would be up
> to the sender to keep track of what has been merged and what hasn't.=20
> That person will be resending some stragglers many times.  Until they
> give up and some patches get permanently lost.

Surely the sender can just CC you on each individual thing just as well?
Ensuring things get picked up is great, but it's not clear to me that
copying everyone on a cross tree series is helping with that.

> Scale all that across many senders and the whole process becomes costly
> and unreliable.  Whereas centralizing it on akpm is more efficient,
> more reliable, more scalable, lower latency and less frustrating for
> senders.

Whereas copying everyone means all the maintainers see something that
looks terribly complicated in their inboxes and have to figure out if
there are actually any dependencies in the series and how it's supposed
to be handed, and then every reply goes to a huge CC list.  That's not
good for either getting people to look at things or general noise
avoidance, especially for people who are expecting to get cross tree
serieses which do have dependencies that need to be managed.

There's also some bad failure modes as soon as anyone has any sort of
comment on the series, suddenly everyone's got a coding style debate or
whatever in their inboxes they can pile into.

--ktE/+HW2BMMja6u3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme/lSYACgkQJNaLcl1U
h9DO/Qf/a9HWwKcXS5+hFxQJSm6QW0NLy2NbqHre8UKfa7aKUVgjHmVnb1gIAdSh
gY+WUz9p7S+67TovmO+FlVs/KDBaHyw8J0auw2I/uFK7bDhNHXtiUi32jBCyuQD4
w+yhOC50NrB6ZXh/FpBk8EXI4DSUoaL5z6KMVYItTTfl0lCtBbTGJSAPXswWc3u1
5ZXriY5GR9Q2MwY4Fs6QN6pbKucqtpxnhiL26E8ic/kdpVh6ZGEoFhFWweV6nD/+
ttggFNcFA98M8YYEySK/p9ls4PyRF4dXL+oQWEXWvylpGogCDAcCj7Igb8CuyJRn
G2+ftlgr6xEk4hOBnRKBY7Ts/BcKqg==
=3AEq
-----END PGP SIGNATURE-----

--ktE/+HW2BMMja6u3--
