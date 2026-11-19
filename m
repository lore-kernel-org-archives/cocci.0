Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063A8606A32A
	for <cocci@archiver.kernel.org>; Fri, 20 Nov 2026 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=iJ6M9aFi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:mime-version:message-id:from:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cEP141ntu6kwVLUX4kI1ElJvMgyAzN7imZOIrBclONs=;
  b=iJ6M9aFiVIS8fKgRuuydI2REeCG4GP8NKZvyt7Dm6kiNUqxZj03IJx2s
   IJC8ikBsg484eun0kIDvFZ85Zz4Zdncr4bXF3XGPOrlDJd9JITkMoc9q+
   kHBu4JWM2RwrQ9GbJAl3mVsa8WHFsqDwRZrJoo6L52oGdvywogiEGwQeV
   A=;
X-CSE-ConnectionGUID: wGCPcy1pRK60pE1mt3scPg==
X-CSE-MsgGUID: wjdV/OqXSvi8HcrHsPZ1FQ==
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
X-IronPort-AV: E=Sophos;i="6.27,223,1787004000"; 
   d="scan'208";a="306545886"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Nov 2026 14:29:55 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B868B81B70; Fri, 20 Nov 2026 14:29:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A834C806A9
	for <cocci@sympa.inria.fr>; Thu, 19 Nov 2026 22:08:26 +0100 (CET)
X-CSE-ConnectionGUID: 9jkztGP2TdCd1+txt9Lexw==
X-CSE-MsgGUID: rhTQpd1dQoyeeKn3MdQaPA==
IronPort-SDR: 6aff6549_W41s0Aea4eAIy5NvvwJ4phn4wYodUzFFUybByI1+6If/nFa
 3ob3e5cUW4+GQ1jCW/YyeLgyOdBVlcuteatcA6w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EXAwDiY/9qgUXdVdFahRqBC2A0BAsZMASEVI9TgiGfU?=
 =?us-ascii?q?ANVEQEDAQ1EDQQBAQECBIR6Ao4lAh4HAQQ0EwECBAMCAwEBAQEBAQEBAQEBC?=
 =?us-ascii?q?wEBAQQBAQECAQECBAMBAQEBAhABATsHDjuGTw2MGoElgSYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEXAg06bQQZAQE3ATQCJgI1AQUBNYMCAYIiAQZLAxGuZItyfzOBA?=
 =?us-ascii?q?YIMAQEGgmvbMwIDBhQBAYEJLoYIgloBgXGDEoQQaYEhG4INgRWDaoFSgQ8CA?=
 =?us-ascii?q?oE8AQGDfIJqghEVgQyBcmSCIJNnCT9+BBwDWSwBVRMNCgsHBYFoAzUSIQkVb?=
 =?us-ascii?q?jIdgSM7Fy9YGwYFgRxCXIESgQNdgSsoXQEhM1WBdgKCUYIAAgFJQQ4HRVMJJ?=
 =?us-ascii?q?UMSRyQiCBIJARMaLAqBGjU8CSY/FQxnAwgaBWEIAg0MdDkQMB4kLwUaJj4bC?=
 =?us-ascii?q?oEMJx8eGw4CHxAGCBgNSBEsNxUZBD5uB5NqgxkBUjssTgIEBDlyOJMpshCBP?=
 =?us-ascii?q?oQrhHWDd4M4lToaM6pxAS6HfZBdjBCBepVjhUcRJIFbIzyBIDMaCBsVO4JnU?=
 =?us-ascii?q?AMZD5IkhRPJJ0cyAgE6AgcCBw4DC5IcgUwBAQ?=
IronPort-PHdr: A9a23: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
 5UHyBrZwKT7D7Q=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:j7F82qPPh/YCmMBcTu+jsMiBIKoaSvp037Dk7TEWdfU1SL3gqy
 nKpp4mPHDP6Qr5NEtQ/exoWpPwI080hKQU3WB5B97LNzUO01HYSb2Kg7GSpAHIKmnQ8PVC3b
 xsf6U7JNr7FkhikMr2iTPVLz/i+ra6GWKT6Ns2t00dLj2CopsP0ztE
X-Talos-CUID: =?us-ascii?q?9a23=3AsLdrbGhi4Uf/8WkhGCb4VJkNCTJuI3/e3mv/GxW?=
 =?us-ascii?q?EBU1lEf6JWUPB3K50jJ87?=
