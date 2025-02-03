Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBC1C02193
	for <cocci@archiver.kernel.org>; Mon,  3 Feb 2025 23:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=inEJFlb8r1npYTsCShTPXzeDexvNBQKU3TCcAYSm03w=;
  b=gQdIRMs8JXFmuR56vXqRiM80aU0bnNKl1ippMW3srW2Ab1PJE0nwPEaa
   4w/1Hx0amVSGj9u4UbhBw2Wn3XLEDM34eOAb4N9dr/EOA+Mb83kySST/y
   nHj4YGgSleOZ9egHOUrYT9wHQ9IJEnhk631EjzrvzlvTC488CKyX7yxMl
   A=;
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
   d="scan'208";a="206392338"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Feb 2025 00:50:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C7923E0D22; Tue,  4 Feb 2025 00:50:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 564A8E0261
	for <cocci@sympa.inria.fr>; Tue,  4 Feb 2025 00:50:26 +0100 (CET)
IronPort-SDR: 67a15642_941k59rHq2u5bmtti2X7ya9Pp69fFgGM7V3ytBTn+7ICzAu
 87+Nm4o2oGFIo7hDJJ2eiuHWFf1OVJKaaXOipbA==
X-IPAS-Result: =?us-ascii?q?A0ELAACeVaFncraaTQ1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDgVczBwhIhFaIHYlTFotgkE2BVoFAPg8BAwFOAQIEA?=
 =?us-ascii?q?QEDBIFMgzQCin0CHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERA?=
 =?us-ascii?q?g1eAQEeAgEDERIEGQEBNwEPGQwCJgICRhAGARKDAoJlBgKfZQGHYAEBAosjf?=
 =?us-ascii?q?zOBAYIMAQEGgmfZOIFlCYEaLgGITQGBbIN/OwmDOXonG4FJRIFKgQaCLYRYg?=
 =?us-ascii?q?0aCaYIzgUKDb6JgCT+BBRwDWSwBVRMNCgsHBWRVOAMgCgsMCxQcFQIUHQ8GE?=
 =?us-ascii?q?ARtRDeCR2lJOgINAjWCHiRYgR2BDoRchEOEToJGVIJEghJ0gReIAx1AAwsYD?=
 =?us-ascii?q?UgRLDcGDhtDAW4HnT88g28ZBwGBDYEngQJ6kkGEGo1KoW+EJaFgATKqUy6HZ?=
 =?us-ascii?q?JBqIqQmhDWCGDqBXEYHIxWDIk8DGQ+IAIYhDBaDWI89AbkYQzU8AgcLAQEDC?=
 =?us-ascii?q?YVGAQGKbYFLAQE?=
IronPort-PHdr: A9a23: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
 Mw5dFGTWVxpx7yURU1hCA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:NndN461JXI9e8tqr+gerDAqjBIgkLtp133Aq2lEZdPWaSL3/qy
 nIpoV56faUslYssBNJo7q90cy7LE80mqQb3WB8B9uftUzdyQ+VxeJZjLcKvQeQeREWn9Q1vc
 xdmupFebjN5DNB4/oSjjPIdOrIuOP3iZyVuQ==
X-Talos-CUID: 9a23:O60o9m18STSM2foanAwsmLxfO+MbV1Oazn3pAlafD14udYSPS2SJ0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AG/4U/w9brluaulk062w6XNaQf5ds/LWOCh4CqK4?=
 =?us-ascii?q?lmJDfPB0gMCWgnDviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,257,1732575600"; 
   d="scan'208";a="206392314"
X-MGA-submission: =?us-ascii?q?MDH+LZwFqkQv+jciRDuYE3vVtSJNtWj1+2LenD?=
 =?us-ascii?q?Riq+PZewNsiRW0/zVcLK/RphGgut2HZxsfpaYcKCd/1isroaKuB4i2Z0?=
 =?us-ascii?q?Ifp2bZSDt3y9DIEj3oBkYSYBFXoSWCjtdUwGWXY7C8YlgjZ53z64mn20?=
 =?us-ascii?q?J1NtvzU5b1jrZNOrxD3cXb1Q=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 04 Feb 2025 00:50:25 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6B0C9205493D;
	Mon,  3 Feb 2025 15:50:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B0C9205493D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738626623;
	bh=inEJFlb8r1npYTsCShTPXzeDexvNBQKU3TCcAYSm03w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ReXLE283sX5Tuc0xrvz7bAVvEIGcJWw0rsBAmKKW/ZsT5S61O5VtjQ66Z15h9nzhF
	 36WfZ+35qfNmyQRvN0ihBKzifDLm1J6exfsCS9sn+0/ui+NUyQWAcEYxIkhW55TQ/5
	 imD44gbuz+LkK2jsREe0wluFIj6KbR/2Q+blP1Ck=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Mon, 03 Feb 2025 23:50:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-converge-secs-to-jiffies-part-two-v2-2-d7058a01fd0e@linux.microsoft.com>
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
Subject: [cocci] [PATCH v2 2/3] rbd: convert timeouts to secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2332
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250203-converge-secs-to-jiffies-part-two-v2-2-d7058a01fd0e%40linux.microsoft.com>

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

While here, remove the no-longer necessary check for range since there's
no multiplication involved.

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/block/rbd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index faafd7ff43d6ef53110ab3663cc7ac322214cc8c..41207133e21e9203192adf3b92390818e8fa5a58 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -108,7 +108,7 @@ static int atomic_dec_return_safe(atomic_t *v)
 #define RBD_OBJ_PREFIX_LEN_MAX	64
 
 #define RBD_NOTIFY_TIMEOUT	5	/* seconds */
-#define RBD_RETRY_DELAY		msecs_to_jiffies(1000)
+#define RBD_RETRY_DELAY		secs_to_jiffies(1)
 
 /* Feature bits */
 
@@ -4162,7 +4162,7 @@ static void rbd_acquire_lock(struct work_struct *work)
 		dout("%s rbd_dev %p requeuing lock_dwork\n", __func__,
 		     rbd_dev);
 		mod_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork,
-		    msecs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT * MSEC_PER_SEC));
+		    secs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT));
 	}
 }
 
@@ -6283,9 +6283,7 @@ static int rbd_parse_param(struct fs_parameter *param,
 		break;
 	case Opt_lock_timeout:
 		/* 0 is "wait forever" (i.e. infinite timeout) */
-		if (result.uint_32 > INT_MAX / 1000)
-			goto out_of_range;
-		opt->lock_timeout = msecs_to_jiffies(result.uint_32 * 1000);
+		opt->lock_timeout = secs_to_jiffies(result.uint_32);
 		break;
 	case Opt_pool_ns:
 		kfree(pctx->spec->pool_ns);

-- 
2.43.0

