Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7DBC021BB
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RCLH8aXh/e5sdYq7k7e2qGUG/PeWI3Ghf2E96MmmOCQ=;
  b=oS+dOCC9vprnZUDBGi8FSEQv5lQcRfbzQs18CCrv6HAeiNKZ3SBuafnQ
   1SCjYfJo9vgw8kuqjg8v03k5ijZGqMdRpSw3AeVFgBb/RORNzR+VjQCmO
   pHW7JXzPdWsxDH365Plnr9nM4lF6AwBQMiZxWcHTBdrdTnnQsMlbn74Sd
   I=;
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
   d="scan'208";a="210043935"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5FAC7E0D97; Tue, 25 Feb 2025 21:28:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AE5DBE0260
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:25 +0100 (CET)
IronPort-SDR: 67be2555_luHTVyvPcQQEDLySDVz7m8v7fk99eRvsfXw80Sw/Rfp6n7a
 nzTB7tSsLzTrmj7cOP0h7p01mue4RCWDrDlQzRw==
X-IPAS-Result: =?us-ascii?q?A0EDAAAjJL5ncraaTQ1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBwhIhFaIHYlTFotQEJBLgVaBQD4PA?=
 =?us-ascii?q?QMBTgECBAEBAwSFAAKLEgIfBgEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABgQyFew2CYgGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARECDV4BAR4CAQMREgQZAQE3AQ8ZDAImAgIgJhAGARKDAoIxAzEGAp0sA?=
 =?us-ascii?q?YdgAQECiyN/M4EBggwBAQaCaNg/DWyBZQmBGi4BiDAeAYFsg387CYM5eicbg?=
 =?us-ascii?q?UlEgUqDM4IfgjmDRoJpgjOBQINsp2EJP4EFHANZLAFVEw0KCwcFZFU4AyAKC?=
 =?us-ascii?q?wwLEhwVAhQdDwYQBGpDN4JFaUk6Ag0CNYIeJFiBHYEOhFSEQ1wvAwMDA4Mqg?=
 =?us-ascii?q?j9RgkKCEXGBGokyg2MdQAMLGA1IESw3Bg4bQwFuB6AlPIQ0B4EPgSYIepM7H?=
 =?us-ascii?q?RGDbI1LgiCeXnGEJZtQhhIBMoQDlAeSSy6HZZBqIpFqlnOCGDqBXEYHIxWDI?=
 =?us-ascii?q?k8DGQ+IAIYhg3qPPQG8M0M1PAIHCwEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 sfr+bmfKg==
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:smtXyazrpmO5onYAcuOiKrPwFr1zdoMgy1knxilNoNJuA6qlfq
 eV7ZcmPH7P6Ar4Ohkb8+xoXZPsfZqyz/FICOUqUYtKGTOW3FdAT7sC0WKd+UyDJ8SWzIc0vp
 uIMZIObeEYZmIVsS+V2njeLz9Z+qj/zJyV
X-Talos-CUID: =?us-ascii?q?9a23=3Agjj2Z2j2mAuFm9R4PsumOVa0iDJuXFeE7SrLA3O?=
 =?us-ascii?q?CJ2dAR7iQQHOi1LJ1jJ87?=
X-Talos-MUID: 9a23:86y/7QnOj9qfBqdrzBFfdnp4L81q26S8OXkfz68KlO6CB3V2YhGS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210043057"
X-MGA-submission: =?us-ascii?q?MDECGTe2RfUqFAr0qF77Htrd8jbC55m46qmrsK?=
 =?us-ascii?q?ID6PopXT2mq0k28xuuzs/iTNw3+OMwAqtQTRBXRXs+fMCwxMYTl+TUoU?=
 =?us-ascii?q?MmTL2RT9FrnLpO+tfZn1dzf3ZwiNu9QFIstjpv0nmUhS72altK15VRLt?=
 =?us-ascii?q?H7GC7z05WDXQiKNdgRf+L5GA=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:17:24 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id C2CA6206940D;
	Tue, 25 Feb 2025 12:17:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2CA6206940D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514640;
	bh=RCLH8aXh/e5sdYq7k7e2qGUG/PeWI3Ghf2E96MmmOCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PXqlaqa8hq7wCvePSwmkX/hYzUg+ju9Ou7bMg+YX8hyBGTbIPc21VpF1/Rau+Mozk
	 IFavdSKToQk7As2VHypOAXb4xve0beBhRHj2pB6jSrbyLVhpMjqfct4Ik7cqdh5u5O
	 CrVVlAliI3k9dFPrPolatWSJ8hKmlQi8g6zOp6X0=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-7-a43967e36c88@linux.microsoft.com>
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
Subject: [cocci] [PATCH v3 07/16] libceph: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2438
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-7-a43967e36c88%40linux.microsoft.com>

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@depends on patch@ expression E; @@

