Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC01C0218D
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 00:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wHjNpOH7tyr94rRGxv8dPL8l4uWj+W2mHTQ0QQI6FRM=;
  b=BDdB7HYGj/pNQY+tqgaaxJhDErxi1MkJdyWVewMBXkVugEJbrwXXhOoy
   /jOQz3QYJCaBPGEyI7NJVkkQklUwppb7FtE7ms7gTarUdbU6PmnrznwsP
   i2+C8xQXP4qQj/HadIZnOgg1NyQv8o0U6u2V8chSczbWv2RVKF0M6OQOI
   U=;
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
   d="scan'208";a="205474700"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 01:22:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DB34CE0D1E; Wed, 29 Jan 2025 01:22:24 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 37983E0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 01:22:20 +0100 (CET)
IronPort-SDR: 679974bb_M9Gx+ybnrIZPFhOezMGw4F4WKf5PcKC8kLSaXJyJEqU9yb6
 wjKZK3tcqLOuCzePE+o4FYi61H9O3xF3jnwxMtg==
X-IPAS-Result: =?us-ascii?q?A0EIAACBc5lnhVvBS5NaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBAtIhFaIHV+GU4F0LQOEO5gHgVaBf?=
 =?us-ascii?q?g8BAwENRAQBAQMEhQACinUCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEBAUBJhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BA?=
 =?us-ascii?q?QEDIwQZAQE3AQ8LDgoCAiYCAlYGARICAQGCfoJlA7UnfzOBAYIMAQEG3B+BZ?=
 =?us-ascii?q?AmBGi4BiE0BhWs7CYM5eicVBoINgTyBFIFvPoRYg0aCaYIzgXODQKE2UnscA?=
 =?us-ascii?q?1ksAVUTFwsHBWFIEDgDIAo2MQIUDRAPBhAEbQU1Cjc6gg1pSToCDQI1gh4kW?=
 =?us-ascii?q?IIrawQFgS2CO4RFYC8DAwMDgzaCQ1SCRIIUemsDAxYRgyd4HIInHUACAQttP?=
 =?us-ascii?q?TcGAwsbBj2dZTyEA1cqDRyBC5Q8kWJooQaEJaFLBg8EL5dEkw8uh2SQaiKpC?=
 =?us-ascii?q?4FnOoFcTTAIgyJPAxkPiACGIQwNCYhriioBulE0NTwCBwsBAQMJkCWBSwEB?=
IronPort-PHdr: A9a23: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
 8f0pLKvf0T4wB6Y4epUbZ3APU6Tw6GC
IronPort-Data: A9a23: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
 b8biodDD616GpDehEfxh+8UvA==
IronPort-HdrOrdr: A9a23:n+SCG6/Bw+L24dIAL0Fuk+DTI+orL9Y04lQ7vn2ZKCY4TiX2rb
 HNoB12737JYVUqN03I5+rvBEDoexq1nvRICKYqXYtKNzOW3VdAQrsSjrcKIQeMJ8U7ndQtsp
 uJtMNFebnNMWQ=
X-Talos-CUID: 9a23:WNnRLG/8OSPKx56d1v6VvxEZIeJ7WXrb91WKLWSbIDZjR7KEbEDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AmsAa3A+bOiKPPGosEPwuT9WQf8hIzufxVGsrrYg?=
 =?us-ascii?q?hgtarHiJiFTenqg3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205474699"
X-MGA-submission: =?us-ascii?q?MDG1Als/aRL/W0KIivFD6e2zUbptkFCuKynxto?=
 =?us-ascii?q?PBeKH6rgWK8izxr3nPPJgzlFr/qaBWTEU+90TWyGLcULIL+DGUsmAkeU?=
 =?us-ascii?q?auvCapaY/5l/qbWOeE/wbc9t0FPW7+PYWxsFWyq+SVBxyDTXqhuvYt8T?=
 =?us-ascii?q?YJRrV9dWyIq7/6mSaSIcdo/w=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 01:22:19 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 50FEFA41615;
	Wed, 29 Jan 2025 00:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED094C4CED3;
	Wed, 29 Jan 2025 00:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738110137;
	bh=o5hYXLrn2BSP7xY88i6vdkcwT4JSgB+EBSjp35TyIH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LvaYBX/PT4FznDpU2Sd7jAjMWT4Zhccvq1G9nSszqh/z9EeEvQMdhKwHFf7ytbKF+
	 IUR+ABOYF1Zb5ToAxGojoYFF5LcMvZK8Geqv9mvejas0wlawpm2evJ55461lpZ3/I/
	 zVKKBQPMk2YJIFo/RCbg1PW01H9enhxph87W35ORJ0IbWnkqCyucviUycj1TOFFCX5
	 tVowcKWyDXFzGw9RnW0kp5cJosqChn0Zj7syPQ+RNy64a4hU0MGfSeqeKrMrafwXVt
	 ED+vwkcJ1uDpOqa3gcUHNMFHbXgSAwCyOvMlWR1/qOlt8d2jZrQdrJy3iTMJ/IM0sX
	 QFqOs0rnLo8tg==
Message-ID: <f39cde78-19de-45fc-9c64-d3656e07d4a7@kernel.org>
Date: Wed, 29 Jan 2025 09:21:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>,
 Xiubo Li <xiubli@redhat.com>, Niklas Cassel <cassel@kernel.org>,
 Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 linux-rdma@vger.kernel.org
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-8-9a6ecf0b2308@linux.microsoft.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-8-9a6ecf0b2308@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH 08/16] libata: zpodd: convert timeouts to
 secs_to_jiffies()
Reply-To: Damien Le Moal <dlemoal@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2295
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/f39cde78-19de-45fc-9c64-d3656e07d4a7%40kernel.org>

On 1/29/25 3:21 AM, Easwar Hariharan wrote:
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

The subject line should be:

ata: libata-zpodd: convert timeouts to secs_to_jiffies()

Other than that, looks good to me.

Acked-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/ata/libata-zpodd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
> index 4b83b517caec66c82b126666f6dffd09729bf845..799531218ea2d5cc1b7e693a2b2aff7f376f7d76 100644
> --- a/drivers/ata/libata-zpodd.c
> +++ b/drivers/ata/libata-zpodd.c
> @@ -160,8 +160,7 @@ void zpodd_on_suspend(struct ata_device *dev)
>  		return;
>  	}
>  
> -	expires = zpodd->last_ready +
> -		  msecs_to_jiffies(zpodd_poweroff_delay * 1000);
> +	expires = zpodd->last_ready + secs_to_jiffies(zpodd_poweroff_delay);
>  	if (time_before(jiffies, expires))
>  		return;
>  
> 


-- 
Damien Le Moal
Western Digital Research
