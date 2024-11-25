Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023B7D58D6A
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jlzbf+EP4WQ9ERhB8MeGSUxEvK9pVGrKH+pSzOMuEbY=;
  b=aGq5DytI8Y2HzsfAEkr/NDDcBhu1Y//VjCKS9frjL3tW6Wlw7TnCcK82
   E38eX04umnw3IVjA4bT2EdWe3901KBtz6Qw8pM/WCj24408+prCr1AV1w
   yboyTiNronokxfnQyTUd/L4KzzJc71sPc6nfDvBFRqTMjtaw4nDeCm/GP
   4=;
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
   d="scan'208";a="195724374"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9EF6AE0D72; Mon, 25 Nov 2024 17:57:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1EFE3E0D1E
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 11:40:46 +0100 (CET)
IronPort-SDR: 67445426_hob4PDnKTIg0lODFpSbVjqIMU24O3ko3/tU1KVDtAQqpXfG
 D5aFWBAmNUku4Po8rcXjjN9nf+IDFV0/BDAAxTQ==
X-IPAS-Result: =?us-ascii?q?A0EhAAC9U0Rn/6Mwd6haHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDB2lmNAQLSIRWiB2HMIIhA5FKjE0ggV4PAQMBDUQEAQEDAQOFA?=
 =?us-ascii?q?AKKWQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAoEKE?=
 =?us-ascii?q?4V7DYJiAXSBJAEBAQEBAQEBAScrAoELAgEDIwQLAQ0BATcBDyAFAhgOAgI9A?=
 =?us-ascii?q?RgZgwGCMQEBATEDr3R/M4EBggwBAQaCUNguBAoaDYEwgSAJgRouAYhLAYVQG?=
 =?us-ascii?q?YN9eicbgg2CUIItgh+Be3aDDoJpgkSBMYNeJYU3g0mbMwcHYV4cA1khEQFVE?=
 =?us-ascii?q?xcLBwWBdgODRoE2KIEpgxFKhQxGPYJKaU03Ag0CNoIkfYJNhRmDRoEjZS8DA?=
 =?us-ascii?q?wMDghOBK4YGHTcJAwttPTcIDBsGPQhCHRKgG0aDQQcBgQ0wHS5gcJMXg1Cvb?=
 =?us-ascii?q?AuCP4FlinaWTU2XUZMAiC+QTKNyAYU1YIEHPYFZcYIBGoEbTwMZD44hhC3HF?=
 =?us-ascii?q?EUyOwIHAQoBAQMJgjmOTTSBSwEB?=
IronPort-PHdr: A9a23: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
 pYDGOczaQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:YKWT1q/2unceiCsPBaluk+C3I+orL9Y04lQ7vn2ZKCY5TiX2ra
 CTdZgguiMc6wx8ZJhfo7u90cC7KBu3yXcf2+gs1NmZMjXbhA==
X-Talos-CUID: =?us-ascii?q?9a23=3Ass/LCGgMHrXgWnSaGtcDt/bBzTJuTG389nzbEV2?=
 =?us-ascii?q?BAjxEa7OXSgavwIE0nJ87?=
X-Talos-MUID: 9a23:wFToMwYBvMOtFuBT9APrjy9GLJlUubWyLkpdqbYgluCjKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="195628636"
X-MGA-submission: =?us-ascii?q?MDFtbaYwGeWO2qrbviQldDEOflsz4J98Amt7yK?=
 =?us-ascii?q?3JTe4Q5PQnp2Vp2IrZSpk1jFt7yIi2zmXS4IgO8CCCLbRj3ChuMjm7Dr?=
 =?us-ascii?q?dJpZNobKvJK6LkF3Z7xq3mvtS+v2lXomoDTlmz7lxIOJwxKhUeEqWcK8?=
 =?us-ascii?q?BnEV4WDsaWOfrr5TNE2BgeNA=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:40:38 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531237;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlzbf+EP4WQ9ERhB8MeGSUxEvK9pVGrKH+pSzOMuEbY=;
	b=egFZ8oIa6Adyyq1lI/k2/7m4vxLRXLRn+Wt3Rqrnhzb3SfQ5501wiHrxZ5Hh82c9pnpMXM
	tYFM+X7VOO2MvY1lLyNSYdDsqdtL+pJRt3Q8+mM/LBcLLRFnb7XdJ1KQa5kGg/oCpQO9di
	bCgKaiQoeHAmqvvLNsihH1RYfcsOPEbEktZ8DrpivnKmA7oW295+etWpuflxh+/+m2mC8h
	JcHrixMYoiM89hrRnhz70aBFe5JJjrUZLCIRNJ5f+wt+8IJKX2gBONy56XdMKZzRYkhxLx
	sRNOVGL1GBxGIPYLf8SztrzZNZb5E37pWOmFQDg7gpMMuxzx91L1/e8x2hR+ug==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	cocci@inria.fr
Date: Mon, 25 Nov 2024 11:40:03 +0100
Message-ID: <20241125104011.36552-10-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 11/11] infiniband: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2113
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241125104011.36552-10-cgoettsche%40seltendoof.de>

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
2.45.2

