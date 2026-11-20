Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65A6606A336
	for <cocci@archiver.kernel.org>; Fri, 20 Nov 2026 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=dugpSWhq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:mime-version:message-id:from:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=1yx6W4KWxYBM/lEeFWv6HyZHXQa1lQq2Z18yHuwNiTg=;
  b=dugpSWhqwiKNhSgI1qm8ksu2SeqptT8Ks/6htpgj6uhO+IwEg3k7Kqc/
   t3M4J+ZuLnlv4+Bd4o4VtFRe8n0yWObuBd9uyk0k6XBP7mWjx5LjH+zSR
   Q94DL2xrXKK7fde1Ebs+DbYmYT9wJ02YbaoC5anM+58+gjldzZtP37IfA
   I=;
X-CSE-ConnectionGUID: GUxR4FjbS4ONhSOsfIexdQ==
X-CSE-MsgGUID: Ff5FDBScSRiQLcHx+K4dJw==
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
   d="scan'208";a="306545958"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Nov 2026 14:29:58 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9502D81B89; Fri, 20 Nov 2026 14:29:57 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5C45781335
	for <cocci@sympa.inria.fr>; Fri, 20 Nov 2026 10:26:55 +0100 (CET)
X-CSE-ConnectionGUID: zkOEUbhfQTiazs6AtgWD3w==
X-CSE-MsgGUID: bFsqTS8WTcqFXqzn/of7ZQ==
IronPort-SDR: 6b00125e_jLpQGMmP/MYV9RfPfECoCssuhjmACzh6VaNB++B+wYgkza8
 hQ3qb+Cco0W6faWNmvhgMAc3baAp8OSNY2sdbSw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GGAwA9EQBrgUaAVdFahRqBC2A0BAsZMASEVI9TgiGfU?=
 =?us-ascii?q?ANVEQEDAQ1EDQQBAQECBIR6Ao4mAh4HAQQ0EwECBAMCAwEBAQEBAQEBAQEBC?=
 =?us-ascii?q?wEBAQQBAQECAQECBAMBAQEBAhABASIZBw47hk8NjBqBJYEmAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBFwINOm0EGQEBNwE0AiYCNQEFATWDAgGCIgEGSwMRrX6Lcn8zg?=
 =?us-ascii?q?QGCDAEBBoJr2zMCAwYUAQGBCS6GCIJaAYFxgxJ2gxppgSEbgg2BFYNqgVKBD?=
 =?us-ascii?q?wICgTwBAYN8gmqCERWBDJhiCT9+BBwDWSwBVRMNCgsHBYFoAzUSIQkVbjIdg?=
 =?us-ascii?q?SM7Fy9YGwYFgRxCXIESgQNdgSsoXQEhM1WBdgKCUYIAAgFJQQ4HRVMJJUMSR?=
 =?us-ascii?q?yQiCBIJARMaLAqBGjU8CSY/FQxnAwgaBWEIAg0MdDkQMB4kLwUaJj4bCoEMJ?=
 =?us-ascii?q?x8eGw4CHxAGDRgNSBEsNxUZBD5uB5NsgxkBUhArCwkYTgIEBDlyk18CkByhd?=
 =?us-ascii?q?IE+hCuEdYN3gziVOhozhASUGpJULod9kF2MEIF6lWOFRxEkgVsjPIEgMxoIG?=
 =?us-ascii?q?xWDIlADGQ+SJIUTySZHMgIBOgIHAgcOAwuSHIFMAQE?=
IronPort-PHdr: A9a23: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
 5YP3Em2+A==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:kkOyxankqKw5gda4QZKcjralAjrpDfIC3DAbv31ZSRFFG/FwWf
 re+sjztCWE8Qr5PUtLpTnuAsi9qB/nhPpICOsqTNWftXjd2FdARbsKheDfKlbbakjDH4BmpM
 BdWpk7J9vqE1BggMr2pCW+Gc0x2cSK/cmT6ds2DE0DceipUcxdBn9Ce2Wm+4RNKjV7OQ==
X-Talos-CUID: 9a23:Y6JlsG9t7swguKRFddmVv1wXPe0YeH3T9UvRKl2jV091R4K5EkDFrQ==
X-Talos-MUID: 9a23:cOjEHQkNBjEyCRk9A8qYdnpoGtxx35/+N3wGiLs2otuCcit+ZAWk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,222,1787004000"; 
   d="scan'208";a="163391594"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEZ6jyLs5d+M7PFBylwFjlz6xXWHcE65Y34wy?=
 =?us-ascii?q?K0MJQxjZfDe6cuHrEcgoHL1xZ3TSWUp4yvpe0XAZZKTprBJZc32qXj4K?=
 =?us-ascii?q?8KLC9sVliyoA6DoeABuFYu9YFS8O68t/fnobaBTrItxSRbxJ9nsktiaL?=
 =?us-ascii?q?IIom5Dk5LdL8ySsTDVfG63sQ=3D=3D?=
