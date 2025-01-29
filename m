Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F5AC02190
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 13:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=i3rgV9p1M11zg70YJd81eEOKwLUjD2dANy4KTLxUdZU=;
  b=frd2mwJODznXgl9smf9abkrXV4N3gPNQk4jxzixkmlx3kkBhLxZ+pvse
   POxyhq66iegnrVGo5697HP+Dr5QWTYan2xpSBZnv1BazE0qg8Iqt5atOj
   QJEjo4+CpN7iDvaAXE0Szab4V7D2wPkR7YEFhe5BdtQTTgmg1lUZv260S
   A=;
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
X-IronPort-AV: E=Sophos;i="6.13,243,1732575600"; 
   d="scan'208";a="205584089"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 14:13:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0220CE0261; Wed, 29 Jan 2025 14:13:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C11C3E0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 14:13:10 +0100 (CET)
IronPort-SDR: 679a2966_mQtPpCkNe7ChD6JZLvYm01fMsCdG4h4VARJBs0lBjeTcFH8
 oSof4OmXd03bCLc+aAOtfagTOYt5jPHoLcXHh6Q==
X-IPAS-Result: =?us-ascii?q?A0EkAABtKJpnjwijxsBaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDcGY0BAtIjHNfhlOBdC0DnheBQD4PAQMBDUEBAgQBAQMEhQACinUCHgYGM?=
 =?us-ascii?q?AkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBAQE5BUmFe?=
 =?us-ascii?q?w2CYgGBJF4HCTgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAQEBA?=
 =?us-ascii?q?gEnEwYBATcBBAsLDjhWBhODAoJCIwO1coEBM4EBggwBAQbcY4EgCYFIAYhNA?=
 =?us-ascii?q?YVrRIM5eieCKIE8CwOCdT6EChGGbIIzgXODQIh7mD9SexwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SlIA4ERI4EmBTUKNzqCDWlJOgINAjWCHiVXgitrBAWBLYI7hEVgLwMDAwODN?=
 =?us-ascii?q?oVbghSBZQMDFhABgyd4HIIsHUACAQttPTcJCxueKzyEA4EOgScdgV+SQINPA?=
 =?us-ascii?q?bAAB4QeoUsGDwQvhASNBplJLodkkGqpLYFnOi6BLnCDN08DGQ+IAIYhDA0Jg?=
 =?us-ascii?q?1jKDUQyPAIHCwEBAwmCOYMNAQGKGwEnDIFLAQE?=
IronPort-PHdr: A9a23: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
 d/KxvqbFQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:VS713qBfQyrPeMrlHei7sseALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+U8ssQIb6Ki90ci7MDrhHPFOkOws1NuZMjUO/VHYSr2KjrGSiwEIeReOktK1vJ
 0IG8QQNDSzNykcsS+Q2mmF+qMbsbu6GdeT9ITjJhlWLD1CWuVF1UNUGwybGkp5SE1vAoc4Lo
 OV4o5qtietYnMea+W8Hz0gU/LYr9PGuZr6aVpebiRXojWmvHeN0vrXAhKY1hARX3dmxqojy3
 HMl0jU97iuqPayzz7bziv2445NkNXs59NfDIini9QTKB/rlgG0Db4REIGqjXQQmqWC+VwqmN
 7Dr1MLJMJo8U7ceWmzvF/ExxTg+CxG0Q6v9XaoxV/Y5eDpTjMzDMRMwahDdAHC1kYmtNZglI
 pWwmOisYZNBx+oplWz2zGIbWAlqqOHmwtjrQchtQ0dbWLYUs4SkWUrxjIVLH7HJlO+1GloKp
 grMCiW3ocsTbrTVQGigoAo+q3gYp17JGb6fmES/sOSyDRYh3Z/0g8Rw9EehG4J8NYnR4BD/P
 msCNUdqFhidL5lUUtGPpZ1feKnTmjWBR7cOmObJlrqUKkBJnLWspbypLE4/vujdpAExIY73M
 2paiIviUciP0b1TcGe1pxC9R7ABG27QDT208lbo5x0oKf1SrbnOTCKDFouj8yjqfMCBdCzYY
 fFBLtGR/v4aWf+E4dA2APzH5FUNHkFScUQ/s02Xlqfy/i7WbECdtarAMo7CICdbwrMAFmPfk
 frdAKDW/lo/wSsRmLyhgTXVjfkZlH/lKgAYZTnww==
