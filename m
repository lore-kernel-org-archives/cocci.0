Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF4DC02190
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=kNKDjhEJ8WEAWrGsmc4Ai3vMOlslzTIFSyWTX24+HcQ=;
  b=oPEpSC9w5ca3Tpva7HAdp0Z3G/ibaTLM8AvhSwnZUqxe+wJ8xYVLfJ5A
   hhK/rb/W7y+gL3953MXNngHZluFSM9BDDcKUVzaObbgUH9yIJzCb6WST2
   eQvfvjjAsjqKT7Ef58Qkw13rqL/qjpCDic9FZ2Z6TYdHiKdKIPRbiB4bz
   Q=;
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
   d="scan'208";a="205450909"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:29:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 627A5E0D37; Tue, 28 Jan 2025 19:29:02 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7CFE3E00A5
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:29:01 +0100 (CET)
IronPort-SDR: 679921ec_xclHecc1We2AREA9dNrkTBfLPp0yPaGmiVOtWbYzfGfiGEV
 OszmlBz3GzfLDQfaVgT282KTuF1OG8SPotN9qVQ==
X-IPAS-Result: =?us-ascii?q?A0EIAACeIJlnhVvBS5NaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAQGCQoFXMwQLSIxzX4ZTggQghXqMcYstgX4PAQMBDUQEA?=
 =?us-ascii?q?QEDBIUAAop1Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBAQFASYV7DUkBEAGCBwGBJIEmAQEBAQEBAQEBAQEBHQINfgEBAQMnE?=
 =?us-ascii?q?wYBATcBDwsOCi4QRgYTgwKCZQO1NIEBM4EBggwBAQbcH4FkCYFIAYhNAYVrR?=
 =?us-ascii?q?IM5eicbgUlEhD8+iweCM4F0g0ChHVJ7eCwBVTUMYUhIA4E1gSYFNQpxgg2BM?=
 =?us-ascii?q?jcCDQKDT4RMgjuERWAvAwMDA4M4gWmDdIIUgWUDAxYQAYMneRyCBR1AA3g9N?=
 =?us-ascii?q?xQbBp4QPIQDgQ6BJ4F8kkCDTwGOfaEDhCWiJgOXLpMPLodkkGqpLYFnOoFcM?=
 =?us-ascii?q?xoIKAiDIk8DGQ+IAIYhDA0JiGvEViM1PAIHCwEBAwmLIIR5gUsBAQ?=
IronPort-PHdr: A9a23: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
 xgF27X1KcIULIKpgiRf
IronPort-Data: A9a23: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
 Z87q6ZhLYxbNrz/dJbFY+4UvJI=
IronPort-HdrOrdr: A9a23:JKfaX63+sHLocwHl6iKpiQqjBL0kLtp133Aq2lEZdPWaSK2lfu
 SV7ZMmPH7P+VIssRQb9OxoV5PtfZqxz/FICMwqTNGftWrdyQ6VxeNZnOjfKlTbckWUnNK1l5
 0QEZSWY+eRMbEVt6jH3DU=
X-Talos-CUID: 9a23:L3J7L2F4/7iqFqKMqmI6qGsKPZg0dEGC1U3POnS5BE1IVp+8HAo=
X-Talos-MUID: 9a23:f65uFgvNzKihH7siSs2n2CtSLsJsuvWUGG8EyoUDkYqZJHx+NGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107588664"
X-MGA-submission: =?us-ascii?q?MDG/BX8KHGNx2FX7Z436cqv2rqBk5JIGd/afrL?=
 =?us-ascii?q?6ljH+86QwdNcu1mMzUVLbVRKNwlxPgUhZqPBVSBk/yAsw+aCsBKKEVj7?=
 =?us-ascii?q?0V7rWBYp1boDxhguQLUKU5uHMukTKWaewAd5RJt/PUoR4EINnHSDTDhM?=
 =?us-ascii?q?gbDkhaZOcX8jQDY270mtNT7Q=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 19:29:01 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B4AC3A40F8F;
	Tue, 28 Jan 2025 18:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831A6C4CEE4;
	Tue, 28 Jan 2025 18:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738088938;
	bh=5vKlyluoIwL5MLSNFaVfQU6gpPWlLBGUfC043Y4ZA48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4RylrDTIX8Uy8PaKXepTKmo9JbD2s1TqRqjVjk79EX6UIO6eP0djQtJJK88za5Fk
	 JwkXSxGvgFzlp0bbaHNaHN00HXwLVEDwoROTo5wDfRfsMG/11EZ/60VjHn4wEmzqLa
	 kcHBrGV05EUJahj0VGnWlSX1miKbeH9kIAO+dxoNow3QgUmwhY5pXRiW1OXApD28B+
	 xQIEadslx9mpHUs2SEA3p3YZ8dPP9LWiKFJVTR9KJ/66eUffexnSqE6XYU8c9mp7pG
	 pv+Gt1KZVlb4zPDYIUoffAngd1LNkOTrkLP3jy3oC+qPbj05QBwYJ5EYU4eU5MsroI
	 zPBbqI0b5RbTw==
Date: Tue, 28 Jan 2025 11:28:52 -0700
From: Keith Busch <kbusch@kernel.org>
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
	"Darrick J. Wong" <djwong@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
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
Message-ID: <Z5kh5BYrYaDArkkU@kbusch-mbp>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-11-9a6ecf0b2308@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-11-9a6ecf0b2308@linux.microsoft.com>
Subject: Re: [cocci] [PATCH 11/16] nvme: convert timeouts to
 secs_to_jiffies()
Reply-To: Keith Busch <kbusch@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2289
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/Z5kh5BYrYaDArkkU%40kbusch-mbp>

On Tue, Jan 28, 2025 at 06:21:56PM +0000, Easwar Hariharan wrote:
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
>  drivers/nvme/host/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 76b615d4d5b91e163e5a6e7baf451c959a2c3cab..87498215ede4bcaf48660b89c901075dfcfaf041 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4459,11 +4459,9 @@ static void nvme_fw_act_work(struct work_struct *work)
>  	nvme_auth_stop(ctrl);
>  
>  	if (ctrl->mtfa)
> -		fw_act_timeout = jiffies +
> -				msecs_to_jiffies(ctrl->mtfa * 100);
> +		fw_act_timeout = jiffies + msecs_to_jiffies(ctrl->mtfa * 100);
>  	else
> -		fw_act_timeout = jiffies +
> -				msecs_to_jiffies(admin_timeout * 1000);
> +		fw_act_timeout = jiffies + secs_to_jiffies(admin_timeout);
>  
>  	nvme_quiesce_io_queues(ctrl);
>  	while (nvme_ctrl_pp_status(ctrl)) {
> 
> -- 

Acked-by: Keith Busch <kbusch@kernel.org>
