Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D31CD98CF
	for <cocci@archiver.kernel.org>; Tue, 16 Jun 2026 08:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=LBk3rX3WP5dotCmPFmOLO7HkV+FMEvshYwSSQQ40Gj0=;
  b=kFU1AP2W/YYEuFULPruYFJgTnzFZ+03l9KVaODBvB9qsUJD0Nmoqphf6
   oWKiqZeZ8D7N+ThP/jALC7/zICjzGiqMu3guXyc5jc+M79kcYezWBhc7e
   9FiLQ2Ztnw36+oC0pqW5kmcCH7tcfb4kt4s6CUpikH6wpLU2wbJjUmztb
   M=;
X-CSE-ConnectionGUID: WZi4Alz5TxedbhwaLRkxsw==
X-CSE-MsgGUID: qlkGlrBkTe2BOymhfMYbfg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.24,208,1774306800"; 
   d="scan'208";a="281759289"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jun 2026 10:45:43 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1A65D817B0; Tue, 16 Jun 2026 10:45:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2683E80D1D
	for <cocci@sympa.inria.fr>; Tue, 16 Jun 2026 04:10:49 +0200 (CEST)
X-CSE-ConnectionGUID: ipsbmIR5QcSMvVVvPW+Sng==
X-CSE-MsgGUID: llgNuLDPQC2+n56YQVQYcQ==
IronPort-SDR: 6a30b0a8_y5jFuzxrreTQytiTAHv5u3/Lvggc291etQ5Q4VfWMceL7Vd
 4vibZDXTDYQljo0dbcAX+zUyuZpBa2Ay9U9IK+A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EEAgDZrzBqgxEsKNhaHgEBCxIMhFGBaDEDBwhJjVOhO?=
 =?us-ascii?q?YdcDwEDAQ1RBAEBAYUFjUMgBgEENBMBAgQDAgMBAQEBAQEBAQEBAQsBAQEEA?=
 =?us-ascii?q?QEBAgEBAgQDAQEBAQIQAQEBATkHSYZcgmIBhAI2AUaBPQESgwKCdAMFtl+BA?=
 =?us-ascii?q?d5DgWcLFAGBOIVxh22BOIR6P4FOgRUygzeLCASCIoEMgXiPG0iBHgNZLAFVE?=
 =?us-ascii?q?w0KCwcFgWYDKgsSEhgVbjIdgSM+DwiBDBsHBYEegg+BBYUPIx8DOX+Bb4ElZ?=
 =?us-ascii?q?2YVMDWBAQERHwo6AwsYDUgRLDcUGwQ+bgeMZRcPgjYHWDaCKZQhj2OCIaEPh?=
 =?us-ascii?q?CeBZqBChASmZwEuh2aQdCOCNqELDmiEaAGBfiOBXE0jFYMiUAMZD44qAw0Jz?=
 =?us-ascii?q?BcnMj0CBwIHDgMLkhyBSwEB?=
