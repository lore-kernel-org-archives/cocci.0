Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6970FC282D0
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=QrlFuLGm9hvjMVYLhfp1xS9+eF/bUp/ZHGLfVGGqgGg=;
  b=UEeLYDhZ+Cnqq/sNOVGM80lKRZnYafNCt+3Je8dhfPzlVb8CipaqmMMO
   T5+ZeRIAW07dYBq1hltiI9zAAQvjv6gVGqOmH+MIPy8Q7jiaoTXsjCHve
   gbXAsPnlgFOzloGXizUjZE5u7gJo4igaW6d5c6Ox+ht/NzJIMc/cwwxFy
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
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211070620"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9D547E1819; Tue,  4 Mar 2025 10:58:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 74445E0261
	for <cocci@sympa.inria.fr>; Thu, 27 Feb 2025 10:03:07 +0100 (CET)
IronPort-SDR: 67c02a4a_FDTj8+sieCTg0/hdIzMo5baw1LOlOLodQoDgfM4RFwpqPDU
 0wY8d0s+aGtTYbIdBqFwX+UI0TCCJrDZldwv7yQ==
X-IPAS-Result: =?us-ascii?q?A0EjAACQKcBnhf4EaaxaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQgMBAQELAQGCQoFXMwQLSI1ShlOCJItzhnWNKg8BAwENRAQBAQMEh?=
 =?us-ascii?q?QACixICHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBAUBJhXsNSQEQAYIHAYEkgSYBAQEBAQEBAQEBAQEdAg19AQEBAQIBOgYBA?=
 =?us-ascii?q?TcBDwsOCi5WBhMIgnqCQiMDrzx4gTSBAYIMAQEG3CCBZQmBSAGBYIZuAYVrg?=
 =?us-ascii?q?316Jxt9gRCEPz6LB4IzgW6DPqg2UnscA1ksAUsKNQw5KEhIA4EygSMFNApxg?=
 =?us-ascii?q?guBMjoCDQKCQHAfMYQXgjeEQ1wvAwMDA4IagRCBY4NvghGBYAMDFg8BgjBvd?=
 =?us-ascii?q?xyEf4QvHUADeD03FBuiFjyDHYEZgjwzHzFMkm+DUAGwBoQloV9JA4NtjQiGO?=
 =?us-ascii?q?pMRLodlkGqjYoVPgX0kgVxNMAiDIk8DGQ+OIRmIdMUuQjU8AgcLAQEDCYtuh?=
 =?us-ascii?q?C6BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:cLqJMqGpf6TLXFsSpLqE58eALOsnbusQ8zAXPo5KKCC9Vvbo8P
 xG/c5rsSMc7Qx9ZJhOo7y90cW7Lk80sKQFh7X5Xo3SOTUO2lHYT72KhLGKq1aLJ8S9zJ8+6U
 4KSchD4bPLY2RHsQ==
X-Talos-CUID: =?us-ascii?q?9a23=3Awlqe0WvkXrSb+jtiFnwRCpOQ6Isob0P0l1DUJ3a?=
 =?us-ascii?q?SMl9bEKGYe06fqaZNxp8=3D?=
X-Talos-MUID: 9a23:923IBgUa64rvCIrq/CW1jRtHP/VY2qSNMmIPsatft+C4aTMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; 
   d="scan'208";a="210301325"
