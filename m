Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20329F589D5
	for <cocci@archiver.kernel.org>; Thu, 23 Apr 2026 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=QWImgfMsXMxp9lut0yLuQFBNwtdl+GzQPUdQpSwT7Zo=;
  b=KEek6JNp8zRSOo/fAfmVYBnq8igXgsgQTqYdRiAR/3x/96chz+Cu2l1E
   ZyPb0aNEy7ew7MGq/3Ih7Yl4Cdk+mTzt1rP2+J2U2bNbprwbB9Mf93zWN
   nV6T7d3AljqgZ6tgX+963H76sL2SrbPoMkEEnxQO++VfRqlv8ZotVpXzP
   g=;
X-CSE-ConnectionGUID: Wu2OmJOSQBiW0ewcQ9sYlw==
X-CSE-MsgGUID: kXX1JXmySk+cUG8SyJjFzg==
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
   d="scan'208";a="273843000"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2026 15:40:27 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id EFA8582524; Thu, 23 Apr 2026 15:40:26 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A3B0582524
	for <cocci@sympa.inria.fr>; Thu, 23 Apr 2026 15:40:20 +0200 (CEST)
X-CSE-ConnectionGUID: YMROH12OSX+fhNDE9YWZlA==
X-CSE-MsgGUID: oSNpmoQiRguQN1M5Zs9/1A==
IronPort-SDR: 69ea2144_1pZhZZQWM6wqaXMpuA6QSTxN1+kMwP5CA/ZfRVO24zfcjyP
 crcLvz6LNSCoR8jCpMNlxV7ve7zROE7KeQ7CgLw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFBgApIOppg07ASNlagluCPxZxXjQEC0kIPh6DdINPj?=
 =?us-ascii?q?ASCIYQ+jxGIeYNSAg8BAwENSgQBAgQBAQEBAQECATiBU5AjAh4HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBIRkHD?=
 =?us-ascii?q?juGIC8NSQEQAYIAgSyBJQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQJHbQQZAQERJzQCGA4CcwEBgn4BgiIBBhABAzYHDQazd?=
 =?us-ascii?q?38zgQGCDAEBBoEIPgUNQVHXex8sIlmBZAECCRSBCy6FcoJKHAEFbol9Jw+BV?=
 =?us-ascii?q?USBPAuCR4I/gREBA4Irgw6CaYImgQ6HFIgDgUocA1ksAVUTFwsHBYFmA4EGM?=
 =?us-ascii?q?jwyHYEjPg8INFgbBwWBS4QJgVeBCgGDKoE2dAIBC209NwkLGwQ9iyYgD4MLW?=
 =?us-ascii?q?QKBTgFOEhmTL7MBNAeCOIFnBYFfDIkIgSaVPwYTL4VbkXcOkwuZBo4JlWCFW?=
 =?us-ascii?q?IF/I4FcMxokT4JnCUcDGQ+NeAFBhBuBC4JhwRtEMgIJMgIHAgcNAwuFRAEBg?=
 =?us-ascii?q?XmKXYFLAQE?=
IronPort-PHdr: A9a23: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
 HLrYqBWXho5G6FCYnk=
IronPort-Data: A9a23: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
 D3QFrAc/vR8/32xedsu2w==
IronPort-HdrOrdr: A9a23:IByeU6pLntoFM8gAEKEJ9Z0aV5oJeYIsimQD101hICG9Afbo9P
 xG+85rsiMc6QxhPE3I/OrqBEDuexzhHPJOkOss1NSZMjUO2lHFEGgK1+KLrgEIcBeOk9K1u5
 0BT4FDKJnXEUVwi9r87TK1CtA63bC8gdiVbKvlrkuEVmtRGsddBupCe3+m+sYafmN7OaY=
X-Talos-CUID: =?us-ascii?q?9a23=3AKs7HHGrieo+XTkbFYwIjfSzmUfEASFr9lS33GH/?=
 =?us-ascii?q?7B2ZPZJDEeGCi/Ioxxg=3D=3D?=
X-Talos-MUID: 9a23:8K1+TQbNF1zHvuBTsATKnDRlDcZS7LmXLhkozKcd6o7dHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,194,1770591600"; 
   d="scan'208";a="273842971"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDG1uRkPePbuDKkwLQDpKSnjY++0Z7KW53CaOH?=
 =?us-ascii?q?/pPg1za0CjhQeUHJHd9tH0CIMDw82s4fco3b3c6Uj/Hm4sqV1Y5aHvsZ?=
 =?us-ascii?q?jKkcgQfiG5xRUKcMnJ4pafLAGpC3UsI7GRFNg3fqln660But4V8VAx07?=
 =?us-ascii?q?RpinWfzyanY74B49NcCulIPg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 15:40:19 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M43GU-1wFuHz0pkG-00GpWM for
 <cocci@inria.fr>; Thu, 23 Apr 2026 15:40:19 +0200
Message-ID: <a0719da1-8512-491e-a991-fb27e7352b0b@web.de>
Date: Thu, 23 Apr 2026 15:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wlac2NFPv45CmevJaNW+ZcycJk3UOx3yjlOFdNFzJOrngw3rHqf
 PXOARNCXR0i6UobNhhId4aBe3mJsNRieBN9kd3XpStu0hHmXrBeOvNToKgtghExnRWAsPIu
 DgwQG59Rz6gqVQUf2mf1CpiSNM9B46HzOdzuXcQcXqYEkYpQ5sRySTH1nHXqBF5jX6PKhky
 lhNOj1Yv/hWJyyvu6aYGw==
UI-OutboundReport: notjunk:1;M01:P0:1AsD74kiEKM=;Xl2wwsWXnGMWoi3PYOgDYcvoZgd
 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
Subject: [cocci] Improve rule identification for SmPL script profiling
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3479
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/xlJ4KrBp9nuVc0H-XI7diw>

Hello,

The program parameter =E2=80=9C--profile=E2=80=9D is generally supported.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d=
827b8b9627a841c85c9/docs/manual/spatch_options.tex#L762-763

I occasionally appreciate to take another look also at software run times
for selected SmPL rules.
I would find an adjusted output format clearer then.


diff --git a/cocci.ml b/cocci.ml
index 64503ee9..3a1d35e3 100644
=2D-- a/cocci.ml
+++ b/cocci.ml
@@ -1563,7 +1563,7 @@ let printtime str =3D Printf.printf "%s: %f\n" str (=
Unix.gettimeofday ())
=20
 let rec apply_cocci_rule r rules_that_have_ever_matched parse_strings es
     (ccs:file_info list ref) =3D
-  Common.profile_code r.rule_info.rulename (fun () ->
+  Common.profile_code ("Rule " ^ r.rule_info.rulename) (fun () ->
     show_or_not_rule_name r.ast_rule r.rule_info.ruleid;
     show_or_not_ctl_text r.ctl r.metavars r.ast_rule r.rule_info.ruleid;
=20

Can further users of the Coccinelle software benefit from similar code ref=
inements?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d=
827b8b9627a841c85c9/cocci.ml#L1586-1590

Regards,
Markus
