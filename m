Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC58EC021B8
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NF/YqI75d1x611JoM4l5Hi8OXTx5W/dSbiWY2k23YlM=;
  b=I/7i2JwAvvdRpebKqlMBnf01B3pqT25l7MW+9YobTLA0rQMWXPc8pHhz
   +7M4M9KnTR+mSvD5dy5q5hRH6jUMEtda2VEpOvWU66prsXVu+BlRrpuGI
   qtHWqke7vx1SpDvTs6VGHwVlu1Cjr6dAsarDSQk2snThHGy8JywMUIJtp
   s=;
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
   d="scan'208";a="211068736"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 82823E0D5F; Tue,  4 Mar 2025 10:58:41 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7910CE0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 17:07:18 +0100 (CET)
IronPort-SDR: 67c48236_xbIhsc8Cay2d6CiBqkj0xpEPl6U845nJnA1NCfmlRWESR1I
 bsmQ4Gw1MbkHbhtlU+XTAHtWx0lVXr0101SPPtA==
X-IPAS-Result: =?us-ascii?q?A0EHAAAngcRn/6Mwd6haGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgUECAQEBAQELAYJDB2kLWzQECx4qhFaPT4IhA5FHj?=
 =?us-ascii?q?E0ggV4PAQMBDUQEAQEDAQOFAAKLFQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?RABAQUBAQECAQECBAYBAoEKE4V7DYJiNIIWLIECCQIBAyMECwENAQE3AQ8gB?=
 =?us-ascii?q?QIYDgICPQEYGVuCJwGCMAEBATEDryt/M4EBggwBAQaCUNgvBAoaDYExgSAJg?=
 =?us-ascii?q?RouAYhOAYVSGYN9eicbgg2CUIItgh+Be4QEFoJTgjOBaoM9mgWOWgdhXhwDg?=
 =?us-ascii?q?W4XEoF2A4EPgUVEN4JFaUk6DzeCHoMnhE6DHYF8LwMDAwONABSEQQICg2uDL?=
 =?us-ascii?q?4I6VAwLbT03CC09CEIdEqB1OoQ6BwGBDTAdLmBlC5Mag1GvewuCP4FminiWU?=
 =?us-ascii?q?E2XU5MDiDC0RwGFNmCBDgsrgVlxgW0JCxqBG08DGQ+OIYQtyCNFMjwCBwEKA?=
 =?us-ascii?q?QEDCYI5jS80gUsB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ytfuyKlCXwkWaetetpAZJXrY5c/pDfIN3DAbv31ZSRFFG/Fw9v
 re/sjzuiWZtN98Yh4dcLO7Scq9qBHnlKKdiLN5VdzJMTUO0FHYSb2KhrGD/9SPIUPDHiQ079
 YFT0C8YOeAamST96zBkXCF+41L+qj+zEjt7t2uskuEiGlRGsddB8MQMHfhLqWwLDM2f6YEKA
 ==
X-Talos-CUID: 9a23:n1pbdmBVmur46+D6Ew1q1HJXF+QmSXTi1SntL0XnBUwuE5TAHA==
X-Talos-MUID: 9a23:lgy+RQp93cIoNBH/L7sezzxNEuFzw56/Mm8Ivo4cmti4PnIrHyjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="110429647"
X-MGA-submission: =?us-ascii?q?MDFsJbEGLIgr/EbQobT9ajlk98T0xYzUwYBNVr?=
 =?us-ascii?q?A+sRQ2kX+eLp+ez2G6XveGa4rFUNkqP4cDzf+PWk9T+ORJrcGeOfo7Ha?=
 =?us-ascii?q?Q+KPlNz24ejZelJ59qzweC3ywOu1axS9ji8aGv0V88yS4zuJ+tLrHnAY?=
 =?us-ascii?q?Lj4cpRT5fJJVDPsbjcKLxmlw=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 17:07:18 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931637;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NF/YqI75d1x611JoM4l5Hi8OXTx5W/dSbiWY2k23YlM=;
	b=MLKYd4SdfO5qik2qg/ZM3lU4zBjr8IBNR7BtbJq+86SS9zjTtf4FQlORIua8KO1wZyFvaS
	mEbMF01enB6UzQO8S/FNHd2Kcfy+xmZtQKAFIyDoU+ldXKcFr8JU1N8LUxYu0DBVE+1xKe
	A3/oQwSmFVXrYKkVCcjlcepGhrBaSB2XQu2aifDAoB2KRvU7i3gp6SMLEU4sttW1Yk3cta
	OXyELxf5MK3Q9R7AVaF7wvbw9ZVjS7PUGAICEE/8oYh8XIJ/Cv8lRzk0EGb2Bgdt+puAZh
	f7qy1HJH/M8cSYLHHn1PqS52e3NMY+K0LccSETFRFHdYJ3e0Ibzv1tK2al0Byg==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org
Date: Sun,  2 Mar 2025 17:06:47 +0100
Message-ID: <20250302160657.127253-10-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2 11/11] infiniband: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2496
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250302160657.127253-10-cgoettsche%40seltendoof.de>

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
 drivers/infiniband/hw/mlx5/devx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 4186884c66e1..39304cae5b10 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -136,12 +136,14 @@ int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user)
 		return -EINVAL;
 
 	uctx = MLX5_ADDR_OF(create_uctx_in, in, uctx);
-	if (is_user && capable(CAP_NET_RAW) &&
-	    (MLX5_CAP_GEN(dev->mdev, uctx_cap) & MLX5_UCTX_CAP_RAW_TX))
+	if (is_user &&
+	    (MLX5_CAP_GEN(dev->mdev, uctx_cap) & MLX5_UCTX_CAP_RAW_TX) &&
+	    capable(CAP_NET_RAW))
 		cap |= MLX5_UCTX_CAP_RAW_TX;
-	if (is_user && capable(CAP_SYS_RAWIO) &&
+	if (is_user &&
 	    (MLX5_CAP_GEN(dev->mdev, uctx_cap) &
-	     MLX5_UCTX_CAP_INTERNAL_DEV_RES))
+	     MLX5_UCTX_CAP_INTERNAL_DEV_RES) &&
+	    capable(CAP_SYS_RAWIO))
 		cap |= MLX5_UCTX_CAP_INTERNAL_DEV_RES;
 
 	MLX5_SET(create_uctx_in, in, opcode, MLX5_CMD_OP_CREATE_UCTX);
-- 
2.47.2