X-MGA-submission: =?us-ascii?q?MDEvu8vwoB5uVd5TQtiChS8cSAz1MMjISrlUwI?=
 =?us-ascii?q?gQLayEivnY0e8vcbjcofYoClqrzEggNOB+SU4KRIdj6zyQm7TUL1oIzL?=
 =?us-ascii?q?9hUowzRg98YPcAWsZ1YjJjRS+5mwFDCIrEEfFfS14dvdZmGAmj+mGrUD?=
 =?us-ascii?q?owlHVMdVxpjhV80ioNAUXZvg=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:03:06 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9AFD4612E1;
	Thu, 27 Feb 2025 09:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7E3C4CEDD;
	Thu, 27 Feb 2025 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740646984;
	bh=NVCpCk+nbSUsNJ/EU7EEuGOPqCNbb7okhZbn+Sil+6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLspYqEw609cIT0ad0o594ZSe9+944oOqgtsX4PvzoyBCh2CjxvcaZKHcRlfZbkg3
	 o98sgutNPNtNQvtB1V2TWfdkxk0jvPKNau6dHa8OKjnpZRzHC9C6ErL5o2r0XNXfYe
	 ynD51HJPuofVM3zovm3pWhAZDAaeGPoIRj6tCVyu8o4t7sFTQlvipwFQwyRdAzsR2d
	 B6voWJuIrlI+Cf1lPSYN2ZjYhqS7rvygaip7lyyFeeh6HBrO8Q/DpezIvl2iQUtyVl
	 OXwKmfMuglQQ5kuzM1Q6kxE36HyfrIokC3I3woeNs2DsuZou71wXc13B0RkvyLg9Ys
	 NykE1mhZbbdJQ==
Date: Thu, 27 Feb 2025 10:02:45 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, 
	Easwar Hariharan <eahariha@linux.microsoft.com>, Yaron Avizrat <yaron.avizrat@intel.com>, 
	Oded Gabbay <ogabbay@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, James Smart <james.smart@broadcom.com>, 
	Dick Kennedy <dick.kennedy@broadcom.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Frank Li <Frank.Li@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Selvin Xavier <selvin.xavier@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, 
	Carlos Maiolino <cmaiolino@redhat.com>
Message-ID: <3apo7evpkvcy5mafw7zdatr3n7lytugvfmumq2zou4nifyptnc@ucbu4c5g5jrq>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <79b24031-5776-4eb3-960b-32b0530647fb@sirena.org.uk>
 <hJl1qb89zCHWejINoRSGGIO0m7NNi3wAmY9N_VC7royLnZoyL-ZozLkmLO-vCPlYc55-IPh76PIB_2_aKKjp1A==@protonmail.internalid>
 <20250226123851.a50e727d0a1bfe639ece4a72@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226123851.a50e727d0a1bfe639ece4a72@linux-foundation.org>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 00/16] Converge on using secs_to_jiffies()
 part two
Reply-To: Carlos Maiolino <cem@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2527
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/3apo7evpkvcy5mafw7zdatr3n7lytugvfmumq2zou4nifyptnc%40ucbu4c5g5jrq>

On Wed, Feb 26, 2025 at 12:38:51PM -0800, Andrew Morton wrote:
> On Wed, 26 Feb 2025 11:29:53 +0000 Mark Brown <broonie@kernel.org> wrote:
> 
> > On Tue, Feb 25, 2025 at 08:17:14PM +0000, Easwar Hariharan wrote:
> > > This is the second series (part 1*) that converts users of msecs_to_jiffies() that
> > > either use the multiply pattern of either of:
> > > - msecs_to_jiffies(N*1000) or
> > > - msecs_to_jiffies(N*MSEC_PER_SEC)
> > >
> > > where N is a constant or an expression, to avoid the multiplication.
> >
> > Please don't combine patches for multiple subsystems into a single
> > series if there's no dependencies between them, it just creates
> > confusion about how things get merged, problems for tooling and makes
> > everything more noisy.  It's best to split things up per subsystem in
> > that case.
> 
> I asked for this.  I'll merge everything, spend a few weeks gathering
> up maintainer acks.  Anything which a subsystem maintainer merges will
> be reported by Stephen and I'll drop that particular patch.

I'm removing this from my queue then and let it go through your tree.
Cheers,

Carlos

> 
> This way, nothing gets lost.  I take this approach often and it works.
> 
> If these were sent as a bunch of individual patches then it would be up
> to the sender to keep track of what has been merged and what hasn't.
> That person will be resending some stragglers many times.  Until they
> give up and some patches get permanently lost.
> 
> Scale all that across many senders and the whole process becomes costly
> and unreliable.  Whereas centralizing it on akpm is more efficient,
> more reliable, more scalable, lower latency and less frustrating for
> senders.
> 
