Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C316FC7EE2D
	for <cocci@archiver.kernel.org>; Mon, 27 Feb 2023 11:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0MX07b53AdXKTA2DvdsdwCeNYBekr9+C8dxxnEXp46A=;
  b=oyR25whmSjmT+uc81Pb2cPn/gMngpZHhWe9fikCL4Nikwr/4rH75CddL
   f0IRzJjKTfXVvELgMJdaHJMt1rJWf6Pd1WGwGDi0HiLkhoGSVWUuQuWRF
   cbnuyPKjGuFq4kQH1pOgqrTw89XmIc/wc/PyKK3L5mfhgsQAOoJbTN38t
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@infradead.org
X-IronPort-AV: E=Sophos;i="5.97,331,1669071600"; 
   d="scan'208";a="94499602"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Feb 2023 12:23:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 81A7CE0159; Mon, 27 Feb 2023 12:23:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8FFDCE00A1
	for <cocci@sympa.inria.fr>; Mon, 27 Feb 2023 12:20:50 +0100 (CET)
IronPort-SDR: 63fc9210_1MNjjRJa+QOp4vJdYwytpmasxbGxuRVvzkNVuZ6V3vnSB7o
 Y8yAWVfa1VIrCx76TyyDcqmq+c++Ksc3BHg0Qzw==
X-IPAS-Result: =?us-ascii?q?A0ErAAD3kPxjjCIym1pSCBkBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAQEBAQEBAQEBAQEBQIFPgi2BCVYuBAtGBI1NhX2CJQMWiyySGYFqDwEDA?=
 =?us-ascii?q?Q09BAECBAEBAwSEfgKFLwIdBgY0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgQEAQECEAEBAQFAEDWFaA2CNykBdYEIAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RYCDRoJLxpdAQEBAQIBOgYBATcBBAsLGC4QEQsdAQ0GE4J+AYIQXgMOIwMEA?=
 =?us-ascii?q?QusU3iBNIEBgggBAQaBQAGbEw1ogV4DBoFAAYc+hQFGhCcnG4FJRIEVgTyBb?=
 =?us-ascii?q?j6CIEIEgSEWhmaJfoRah0wKgTR3gSMOgUKBCQIJAhFvgRQIaIICRwIPRzcDR?=
 =?us-ascii?q?B1AAws7Oj81FCAtATOBGyQFAwsVKkcECDYFBhw0EQIIDxIPBiZDDkI3NBMGX?=
 =?us-ascii?q?AEpCw4RA0+BSAQvgV8GASgkmRNIBwEVXhosUBpbCA0QDlACLQOSMgE5gmABi?=
 =?us-ascii?q?02fPYFFZAuEA4FVig6PDYYHMoN6jGWYWZdZi2OBb4NsllmBeSM8gSBNMAg7g?=
 =?us-ascii?q?mcTPAMZD44gDA0JiGSKZkA0AgE4AgcLAQEDCYVGAQGBAYRuAQE?=
IronPort-PHdr: A9a23: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
 DCVCUbvMz2P0T7zWEL3Wdw=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:+3h9DK/659xkUlqs0bBuk+DZI+orL9Y04lQ7vn2ZhyY0TiW9rb
 HJoB17726StN91YhodcL+7V5VoLUmzyXcx2/hpAV7AZniDhILLFvAB0WKK+VSJcUCTygce79
 YET0EUMqySMbEVt6fH3DU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,331,1669071600"; 
   d="scan'208";a="48712396"
X-MGA-submission: =?us-ascii?q?MDH/FJFl4DUIqkd+XcaJjRmfhvdbZcQL8fCvxf?=
 =?us-ascii?q?VkGNibJJ/XavOPFdRm9XEek85DTSEvf9QFgjA1FrW1t0rCguWU9LdP5p?=
 =?us-ascii?q?ALRgc2cp1wHiDCeUtLpCXDkaIrsv+i82sHa70wCRKBLJ7WCzTggjzMsi?=
 =?us-ascii?q?+Z7Xqev1KyPmD3Zb3IKsICaQ=3D=3D?=
