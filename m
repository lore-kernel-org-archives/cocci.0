Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E55AC021BE
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:message-id:mime-version:
   content-transfer-encoding:to:cc:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pRPTMwC85c4lYLBd5/aEkvEtme0QilCw7nKJr8ytgmI=;
  b=GEkC/pLY25kv/TY+vSy5Beq+GUeOhXFCUfepr83FhlC8OezoK2bFgZ3m
   jNSGyTLM3e6L1KIV5lmv/zRmjuLdGwtOCMG4p1INdYJNZybqsdNIdZzOu
   yJ+lcbn4o/koBXvkJMnEOascIIZCWGJLw13dSobt/YbPUTHhjD5ir2Voq
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210043704"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 98141E0260; Tue, 25 Feb 2025 21:28:01 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 900DCE0D1E
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:24 +0100 (CET)
IronPort-SDR: 67be2552_1WcRlDhjZsvqHQs5/4cuBS+5V/5cgpJd5urPTXrSxFillhi
 aomkDE2cXrbbDm43hM8JePc2ok9PRWF66HTs/OQ==
X-IPAS-Result: =?us-ascii?q?A0EhAACfJL5ncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfVozBwhIBIRSiB2JUxaLYJBLgVaBQD4PAQMBSgQBAgQBAQMEh?=
 =?us-ascii?q?QCLFAIfBgEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABg?=
 =?us-ascii?q?QyFew2CYgGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BASAVE?=
 =?us-ascii?q?gQZAQE3ASgMAiYCSBYBEoMCAYJkBgIMBp0bAYdgAQECiyN/M4EBggwBAQaCa?=
 =?us-ascii?q?Nk4gWUDBoEaLgGBYYZtAYFsg387g0KBIRuBSUSBFTWHWDMEg0KCaYEUhkuIZ?=
 =?us-ascii?q?pEphHmIWQk/gQUcA1ksAVUTDQoLBwVkVTgDIAoLDAsSHBUCFB0PBhAEakM3g?=
 =?us-ascii?q?kVpSToCDQI1gh4kWIEdgQ6EVIRDXC8DAwMDgyqCP1GCQoIRcYEagjGHAYNjH?=
 =?us-ascii?q?UADCxgNSBEsNwYOG0MBbgegJAE8g0hTHwGBDyswICMGgQRNkm4ug2yNS6Fvh?=
 =?us-ascii?q?CWMGJVKATKqVS6HZY4KgmAii2qBeZp6ghg6gVxGByMVgyJPAxkPjiEMFoNYh?=
 =?us-ascii?q?ROKKgG8NUM1AgE5AgcLAQEDCYVGAQGBAIlUamEBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:UUKelqBBJl+vDpLlHemO55DYdb4zR+YMi2TDGXoBLyC9Ffbo9f
 xG/c5rtiMd6l4qMk3I/OrsBEDuex3hHPJOjbX5Xo3DYOCZggqVxehZhOOI/9SKIULDH4BmpM
 BdWpk7I4C1MENzh8T75wfQKadE/PC3tIqojeDRwzNMYGhRGsVdBn9Ce3+mLnE=
X-Talos-CUID: 9a23:7OMHfWCiCkd0TCT6Extr0HYkFO8ASG3A6ibgHFWFBD4yVLLAHA==
X-Talos-MUID: 9a23:CPQV4AZFqALjrOBTmRv2jiFnNZtU8YOvKEdOmr4J+JXDKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="110053381"
X-MGA-submission: =?us-ascii?q?MDE8IyWcW849Pyyo6qSEe0bjzPOSIa32IXGXqB?=
 =?us-ascii?q?WXa1tut7g7SlewilVuuZy7NMln5nGkAkhkLvYtgxKVEkfDAVMEmF4sV9?=
 =?us-ascii?q?01Wc8M5y6len6Vx4PUJ2aWmngtjC/r2yZw1f+htD3hPkqW0F4ZFxtanz?=
 =?us-ascii?q?JbbEr+D1FUdEeDTc0ckzbl7w=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 25 Feb 2025 21:17:22 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 920F4203CDFC;
	Tue, 25 Feb 2025 12:17:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 920F4203CDFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514639;
	bh=pRPTMwC85c4lYLBd5/aEkvEtme0QilCw7nKJr8ytgmI=;
	h=From:Subject:Date:To:Cc:From;
	b=OJWfAvqAxjSS6nUkULU00Pa8nQ9u9kKy42lXSCjyZ4ZUUOElAuQC0IJLL8YdgMxy4
	 fRHYXp6qo5lzLvyA3yVmWt3cKN1fewJPyBbSi8i8x+l37gp4hdCbMSActzutlKgtXo
	 djKAYQpE3vAmx4Iwoj2HThNeFrxgkdmyOVA8YA+8=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:14 +0000
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEslvmcC/43NMRKCMBCF4aswqV1nExDQyns4FjFsZB0hThKjj
 sPdDTY2FpT/K773FoE8UxC74i08JQ7sxhzlqhCm1+OZgLvcQqGqpJINGDcm8nkPZAJEBxe2Ngt
 w0z5CfDiwVYWy0bq2dSOyc/Nk+fn9OBxz9xyi86/vZZLzOusblKpdoCcJCFtdk7F4UiW2+yuP9
 +d6YONdcDaujRvE/JPUz1ZYLrFVtrsGN61GaTuk//Y0TR+h+4siOAEAAA==
