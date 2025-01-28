Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A6EC02197
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:message-id:mime-version:
   content-transfer-encoding:to:cc:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DWnZxqt2SesB4Fck6kqsaU204yIBxTyh+Yo+gWHnxew=;
  b=WT2w1sc+zjOOqYyLkB1iN76LCg9dCoC8SRv6Ei+cQt8KmHoO+emsSJ3K
   ScvfTYNqBRVLx9ZZEdtEvFYPwoNisjUmU3V2p/vo4qFQE/gkBwQ0D1mFO
   UPsyjTBtUk1hCu9c8osQGqDRGfgZunovmjk3YD1zYTV17raKEd+NcnOmP
   0=;
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
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205449967"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 57F8AE0D82; Tue, 28 Jan 2025 19:22:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C95C1E0D1D
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:01 +0100 (CET)
IronPort-SDR: 67992048_XyaxwzQ7Fite3I2kciPmsoQR9d0e8A+O3jPCQLg/rbrOWLD
 PloZslMAee47Iqu3OtiFhNO8LAc45EVI6eEIbFA==
X-IPAS-Result: =?us-ascii?q?A0HJAgCtH5lncraaTQ1aHgEBCxIMQIFIC4JEfVozBwhIB?=
 =?us-ascii?q?IRSkXCLdpBPgVaBQD4PAQMBSAYBAgQBAQMEgUyDNIp3Ah8GAQQwCQ4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAGBDIV7DYJiAYEkUQ1IAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEhFRIdAQE3ASgMAiYCSBYBEoMCA?=
 =?us-ascii?q?YJkBgIMoiYBh2ABAQKLI4EygQGCDAEBBoJn2TiBZAMGgRougWKGbAGBbIN/O?=
 =?us-ascii?q?4NCgSEbgUlEgRU1h1gzg0aCaYEUhlOIe5AYiAoJP4EFHANZLAFVEw0KCwcFZ?=
 =?us-ascii?q?FU4AyALCwwLFBwVAhQdDwYQBG1EN4JHaUk3Ag0CNYIeJFiBHYEOhFyERWAvA?=
 =?us-ascii?q?wMDA4M4gkVUgkSCFHqBF4I2hAwdQAMLGA1IESw3Bg4bQwFuB5xcATyDYx8Bg?=
 =?us-ascii?q?Q8rMEmBUZJtLoNrjUmhboQljBiVSAEyqlMuh2SOCoJgIotpgXmaeIIYOoFcR?=
 =?us-ascii?q?gcjFYMiTwMZD44hDBaDWIUTiioBugtDNQIBOQIHCwEBAwmFRgEBgQCJUWphA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 V+lKRAairtq4NXdkpc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:PdA336G3OBJktfyYpLqEyseALOsnbusQ8zAXPo5KOHpom6uj5q
 KTdZUgpHzJYFR4YhsdcLW7VZVoLkmzyXcY2+Us1NSZPDUOxlHIEGgK1+KLqAEIcBeQygcy79
 YGT4FOTPasSWVghcz54A63euxQpeWvweSDhO/YwXsobSwCUdAF0+4AMHfjLnFL
