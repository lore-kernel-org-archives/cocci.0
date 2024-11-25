Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5035D58D69
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5x0yPCIryoiXTXe24z13INkplAFzoVmn1x49aPuCCtY=;
  b=mi21+Xbq0l6XJMS9kcr4ma4hsatoIkg3Ez275S2g7XzCviDX6xKcEp2J
   KR4jTCFZUjiN0HG0J5tLKeU7hZ+mI1S+XZdi2U/AU0eZvSSY5qxYyjflY
   PQc7c4tebPX4VWTBpOb2tsu0JixazqrY3VZ80Ni0bHUwuh3v5Ch0GMYvn
   8=;
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
   d="scan'208";a="195724201"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 31358E0D74; Mon, 25 Nov 2024 17:57:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E375CE00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 11:40:39 +0100 (CET)
IronPort-SDR: 67445427_jL/u4iWlOd9P7udVv1QpOjEjDSN9syfSI3040q/ln/M3BDF
 EeU2utyiuPtpVbfiPeJ5Kbe26J2Mq7jfHjwQw+A==
X-IPAS-Result: =?us-ascii?q?A0FJAADMUkRn/6Mwd6haHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDB2lmNAQLSIRWkW4DgROQN4xNFAyBXg8BAwENRAQBAQMBA4UAA?=
 =?us-ascii?q?opZAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECgQoTh?=
 =?us-ascii?q?XsNgmIBdIEkAQEBAQEBAQEBJysCgQsCAQMjDwENAQE3AQ8gBQIYDgICPQEYG?=
 =?us-ascii?q?YMBgjEBAQExA69ygTKBAYIMAQEGglDYLgQKGg2BMIEgCYEaLgGISwGFaYMUa?=
 =?us-ascii?q?XonG4INgRWBO4E3doIfgWcUhASCaYJEgTGDXiWFN4NJmzMHB2FeHANZIREBV?=
 =?us-ascii?q?RMXCwcFgXYDg0aBNiiBKYMRSoUMRj2CSmlNNwINAjaCJH2CTYUZg0aBI2UvA?=
 =?us-ascii?q?wMDA4ITgSuGBh03CQMLbT03CAwbBj0IQh0SoBtGg0EHAYENAS8dLmBwDZMKL?=
 =?us-ascii?q?rMOC4I/gWWKdpZNTZdRkwCIL5BMo3IBGIUdYIEOAzOBWXFPgTIagRtPAxkPj?=
 =?us-ascii?q?iGELccQRTI7AgcBCgEBAwmCOY5NNIFLAQE?=
