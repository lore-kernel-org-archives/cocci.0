Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B079C88E53
	for <cocci@archiver.kernel.org>; Tue, 15 Sep 2026 08:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=oFoR9qQIdwt3+vZZkEYKmSOPISctBhe05eYTvaM9nRc=;
  b=kCtVvIMYJ4yytspzw0XvO0IbRKWNumFNjTLpgb1AY9ONPBI4zRvXAyps
   11u4QDNgeUC6cZ1bVISy6g/IeAcue58wHox6Jg+lZwcAUIs6y8jSW3mYX
   5g+BpRzvUZ8GtOElLukOvjk4mlXD5rJbwDbJjEndFycf6UPMTlbV24c7h
   g=;
X-CSE-ConnectionGUID: hjVhS8HvQ6yMTVl8o9yrpQ==
X-CSE-MsgGUID: +YvSrCWwQKiKcUxZOD4DXA==
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
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="294998424"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Sep 2026 10:45:52 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 307DB826FD; Tue, 15 Sep 2026 10:45:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 367AE8072E
	for <cocci@sympa.inria.fr>; Tue, 15 Sep 2026 00:37:55 +0200 (CEST)
X-CSE-ConnectionGUID: GngilK3nSxaZy/Ios3dapg==
X-CSE-MsgGUID: 3pk7rDM2TNW0h3e8dgGQ0A==
IronPort-SDR: 6aa87742_rK+1XLGPCzKEH+sQ/CfpUMVYOtrEjNyna1yEwH7cI/lpCBV
 8ou8d+a/danK8O62rhAK9iHpq7+FhSL53DlqL7g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GcAAANdqhqj/4EaaxaglmCQRaBVjMEC0mNUooPnQiBf?=
 =?us-ascii?q?AIPAQMBDVEEAQEBAgSEfo4JAh4HAQQwCQ4BAgQDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QEEAQEBAgEBAgQDAQEBAQIQAQEBAQEBOQVJhk8NjBoBgSSBJgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAR0CDYEAKwsBDQEBNwGBPBODAoIjB0sDxgwzgQGCDAEBBtw0gWgBAgkUA?=
 =?us-ascii?q?YE4hXGHcIE6gz6BIRuCDYEVMoJBdoRYhjCDMoJmkUVIgR4DWSwBVRMNCgsHB?=
 =?us-ascii?q?V6BCAM1EioVbjIdgSM+F4EHGwYFgR2BJ4JiIxk2eoEJXoErKWABEheBCYIIA?=
 =?us-ascii?q?oJUggECAUlDDgdFUwknSxJMKSIIEgkBExoWGA1IESw3FRkEPm4HjysfglgHW?=
 =?us-ascii?q?DaWDjyPY4IhoQ+EKIFmn3YaM4FLlgiTGQEumFqjcmiEaYFoOoFcMxoIKAg7g?=
 =?us-ascii?q?mdQAxkPjisDDQmIc8cmJDU9AgcCBw4DC5IcgUwBAQ?=
IronPort-PHdr: A9a23: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
 YAIR7sdU0Y6RKty4qtNH9EYJppzGDQ+nuzC5PM=
IronPort-Data: A9a23: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
 4T4qaCojXxXkXLMLPs=
IronPort-HdrOrdr: A9a23:Q95sUqrc/i+nUYbPJr78fucaV5oIeYIsimQD101hICG9vPb3qy
 nIpoV86faQslsssR4b+exoVJPtfZq+z+8R3WBuB8bAYOCOggLBR+tfBODZogEIdReQysdtkY
 ptbKR6DsT9FhxZgdaS2njeL/8QhPSK76ysg/7T1DNWTQ9sY7x99AsRMHf+LqQPfnglOaYE
