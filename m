Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DC4D58D6B
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=g0u/9xnJFmCzCIsRXywH2TwoCekIvWc3+cszQ3gofsI=;
  b=XqzM8GhlV1GFdkV6kyUC9FkoQhpZ1r/N3NxXYWDYrEuBsz3oVCYrxDfi
   /S0pu4xpN5PoBsZd29+lErIpj+XTJc3ciQ2JY+Low7f085WV/BPLG2Skw
   Ij4ZXSZt9HNaYSzfHA6I2gPJWYSvAcnkqY8I3yYVYo3wmEtGs+mtJf1gh
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@seltendoof.de
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195724099"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AB881E0D1D; Mon, 25 Nov 2024 17:57:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4FC32E00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 11:40:26 +0100 (CET)
IronPort-SDR: 67445419_jVeb8GhS+x0YmngJRfWzOnNBkDgxGk2vStmLO6jYuTzyRlc
 iP6H/pFVmlsbKEqvc5Q4I0N5KjvG58EAzwC5Pfg==
X-IPAS-Result: =?us-ascii?q?A0EhAADMUkRn/6Mwd6haHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDB2lmNAQLSIRWiB2HMIIhA5FKjE0ggV4PAQMBDUQEAQEDAQOFA?=
 =?us-ascii?q?AKKWQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAoEKE?=
 =?us-ascii?q?4V7DYJiAXSBJAEBAQEBAQEBAScrAoELAgEDIwQLAQ0BATcBDyAFAhgOAgI9A?=
 =?us-ascii?q?RgZgwGCMQEBATEDr3J/M4EBggwBAQaCUNguBAoaDYEwgSAJgRouAYhLAYVQG?=
 =?us-ascii?q?YN9eicbgg2EfYIfgXt2gw6CaYJEgTGDXiWFN4NJkA+LJAcHYV4cA1khEQFVE?=
 =?us-ascii?q?xcLBwWBdgODRoE2KIEpgxFKhQxGPYJKaU03Ag0CNoIkfYJNhRmDRoEjZS8DA?=
 =?us-ascii?q?wMDghOBK4YGHTcJAwttPTcIDBsGPQhCHRKgG0aDQQcBgQ0wHS5gcJMWAYNQr?=
 =?us-ascii?q?2wLgj+BZYp2lk1Nl1GTAIgvkEyjcgGFNWCBBz2BWXGCARqBG08DGQ+OIYQtx?=
 =?us-ascii?q?xBFMjsCBwEKAQEDCYI5jk00gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:W2LBaK1UC6ePr/Vp5zWyOAqjBLMkLtp133Aq2lEZdPWaSKClfq
 eV7ZMmPH7P+VIssRQb8+xoV5PvfZqxz/VICMwqXYtKPzOW3VdATrsC0WKK+VSJJ8S9zJ8/6U
 4HSdkdNDSaNzdHZKjBjTWFLw==
X-Talos-CUID: 9a23:HDW7Rm7aOaFjhxU3ldss3mQPQ/EpSWLm6UzRIhGdE01ibrS7YArF
X-Talos-MUID: 9a23:JHfZDAl5iPCi7PUHCvk4dnpfMcAz5bihM3kHiIQvl8KEbQhTYBWC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="102546514"
X-MGA-submission: =?us-ascii?q?MDHO0vEB/JUhRrE0p5eHtm+6qt9LL8LWTHpmwK?=
 =?us-ascii?q?0x1JvAq7TiQkFiOW8t1mkhzJa0fwupnEUQy1JmKB1mg702igSMsyhP9M?=
 =?us-ascii?q?NhRTOFfon1lAX3nzIrYEnHPR0kksUId8UqGXT/KJDNWM9NlmRCTeHilH?=
 =?us-ascii?q?HV9qS26O4eQiSW5zS2Es3o7g=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:40:25 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531224;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0u/9xnJFmCzCIsRXywH2TwoCekIvWc3+cszQ3gofsI=;
	b=nqGJcLfQpuCPVU4svGCFemBiN+Nqp+1R16Nvd1Z8RvKusipz8MFxJLNdU2uhjFvntoOYSb
	Xj1L3BtASdJeevaSB18S7Dl4G9iVy2NeKuB5bVvlEQ/00Zw4mWcB4rc9Y8T8msyZ1lYG1X
	9EFJuwkmLAYq+yC2ipfy3AxGyZxlF/Jc9QDPrMphpZ2z7VT/m3D7jllOSk539ISoY/tFbc
	kSn7Zr8qrh9mhI/pb9WE7RVtWlm2DpAmQRLqFEX0I9t3ojiACy+XuvtER8YjGVp+0wWSGE
	NlMPqw/DtS7g8Ao5UdD3jNlwW46B8Yn6PoWxwEILbI/QoEnLV0D9q/lx/AKSKA==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	cocci@inria.fr
Date: Mon, 25 Nov 2024 11:39:55 +0100
Message-ID: <20241125104011.36552-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 03/11] ext4: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2104
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241125104011.36552-2-cgoettsche%40seltendoof.de>

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
2.45.2

