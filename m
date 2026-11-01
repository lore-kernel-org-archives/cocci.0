Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8AC606A326
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=uXYne7Rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:content-transfer-encoding:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lr29LKj7jm7xrhBm1kvzir943FoFGYbdRXMWRa/z/8g=;
  b=uXYne7Rc1RcTYj9fQCmID9PKPSIACNhf2ww2jBA1WzWEpwjSeR9v68Ix
   0hgD/kZGcMgFhFmO37qyzrj7AtsMhnyIYx1nDWqXa8wLiV3ib51yWQAWB
   oqgSG26WaQqu0w237wd2huYOyxzvzCd+v0gy7mAtVPK0EOVQFNrJncait
   c=;
X-CSE-ConnectionGUID: z1cHviSGS0CGUoR2OAHTUg==
X-CSE-MsgGUID: KZ7s2rFaT6qibzgivIjA8Q==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323144"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:15 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C004281693; Sat,  7 Nov 2026 11:59:16 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id CDF6680F60
	for <cocci@sympa.inria.fr>; Sun,  1 Nov 2026 11:35:57 +0100 (CET)
X-CSE-ConnectionGUID: eq+eJQ2CTySh1nRb253tEA==
X-CSE-MsgGUID: JTIAzDeRSt+ZykkK0TeneQ==
IronPort-SDR: 6ae7160d_7YPVdOjofEVn5+2UWHf0+JiIEDyf81Q1dJ8Ly06FkO+K45a
 yEtPnoZSvuEFga0V89uJtLJT0ctS84RWI1o1PjA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EJAADzFOdqjxEsKNhaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBgkCBazQHCEmEWIgbX4h6mEGEDIFVgX4PAQMBDVEEAQEBhQSOICAGA?=
 =?us-ascii?q?QQwCQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBA?=
 =?us-ascii?q?QEBOQUOO4ZcjBoBhAInVjUCJgJeARKDAoJ1AwW7DIEygQGEf9lKgWkLFAGBC?=
 =?us-ascii?q?i4BhXGCbQGBcYRDCYR7P4FOgRWDaYgfgmoEgiKBDIF4lRMJgUEcA1ksAVUTF?=
 =?us-ascii?q?wsHBYE1MwMqLy1uMh1wDCcSLA8IL1gbBgWBHYEegRmBB12BKylgASGBCIF2A?=
 =?us-ascii?q?oJRggACAUlBDgdFUwklQxJHJCIIEgkBExosC4EaNTwJJkEVDGQLGgViCAIND?=
 =?us-ascii?q?HY5EDAgJjAFHSYdbT03Bg8ZBJM0gwkGAT0bNgGCKJQij2KCIaEPhCmBZ6BDh?=
 =?us-ascii?q?ASmbC6HZpB0I4I2oQwOhVEBgWc6gVxNIxWDIlADGQ+OKwMNCdI7JjI9AgcCB?=
 =?us-ascii?q?w4DC5IcgUwBAQ?=
IronPort-PHdr: A9a23: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
 weFnmkbEFU=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:hSeXxayyvao8rfe5zkZlKrPwrL1zdoMgy1knxilNoNJuE/Bw8P
 re/sjztCWE6wr5N0tBpTntAsa9qBDnhPpICOsqUItKNTOO0ADDEGgI1+ffKlPbdREWutQtsJ
 tIQuxeJJnVAUVz5PyKnDWQIpIA7J27+K7Av5ai815dCTpxcqll4kNAFgqGHglXSWB9dPwEPa
 vZ3dBfrz6sPU4addu2HRA+Lo/+juyOrp79ex4BAFoGxWC1/EmVwY+/KRSDxBcZVHdqyawh/X
 OtqX2D2ky8iYDC9jbsk1XP54kTotvuzdNfGNeB4/JlUwnRtg==
X-Talos-CUID: =?us-ascii?q?9a23=3Arc3xrGh+dbH83vZ7fU1hm7+KLjJuf2SewVXpeWS?=
 =?us-ascii?q?EGF1pEbuvQwXNo79Jup87?=
X-Talos-MUID: 9a23:0Q4B0wbED7Zv3uBTlQPNrSNOOf1T/+ecGUMOss06ts+JDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,189,1787004000"; 
   d="scan'208";a="161405900"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHW8uDcDE68w8bQusLtEOX87O0Kol3JeVuDai?=
 =?us-ascii?q?+Hp9Pklp5Co8tRzYchjw8T0G31iE1cjA8ESH+u/pGMvRb61hzSBVE+Ba?=
 =?us-ascii?q?Y2hF1LLiHwioYMB7oQmrYZGfWnK9Frsahc7DUhSVwhfCzlKc3VsmAxf/?=
 =?us-ascii?q?d4o8WVnLoJJIBF1ZKKMzH5JQ=3D=3D?=
