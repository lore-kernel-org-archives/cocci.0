Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1F0D68BED
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+gVV/UmY/+D+Ld41CNddLz/uQ1pNX7ndA8K/EVCvtE8=;
  b=KjYPaGigM6rby5sc7DUD60+kNAaiF+Zl5tPc+OFZTk7A9WdPKpKzm0YE
   hVif7+9oAunCsGx4blkyzTLL6EoAUcEnS25IKVZz9ll81PqJQC5pCf9Ut
   iDyrzW9/w8QWLbwt4HXsUUJUK20A6MU8B/EKHkGL/LQx3RA+NN+NjLDEQ
   s=;
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
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194204817"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 846FFE0DF7; Sat, 16 Nov 2024 12:26:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AB3EEE00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 11:16:46 +0100 (CET)
IronPort-SDR: 673870f0_68iVzT3PzhNi2NvfCc2Lu4U6K3In2giOt1dHH07ARS0WC+y
 0hfEXLmT16UVhQndgSK8ISowTMKO7qMDQ9HZKNA==
X-IPAS-Result: =?us-ascii?q?A0EMAACZcDhnhQrrEV1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDfQZTNAQLSIRWiB1fhlGBdC0DhDuYBoFWgUA+DwEDA?=
 =?us-ascii?q?Q05CwQBAQMEhQACiksCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBAUBJhXsNgmIBgSRRDQMHPgEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQUCDV4BAR4BAQECASMPAQVBEAsODAImAgJWB?=
 =?us-ascii?q?gESAgEBgn0BgkEjBw0EsTqBMoEB3jOBZwaBGi4BhWmCYgGFaTuEPCcPgVVEg?=
 =?us-ascii?q?RUngwM+hCaDeIJpBIEQhkQliH+Jd4IghVuII1J7HANZIBIBVRMXCwcFgSkRE?=
 =?us-ascii?q?CwDIm9qTn+BNoFRAUGCTi8bIQtcgSl9HRQGFQSBDgU3Cj+CSmlLNwINAjaCJ?=
 =?us-ascii?q?CRZgk+BJQQFg2yBC4NhZy8DAwMDgzyCTmRVHUACAQttPTUGAwsbBj2gDgFGg?=
 =?us-ascii?q?kNSHwGBDytQQUYDOTeTGhMgkk6fYzQHhB2BXQYMiieVMgYTL5dMCJJ6Lodkk?=
 =?us-ascii?q?GUihHiIZZVWHYU1gUIlOhAsgSBNJoM0TwMZD446iB+LAAG2Z0UyOwIHAQoBA?=
 =?us-ascii?q?QMJhkiIBzOBSwEB?=
IronPort-PHdr: A9a23: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
 WM=
IronPort-Data: A9a23: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
 E4=
IronPort-HdrOrdr: A9a23:97VE/6xpQnampndxZifzKrPwGb1zdoMgy1knxilNoNJuA7Wlfr
 OV7Y8mPHjP+UkssRAb6Ky90ca7MBHhHPJOkPMs1PKZLXTbUQiTXeRfBOnZsl7d8kTFn4Y3uM
 sOEshD4Z/LfCBHZK3BkW6F+rgbsb+6GeyT9IPjJqhWJ29XV50=
X-Talos-CUID: =?us-ascii?q?9a23=3Ac9mKm2lcOTb+SiSgCKjTRKggyr/XOVmEx3KBIhe?=
 =?us-ascii?q?2M35Cap2pQg6A2L9HzvM7zg=3D=3D?=
X-Talos-MUID: 9a23:Kaz31QqJPfS+l7n20IkezyFjPZ842pmfM0ZTlswd5MqGHgBUACjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="101790764"
X-MGA-submission: =?us-ascii?q?MDEl/I8BqssYnoeGERzxPdSRoRHBFPo9y74MI2?=
 =?us-ascii?q?BXtwprBYBksshHXUHe81UEQsxAACnRrpk+aqDqQg/2BlRgtC0VvVJMN4?=
 =?us-ascii?q?mZF2T/MYPUOeYPTM8U84RBrA1W9YAdgobAR0koK1c6VDNU/BAKhkHlwH?=
 =?us-ascii?q?IYawOxAQJJZH4/CnbiDRuo9Q=3D=3D?=
