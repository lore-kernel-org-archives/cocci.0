Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7835BC02190
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=HdLPh2PfgYXpuYBC8DOdOZE21MhHNYKQn7qY/vRruJc=;
  b=QDyfikX3qIpZjfUNoFv3mhzIfZZXO0nfE+6o6EOjn9hhbzVvWCpNoe/D
   b+49gavOMorZ7uBN4htuwfO7DG5c0DAIV1Ec8FrO61alvGEe9NE0643k7
   pVaAo29A8HzgzkQGctYXsngqONITH4do5CeGIO2DAPWJKSrgUMzqEjf33
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
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205450116"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C1BA5E00A5; Tue, 28 Jan 2025 19:22:14 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D0560E0D1D
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:03 +0100 (CET)
IronPort-SDR: 6799204b_GgYzwQ85RTLuy3ikEaIGl8pqJpoZh3j7GDMMOY2Ct/PMAv4
 R2P1S4bZgALIoWsQ/eN2UjKUjxxp5n064pUPgjw==
X-IPAS-Result: =?us-ascii?q?A0EgAACtH5lncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHYlTi3aQT4FWgUA+DwEDAU4BAgQBAQMEgUyDN?=
 =?us-ascii?q?AKKdQIfBgEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABg?=
 =?us-ascii?q?QyFew2CYgGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BAR4CA?=
 =?us-ascii?q?QMREgQZAQE3AQ8ZDAImAgJGEAYBEoMCgmUGAqIyAYdgAQECiyN/M4EBggwBA?=
 =?us-ascii?q?QaCZ9k4gWQJgRouAYhNAYFsg387CYM5eicbgUlEgUqDM4RYg0aCaYIzgUWDb?=
 =?us-ascii?q?6EdCT+BBRwDWSwBVRMNCgsHBWRVOAMgCwsMCxQcFQIUHQ8GEARtRDeCR2lJN?=
 =?us-ascii?q?wINAjWCHiRYgR2BDoRchEVgLwMDAwODOIJFVIJEghR6gReGQh1AAwsYDUgRL?=
 =?us-ascii?q?DcGDhtDAW4HnF08g3wHgQ+BJgiUNB2DfI1Jgh+fT4QloWABMqpTLodkkGoiq?=
 =?us-ascii?q?FqCGDqBXEYHIxWDIk8DGQ+IAIYhg3qPPQG6C0M1PAIHCwEBAwmFRgEBilGBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ccuYP6OF+KZdpsBcTvujsMiBIKoaSvp037Dk7TEWdfUzSL36qy
 nOppQmPX2dslwssRQb9OxoV5PufZqxz/JICMwqTNOftWrd2VdAUrsSj7cKqgeIc0bDH6xmpM
 JdmsNFZuEYY2IK6voSmDPIauod/A==
X-Talos-CUID: =?us-ascii?q?9a23=3Aak6U1WvAhi30elL93R09ScLU6It1bUzy6nfBDnW?=
 =?us-ascii?q?gGHlvWZO7WWK846prxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AwZp0eg3lNcWo+O4uFz+YZI4izjUj5r+pEUsVvIU?=
 =?us-ascii?q?9+JObDy9xJnCikTqOa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107588267"
X-MGA-submission: =?us-ascii?q?MDGVfrjBwYcGnjHPGwCTnqwPtPtkEqaeQ86BPX?=
 =?us-ascii?q?EsSkQxR0UTs6Ejx6ZISPuHsPvq+6wSnvx7+SQoi8JZnS3endomHoRM45?=
 =?us-ascii?q?E4CLebtEoZXF6Nctq+uDRryChWHGnBw+XUjvvnJ1wSyE6sq6/chVERUx?=
 =?us-ascii?q?AvXjEUVQqsk/AhzIkt9BZsIQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 28 Jan 2025 19:22:03 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 677F3203717D;
	Tue, 28 Jan 2025 10:21:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 677F3203717D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088518;
	bh=HdLPh2PfgYXpuYBC8DOdOZE21MhHNYKQn7qY/vRruJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hgE89/ZEGzhCC06fBSy0OuT0sQNDNNusckBiNMFdx8HObLyTLW3siMG94Pr0ZLlsb
	 fQK9++emxz2f1q1VTPxH2f2GJNOABzUmDv5dw+7qWye+06L0MBnTU4YhBM46fW71JN
	 PSr2aK+Cp92CEJ/69KbyMUuvjSAK/8CWtJpCo8l8=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-7-9a6ecf0b2308@linux.microsoft.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
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
Subject: [cocci] [PATCH 07/16] libceph: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2282
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-7-9a6ecf0b2308%40linux.microsoft.com>

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

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
 net/ceph/ceph_common.c | 10 ++++------
 net/ceph/osd_client.c  |  3 +--
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 4c6441536d55b6323f4b9d93b5d4837cd4ec880c..0d1e303c0212cc9f70f7c54ca422b0b3ea01bf32 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -529,27 +529,25 @@ int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
 		/* 0 isn't well defined right now, reject it */
 		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
 			goto out_of_range;
-		opt->osd_keepalive_timeout =
-		    msecs_to_jiffies(result.uint_32 * 1000);
+		opt->osd_keepalive_timeout = secs_to_jiffies(result.uint_32);
 		break;
 	case Opt_osd_idle_ttl:
 		/* 0 isn't well defined right now, reject it */
 		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
 			goto out_of_range;
-		opt->osd_idle_ttl = msecs_to_jiffies(result.uint_32 * 1000);
+		opt->osd_idle_ttl = secs_to_jiffies(result.uint_32);
 		break;
 	case Opt_mount_timeout:
 		/* 0 is "wait forever" (i.e. infinite timeout) */
 		if (result.uint_32 > INT_MAX / 1000)
 			goto out_of_range;
-		opt->mount_timeout = msecs_to_jiffies(result.uint_32 * 1000);
+		opt->mount_timeout = secs_to_jiffies(result.uint_32);
 		break;
 	case Opt_osd_request_timeout:
 		/* 0 is "wait forever" (i.e. infinite timeout) */
 		if (result.uint_32 > INT_MAX / 1000)
 			goto out_of_range;
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