IronPort-PHdr: A9a23:MD7LQhU/MyAf1payHWy0qh3H+hPV8KwEXDF92vMcY1JmTK2v8tzYM
 VDF4r011RmVBtids6oP0bCO4/qoGTRZp8ra7DZaKN0EfiRGoPtVtjRoONSCB0z/IayiRA0BN
 +MGeXlbulqWCgxrIvv4fEDYuXao7DQfSV3VPAtxIfnpSMaJ15zkn++99IfObApWmTGzfa19L
 AmsrQXWq8IanZZuJrw+xxbHonZEYfhayX9nKV6NgRrw+sS98IB++ChUp/4t6tRMXKr0cqk3V
 7BUECgqP2Uo78D3qBfPSheC6XQbXmgKiBRDHhLL7Av9Xpf/syv6svRy1SyHNsDoTr46RCqv4
 b5zRBHnkCkIOCc1/X/YhMJtlK5Urw6vqBJ5w47PfYGaL+F+cb/HfdMbXmVOQMBcXDFcD4ymb
 osPC+0BPftEr4T4ulADoweyCRWqCejy0TJDmGP40rMm3OQgCQHG3RIvH9QSsHTPsd75ML4eX
 f2pwKXUyDnOae5d1zXg54jSah0voe+CUKxtf8TfykchEAzKgFqLpID5PD6YzPgBvnKH4+Z8U
 ++klm4pqxt2ojiq3soijo7JiZwIwV7e6yp52po6Jd2mR05gfNWpF5lQtyaEOIZtWsMtXXtot
 zo6yrIYop63ZjQFyJMixxPGbfGMboeH7A75WumLPTd4mGxqeKi5hxuq7ESs1uLyWMew3VtXs
 CdIkdnBu3EC2hDN5MaKRedx8Em/1DiA1Q3d5eBJL04qmKffKJMt3LE+m5QXvEnHACL7hEP7h
 7KVeEU84uWk9fnrb7T8qpKTK4N4kA7zP6s0lsCiA+k1NBUFUXKB9uSmzrLj+FX0QLVUgf0yl
 anUqIraKtofpqGjAw5ZyIYj6xGkDze6ztsXgGcILFdfdxKGi4jlIU3BIPf9DfunglSslilkx
 +zeM7H/H5nAL2LPnbj9cbpn5ENRxxA/wc1d6p5MD7EOOvPzWkv/tNzCCR85NhS5w+TgCNpjz
 Y4eQXyAArWFP6PSr1CI/fgjLPWLZI8QoDr9MeQq5+byjX8lnl8QZa2p0oEZaX+iGvRmJ16UY
 HvtgtcECmgKpBAxQPbriF2ESz5TZmy9U7gy5jEhEI6mF5vMRpixgLyd2ye2BoFZZmdaBV+QE
 HflbJ6EWvcJaCKKOMBtiD0EVb67S48gzx6irgH6y6B/IurS4SIXrYjj28Rt5+3PiREy8iR5A
 9qF32GCUW50mWAGSSUu0a1hvUFx0k2D3rZmg/JbD9Je/+hJUgImNZ7E1ex1FdTyVRjBf9uVV
 FqqX9erDSsxTtI22N8Of1hyFMi8gRDGxSWqArsVm6aXC5wz96LQx2X+J8V8y3bDzKQvl1YoT
 cVRO2O6mqNx8RDfCJPMk0qDjaalabwR0jbU+mmbwmSCpFpYUBZ+UajdR34SelbYo8nh6kPZV
 7+uB6woMgtfxs6GLatHcsfngElbSvn+a5ziZDeegWq/TTWojueDdofleGU12CTbFVgKlB0V8
 X+aNA84QCC7rDSaRDhvE0//JkDh6+9zrFulQUIuiQKHdUts0/yy4BFGq+abTqYx2b9MgCo7o
 DV5Bx7p3dXbI8KNvQFhcb4aatQ4tgQUnVnFvhBwa8TzZ5tpgUQTJkEu5xuGP3RfD4xBlZNvt
 3Y21E9pLrre1lpddjSe1JS2O7vNK2C08gr8I7XO1AT419CbsrwK9Ox+s0/q6QOuG2I6/m9s0
 9ROlXCb48aCFxIcBKr4SV1/7B1mv/ffayg56ZnT0ChuNqScqjLY0NIkH60uzRPzN8xHPva8H
 RTpW9YfG9DoKOEunA2xaQkYOelJ6KMuF9mrc/KXnq6sJ/ptkD+jhGVDpot61ypg7gJaTejFl
 9YAyvCchU6cUivkyUymqobxkJxFYjcbGiy+zzLlDchffP86e4FDEmqoL8Cto7c2z5fwR35V8
 kKiDFIayYeofxSVdVn0wQxX0wwev3WmnSKyyzE8nSsuq+KT2ynHwuKqcxRiWCYDRm5vpU/hO
 4O0gstcV0+tLkAomBaj+Ufm1v1Dvq0sZ2LXQEpOY233NzQ4C/X26uLEP5IJscx71EcfGP6xa
 l2bVLPn9h4T0ie4WnBb2Ch+bDay/JPwgx19jmuZand1tnvQP89qlnK9rJTRQ+Bc2j0eSWx2k
 z7SUxK+ONSB5diOnJfOqaa1UGfrBdVDNDLmy4+Nrn7x52pnKQWyhfuzl8ahGg8/m3yetZEiR
 WDDqxDyZZPu3qKxPLd8f0VmM1T77tJzBoB0loZYaIg44XEBnd3V+HMGlTy2KtBHwefla2JLQ
 zcXwtnT6Qyj2Ut5L3vPyZirHnmax8JgYZG9bAZ0kmo/6M1iEKqO57xJhm1+pV/woQ/KYPd7l
 ysQ0rN0sSBc37lP5FZrl3rVC6taBURCOC3wixmEp8uzqqlafifKE/D41UZzm8ygEKDXpwhdX
 HjjfZJxVSR078h5LBfNyCips9+iJIGWMY5V70LH9nWIx/JYI58wiPcQ0C9uOGam+GYg1/Z+l
 ht2m5ezoImALWxpuqO/GB9RcDPvNKZxsnngi7hTmsGO0sWhBJJkT38JW5bAVf+yGzIfrrLsM
 APEQ3Us72yWH7bSB1rV6kBrh2rCCZurOmrRL34ch4YHJlHVNAlUhwYaWy8/l5gyG1WxxcDvR
 0x+4ygY+l/yrhYfgvItLRT0VX3T4Ru5cjphAobKNwJYt0sRgiWdedzb9O94GDtUu4GsvBDYY
 HLOfBxGVCkIQhDWXQm9eOX2o4WctbDfXLb2OfLKZf/mRfV2b/6T3trv14Jn+23JLcCTJjx5C
 OV93ENfXHd/EsCfmjMVSiVRmTifJ8KcoR69/GVwoKXduLzzXxnz4IKUF7ZIGc9i/xmnx6eEL
 PKdiCt8IDdckJgLwDfExaMe01gblyx1P2P0T/Jc7WiREOSJxedeFHt5I2trOdFN7r4g0wUFI
 sPdht7vl/Z5gvMzF1ZZRAnhl8WuNoQBJ2CwMk+CBV7ebu3YY2GThZ2rJ/rjGtgyxK1Ouha9u
 CiWCRrmNzWHzHzyUgy3dPpLlGedNQBfv4e0dlBsD3LiRZTocE7eUpc/gDsozLkznn6PO3QbN
 G02cURAhqWd9yhYj+45EGtEpCkAT6HMi2OC4u/UJ4xD++NsGThxnvlG7W4S0bZR5TACRPtuh
 Cbeo9tnolXgme6KgGkCMlIGunNAg4SFul9nMKPS+8xbWHrKyxkK6H2ZFxUAo9Y2Qs2qoa1bz
 cLD0b7iMDoXucyB5tMSXoKHTaDPeGpkKxfiHyTYSRcIXSL+f3+KnFRTybmT7iHH9MFk7MS03
 sZSDOccDgB9F+tGWB48QppeeNErBHV81uTH6axArXum8EuPGIML7tabDLTKRq+zYDeB0esaO
 11ZkfWjc8JKacX6wxAwNAU8zdSMQBSWBIEowGUpbxdo8hsRtikuCDZtnRi6IgK1vC1NSbjlz
 lht1E0kMaN2rX/t+wtleAaM9Xt2zBZ3wZK/3VXzOHbwNPviA90QWnqy7BZ3acu8GFw9bBXuz
 xY9anGYH/QK0/0xMjsxwA7E5ckRRbgNHOsdPEdWnbbNO5BKmRxKoyGjjyevBMPfBJ9rhU0qd
 oWwon5N3gtiaJg+IqmCfcKhK3BIi7iFviKzkOs2xV1GT67i2HufYiUItVdOPb4jdXPAww==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Y7r12KOyv8Tg8cBcTkujsMiBIKoaSvp037Dk7S9MoHtuA6mlfq
 +V/cjzuSWYtN9zYgBDpTnjAsm9qBrnnPYfi7X5Vo3NYOCJggeVBbAnzKen5zH8E0TFh5Ng/J
 YlUoQ7NdX/ZGIK9/oSmDPIcOoI8Z296rmhgeqb92tgUQ0vS6wI1XYBNi+rVnZtXQFDCN4CGI
 GC6tEvnUvHRV0nKv62HGMEWe+Gh/CjruOcXTc2QyQq8hOPizTtzLbgERSCty1uKw+n341Sll
 TtokjC+62/98u6xBjVynPJ4/1t6b/c9uc=
