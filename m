Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89328C3600C
	for <cocci@archiver.kernel.org>; Mon, 24 Mar 2025 09:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=fZxWr7Cjs/qhHm/DOStAqn9aFWtD5lCcmIr3VDYuSj8=;
  b=DoZqC55cr73sd2SdRa9Vbls00oo8jrIceEj/R4qClRRiwsJdTuLcWAqJ
   OHFlQ3LCSGeaBn2p27kPkkBFmk9P2kNgep1v8udd/dDkiHotarsz8Zkfw
   1OfvmoEAzm146W5i8cGWjiIdIapHgP+Vrkvk5NjzlPjfRLE4/OT5GZtVL
   w=;
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
   d="scan'208";a="214380456"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Mar 2025 10:07:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 03AA8E0D1E; Mon, 24 Mar 2025 10:07:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AA8DAE007A
	for <cocci@sympa.inria.fr>; Fri, 21 Mar 2025 17:06:28 +0100 (CET)
IronPort-SDR: 67dd8e83_FmI7EDa3/C0pa3DkgfjTZlwYIXgneXl7WykpfJqLr4CHdwv
 aD3RILrtalJ9LE08PySo2yAlZgYKowr+gRHrtrw==
X-IPAS-Result: =?us-ascii?q?A0EUAAB5jd1ngxGjxsBaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQQQBAQELAYJDcGY0BAtIjVKGVYF0MJ4UgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?IUAAosiAh4GBjIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBATkHDjuFew2CYgGBJF4HCTgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERA?=
 =?us-ascii?q?g1eAQEeAQEBAgE6BgEBNwEECwsOOFYGARKDAoJCIwOuXoE0gQGCDAEBBtxlg?=
 =?us-ascii?q?SAJgUgBiE8BhWxEgzl6J4IogTwOgnU+hAqGfYIzgWmDQYhWogNSexwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSlDAyo0MSOBIgU0CioOOCmBY2lJOgINAjWCGyVXgihqBAWBJII2h?=
 =?us-ascii?q?D5cLwMDAwODKYVQghGBXAMDFg8Bgx91HIRAPYRjLVCCRR1AAgELbT03CQsbp?=
 =?us-ascii?q?BM6hEOBDoEngRiTJ4NQAbAIB4QeoU0GDwQvqlcuh2WQayKpEYFuBC+BXHCDN?=
 =?us-ascii?q?08DGQ+IAIYhDA0JFoNCu3lEMjwCBwsBAQMJgjmDDQEBiiAEMIFLAQE?=
IronPort-PHdr: A9a23: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
 tzOkr/jbjZE79/Qu8AbApqMQP8=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:qT31Faxx8OvVwZ5j/qDNKrPw4L1zdoMgy1knxilNoH1uA7Olfq
 WV98jzuiWE7wr5NEtQ/exofZPwOk80lqQFnbX5X43SJjUO0VHARO8SiLcKgQeQZhEWndQtrZ
 uIHZIObuHYPBxRt+q/yg++FNor3dmA946Vpcq29R0NcShaL4tbw0NcEAi0Lm1aLTMqZabRU6
 DshfavoQDNFgV0Uu2wDBA+LpH+m+E=
X-Talos-CUID: =?us-ascii?q?9a23=3AHV2L7mquwgB+JPBNrY1xpN3mUfkCeVrTlEzuH3T?=
 =?us-ascii?q?7CUxpQ4W2TGeP05oxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ADYYPxQyszzxmVhZTUYikwtXVfuKaqIn3MU9OqIk?=
 =?us-ascii?q?qgpiFJyhgMAuHixmxQbZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="112277553"
X-MGA-submission: =?us-ascii?q?MDFE6v4ram2j5y0w4zZjjJDDEpeHv7oF9YOF3i?=
 =?us-ascii?q?CpEIMe1zH9a5dhh/BhGU5Q0pbt7hs6I7o0oIQl89JZBNJVmO8R923u9/?=
 =?us-ascii?q?TRSByoSZDaO+pqhiWgUykwa1X0kj+W6iOu/Y5LqUE+kec+hFUky9TAq6?=
 =?us-ascii?q?nW9J5KIVHuJ1LJL8j8ReLZ+Q=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.17])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 17:06:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742573186; x=1774109186;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WgBVYTr0URRl3zJspKTAryBSC/YiYErKzgv7WS4Rg/s=;
  b=kNY6qShHkXm1x8Yg7zqcvb96B9oH334+xnb4UrIOT5Jne+1ymdX/3dVR
   345k5hnGTjjP7Xj8CzLba5AQDFbGmmuoZcXorMMF+UN2cSURY0iteHGo8
   qngWRJVySzSCZi+3uXyF9V8oLg4tg28oRL411ON7pk3SSbFzIqT7WDUE1
   Irspw+E//l/KZQWLa0dQZSWCjDuhQZfblKzicVIWs+3mS70ixep2Zddp9
   Fq6YWZC4AZTKmBJEiUuimIWZt0lSxjfUfWMnu43Sc9NPPoma1QEsjKmcm
   uGZW/dbAA6J4P8TtMRM9dSXXkSDqrtvNc/7ityc83pkJgCk6lvzWdWpJz
   g==;
X-CSE-ConnectionGUID: HTFhQPXtQG6ZFeNA+Pnfcw==
X-CSE-MsgGUID: 6Wp12Q2WQ2e1ZB4kXk6jew==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43726601"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="43726601"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:06:23 -0700
X-CSE-ConnectionGUID: g7UgcbV4QTih6n+cWYD8tQ==
X-CSE-MsgGUID: 1EcrVXRMQNGo+fC3Vk/4zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123417648"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:06:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 21 Mar 2025 18:06:02 +0200 (EET)
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
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-15-a43967e36c88@linux.microsoft.com>
Message-ID: <9e761e10-eb4d-0a34-79b5-ef4507f002c5@linux.intel.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com> <20250225-converge-secs-to-jiffies-part-two-v3-15-a43967e36c88@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 15/16] platform/x86: thinkpad_acpi: convert
 timeouts to secs_to_jiffies()
Reply-To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2676
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/9e761e10-eb4d-0a34-79b5-ef4507f002c5%40linux.intel.com>

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
>  drivers/platform/x86/thinkpad_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index ab1cade5ef231e9a9a520bc0cca82384c911a331..d269e791f7fbc2a8ccf96f28cb476beccb57c9a7 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8512,7 +8512,7 @@ static void fan_watchdog_reset(void)
>  	if (fan_watchdog_maxinterval > 0 &&
>  	    tpacpi_lifecycle != TPACPI_LIFE_EXITING)
>  		mod_delayed_work(tpacpi_wq, &fan_watchdog_task,
> -			msecs_to_jiffies(fan_watchdog_maxinterval * 1000));
> +			secs_to_jiffies(fan_watchdog_maxinterval));
>  	else
>  		cancel_delayed_work(&fan_watchdog_task);
>  }

-- 
 i.