Received: from casper.infradead.org ([90.155.50.34])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 12:20:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0MX07b53AdXKTA2DvdsdwCeNYBekr9+C8dxxnEXp46A=; b=sjBC8e88e2ZBceEDiR6v33cR/P
	cmwLxZDQDXR/5B7OJsI25RF4PBhoX+gdYPjbk6xjPbJcq8YpGezyp0ukAi5Xu5WMavPdbHa1YpmlF
	Zv8F2BZZb9y9e4V3emC3wLHckD6XUo52Kd1hITabrEFR08h0jqVzAPM6XUmSIyd/mAelbu6x9ZCqA
	VYayYCkUD076G4XwxFQ8+wq9LB5uD0ogtTcsmqy5hKZwemQakmS0qX9TQP4O9oDByQDygQLLAXJCW
	Nh9aSUmbxIdw+6hwGI6VfhoWa5NMeBXV4JjqxpIzveGZTspvjPX78PeiWU3g+8sbihK236Vz70fF1
	7wBQh5Yw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWbYW-00048U-5J; Mon, 27 Feb 2023 11:20:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19D5B300632;
	Mon, 27 Feb 2023 12:20:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id EFC7A22F1DD87; Mon, 27 Feb 2023 12:20:28 +0100 (CET)
Date: Mon, 27 Feb 2023 12:20:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Schspa Shi <schspa@gmail.com>
Cc: linux-kernel@vger.kernel.org, cocci@inria.fr, mcgrof@kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, buytenh@wantstofly.org,
	johannes.berg@intel.com, gregkh@linuxfoundation.org,
	tomba@kernel.org, airlied@gmail.com, daniel@ffwll.ch
Message-ID: <Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
References: <20230227075346.69658-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227075346.69658-1-schspa@gmail.com>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [RFC PATCH] cocci: cpi: add complete api check script
Reply-To: Peter Zijlstra <peterz@infradead.org>
X-Loop: cocci@inria.fr
X-Sequence: 868
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-02/Y%2FyR%2FLypvJQXRhAr%40hirez.programming.kicks-ass.net>

On Mon, Feb 27, 2023 at 03:53:47PM +0800, Schspa Shi wrote:
> When DECLARE_COMPLETION_ONSTACK was used, the user must to ensure the other
> process won't reference the completion variable on stack. For a
> killable/interruptiable version, we need extra code(add locks/use xchg) to
> ensure this.
> 
> This patch provide a SmPL script to detect bad
> DECLARE_COMPLETION_ONSTACK(_MAP) API usage, but far from perfect.

Documentation/process/submitting-patches.rst:instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy

But also, wth is SmPL, the actual thing included is a coccinelle script.

> This is a common problem, and a lot of drivers have simpler problem. The
> fellowing is a list of problems find by this SmPL patch, due to the complex
> use of wait_for_complete* API, there will still be some false negatives and
> false positives. This RFC patch is mainly used to discuss improvement
> methods. If we introduce the wait_for_complete*_onstack API, it will be
> easier to modify these problems, and the patch rules of SmPL will be very
> easy. In the process of trying to write SmPL scripts, I strongly recommend
> introducing two onstack APIs to complete this operation.
> 
> file:/Users/schspa/work/src/linux/drivers/infiniband/ulp/srpt/ib_srpt.c::2962 was suspected to return a variable on stack

What's with this retarded file path? Are you running on Windows or
something daft like that?

Please, make them relative to srctree.

> file:/Users/schspa/work/src/linux/drivers/misc/tifm_7xx1.c::268 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/firmware/arm_scmi/driver.c::1001 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::595 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::491 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::538 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::645 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::3175 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2360 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2314 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2634 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::1804 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::1758 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::2034 was suspected to return a variable on stack

These don't seem buggy, they take the whole DSI out -- which lives on
stack too.

> file:/Users/schspa/work/src/linux/drivers/net/wireless/marvell/mwl8k.c::2259 was suspected to return a variable on stack

Heh, they seem to have the right idea but a buggy implementation.