X-Talos-CUID: =?us-ascii?q?9a23=3ArQtslGmerKSnuYteQ2jU/Xp4NnTXOXzF133VAnX?=
 =?us-ascii?q?lMG1SbaOrd0Gox+BflcU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AI+Hr/w4yroFZlwxiMxmq1gnFxoxs56uIFWQhqaw?=
 =?us-ascii?q?t4YqCaHJBAgmkvT+OF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,207,1774306800"; 
   d="scan'208";a="149529013"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHsd9U/p05ldNjpZZb2RE52kIiFk/U86WuFs4?=
 =?us-ascii?q?Z5E4uJyMKhkP8HewRslVJftnDcpgqyZFsBTfEBNgqqf2VSQYqyUC6JeC?=
 =?us-ascii?q?uCSw6FOKY3UhI4VrVkLZLqfIu9YwMeR5lIhVx5Y0EhhlgKnee9Fd67dD?=
 =?us-ascii?q?4EsZ8oXN9TPLYil0eNwpqIsg=3D=3D?=
Received: from smtprelay0017.hostedemail.com (HELO relay.hostedemail.com) ([216.40.44.17])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 04:10:47 +0200
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 741E11C1CDD;
	Tue, 16 Jun 2026 02:10:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 195662002C;
	Tue, 16 Jun 2026 02:10:41 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	driver-core@lists.linux.dev,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr
