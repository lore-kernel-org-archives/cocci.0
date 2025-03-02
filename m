Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C795BC282DC
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:reply-to:mime-version:
   content-transfer-encoding:subject:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=O6DE7DCpJw4TB8feyeSd8BWfUFVAmf0EuvvRwHMeulI=;
  b=KU4jmFCHf4PR54wXzuMAW2SIE0GsksASGCMhO+k3ylyeXm2WnuO1eB/e
   PFO242ZvgCZ+ouZw9MmO5LWjDxvtvZo2U/Wgp9Yy2H2H5vuKfzZHGxiDD
   MsnS8dgxDkOnecuO8Sy6CAZUShk8xaI5P95dg4XKAlD10s1AvInUbkF+R
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@seltendoof.de
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211070373"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DC39BE18B6; Tue,  4 Mar 2025 10:58:49 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 25A5EE0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 17:07:04 +0100 (CET)
IronPort-SDR: 67c48227_RWB09g0/U3mghyQ/S1U6CzhR3DUIY1uOFG25KmkXhyDX35U
 r5rPnTT91x+pFl905xOxSfxzefHcih3QgCQHpJw==
X-IPAS-Result: =?us-ascii?q?A0EDAAAngcRn/6Mwd6haGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAYJDB2kLWzQECx4qhFaIHYlTkUqMT?=
 =?us-ascii?q?SCBXg8BAwENRAQBAQMBA4UAixcCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQKBChOFew2CYjSCFiyBAgsnBAsBDQEBNwEvBQIYDgI/A?=
 =?us-ascii?q?TFbgicBgjABAQExA68rfzOBAYIMAQEGglDYLwQKGg2BMYEgCYEaLgGITgGFU?=
 =?us-ascii?q?hmDfYEhG4INglCCLYIfgXsMg3gWglOCM4Fqgz2aBY5aB2FeHAOBbhcSgXYDg?=
 =?us-ascii?q?Q+BRUQ3gkVpSToPN4IegyeEToMdgXwvAwMDA40AFIRBAgKDa4MvgjpUDAttP?=
 =?us-ascii?q?TcILT0IQh0SoHU6hDoHAYENMB0uYGULkxqDUa97C4I/gWaKeJZQTZdTkwOIM?=
 =?us-ascii?q?LRHAYU2YIEHPYFZcYFtCQsagRtPAxkPjiGELcgjRTI8AgcBCgEBAwmCOY0vA?=
 =?us-ascii?q?ScMgUsB?=
IronPort-PHdr: A9a23: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
 8LRmbircnFZ/tbI8M0QAM/abs6KYiJJDA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:VhS6yaEUyHsGg1tTpLqE/ceALOsnbusQ8zAXPo5KJSC9Ffbo8v
 xG/c5rtyMc7Qx6ZJhOo7690cW7Kk80lqQFgrX5X43CYOCOggLBEGgF1+vfKlbbdBEWmNQx6Z
 td
X-Talos-CUID: =?us-ascii?q?9a23=3A+Yn+NmseCjpncGQsO/XMl5oh6Isafk/87kn0IHa?=
 =?us-ascii?q?lInhWT7iHV2GRpaNdxp8=3D?=
X-Talos-MUID: 9a23:lhXImgXsa4Rs7lTq/A/hvAE9ZdZo2aa/DnAQwKQs+O+qFQUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210743764"
X-MGA-submission: =?us-ascii?q?MDFGOi4mla/mvLhBwi5ezhnFZctTprfQ+8GORq?=
 =?us-ascii?q?A/tb8/w85lvYSmezJBPajYIFc2l/O0Gdw5jHmDcmTF9kPaWw7cv0Gtcq?=
 =?us-ascii?q?PZXHSIiL4SikurqYO1Y5W859SXnXRmZEfdWm+XLMRzbl9JAcZ/Esqpkg?=
 =?us-ascii?q?67hyStkbmBxDQW0+4TG8mbLw=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 17:07:03 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931622;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=O6DE7DCpJw4TB8feyeSd8BWfUFVAmf0EuvvRwHMeulI=;
	b=PiWSfiieggVS+NN774Yowdm3BHp08bxuRLv4yBIU7WPvptO1S3gmmiHLeYXYmtpJQbuxHE
	tl+oUyQ+zI2i7B8Fn2bEToyS9YLGcjJU2dHkRupFBaT4ALGWcaV8pJowicqwQQlvB2W4ql
	MxoMfrj07KDalLy6DIrunO6hBwM8CcszdwW65tv2rj1krx1nyFWPyI4gvzcL9r7FVn78E/
	jlYF4VMCNL/G7PK40V/u0UhZOFkGs/jnixY6Rm+Q0yggOaJszuLy5jRKKljTFboNhwyxMX
	spm1dWYccPY499VqDlbImT/va1d+AtfepabQe8ew7e7bZ+uTckZrB8diqJ8DEg==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr
Date: Sun,  2 Mar 2025 17:06:38 +0100
Message-ID: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2 02/11] quota: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2528
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250302160657.127253-1-cgoettsche%40seltendoof.de>

From: Christian Göttsche <cgzones@googlemail.com>

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 fs/quota/dquot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 825c5c2e0962..5c56babf581c 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1283,9 +1283,9 @@ static int ignore_hardlimit(struct dquot *dquot)
 {
 	struct mem_dqinfo *info = &sb_dqopt(dquot->dq_sb)->info[dquot->dq_id.type];
 
-	return capable(CAP_SYS_RESOURCE) &&
-	       (info->dqi_format->qf_fmt_id != QFMT_VFS_OLD ||
-		!(info->dqi_flags & DQF_ROOT_SQUASH));
+	return (info->dqi_format->qf_fmt_id != QFMT_VFS_OLD ||
+		!(info->dqi_flags & DQF_ROOT_SQUASH)) &&
+		capable(CAP_SYS_RESOURCE);
 }
 
 static int dquot_add_inodes(struct dquot *dquot, qsize_t inodes,
-- 
2.47.2