Received: from mail-wm1-f70.google.com ([209.85.128.70])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 10:26:54 +0100
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a35db2d6b3so4411375e9.3
        for <cocci@inria.fr>; Fri, 20 Nov 2026 01:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795166813; x=1795771613;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1yx6W4KWxYBM/lEeFWv6HyZHXQa1lQq2Z18yHuwNiTg=;
        b=vGO51O/s+DW1I9JIMPoKOpcemOwsQY6lr8IrRdhFT4QM7X/8rHhT4ahuFqIwKX2kRT
         hmUv/i9yrcCtpRkDvqk1TV5Ilrugzim6nI7G92hdIAvTVBuaU/1O4MrCGF8oA2jD79su
         Vw+G9y1sDYr0HpCnAq8x2AGvLgqakdmhyuK0r+XccHpBsXRAcrAaP0Jn/IGo5dBEmQzh
         M/MFVLThH3IwgFBA+Nr4JbyuXmvVcOfjluV9Cm/z6MK5qyrous31bBgDTdZ+k0ZGZY57
         pgPtCYj2+4e5LdBCYzZ8CoqrFu4PbED87pAqbtk4Y4nJbUfcxT0P+oijoOB2QklMj9Go
         cueQ==
X-Forwarded-Encrypted: i=1; AL+hErF89a7SNjzLwRgO+G8cRWkFbm9PPsnLfEVpGb9jQE3lJQ4dyURCnZFTgase+81SRFtCwmniHw==@inria.fr
X-Gm-Message-State: APuU4Z+G0pbzvSSimuFEhxsIIKNeDC1yDtxD7cIe3hHZEk1vX5YuHAhH
	aOvUBFAHNUxvSMfOi17rIFIVBAOloafC+Jux9LJTDSoZGss/uQnwdukwC7J2XETu6dTMU28y5Bu
	LGQ==
X-Received: from wmgi5.prod.google.com ([2002:a05:600c:2d85:b0:4bb:52ec:7054])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f16:b0:4a2:47:b79c
 with SMTP id 5b1f17b1804b1-4bb8882a66emr57694005e9.32.1795166813334; Fri, 20
 Nov 2026 01:26:53 -0800 (PST)
Date: Fri, 20 Nov 2026 09:26:40 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120092646.3062639-1-elver@google.com>
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, cocci@inria.fr, kasan-dev@googlegroups.com, 
	Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2] coccinelle: locks: Add must_hold.cocci
Reply-To: Marco Elver <elver@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 3817
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/8zTByJqlvzWAA3fMM_tn9A>
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
lock is held, where the lock can be named in a function attribute, and
which are not annotated with __must_hold*(), __releases*(),
__context_unsafe() or __no_context_analysis. A lock can be named if all
identifiers in the lock expression are parameters or member names, or if
it is a global of the form &name or &name.member. Functions that mention
the lock before asserting it, e.g. to acquire it, are skipped.

lockdep_assert_held() passes for any mode, so for it the script cannot
tell __must_hold() from __must_hold_shared() and reports both.

For example, on v7.4-rc2:

  kernel/locking/rwsem.c:396:1-20: rwsem_del_waiter() asserts &sem->wait_lock is held but lacks __must_hold(&sem->wait_lock) or __must_hold_shared(&sem->wait_lock)
  kernel/futex/pi.c:919:1-20: fixup_pi_state_owner() asserts q->lock_ptr is held but lacks __must_hold(q->lock_ptr) or __must_hold_shared(q->lock_ptr)
  drivers/nvme/host/fabrics.c:650:1-20: nvmf_lookup_transport() asserts &nvmf_transports_rwsem is held but lacks __must_hold(&nvmf_transports_rwsem) or __must_hold_shared(&nvmf_transports_rwsem)

Limitations:

 - Annotations on a prototype in another file are not seen; non-static
   functions are reported with "check prototype".
 - Annotations are detected textually and are not matched against the
   asserted lock.
 - Functions that require a lock without asserting it are not found.
 - Only lockdep_assert_held{,_write,_read,_once}() and
   assert_{raw_,}spin_locked() are matched; wrappers such as
   lockdep_assert_wiphy() are not.
 - Functions that test the lock expression before the assertion, e.g.
   __futex_unqueue(), are skipped along with those that acquire it.
 - &name.member is assumed to be a global.

Cc: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/all/CANpmjNNM=qBJMvBkRu-WbhKA0hnkb_Bk8fyF9DTTsVmENDvZuQ@mail.gmail.com/
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Report both __must_hold() and __must_hold_shared() for
  lockdep_assert_held() (Bart).