Received: from smtprelay0017.hostedemail.com (HELO relay.hostedemail.com) ([216.40.44.17])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 11:35:57 +0100
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 55FB21C4474;
	Sun,  1 Nov 2026 10:35:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 020121A;
	Sun,  1 Nov 2026 10:35:47 +0000 (UTC)
Message-ID: <9b55b3e3269ef43ede64fff34f42121f7aa47979.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, driver-core@lists.linux.dev, Julia Lawall	
 <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr
Date: Sun, 01 Nov 2026 02:35:46 -0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 020121A
X-Stat-Signature: wgijqpyekkg9ojk3istbf14hpw4us5qt
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/CuLGSxAJF5y4MHlonP5ikbskV72/ZZM8=
X-HE-Tag: 1793529347-718889
X-HE-Meta: U2FsdGVkX1/yk6OTOzTW8KwYYkxvqFINixk1dvu/iIHmosmBasoCT/OuDz7qkFXOOnrtJHvqrkMzc1tTaKl4rZEdFM1hTRtsVrvecp5/rhBaLVraYV2JW6r8Y3hzkrj/qGO0+xZUS6Zy0mDsBmEIUkI6p6GxiWPLR3L4wXBO5P/OpCpDKBA97a6EvZYzgPvAJhir8v4NckP7mcNCqZMJuUhJuLqi8WIOx9R9gFmVddM0luEm/nWHPHUBozPV6r9WwfdS4StBR3Md/udxLkdX1lZdU0PjS5TbfZjyKMh4qvJ5cx76kp51VGO8mL63fJ40zI6Ai+viegBOhQQwbEgGeoh3qo3pNVOCrP/Ns93C2AuSfkZA/jRAAdusQcWjcyTC
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [resend PATCH] coccinelle: Add devm_kmalloc_objs conversion
 script
