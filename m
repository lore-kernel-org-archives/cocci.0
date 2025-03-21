Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773D3C36008
	for <cocci@archiver.kernel.org>; Mon, 24 Mar 2025 09:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=kQBajJAoJkC7GwhQVy9dfYo3TE5PXv50NW4/L40caE8=;
  b=isr9pXrdqPgBRKBNEKQreJJ+qKB5KpVAsYmeBdBIxG/ZNrZuC9Ja7iPb
   yfa7QSnrxcqZKq5UP7EykqFnzMMbAtaWnGRA9D/x+YtALM/uFlD4ysHfn
   V+RTzH1wi5KxNUsECSWme2I9KJjq3f0cgQAReZzw8lrCXQsgQfgw6IMep
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.14,271,1736809200"; 
   d="scan'208";a="214380500"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Mar 2025 10:07:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EDD3CE0D2F; Mon, 24 Mar 2025 10:07:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8571EE007A
	for <cocci@sympa.inria.fr>; Fri, 21 Mar 2025 17:09:50 +0100 (CET)
IronPort-SDR: 67dd8f4d_a0aP6OJNU0GhLdrNNJxJgIHbFy/zAGLETlbbRArc+vlzaMA
 +rPbZ/KGM8X2UCF7r0JJnpaRbXnvGXDCa0cAWUw==
X-IPAS-Result: =?us-ascii?q?A0ESAABjjt1njwijxsBaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDcGY0BAtIjHNfhlWBdC0DnhSBQD4PAQMBDUEBAgQBAQMEhQACi?=
 =?us-ascii?q?yICHgYGMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBA?=
 =?us-ascii?q?QE5BUmFew2CYgGBJF4HCTgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eA?=
 =?us-ascii?q?QEeAQEBAgEnEwYBATcBBAsLDjhWBgESgwKCQiMDrlqBATOBAYIMAQEG3GWBI?=
 =?us-ascii?q?AmBSAGITwGFbESDOXongiiBPA6CdT6ECoZ9gjOBaYNBiFaiA1J7HANZLAFVE?=
 =?us-ascii?q?xcLBwWBKUMDKjQxI4EiBTQKKg44KYFjaUk6Ag0CNYIbJVeCKGoEBYEkgjaEP?=
 =?us-ascii?q?lwvAwMDA4MphVCCEYFcAwMWDwGDH3UchEA9hGMtUIJFHUACAQttPTcJCxukE?=
 =?us-ascii?q?zqEQ4EOgSeBGGSSQ4NQAbAIB4QeoU0GDwQvqlcuh2WQayKpEYFnOoFccIM3T?=
 =?us-ascii?q?wMZD4gAhiEMDQkWg0K7fEQyPAIHCwEBAwmCOYMNAQGKIDSBSwEB?=
IronPort-PHdr: A9a23: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
 97Tmaa1IzBHoYq8wA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:fWj+76pTvbhERdOgCk6tWX8aV5rneYIsimQD101hICG9E/bo6P
 xG+c5x6faaskd3ZJhNo6HlBEDEewKmyXcX2/hsAV7BZnidhILAFugLg/qG/9SjIVyCygc379
 YZT0ERMqyXMXFKyezBzE2TFdEmzNOb8Kauq9v/4h5WJ2BXQpAlxT1UTiKAHGNLZCQuP/dYKH
 Pa3Lslm9OnQxh5H6aGL3MONtKz3uH2qA==
X-Talos-CUID: =?us-ascii?q?9a23=3A3Efl+mvLWhRBfwEjupf78HXX6IsIcCfelm7TEXa?=
 =?us-ascii?q?VMmJCR5GMRWGM3oxdxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A72yHzwx/S3NB/9HAOMQftcHL0taaqI72WUcLgLg?=
 =?us-ascii?q?PguCjHnxBfAWbjhidXZByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="112277902"