> file:/Users/schspa/work/src/linux/drivers/net/wireless/mediatek/mt7601u/mcu.c::317 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/net/wireless/ti/wlcore/main.c::6674 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/net/wwan/t7xx/t7xx_state_monitor.c::416 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/soc/apple/rtkit.c::647 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/soc/apple/rtkit.c::653 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/soc/qcom/rpmh.c::269 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/aic94xx/aic94xx_tmf.c::339 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_ctl.c::242 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::1811 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::2266 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::1603 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::2073 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/qla2xxx/qla_os.c::1807 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/qla2xxx/qla_os.c::1328 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/ibmvscsi/ibmvfc.c::2466 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic79xx_osm.c::844 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic79xx_osm.c::2334 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic7xxx_osm.c::2297 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/lpfc/lpfc_nvmet.c::2119 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/ipr.c::5153 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/scsi_error.c::1157 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_main.c::1215 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c::996 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c::867 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/isci/task.c::317 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::1844 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2310 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2086 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2579 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/ufs/core/ufshcd.c::6752 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/ufs/core/ufshcd.c::4074 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/thunderbolt/ctl.c::604 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/i2c/busses/i2c-hisi.c::206 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/s390/cio/vfio_ccw_drv.c::71 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/slimbus/messaging.c::154 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ngd-ctrl.c::894 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ngd-ctrl.c::932 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ctrl.c::377 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/usb/core/devio.c::1142 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/usb/core/hcd.c::2229 was suspected to return a variable on stack

These do usb_kill_urb() in the fail case. IIUC this avoids the UaF
problem this script is trying to finger, no?

> file:/Users/schspa/work/src/linux/drivers/spi/spi-hisi-sfc-v3xx.c::337 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/bluetooth/hci_bcm4377.c::955 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c::336 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/cmd_v2.c::278 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::360 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::312 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::238 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/ata/libata-core.c::1558 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::285 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::233 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::262 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/lib/kunit/try-catch.c::76 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/sound/aoa/soundbus/i2sbus/pcm.c::264 was suspected to return a variable on stack
> 
> To fix this, we can add introducing two new API for this.
> 
> +
> +void complete_on_stack(struct completion **x)
> +{
> +       struct completion *comp = xchg(*x, NULL);
> +
> +       if (comp)
> +               complete(comp);
> +}
> +EXPORT_SYMBOL(complete_on_stack);
> +
> +int __sched wait_for_completion_state_on_stack(struct completion **x,
> +                                       unsigned int state)
> +{
> +       struct completion *comp = *x;
> +       int retval;
> +
> +       retval = wait_for_completion_state(comp, state);
> +       if (retval) {
> +               if (xchg(*x, NULL))
> +                       return retval;
> +
> +               /*
> +                * complete_on_stack will call complete shortly.
> +                */
> +               wait_for_completion(comp);
> +       }
> +
> +       return retval;
> +}
> +EXPORT_SYMBOL(wait_for_completion_state_on_stack);

So going by the 3 random samples above, only 1 would use this pattern.

Does that mean you 'forgot' to audit all these results before proposing
a fix?

What does that mean for this script?

> Link: https://lore.kernel.org/all/20221115140233.21981-1-schspa@gmail.com/T/#mf6a41a7009bb47af1b15adf2b7b355e495f609c4
> Link: https://lore.kernel.org/all/7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp/
> 
> CC: Julia Lawall <Julia.Lawall@inria.fr>
> CC: Nicolas Palix <nicolas.palix@imag.fr>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Juri Lelli <juri.lelli@redhat.com>
> CC: Vincent Guittot <vincent.guittot@linaro.org>
> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ben Segall <bsegall@google.com>
> CC: Mel Gorman <mgorman@suse.de>
> CC: Daniel Bristot de Oliveira <bristot@redhat.com>
> CC: Valentin Schneider <vschneid@redhat.com>
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  scripts/coccinelle/api/complete.cocci | 160 ++++++++++++++++++++++++++
>  1 file changed, 160 insertions(+)
>  create mode 100644 scripts/coccinelle/api/complete.cocci
> 
> diff --git a/scripts/coccinelle/api/complete.cocci b/scripts/coccinelle/api/complete.cocci
> new file mode 100644
> index 000000000000..d4cf32187180
> --- /dev/null
> +++ b/scripts/coccinelle/api/complete.cocci
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0
> +///
> +//  Copyright: (C) 2023 Schspa Shi.
> +//  Confidence: High

