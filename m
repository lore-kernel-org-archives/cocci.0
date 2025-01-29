Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42394C0218D
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 21:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=O+JFGGFluQhzEspwlwz6aXkZ7QKW4DjxL6knEN3myoo=;
  b=lIc7ZsKgCDdQj/RYKTfbIsquO88Bndv+i2+IYKRCESjKotCt6cwS9AXh
   Wv30rHstpnus5YqRW7/9GyLHGS5DOUi5qRateNqSRngAVSNdMCP0xMaeL
   IGmjpBLXQ3jk/briO7jxiehiMYVIYATUpZ3Wks6Wz4kci9dsiVRTrRGcw
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.13,244,1732575600"; 
   d="scan'208";a="205662573"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 22:04:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 81C60E0260; Wed, 29 Jan 2025 22:04:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 01070E0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 22:04:01 +0100 (CET)
IronPort-SDR: 679a97c0_JcYjU3t4AOocdaySO9wrSx4aeLn/OsCdPJWXlxT6wzSUayl
 KqwiDmGHfvWTkW7ADeWZVFD3wRHGsTug+MVa7Eg==
X-IPAS-Result: =?us-ascii?q?A0EBAAAzl5pnhbaaTQ1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAYJDgVczBwhIhFaIHYlTAxOLYJBOg?=
 =?us-ascii?q?VaBQD4PAQMBTgECBAEBAwSFAAKKdQIfBgEEMAkOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?RABAQUBAQECAQECBAYBAhABAQEBQEmFew2CYgGBJFENSAEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBARECDV4BAR4BAQEDERIEGQEBNwEPCw4KAgImAgJWBgESA?=
 =?us-ascii?q?gEBgn6CZQYCpFEBh2ABAQKLI38zgQGCDAEBBtwfgWQJgRouAYhNAYVrGyAJh?=
 =?us-ascii?q?DMnG4FJRIE8DoJ1PoRYg0aCaYIzSoEpg0CRCpA5UnscA1ksAVUTFwsHBYEpE?=
 =?us-ascii?q?DgDIAo2MQIUDRAPBhAEbQU1Cjc6gg1pSTcCDQI1gh4kWIEdgQ5rBAWBLYI9h?=
 =?us-ascii?q?EVgLwMDAwODNoJFVIJEghR6awMDFhABgyd4HIJDHUACAQttPTcGAwsbQ512P?=
 =?us-ascii?q?INkGQcBgQ2BJwWBE5Mkg08BgQWNDWuhA4QloUsGDwQvhASNBoZOknsuh2SQa?=
 =?us-ascii?q?iKoWoIYOoFcRgcjFYMiTwMZD4gAhiEZg2HJfyI1PAIHCwEBAwmFRgEBikuBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 xGS3T5Cc3ILTP0kvrRh8UZvYoy9
IronPort-Data: A9a23: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
 gSR3g==
IronPort-HdrOrdr: A9a23:cio3japUPs4y8s3w7P0igsYaV5obeYIsimQD101hICG9vPb5qy
 ncpoV96faSskdoZJhAo6H4BEHjKUm3yXcR2+Qs1NiZMzUO1FHYSL2KqLGSpQEIeBeRygc+78
 tdmsFFYbWaMbE5t7ee3ODSKadC/DDoytHLuQ6T9RZQcT0=
X-Talos-CUID: 9a23:PLeTqW7YOTtoltF0DNss3nA0QusVdyzk5UjzEhOqEkBCSrqlVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3A/AilGQwavPbri980kTlRfFvYbCeaqLbwA3Aissp?=
 =?us-ascii?q?BgpiBDg5gIje3qT+YSbZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,244,1732575600"; 
   d="scan'208";a="107699345"
X-MGA-submission: =?us-ascii?q?MDEB4y+BRXmigYiBwpuHG6lN/OVFC7AKQfwqzu?=
 =?us-ascii?q?a52KAXG7AF4phwboakyUmi0kb11EgpFVJGAM4n/pX3h42mimVFWCM7UK?=
 =?us-ascii?q?HrsWN9amilMoJVXp90z9wl36DeR+z+yKPbFyF4uMIOJq47hvQBsI7ypK?=
 =?us-ascii?q?2dUG27ACSK4eizi3k/9PAiEQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 29 Jan 2025 22:04:00 +0100
Received: from [100.65.161.47] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4FFDA2109A5E;
	Wed, 29 Jan 2025 13:03:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4FFDA2109A5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738184637;
	bh=O+JFGGFluQhzEspwlwz6aXkZ7QKW4DjxL6knEN3myoo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=mY3mAkZdBwX5JW6v0rHOcPwixnNpeCwrI5i6lioeivoGl5PeSwTfMHOmjED6AV41/
	 5wIYfQa9MecJKhXc6T7//bDDoOB4BG1MPO3Miu2pGAWJwBcdsKKFOS1hzy+NN34ovy
	 jA6uxIox2R9YzB3PKnfuI/uqwUCqDlg2DifBsbMw=
Message-ID: <dd0358b1-7c8a-4c9e-88c5-2e1db69a3a35@linux.microsoft.com>
Date: Wed, 29 Jan 2025 13:03:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay
 <ogabbay@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, James Smart
 <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
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
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 eahariha@linux.microsoft.com, cocci@inria.fr, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
 Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-6-9a6ecf0b2308@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-6-9a6ecf0b2308@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH 06/16] rbd: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2316
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/dd0358b1-7c8a-4c9e-88c5-2e1db69a3a35%40linux.microsoft.com>

On 1/28/2025 10:21 AM, Easwar Hariharan wrote:
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
>  drivers/block/rbd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

<snip>

> @@ -6283,9 +6283,9 @@ static int rbd_parse_param(struct fs_parameter *param,
>  		break;
>  	case Opt_lock_timeout:
>  		/* 0 is "wait forever" (i.e. infinite timeout) */
> -		if (result.uint_32 > INT_MAX / 1000)
> +		if (result.uint_32 > INT_MAX)
>  			goto out_of_range;
> -		opt->lock_timeout = msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->lock_timeout = secs_to_jiffies(result.uint_32);
>  		break;
>  	case Opt_pool_ns:
>  		kfree(pctx->spec->pool_ns);
> 

Hi Ilya, Dongsheng, Jens, others,

Could you please review this hunk and confirm the correct range check
here? I figure this is here because of the multiplier to
msecs_to_jiffies() and therefore unneeded after the conversion. If so, I
noticed patch 07 has similar range checks that I neglected to fix and
can do in a v2.

Thanks,
Easwar (he/him)