X-Change-ID: 20241217-converge-secs-to-jiffies-part-two-f44017aa6f67
To: Andrew Morton <akpm@linux-foundation.org>, 
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
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org, 
 Easwar Hariharan <eahariha@linux.microsoft.com>, 
 Takashi Iwai <tiwai@suse.de>, Carlos Maiolino <cmaiolino@redhat.com>
X-Mailer: b4 0.14.2
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3 00/16] Converge on using secs_to_jiffies() part
 two
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2433
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88%40linux.microsoft.com>

This is the second series (part 1*) that converts users of msecs_to_jiffies() that
either use the multiply pattern of either of:
- msecs_to_jiffies(N*1000) or
- msecs_to_jiffies(N*MSEC_PER_SEC)

where N is a constant or an expression, to avoid the multiplication.

The conversion is made with Coccinelle with the secs_to_jiffies() script
in scripts/coccinelle/misc. Attention is paid to what the best change
can be rather than restricting to what the tool provides.

Andrew has kindly agreed to take the series through mm.git modulo the
patches maintainers want to pick through their own trees.

This series is based on next-20250225

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

* https://lore.kernel.org/all/20241210-converge-secs-to-jiffies-v3-0-ddfefd7e9f2a@linux.microsoft.com/

---
Changes in v3:
- Change commit message prefix from libata: zpodd to ata: libata-zpodd: in patch 8 (Damien)
- Split up overly long line in patch 9 (Christoph)
- Fixup unnecessary line break in patch 14 (Ilpo)
- Combine v1 and v2
- Fix some additional hunks in patch 2 (scsi: lpfc) which the more concise script missed
- msecs_to_jiffies -> msecs_to_jiffies() in commit messages throughout
- Bug in secs_to_jiffies() uncovered by LKP merged in 6.14-rc2: bb2784d9ab4958 ("jiffies: Cast to unsigned long in secs_to_jiffies() conversion")
- Link to v2: https://lore.kernel.org/r/20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com

Changes in v2:
- Remove unneeded range checks in rbd and libceph. While there, convert some timeouts that should have been fixed in part 1. (Ilya)
- Fixup secs_to_jiffies.cocci to be a bit more verbose
- Link to v1: https://lore.kernel.org/r/20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com

---
Easwar Hariharan (16):
      coccinelle: misc: secs_to_jiffies: Patch expressions too
      scsi: lpfc: convert timeouts to secs_to_jiffies()
      accel/habanalabs: convert timeouts to secs_to_jiffies()
      ALSA: ac97: convert timeouts to secs_to_jiffies()
      btrfs: convert timeouts to secs_to_jiffies()
      rbd: convert timeouts to secs_to_jiffies()
      libceph: convert timeouts to secs_to_jiffies()
      ata: libata-zpodd: convert timeouts to secs_to_jiffies()
      xfs: convert timeouts to secs_to_jiffies()
      power: supply: da9030: convert timeouts to secs_to_jiffies()
      nvme: convert timeouts to secs_to_jiffies()
      spi: spi-fsl-lpspi: convert timeouts to secs_to_jiffies()
      spi: spi-imx: convert timeouts to secs_to_jiffies()
      platform/x86/amd/pmf: convert timeouts to secs_to_jiffies()
      platform/x86: thinkpad_acpi: convert timeouts to secs_to_jiffies()
      RDMA/bnxt_re: convert timeouts to secs_to_jiffies()

 .../accel/habanalabs/common/command_submission.c   |  2 +-
 drivers/accel/habanalabs/common/debugfs.c          |  2 +-
 drivers/accel/habanalabs/common/device.c           |  2 +-
 drivers/accel/habanalabs/common/habanalabs_drv.c   |  2 +-
 drivers/ata/libata-zpodd.c                         |  3 +-
 drivers/block/rbd.c                                |  8 ++---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |  2 +-
 drivers/nvme/host/core.c                           |  6 ++--
 drivers/platform/x86/amd/pmf/acpi.c                |  2 +-
 drivers/platform/x86/thinkpad_acpi.c               |  2 +-
 drivers/power/supply/da9030_battery.c              |  3 +-
 drivers/scsi/lpfc/lpfc.h                           |  3 +-
 drivers/scsi/lpfc/lpfc_els.c                       | 11 +++---
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |  2 +-
 drivers/scsi/lpfc/lpfc_init.c                      | 10 +++---
 drivers/scsi/lpfc/lpfc_scsi.c                      | 12 +++----
 drivers/scsi/lpfc/lpfc_sli.c                       | 41 +++++++++-------------
 drivers/scsi/lpfc/lpfc_vport.c                     |  2 +-
 drivers/spi/spi-fsl-lpspi.c                        |  2 +-
 drivers/spi/spi-imx.c                              |  2 +-
 fs/btrfs/disk-io.c                                 |  6 ++--
 fs/xfs/xfs_icache.c                                |  2 +-
 fs/xfs/xfs_sysfs.c                                 |  8 ++---
 include/linux/ceph/libceph.h                       | 12 +++----
 net/ceph/ceph_common.c                             | 18 ++++------
 net/ceph/osd_client.c                              |  3 +-
 scripts/coccinelle/misc/secs_to_jiffies.cocci      | 10 ++++++
 sound/pci/ac97/ac97_codec.c                        |  3 +-
 28 files changed, 82 insertions(+), 99 deletions(-)
---
base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
change-id: 20241217-converge-secs-to-jiffies-part-two-f44017aa6f67

Best regards,
-- 
Easwar Hariharan <eahariha@linux.microsoft.com>