I'm thinking that 'high' is somewhat premature, 2 out of 3 false
positive rate does not inspire confidence.

> +virtual report
> +
> +@r1 exists@
> +declarer name DECLARE_COMPLETION_ONSTACK;
> +declarer name DECLARE_COMPLETION_ONSTACK_MAP;
> +position p;
> +identifier done;
> +identifier func;
> +@@
> +
> +func(...) {
> +...
> +(
> +DECLARE_COMPLETION_ONSTACK(done@p);
> +|
> +DECLARE_COMPLETION_ONSTACK_MAP(done@p, ...);
> +)
> +...
> +}
> +
> +@locked exists@
> +identifier func=r1.func;
> +identifier done=r1.done;
> +position p1,p;
> +@@
> +
> +func(...) {
> +...
> +(
> +mutex_lock@p1
> +|
> +mutex_trylock@p1
> +)
> + (...)
> +...  when != mutex_unlock(...)
> +done@p
> +...
> +}
> +
> +
> +@elocked exists@
> +identifier func=r1.func;
> +identifier done=r1.done;
> +position p1,p;
> +expression e;
> +@@
> +
> +func(...) {
> +...
> +e = &done;
> +...
> +(
> +mutex_lock@p1
> +|
> +mutex_trylock@p1
> +)
> + (...)
> +...  when != mutex_unlock(...)
> +e@p
> +...
> +}
> +
> +
> +@has_wait_for_completion exists@
> +position p;
> +identifier done;
> +identifier func=r1.func;
> +identifier fb = { wait_for_completion, wait_for_completion_io};
> +expression e;
> +@@
> +
> +func(...) {
> +...
> +(
> +...
> +fb(&done@p);
> +...
> +|
> +e = &done;
> +...
> +fb(e@p);
> +)
> +...
> +}
> +
> +@has_while_wait exists@
> +position p;
> +identifier done, ret;
> +identifier func=r1.func;
> +identifier fb =~ "wait_for_completion.*";
> +expression e;
> +@@
> +
> +func(...) {
> +...
> +while (...) {
> +	...
> +	ret = fb(&done@p, e);
> +	...
> +}
> +...
> +}
> +
> +@has_while_wait2 exists@
> +position p;
> +identifier done;
> +identifier func=r1.func;
> +expression fb =~ "wait_for_completion.*";
> +@@
> +
> +func(...) {
> +...
> +while (fb(&done@p, ...) == 0) {
> +	...
> +}
> +...
> +}
> +
> +
> +@r2 depends on (!has_wait_for_completion && !has_while_wait && !has_while_wait2) exists@
> +declarer name DECLARE_COMPLETION_ONSTACK;
> +position p!={locked.p, elocked.p};
> +identifier done=r1.done;
> +identifier func=r1.func;
> +expression e;
> +@@
> +
> +func(...) {
> +...
> +(
> +wait_for_completion_interruptible(&done@p)
> +|
> +wait_for_completion_killable(&done@p)
> +|
> +wait_for_completion_timeout(&done@p, ...)
> +|
> +wait_for_completion_io_timeout(&done@p, ...)
> +|
> +wait_for_completion_interruptible_timeout(&done@p, ...)
> +|
> +wait_for_completion_killable_timeout(&done@p, ...)
> +|
> +try_wait_for_completion(&done@p)
> +|
> +wait_for_completion_timeout(e@p, ...)
> +)
> +...
> +}
> +
> +
> +@script:python depends on report@
> +fp << r2.p;
> +@@
> +
> +print('file:{:s}::{:s} was suspected to return a variable on stack'.format(fp[0].file, fp[0].line))
> +
> -- 
> 2.37.3
> 
