Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B82AD3B7FB
	for <cocci@archiver.kernel.org>; Tue,  9 Dec 2025 10:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bHDnA39n23L3Oms8EO9Ali9+Wl0S4uKjpuKYohEsaUw=;
  b=JtMXjakmaldWdvYyFYD3zzo4/LvMuie+RBvZPp5SuSTN7NgPIYHDQaZW
   X5cqs2z/btSGEhYujYfOZsUF05ceNub+KGQfV7SZ4gXeA6IbAa/XqnIlf
   0jIwYRn8XIQ8OigZmZ+g1h8ucPo1ujV8pB1WRzTBKYQ3pZhMOUgj9aQi1
   s=;
X-CSE-ConnectionGUID: 5exM0EQpQNi2sIrKjq9zQw==
X-CSE-MsgGUID: CG0JtWpcR7aKQrcOx9JSNA==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.20,261,1758578400"; 
   d="scan'208";a="253495219"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2025 11:10:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EDACEE0CF5; Tue,  9 Dec 2025 11:10:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6FA2AE00A5
	for <cocci@sympa.inria.fr>; Thu,  4 Dec 2025 00:30:42 +0100 (CET)
X-CSE-ConnectionGUID: 4lC8FlcJQHukjEVrDkRMzQ==
X-CSE-MsgGUID: zNm7l+0xTB6T+QljcdFTPA==
IronPort-SDR: 6930c821_a4anHOP2Bofx1oINji1YdgZd+ygbyGNyoOUDKdbsRYcHsja
 HtaodfBPIGCwkfCJjKJkVuph7NQkXq0RNZ4cmlA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EfAQCgxjBpjx/86qxaHgEBCxIMggULgkCBYTMEC0mNU?=
 =?us-ascii?q?IZYoD6BfQIPAQMBDVEEAQEDBIUAAoxnAh4HAQQxCA4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQEBATkFSYZPDYJiAYEkgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAg1+AgEDMgENAQE3AQ8ZOFYGE4MCgiMHSgO0FIEBggwBAQbcJ?=
 =?us-ascii?q?4FkCYFLhW6HY3FEgzp6JxuCDYEVgTuCLYRYhi+DNIYfglMekFFIgR4DWSwBV?=
 =?us-ascii?q?RMNCgsHBVuBCAM1DAsqFW4yHYEjPg8Ic4RdHmcPBoERg1EGiRIPij0lAwsYD?=
 =?us-ascii?q?UgRLDcUGwY+bgeUIU+CKwdYNpZKgnABjHCCIaEOhCaBZJ9zGjOBS5YHkxkum?=
 =?us-ascii?q?FijYg6FUIFqAzWBXDMaCCgIgyJPAxkPjiEJAw0JiHG4VSI1PAIHCwEBAwmSH?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:jGfj5KOsFk9GTcBcT6T155DYdb4zR+YMi2QD/1t6SBxLfsHdv9
 3GpoVX6faVsltwZJhAo6H4BEDuewK6yXce2+Ys1ImZLXjbUQeTXeNfBWWL+UyrJ8XRntQtop
 uIWZIOfOEZlTNB/I3HCDDRKadp/DFsmJrY89s2tk0dBD2CCJsQiTuRaDzrcXGeHzM2detLKH
 P03KMuzFDPGEj/CP7LekXtcNKz1eEj/6iWBSLuaSRXjTVns1mTmcHHOind+AwfXTNJybJn3E
 zsqCa83amoteq3oyWsm1M7gq47pPLRjuBYHcSJh4w8ICjtjAHAXvUdZ5Sy+Asuuemq5RITjN
 XRr1MBMq1ImgjsV1DwmgH10w3slAwj8GDv0jaj8APeSceSfkNFN+NxwbhBeh/Vr3Etps14zc
 twrhiknqsSChWFlD/25tjWW3hR5z+JnUY=
