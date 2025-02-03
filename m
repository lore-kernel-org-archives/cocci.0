Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC603C02199
	for <cocci@archiver.kernel.org>; Mon,  3 Feb 2025 23:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jl/YrVgNHMJyuougsZ83XWkAHGEtBSCoppF53ehyxrQ=;
  b=LJc+Z8YKwxW8wM7TE2OMDmtjrwkdPBaYRzxWGE6pNIxbkJqLOXiprvt1
   MDvSeP7z/FMp8+DciA8sf7iv3X8jIUFpSAoB45+SOic0U2s2zloNkguBh
   ERe+jpSMfBU6m1X8A0DFc9csu48C6KWQjpfy/bn5sF1IhbwhEvpr4EGJf
   o=;
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
X-IronPort-AV: E=Sophos;i="6.13,257,1732575600"; 
   d="scan'208";a="206392383"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Feb 2025 00:50:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 12571E0260; Tue,  4 Feb 2025 00:50:32 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 99D3BE0D1D
	for <cocci@sympa.inria.fr>; Tue,  4 Feb 2025 00:50:26 +0100 (CET)
IronPort-SDR: 67a15642_ccJ2rD5z5vWgPjpdmoLw0sY4wHugMP/Oim7stOvOaDKm4zp
 zupzXKXqspHOpubFBoSkRUmeALBogHBakzm2c4Q==
X-IPAS-Result: =?us-ascii?q?A0EDAACeVaFncraaTQ1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDgVczBwhIhFaIHYlTFotgkE2BVoFAPg8BA?=
 =?us-ascii?q?wFOAQIEAQEDBIFMgzQCin0CHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQERAg1eAQEeAgEDERIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKfZQGHY?=
 =?us-ascii?q?AEBAosjfzOBAYIMAQEGgmfZOIFlCYEaLgGITQGBbIN/OwmDOXonG4FJRIFKg?=
 =?us-ascii?q?zOEWINGgmmCM4FCg2+iYAk/gQUcA1ksAVUTDQoLBwVkVTgDIAoLDAsUHBUCF?=
 =?us-ascii?q?B0PBhAEbUQ3gkdpSToCDQI1gh4kWIEdgQ6EXIRDhE6CRlSCRIISdIEXiAMdQ?=
 =?us-ascii?q?AMLGA1IESw3Bg4bQwFuB50/PIQIB4EPgSYIepM7HRGDbI1KgiCfT4QloWABM?=
 =?us-ascii?q?oQElAaSSS6HZJBqIqQmhDWCGDqBXEYHIxWDIk8DGQ+IAIYhg3qPPQG5GEM1P?=
 =?us-ascii?q?AIHCwEBAwmFRgEBim2BSwEB?=
IronPort-PHdr: A9a23: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
 Mw5dFGTWVxpx7yURUxhCA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:+o2xsKwZNXrS8oBod5OsKrPwFr1zdoMgy1knxilNoNJuA6qlfq
 eV7ZcmPH7P6Ar4Ohkb8+xoXZPsfZqyz/FICOUqUYtKGTOW3FdAT7sC0WKd+UyDJ8SWzIc0vp
 uIMZIObeEYZmIVsS+V2njeLz9Z+qj/zJyV
X-Talos-CUID: =?us-ascii?q?9a23=3AnrPkJGiIFaebyxDB6SEN4iYmTjJufXT47yuTJxe?=
 =?us-ascii?q?BBWNbY+CtZmfI0aBGnJ87?=
X-Talos-MUID: 9a23:ruCCcwlszp0M4hnRMNh6dnpdLdpLwY/wS3kplJsWlcelOjxVKimk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,257,1732575600"; 
   d="scan'208";a="206392316"
X-MGA-submission: =?us-ascii?q?MDEbQVUTiz34qlqOalp3Y5LF8nhzRq/Feo+x2F?=
 =?us-ascii?q?GmZjj/DowhPyW7Lo9TPkSWMGBLXZjRWcD+CYmHjMvQH9ZTo2jfuI4oAF?=
 =?us-ascii?q?+GTnWypksxEZzQo4VxKGYwXDPIMadRftU8ofaJet85huogsPqMAbFNvX?=
 =?us-ascii?q?XT5VKwWqDdo6i49ZIZq2/7Jg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 04 Feb 2025 00:50:25 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 84A00205493E;
	Mon,  3 Feb 2025 15:50:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 84A00205493E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738626623;
	bh=jl/YrVgNHMJyuougsZ83XWkAHGEtBSCoppF53ehyxrQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=StqwqgSNG2KkJyJsRG/IWgyvZ5UocaH2m/+dfcXUagDXBgaYXw89QgEKxugfrep4v
	 dLKXw3DPl9XGMIJreixUiyn7yAWneAEebfFyONYlzSWFZngQlphknQdYWu13Rs37yX
	 3WP+/AGKzQjgplcS2c3XKuSfIiY+hG9bzK/eU1/c=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Mon, 03 Feb 2025 23:50:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-converge-secs-to-jiffies-part-two-v2-3-d7058a01fd0e@linux.microsoft.com>
References: <20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com>
In-Reply-To: <20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 Ilya Dryomov <idryomov@gmail.com>, 
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, 
 Xiubo Li <xiubli@redhat.com>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
Subject: [cocci] [PATCH v2 3/3] libceph: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2334
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250203-converge-secs-to-jiffies-part-two-v2-3-d7058a01fd0e%40linux.microsoft.com>

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

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

