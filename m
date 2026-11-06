Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59F1606A32C
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=YrESmuVi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:to:from:cc:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=U+GMiC/0PnCN2U2/dRiS6xeO1SVteXmyJzYr93GAZi8=;
  b=YrESmuVijuiRD61n1aOMtkdRzgbXYKPURuNzPcKOSn9JVuengProsbNU
   5AMQU54VuvRMmeKML25RdHIYa2Q/CnC12rNueW5HzcAZViqAn30sEqRmk
   oBjHYEMSuwc5dA7qG9oKDYW9j8+5WCtnVve+Sfp8s4oR1YRxK70ouKMrA
   4=;
X-CSE-ConnectionGUID: nHuZObNlQ9q8MGJi/ZZNPA==
X-CSE-MsgGUID: 9Go8dmmbSmaj7XQiO2giiA==
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
   d="scan'208";a="304323748"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:31 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5090A8174C; Sat,  7 Nov 2026 11:59:31 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B2F1D80F0F
	for <cocci@sympa.inria.fr>; Fri,  6 Nov 2026 20:35:41 +0100 (CET)
X-CSE-ConnectionGUID: JxoYeQtHQ4CqmzPvcMzPqg==
X-CSE-MsgGUID: dIvJjZDWSWiqqNB7Y/nI3g==
IronPort-SDR: 6aee2c04_/OVTYkzVAnMJKYdfnWYZBR+9aCpn+bKYk1/lSZ1j2JzllW1
 2mqYAcDznhYEVpGLqrpbx3fc+pvLMVcpdJU3CkA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EJAgCnK+5qeRlqh09aglmCQYFrNAcISYRYkXScT4FVF?=
 =?us-ascii?q?IFoAg8BAwENUQQBAQECAQOEfo4gAh8GAQQxCA4BAgQDAgMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQEEAQEBAgEBAgQDAQEBAQIQAQFCDjuGTw2MGgEzghYsDYEAJwQZAQE3A?=
 =?us-ascii?q?TQCJgJeARKDAoIjAQZLB71HfzOBAYIMAQEGgmrZS4FpAgkUAYEKLohiAYY0C?=
 =?us-ascii?q?YJWaYEhG4FJRIEVg2mEKYN2GYJRgzKCXYU9jyaBShwDWSwBVRMXCwcFgWgDK?=
 =?us-ascii?q?i8tbjIdgSM+Fy9YGwYFgR2BHoESgQddgSsoXQEhgQiBdgKCUYIAAgFJQQ4HR?=
 =?us-ascii?q?VMJJUMSRyQiCBIJARMaLAqBGjU8CSY/FQxkCxoFYQgCDQx0ORAwHiQvBRwmP?=
 =?us-ascii?q?hsKNm09NxUZBJN1giByWDYBCgmBCx48MCIpkxyzT4QqoV5Nh3abS4cvAS6HX?=
 =?us-ascii?q?ZB9I6QBhSCBagE3gVwzGggbFYMiUAMZD5IkywxHMj0CBwIHDgMLkhyBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 lTZiYyJrI9XhKIx/Qtdl6ZpJSwk
IronPort-HdrOrdr: A9a23:CVa5Ea8LtEZ+JWTC9nRuk+DiI+orL9Y04lQ7vn2ZhyY7TiX+rb
 HLoB17726QtN91YhodcL+7UpVoPkm9yXcY2+Us1NSZLWvbUQmTTb2KhLGKqwEIcBeRygcy78
 pdWpk7Mdm1KVRhl8717E2ZPr8bsbq6zJw=
X-Talos-CUID: =?us-ascii?q?9a23=3Ad3nlFmmDQqvfSaawJWcX065HnpnXOV/Ny0bdGlO?=
 =?us-ascii?q?YMDpCUbiHcUGb3bFcisU7zg=3D=3D?=
X-Talos-MUID: 9a23:nx+LEAUXYTGIIQ3q/DPNmhNgButX2JuvEVkru8o3/M+lbiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,199,1787004000"; 
   d="scan'208";a="304269308"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDH702paYxMwrwVfFjLN/u2gEAAhevBN7bPJ1C?=
 =?us-ascii?q?Mw6vgjY/jp0gJlfcMalIhepZP336ppyRczR4q3bPRCpOwSWOQJol6rPv?=
 =?us-ascii?q?FKlwa/1zxpXHq7nF0es+miKUvzPBOV3yJzN623LCEeXTcb/DJZrJ7/hl?=
 =?us-ascii?q?C/TF0JDvYE0/P0ju98KdhSZA=3D=3D?=
Received: from mail-10625.protonmail.ch ([79.135.106.25])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 20:35:32 +0100
Date: Fri, 06 Nov 2026 19:35:25 +0000
To: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
From: Chad Aldreda <ca@modelmiser.com>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org
Message-ID: <20261106193517.3267013-2-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 0919c766be63babccd11c4cbbbda29866fc3fbaa
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] coccinelle: api: add a checker for device nodes in
 devm_ memory
