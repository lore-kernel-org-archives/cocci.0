Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7162BF589DE
	for <cocci@archiver.kernel.org>; Thu, 23 Apr 2026 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=m3ZnUA9Vn2q8lSC+Q1LAhAiuaX70m0IKSF/jG1OgTgI=;
  b=PPS7CeQrY3jtSTbEG+UOyPJJSFqiikYLyUzvA6XrziefJcW6Ix9MkMJQ
   NgwOuk+RoLdW5dGXYSt0m9a9nuZdSyMUVls6GNMmAO40l154XBBeoTbjy
   UDB/uALJ0miewl+EqpQ3+lemgNqvp+P0ORk8aOvXC6Kr9ipqcB76gtK2v
   o=;
X-CSE-ConnectionGUID: Io9BorMeTxWT0BaV3TrUdQ==
X-CSE-MsgGUID: QGDGXkglSaW04zk5vgXZww==
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
X-IronPort-AV: E=Sophos;i="6.23,194,1770591600"; 
   d="scan'208";a="273859318"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2026 16:52:27 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id CF99182685; Thu, 23 Apr 2026 16:52:26 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8622882205
	for <cocci@sympa.inria.fr>; Thu, 23 Apr 2026 16:52:22 +0200 (CEST)
X-CSE-ConnectionGUID: 4ul6xjJKT2CdfMvQdgtPRw==
X-CSE-MsgGUID: ENoPaDbRQuaSokC2+7yd4Q==
IronPort-SDR: 69ea3215_Rh2f3XhCGNttMGpGaJLTCczEKghT+RlT0ie5WF3xMc85KRL
 vMRRk5o29bW6kTrRgiO7fhFhlUstt/tmuVc8dxQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GoBADRMeppg07ASNlahRoWcV40BAtJCIRQj1OGX48Ri?=
 =?us-ascii?q?HmDUgIPAQMBDUoEAQIEAQEBAQEDAYILkCMCHgcBBDQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEhGQcOO4YgLw2CW4Esg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQJHb?=
 =?us-ascii?q?R0BAREnNAIYDgJzAQGCfgGCIgEGEAEDNgcNBrQGgTKBAYIMAQEGgUYFgR/Xe?=
 =?us-ascii?q?x8sIlmBZAECAwYUgQsuhXKCShwBBW6KJA+BVUSBFSeGIgEDgiuDDoJpgiaBD?=
 =?us-ascii?q?oF+Iox9gUocA1ksAVUTFwsHBYFmA4EGbjIdgSM+FzRYGwcFgUuFYIEKAYMqg?=
 =?us-ascii?q?TZ7AgELbT03CQsbBD2LKiAPg2SBUWwNky+RPKFFNAeCOIFngWQMiQiBJpU/B?=
 =?us-ascii?q?hMvl1IOkwuZBo4JlWCFWIF/I4FcMxokgzZQAxkPjXgBQYQbgQvDXEQyAgk0B?=
 =?us-ascii?q?wIHDgKFTwEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RzyNJE90thdD6yFndou28E=
IronPort-HdrOrdr: A9a23:NpEemaqA/PJIT196YNr2OksaV5oJeYIsimQD101hICG9Afbo9P
 xG+85rsiMc6QxhPE3I/OrqBEDuexzhHPJOkOss1NSZMjUO2lHFEGgK1+KLrgEIcBeOk9K1u5
 0BT4FDKJnXEUVwi9r87TK1CtA63bC8gdiVbKvlrkuEVmtRGsddBupCe3+m+sYafmN7OaY=
X-Talos-CUID: 9a23:KNTWNG0k6S53QMB8gXl6drxfRt0hLG3f7lTseWS0B0N3cbGaVWeq5/Yx
X-Talos-MUID: 9a23:dduikworniXaqFc5ezoezxxEM/9hz66UMV0EqpIFkJPHaj18Zw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,194,1770591600"; 
   d="scan'208";a="273859264"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDE7Ht5YxasrmFUziCrzM2OrYglq1vEex2breJ?=
 =?us-ascii?q?hIK+nltnK89ki0pTvLFq7FAIDMy8sob/K8xoDEuKX9/W5augwDAz4zNj?=
 =?us-ascii?q?CBrrRUiZhfEx3CXkT3xg+hVMpeVM4K9e5AgfjUVbBYX2lrjamlAPur/9?=
 =?us-ascii?q?sths7OFOecl3DX9MY460FHqQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 16:52:05 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrwsB-1vdnJB1fCn-00bdzI for
 <cocci@inria.fr>; Thu, 23 Apr 2026 16:52:04 +0200
Message-ID: <53b09a64-6f8c-4f8a-83e8-9cd3dfcc3409@web.de>
Date: Thu, 23 Apr 2026 16:52:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jmYRwzF/jBN/7TqIcDP/egsSt30YqjIPkFg1S7NZWqQgiqmKCUO
 FyBgZCAjk+oxnt3kI3MQr7JMrCZpMhWu9neS4uSagXau/ZhQTBPbJS1/rRNRHTjchZbk3bq
 XUYLPYp/9ycnnOzyL7Af8Pn/a4UHLXytirjLmn4JrIxewlVkzMuYCPm3oOqsMHQER6mljpm
 8aa4ddHzioPGcKSWVJ05g==
UI-OutboundReport: notjunk:1;M01:P0:Xen0XVbtDCg=;EuUYuUk0DoLnSfjuClv9mIGteAT
 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
 MH
Subject: [cocci] Build configuration for OPAM support?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3480
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/CaFLkE6pMMM1dutyE68_CQ>

Hello,

I occasionally prefer to reuse OCaml components by OPAM interfaces.

Program parameters need to be adjusted accordingly.


diff --git a/ocaml/yes_prepare_ocamlcocci.ml b/ocaml/yes_prepare_ocamlcocci.ml
index 1680856e4..da36af522 100644
--- a/ocaml/yes_prepare_ocamlcocci.ml
+++ b/ocaml/yes_prepare_ocamlcocci.ml
@@ -582,8 +582,9 @@ let load_file mlfile =
   let (ldlibs, inc) = dep_flag cmifile mlfile in
   (* add ocaml and ocaml/coccilib as search directories for the ocaml scripting *)
   let flags =
-    Printf.sprintf "-g -I %s %s -I %s -for-pack Coccinelle_modules"
-      (Filename.dirname cmifile) inc (sysdir ()) in
+    Printf.sprintf
+      "-g -I %s %s -I \"$(opam exec -- ocamlc.opt -where)\" -for-pack Coccinelle_modules"
+      (Filename.dirname cmifile) inc in
   let (obj, cmd) =
     if Cocciconfig.dynlink_is_native
     then compile_native_cmd flags mlfile



Can further users of the Coccinelle software benefit from such a code refinement?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d827b8b9627a841c85c9/cocci.ml#L1586-1590

Regards,
Markus
