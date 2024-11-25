Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A1CD58D69
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wEUm66qIu8PkMwOxCNnnSHqwyJubiCsERAs4lb+4vxc=;
  b=bXMWamwGxu+uymSG54DQ8UMeD7NYap//iHPzOUggsghKrzTjJ/MW9xu9
   tYNZHa+v15OfioQ7lf3W21Qx0WYssoD3IKA2PXFqG07qlJ+jjMDq2S8nV
   HXayAZ/ySrlrRpMCdlbn1hFpK6sbpN4KNHwmX429sP3voE5EIZ2iaPCw/
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@seltendoof.de
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195724397"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1853BE0DA0; Mon, 25 Nov 2024 17:57:24 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 153FBE0D1D
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 11:40:46 +0100 (CET)
IronPort-SDR: 67445421_vYHQT1fUQlpA5tj+y7duIubUW6F6Z+tgtWzz4+LnZh9odnd
 5iUo2e2Nvf8fVXbrWMp0bdZt9vrGEr5WQcBG6YA==
X-IPAS-Result: =?us-ascii?q?A0EKAAC9U0Rn/6Mwd6haGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDB2lmNAQLSIRWiB2JUQORSoxNIIFeDwEDAQ1EBAEBA?=
 =?us-ascii?q?wEDhQACilkCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QKBChOFew2CYgF0gSQBAQEBAQEBAQEnKwKBCwIBAyMECwENAQE3AQ8gBQIYD?=
 =?us-ascii?q?gICPQEYGYMBgjEBAQExA690fzOBAYIMAQEGglDYLgQKGg2BMIEgCYEaLgGIS?=
 =?us-ascii?q?wGFUBmDfXonG4INhH2CH4F7DGqDDoJpgkSBMYNeJYU3g0mbMwcHYV4cA1khE?=
 =?us-ascii?q?QFVExcLBwWBdgODRoE2KIEpgxFKhQxGPYJKaU03Ag0CNoIkfYJNhRmDRoEjZ?=
 =?us-ascii?q?S8DAwMDghOBK4YGHTcJAwttPTcIDBsGPQhCHRKgG0aDQQcBgQ0wHS5gcJMXg?=
 =?us-ascii?q?1CvbAuCP4FlinaWTU2XUZMAiC+QTKNyAYU1YIEHPYFZcYIBGoEbTwMZD44hh?=
 =?us-ascii?q?C3HFEUyOwIHAQoBAQMJgjmOTQEnDIFLAQE?=
IronPort-PHdr: A9a23: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
 50ADLNWBgRdKw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:I54nna+3ZMunqca+zn9uk+DZI+orL9Y04lQ7vn2ZhyY4TiX+rb
 HIoB17726RtN91YhsdcL+7VpVoLUm2yXcx2+ks1NSZLWzbUQmTTb2KhLGKqwEIWReOldK1s5
 0QEZSWY+eeMbEVt6vH3DU=
X-Talos-CUID: =?us-ascii?q?9a23=3Aef/hJGoEG3oYynNtG96fjq7mUfgeI0fH8nr0H0W?=
 =?us-ascii?q?XEWtDdoPMCnm9opoxxg=3D=3D?=
X-Talos-MUID: 9a23:AtMnLQVSNMAD0Mzq/G711TxPMsxy2byNC2MirYQcvvGVaRUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="195628601"
X-MGA-submission: =?us-ascii?q?MDGuXXKfTzUothvtIIaWvbMC7JNLeAcfAnWuhb?=
 =?us-ascii?q?fZdex7rh2+B2si1HLt/I3FB1ki8xJJnL33pR59F3IkvuU58+Zmt36Cgk?=
 =?us-ascii?q?aICqoStekuAmc25drpoj43uWze/u4l/cm9kB2UhQFl7Oi6bOKuezGGIp?=
 =?us-ascii?q?df3nFV/T+ZSWuXwGQDVw1GSw=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:40:33 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531232;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEUm66qIu8PkMwOxCNnnSHqwyJubiCsERAs4lb+4vxc=;
	b=htLbeYksaORg5/HvEg6PKAtZC4kv17t058Wj3CTukaT/twqcgszc31G/pliYnDXAeXwBbx
	QMLvNRwy/9JY/gwAElTZUIR+VhYroro5VjcvBj36kROIgytwGOorYZM1uE3ah7VuglSwNJ
	AJxkQfGe5n5pbNgcZ1Rwi9TZs8GGnAWKUcc1cdRJgOLc8JE647oNbHFT07b/NW6yQe/mw8
	9LPEjY1zZnx1vLvmbV8hw3+OasVI71Nk4ieD3f9NOoxnejq/Anz920QM/DOTM6uO7hcHXU
	5BCkR9dAKb3kUbIeYS+K2wGlLZ4Z+FtponRFMBmBu3IkMFi7cKP95/dBb8x2Cw==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev,
	cocci@inria.fr
Date: Mon, 25 Nov 2024 11:40:00 +0100
Message-ID: <20241125104011.36552-7-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 08/11] gfs2: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2114
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241125104011.36552-7-cgoettsche%40seltendoof.de>

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
 fs/gfs2/quota.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/quota.h b/fs/gfs2/quota.h
index f462d9cb3087..988f38dc5b2c 100644
--- a/fs/gfs2/quota.h
+++ b/fs/gfs2/quota.h
@@ -44,8 +44,8 @@ static inline int gfs2_quota_lock_check(struct gfs2_inode *ip,
 	int ret;
 
 	ap->allowed = UINT_MAX; /* Assume we are permitted a whole lot */
-	if (capable(CAP_SYS_RESOURCE) ||
-	    sdp->sd_args.ar_quota == GFS2_QUOTA_OFF)
+	if (sdp->sd_args.ar_quota == GFS2_QUOTA_OFF ||
+	    capable(CAP_SYS_RESOURCE))
 		return 0;
 	ret = gfs2_quota_lock(ip, NO_UID_QUOTA_CHANGE, NO_GID_QUOTA_CHANGE);
 	if (ret)
-- 
2.45.2

