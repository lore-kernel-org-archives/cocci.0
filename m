Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B930410ED656
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2026 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=mUSN1aFy70IRQtO7gSJiwBge5xnWJ5yn2BxfhJqvJBk=;
  b=jd9tftaswFAWyc+IYsS/JVCoP6DYLSYL3IDlAG+pcRVR/XayzdoAuzD6
   aniNoMqaypd8jCdQMKAfnRH5bRmsRquOUUxRVi1T51dqNX8WovLAoIFku
   PUBuz7TNYL3T2SmAmjVqdAc//Y87PdErg+H8iU7Zv5DUndptxsg00os3l
   A=;
X-CSE-ConnectionGUID: +hgYKuQtQQi7MlunaprgJw==
X-CSE-MsgGUID: qvdrsUDCRhqqEqSBxppa1g==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,144,1770591600"; 
   d="scan'208";a="269791422"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2026 11:51:06 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 08E8081923; Fri, 27 Mar 2026 11:51:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1F8A2824B5
	for <cocci@sympa.inria.fr>; Fri, 20 Mar 2026 18:51:33 +0100 (CET)
X-CSE-ConnectionGUID: zY+vpMi9T06OBakXL/7yiA==
X-CSE-MsgGUID: L0ZiYxurTBy4Hzjt7/N9lw==
IronPort-SDR: 69bd891a_7wHlZCc7a9FoY5SkhPfHItJmDXzy+W2XFfaCMB04trQz53S
 xD/FzHxbQeUQmVbbgqmixm1zFSHaMt1TH2BO8Uw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EcAQCyiL1phR/86qxaglmCQRaBUDMEC0mNU6cWgX0CD?=
 =?us-ascii?q?wEDAQ1RBAEBAwSFAI0mAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBAQFASYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAg2BA?=
 =?us-ascii?q?DYBDQEBNwGBPBODAoIjB0oDsVSBAYIMAQEG3CqBZAECCRQBgTiFb4dohHSBI?=
 =?us-ascii?q?RuCDYEVMoM2hFiGL4M0kmZIgR4DWSwBVRMNCgsHBV6BCAM1EioVbjIdgSM+F?=
 =?us-ascii?q?4EMGwcFgz4PiHGBYYEThCYDCxgNSBEsNxQbBD5uB408O4I0gQ6CKZQhkgKhD?=
 =?us-ascii?q?oQmgWSfdBozgUuWB5MYAS6YWKNjdoRogWkBOIFcMxoIKAiDIk8DGQ+OOoh6w?=
 =?us-ascii?q?U4jNT0CBwIHDQMLkhyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:xMTnCKpURJYnQAjnc0w67ZkaV5oIeYIsimQD101hICG9vPb3qy
 nIpoV86faQslsssR4b+exoVJPtfZq+z+8R3WBuB8bAYOCOggLBR+tfBODZogEIdReQysdtkY
 ptbKR6DsT9FhxZgdaS2njeL/8QhPSK76ysg/7T1DNWTQ9sY7x99AsRMHf+LqQPfnglOaYE
X-Talos-CUID: 9a23:gP6Bk24SQ3ir8UEPcdss5n9XBNgAcyzhlCn3CUa7OUIuF6yUYArF
X-Talos-MUID: 9a23:ETm+eghhy5s+HlT6cXUVG8MpEJ9a4pW+FVoxu4Ram9uGKXM3HWaZk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,130,1770591600"; 
   d="scan'208";a="141922783"
X-MGA-submission: =?us-ascii?q?MDELoXt+CsprCY85jCygNUsNxurDlbRE+Nxreu?=
 =?us-ascii?q?kglXcfrhQSs0YcPXENbXefep6+0vULYXF4Uq9Dm0A9Ck8SyYPyo/EgGf?=
 =?us-ascii?q?fwKwl3aAFvlwf1F8w8rrbk5a4PdDFTtXvKXjHf2LAtXw8gXjdzEp6dm1?=
 =?us-ascii?q?SY5eyrNIOrkQqEeQjppbAOpw=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 18:51:22 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ACD2E43AD3;
	Fri, 20 Mar 2026 17:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8568AC4CEF7;
	Fri, 20 Mar 2026 17:51:19 +0000 (UTC)
From: Kees Cook <kees@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Kees Cook <kees@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Date: Fri, 20 Mar 2026 10:51:18 -0700
Message-Id: <20260320175113.work.016-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=kees@kernel.org; h=from:subject:message-id; bh=5zBHZBiRQnxI63nFpcUxKUAqSHpyESQ+S3fdO2jglgU=; b=owGbwMvMwCVmps19z/KJym7G02pJDJl7O0VnVyr17zb+ni6ta+Cw/PnHTseFs1nvH+QpnFnv0 8+83/51RykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwET2z2H4wxNdcGBfowfv9fUB k379aGqfdeLxj3rF0scPT87btbQwKJvhn0FV9clPH4Jl3/h9TYvcp9s87UHUJd76p6smuwSt38L 9kxcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH] coccinelle: kmalloc_obj: Remove default GFP_KERNEL
 arg
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3462
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/bENmBWtGPO-uYpTxxRKuqA>

Remove any GFP_KERNEL arguments found in the new kmalloc_obj-family
helpers. This captures the script used in commit 189f164e573e ("Convert
remaining multi-line kmalloc_obj/flex GFP_KERNEL uses").

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: <cocci@inria.fr>
---
 scripts/coccinelle/api/kmalloc_objs.cocci | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/coccinelle/api/kmalloc_objs.cocci b/scripts/coccinelle/api/kmalloc_objs.cocci
index db12b7be7247..e9a415b7b6f4 100644
--- a/scripts/coccinelle/api/kmalloc_objs.cocci
+++ b/scripts/coccinelle/api/kmalloc_objs.cocci
@@ -122,3 +122,14 @@ fresh identifier ALLOC_OBJS = script:python(ALLOC_ARRAY) { alloc_array(ALLOC_ARR
 -	ALLOC(struct_size_t(TYPE, FLEX, COUNT), GFP)
 +	ALLOC_FLEX(TYPE, FLEX, COUNT, GFP)
 )
+
+@drop_gfp_kernel depends on patch && !(file in "tools") && !(file in "samples")@
+identifier ALLOC = {kmalloc_obj,kmalloc_objs,kmalloc_flex,
+		    kzalloc_obj,kzalloc_objs,kzalloc_flex,
+		    kvmalloc_obj,kvmalloc_objs,kvmalloc_flex,
+		    kvzalloc_obj,kvzalloc_objs,kvzalloc_flex};
+@@
+
+	ALLOC(...
+-		 , GFP_KERNEL
+	     )
-- 
2.34.1

