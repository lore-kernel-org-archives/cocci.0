Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD26C0218D
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 05:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=AlfHderxthQMeExnzJFyim+ot5sUrIiLRVIl31grSHI=;
  b=Wc809wqMywtCrcOOANHcdasVLnHQR2ffqIwFk+B4nyJo5uOdXlLpWdVx
   xgsJvJMeNF0Y/8Xo79USVdoL1TIzrWqQW9IxWUCPNRr0+h1DLNvUv3mXn
   9kKoeIcU79amOfZfc9EOxVr6nUn+XoRb7qyn8i6wfyvjYUlJlFqzaehc7
   k=;
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
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205484801"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 06:21:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 371D0E0D1D; Wed, 29 Jan 2025 06:21:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6D2AEE0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 06:21:13 +0100 (CET)
IronPort-SDR: 6799bac9_gDcecXpb3AZfGU+9PIirRJefLpZjxEStMTDsGHst4DOtEhZ
 XmosXzWP2iiWteNyecjxSkJGpu43hZDiG5YGYKA==
X-IPAS-Result: =?us-ascii?q?A0EyAADtuZlncdMLX9VaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVY0BAuNO4cyWQEDBoFBi3OSJYF+DwEDAQ1BAQIEAQGFBwKKd?=
 =?us-ascii?q?QIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABgQyGC?=
 =?us-ascii?q?IJiAYQAAQEBAycTPxALDgocEhQXMYV6B7UigQEzgQHgIIFIAYhNAYVrhR4bf?=
 =?us-ascii?q?YEQhD8+iFiCLwSCL4Fzg0ChOlJ7HANZLAFVExcLBwWBKUgDgREjgSYFNQo3O?=
 =?us-ascii?q?oINaUk6Ag0CNYIefIIrgiGCO4RFYC8DAwMDgzaFW4IUgWUDAxYQAYMneByCL?=
 =?us-ascii?q?B1AAwttPTcUGwaiY5pBAbAAgj+BZoRvnFdNg3EBk2CTAS6HZJBqqS2BZzqBX?=
 =?us-ascii?q?DMaCBwUgyNOAxkP3DJFbgIHCwEBAwmFRgEBil2BSwEB?=
IronPort-PHdr: A9a23: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
 cOJ07vI
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:YnPvY6Dd2uxxjBflHemh55DYdb4zR+YMi2TDGXofdfVwSL38qy
 nOpoV46faaslwssR0b9OxofZPwJU80lqQFgrX5X43CYOCOggLBR72Kr7GD/9SKIUPDH4BmuZ
 uIP5IOb+HNMQ==
X-Talos-CUID: 9a23:Sn1OrW09w8xNxW+jxq1ImbxfFMYbb2zn7UzqP1KpD0hzTJKMdVCVwfYx
X-Talos-MUID: 9a23:JYOmgwRJXpxPknv/RXS81DIhCdl54p+SLxkhwKoI5PW9MAF/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205484798"
X-MGA-submission: =?us-ascii?q?MDH4dkelQ79BFJNry1RPyy8UPzIX5L1xEdUM35?=
 =?us-ascii?q?oywvLT6zC3Gn4Mt3CvNxW2EfpNjjf01cpUIcb7qpSALTU1XzV6cCuVjF?=
 =?us-ascii?q?BQVkjb5UKUyylsY/4yp8UZIWLB2B+ePuIMt0+iMuRIfEm0marGFl2ji6?=
 =?us-ascii?q?SVBTiV9MXhPS/16GVGhl1Kpg=3D=3D?=
Received: from verein.lst.de ([213.95.11.211])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 06:21:13 +0100
Received: by verein.lst.de (Postfix, from userid 2407)
	id 77CD368BEB; Wed, 29 Jan 2025 06:21:08 +0100 (CET)
Date: Wed, 29 Jan 2025 06:21:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yaron Avizrat <yaron.avizrat@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
Message-ID: <20250129052108.GB28513@lst.de>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com> <20250128-converge-secs-to-jiffies-part-two-v1-9-9a6ecf0b2308@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-9-9a6ecf0b2308@linux.microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Subject: Re: [cocci] [PATCH 09/16] xfs: convert timeouts to
 secs_to_jiffies()
Reply-To: Christoph Hellwig <hch@lst.de>
X-Loop: cocci@inria.fr
X-Sequence: 2297
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250129052108.GB28513%40lst.de>

On Tue, Jan 28, 2025 at 06:21:54PM +0000, Easwar Hariharan wrote:
>  		else
> -			cfg->retry_timeout = msecs_to_jiffies(
> -					init[i].retry_timeout * MSEC_PER_SEC);
> +			cfg->retry_timeout = secs_to_jiffies(init[i].retry_timeout);

This messes up the formatting by introducing an overly long line.

Otherwise the change looks fine.
