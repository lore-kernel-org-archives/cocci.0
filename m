Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7901C021B8
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LtVFyKPYvAG6nPAlnlSRsIED7/Fit5RjlOi+m21VZYs=;
  b=esRz/xfU9NPkJwJx7srwG6yj3dRDDSjqOTEm6j+ILJs3s73rC/t5SElN
   901lDjotDJ6RSiboEk1u5DOtVpwRcty1c5fX8KHDnPmutG0o4sW5D1UUz
   +p09PSzbYk3zp5TmpFo9uXfUpXXS7exs7TE5po29gF/uufybO7/DplZZ6
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@seltendoof.de
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211067644"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 231A4E0D1E; Tue,  4 Mar 2025 10:58:38 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1044EE0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 17:07:06 +0100 (CET)
IronPort-SDR: 67c48229_lyMfhsdO0ZqLpYl8rgN81C6mSV1CFITgJyO4YMwtDISmud7
 EfqyLRrcJFTF4XYeqfUDYV8C2RAPbTLkeyyyxAQ==
X-IPAS-Result: =?us-ascii?q?A0EHAAAngcRn/6Mwd6haGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFABAEBAQELAYJDB2kLWzQECx4qhFaPT4IhA5FHjE0ggV4PA?=
 =?us-ascii?q?QMBDUQEAQEDAQOFAAKLFQIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBARABAQUBA?=
 =?us-ascii?q?QECAQECBAYBAoEKE4V7DYJiNIIWLIECCQIBAyMECwENAQE3AQ8gBQIYDgICP?=
 =?us-ascii?q?QEYGVuCJwGCMAEBATEDryt/M4EBggwBAQaCUNgvBAoaDYExgSAJgRouAYhOA?=
 =?us-ascii?q?YVSGYN9eicbgg2EfYIfgXuEBBaCU4IzgWqDPY5ciCGDCI5aB2FeHAOBbhcSg?=
 =?us-ascii?q?XYDgQ+BRUQ3gkVpSToPN4IegyeEToMdgXwvAwMDA40AFIRBAgKDa4MvgjpUD?=
 =?us-ascii?q?AttPTcILT0IQh0SoHU6hDoHAYENMB0uYGULkxkBg1GvewuCP4FminiWUE2XU?=
 =?us-ascii?q?5MDiDC0RwGFNmCBCQE6gVlxgW0JCxqBG08DGQ+OIYQtyCNFMjwCBwEKAQEDC?=
 =?us-ascii?q?YI5jS80gUsB?=
IronPort-PHdr: A9a23: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
 daJmK+hcF+qHPrP8M8ACs7YL8WJdnYsY0OBJQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:0XqHh64t3lCSYbmcEwPXwOnXdLJyesId70hD6qkRc202TiX2ra
 yTdZgguiMc6wxhO03I++rgBEDoexq1nvQZ3WB4B8bGYOCMgguVxe9Zg7cLCVXbaknDHi0079
 YGT0AFYueAdGST1qzBkXGF+5JK+qj7zEhs7d2uqUuEiWlRGtpdB8AQMHfgLnFL
X-Talos-CUID: 9a23:0Bi/gGytXG0NlTlyyLZKBgUJCOkjflnX803rDFaoWHxoYr6oT3+frfY=
X-Talos-MUID: 9a23:kuoR5gbou9HQYuBTrWPJ2hBJZcVR3amsJBwnqrwAv/aeKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="110429638"
X-MGA-submission: =?us-ascii?q?MDGXiFAKCdqCnlv+3a05t1LhVxi+A1Uxb8yBas?=
 =?us-ascii?q?7pI6xq9r1wlY+/rMFUY4nA+rhj32Un80Kka8fJbAazkYeYVM2LXjHHkI?=
 =?us-ascii?q?2QwHxoquKmQYbB9mkYDOj0Y/tBKL97HnuYcAQHh51rHOaiVrqoGyYoHV?=
 =?us-ascii?q?b9K0rUKQRqtRF+ALmf/ougtA=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 17:07:05 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931624;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LtVFyKPYvAG6nPAlnlSRsIED7/Fit5RjlOi+m21VZYs=;
	b=rW723r6bWSv6qn26AEbrStX87CkVu9G/7vNGrh7xh7Lqn7pp5kWJbhTClYidy6wk+Y+7sd
	FjPR7nS2CFldQESu5vxVqQRKbzDULfHYgaqGYBjNrElC8Jp/+8E5Ctfj1Nv59jeyJqvS98
	yhpZrwB0FKmtPiiVuoqWjkBdcS/5eOoj5FPfR9gm5C7XWNjjza4nuEYR9IxTQ0lpuWjwCZ
	e+OlRPH2PFwomxohnhpClrlM995TmC9Xbrwm+7wdfa0h0OYtxXTqP8FO7MHjgM164WRD/j
	93uAuVblah5062CFYFw/SQT9UgQc9mpRBtCUpTLTwBR1k7kbipwv85mDQlL9vg==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org
Date: Sun,  2 Mar 2025 17:06:39 +0100
Message-ID: <20250302160657.127253-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2 03/11] ext4: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2488
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250302160657.127253-2-cgoettsche%40seltendoof.de>

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
 fs/ext4/balloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 8042ad873808..c48fd36b2d74 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -649,8 +649,8 @@ static int ext4_has_free_clusters(struct ext4_sb_info *sbi,
 	/* Hm, nope.  Are (enough) root reserved clusters available? */
 	if (uid_eq(sbi->s_resuid, current_fsuid()) ||
 	    (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) && in_group_p(sbi->s_resgid)) ||
-	    capable(CAP_SYS_RESOURCE) ||
-	    (flags & EXT4_MB_USE_ROOT_BLOCKS)) {
+	    (flags & EXT4_MB_USE_ROOT_BLOCKS) ||
+	    capable(CAP_SYS_RESOURCE)) {
 
 		if (free_clusters >= (nclusters + dirty_clusters +
 				      resv_clusters))
-- 
2.47.2