Reply-To: Chad Aldreda <ca@modelmiser.com>
X-Loop: cocci@inria.fr
X-Sequence: 3783
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/3Ps9e08SK4FeWdrZvcZVSQ>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A struct cdev, struct miscdevice, struct video_device or struct
v4l2_device embedded in memory from devm_kzalloc() and friends is freed
when the driver unbinds, but a file that user space holds open on the
node outlives the unbind. Its later file operations are a use-after-free
when they use that memory, and for a cdev or video_device so is its
close(), where the core touches the object and the v4l2_device the
video_device points to.

Add a script that reports such allocations: by two rules when the
allocation, as an assignment or a declaration initializer, and a
registration of it or of an address taken inside it are written directly
in one function, and by a third, type-based rule when the struct is
defined in the same .c file and the node is a direct member of it. A
registration in a helper function on a struct defined in a header is not
seen, so cx231xx is reported only through its v4l2_device.

On 7.4-rc1 it reports 101 sites under drivers/, 50 of which are found
only through a v4l2_device. Not all are actionable: some drivers cannot
be unbound, and some miscdevice drivers never use the allocation after
open(); the header lists the false-positive classes and the misses.

Tested with spatch 1.1.1, with make coccicheck MODE=3Dreport and MODE=3Dorg=
,
and on small test files for each allocation form, a struct in a header,
a registration in a helper, a node in an array member, a registered
pointer to separate memory, a v4l2_device, an embedded node that is
never registered and a kzalloc() control.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Chad Aldreda <ca@modelmiser.com>
---
The type rule uses --include-headers-for-types, which reports the same
101 sites on every run. With --include-headers it also sees structs
defined in headers: run on one file at a time, that adds 22 sites on
7.4-rc1 (xilinx-vipp and ultrasoc-smb among them). Under --dir, as make
coccicheck runs it, some are lost. spatch --include-headers --dir
drivers/media/pci/intel/ipu6 reports nothing, even as a single process,
while the same command on drivers/media/pci/intel/ipu6/ipu6-isys.c alone
reports line 990. With six jobs the rest vary as well: five runs over
drivers/ found 15 to 17 of the 22, a different set each time.

So I kept the deterministic option. Is the --dir difference expected,
and is there a better way to give the type rule header-defined structs?

 .../coccinelle/api/devm_file_reachable.cocci  | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 scripts/coccinelle/api/devm_file_reachable.cocci