Reply-To: Joe Perches <joe@perches.com>
X-Loop: cocci@inria.fr
X-Sequence: 3768
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/slpG_EMJjC0sDdSFaffzCw>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Like commit bdc5071d7f7b ("coccinelle: Add kmalloc_objs conversion script")
with commit 1c7bbaeed110 ("coccinelle: kmalloc_obj: Remove default GFP_KERN=
EL arg")

Finds and converts sized devm_kmalloc-family of allocations into the typed
devm_kmalloc_obj-family of allocations.

Signed-off-by: Joe Perches <joe@perches.com>
---

Maybe this might be useful to run and apply just prior to some -rc1

This script would change more than 8000 instances in more than
5000 files in Linus' current master.

$ spatch -D patch --very-quiet --cocci-file ./scripts/coccinelle/api/devm_k=
malloc_objs.cocci \
    --include-headers-for-types --all-includes --include-headers --keep-com=
ments \
    -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include \
    -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./in=
clude/uapi \
    -I ./include/generated/uapi --include ./include/linux/compiler-version.=
h \
    --include ./include/linux/kconfig.h .

Lightly tested but directly copied and modified to update the devm_ uses

Its been a bit.
Any comments or negatives about using or running this script?

 .../coccinelle/api/devm_kmalloc_objs.cocci    | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 scripts/coccinelle/api/devm_kmalloc_objs.cocci

diff --git a/scripts/coccinelle/api/devm_kmalloc_objs.cocci b/scripts/cocci=
nelle/api/devm_kmalloc_objs.cocci
new file mode 100644
index 0000000000000..322f79a2d9654
--- /dev/null
+++ b/scripts/coccinelle/api/devm_kmalloc_objs.cocci
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use devm_kmalloc_obj family of macros for allocations
+///
+// Confidence: High
+// Options: --include-headers-for-types --all-includes --include-headers -=
-keep-comments
+
+virtual patch
+
+@initialize:python@
+@@
+import sys
+
+def alloc_array(name):
+	func =3D "FAILED_RENAME"
+	if name =3D=3D "devm_kmalloc_array":
+		func =3D "devm_kmalloc_objs"
+	elif name =3D=3D "devm_kvmalloc_array":
+		func =3D "devm_kvmalloc_objs"
+	elif name =3D=3D "devm_kcalloc":
+		func =3D "devm_kzalloc_objs"
+	elif name =3D=3D "devm_kvcalloc":
+		func =3D "devm_kvzalloc_objs"
+	else:
+		print(f"Unknown transform for {name}", file=3Dsys.stderr)
+	return func
+
+// This excludes anything that is assigning to or from integral types or
+// string literals. Everything else gets the sizeof() extracted for the
+// kmalloc_obj() type/var argument. sizeof(void *) is also excluded becaus=
e
+// it will need case-by-case double-checking to make sure the right type i=
s
+// being assigned.
+@direct depends on patch && !(file in "tools") && !(file in "samples")@
+typedef u8, u16, u32, u64;
+typedef __u8, __u16, __u32, __u64;
+typedef uint8_t, uint16_t, uint32_t, uint64_t;
+typedef uchar, ushort, uint, ulong;
+typedef __le16, __le32, __le64;
+typedef __be16, __be32, __be64;
+typedef wchar_t;
+type INTEGRAL =3D {u8,__u8,uint8_t,char,unsigned char,uchar,wchar_t,
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
+identifier ALLOC =3D~ "^devm_kv?[mz]alloc$";
+fresh identifier ALLOC_OBJ =3D ALLOC ## "_obj";
+fresh identifier ALLOC_FLEX =3D ALLOC ## "_flex";
+identifier ALLOC_ARRAY =3D {devm_kmalloc_array,devm_kvmalloc_array,devm_kc=
alloc,devm_kvcalloc};
+fresh identifier ALLOC_OBJS =3D script:python(ALLOC_ARRAY) { alloc_array(A=
LLOC_ARRAY) };
+@@
+
+(
+-	VAR =3D ALLOC(DEV,(sizeof(*VAR)), GFP)
++	VAR =3D ALLOC_OBJ(DEV,*VAR, GFP)
+|
+	ALLOC(DEV,(\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP=
)
+|
+	BYTES =3D ALLOC(DEV,(sizeof(E)), GFP)
+|
+	BYTES =3D ALLOC(DEV,(sizeof(TYPE)), GFP)
+|
+	BYTES_PTRS =3D ALLOC(DEV,(sizeof(E)), GFP)
+|
+	BYTES_PTRS =3D ALLOC(DEV,(sizeof(TYPE)), GFP)
+|
+	ALLOC(DEV,(sizeof(void *)), GFP)
+|
+-	ALLOC(DEV,(sizeof(E)), GFP)
++	ALLOC_OBJ(DEV, E, GFP)
+|
+-	ALLOC(DEV,(sizeof(TYPE)), GFP)
++	ALLOC_OBJ(DEV,TYPE, GFP)
+|
+	ALLOC_ARRAY(DEV,COUNT, (\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGR=
AL *)\)), GFP)
+|
+	BYTES =3D ALLOC_ARRAY(DEV, COUNT, (sizeof(E)), GFP)
+|
+	BYTES =3D ALLOC_ARRAY(DEV,COUNT, (sizeof(TYPE)), GFP)
+|
+	BYTES_PTRS =3D ALLOC_ARRAY(DEV, COUNT, (sizeof(E)), GFP)
+|
+	BYTES_PTRS =3D ALLOC_ARRAY(DEV, COUNT, (sizeof(TYPE)), GFP)
+|
+	ALLOC_ARRAY(DEV, (\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\=
)), COUNT, GFP)
+|
+	BYTES =3D ALLOC_ARRAY(DEV, (sizeof(E)), COUNT, GFP)
+|
+	BYTES =3D ALLOC_ARRAY(DEV, (sizeof(TYPE)), COUNT, GFP)
+|
+	BYTES_PTRS =3D ALLOC_ARRAY(DEV, (sizeof(E)), COUNT, GFP)
+|
+	BYTES_PTRS =3D ALLOC_ARRAY(DEV, (sizeof(TYPE)), COUNT, GFP)
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
+@drop_gfp_kernel depends on patch && !(file in "tools") && !(file in "samp=
les")@
+identifier ALLOC =3D {devm_kmalloc_obj,devm_kmalloc_objs,devm_kmalloc_flex=
,
+		    devm_kzalloc_obj,devm_kzalloc_objs,devm_kzalloc_flex,
+		    devm_kvmalloc_obj,devm_kvmalloc_objs,devm_kvmalloc_flex,
+		    devm_kvzalloc_obj,devm_kvzalloc_objs,devm_kvzalloc_flex};
+@@
+
+	ALLOC(...
+-		 , GFP_KERNEL
+	     )
