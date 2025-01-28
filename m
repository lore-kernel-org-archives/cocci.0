Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BC9C02192
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 19:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=W7WsprbcBEfGK2k7Y3aFUT9StnbhuOuzj3SKN/VdRxY=;
  b=Ggfya8E0Sq7kak17aomIs2pm3RMx4E2zfVsqfCdwotQMfcP0TDOfMeQM
   JvXxFTV8j6YhX4Thf5qYn9xJiw9XdmFru5QzAq0rRlnLRuMxO6RiC7rmX
   X0ytKYUPjmDVeW2rF7hiB6YQuxFHS0Wfghs2ZtBHfF7kuVRsF/4R9D9JL
   s=;
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
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205455529"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 20:32:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A6A36E00A5; Tue, 28 Jan 2025 20:32:09 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6DD26E00A5
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 20:32:06 +0100 (CET)
IronPort-SDR: 679930b4_zwwhOElgocOXZUTAlaeQM03wCrPlacuytAcMs7fTKj3guLg
 hnArFP6+QQ5B5tXLWHo3rKSieT1VmLJb/SMIO8A==
X-IPAS-Result: =?us-ascii?q?A0ESAABtMJlnhVvBS5NaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIjHNfhlOCJJJPi0mBfg8BAwENRAQBAQMEhQACinUCH?=
 =?us-ascii?q?gcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJh?=
 =?us-ascii?q?XsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDJxMGAQE3AQ8LDgouVgYTg?=
 =?us-ascii?q?wKCZQO1B4EBM4EBggwBAQbeAwmBSAGITQGFa0SDOXonFQaCDYQ/PosHgjOBR?=
 =?us-ascii?q?S+DQKEfUnscA1ksAUsKExcLBwU5KEhIA4ESI4EmBTUKNzqCDWlJNwINAjWCC?=
 =?us-ascii?q?xNdHzGBeoIhgjuERWAvAwMDA4IigRaBaYN0ghSBZQMDFhGDJ3kcggwdQAMLb?=
 =?us-ascii?q?T03FBueHTyEA4EPG4ELlDyDTwGOfaEDBwOEG6FGTRMDly6TDy6HZJBqqS2BZ?=
 =?us-ascii?q?zqBXH0IgyJPAxkPiACGIRmIdMRpIjU8AgcLAQEDCZAZgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 586q6thLl16AkAuhJY=
IronPort-HdrOrdr: A9a23:nSNccKm9lPUAprQyi3237bZNLh/pDfIj3DAbv31ZSRFFG/FwWf
 rOoB0+726StN9xYgBFpTnkAsS9qBznmaKdjbN/AV7mZniBhILKFvAG0WKB+UyCJ8SWzIc0vs
 1dmupFeb/N5DNB7foSjjPXL+od
X-Talos-CUID: =?us-ascii?q?9a23=3AGFH3PWroMPR4L7PDCcqHiUjmUdo5QiP0ymXeGRD?=
 =?us-ascii?q?7G1drbJ23cHOe1Ioxxg=3D=3D?=
X-Talos-MUID: 9a23:5R9SyAp2WBYpisIedNMezzV7OuhR76meMnEMsI08oue4MjVuNh7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107591301"
X-MGA-submission: =?us-ascii?q?MDF7kN7MsnowrykswH/zmPMk393TLE4r2k5Jcq?=
 =?us-ascii?q?7XkGTEvJK4+wdjsc9EoDiLbtvxwZbWPrbhVJFKCHNvCdnxwfAmko98GE?=
 =?us-ascii?q?/ms8rLKNq1FoiduZ5Wg+RQIxOkH1bN3wAK7ReD1VdUyqvpQ1o9AfiCMN?=
 =?us-ascii?q?H7kvO4FrypuVzgzXS9A/x7NA=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 20:32:05 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3E73AA40CB9;
	Tue, 28 Jan 2025 19:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F73C4CED3;
	Tue, 28 Jan 2025 19:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738092722;
	bh=owNZ34z8H8gKLRBDKBwfWe18qn3L1v88nfMIg3Pz1LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SRwyMrI+7rEDcHW7IuHVGV+Beu/rz3fr4xRZE/2FNaxy/8w04xmtMB+5l/7OjtE7X
	 g/ih+kr8TPIvY/SUMmDSRxJ9agHUzYETwZBr5Vr1MKa3PL3qv7X/YMDfOsOf9s2Vo5
	 w0pVGeJ25CkC8SD9eHiydelX+MwSAm4rpeoVmHUek+yQ4hSnEZyQONnAeLKb6DUyIW
	 UK07D+tXIeIjeZTqlhU59S2JZeZJV301qEk91VI6n4APgSoo/WoePKctqgMT4vkHwk
	 x3yl5NU9mWz8XPDeJzaWsXZh8d3H0HM6TZ2FVo8Y+2ItMnE82HdktnkogYjBpDnvic
	 uPKV+NxOKmHOw==