X-Talos-CUID: 9a23:QTYnaWxY3vAYKv2Xyk8zBgU7HM8kdl6GykzAKn2pTkduU+aZQEefrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3ApC2PPw+ntPFFwHPhuACSauiQf5xw4Pu0JGVXrbM?=
 =?us-ascii?q?548nfOHx8NBik1B3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="156901549"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDE83Po0dMngahvHbuGDOSvqrC2bYScDrAK9E5?=
 =?us-ascii?q?M+nvi6cPWvRPyib6+0uxuPC7xZEbhxh8bizCzYMg+5bmFoFeH8t1XglP?=
 =?us-ascii?q?hq9mNjbmO9FYqP0Sp9N5rD0sJzaqaYb4NfpLQDMBJyHkrIKCLIgGHQ5s?=
 =?us-ascii?q?dyKO3Z9tDKEWCJJhEP3WexbA=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:37:54 +0200
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B3CF06025B;
	Mon, 14 Sep 2026 22:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C9C1F000FF;
	Mon, 14 Sep 2026 22:37:50 +0000 (UTC)
From: Kees Cook <kees@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Kees Cook <kees@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Date: Mon, 14 Sep 2026 15:37:49 -0700
Message-Id: <20260914223748.i.971-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11778; i=kees@kernel.org; h=from:subject:message-id; bh=5Y3Qv8aSWtG1ldbvwnoLA2PLP4W7OW/PZbwFVfjYd74=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkrym2SOLM6ZnZl3HqwQu5f07ID4jlbZeO+8tTtCNURf ZCZtN+oo5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCLHCxgZlm37xp/3hjtz2gfP A8vFhaM4Fp5mzvu5VDeRKaBAtSTSg5Hhye/S/2KHkpoCFl090HzIjz/C1mlW6tbfquc86rfU6Ac xAAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH] coccinelle: kmalloc_obj: Convert multi-byte
 integral allocations
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3733
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/-VqcPmMEn9CdyYZ9zWeRww>

Currently the kmalloc_obj conversion rules leave alone every allocation
sized to an integral type, or assigned to a pointer to one, so that byte
buffers keep being allocated with a byte count. That also leaves alone
arrays of multi-byte integers, such as

	vals = kcalloc(n, sizeof(u32), GFP_KERNEL);

which count objects like any other array. At the same time the signed
types (s8 through s64 and their variants) were not in the list at all.
But these multi-byte types are better handled through the full
kmalloc_obj-style allocation, as they are, in fact, typed and aren't
just a byte string, so they would benefit from type checking.

Split INTEGRAL into BYTE_TYPES and MULTIBYTE_TYPES:

 - Allocations sized by a byte type or a string literal, or assigned to
   a pointer to a byte type, are still left alone.
 - Allocations sized by a multi-byte type are converted when they are
   assigned to a pointer, or a pointer to const, of that same type.
   Other allocations sized by a multi-byte type are left alone, as their
   target may be a pointer to an array.
 - Allocations of other types assigned to a pointer to a multi-byte type
   are still left alone.
 - Arrays of pointers to integral types sized by type, such as
   sizeof(char *), are still left alone, now including the signed
   types, as their target may be a pointer to an array of pointers, like
   "const char *(*fmts)[]". Sized as sizeof(*target), they are converted
   like any other array.

List the signed types and the other spellings of the standard integer
types (short int, unsigned, long long int, and so on), so that a
declaration and a sizeof() that spell the same type differently still
match.

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: <cocci@inria.fr>
---
 scripts/coccinelle/api/kmalloc_objs.cocci | 161 +++++++++++++++++-----
 1 file changed, 129 insertions(+), 32 deletions(-)

diff --git a/scripts/coccinelle/api/kmalloc_objs.cocci b/scripts/coccinelle/api/kmalloc_objs.cocci
index e9a415b7b6f4..0a98ddf03eca 100644
--- a/scripts/coccinelle/api/kmalloc_objs.cocci
+++ b/scripts/coccinelle/api/kmalloc_objs.cocci
@@ -24,27 +24,57 @@ def alloc_array(name):
 		print(f"Unknown transform for {name}", file=sys.stderr)
 	return func
 
-// This excludes anything that is assigning to or from integral types or
-// string literals. Everything else gets the sizeof() extracted for the
-// kmalloc_obj() type/var argument. sizeof(void *) is also excluded because
-// it will need case-by-case double-checking to make sure the right type is
+// Allocations sized by a byte-sized type (BYTE_TYPES) or a string literal,
+// and allocations assigned to a pointer to a byte-sized type, are byte
+// buffers and are left alone. sizeof(void *) is also excluded because it
+// will need case-by-case double-checking to make sure the right type is
 // being assigned.