* Fix detection of annotations on prototypes in the same file (Bart).
* Make "forall" explicit (Bart).
* Skip functions that mention the lock before asserting it (Bart).
* Require all identifiers in the lock expression to be parameters or
  member names; accept &name.member as a global (Bart).
* Match parameter names and "static" in SmPL instead of with regular
  expressions (Bart).
* Also match lockdep_assert_held_once() and assert_{raw_,}spin_locked()
  (Bart).
* Document skipped attributes and further limitations.
---
 scripts/coccinelle/locks/must_hold.cocci | 131 +++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 scripts/coccinelle/locks/must_hold.cocci

diff --git a/scripts/coccinelle/locks/must_hold.cocci b/scripts/coccinelle/locks/must_hold.cocci
new file mode 100644
index 000000000000..0acec2680aa6
--- /dev/null
+++ b/scripts/coccinelle/locks/must_hold.cocci
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Find functions that unconditionally assert that a lock is held, but lack
+/// the corresponding __must_hold() annotation. The compiler's context
+/// analysis does not check the callers of such functions.
+///
+/// Only locks that can be named in a function attribute are reported: either
+/// all identifiers in the lock expression are parameters or member names, or
+/// the lock is a global of the form &name or &name.member. Functions that
+/// mention the lock before asserting it (e.g. to acquire it) are skipped, as
+/// are functions annotated with __must_hold*(), __releases*(),
+/// __context_unsafe() or __no_context_analysis.
+//
+// Confidence: Moderate
+// Comments: Annotations on a prototype in another file are not seen; such
+//	     functions are reported with "check prototype". Annotations are
+//	     detected textually and are not matched against the asserted lock.
+//	     Wrappers like lockdep_assert_wiphy() are not handled.
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
+ATTRS = re.compile(r'__(must_hold|must_hold_shared|releases|releases_shared|'
+		   r'context_unsafe|no_context_analysis)\b')
+params = {}
+static = set()
+
+def key(pf):
+	return (pf[0].file, pf[0].line)
+
+def missing_must_hold(f, a, E, pf, p):
+	e = re.sub(r'\s+', '', E)
+
+	# Identifiers that are neither member names nor called functions.
+	free = re.findall(r'(?<![\w.>])[A-Za-z_]\w*(?!\w*\()', e)
+	if not (all(i in params.get(key(pf), ()) for i in free) or
+		re.fullmatch(r'&\w+(\.\w+)*', e)):
+		return None	# Cannot be named in an attribute.
+
+	with open(pf[0].file, errors='replace') as fp:
+		src = fp.read()
+
+	# Attributes on the definition, or on a prototype in the same file.
+	hdr = ''.join(src.splitlines(True)[int(pf[0].line) - 1:]).split('{')[0]
+	if ATTRS.search(hdr):
+		return None
+	for d in re.finditer(r'\b%s\s*\([^;{}]*;' % re.escape(f), src):
+		if ATTRS.search(d.group(0)):
+			return None
+
+	if a == 'lockdep_assert_held_read':
+		want = "__must_hold_shared(%s)" % e
+	elif a == 'lockdep_assert_held':
+		want = "__must_hold(%s) or __must_hold_shared(%s)" % (e, e)
+	else:
+		want = "__must_hold(%s)" % e
+	return "%s() asserts %s is held but lacks %s%s" % (
+		f, e, want, "" if key(pf) in static else "; check prototype")
+
+@prm@
+identifier f, x;
+type T;
+position pf;
+@@
+
+f@pf(..., T x, ...) { ... }
+
+@script:python@
+x << prm.x;
+pf << prm.pf;
+@@
+
+params.setdefault(key(pf), set()).add(x)
+
+@st@
+identifier f;
+position pf;
+@@
+
+static f@pf(...) { ... }
+
+@script:python@
+pf << st.pf;
+@@
+
+static.add(key(pf))
+
+@r forall@
+identifier f;
+identifier a = {lockdep_assert_held, lockdep_assert_held_write,
+		lockdep_assert_held_read, lockdep_assert_held_once,
+		assert_spin_locked, assert_raw_spin_locked};
+expression E;
+position pf, p;
+@@
+
+f@pf(...)
+{
+	... when != E
+	a@p(E);
+	...
+}
+
+@script:python depends on report@
+f << r.f;
+a << r.a;
+E << r.E;
+pf << r.pf;
+p << r.p;
+@@
+
+msg = missing_must_hold(f, a, E, pf, p)
+if msg:
+	coccilib.report.print_report(p[0], msg)
+
+@script:python depends on org@
+f << r.f;
+a << r.a;
+E << r.E;
+pf << r.pf;
+p << r.p;
+@@
+
+msg = missing_must_hold(f, a, E, pf, p)
+if msg:
+	coccilib.org.print_todo(p[0], msg)
-- 
2.56.1.750.gf70dc682cf-goog