-msecs_to_jiffies(E * 1000)
+secs_to_jiffies(E)

@depends on patch@ expression E; @@

-msecs_to_jiffies(E * MSEC_PER_SEC)
+secs_to_jiffies(E)

While here, remove the no-longer necessary checks for range since there's
no multiplication involved.

Acked-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 include/linux/ceph/libceph.h | 12 ++++++------
 net/ceph/ceph_common.c       | 18 ++++++------------
 net/ceph/osd_client.c        |  3 +--
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 733e7f93db66a7a29a4a8eba97e9ebf2c49da1f9..5f57128ef0c7d018341c15cc59288aa47edec646 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -72,15 +72,15 @@ struct ceph_options {
 /*
  * defaults
  */
-#define CEPH_MOUNT_TIMEOUT_DEFAULT	msecs_to_jiffies(60 * 1000)
-#define CEPH_OSD_KEEPALIVE_DEFAULT	msecs_to_jiffies(5 * 1000)
-#define CEPH_OSD_IDLE_TTL_DEFAULT	msecs_to_jiffies(60 * 1000)
+#define CEPH_MOUNT_TIMEOUT_DEFAULT	secs_to_jiffies(60)
+#define CEPH_OSD_KEEPALIVE_DEFAULT	secs_to_jiffies(5)
+#define CEPH_OSD_IDLE_TTL_DEFAULT	secs_to_jiffies(60)
 #define CEPH_OSD_REQUEST_TIMEOUT_DEFAULT 0  /* no timeout */
 #define CEPH_READ_FROM_REPLICA_DEFAULT	0  /* read from primary */
 
-#define CEPH_MONC_HUNT_INTERVAL		msecs_to_jiffies(3 * 1000)
-#define CEPH_MONC_PING_INTERVAL		msecs_to_jiffies(10 * 1000)
-#define CEPH_MONC_PING_TIMEOUT		msecs_to_jiffies(30 * 1000)
+#define CEPH_MONC_HUNT_INTERVAL		secs_to_jiffies(3)
+#define CEPH_MONC_PING_INTERVAL		secs_to_jiffies(10)
+#define CEPH_MONC_PING_TIMEOUT		secs_to_jiffies(30)
 #define CEPH_MONC_HUNT_BACKOFF		2
 #define CEPH_MONC_HUNT_MAX_MULT		10
 
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 4c6441536d55b6323f4b9d93b5d4837cd4ec880c..c2a2c3bcc4e91a628c99bd1cef1211d54389efa2 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -527,29 +527,23 @@ int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
 
 	case Opt_osdkeepalivetimeout:
 		/* 0 isn't well defined right now, reject it */
-		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
+		if (result.uint_32 < 1)
 			goto out_of_range;
-		opt->osd_keepalive_timeout =
-		    msecs_to_jiffies(result.uint_32 * 1000);
+		opt->osd_keepalive_timeout = secs_to_jiffies(result.uint_32);
 		break;
 	case Opt_osd_idle_ttl:
 		/* 0 isn't well defined right now, reject it */
-		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
+		if (result.uint_32 < 1)
 			goto out_of_range;
-		opt->osd_idle_ttl = msecs_to_jiffies(result.uint_32 * 1000);
+		opt->osd_idle_ttl = secs_to_jiffies(result.uint_32);
 		break;
 	case Opt_mount_timeout:
 		/* 0 is "wait forever" (i.e. infinite timeout) */
-		if (result.uint_32 > INT_MAX / 1000)
-			goto out_of_range;
-		opt->mount_timeout = msecs_to_jiffies(result.uint_32 * 1000);
+		opt->mount_timeout = secs_to_jiffies(result.uint_32);
 		break;
 	case Opt_osd_request_timeout:
 		/* 0 is "wait forever" (i.e. infinite timeout) */
-		if (result.uint_32 > INT_MAX / 1000)
-			goto out_of_range;
-		opt->osd_request_timeout =
-		    msecs_to_jiffies(result.uint_32 * 1000);
+		opt->osd_request_timeout = secs_to_jiffies(result.uint_32);
 		break;
 
 	case Opt_share:
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b24afec241382b60d775dd12a6561fa23a7eca45..ba61a48b4388c2eceb5b7a299906e7f90191dd5d 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4989,8 +4989,7 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 	linger_submit(lreq);
 	ret = linger_reg_commit_wait(lreq);
 	if (!ret)
-		ret = linger_notify_finish_wait(lreq,
-				 msecs_to_jiffies(2 * timeout * MSEC_PER_SEC));
+		ret = linger_notify_finish_wait(lreq, secs_to_jiffies(2 * timeout));
 	else
 		dout("lreq %p failed to initiate notify %d\n", lreq, ret);
 

-- 
2.43.0