Received: from pegase2.c-s.fr ([93.17.235.10])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 11:16:16 +0100
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xr8tR49hqz9sSq;
	Sat, 16 Nov 2024 11:16:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J6J2bYZIXDQx; Sat, 16 Nov 2024 11:16:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xr8tP65s9z9sSn;
	Sat, 16 Nov 2024 11:16:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AECE08B7A7;
	Sat, 16 Nov 2024 11:16:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id pm9eRPbD1CxI; Sat, 16 Nov 2024 11:16:13 +0100 (CET)
Received: from [192.168.232.159] (POS169858.IDSI0.si.c-s.fr [192.168.232.159])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 159E18B763;
	Sat, 16 Nov 2024 11:16:10 +0100 (CET)
Message-ID: <cbca5f57-bc29-4d3e-a009-8ac3f5d38600@csgroup.eu>
Date: Sat, 16 Nov 2024 11:16:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Russell King
 <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>,
 Oded Gabbay <ogabbay@kernel.org>, Lucas De Marchi
 <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann
 <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Xiubo Li <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Louis Peens <louis.peens@corigine.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, cocci@inria.fr,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, linux-mm@kvack.org,
 linux-bluetooth@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org,
 live-patching@vger.kernel.org, linux-sound@vger.kernel.org,
 etnaviv@lists.freedesktop.org, oss-drivers@corigine.com,
 linuxppc-dev@lists.ozlabs.org, Anna-Maria Behnsen <anna-maria@linutronix.de>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 00/21] Converge on using secs_to_jiffies()
Reply-To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Loop: cocci@inria.fr
X-Sequence: 2070
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/cbca5f57-bc29-4d3e-a009-8ac3f5d38600%40csgroup.eu>



Le 15/11/2024 à 22:26, Easwar Hariharan a écrit :
> [Vous ne recevez pas souvent de courriers de eahariha@linux.microsoft.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> This is a series that follows up on my previous series to introduce
> secs_to_jiffies() and convert a few initial users.[1] In the review for
> that series, Anna-Maria requested converting other users with
> Coccinelle. This is part 1 that converts users of msecs_to_jiffies()
> that use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000), or
> - msecs_to_jiffies(N*MSEC_PER_SEC)

You should provide a reference to the accepted commit that adds 
secs_to_jiffies:

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()")