Date: Tue, 28 Jan 2025 11:32:02 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
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
	Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
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
Message-ID: <20250128193202.GR1611770@frogsfrogsfrogs>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-9-9a6ecf0b2308@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-9-9a6ecf0b2308@linux.microsoft.com>
Subject: Re: [cocci] [PATCH 09/16] xfs: convert timeouts to
 secs_to_jiffies()
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2292
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128193202.GR1611770%40frogsfrogsfrogs>

On Tue, Jan 28, 2025 at 06:21:54PM +0000, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@
> expression E;
> @@
> 
> -msecs_to_jiffies
> +secs_to_jiffies
> (E
> - * \( 1000 \| MSEC_PER_SEC \)
> )
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Looks good to me,
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_icache.c | 2 +-
>  fs/xfs/xfs_sysfs.c  | 7 +++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 7b6c026d01a1fc020a41a678964cdbf7a8113323..7a1feb8dc21f6f71d04f88de866e5a95925e0c54 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -230,7 +230,7 @@ xfs_blockgc_queue(
>  	rcu_read_lock();
>  	if (radix_tree_tagged(&pag->pag_ici_root, XFS_ICI_BLOCKGC_TAG))
>  		queue_delayed_work(mp->m_blockgc_wq, &pag->pag_blockgc_work,
> -				   msecs_to_jiffies(xfs_blockgc_secs * 1000));
> +				   secs_to_jiffies(xfs_blockgc_secs));
>  	rcu_read_unlock();
>  }
>  
> diff --git a/fs/xfs/xfs_sysfs.c b/fs/xfs/xfs_sysfs.c
> index 60cb5318fdae3cc246236fd988b4749df57f8bfc..eed0f28afe97ead762a9539e45f292db7d0d0c4a 100644
> --- a/fs/xfs/xfs_sysfs.c
> +++ b/fs/xfs/xfs_sysfs.c
> @@ -568,8 +568,8 @@ retry_timeout_seconds_store(
>  	if (val == -1)
>  		cfg->retry_timeout = XFS_ERR_RETRY_FOREVER;
>  	else {
> -		cfg->retry_timeout = msecs_to_jiffies(val * MSEC_PER_SEC);
> -		ASSERT(msecs_to_jiffies(val * MSEC_PER_SEC) < LONG_MAX);
> +		cfg->retry_timeout = secs_to_jiffies(val);
> +		ASSERT(secs_to_jiffies(val) < LONG_MAX);
>  	}
>  	return count;
>  }
> @@ -686,8 +686,7 @@ xfs_error_sysfs_init_class(
>  		if (init[i].retry_timeout == XFS_ERR_RETRY_FOREVER)
>  			cfg->retry_timeout = XFS_ERR_RETRY_FOREVER;
>  		else
> -			cfg->retry_timeout = msecs_to_jiffies(
> -					init[i].retry_timeout * MSEC_PER_SEC);
> +			cfg->retry_timeout = secs_to_jiffies(init[i].retry_timeout);
>  	}
>  	return 0;
>  
> 
> -- 
> 2.43.0
> 
> 