+//
+// Allocations sized by a multi-byte integral type (MULTIBYTE_TYPES) are
+// converted when they are assigned to a pointer to that same type.
+// Otherwise they are left alone: the target may be a pointer to an array
+// of that type, such as "s16 (*pairs)[2]", for which the converted
+// allocation would have the wrong pointer type. For the same reason,
+// arrays of pointers to integral types sized as sizeof(char *) and the
+// like are left alone. Allocations of other types assigned to a pointer to
+// a multi-byte integral type are left alone too.
+//
+// Everything else gets the sizeof() extracted for the kmalloc_obj()
+// type/var argument.
+//
+// The first matching alternative below wins, so the exclusions must come
+// before the more general conversions.
 @direct depends on patch && !(file in "tools") && !(file in "samples")@
 typedef u8, u16, u32, u64;
 typedef __u8, __u16, __u32, __u64;
 typedef uint8_t, uint16_t, uint32_t, uint64_t;
+typedef s8, s16, s32, s64;
+typedef __s8, __s16, __s32, __s64;
+typedef int8_t, int16_t, int32_t, int64_t;
 typedef uchar, ushort, uint, ulong;
 typedef __le16, __le32, __le64;
 typedef __be16, __be32, __be64;
 typedef wchar_t;
-type INTEGRAL = {u8,__u8,uint8_t,char,unsigned char,uchar,wchar_t,
-		 u16,__u16,uint16_t,unsigned short,ushort,
-		 u32,__u32,uint32_t,unsigned int,uint,
-		 u64,__u64,uint64_t,unsigned long,ulong,
-		 __le16,__le32,__le64,__be16,__be32,__be64};
+type BYTE_TYPES = {char,signed char,unsigned char,uchar,
+		   u8,__u8,uint8_t,s8,__s8,int8_t};
+type MULTIBYTE_TYPES = {short,short int,signed short,signed short int,
+			unsigned short,unsigned short int,ushort,
+			int,signed,signed int,unsigned,unsigned int,uint,
+			long,long int,signed long,signed long int,
+			unsigned long,unsigned long int,ulong,
+			long long,long long int,
+			signed long long,signed long long int,
+			unsigned long long,unsigned long long int,
+			u16,__u16,uint16_t,s16,__s16,int16_t,
+			u32,__u32,uint32_t,s32,__s32,int32_t,
+			u64,__u64,uint64_t,s64,__s64,int64_t,
+			__le16,__le32,__le64,__be16,__be32,__be64,
+			wchar_t};
 char [] STRING;
-INTEGRAL *BYTES;
-INTEGRAL **BYTES_PTRS;
+BYTE_TYPES *BYTES;
+MULTIBYTE_TYPES *MULTIBYTES;
+const MULTIBYTE_TYPES *CONST_MULTIBYTES;
+MULTIBYTE_TYPES MULTIBYTE;
 type TYPE;
 expression VAR;
 expression GFP;
