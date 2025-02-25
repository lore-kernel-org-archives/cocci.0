Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A0AC021B8
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XNL3dldZNlw1Eq84meBUr//vKEng/ID/zFGHKMY53sg=;
  b=Q6fvsjd8ARtoBNDdyo7iwa374gre+dodlb0FlgbLSu5mEMFCvOy+iW6y
   RahMjX0aSfil7Aqz7ObyWjRQ37v5pwsC86m6frohb6RRGEdH8XMTW6Mt9
   fakgeW3WqMtnrZPtbc1P+2DBMiVGb/JE/WSwHO014/HEwrd9GayBx0/bW
   Y=;
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
   d="scan'208";a="210044164"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D05F6E0E3A; Tue, 25 Feb 2025 21:28:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F2E4BE0260
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:28 +0100 (CET)
IronPort-SDR: 67be2558_BGctZWaITElddnYCC37cEMf5fCzU5qDajB4vCK64F81P+Ar
 AzlPydvOMBRA4H/sxJgZ03ZLRwY5fAP7O4TG0ug==
X-IPAS-Result: =?us-ascii?q?A0EYAAAjJL5ncraaTQ1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQQQBAQELAYJDgVczBwhIhFaSBotgkEuBVoFAPg8BAwFOAQIEAQEDB?=
 =?us-ascii?q?IUAAosSAh8GAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AGBDIV7DYJiAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEBH?=
 =?us-ascii?q?gIBAxESBBkBATcBDxkMAiYCAkYQBgESgwKCZQYCnSwBh2ABAQKLI38zgQGCD?=
 =?us-ascii?q?AEBBoJo2TiBZQmBGi4BiE4BgWyDfzsJgzl6JxuBSUSBFTWBBoIthApOg0aCa?=
 =?us-ascii?q?YIzgUCDbIFsilwcLYIlmCsJP4EFHANZLAFVEw0KCwcFZFU4AyAKCwwLEhwVA?=
 =?us-ascii?q?hQdDwYQBGpDN4JFaUk6Ag0CNYIeJFiBHYEOhFSEQ1wvAwMDA4Mqgj9RgkKCE?=
 =?us-ascii?q?XGBGokyg2MdQAMLGA1IESw3Bg4bQwFuB6AlPIQ7gQ6BJ5Q9hBqNS6FvhCWhY?=
 =?us-ascii?q?gEyqlUuh2WQaiKoXYIeATOBXEYHIxWDIk8DGQ+IAIYhg3qPPQG8M0M1PAIHC?=
 =?us-ascii?q?wEBAwmFRgEBiiA0gUsBAQ?=
IronPort-PHdr: A9a23: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
 sfr+bmfKg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:eLQ83qlRqc8VzwmD7U4q9ipAFLjpDfIW3DAbv31ZSRFFG/FwWf
 re+sjzsiWE6wr5OUtBpTjjUJPrfZq4z/NICOYqUotKMDOLhILsFvAH0WKA+Vzd8lPFh4xgPM
 5bGsAUNDSzNykesS+Q2meF+rgbsb66GdiT9J7j80s=
X-Talos-CUID: 9a23:xMm5qmE7VxTGmBDXqmJGr1QPGfE+dET01VfNJhKmImQ5GOaaHAo=
X-Talos-MUID: 9a23:Se62yAZ6vKVmZOBTuRrWtC17d9pRv7W2U38AlKpY69a0HHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210043083"
X-MGA-submission: =?us-ascii?q?MDHJADPZ4RdbrydFZy2fAqx41Mvq0DlUoyO4ft?=
 =?us-ascii?q?LkqE0jSeMmvN8BqSziUPdM49aIqG16NuWgnsKExjrXEPQ/rBbIyeNFGL?=
 =?us-ascii?q?IJ1fqq8oF3W1eMqxtP36HcyW6ahgXIXiZa3ycZbgZpXXiUwQyj1opt4R?=
 =?us-ascii?q?8FxYKGIXFrRen6gSF/BOQLIA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:17:28 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 544A4206ADFB;
	Tue, 25 Feb 2025 12:17:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 544A4206ADFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514642;
	bh=XNL3dldZNlw1Eq84meBUr//vKEng/ID/zFGHKMY53sg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Du6Fw81gtR9lc6VxhG+uolWk6DNSsR0fD03V4uHvgstLN4C99mrYAdfHxBUoITNbw
	 0dBuGVNQZXhzAmqB9swX2y81gcwwAgNvdFZl3mtEL75lM8WadHp0lYC+JXaZXEaD0T
	 xEVN7fx6wsqh1SZPlLtM4UUNPYU6T4vw+KsVz5dg=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-16-a43967e36c88@linux.microsoft.com>
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
Subject: [cocci] [PATCH v3 16/16] RDMA/bnxt_re: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2447
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-16-a43967e36c88%40linux.microsoft.com>

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

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 17e62f22683b14a3571188e25fe0df3cbf1d8360..b1a18c9cb7f6c248548bc38fcb98781a3030a1b6 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -160,7 +160,7 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 		wait_event_timeout(cmdq->waitq,
 				   !crsqe->is_in_used ||
 				   test_bit(ERR_DEVICE_DETACHED, &cmdq->flags),
-				   msecs_to_jiffies(rcfw->max_timeout * 1000));
+				   secs_to_jiffies(rcfw->max_timeout));
 
 		if (!crsqe->is_in_used)
 			return 0;

-- 
2.43.0