Date: Mon, 15 Jun 2026 19:10:39 -0700
Message-ID: <eed0c57a2c897e34d411229c3de41c5402791894.1781575297.git.joe@perches.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: ezyiduz3r4o6zigfgm3b41bxcdbk4kmm
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 195662002C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/S7s3uTDrspAEECRY5e3QwscfCVSirI1U=
X-HE-Tag: 1781575841-140553
X-HE-Meta: U2FsdGVkX1/tvojikqxp7bcJdKh2RLorXKPMW6+DRie8nXFD+L92k658r5d2cUcoRGAE4tuxH0yivxRQq8k8SiEMPS+tvRNqRmKSZlmRzCWkI1yjb8ZDtAYZPxNDjo/LiZE4CdXi/0F05mWmgrmq7GYpjcxSoPrYGwNwF0AFi4k2tII7C3tix6ke/WYac5DAizeADiSlPIPWbjUlP628KNsgUEfXcnaKj9LloHpWKTFpkW3A2nwHFDvfVORJ7yBN3eBrc71C7gsp0xeCRL/UCwxpdXYpS6jWLliA8pIW5+0TdqGOY0phTC6pgG0J9IcMhBCNZDykifQ=
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH] coccinelle: Add devm_kmalloc_objs conversion script
Reply-To: Joe Perches <joe@perches.com>
X-Loop: cocci@inria.fr
X-Sequence: 3578
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/H8fyskmk5icawTnBhaypTQ>