@@ -59,66 +89,133 @@ fresh identifier ALLOC_OBJS = script:python(ALLOC_ARRAY) { alloc_array(ALLOC_ARR
 @@
 
 (
+// Convert a single object sized by its target: p = kmalloc(sizeof(*p), gfp)
 -	VAR = ALLOC((sizeof(*VAR)), GFP)
 +	VAR = ALLOC_OBJ(*VAR, GFP)
 |
-	ALLOC((\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
+// Exclude byte buffers and integral pointers: kmalloc(sizeof(u8), gfp),
+//   kmalloc(sizeof("str"), gfp), kmalloc(sizeof(char *), gfp)
+	ALLOC((\(sizeof(STRING)\|sizeof(BYTE_TYPES)\|
+		sizeof(BYTE_TYPES *)\|sizeof(MULTIBYTE_TYPES *)\)), GFP)
 |
-	BYTES = ALLOC((sizeof(E)), GFP)
+// Exclude anything assigned to a byte pointer:
+//   u8 *buf = kmalloc(sizeof(*hdr), gfp)
+	BYTES = ALLOC((\(sizeof(E)\|sizeof(TYPE)\)), GFP)
 |
-	BYTES = ALLOC((sizeof(TYPE)), GFP)
+// Convert a multi-byte type to a pointer to it:
+//   u32 *p = kmalloc(sizeof(u32), gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) =
+-		ALLOC((sizeof(MULTIBYTE_TYPES)), GFP)
++		ALLOC_OBJ(MULTIBYTE_TYPES, GFP)
 |
-	BYTES_PTRS = ALLOC((sizeof(E)), GFP)
+// Same by expression: u32 *p = kmalloc(sizeof(p[0]), gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) =
+-		ALLOC((sizeof(MULTIBYTE)), GFP)
++		ALLOC_OBJ(MULTIBYTE, GFP)
 |
-	BYTES_PTRS = ALLOC((sizeof(TYPE)), GFP)
+// Exclude other multi-byte sizes, e.g. to pointers to arrays: s16 (*p)[2] = ...
+	ALLOC((\(sizeof(MULTIBYTE_TYPES)\|sizeof(MULTIBYTE)\)), GFP)
 |
+// Exclude anything else assigned to a multi-byte pointer:
+//   u32 *p = kmalloc(sizeof(*hdr), gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) = ALLOC((\(sizeof(E)\|sizeof(TYPE)\)), GFP)
+|
+// Exclude void pointers, to be checked by hand: kmalloc(sizeof(void *), gfp)
 	ALLOC((sizeof(void *)), GFP)
 |
+// Convert any other expression: p = kmalloc(sizeof(s->item), gfp)
 -	ALLOC((sizeof(E)), GFP)
 +	ALLOC_OBJ(E, GFP)
 |
+// Convert any other type: p = kmalloc(sizeof(struct item), gfp)
 -	ALLOC((sizeof(TYPE)), GFP)
 +	ALLOC_OBJ(TYPE, GFP)
 |
-	ALLOC_ARRAY(COUNT, (\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
-|
-	BYTES = ALLOC_ARRAY(COUNT, (sizeof(E)), GFP)
-|
-	BYTES = ALLOC_ARRAY(COUNT, (sizeof(TYPE)), GFP)
-|
-	BYTES_PTRS = ALLOC_ARRAY(COUNT, (sizeof(E)), GFP)
+// The same, for arrays allocated as (count, size):
+// Exclude byte buffers and integral pointers: kcalloc(n, sizeof(u8), gfp),
+//   kcalloc(n, sizeof(char *), gfp)
+	ALLOC_ARRAY(COUNT, (\(sizeof(STRING)\|sizeof(BYTE_TYPES)\|
+			    sizeof(BYTE_TYPES *)\|sizeof(MULTIBYTE_TYPES *)\)), GFP)
 |
-	BYTES_PTRS = ALLOC_ARRAY(COUNT, (sizeof(TYPE)), GFP)
+// Exclude arrays assigned to a byte pointer:
+//   u8 *buf = kcalloc(n, sizeof(*hdr), gfp)
+	BYTES = ALLOC_ARRAY(COUNT, (\(sizeof(E)\|sizeof(TYPE)\)), GFP)
 |
-	ALLOC_ARRAY((\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), COUNT, GFP)
+// Convert a multi-byte array to a pointer to it:
+//   u32 *p = kcalloc(n, sizeof(u32), gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) =
+-		ALLOC_ARRAY(COUNT, (sizeof(MULTIBYTE_TYPES)), GFP)
++		ALLOC_OBJS(MULTIBYTE_TYPES, COUNT, GFP)
 |
-	BYTES = ALLOC_ARRAY((sizeof(E)), COUNT, GFP)
+// Same by expression: u32 *p = kcalloc(n, sizeof(*p), gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) =
+-		ALLOC_ARRAY(COUNT, (sizeof(MULTIBYTE)), GFP)
++		ALLOC_OBJS(MULTIBYTE, COUNT, GFP)
 |
-	BYTES = ALLOC_ARRAY((sizeof(TYPE)), COUNT, GFP)
+// Exclude other multi-byte arrays:
+//   s16 (*pairs)[2] = kcalloc(n, sizeof(s16), gfp)
+	ALLOC_ARRAY(COUNT, (\(sizeof(MULTIBYTE_TYPES)\|sizeof(MULTIBYTE)\)), GFP)
 |
-	BYTES_PTRS = ALLOC_ARRAY((sizeof(E)), COUNT, GFP)
-|
-	BYTES_PTRS = ALLOC_ARRAY((sizeof(TYPE)), COUNT, GFP)
+// Exclude other arrays assigned to a multi-byte pointer:
+//   u32 *p = kcalloc(n, sizeof(*hdr), gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) = ALLOC_ARRAY(COUNT, (\(sizeof(E)\|sizeof(TYPE)\)), GFP)
 |
+// Exclude arrays of void pointers: kcalloc(n, sizeof(void *), gfp)
 	ALLOC_ARRAY(COUNT, (sizeof(void *)), GFP)
 |
-	ALLOC_ARRAY((sizeof(void *)), COUNT, GFP)
-|
+// Convert any other expression: p = kcalloc(n, sizeof(*p), gfp)
 -	ALLOC_ARRAY(COUNT, (sizeof(E)), GFP)
 +	ALLOC_OBJS(E, COUNT, GFP)
 |
+// Convert any other type: p = kcalloc(n, sizeof(struct item), gfp)
 -	ALLOC_ARRAY(COUNT, (sizeof(TYPE)), GFP)
 +	ALLOC_OBJS(TYPE, COUNT, GFP)
 |
+// The same, for arrays allocated as (size, count):
+// Exclude byte buffers and integral pointers: kcalloc(sizeof(u8), n, gfp),
+//   kcalloc(sizeof(char *), n, gfp)
+	ALLOC_ARRAY((\(sizeof(STRING)\|sizeof(BYTE_TYPES)\|
+		      sizeof(BYTE_TYPES *)\|sizeof(MULTIBYTE_TYPES *)\)), COUNT, GFP)
+|
+// Exclude arrays assigned to a byte pointer:
+//   u8 *buf = kcalloc(sizeof(*hdr), n, gfp)
+	BYTES = ALLOC_ARRAY((\(sizeof(E)\|sizeof(TYPE)\)), COUNT, GFP)
+|
+// Convert a multi-byte array to a pointer to it:
+//   u32 *p = kcalloc(sizeof(u32), n, gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) =
+-		ALLOC_ARRAY((sizeof(MULTIBYTE_TYPES)), COUNT, GFP)
++		ALLOC_OBJS(MULTIBYTE_TYPES, COUNT, GFP)
+|
+// Same by expression: u32 *p = kcalloc(sizeof(*p), n, gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) =
+-		ALLOC_ARRAY((sizeof(MULTIBYTE)), COUNT, GFP)
++		ALLOC_OBJS(MULTIBYTE, COUNT, GFP)
+|
+// Exclude other multi-byte arrays:
+//   s16 (*pairs)[2] = kcalloc(sizeof(s16), n, gfp)
+	ALLOC_ARRAY((\(sizeof(MULTIBYTE_TYPES)\|sizeof(MULTIBYTE)\)), COUNT, GFP)
+|
+// Exclude other arrays assigned to a multi-byte pointer:
+//   u32 *p = kcalloc(sizeof(*hdr), n, gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) = ALLOC_ARRAY((\(sizeof(E)\|sizeof(TYPE)\)), COUNT, GFP)
+|
+// Exclude arrays of void pointers: kcalloc(sizeof(void *), n, gfp)
+	ALLOC_ARRAY((sizeof(void *)), COUNT, GFP)
+|
+// Convert any other expression: p = kcalloc(sizeof(*p), n, gfp)
 -	ALLOC_ARRAY((sizeof(E)), COUNT, GFP)
 +	ALLOC_OBJS(E, COUNT, GFP)
 |
+// Convert any other type: p = kcalloc(sizeof(struct item), n, gfp)
 -	ALLOC_ARRAY((sizeof(TYPE)), COUNT, GFP)
 +	ALLOC_OBJS(TYPE, COUNT, GFP)
 |
+// Convert flexible array structures: p = kmalloc(struct_size(p, data, n), gfp)
 -	ALLOC(struct_size(VAR, FLEX, COUNT), GFP)
 +	ALLOC_FLEX(*VAR, FLEX, COUNT, GFP)
 |
+// Same by type: kmalloc(struct_size_t(struct item, data, n), gfp)
 -	ALLOC(struct_size_t(TYPE, FLEX, COUNT), GFP)
 +	ALLOC_FLEX(TYPE, FLEX, COUNT, GFP)
 )
-- 
2.34.1

