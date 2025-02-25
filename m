Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FD7C021BE
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/rdlqcTwv5mN/sc7m2KrDg4m+dKAQX2yY+t0CXok2oY=;
  b=s6q8+hmemPilCB1ISOH1oE+WBQ138bYeixGniCZd05PCrIo+9mN5Qf/I
   IyLcQazUlrL4K28rjqPgflzbnxdmlZgxpILnaUm+ofjG0Jyzsy8Y9GZjy
   3WUWg236+cNQSF2oRrd2Mbzmbkbu0cuutWNej+APFtbvrg2FlLolb+BQ5
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
   d="scan'208";a="210043986"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 01E0FE0DC5; Tue, 25 Feb 2025 21:28:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6E312E0264
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:26 +0100 (CET)
IronPort-SDR: 67be2556_pPZluo9Ff+zDMaMVwM2fwcmHi42tA882E2u1G3FYb+SMLfk
 erC2NbrhQspl6EMvLzi622neZvYCYasMsZpeNNQ==
X-IPAS-Result: =?us-ascii?q?A0ELAACfJL5ncraaTQ1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDgVczBwhIhFaIHYlpi2CQS4FWgUA+DwEDAU4BAgQBA?=
 =?us-ascii?q?QMEhQACixICHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eA?=
 =?us-ascii?q?QEeAgEDERIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKdLQGHYAEBAosjfzOBA?=
 =?us-ascii?q?YIMAQEGgmjZOIFlCYEaLgGITgGBbIN/OwmDOXonG4FJRIFKgzOEWINGgmmCM?=
 =?us-ascii?q?4FAg2ynYQk/gQUcA1ksAVUTDQoLBwVkVTgDIAoLDAsSHBUCFB0PBhAEakM3g?=
 =?us-ascii?q?kVpSToCDQI1gh4kWIEdgQ6EVIRDXC8DAwMDgyqCP1GCQoIRcYEaiTKDYx1AA?=
 =?us-ascii?q?wsYDUgRLDcGDhtDAW4HoCU8hDuBDoEngXySQYQajUuhb4QloWIBMqpVLodlk?=
 =?us-ascii?q?GoiqF2CGDqBXEYHIxWDIk8DGQ+IAIYhDBaDWI89Abw1QzU8AgcLAQEDCYVGA?=
 =?us-ascii?q?QGKVIFLAQE?=
IronPort-PHdr: A9a23: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
 A==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:wWwek6OeI098rcBcTvujsMiBIKoaSvp037Dk7TEWdfUzSL36qy
 nOppQmPX2dslwssRQb9OxoV5PufZqxz/JICMwqTNOftWrd2VdAUrsSj7cKqgeIc0bDH6xmpM
 JdmsNFZuEYY2IK6voSmDPIauod/A==
X-Talos-CUID: 9a23:b7u152D4AGE9x576ExBbrVNOHdBmS0/Y3ljNLm+aV2FIdrLAHA==
X-Talos-MUID: 9a23:AuFs8wosvHoE4/7ByG0ez2xcO8FQ0am/M1gMsaQplee2JCt3CjjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="110053386"
X-MGA-submission: =?us-ascii?q?MDGHNdYvKe83CYLam/kPzKi2O9VYx4Q17Xe8h8?=
 =?us-ascii?q?32UtL9Lp8dcBBNU5LsTBi3Gbd1lr19clY42oChAkCDDHHotPA9USCh/S?=
 =?us-ascii?q?CY1hUvBKJvpzJkTbRUr52MPYNlOsGcZjCPXBvAL6/9rTIoB7Efb5QTTg?=
 =?us-ascii?q?Lw9q+GBwhnRn0KvttGOCQ7eA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 25 Feb 2025 21:17:26 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 75931206AB6C;
	Tue, 25 Feb 2025 12:17:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 75931206AB6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514641;
	bh=/rdlqcTwv5mN/sc7m2KrDg4m+dKAQX2yY+t0CXok2oY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rY57gui/I5s3opnKpMkUiVz2c8KEinkfrPoI4a0X58a/iSSS8lb6zsgJqkOKu7xOq
	 seorPBf8U1Bj+VcZjFfcO6jdNkWNML7i48hryZFC0g73WPEObXszX5QqDSiVWRpKsR
	 xhTzpQnxfRVcu8e8QVi+FGZLfxmNCa9p9IBg3p6A=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-11-a43967e36c88@linux.microsoft.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
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
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3 11/16] nvme: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2441
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-11-a43967e36c88%40linux.microsoft.com>

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@depends on patch@
expression E;
@@

-msecs_to_jiffies
+secs_to_jiffies
(E
- * \( 1000 \| MSEC_PER_SEC \)
)

Acked-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/nvme/host/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f028913e2e622ee348e88879c6e6b7e8f8a1cc82..24c3e1765d491daf8fd600f96788bf5765946f54 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4466,11 +4466,9 @@ static void nvme_fw_act_work(struct work_struct *work)
 	nvme_auth_stop(ctrl);
 
 	if (ctrl->mtfa)
-		fw_act_timeout = jiffies +
-				msecs_to_jiffies(ctrl->mtfa * 100);
+		fw_act_timeout = jiffies + msecs_to_jiffies(ctrl->mtfa * 100);
 	else
-		fw_act_timeout = jiffies +
-				msecs_to_jiffies(admin_timeout * 1000);
+		fw_act_timeout = jiffies + secs_to_jiffies(admin_timeout);
 
 	nvme_quiesce_io_queues(ctrl);
 	while (nvme_ctrl_pp_status(ctrl)) {

-- 
2.43.0

