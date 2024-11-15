Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6656D68BE0
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:message-id:mime-version:
   content-transfer-encoding:to:cc:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NaKJY5KeJ2E1lFlJGT3YRi054w9/PadhToJsjl04lc4=;
  b=ERl26LfQUZXGGMrfjsdNaxvY7orrldzsvtTK/FrVop9GcfrUuCVFVOza
   gHU1qtjmArfL1p6jhhhrCbpjOJ+jQIGHMoCP2qTKMkT9l7hYJDyPcmHc2
   fsJHh2G8gtTG/owzIWaqrQAA/QH6kmJThfLX9Q9klbJx/kUerjMK0Q/96
   E=;
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
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194169162"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:35:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8479BE0D33; Fri, 15 Nov 2024 23:35:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C3A4BE0D1E
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:47 +0100 (CET)
IronPort-SDR: 6737bba5_jTHpbt1V3Jym9TNkf+j7tPNrznV3lS2IuINQ5ly9RdnlhMX
 chw/1/F/JKjq4qIdAalsyRh4dDi0TvLVn8NuYFw==
X-IPAS-Result: =?us-ascii?q?A0EtAABAujdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCQn1aMwcISASEUogdiVGLdpBNgVaBQD4PAQMBSAYBAgQBAQMEg?=
 =?us-ascii?q?UyDNIpNAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AGBDIV7DUkBEAGCBwGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECD?=
 =?us-ascii?q?V4BASAVEh0BATcBNAImAkgWARKDAQGCZAYCDJ9AAYdgAQECiyOBMoEBggwBA?=
 =?us-ascii?q?QaCZ9k4gWQDBoEaLgGBYYZqAYFsg307g0KBIRuBSUSBFTWHWTKDRoJpgRSGR?=
 =?us-ascii?q?CWIf4l3giCFP4giCT+BBRwDWSERAVUTDQoLBwVjVzwDIm9qU3orgQuBFzpCg?=
 =?us-ascii?q?TuBEy8bIQtcgSmBGhQGFQSBDkY/gkppSzcCDQI2giQkWYEdgTKFGoRsZy8DA?=
 =?us-ascii?q?wMDgzyCTmQuHUADCxgNSBEsNQYOG0MBbgefAQFGgkJSHwGBDyuBEYECN5MaM?=
 =?us-ascii?q?4JvSY1CoWuEJIwWlUcBMqpOLodkkGUii2WBeJVzhQSCGDo8gSBGByMVgyJPA?=
 =?us-ascii?q?xkPjiGDeoUUiioBthlDNQIBOAIHCwEBAwmFRgEBgQCEOoQiM4FLAQE?=
IronPort-PHdr: A9a23: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
 thZlgb7VqhzSDnWrljenjVLDA==
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:jS4FaaxI0SP31KWNE7CGKrPwDr1zdoMgy1knxilNoNJuA6qlfq
 eV7ZYmPH7P+VUssBNJo7q90cy7LE80mqQa3WB8B9uftWrd2FdAUrsC0WKK+VSJcBEWndQz6U
 4PSdkYNPTASXMmyfvg6AO7E9EvqeP3lZyAtKP1zn9rQw0vS4wI1XYcNu/iKDwOeDV7
X-Talos-CUID: 9a23:dWxIMGC+sa1arfP6E3ZEzxYfPs0BS37QkCjtJk+BBk1QGITAHA==
X-Talos-MUID: 9a23:kbfb5Qbu8MF6s+BT7CTVtXJiFMxS3oulMlAkzpNFm/OiOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101770974"
X-MGA-submission: =?us-ascii?q?MDFW2undSxpJ7mXykd8FHZ+jeyUtAt1DqGr2XX?=
 =?us-ascii?q?HEpPRVIIoz22Ytso5zyD6HCC0evIiOKqrzSmOm1NFR3VCUOMZttJQEqC?=
 =?us-ascii?q?Uu6yQrr3qi3Y+v9XtJ8F0BUIwn1OpAjI+o2RQih8Dx+PvlItEaikwFSw?=
 =?us-ascii?q?Z7KpHoF4A8DtvLsMZnabEkZg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:22:45 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id C8F55206BCE1;
	Fri, 15 Nov 2024 13:22:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C8F55206BCE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705762;
	bh=NaKJY5KeJ2E1lFlJGT3YRi054w9/PadhToJsjl04lc4=;
	h=From:Subject:Date:To:Cc:From;
	b=qSckkTefY4nSDpMG6iW1ikvAvcu+Bro+zmtddjC9Ua2IIcocuRc7w5JVg1mXiL1Zv
	 gjq7MVSAX23TgeVecpPfH5/IBxuFBQ/uZHv6yLuKDmXda9ST9w35n4VJDzv6x+pplU
	 738dCnI1RTxo/K26kLo/E4BvWWcYM0/mvOAHIgpM=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:30 +0000
Message-Id: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJa7N2cC/y2NQQqDQAxFryJZN2AGKehVpIt2JtOmi5k2sSKId
 zdol+/Bf38FYxU2GJoVlGcxqcWBLg3E1708GSU5Q2hDR0QBYy0zq3vjaDhVfEvOXsDU94lauj4
 SEfj8o5xlOdLj7WTl788fpr/cth3E5bKGfwAAAA==