diff --git a/scripts/coccinelle/api/devm_file_reachable.cocci b/scripts/coc=
cinelle/api/devm_file_reachable.cocci
new file mode 100644
index 0000000000..3847710798
--- /dev/null
+++ b/scripts/coccinelle/api/devm_file_reachable.cocci
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Find a struct cdev, struct miscdevice, struct video_device or struct
+/// v4l2_device embedded in memory from the devm_ allocators.  The memory
+/// is freed when the driver unbinds, but a file that is open on the node
+/// outlives the unbind: for a cdev or a video_device the core touches the
+/// object, and the v4l2_device the video_device points to, on every
+/// close, and for a miscdevice the driver's file operations usually reach
+/// it through file->private_data.  Allocate such state with kzalloc() and
+/// free it on the last reference; see
+/// Documentation/driver-api/driver-model/devres.rst.
+///
+/// The first rules need the allocation and a registration of it, or of an
+/// address taken inside it, written directly in one function; an
+/// allocation inside a condition or behind a cast or a wrapper function
+/// is not seen by them. The type rule catches the rest, but with the
+/// options below it sees only a struct defined in the .c file itself, not
+/// in a header, and only a node that is a direct, non-array member of it,
+/// not one nested in another member. So a registration in a helper
+/// function, or through any alias of x such as vfd =3D &x->vdev, is misse=
d
+/// when the struct is in a header or the node is not such a member. Not
+/// checked: a struct media_device in devm_ memory, which v4l2_release()
+/// also reaches; a struct v4l2_subdev with a device node, whose close
+/// reaches it; a static node whose file operations reach devm_ state
+/// through a global or drvdata pointer; memory freed by devm_add_action()
+/// rather than allocated by devm_k*(); a typedef'd struct; and a file or
+/// function spatch cannot parse.
+/// False positives: a driver that cannot be unbound (suppress_bind_attrs,
+/// platform_driver_probe()) on a device that is never removed, a driver
+/// whose remove() waits for the last close, a miscdevice driver whose fil=
e
+/// operations do not use the allocation after open(), a registration of
+/// an address that only uses the allocation to reach separate memory
+/// (&x->ptr->misc, &table[x->idx]), a v4l2_device that no video_device
+/// points to, and, for the type rule, a struct whose embedded node is not
+/// registered from this allocation.  When an allocation has several
+/// registrations, the report names the first one found.
+///
+// Confidence: Moderate
+// Options: --include-headers-for-types
+
+virtual org
+virtual report
+
+@initialize:python@
+@@
+seen =3D set()
+
+@alloc depends on org || report exists@
+expression x, e, e2;
+identifier fn =3D~ "^devm_k[mzcr]";
+position p, q;
+@@
+
+x =3D fn@p(...);
+... when !=3D x =3D e
+(
+misc_register@q(\(x\|&<+... x ...+>\))
+|
+cdev_add@q(\(x\|&<+... x ...+>\), ...)
+|
+cdev_device_add@q(\(x\|&<+... x ...+>\), ...)
+|
+video_register_device@q(\(x\|&<+... x ...+>\), ...)
+|
+video_register_device_no_warn@q(\(x\|&<+... x ...+>\), ...)
+|
+__video_register_device@q(\(x\|&<+... x ...+>\), ...)
+|
+v4l2_device_register@q(e2, \(x\|&<+... x ...+>\))
+)
+
+@allocdecl depends on org || report exists@
+identifier x;
+type T;
+expression e, e2;
+identifier fn =3D~ "^devm_k[mzcr]";
+position p, q;
+@@
+
+T *x =3D fn@p(...);
+... when !=3D x =3D e
+(
+misc_register@q(\(x\|&<+... x ...+>\))
+|
+cdev_add@q(\(x\|&<+... x ...+>\), ...)
+|
+cdev_device_add@q(\(x\|&<+... x ...+>\), ...)
+|
+video_register_device@q(\(x\|&<+... x ...+>\), ...)
+|
+video_register_device_no_warn@q(\(x\|&<+... x ...+>\), ...)
+|
+__video_register_device@q(\(x\|&<+... x ...+>\), ...)
+|
+v4l2_device_register@q(e2, \(x\|&<+... x ...+>\))
+)
+
+@embeds depends on org || report@
+identifier S, f;
+type T =3D {struct cdev, struct miscdevice, struct video_device,
+          struct v4l2_device};
+@@
+
+struct S {
+  ...
+  T f;
+  ...
+};
+
+@bytype depends on org || report@
+identifier embeds.S;
+struct S *x;
+identifier fn =3D~ "^devm_k[mzcr]";
+position p;
+@@
+
+x =3D fn@p(...)
+
+@script:python depends on org@
+p << alloc.p;
+q << alloc.q;
+@@
+if (p[0].file, p[0].line, p[0].column) not in seen:
+    seen.add((p[0].file, p[0].line, p[0].column))
+    coccilib.org.print_todo(p[0], "WARNING: devm_ memory registered at lin=
e %s as a device node or a v4l2_device; an open file outlives unbind" % q[0=
].line)
+
+@script:python depends on report@
+p << alloc.p;
+q << alloc.q;
+@@
+if (p[0].file, p[0].line, p[0].column) not in seen:
+    seen.add((p[0].file, p[0].line, p[0].column))
+    coccilib.report.print_report(p[0], "WARNING: devm_ memory registered a=
t line %s as a device node or a v4l2_device; an open file outlives unbind" =
% q[0].line)
+
+@script:python depends on org@
+p << allocdecl.p;
+q << allocdecl.q;
+@@
+if (p[0].file, p[0].line, p[0].column) not in seen:
+    seen.add((p[0].file, p[0].line, p[0].column))
+    coccilib.org.print_todo(p[0], "WARNING: devm_ memory registered at lin=
e %s as a device node or a v4l2_device; an open file outlives unbind" % q[0=
].line)
+
+@script:python depends on report@
+p << allocdecl.p;
+q << allocdecl.q;
+@@
+if (p[0].file, p[0].line, p[0].column) not in seen:
+    seen.add((p[0].file, p[0].line, p[0].column))
+    coccilib.report.print_report(p[0], "WARNING: devm_ memory registered a=
t line %s as a device node or a v4l2_device; an open file outlives unbind" =
% q[0].line)
+
+@script:python depends on org@
+p << bytype.p;
+S << embeds.S;
+@@
+if (p[0].file, p[0].line, p[0].column) not in seen:
+    seen.add((p[0].file, p[0].line, p[0].column))
+    coccilib.org.print_todo(p[0], "WARNING: devm_ allocation of struct %s,=
 which embeds a cdev, miscdevice, video_device or v4l2_device" % S)
+
+@script:python depends on report@
+p << bytype.p;
+S << embeds.S;
+@@
+if (p[0].file, p[0].line, p[0].column) not in seen:
+    seen.add((p[0].file, p[0].line, p[0].column))
+    coccilib.report.print_report(p[0], "WARNING: devm_ allocation of struc=
t %s, which embeds a cdev, miscdevice, video_device or v4l2_device" % S)
--=20
2.43.0


