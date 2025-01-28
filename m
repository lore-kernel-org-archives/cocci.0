Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1759C02198
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VqcHpB+vyGTp1RMX3+WFTH5f5bCj+Q9J8OolxUskrKo=;
  b=le7oewnnkHS73ySa4D6x2cxF+FWQmbHHIFEw9gI25umYxk1twdQrZ9OK
   u6BzpcqG//2KXdJt31oA6CzY+9MNhZw90YOHnOwhTclq+XZXLYaP/BuJp
   f4WsCuOzXceSXeODgA0gR/1pa4R4M91M/jY1xG4m6E58nKmdpkIz3EV+3
   M=;
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
   d="scan'208";a="205450217"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C2B15E0D63; Tue, 28 Jan 2025 19:22:16 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CD874E0D1E
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:04 +0100 (CET)
IronPort-SDR: 6799204c_2Leo+hKgllHi03CuyMflSLp4tvPJL+rU+voTmyIOilTZMkb
 eJWGkbuahu7DNnqwoz52Eb0Vmu63uyjVlWqu5KQ==
X-IPAS-Result: =?us-ascii?q?A0EgAACtH5lncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVJkE+BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?nUCHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKiMgGHYAEBAosjfzOBAYIMAQEGg?=
 =?us-ascii?q?mfZOIFkCYEaLgGITQGBbIN/OwmDOXonG4FJRIFKgzOECk6DRoJpgjOBRYNvi?=
 =?us-ascii?q?HuYIgk/gQUcA1ksAVUTDQoLBwVkVTgDIAsLDAsUHBUCFB0PBhAEbUQ3gkdpS?=
 =?us-ascii?q?TcCDQI1gh4kWIEdgQ6EXIRFYC8DAwMDgziCRVSCRIIUeoEXhkIdQAMLGA1IE?=
 =?us-ascii?q?Sw3Bg4bQwFuB5xdPIQDgQ6BJ4F8kkCEGY1JoW6EJaFgATKqUy6HZJBqIqhag?=
 =?us-ascii?q?hg6gVxGByMVgyJPAxkPiACGIQwWg1iPPQG6C0M1PAIHCwEBAwmFRgEBih00g?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:swU6daEbqs9QBMkBpLqE0seALOsnbusQ8zAXPo5KOHpom6uj5q
 OTdZUgtSMd6l4qMk3I/OrsBEDuexzhHPJOjbX5eI3SODUO21HIEGgd1/qB/9SIIUSXndK1l5
 0QFpSWY+efMbEVt7ec3ODBKadY/OW6
X-Talos-CUID: 9a23:9m6FBmETurPwoT6bqmJX8FMpN5kBVUGH5yr9HmyzLDhDSpusHAo=
X-Talos-MUID: 9a23:Yw/k6wuyhAhzM6RKRs2nqmxCOftxx5WUKH9OkqsYqvuDGDBREmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107588276"
X-MGA-submission: =?us-ascii?q?MDEzcGTaHJAVut7dx9puvYe+ynEMy6da/9oQNF?=
 =?us-ascii?q?qfnwcG+AsVFweyutZqp6WSjvy0dWI2UExZFM+FY6lAKZAZE6+fP4GWT2?=
 =?us-ascii?q?W5QoBnMMycO8IuGlB6uIejJkL3QSvLHRQmPjiQe8oNrhNA1bPIKoAp5d?=
 =?us-ascii?q?Wz5kEwJbpCgbdslHDDv3qJiw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 28 Jan 2025 19:22:04 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7B8912037183;
	Tue, 28 Jan 2025 10:21:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B8912037183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088519;
	bh=VqcHpB+vyGTp1RMX3+WFTH5f5bCj+Q9J8OolxUskrKo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZOuwdqaZhug0KNQQ21Ohb30BhgvBJyo55qHRaa7MGqCb8wONCvj3jN/bLp9sKWWM6
	 8bC+bT63Hpx0+HHlZCeQeaR75fGVzJRRwDfMPixaFz8dfRqI1843e4U/m+evk1P+Me
	 /+O0qMwZndCMTYuy618bWJRmYRUItE1KI26PeEM4=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-14-9a6ecf0b2308@linux.microsoft.com>
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
Subject: [cocci] [PATCH 14/16] platform/x86/amd/pmf: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2285
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-14-9a6ecf0b2308%40linux.microsoft.com>

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
 drivers/platform/x86/amd/pmf/acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/acpi.c b/drivers/platform/x86/amd/pmf/acpi.c
index dd5780a1d06e1dc979fcff5bafd6729bc4937eab..6b7effe80b78b7389b320ee65fa5d2373f782a2f 100644
--- a/drivers/platform/x86/amd/pmf/acpi.c
+++ b/drivers/platform/x86/amd/pmf/acpi.c
@@ -220,7 +220,8 @@ static void apmf_sbios_heartbeat_notify(struct work_struct *work)
 	if (!info)
 		return;
 
-	schedule_delayed_work(&dev->heart_beat, msecs_to_jiffies(dev->hb_interval * 1000));
+	schedule_delayed_work(&dev->heart_beat,
+			      secs_to_jiffies(dev->hb_interval));
 	kfree(info);
 }
 

-- 
2.43.0