X-Change-ID: 20241112-converge-secs-to-jiffies-d99d1016bd11
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, 
 Oded Gabbay <ogabbay@kernel.org>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
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
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jack Wang <jinpu.wang@cloud.ionos.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Louis Peens <louis.peens@corigine.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
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
 linuxppc-dev@lists.ozlabs.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>, 
 Michael Kelley <mhklinux@outlook.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
X-Mailer: b4 0.14.2
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 00/22] Converge on using secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2008
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-0-19aadc34941b%40linux.microsoft.com>

This is a series that follows up on my previous series to introduce
secs_to_jiffies() and convert a few initial users.[1] In the review for
that series, Anna-Maria requested converting other users with
Coccinelle. This is part 1 that converts users of msecs_to_jiffies()
that use the multiply pattern of either of:
- msecs_to_jiffies(N*1000), or
- msecs_to_jiffies(N*MSEC_PER_SEC)

The entire conversion is made with Coccinelle in the script added in
patch 2. Some changes suggested by Coccinelle have been deferred to
later parts that will address other possible variant patterns.

CC: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

[1] https://lore.kernel.org/all/20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com/
[2] https://lore.kernel.org/all/8734kngfni.fsf@somnus/

---
Easwar Hariharan (22):
      netfilter: conntrack: Cleanup timeout definitions
      coccinelle: misc: Add secs_to_jiffies script
      arm: pxa: Convert timeouts to use secs_to_jiffies()
      s390: kernel: Convert timeouts to use secs_to_jiffies()
      powerpc/papr_scm: Convert timeouts to secs_to_jiffies()
      mm: kmemleak: Convert timeouts to secs_to_jiffies()
      accel/habanalabs: Convert timeouts to secs_to_jiffies()
      drm/xe: Convert timeout to secs_to_jiffies()
      drm/etnaviv: Convert timeouts to secs_to_jiffies()
      scsi: lpfc: Convert timeouts to secs_to_jiffies()
      scsi: arcmsr: Convert timeouts to secs_to_jiffies()
      scsi: pm8001: Convert timeouts to secs_to_jiffies()
      xen/blkback: Convert timeouts to secs_to_jiffies()
      gve: Convert timeouts to secs_to_jiffies()
      wifi: ath11k: Convert timeouts to secs_to_jiffies()
      Bluetooth: MGMT: Convert timeouts to secs_to_jiffies()
      staging: vc04_services: Convert timeouts to secs_to_jiffies()
      ceph: Convert timeouts to secs_to_jiffies()
      livepatch: Convert timeouts to secs_to_jiffies()
      ALSA: line6: Convert timeouts to secs_to_jiffies()
      nfp: Convert timeouts to secs_to_jiffies()
      jiffies: Define secs_to_jiffies()

 arch/arm/mach-pxa/sharpsl_pm.c                      |  6 +++---
 arch/powerpc/platforms/pseries/papr_scm.c           |  2 +-
 arch/s390/kernel/lgr.c                              |  3 ++-
 arch/s390/kernel/time.c                             |  4 ++--
 arch/s390/kernel/topology.c                         |  2 +-
 drivers/accel/habanalabs/common/device.c            |  2 +-
 drivers/accel/habanalabs/common/habanalabs_drv.c    |  3 +--
 drivers/block/xen-blkback/blkback.c                 |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c            |  2 +-
 drivers/gpu/drm/xe/xe_device.c                      |  2 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c        |  6 ++----
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c |  2 +-
 drivers/net/wireless/ath/ath11k/debugfs.c           |  2 +-
 drivers/scsi/arcmsr/arcmsr_hba.c                    |  2 +-
 drivers/scsi/lpfc/lpfc_init.c                       | 18 +++++++++---------
 drivers/scsi/lpfc/lpfc_nportdisc.c                  |  8 ++++----
 drivers/scsi/lpfc/lpfc_nvme.c                       |  2 +-
 drivers/scsi/lpfc/lpfc_sli.c                        |  4 ++--
 drivers/scsi/lpfc/lpfc_vmid.c                       |  2 +-
 drivers/scsi/pm8001/pm8001_init.c                   |  2 +-
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c     |  2 +-
 fs/ceph/quota.c                                     |  2 +-
 include/linux/jiffies.h                             | 13 +++++++++++++
 mm/kmemleak.c                                       |  4 ++--
 net/bluetooth/hci_event.c                           |  2 --
 net/bluetooth/mgmt.c                                |  2 +-
 net/netfilter/nf_conntrack_proto_sctp.c             | 21 ++++++++-------------
 samples/livepatch/livepatch-callbacks-busymod.c     |  2 +-
 samples/livepatch/livepatch-shadow-fix1.c           |  2 +-
 samples/livepatch/livepatch-shadow-mod.c            | 10 +++++-----
 scripts/coccinelle/misc/secs_to_jiffies.cocci       | 21 +++++++++++++++++++++
 sound/usb/line6/toneport.c                          |  2 +-
 32 files changed, 92 insertions(+), 67 deletions(-)
---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241112-converge-secs-to-jiffies-d99d1016bd11

Best regards,
-- 
Easwar Hariharan <eahariha@linux.microsoft.com>

