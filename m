Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3356F107BCD3
	for <cocci@archiver.kernel.org>; Fri, 13 Mar 2026 17:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=huuTkZFjlnKV77Zy5MuXVWaQQebgl9Nl3Zi0dBkFraI=;
  b=DrsPMPULOWC52o0iJmnrAdfGe531JzLpYa2luYr8q7pgbbKtDsEgBn+r
   MEMDUZWDRexaEMQoHwaxP1c7BREXw9Ve3hpmxFXbIrFB05VhOgpuVrCFr
   FcTF//ZrrG9QnJibNCpUV4RTtlFVLpwhZ4sSIw+LyZ88Bqad0adioy39j
   c=;
X-CSE-ConnectionGUID: ahFpvLiZQJq/rumTq/on8w==
X-CSE-MsgGUID: xttRbY3+R3+laBhvoP07bQ==
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
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208";a="267732320"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2026 18:31:51 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 72D6C83708; Fri, 13 Mar 2026 18:31:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B588B836F0
	for <cocci@sympa.inria.fr>; Fri, 13 Mar 2026 18:31:46 +0100 (CET)
X-CSE-ConnectionGUID: c8T+oHO+Tzisg/dF4Y0NaA==
X-CSE-MsgGUID: ozqu1/wERzSSf4hgsYuZBQ==
IronPort-SDR: 69b44a02_pTsxNMDvKDM3+/LJxZ8U4Z0F4uN9AEEd6wqNjSV3yjKcd1w
 Gh/1xOoR/Nv4rT7UMG6jwRcGF6G6hmSMuwGt7eA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G6AwB2SLRpgAQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VCCQWh9NAQLSYRYj1OCIYQ+hzyMRYQJg1ICDwEDAQ1OAQIEAQEDBDcBgVSCd?=
 =?us-ascii?q?I0lAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QE7Bw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdGJx0BAREmAS4BBQIYD?=
 =?us-ascii?q?gJNEQESAgEBgn6CIwEGEAEDNgeyA4EygQGCDAEBBtpkHywiWYFlAgkUAYEKL?=
 =?us-ascii?q?oU8M4JlAYVkSwmCU2mBIQ+BVUSBFSeDQYQKhBSCaYM0gWGRSIFKHANZLAFVE?=
 =?us-ascii?q?xcLBwWBMzMDIAovFBkCFC8PGjIdcAwnEiwPCDNYGwcFhRoPiHKBCFmBEAGDK?=
 =?us-ascii?q?wIBC209NwYDCxsEPY5wPYI0gQ6CBnCWRAGvazQHgjiBZ4FkDJ9tBhMvl1IOk?=
 =?us-ascii?q?woBLoV0gXEWkF0ioxtlhR82gUkjgVwzGiSDNk8DGQ+OIT6Ddcd2RTI8AgcBC?=
 =?us-ascii?q?gEBAwkBgVWDcAEBjCI0gUsBAQ?=
IronPort-PHdr: A9a23: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
 gE7gE1ybLZ0nAo=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:zEKabqCyxfFRANXlHel055DYdb4zR+YMi2TDGXoBKyC9Afb5qy
 nIpoV86faUskd3ZJhEo7u90ca7Lk80maQFhLX5Xo3NYOCFggeVxehZhOOO/9SKIVybygcy79
 YCT4FDKJnXEUVwi9r87TK1CtA63bC8gduVbKvlrkuEVmtRGthdBupCe36m+sYafmN7OaY=
X-Talos-CUID: =?us-ascii?q?9a23=3A/5s8VGoMmpPHkRbLPydOpInmUct1Tj7a7FCTH12?=
 =?us-ascii?q?5EmkuRJPJeAe28Yoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AzCM/uA24KdAf2OR5C1lq3gNFtDUj5La3FRlKjrg?=
 =?us-ascii?q?8qfK/O3BwNCyskQade9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208";a="267732300"