X-MGA-submission: =?us-ascii?q?MDE727cRMZVMaPzi70C1MUkXUMloHbK0YPPhpU?=
 =?us-ascii?q?yB3yVUw9yycLZzbqg9v/Cb7hc8TGplKRDuOLQRoFckYWrNBTLMccrbId?=
 =?us-ascii?q?J6xuUKQjRvyQij+pVLNfuFreM0WvSvug4h+hULoGJS8Kl94Ypmzidajd?=
 =?us-ascii?q?ppRZv364K3XQ6a36YByGZPSg=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.8])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 17:09:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742573390; x=1774109390;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aDAlamYyZ4jkLWyWBaRa75vEGUzN9zvUrX/xuDuvQhE=;
  b=KD1uX7gP/LojJ727AwyAAyD0Nif/BSbN6jJiNHdeu/UGg7KOcOSrIayc
   zib/pyedUdNPJ4gkTR8fD+esqiAblSHVsozPQfuaLHTdPbRxCF5v7uaWS
   yMtSEWBAwysHpJPOtpgiKebJjf20UbffOFIPsV5FpUflgzXTFxqWy7l7r
   H8ubMuMdMU6XS2ACvFM1Kamh45nczZD2ix4bS85icbG+Xtyz2+MqMEftg
   nJcEJyaCFejn3YlHhic51frQvzNhQ2fHxP+fIu8ir8UDtRroTGy+VNX6W
   AkZ8ajr1b+0kxXohXJ2Ncd607RBSDXS2ns4ll1OnKQA/AKzLpYk5Xl3ir
   g==;
X-CSE-ConnectionGUID: 5sCIidaZSducibx7r9K/1Q==
X-CSE-MsgGUID: T7koVtO8T/Kzj00b9KjEvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="61366685"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="61366685"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:08:47 -0700
X-CSE-ConnectionGUID: s+SzOXF7TAiwIAcfG0mbgQ==
X-CSE-MsgGUID: 6hxEBaxKRL6vcWoyAx4wig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="124388577"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:08:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 21 Mar 2025 18:08:26 +0200 (EET)
To: Easwar Hariharan <eahariha@linux.microsoft.com>, 
    Andrew Morton <akpm@linux-foundation.org>
cc: Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
    Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    James Smart <james.smart@broadcom.com>, 
    Dick Kennedy <dick.kennedy@broadcom.com>, 
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, 
    Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
    Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
    David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, 
    Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, 
    Xiubo Li <xiubli@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
    Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
    "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
    Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>, 
    Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
    Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Selvin Xavier <selvin.xavier@broadcom.com>, 
    Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
    cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
    linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
    linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org, 
    ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
    linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, 
    linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org, 
    linux-spi@vger.kernel.org, imx@lists.linux.dev, 
    linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
    ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-14-a43967e36c88@linux.microsoft.com>
Message-ID: <1252f601-97fd-f199-c339-5bd4ea8060dc@linux.intel.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com> <20250225-converge-secs-to-jiffies-part-two-v3-14-a43967e36c88@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 14/16] platform/x86/amd/pmf: convert timeouts
 to secs_to_jiffies()
Reply-To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2677
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/1252f601-97fd-f199-c339-5bd4ea8060dc%40linux.intel.com>

On Tue, 25 Feb 2025, Easwar Hariharan wrote:

> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
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

Applied to the review-ilpo-next branch.

> ---
>  drivers/platform/x86/amd/pmf/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/acpi.c b/drivers/platform/x86/amd/pmf/acpi.c
> index dd5780a1d06e1dc979fcff5bafd6729bc4937eab..f75f7ecd8cd91c9d55abc38ce6e46eed7fe69fc0 100644
> --- a/drivers/platform/x86/amd/pmf/acpi.c
> +++ b/drivers/platform/x86/amd/pmf/acpi.c
> @@ -220,7 +220,7 @@ static void apmf_sbios_heartbeat_notify(struct work_struct *work)
>  	if (!info)
>  		return;
>  
> -	schedule_delayed_work(&dev->heart_beat, msecs_to_jiffies(dev->hb_interval * 1000));
> +	schedule_delayed_work(&dev->heart_beat, secs_to_jiffies(dev->hb_interval));
>  	kfree(info);
>  }
>  
> 
> 

-- 
 i.