X-Talos-CUID: =?us-ascii?q?9a23=3AQjpz4mpgwnSY+YG/DPxhamnmUZwhWS3zyHzyGm+?=
 =?us-ascii?q?lCmREdqe5SmW16poxxg=3D=3D?=
X-Talos-MUID: 9a23:cesYWQozo5Xpo1TkhpgezyNEMZhsoPy+NGpTrdY/v8uPOQJMAx7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,247,1758578400"; 
   d="scan'208";a="132706243"
X-MGA-submission: =?us-ascii?q?MDFeM67szf8+tSwfTykmt0zCWsBVIj9QDttTaW?=
 =?us-ascii?q?S9hQ2djAQSQhj3TZE6G3olmo26KNdA/bowirXeir2E/1E85uKtCSAoa6?=
 =?us-ascii?q?hwL+GGed7MTdWjLiiObBiNgaCGBTEAdEAibRAD0+3X726GmYwFI8Bgda?=
 =?us-ascii?q?WHnKl4xPVKeDX1GaDtKaPPsg=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 00:30:40 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A2B6044411;
	Wed,  3 Dec 2025 23:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5515AC2BCB9;
	Wed,  3 Dec 2025 23:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764804637;
	bh=5dAQ4T//TVYvlDNMsV5Y6TSBwmCOXpo3qNaO4v8qX0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tb1QFnmrmnR+zXH4fFBLmyxgcqpG4u3ZvwA7jcak8tIqWFqIsmYPPKVxGdTX8Ryvr
	 R1Li+pHJWV1tAMBLLP3p+jTOEuYTJC+rO7oIZ4ejDqA1hne6lUoKesO8t7wxq6qoqz
	 dGwtzcdHfbeL7AZLleyooLz5rSKKZZHmqOqNQT/gL2IqbrPdi1OGOn1CFy4tmYloBK
	 ZP+6uTtqVaFhxeXwW8PA0tVDOwqLxJ/ruN46Fnaai8RPGeamw7sRh3iri3PFyf7QuU
	 aqmZoLMDLVciN4vCgG365BnxUxt6oAmlIlK001XgapbBRngGvP07yXaJrao1Bu0yB+
	 aS4CkB0gAXGhg==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Joe Perches <joe@perches.com>,
	Christoph Lameter <cl@linux.com>,
	Marco Elver <elver@google.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jann Horn <jannh@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev
Date: Wed,  3 Dec 2025 15:30:35 -0800
Message-Id: <20251203233036.3212363-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203233029.it.641-kees@kernel.org>
References: <20251203233029.it.641-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3968; i=kees@kernel.org; h=from:subject; bh=5dAQ4T//TVYvlDNMsV5Y6TSBwmCOXpo3qNaO4v8qX0A=; b=owGbwMvMwCVmps19z/KJym7G02pJDJkGJ6Sy9r13X/2Re2em+HFHS6vbrLaGdziDJu7dxrh1l R1vmPW3jlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIl4hzD8L6ve9u7a1VXb7Pz5 MjPFYksnmr7e9rF9fq7z04VTjtk3ejH84bQ9zWIc4xC+xfH9mXsPlN8nHDdq3WiycYLhz4VWbE2 qDAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v6 5/5] coccinelle: Add kmalloc_objs conversion
 script
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3256
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/20251203233036.3212363-5-kees%40kernel.org>

Finds and converts sized kmalloc-family of allocations into the
typed kmalloc_obj-family of allocations.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr
---
 scripts/coccinelle/api/kmalloc_objs.cocci | 109 ++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 scripts/coccinelle/api/kmalloc_objs.cocci

