Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D57C282DE
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QhumB2dMhTn1kPpxWtkQ9ngztdTyiGL1QjPpmk5uZ9k=;
  b=rC+2VZdNznexOWCPpF3pbAKJR9v553GFHmmo+OD64kI06ZF2sIcaUCa7
   6I0gIXYJGyVyIiwEERKW0+TDj344h0Ut+28khD7sBaylOC+zlGnDYT0vt
   iUfF08hLadLYFiY3MVwfxSEz4nTKlhWZD0cwU4pT5emmyN5OFd2vyZ/iV
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux-foundation.org
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211070357"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C1779E1744; Tue,  4 Mar 2025 10:58:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 99120E0260
	for <cocci@sympa.inria.fr>; Wed, 26 Feb 2025 21:38:56 +0100 (CET)
IronPort-SDR: 67bf7be0_atfbrDmMH55GJyqkjInurPqpXCBvHVgO+d4CfF4o1JVss8F
 IrkwPFjMkA9TwhqP6sqsdeXQijf47/P2SUeiWKA==
X-IPAS-Result: =?us-ascii?q?A0EkAAB7e79nhf4EaaxaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAQGCQoFXMwQLSI1ShlOCJItzkiGBfg8BAwENRAQBAQMBA4UAAosSA?=
 =?us-ascii?q?h4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQFAS?=
 =?us-ascii?q?YV7DUkBDAGCCwEzghYsDX0BAQEBAgE6BgEBNwEECwsOCi5WBhODAoJCIwOva?=
 =?us-ascii?q?XiBNIEBggwBAQbcIIFlCYFIAYFghm4BhWuDfXonG32BEIQ/PosHhCGDPqgpS?=
 =?us-ascii?q?Ap7eCwBVRMNCgsHBWFISAM1DAsuFSOBIwU0Cjc6ggtpSToCDQI1gh58giuCH?=
 =?us-ascii?q?YI3hENcLwMDAwODKoVSghGBYAMDFg8BgjBvdxyEf4QmHUADCxgNSBEsNxQbR?=
 =?us-ascii?q?G4HoFg8gx2BGYI8Mx99km6DUAGOFGuhBIQloUhNhAONB4Y6kxEuh2WQaqNih?=
 =?us-ascii?q?U6BaAE4gVwzGggoCIMiTwMZD44hGYh0xSgiNTwCBwsBAQMJjUCCXIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 QVAL5Tz6Ipp5ayRNHCrJd01xq9M
IronPort-HdrOrdr: A9a23:5Ha3iayWEE4lX3GPW2ScKrPwKb1zdoMgy1knxilNoNJuE/Bw8P
 re5cjztCWE7gr5PUtMpTnuAsW9qB/nmqKdpLNhX4tKIjOW21dAXbsSircKqgeIc0aVygce79
 YET0EUMr3N5DZB4/oSmDPId+od/A==
X-Talos-CUID: =?us-ascii?q?9a23=3Amq+MzmuVTEquo2InbFTo57JZ6ItiSUX+6nOLAnO?=
 =?us-ascii?q?xVzlzZLeWY1Gtp6NNxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ANjxx1gwMh33xRxkn0nAkuK3nA0qaqJmpKm8zsLA?=
 =?us-ascii?q?BgtinZHd8fBjGgwmOQ7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,318,1732575600"; 
   d="scan'208";a="210241945"
X-MGA-submission: =?us-ascii?q?MDGNd32FzNiRqSoKX0i+vfy/+aEqzQxBAFPq7L?=
 =?us-ascii?q?ONnDHoMYDlZ86P1VmCLQynZj3rlEkCkyUxqpWlGCK2Nn8vqgVQ775agu?=
 =?us-ascii?q?X8/VErJAQMde2r9c5yGR018T3r8ljFqHylPjxGETfWQu4lmnaBDBoFiP?=
 =?us-ascii?q?MIrUfgdkvCXDVOvw39Jt57xg=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:38:55 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D3787611FB;
	Wed, 26 Feb 2025 20:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6862C4CED6;
	Wed, 26 Feb 2025 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740602333;
	bh=7XYXLxmDs/g+GFsdMP00ShC9As4ZJdRFjOnafekKWK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fV8iNAC7l4sOXlbbBPxr62ebH5w2CCdPAcSqIvutoYztu5oPQJIO+VleFuSaNJwgu
	 4XgUTLEITbZ/EXzbMYjOUaYvhSzh8lkiZR+OX0Og6mdEO8tbUqzELkCgiiGXTD8w+8
	 VA5I1aWrxf8HjtmXFunV8nM5CekAUj0+LkOLORow=
Date: Wed, 26 Feb 2025 12:38:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>, Yaron Avizrat
 <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, Julia Lawall
 <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, James Smart
 <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Ilya
 Dryomov <idryomov@gmail.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Carlos Maiolino
 <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Frank Li
 <Frank.Li@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Shyam Sundar S K
 <Shyam-sundar.S-k@amd.com>, Hans de Goede <hdegoede@redhat.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Henrique de
 Moraes Holschuh <hmh@hmh.eng.br>, Selvin Xavier
 <selvin.xavier@broadcom.com>, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org, Takashi
 Iwai <tiwai@suse.de>, Carlos Maiolino <cmaiolino@redhat.com>
Message-Id: <20250226123851.a50e727d0a1bfe639ece4a72@linux-foundation.org>
In-Reply-To: <79b24031-5776-4eb3-960b-32b0530647fb@sirena.org.uk>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
	<79b24031-5776-4eb3-960b-32b0530647fb@sirena.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 00/16] Converge on using secs_to_jiffies()
 part two
Reply-To: Andrew Morton <akpm@linux-foundation.org>
X-Loop: cocci@inria.fr
X-Sequence: 2525
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250226123851.a50e727d0a1bfe639ece4a72%40linux-foundation.org>

On Wed, 26 Feb 2025 11:29:53 +0000 Mark Brown <broonie@kernel.org> wrote:

> On Tue, Feb 25, 2025 at 08:17:14PM +0000, Easwar Hariharan wrote:
> > This is the second series (part 1*) that converts users of msecs_to_jiffies() that
> > either use the multiply pattern of either of:
> > - msecs_to_jiffies(N*1000) or
> > - msecs_to_jiffies(N*MSEC_PER_SEC)
> > 
> > where N is a constant or an expression, to avoid the multiplication.
> 
> Please don't combine patches for multiple subsystems into a single
> series if there's no dependencies between them, it just creates
> confusion about how things get merged, problems for tooling and makes
> everything more noisy.  It's best to split things up per subsystem in
> that case.

I asked for this.  I'll merge everything, spend a few weeks gathering
up maintainer acks.  Anything which a subsystem maintainer merges will
be reported by Stephen and I'll drop that particular patch.

This way, nothing gets lost.  I take this approach often and it works.

If these were sent as a bunch of individual patches then it would be up
to the sender to keep track of what has been merged and what hasn't. 
That person will be resending some stragglers many times.  Until they
give up and some patches get permanently lost.

Scale all that across many senders and the whole process becomes costly
and unreliable.  Whereas centralizing it on akpm is more efficient,
more reliable, more scalable, lower latency and less frustrating for
senders.

