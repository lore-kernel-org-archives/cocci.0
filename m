Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C61C02192
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 06:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=SjO4doi6Crwa1+LH/mFjSX+oOZBIPS0GurKbtLeu/UA=;
  b=JCiaqWzD++T8537czjXQWlZGgX7i+gzkSq+TZUlW7+Ck6S3hJeq71/6d
   WB6lWZsVfaZ2FVKQ2PbA257lFbF4S2flVFU+cuurR+rzqC4/FuwpZ5aUb
   anQxcrajVfhoRUuxhWswON821Abua34O5uNU3nKB0UYc5Ps8I/OTgVD+I
   4=;
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
   d="scan'208";a="205488701"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 07:27:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CBDECE0D1D; Wed, 29 Jan 2025 07:27:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B9DB0E0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 07:27:47 +0100 (CET)
IronPort-SDR: 6799ca63_9QZLmwJr56WCeuKMtI8vu3IcjXzBYNZMmvgztDk0hSYeJAG
 SAPCZTBqK47Rv1EIldoiGvq/TA6Df2Hl0z2nqmQ==
X-IPAS-Result: =?us-ascii?q?A0EjAABFyZlnhdlUsotaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCQoFXMwQLSIxzX4ZTXQaBQYtzhniLLYF+DwEDAQ1EBAEBAwSFA?=
 =?us-ascii?q?AKKdQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEBQEmFew1JARABggcBgSSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDJxMGAQE3A?=
 =?us-ascii?q?Q8LDgouVgYTCIJ6gmUDtRuBATOBAYIMAQEG3B+BZAmBSAGITQGFa0SDOXonG?=
 =?us-ascii?q?32BEIQ/PosHgjOBRC+DQIFsin4dL4IpkVtSexwDWSwBSwo1DDkoSEgDgTSBJ?=
 =?us-ascii?q?gU1CnGCDYEyOgINAoJAcB8xhBuCO4RFYC8DAwMDgiCBFoFng3SCFIFlAwMWE?=
 =?us-ascii?q?AGDJ3gcgiwdQAN4PTcUG54rPIQDgQ+BJoEZkyODTwGab5URhCWhXUkDly6TD?=
 =?us-ascii?q?y6HZJBqqS2BZzqBXE0wCIMiTwMZD4gAhiEZiHTFBUI1PAIHCwEBAwmLboQ3g?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 J85q6ZhI4xb55DLhZYUhg==
IronPort-HdrOrdr: A9a23:rpEOfKM499pkKcBcTs6jsMiBIKoaSvp037Dk7SFMoDhuA6ulfq
 GV7ZAmPHrP5Qr5N0tNpTntAsa9qDbnhPhICOoqTNKftWvdyQiVxehZhOOIqQEIWReOlNK1vp
 0BT0ERMrPNMWQ=
X-Talos-CUID: 9a23:bVrcX21oc/ORBF7t/sdAprxfOdJ+X1/R9HDqPFaqVH9XRbSEYAbI5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3A8CR4Vg5MDZYvkhYIZ4YV/bLgxoww8fj0NRoTn6w?=
 =?us-ascii?q?8tsylGAVAFWuQzxaOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205488700"
X-MGA-submission: =?us-ascii?q?MDHoqo+NlM7ukWTOTFEH41c+BYapgGExuPNEn8?=
 =?us-ascii?q?ZNG2jV12fPQc+iSpZGjQ/7n86Mw7itdbAcg8tQm1fDw6iyvkhRcuPaJw?=
 =?us-ascii?q?BX194euvSr0oznFCM6NOJMiCHD4zW++P1aPebfcCMEB9HJRpaKGxlI5N?=
 =?us-ascii?q?avH9Bu9NdmAbxdOh0/cRKaYg=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 07:27:46 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D54ED5C55CE;
	Wed, 29 Jan 2025 06:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E108EC4CED3;
	Wed, 29 Jan 2025 06:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738132062;
	bh=BcheDkbF7i4plK077EE5fx0I+7LaoMSZmCvmiRwCLWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tYXlaTpf1UHLxCOLY2b71oBs1Z8jmc+k88hDg4mxgy9BfVh5FaZFJ0sctqiMaUJa3
	 0ERjR88O2sKxLaXENNFiYXgW5V6EWANwLybrlRdZ0uAueHnvFc/luTGhJJHi5qSyHf
	 Qhwk4n5jqTURqvwR6zUdrtKBktKuVAQJmisiNKpSZSSK6LJmo4zYOOzg6tSFgxCsOc
	 Qfzb+Ch4Hp08uSkL1c1h9vCW8n/kbD+KUJVXjOVTrDcLl+peTbMx/iozRX16+XGbqx
	 LmxLOokGigU1zjIvh0goqBVkjBWqvL4YDcg+yxNUApdR5ACop75NXb+fT4J9+7jnPJ
	 KRVcLrP4/YQHg==
Date: Wed, 29 Jan 2025 07:27:24 +0100
From: Carlos Maiolino <cem@kernel.org>
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
	"Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
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
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Message-ID: <kywszbmxtm27rlgaefr6xus6l4bpdiouqqe72px7ml72hh4ozc@5orjtzsbg75s>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <JZGx8kYNWP54f9cEViEKZlR6sGGADv31K4TOPtwvyeoDEFkRKICiFaQy04EvZtsQtc44Zozh76mkch2s8rz7mQ==@protonmail.internalid>
 <20250128-converge-secs-to-jiffies-part-two-v1-9-9a6ecf0b2308@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-9-9a6ecf0b2308@linux.microsoft.com>
Subject: Re: [cocci] [PATCH 09/16] xfs: convert timeouts to
 secs_to_jiffies()
Reply-To: Carlos Maiolino <cem@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2298
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/kywszbmxtm27rlgaefr6xus6l4bpdiouqqe72px7ml72hh4ozc%405orjtzsbg75s>

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

Looks fine to me.

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

> 
> 
> --
> 2.43.0
> 
> 