> 
> The entire conversion is made with Coccinelle in the script added in
> patch 2. Some changes suggested by Coccinelle have been deferred to
> later parts that will address other possible variant patterns.
> 
> CC: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> 
> [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20241030-open-coded-timeouts-v3-0-9ba123facf88%40linux.microsoft.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C121622b159564a010cac08dd05bc32da%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638673028056187739%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=oW04hGIpfjRo8qcX0GaGdHE1xiApgoOtgAuWQXFgWR4%3D&reserved=0
> [2] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F8734kngfni.fsf%40somnus%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C121622b159564a010cac08dd05bc32da%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638673028056211741%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=UDn89U6oUNFiRj3K5fvNEIuiwmwEGfJ2XhPn43z8%2BhA%3D&reserved=0
> 
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20241115-converge-secs-to-jiffies-v1-0-19aadc34941b%40linux.microsoft.com&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C121622b159564a010cac08dd05bc32da%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638673028056225723%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=reWzZOiSyn%2FA5qxcXAoUqNGedJ1K%2FM%2BuCgEKwXusuU8%3D&reserved=0
> 
> ---
> Easwar Hariharan (21):
>        netfilter: conntrack: Cleanup timeout definitions
>        coccinelle: misc: Add secs_to_jiffies script
>        arm: pxa: Convert timeouts to use secs_to_jiffies()
>        s390: kernel: Convert timeouts to use secs_to_jiffies()
>        powerpc/papr_scm: Convert timeouts to secs_to_jiffies()
>        mm: kmemleak: Convert timeouts to secs_to_jiffies()
>        accel/habanalabs: Convert timeouts to secs_to_jiffies()
>        drm/xe: Convert timeout to secs_to_jiffies()
>        drm/etnaviv: Convert timeouts to secs_to_jiffies()
>        scsi: lpfc: Convert timeouts to secs_to_jiffies()
>        scsi: arcmsr: Convert timeouts to secs_to_jiffies()
>        scsi: pm8001: Convert timeouts to secs_to_jiffies()
>        xen/blkback: Convert timeouts to secs_to_jiffies()
>        gve: Convert timeouts to secs_to_jiffies()
>        wifi: ath11k: Convert timeouts to secs_to_jiffies()
>        Bluetooth: MGMT: Convert timeouts to secs_to_jiffies()
>        staging: vc04_services: Convert timeouts to secs_to_jiffies()
>        ceph: Convert timeouts to secs_to_jiffies()
>        livepatch: Convert timeouts to secs_to_jiffies()
>        ALSA: line6: Convert timeouts to secs_to_jiffies()
>        nfp: Convert timeouts to secs_to_jiffies()
> 
>   arch/arm/mach-pxa/sharpsl_pm.c                      |  6 +++---
>   arch/powerpc/platforms/pseries/papr_scm.c           |  2 +-
>   arch/s390/kernel/lgr.c                              |  3 ++-
>   arch/s390/kernel/time.c                             |  4 ++--
>   arch/s390/kernel/topology.c                         |  2 +-
>   drivers/accel/habanalabs/common/device.c            |  2 +-
>   drivers/accel/habanalabs/common/habanalabs_drv.c    |  3 +--
>   drivers/block/xen-blkback/blkback.c                 |  2 +-
>   drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c            |  2 +-
>   drivers/gpu/drm/xe/xe_device.c                      |  2 +-
>   drivers/net/ethernet/google/gve/gve_tx_dqo.c        |  6 ++----
>   drivers/net/ethernet/netronome/nfp/nfp_net_common.c |  2 +-
>   drivers/net/wireless/ath/ath11k/debugfs.c           |  2 +-
>   drivers/scsi/arcmsr/arcmsr_hba.c                    |  2 +-
>   drivers/scsi/lpfc/lpfc_init.c                       | 18 +++++++++---------
>   drivers/scsi/lpfc/lpfc_nportdisc.c                  |  8 ++++----
>   drivers/scsi/lpfc/lpfc_nvme.c                       |  2 +-
>   drivers/scsi/lpfc/lpfc_sli.c                        |  4 ++--
>   drivers/scsi/lpfc/lpfc_vmid.c                       |  2 +-
>   drivers/scsi/pm8001/pm8001_init.c                   |  2 +-
>   .../vc04_services/bcm2835-audio/bcm2835-vchiq.c     |  2 +-
>   fs/ceph/quota.c                                     |  2 +-
>   mm/kmemleak.c                                       |  4 ++--
>   net/bluetooth/mgmt.c                                |  2 +-
>   net/netfilter/nf_conntrack_proto_sctp.c             | 21 ++++++++-------------
>   samples/livepatch/livepatch-callbacks-busymod.c     |  2 +-
>   samples/livepatch/livepatch-shadow-fix1.c           |  2 +-
>   samples/livepatch/livepatch-shadow-mod.c            | 10 +++++-----
>   scripts/coccinelle/misc/secs_to_jiffies.cocci       | 21 +++++++++++++++++++++
>   sound/usb/line6/toneport.c                          |  2 +-
>   30 files changed, 79 insertions(+), 65 deletions(-)
> ---
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> change-id: 20241112-converge-secs-to-jiffies-d99d1016bd11
> 
> Best regards,
> --
> Easwar Hariharan <eahariha@linux.microsoft.com>
> 