X-Talos-CUID: 9a23:sRkFUW/mInWoHsgTineVv0URK9E5KFPW8H73AXSZBl5lWpPJSXbFrQ==
X-Talos-MUID: 9a23:FEntywZekwwQnOBTjHjqv2hdatVT7qm0GGc9k4sam+6nOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107588255"
X-MGA-submission: =?us-ascii?q?MDFxfdONeHODyZiojL2iXFRaAVFsjXRff1FeAw?=
 =?us-ascii?q?QzGaEt4qSsl0M7gbVRYOvEupYqwQdw98WTHskA10zxWgCM6qj8li+lJ6?=
 =?us-ascii?q?xIWJit0FEiJNIJLop2M6jjUjGbTc3/Be3l6Fz/V4VC9McCOfcL5I5hR4?=
 =?us-ascii?q?Sr2XOvR1j+ivsNNvgfYlTQEQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 28 Jan 2025 19:22:00 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5C2E02037175;
	Tue, 28 Jan 2025 10:21:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C2E02037175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088517;
	bh=DWnZxqt2SesB4Fck6kqsaU204yIBxTyh+Yo+gWHnxew=;
	h=From:Subject:Date:To:Cc:From;
	b=rbsRgRXsDhgQ49qwzz8O9F+b3CIaPu+u/u5bFNXstLiqFfaEZgC1iIU54pEJ4SCC9
	 qXRUrwxGkFwK11MEhKH4r7I0e/4uhHl3G7yCK3E3A4G+YwxkrF4Z/N40iZHmQckLfV
	 +mfJ829accGVQ64/iuqsqnpCIMIptrmhiAA8pmnE=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:45 +0000
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADogmWcC/x2NMQrDMAwAvxI0VxAbE0O/UjoYV2qUwQ6SSQshf
 6/oeDfcnWCkQgb36QSlQ0x6cwi3Cepa2ptQXs4Q55hCDBlrbwepe6NqODpuwuwF3IsOHJ+OnNI
 ccikLLxm8syuxfP+Px/O6fgSSOflzAAAA
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
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
Subject: [cocci] [PATCH 00/16] Converge on using secs_to_jiffies() part two
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2275
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308%40linux.microsoft.com>

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

This series is based on next-20250128

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

* https://lore.kernel.org/all/20241210-converge-secs-to-jiffies-v3-0-ddfefd7e9f2a@linux.microsoft.com/

---
Easwar Hariharan (16):
      coccinelle: misc: secs_to_jiffies: Patch expressions too
      scsi: lpfc: convert timeouts to secs_to_jiffies()
      accel/habanalabs: convert timeouts to secs_to_jiffies()
      ALSA: ac97: convert timeouts to secs_to_jiffies()
      btrfs: convert timeouts to secs_to_jiffies()
      rbd: convert timeouts to secs_to_jiffies()
      libceph: convert timeouts to secs_to_jiffies()
      libata: zpodd: convert timeouts to secs_to_jiffies()
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
 drivers/ata/libata-zpodd.c                         |  3 +--
 drivers/block/rbd.c                                |  6 +++---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |  2 +-
 drivers/nvme/host/core.c                           |  6 ++----
 drivers/platform/x86/amd/pmf/acpi.c                |  3 ++-
 drivers/platform/x86/thinkpad_acpi.c               |  2 +-
 drivers/power/supply/da9030_battery.c              |  3 +--
 drivers/scsi/lpfc/lpfc_init.c                      |  4 ++--
 drivers/scsi/lpfc/lpfc_scsi.c                      | 12 +++++------
 drivers/scsi/lpfc/lpfc_sli.c                       | 24 ++++++++--------------
 drivers/scsi/lpfc/lpfc_vport.c                     |  2 +-
 drivers/spi/spi-fsl-lpspi.c                        |  2 +-
 drivers/spi/spi-imx.c                              |  2 +-
 fs/btrfs/disk-io.c                                 |  6 +++---
 fs/xfs/xfs_icache.c                                |  2 +-
 fs/xfs/xfs_sysfs.c                                 |  7 +++----
 net/ceph/ceph_common.c                             | 10 ++++-----
 net/ceph/osd_client.c                              |  3 +--
 scripts/coccinelle/misc/secs_to_jiffies.cocci      | 22 ++++++++++++++------
 sound/pci/ac97/ac97_codec.c                        |  3 +--
 24 files changed, 63 insertions(+), 69 deletions(-)
---
base-commit: 9a87ce288fe30f268b3a598422fe76af9bb2c2d2
change-id: 20241217-converge-secs-to-jiffies-part-two-f44017aa6f67

Best regards,
-- 
Easwar Hariharan <eahariha@linux.microsoft.com>