X-Talos-MUID: 9a23:sG7oqQTMjrbB9wqvRXT2hA1bLMsx752pGU0AspNdnsW9PBRZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,221,1787004000"; 
   d="scan'208";a="163323129"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHAoCX9AFE5O3cdCCRo9Zh5v9O5OhkglFH2J5?=
 =?us-ascii?q?KXeZmN9M51QhLWmxtGGp/cJMBZ3SqvrEFpHew9yF72jSYgsgxORt9c4O?=
 =?us-ascii?q?ai/x483C/XQIF0U+8GbzHgSOm5GoV1GuKHW2Ud19O3jckUgOXTn6GTci?=
 =?us-ascii?q?zJR/NxtC4qWVy23QzaoKiGnQ=3D=3D?=
Received: from mail-wr1-f69.google.com ([209.85.221.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 22:08:25 +0100
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4925ef75fc4so78209f8f.1
        for <cocci@inria.fr>; Thu, 19 Nov 2026 13:08:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795122505; x=1795727305;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEP141ntu6kwVLUX4kI1ElJvMgyAzN7imZOIrBclONs=;
        b=nTt18scfK0/KLrqT+JyCErcyxFYsiqCDl4S9GfXWA2F2jLy4dMmiY8HFG8gyis+4xf
         7m5OW5jd9EvU0oafOJ1M7rV5YoQvWR0AjJ6G5mHCCs2fRfPzsw+M6THrf3eB4CJBmNAU
         m0VkJDJDgklRXavUbPF6lLc+1WiaNM4jCR7PPyH9m37ASBBbyaV8KRyayD+O0ixRCh0x
         1zwTnXrwEHDxRsaK15B663kTNakCtzYiHa9b/W0Q3Dn8V6hHhKYiJgXOPw2OCOURoW6l
         l+eII0Hxl2f83prCgNY41k8InnLRnF9CZD8n0xO/elzgJmimzKU4Jzs8Mf1RO11qKjJC
         7dKw==
X-Forwarded-Encrypted: i=1; AL+hErH4+T/1GVgVjgak7mK50NTyxl3fOFi9RltcIpHF7tF+vPJmMscTMtgJopNwIJzQGR9jE34Qsg==@inria.fr
X-Gm-Message-State: APuU4Z+BxxPDFUn7U9LPeowgF774om8MAnwEx8hS6vTA+FQUQx049pUN
	BFPpYDPWlRpqt6XYfVVtVOCozwWPjuS4CIuPnkKwqzCMbC6pbyWvUCWOaCSxTC8sD/iOzdaC0ye
	Jyg==
X-Received: from wrbdh5.prod.google.com ([2002:a05:6000:a85:b0:48a:f5b5:2f71])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:989:b0:4a8:2fb7:e610
 with SMTP id ffacd0b85a97d-4abaab6344bmr1579956f8f.2.1795122504495; Thu, 19
 Nov 2026 13:08:24 -0800 (PST)
Date: Thu, 19 Nov 2026 21:07:56 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119210807.211041-1-elver@google.com>
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, cocci@inria.fr, kasan-dev@googlegroups.com, 
	Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH] coccinelle: locks: Add must_hold.cocci
Reply-To: Marco Elver <elver@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 3815
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/NEyQ1ScqTYemAlQ2NQlHTw>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clang's context analysis treats lockdep_assert_held*() as an assumption
that the lock is held. A function that asserts instead of being
annotated with __must_hold() therefore passes the analysis, but its
callers are never checked.

Add a script that reports functions which assert on all paths that a
lock is held, where the lock can be named in a function attribute (it is
reachable from a parameter or is a global lock), and which lack a
__must_hold*() or __releases*() annotation.

For example, on v7.4-rc2:

  kernel/locking/rwsem.c:396:1-20: rwsem_del_waiter() asserts &sem->wait_lock is held but lacks __must_hold(&sem->wait_lock)
  kernel/locking/rwsem.c:437:1-20: rwsem_mark_wake() asserts &sem->wait_lock is held but lacks __must_hold(&sem->wait_lock)
  kernel/futex/pi.c:919:1-20: fixup_pi_state_owner() asserts q->lock_ptr is held but lacks __must_hold(q->lock_ptr)
  drivers/nvme/host/fabrics.c:650:1-20: nvmf_lookup_transport() asserts &nvmf_transports_rwsem is held but lacks __must_hold(&nvmf_transports_rwsem)

Limitations:

 - Annotations on a prototype in another file are not seen; non-static
   functions are reported with "check prototype".
 - Annotations are detected textually and are not matched against the
   asserted lock.
 - Functions that require a lock without asserting it are not found.

Cc: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/all/CANpmjNNM=qBJMvBkRu-WbhKA0hnkb_Bk8fyF9DTTsVmENDvZuQ@mail.gmail.com/
Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/coccinelle/locks/must_hold.cocci | 100 +++++++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 scripts/coccinelle/locks/must_hold.cocci

diff --git a/scripts/coccinelle/locks/must_hold.cocci b/scripts/coccinelle/locks/must_hold.cocci
new file mode 100644
index 000000000000..ba45544afc46
--- /dev/null
+++ b/scripts/coccinelle/locks/must_hold.cocci
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Find functions that unconditionally assert with lockdep that a lock is
+/// held, but lack the corresponding __must_hold() annotation. For such
+/// functions the compiler's context analysis trusts the assertion instead of
+/// checking the callers.
+///
+/// Only locks that can be named in a function attribute are reported, i.e.
+/// those reachable from a parameter or a global lock (&lock). Assertions on
+/// locks reached through local aliases are skipped.
+//
+// Confidence: Moderate
+// Comments: Annotations on a prototype in another file are not seen; such
+//	     functions are reported with "check prototype".
+// Options: --no-includes --include-headers
+
+virtual report
+virtual org
+
+@initialize:python@
+@@
+
+import re
+
+def squash(s):
+	return re.sub(r'\s+', '', s)
+
+def missing_must_hold(f, ps, E, pf, p):
+	e = squash(E)
+	m = re.match(r'[&(]*(\w+)', e)
+	if not m:
+		return None
+	params = re.findall(r'(\w+)\s*(?:\[[^\]]*\]\s*)*(?:,|$)', str(ps))
+	if m.group(1) not in params and not re.fullmatch(r'&\w+', e):
+		return None	# Local alias: cannot be named in an attribute.
+
+	with open(pf[0].file, errors='replace') as fp:
+		lines = fp.readlines()
+	first, last = int(pf[0].line), int(p[0].line)
+
+	# Attributes between the declarator and the assertion.
+	hdr = ''.join(lines[first - 1:last - 1])
+	if re.search(r'__(must_hold|must_hold_shared|releases|releases_shared|'
+		     r'context_unsafe|no_context_analysis)\b', hdr):
+		return None
+
+	# Attributes on a prototype in the same file.
+	for d in re.finditer(r'\b%s\s*\([^;{}]*\)([^;{}]*);' % re.escape(f),
+			     ''.join(lines)):
+		if '__must_hold' in d.group(1):
+			return None
+
+	static = 'static' in ''.join(lines[max(first - 3, 0):first])
+	shared = 'lockdep_assert_held_read' in lines[last - 1]
+	return "%s() asserts %s is held but lacks __must_hold%s(%s)%s" % (
+		f, e, "_shared" if shared else "", e,
+		"" if static else "; check prototype")
+
+@r@
+identifier f;
+parameter list ps;
+expression E;
+position pf, p;
+@@
+
+f@pf(ps)
+{
+	...
+(
+	lockdep_assert_held@p(E);
+|
+	lockdep_assert_held_write@p(E);
+|
+	lockdep_assert_held_read@p(E);
+)
+	...
+}
+
+@script:python depends on report@
+f << r.f;
+ps << r.ps;
+E << r.E;
+pf << r.pf;
+p << r.p;
+@@
+
+msg = missing_must_hold(f, ps, E, pf, p)
+if msg:
+	coccilib.report.print_report(p[0], msg)
+
+@script:python depends on org@
+f << r.f;
+ps << r.ps;
+E << r.E;
+pf << r.pf;
+p << r.p;
+@@
+
+msg = missing_must_hold(f, ps, E, pf, p)
+if msg:
+	coccilib.org.print_todo(p[0], msg)
-- 
2.56.1.750.gf70dc682cf-goog

