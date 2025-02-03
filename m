Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8952AC02198
	for <cocci@archiver.kernel.org>; Mon,  3 Feb 2025 23:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=iYMbK5A793RDdkoEPga+PoRyWET+ntXiAELhCjFiDKo=;
  b=ljtF2cHwW+Ukgsp5GIwnbNddFSTPJqD14EJekOEIf+9LsRS/v3HO/eap
   NOGLtiIstiBw35+KXFfZXkV7j4y9JxsuK6o02pGrDJ7OZbrSWfnKeu2/w
   /2mY4IAfAovGiiF8GOO3hTBI5rd60oXlD7Ul9YBcb9MYW1STHeHhqu9NE
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.13,257,1732575600"; 
   d="scan'208";a="206392375"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Feb 2025 00:50:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1FF6CE0D3D; Tue,  4 Feb 2025 00:50:31 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6FD8CE0264
	for <cocci@sympa.inria.fr>; Tue,  4 Feb 2025 00:50:26 +0100 (CET)
IronPort-SDR: 67a15642_kiiNKo4hhM0xj1iUbcdQ7+l7PhtqaHkoADbUVfM4/UDrRF+
 qkp00faliNoFYmc0VSUdl9EujeHuQHItVBFkmlg==
X-IPAS-Result: =?us-ascii?q?A0E2AACeVaFncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDgVczBwhIhFaSBotgkE2BVoFAPg8BAwFOAQIEAQEDBIFMgzQCi?=
 =?us-ascii?q?n0CHwYBBDEIDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAYEMh?=
 =?us-ascii?q?XsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAgEDE?=
 =?us-ascii?q?RIdAQE3AQ8ZDAImAgJGEAYBEoMCgmUGAp9lAYdgAQECiyOBMoEBggwBAQaCZ?=
 =?us-ascii?q?9k4gWUJgRouAYhNAYFsg387CYM5eicbgUlEgUqDM4RYg0aCaYN1g2+iYAk/g?=
 =?us-ascii?q?QUcA1ksAVUTDQoLBwVkVTgDIAoLDAsUHBUCFB0PBhAEbUQ3gkdpSToCDQI1g?=
 =?us-ascii?q?h4kWIEdgQ6EXIRDhE6CRlSCRIISdIEXiAMdQAMLGA1IESw3Bg4bQwFuB50/P?=
 =?us-ascii?q?IQPgQ6Zfo1KoW+EJaFgATKqUy6HZJBqIqQmhDWCGQE4gVxGByMVgyJPAxkPj?=
 =?us-ascii?q?iGDeo89AbkYQzU8AgcLAQEDCYVGAQGKbYFLAQE?=
IronPort-PHdr: A9a23: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
 YEmckGOUFsowqfXHBMMZ5OqFA==
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:6qIUbaBcZYd7PS3lHemW55DYdb4zR+YMi2TDGXoBLyC9Ffbo9P
 xG/c566feX4Ax6ZJhEo7290ca7Lk80maQY3WBVB8bHYOCEggqVxf9ZnOnfKlTbckWUygce79
 YET0EUMrPN5DZB/KHHCXGDYq8d/OU=
X-Talos-CUID: 9a23:CIE0imBOTpCChqb6E3JW02k2WdE1SSPE0kzIeUSqTnRFTaLAHA==
X-Talos-MUID: 9a23:lB0G/wl8k0fjjeG5sl5qdnpBP9pszY+KV3wwqrknvcaqLwNTBjWC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,257,1732575600"; 
   d="scan'208";a="206392315"
X-MGA-submission: =?us-ascii?q?MDEMUe+xXBirHX9ZpaJ5Y/u3Zku4GUF+rDkpy9?=
 =?us-ascii?q?hzrWMJAFhiSpxqv1vziZB7feus1Zlx+3fUOBkf3Y47bpWm98Jt3qh0OH?=
 =?us-ascii?q?gb7pqq54hYDAx3EvzLRm1iH+qUh15ApsoguzsZdUPlafXQb5thgiOuje?=
 =?us-ascii?q?+dlEKfpgst4aneR8SnD2FMLg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 04 Feb 2025 00:50:25 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 50B64205493C;
	Mon,  3 Feb 2025 15:50:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50B64205493C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738626623;
	bh=iYMbK5A793RDdkoEPga+PoRyWET+ntXiAELhCjFiDKo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oEhdTh0QOjAvgDcCvjUZsTTf0lTUPwUPP4F7dTpmwoMR8Uf43qW2ThQjODVfBeW0b
	 0A6YDdlPjF9Czqd/5/jjq41qeq/60xuBa1N/Q6LH7mm4uy7SMYZgwshRZgXGrP3Sf2
	 WEnpJG8ujT5WK9I6pJnS/o5zRDHyBdC0zkVrN8s8=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Mon, 03 Feb 2025 23:50:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-converge-secs-to-jiffies-part-two-v2-1-d7058a01fd0e@linux.microsoft.com>
References: <20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com>
In-Reply-To: <20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 Ilya Dryomov <idryomov@gmail.com>, 
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, 
 Xiubo Li <xiubli@redhat.com>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
Subject: [cocci] [PATCH v2 1/3] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2333
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250203-converge-secs-to-jiffies-part-two-v2-1-d7058a01fd0e%40linux.microsoft.com>

Teach the script to suggest conversions for timeout patterns where the
arguments to msecs_to_jiffies() are expressions as well.

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 scripts/coccinelle/misc/secs_to_jiffies.cocci | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
index 8bbb2884ea5db939c63fd4513cf5ca8c977aa8cb..416f348174ca659b544441f5f68f04a41d1ad4a3 100644
--- a/scripts/coccinelle/misc/secs_to_jiffies.cocci
+++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
@@ -20,3 +20,13 @@ virtual patch
 
 - msecs_to_jiffies(C * MSEC_PER_SEC)
 + secs_to_jiffies(C)
+
+@depends on patch@ expression E; @@
+
+- msecs_to_jiffies(E * 1000)
++ secs_to_jiffies(E)
+
+@depends on patch@ expression E; @@
+
+- msecs_to_jiffies(E * MSEC_PER_SEC)
++ secs_to_jiffies(E)

-- 
2.43.0