IronPort-PHdr: A9a23:8XeOsRCnLMGlGoVhNNSAUyQUmEkY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua40ygOUFtyFo7Ic0qyK6PimATRBqb+681k8M7V0FCU5wf0MmAIhBMPXQWbaF9XNKxIAI
 cJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQka3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+N
 hq7oAvMusUMjoZvKqk9xgbIr3BVf+ha2X5kKUickhvy+su85oJv/zhVt/k868NOTKL2crg3Q
 rBfEDkoKWc56tH1uxLeVwWP/HwcUmsXkhpMHQfI6QzxU4nyvCXnqOdzwTGWMsLqQ786XzSi9
 LprRwTziCgbLT458XrYhdJ2galGvR+uvR1/w4rTYIGIKPpze77WcN0GSWZdWMtaSjdMCZ2gY
 YQRE+UBPP5Yr4jjqFsIsRu+HhSnCOf2xjNVmnP6wag23uI8Gg/EwQMgBcoDvnTKotjrKakcX
 +O7w6vGzTXZYPxZxTjz5ZPUch0iu/yAQa58fdbTxEQpCgjLjk+QqYvgPz6NyOkNs3Kb7+t7V
 eKzim4osQdxqSWuyN8qlonJmpkVxUzE9Spn3Y04IsG3SEF8YdG6DJtQqzqaOJd2Qsw8WGxoo
 zg1yrkauZGleigF1ZMnxxnRa/CdboeH/AvuWeCMKjh3mHxrYqiwhwqu8Ue+0O38UNG53lhEo
 ydEnNTAqH8D2wDO58aIRPZw/Uev1DaR2gzN9+xJIEA6m6rHJpMh37M9lpgevEDfEiH4mEj4g
 rGaelg49uWu9u/pYa3mq4eBO4J1iQzyKLkiltG7DOgiPQUDXHKX9fm92bDt+0DyXatHjvkrk
 qnCrJDVO94bqLO4Aw5UzIku8xiyAjG729oCh3YHNkhKeBefgojpJV7OJPf4AO+kg1uyijdr2
 e7JPqf9DpnTNHTDi6nufbJh60FCzgo80Ndf55VaCr0bPf38RFf9tN3eDhAnLwy52/vrBdR+2
 48ERG6DH6uUPLndvFKL/O4jPuiBaYENtDb4Mfcl5vrujXEjmV8aeKmkxYcYaH+/Hvt4P0WZf
 WHsjcsBEWgUpQc+V/LliFmeUTFNYXa9QqU85jY1CI68EIjMWJihgLqa0yijBJ1ZenhGCkyQE
 Xfvb4iIRe8AaDiOLc95jjwESb+hRpcl1R60ug710b5nLu7P9ywZtJLj0cN65/fJmh0o9Dx0C
 d6d02CXQG1ukGMIXSc63Lpjrkxl1leDza94juREGtxU+/xGTgY6OIXHz+16DtDyQhjOcs2IS
 FagWNWmACs+Qsg/w98UMA5BHICmjxbez2+xDrQIjb2XFdkx9a7B23XZOclw0TDF2bMngl1gR
 dFAZlernqpuyw+GDIHblEOUjI6lcqMT2CPI/WaHi2GJuRJ2Sgl1BI7FR3EEekrfq5zWeF/eV
 LSuBPxzOQRGxNKeMaBKZ/XygFFaSfHvP9PQJW68zTTjTS2Uz6+BOdK5M14W2z/QXQ1dy1h7F
 ReuMAE/AnzkuGfCFHl1EkqpZUrw8O54oXf9T0kuzgjMYVcyn6Gt9EszgvqRA+gWwqpCoD0o/
 j57G1uhw8ndC9eovAdlYKhabdQ67hFL2DGRrBRza6SpNLsqnVsCa0JytkLq2Q9wD9BLns8ns
 G8xxwp/AbmV1E9McT+f2p62NrCEYnLq8kWJbKjbkkrbzM7Q+qoL76EgrE7/uQiyCkc4225qy
 cdYySPGoI7HCBYfV572VUhx+xUSS6jyRC476suU0HRtNfLxqTrew5cyA/NjzB+8ftBZOafCF
 QnoEsRcCdL8YOot00OkaB4JJoUwvOY9It+mev2a2aWqIPconTSoin5C6Zx81UTE/jR1S+rB1
 ZIIi/+C2Q7PWzD5hVan+sf5/OIMLTodGWej1TPvBIN5faB2YYsNBWCpLYu7y5Q2hpLgXWJZ6
 E/2H0kPi6rLMVKZa13w2xEV1FxC+CL333Lhnnoow3dw8PHMuU6Gi/7vfxcGJGNREWxrjFO3Z
 JOxk8hfR0+wKQ4giBqi40/+galdvqV2aWfJEiIqN2D7KX9vVqyou/+MeclKvdkjviJaTPina
 lCXYqXwpwcX1S/kGGUYyD1xJFTI8t3p2gd3jm6QNiM5p3XedN1s3hzf6fTHSPpN0zwKQy52z
 zXaTAvZXZHh7ZCfkJHNtfq7XmSqW8hIcCXl+oiHsTOy+WxgBRDXc+mbotT8CkB61Cb604IvT
 iDUtFPnZZGt0a2mMOVhd00uBVnm6sM8FJss2oc3gZgR3zAdiPD3tTIMnmD+LclA0qLzRGEAQ
 SIGxdLS5waj1EArIn+Sxo3/X2mQ2YM4OYn8OzpHnH5tqZkUU++d99km1WNtr0C9rB7NbPQ1h
 TobxfY0qTYbj+wPpAsx33CYC7EWE1NfOH+J9VzA5NS/oaNLIWe3JOHuhAwnxIHnUOHE+18HC
 xObMt84ECR979tyKgfJ2Xz3scT/fcXIKMkUrluSmgvBiO5cLNQwkOALjGxpIzGY3zVtxuglg
 BhpxZz/spKALjAn962+DwJELTb1ausI9zXxgKBSmcGYmYyiVMYEeH1DTN7zQPSkHShH///oM
 AuSDCY3qnqzArfbAQKZ5EBhoTTDHtr4UhPfbGlcxtJkSh6HIUVZiw1BRzQ2kKkyEQWyzdDge
 kN0tXgBo0T1oRxWxqd0JgHyBy3B8RywZG5+G/39ZFJGqxtP7EDPPYmC4/JvSmtGq4a5olXFL
 3zTIg1MCSthtlWsIVflM/Hu4NDB97PdHe+iN77VZq3Ir+VCVvCOzJbp0418/j/KON/ddn9lR
 +Y23EZORxUbU4zQhikPRioLlinMc9/TpRGy/Tdyp9y+9/KjURzm5I+GAb9fedt1/BX+jaCGP
 u+WzCF3TFQQnosL3mPNwaMD0UQ6kCx0aTS3Se5GriPJUK/WlqhQAVgXZmI7NcdF6b49whgYO
 cPfjYCQtPYwhfo0BlFZEF35z5j3NYpTejD7aAOBXRjQZ9HkbXXRzsr6YL2xU+hVheRQ7Firv
 CqDVlTkJnKFniXoUBamNadNijuaNVpQotLYEF4lBG79QdbhchD+PsVwiGh8yrIzi2/WLmUcP
 BBnfkdRo7uc6iRWxPlyUT8kjDItPayfliCV4vONYI4RquduCz9omvhy+3kg1bZPtHsCX/Fxh
 CbUotlprReqn6Pcr1gvGAoLoTFNioWRuExkMqiM7ZhMV0HP+xcV5HmRARAHzzOKIsbiv7xdz
 NTIk6y1JDoQqro8GOMHCszIJcSLN30vdxbkSma85OotVjOxK2zF3xYbi/yW6nCTop89pN7gl
 chWIoI=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3cZNV639tkxQ2jsa5yWx1QqjBLMkLtp133Aq2lEZdPWaSKClfq
 eV7ZMmPH7P+VIssRQb8+xoV5PvfZqxz/VICMwqXYtKPzOW3VdATrsC0WKK+VSJJ8S9zJ8/6U
 4HSdkdNDSaNzdHZKjBjTWFLw==