Like commit bdc5071d7f7b ("coccinelle: Add kmalloc_objs conversion script")
with commit 1c7bbaeed110 ("coccinelle: kmalloc_obj: Remove default GFP_KERNEL arg")

Finds and converts sized devm_kmalloc-family of allocations into the typed
devm_kmalloc_obj-family of allocations.

Signed-off-by: Joe Perches <joe@perches.com>
---

Maybe this might be useful to run and apply just prior to some -rc1

Lightly tested but directly copied and modified to update the devm_ uses

 .../coccinelle/api/devm_kmalloc_objs.cocci    | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 scripts/coccinelle/api/devm_kmalloc_objs.cocci

diff --git a/scripts/coccinelle/api/devm_kmalloc_objs.cocci b/scripts/coccinelle/api/devm_kmalloc_objs.cocci
new file mode 100644
index 0000000000000..322f79a2d9654
--- /dev/null
+++ b/scripts/coccinelle/api/devm_kmalloc_objs.cocci
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use devm_kmalloc_obj family of macros for allocations
+///
+// Confidence: High
+// Options: --include-headers-for-types --all-includes --include-headers --keep-comments
+
+virtual patch
+
+@initialize:python@
+@@
+import sys
+
+def alloc_array(name):
+	func = "FAILED_RENAME"
+	if name == "devm_kmalloc_array":
+		func = "devm_kmalloc_objs"
+	elif name == "devm_kvmalloc_array":
+		func = "devm_kvmalloc_objs"
+	elif name == "devm_kcalloc":
+		func = "devm_kzalloc_objs"
+	elif name == "devm_kvcalloc":
+		func = "devm_kvzalloc_objs"
+	else:
+		print(f"Unknown transform for {name}", file=sys.stderr)
+	return func
+
+// This excludes anything that is assigning to or from integral types or
+// string literals. Everything else gets the sizeof() extracted for the
+// kmalloc_obj() type/var argument. sizeof(void *) is also excluded because
+// it will need case-by-case double-checking to make sure the right type is
+// being assigned.
+@direct depends on patch && !(file in "tools") && !(file in "samples")@
+typedef u8, u16, u32, u64;
+typedef __u8, __u16, __u32, __u64;
+typedef uint8_t, uint16_t, uint32_t, uint64_t;
+typedef uchar, ushort, uint, ulong;
+typedef __le16, __le32, __le64;
+typedef __be16, __be32, __be64;
+typedef wchar_t;
+type INTEGRAL = {u8,__u8,uint8_t,char,unsigned char,uchar,wchar_t,
+		 u16,__u16,uint16_t,unsigned short,ushort,
+		 u32,__u32,uint32_t,unsigned int,uint,
+		 u64,__u64,uint64_t,unsigned long,ulong,
+		 __le16,__le32,__le64,__be16,__be32,__be64};
+char [] STRING;
+INTEGRAL *BYTES;
+INTEGRAL **BYTES_PTRS;
+type TYPE;
+expression VAR;
+expression GFP;
+expression COUNT;
+expression FLEX;
+expression E;
+expression DEV;
+identifier ALLOC =~ "^devm_kv?[mz]alloc$";
+fresh identifier ALLOC_OBJ = ALLOC ## "_obj";
+fresh identifier ALLOC_FLEX = ALLOC ## "_flex";
+identifier ALLOC_ARRAY = {devm_kmalloc_array,devm_kvmalloc_array,devm_kcalloc,devm_kvcalloc};
+fresh identifier ALLOC_OBJS = script:python(ALLOC_ARRAY) { alloc_array(ALLOC_ARRAY) };
+@@
+
+(
+-	VAR = ALLOC(DEV,(sizeof(*VAR)), GFP)
++	VAR = ALLOC_OBJ(DEV,*VAR, GFP)
+|
+	ALLOC(DEV,(\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
+|
+	BYTES = ALLOC(DEV,(sizeof(E)), GFP)
+|
+	BYTES = ALLOC(DEV,(sizeof(TYPE)), GFP)
+|
+	BYTES_PTRS = ALLOC(DEV,(sizeof(E)), GFP)
+|
+	BYTES_PTRS = ALLOC(DEV,(sizeof(TYPE)), GFP)
+|
+	ALLOC(DEV,(sizeof(void *)), GFP)
+|
+-	ALLOC(DEV,(sizeof(E)), GFP)
++	ALLOC_OBJ(DEV, E, GFP)
+|
+-	ALLOC(DEV,(sizeof(TYPE)), GFP)
++	ALLOC_OBJ(DEV,TYPE, GFP)
+|
+	ALLOC_ARRAY(DEV,COUNT, (\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
+|
+	BYTES = ALLOC_ARRAY(DEV, COUNT, (sizeof(E)), GFP)
+|
+	BYTES = ALLOC_ARRAY(DEV,COUNT, (sizeof(TYPE)), GFP)
+|
+	BYTES_PTRS = ALLOC_ARRAY(DEV, COUNT, (sizeof(E)), GFP)
+|
+	BYTES_PTRS = ALLOC_ARRAY(DEV, COUNT, (sizeof(TYPE)), GFP)
+|
+	ALLOC_ARRAY(DEV, (\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), COUNT, GFP)
+|
+	BYTES = ALLOC_ARRAY(DEV, (sizeof(E)), COUNT, GFP)
+|
+	BYTES = ALLOC_ARRAY(DEV, (sizeof(TYPE)), COUNT, GFP)
+|
+	BYTES_PTRS = ALLOC_ARRAY(DEV, (sizeof(E)), COUNT, GFP)
+|
+	BYTES_PTRS = ALLOC_ARRAY(DEV, (sizeof(TYPE)), COUNT, GFP)
+|
+	ALLOC_ARRAY(DEV, COUNT, (sizeof(void *)), GFP)
+|
+	ALLOC_ARRAY(DEV, (sizeof(void *)), COUNT, GFP)
+|
+-	ALLOC_ARRAY(DEV, COUNT, (sizeof(E)), GFP)
++	ALLOC_OBJS(DEV, E, COUNT, GFP)
+|
+-	ALLOC_ARRAY(DEV, COUNT, (sizeof(TYPE)), GFP)
++	ALLOC_OBJS(DEV, TYPE, COUNT, GFP)
+|
+-	ALLOC_ARRAY(DEV, (sizeof(E)), COUNT, GFP)
++	ALLOC_OBJS(DEV, E, COUNT, GFP)
+|
+-	ALLOC_ARRAY(DEV, (sizeof(TYPE)), COUNT, GFP)
++	ALLOC_OBJS(DEV, TYPE, COUNT, GFP)
+|
+-	ALLOC(DEV, struct_size(VAR, FLEX, COUNT), GFP)
++	ALLOC_FLEX(DEV, *VAR, FLEX, COUNT, GFP)
+|
+-	ALLOC(DEV, struct_size_t(TYPE, FLEX, COUNT), GFP)
++	ALLOC_FLEX(DEV, TYPE, FLEX, COUNT, GFP)
+)
+
+@drop_gfp_kernel depends on patch && !(file in "tools") && !(file in "samples")@
+identifier ALLOC = {devm_kmalloc_obj,devm_kmalloc_objs,devm_kmalloc_flex,
+		    devm_kzalloc_obj,devm_kzalloc_objs,devm_kzalloc_flex,
+		    devm_kvmalloc_obj,devm_kvmalloc_objs,devm_kvmalloc_flex,
+		    devm_kvzalloc_obj,devm_kvzalloc_objs,devm_kvzalloc_flex};
+@@
+
+	ALLOC(...
+-		 , GFP_KERNEL
+	     )
-- 
2.54.0