X-Talos-CUID: 9a23:1KZY9myzo6Qo6FLPaWC9BgU6GJ5/a3H90k3PCFeeE01ZUpCfSgefrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AOhShqQ9he54t616mxXhdvTiQf8hS6a2pV2ASqLp?=
 =?us-ascii?q?YlNGmEjRJCzyvgDviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,243,1732575600"; 
   d="scan'208";a="205584082"
X-MGA-submission: =?us-ascii?q?MDE62DTE/JfruRbMxfp4hxUGbXgc2PpiYQiEqo?=
 =?us-ascii?q?Pm1VhkGhgUXdcs9/9RWES7cJ6kI0SemCvHM/i3UUOEDoeHyNpRGo+9AH?=
 =?us-ascii?q?06mLs8LtPka7/N0wZwxW2FhlHUP8YhNQu5wXWST4KZeAILSQ1S0yVkD5?=
 =?us-ascii?q?3S+ekrDA+VKY49F6XZFoT0PQ=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.8])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 14:13:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738156390; x=1769692390;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uWLMAkjiPxmd0IZ1cdFsHKZZFguDfleylm6v197BRzQ=;
  b=GA++SSPokmDrtk+90xAO5ru4NDx06RxbTf4hVle1bHGYZSW0DQVnsPS3
   C1tznJORYqf+6pxNt2tQkCwju50/Etf+erxsRLi2gxIAIxFj7gpQ6qGAd
   uuWoSriaKFxexk3UhMZPhvwb1x4efQOKsupTf/NHPeUtEXA0MOsn6wVgs
   Lp2ViMbr+ZUQDx9HXOhK01Vys0NGaArE9KC/mobC0dMtYj3gyjmsZGv14
   s0Uqo8ULQQ3XVMr8QULMdRVFPgy5511RuyNAAkbjNw8lz/yVpFA6V661G
   In3JDekjNEGvOVd1cHMKOkluIRUfIIEUQLo/uh/YEp2YdAtS3gGZI7Vta
   g==;
X-CSE-ConnectionGUID: cliXGXQAQ0u9UMcwUA1lCA==
X-CSE-MsgGUID: iPmNGeYDQNuk0Ry7Y7iGoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="56203311"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="56203311"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 05:13:06 -0800
X-CSE-ConnectionGUID: VQdEsMXqR8qBKjmeEKbOAw==
X-CSE-MsgGUID: O+KtZNkvRJq7JgLfGnW4VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113646751"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 05:12:52 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 29 Jan 2025 15:12:49 +0200 (EET)
To: Easwar Hariharan <eahariha@linux.microsoft.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
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
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-14-9a6ecf0b2308@linux.microsoft.com>
Message-ID: <e8207616-6079-be0d-d482-6577616a4cc7@linux.intel.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com> <20250128-converge-secs-to-jiffies-part-two-v1-14-9a6ecf0b2308@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH 14/16] platform/x86/amd/pmf: convert timeouts to
 secs_to_jiffies()
Reply-To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2310
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/e8207616-6079-be0d-d482-6577616a4cc7%40linux.intel.com>

On Tue, 28 Jan 2025, Easwar Hariharan wrote:

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
>  drivers/platform/x86/amd/pmf/acpi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/acpi.c b/drivers/platform/x86/amd/pmf/acpi.c
> index dd5780a1d06e1dc979fcff5bafd6729bc4937eab..6b7effe80b78b7389b320ee65fa5d2373f782a2f 100644
> --- a/drivers/platform/x86/amd/pmf/acpi.c
> +++ b/drivers/platform/x86/amd/pmf/acpi.c
> @@ -220,7 +220,8 @@ static void apmf_sbios_heartbeat_notify(struct work_struct *work)
>  	if (!info)
>  		return;
>  
> -	schedule_delayed_work(&dev->heart_beat, msecs_to_jiffies(dev->hb_interval * 1000));
> +	schedule_delayed_work(&dev->heart_beat,
> +			      secs_to_jiffies(dev->hb_interval));
>  	kfree(info);
>  }

Hi,

So you made the line shorter but still added the newline char for some 
reason even if the original didn't have one?? Please don't enforce 80 
chars limit with patches like this.

-- 
 i.