X-MGA-submission: =?us-ascii?q?MDHdDc9slrZMh/1MPi7lRDi0HGG3g22CJPr4H8?=
 =?us-ascii?q?LVm5//lEVy9pJdKB145davSfXq/QLgiJjFEzLl29AJp60nXocmxUuMN8?=
 =?us-ascii?q?0kwbHi9iKUFxsmEN6KEkuAEasA+hwPeLLLVdYSLnVVttjm7+ibYxpEhO?=
 =?us-ascii?q?YPRALzvf42IeLF/eXn9anXEg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 18:31:46 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNORC-1wGzZN3F98-00SzA2; Fri, 13
 Mar 2026 18:31:11 +0100
Message-ID: <4fa1cbbe-506d-4acc-acd6-57700d76d0e2@web.de>
Date: Fri, 13 Mar 2026 18:31:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Alejandro Colomar <alx@kernel.org>,
 Felix Gu <ustc.gu@gmail.com>, Philipp Hahn <phahn-oss@avm.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bxkThwH0ddhMfNrjXZrhpmXcI8FKvr5/5MXot1SKPntsFGDAdU/
 0rwzaOyECAZJ0sZYnQIIjmROHVTQ/lYvTVOwGVubKjVqmgyQ7KEnOe8N5iUWV62xp2jrWfX
 24ZNH6fk8aRM/cpkoai+yasS+PRqkHToQTzKAeb5qek1nIdHMctevRW9H0t6tUUtgp0wK6M
 bN4Z9j6Joeiwo7xzHvZ/A==
UI-OutboundReport: notjunk:1;M01:P0:wog42B0XDCQ=;99JGrzbACzzsTvsAgvqCV8hU8M9
 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
 32AhJ6+gd+3ae0mxRD5BxUFQ==
Subject: [cocci] [PATCH] Coccinelle: api: Add SmPL script
 =?UTF-8?Q?=E2=80=9Cpm=5Fruntime=5Fmark=5Flast=5Fbusy-deletion=2Ecocci?=
 =?UTF-8?Q?=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3430
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/8bMV6Uf5dgB70kFlVYhf2A>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Mar 2026 18:15:11 +0100

The device's last busy timestamp was set in a wrapper function since
the commit b3db492e8335417dfd66c1fa2ea08e1d2f7b6736 ("PM: runtime:
Mark last busy stamp in pm_runtime_put_autosuspend()").
Thus delete pm_runtime_mark_last_busy() calls before
pm_runtime_put_autosuspend() calls.
Provide design options for the adjustment of affected source code
by the means of the semantic patch language (Coccinelle software).

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 .../pm_runtime_mark_last_busy-deletion.cocci  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 scripts/coccinelle/api/pm_runtime_mark_last_busy-delet=
ion.cocci

diff --git a/scripts/coccinelle/api/pm_runtime_mark_last_busy-deletion.coc=
ci b/scripts/coccinelle/api/pm_runtime_mark_last_busy-deletion.cocci
new file mode 100644
index 000000000000..fa17fd8ea43b
=2D-- /dev/null
+++ b/scripts/coccinelle/api/pm_runtime_mark_last_busy-deletion.cocci
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Omit pm_runtime_mark_last_busy() call before pm_runtime_put_autosuspe=
nd().
+//
+// Keywords: wrapper function access timestamp autosuspend
+// Confidence: High
+// Options: --no-includes --include-headers
+
+virtual context, patch, report, org
+
+@depends on context@
+expression e;
+@@
+*pm_runtime_mark_last_busy(e);
+ pm_runtime_put_autosuspend(e);
+
+@depends on patch@
+expression e;
+@@
+-pm_runtime_mark_last_busy(e);
+ pm_runtime_put_autosuspend(e);
+
+@x depends on org || report@
+expression e;
+position p;
+@@
+ pm_runtime_mark_last_busy@p(e);
+ pm_runtime_put_autosuspend(e);
+
+@script:python depends on org@
+p << x.p;
+@@
+coccilib.org.print_todo(p[0], "WARNING: Delete pm_runtime_mark_last_busy(=
) call before pm_runtime_put_autosuspend()")
+
+@script:python depends on report@
+p << x.p;
+@@
+coccilib.report.print_report(p[0], "WARNING: Delete pm_runtime_mark_last_=
busy() call before pm_runtime_put_autosuspend()")
=2D-=20
2.53.0

