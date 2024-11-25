Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A62D58D6E
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:reply-to:mime-version:
   content-transfer-encoding:subject:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=17lhHTnnZGmrh/UycwQ7pmOcwP/SDxseygpcnk52sbc=;
  b=jJeb3LE+AjmvjxDdELIHR3Vb0GvrVNPra1ZOqjBuPMqnECaJCj6MG/Xm
   wbziVjfS5+m9fT5ZSGBnxtlCfS5PEPYxLs86FfRjU6zwdVORg1sGMztUG
   U1cuFwMBaB3eRzR9ymJ7nJyyqvcQn3HmTae2cHBV4wNOnSir+7XCQnCrr
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@seltendoof.de
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195724263"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A4E1DE0D5F; Mon, 25 Nov 2024 17:57:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B2601E00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 11:40:45 +0100 (CET)
IronPort-SDR: 67445418_cwBB7UDmRjb+a40gBtEJjQaBkoNxDT4f5M/suA9eTR9lApj
 nu6MMM9U2g7iFVWe682NvZRosXBn7T+oGWRcIvw==
X-IPAS-Result: =?us-ascii?q?A0EgAAC9U0Rn/6Mwd6haHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDB2lmNAQLSIRWiB2JUZFNjE0ggV4PAQMBDUQEAQEDAQOFAIpbA?=
 =?us-ascii?q?h4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECgQoThXsNg?=
 =?us-ascii?q?mIBdIEkAQEBAQEBAQEBJysCgQ0nBAsBDQEBNwEvBQIYDgI/ATGDAYIxAQEBM?=
 =?us-ascii?q?QOvdH8zgQGCDAEBBoJQ2C4EChoNgTCBIAmBGi4BiEsBhVAZg32BIRuCDYJQg?=
 =?us-ascii?q?i2CH4F7DGqDDoJpgkSBMYNeJYU3g0mbMwcHYV4cA1khEQFVExcLBwWBdgODR?=
 =?us-ascii?q?oE2KIEpgxFKhQxGPYJKaU03Ag0CNoIkfYJNhRmDRoEjZS8DAwMDghOBK4YGH?=
 =?us-ascii?q?TcJAwttPTcIDBsGPQhCHRKgG0aDQQcBgQ0wHS5gcJMXg1CvbAuCP4FlinaWT?=
 =?us-ascii?q?U2XUZMAiC+QTKNyAYU1YIEHPYFZcYIBGoEbTwMZD44hhC3HFEUyOwIHAQoBA?=
 =?us-ascii?q?QMJgjmOTQEnDIFLAQE?=
IronPort-PHdr: A9a23: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
 chWIoI=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:6ss4S6zeuiOVm3x+Ooz+KrPwOb1zdoMgy1knxilNoNJuHvBw8P
 re+cjztCWE6gr5PUtLpTnuAse9qB/nnqKdgrNhXotKPjOGhILAFugL0WKF+V3d8kbFmdK1u5
 0MT5RD
X-Talos-CUID: 9a23:UUv7aGAKLyD7rQL6EzhKxVQsJekOS33QlCmJDQyXBCVScqLAHA==
X-Talos-MUID: 9a23:qmNzugv6vd4ILFsIMs2nlg87D8VX4J+XI2cpq4U46uSIbDxrNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="195628544"
X-MGA-submission: =?us-ascii?q?MDFZv9AqoFX8+sbasNPgohjVKMNCMSPAlWYvdD?=
 =?us-ascii?q?CLwr4vrA38GUb23I9QhcBdY6hYvrXiGqXCI6PGKGyKhz7jNRFEYR0V4G?=
 =?us-ascii?q?ASWD7W8yxZSM/rPpaaV0Jt1F5l3v70Ry+ZHTsonT1h3DVJ9mL4xHiR1O?=
 =?us-ascii?q?HZBoJFRrcKsh4eCeTlhiNEvw=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:40:24 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531222;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=17lhHTnnZGmrh/UycwQ7pmOcwP/SDxseygpcnk52sbc=;
	b=jFlHUnSJvVahXsR69S9gj5XhwOZOsx5mApFRT8497wpNJyGwwA7cfg7pEHClwY3EqMnwJS
	16s13rukrF0jxcnU4oJZse0adk+QnpoVnIrLGjWT3Z3v1hqD0/rz3cKNL4icom2QnisO+O
	52mTcwDrpYGSSIO5tMsUSRk249MQUpqXOxopVq4MvMOHI2hNIrgmXrIQ4lMEIPLvaLvo1o
	eil+6vDCkSBuqJtZei1xOBeQ6SmFf5x8awUZo6AhLqGdzAdbtqT6DNM4/LYTdsN+RzomRg
	Pa94yEk0S+pz6JHp2rzZRP/L46XO6/mQecqyF7JlaS9Ty2QdWS9rygJkL3FXeA==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Jan Kara <jack@suse.com>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr
Date: Mon, 25 Nov 2024 11:39:54 +0100
Message-ID: <20241125104011.36552-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 02/11] quota: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2110
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241125104011.36552-1-cgoettsche%40seltendoof.de>

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
---
 fs/quota/dquot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 3dd8d6f27725..a2dddffeaac5 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1281,9 +1281,9 @@ static int ignore_hardlimit(struct dquot *dquot)
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
2.45.2