X-Talos-CUID: 9a23:CvUWdm9VgmVZHW/2WJCVv2QMM8opVmXz933VDAyKNH1OVLOcZ2bFrQ==
X-Talos-MUID: 9a23:JsogxwukPyOm6JJNSc2nmhduKZ1L4/iXCV0zlMoKusSILgBdEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="102546542"
X-MGA-submission: =?us-ascii?q?MDHWaANThTFVvMDQfF8DKa/HOTPWkT6Vw1SDGW?=
 =?us-ascii?q?OufsFqVvLTuaX3IxYAw4UWgqHNZTh1JTRgI9YoLqJO45NcsIcIgr/U4i?=
 =?us-ascii?q?5EEd+HSzsT6+iCN4Uht88sXSfIvPUB6DWHXdSgTf2IMDSEfRp6qQtGTD?=
 =?us-ascii?q?x5W6XTHOTTVmmRP0+XN6ck8g=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:40:39 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531238;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5x0yPCIryoiXTXe24z13INkplAFzoVmn1x49aPuCCtY=;
	b=jSKVqFExQSaxinJXOrSxNiS3t8Eipge1vhRHBNJjhjCz4n+7KScfgPxBuo3b46kSVLhJ2j
	0UXhFTBuKx0joSbRghed5bds0gNwtkpqrBXIrEoXXXFKSX8qE9F0glBVwfeSpHJWMuHfz2
	nVV0HJum8Ip7bUeU4cuswj8g9PjYLTmNs5vzPTZx7cQt/KD5M6+XKYaJ51YvSi/48XcQ/0
	7c37i7/iZ5dQQDciVeEFDG76UYubJI3Gk7iK28SGmDxf2ZG2FeVzk1vdHvZ91lOAfTaaut
	JWZBvLX+qbBYQn1/zRqcUXDbxu5PwSHYCEUrJraSUnNW55PMAPFq39B1zB9tFw==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr
Date: Mon, 25 Nov 2024 11:40:04 +0100
Message-ID: <20241125104011.36552-11-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 01/11] coccinelle: Add script to reorder capable()
 calls
X-Loop: cocci@inria.fr
X-Sequence: 2108
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241125104011.36552-11-cgoettsche%40seltendoof.de>

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
 MAINTAINERS                                |  1 +
 scripts/coccinelle/api/capable_order.cocci | 98 ++++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 scripts/coccinelle/api/capable_order.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index e7f017097701..ab5ea47b61e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5106,6 +5106,7 @@ S:	Supported
 F:	include/linux/capability.h
 F:	include/uapi/linux/capability.h
 F:	kernel/capability.c
+F:	scripts/coccinelle/api/capable_order.cocci
 F:	security/commoncap.c
 
 CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
diff --git a/scripts/coccinelle/api/capable_order.cocci b/scripts/coccinelle/api/capable_order.cocci
new file mode 100644
index 000000000000..4150d91b0f33
--- /dev/null
+++ b/scripts/coccinelle/api/capable_order.cocci
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Checks for capable() calls of the left side of a binary expression.
+/// Reordering might avoid needless checks, LSM log messages, and more
+/// restrictive LSM security policies (e.g. SELinux).
+/// Can report false positives if the righthand side contains a nested
+/// capability check or has side effects.
+///
+// Confidence: Moderate
+// Copyright: (C) 2024 Christian Göttsche.
+// Options: --no-includes --include-headers
+// Keywords: capable, ns_capable, sockopt_ns_capable
+//
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+//----------------------------------------------------------
+//  Pattern to ignore
+//----------------------------------------------------------
+
+@ignore@
+identifier F1 = { capable, ns_capable, sockopt_ns_capable };
+identifier F2 = { capable, ns_capable, sockopt_ns_capable };
+binary operator op,op1,op2;
+expression E;
+position p;
+@@
+
+(
+F1@p(...) op F2(...)
+|
+E op1 F1@p(...) op2 F2(...)
+)
+
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+@ depends on patch@
+identifier F = { capable, ns_capable, sockopt_ns_capable };
+binary operator op,op1,op2;
+expression E,E1,E2;
+expression list EL;
+position p != ignore.p;
+@@
+
+(
+-  F@p(EL) op E
++  E op F(EL)
+|
+-  E1 op1 F@p(EL) op2 E2
++  E1 op1 E2 op2 F(EL)
+)
+
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+@r1 depends on !patch exists@
+identifier F = { capable, ns_capable, sockopt_ns_capable };
+binary operator op,op1,op2;
+expression E, E1, E2;
+position p != ignore.p;
+@@
+
+(
+*  F@p(...) op E
+|
+*  E1 op1 F@p(...) op2 E2
+)
+
+
+//----------------------------------------------------------
+//  For org mode
+//----------------------------------------------------------
+
+@script:python depends on org@
+p << r1.p;
+@@
+
+cocci.print_main("WARNING opportunity for capable reordering",p)
+
+
+//----------------------------------------------------------
+//  For report mode
+//----------------------------------------------------------
+
+@script:python depends on report@
+p << r1.p;
+@@
+
+msg = "WARNING opportunity for capable reordering"
+coccilib.report.print_report(p[0], msg)
-- 
2.45.2