diff --git a/scripts/coccinelle/api/kmalloc_objs.cocci b/scripts/coccinelle/api/kmalloc_objs.cocci
new file mode 100644
index 000000000000..916cc3a661b9
--- /dev/null
+++ b/scripts/coccinelle/api/kmalloc_objs.cocci
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use kmalloc_obj family of macros for allocations
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
+	if name == "kmalloc_array":
+		func = "kmalloc_objs"
+	elif name == "kvmalloc_array":
+		func = "kvmalloc_objs"
+	elif name == "kcalloc":
+		func = "kzalloc_objs"
+	elif name == "kvcalloc":
+		func = "kvzalloc_objs"
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
+typedef __le16, __le32, __le64;
+typedef __be16, __be32, __be64;
+type INTEGRAL = {u8,__u8,uint8_t,char,unsigned char,
+		 u16,__u16,uint16_t,unsigned short,
+		 u32,__u32,uint32_t,unsigned int,
+		 u64,__u64,uint64_t,unsigned long,
+		 __le16,__le32,__le64,__be16,__be32,__be64};
+char [] STRING;
+INTEGRAL *BYTES;
+type TYPE;
+expression VAR;
+expression GFP;
+expression COUNT;
+expression FLEX;
+expression E;
+identifier ALLOC =~ "^kv?[mz]alloc$";
+fresh identifier ALLOC_OBJ = ALLOC ## "_obj";
+fresh identifier ALLOC_FLEX = ALLOC ## "_flex";
+identifier ALLOC_ARRAY = {kmalloc_array,kvmalloc_array,kcalloc,kvcalloc};
+fresh identifier ALLOC_OBJS = script:python(ALLOC_ARRAY) { alloc_array(ALLOC_ARRAY) };
+@@
+
+(
+-	VAR = ALLOC((sizeof(*VAR)), GFP)
++	VAR = ALLOC_OBJ(*VAR, GFP)
+|
+	ALLOC((\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
+|
+	BYTES = ALLOC((sizeof(E)), GFP)
+|
+	BYTES = ALLOC((sizeof(TYPE)), GFP)
+|
+	ALLOC((sizeof(void *)), GFP)
+|
+-	ALLOC((sizeof(E)), GFP)
++	ALLOC_OBJ(E, GFP)
+|
+-	ALLOC((sizeof(TYPE)), GFP)
++	ALLOC_OBJ(TYPE, GFP)
+|
+	ALLOC_ARRAY(COUNT, (\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
+|
+	BYTES = ALLOC_ARRAY(COUNT, (sizeof(E)), GFP)
+|
+	BYTES = ALLOC_ARRAY(COUNT, (sizeof(TYPE)), GFP)
+|
+	ALLOC_ARRAY((\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), COUNT, GFP)
+|
+	BYTES = ALLOC_ARRAY((sizeof(E)), COUNT, GFP)
+|
+	BYTES = ALLOC_ARRAY((sizeof(TYPE)), COUNT, GFP)
+|
+	ALLOC_ARRAY(COUNT, (sizeof(void *)), GFP)
+|
+	ALLOC_ARRAY((sizeof(void *)), COUNT, GFP)
+|
+-	ALLOC_ARRAY(COUNT, (sizeof(E)), GFP)
++	ALLOC_OBJS(E, COUNT, GFP)
+|
+-	ALLOC_ARRAY(COUNT, (sizeof(TYPE)), GFP)
++	ALLOC_OBJS(TYPE, COUNT, GFP)
+|
+-	ALLOC_ARRAY((sizeof(E)), COUNT, GFP)
++	ALLOC_OBJS(E, COUNT, GFP)
+|
+-	ALLOC_ARRAY((sizeof(TYPE)), COUNT, GFP)
++	ALLOC_OBJS(TYPE, COUNT, GFP)
+|
+-	ALLOC(struct_size(VAR, FLEX, COUNT), GFP)
++	ALLOC_FLEX(*VAR, FLEX, COUNT, GFP)
+|
+-	ALLOC(struct_size_t(TYPE, FLEX, COUNT), GFP)
++	ALLOC_FLEX(TYPE, FLEX, COUNT, GFP)
+)
-- 
2.34.1

