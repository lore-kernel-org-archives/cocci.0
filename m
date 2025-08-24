Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B243CA0EFC
	for <cocci@archiver.kernel.org>; Sun, 24 Aug 2025 12:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Tqa50LUKbPjx5CllJ9Yt080fvO8tlmlu1B/nkJ0AjBY=;
  b=jTLCDdATcdM6RMMd7MQ+DU/6KEvGUwkaKBuXgCTaMbb6rFOyczetY8/p
   inp1Xd2jccbGZbmfm36yYFxJ6t+K5f8/vjGXugqSiC+J775Ze1QnsqSdt
   Kho8pAZUufIXzrf5W0CKUoRtwJM2TeRFJQXUe49TjQoMdDuqmReG0OL+G
   c=;
X-CSE-ConnectionGUID: 08exyxd/TqKsNcztBI0lAw==
X-CSE-MsgGUID: xYMygwlhSYaju+/Gj6xoSg==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="235892085"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2025 14:41:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A4E70E0B0D; Sun, 24 Aug 2025 14:41:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 48B49E0172
	for <cocci@sympa.inria.fr>; Sun, 24 Aug 2025 14:41:18 +0200 (CEST)
X-CSE-ConnectionGUID: e3voucKfQNix3HCHSuAK8g==
X-CSE-MsgGUID: /PwgdbUjSNWfHD/FgmZm3A==
IronPort-SDR: 68ab086d_r9HYNA7DfZMhow+mb9qsmNyV6GlyfYmn99P8c/GSqWi/akF
 rQ45n283enDpCSBw8PTs0VMBiNV/TU1iktipjnw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EzEgBbB6toeA4P49RaHgEBCxIMQIFIC4JAgQEGVDMEC?=
 =?us-ascii?q?0kIhE2PUIZfjxGIeYNSAg8BAwENSgQBAgQBAQMDAYIMgnSMKAIeBwEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABQw4KMYZPDYJbg?=
 =?us-ascii?q?SyBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?kdGJx0BAREmATQCJgJNJgEBgn4BgiIBBhABAzUHDQawNIEygQGCDAEBBoFGB?=
 =?us-ascii?q?Q1BUNd1HywiWYFkAwaBGy6FbIJKGgEFboRphA2BIQ+BVUSBPIYiAQOCK4MOg?=
 =?us-ascii?q?mmCJoEWg1iEA5JrgUocA1ksAVUTFwsHBYFjA4EPbjIdgSeEAIEOg1tFK0+FA?=
 =?us-ascii?q?kFYg1Mkaw8GgRWDYwaCNEACAQttPTcJCxsGPZRPhA9ZgkqTL7MBNAeCOIFng?=
 =?us-ascii?q?WQMiQiBJpU+BhMvg3GTYQ4GkwQBhiKSZI4IlWCFWTaBSCSBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hhDOBC7c3QTUCCTECBwEKAQEDCQGBVYNwAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 t3Iib61NzpItd7Zr5N07yf8N8+NdnYsY0OBJQ==
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:0D++2az4BLm/chQnZ9xTKrPw9L1zdoMgy1knxilNoNJuA66lfr
 OV7ZcmPHjP+VAssRAb6Le90cy7Kk80mqQb3WB8B8bGYOCEggWVxeNZgbcKqgeIc0DDH4VmpM
 NdmsZFaOHYMXg/q9rm6w+lFNsazMCA673Av5ak854gd2BXg7oL1XYBNu93KDwPeOHMaKBSKK
 ah
X-Talos-CUID: 9a23:nWkaqWOg82+u1u5DVXJ581MfOc4cVHzNl1f7A3SlIEU5R+jA
X-Talos-MUID: 9a23:Z/5JIgiVvuQnSOiYD0IU4cMpc/937KikNUI2t6oIm+XDGyN1CTLGpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="123776329"
X-MGA-submission: =?us-ascii?q?MDGJhQ9uKnsfjI6zLL6ElKtZvLttMJqlTNjXf4?=
 =?us-ascii?q?XMOLcphnOUGFQV77AMSrUHYey4xA7cQ5R8VgA6EXxm9BcE6TvaGh+8sV?=
 =?us-ascii?q?LgoDrg/ZyeTBg8QW5WFA2JCaeIAhAMUPcs4qRbl2YBppJfCq0a1LpGdE?=
 =?us-ascii?q?bPLnJNdZ8ZYQcOBgDMTB7CYQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 14:41:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756039264; x=1756644064; i=markus.elfring@web.de;
	bh=Tqa50LUKbPjx5CllJ9Yt080fvO8tlmlu1B/nkJ0AjBY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IFoGjT10L7jZ+juLGHbeW1ElBZNl7XDpHr5qxyF3T4iXW08WVlyZyg2wHco8QsPc
	 cXtjGg+BxW6NBK8expGK2yquE34b3Gjia11NK4rHSTRVd8uNwv0kpowxWh2lZ2CtN
	 s80kaumvSogL5pgQHnr9hIC/MV5UZ4OJDJuhpaR9UOFg9LWKgnDtVnRz+2I3tCg2P
	 Gldar9b2RT9Y6owzuI0U3WanAEILYYkm0g4A0uFmLLHjX1mHgZUD0mgSAgkeyB/L0
	 AgzvIDaQAluLRTUjnRcJB6TteWXAPm2TbVYGhAj5crxodBnatzdUlUxf+Ob9ZS4wH
	 ji62CkLusdrxfURVRg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.216]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6lX-1ubG9P3GmN-00vMZR; Sun, 24
 Aug 2025 14:41:04 +0200
Message-ID: <574a6fa0-00a0-43c2-8e66-cc6443f5cfd4@web.de>
Date: Sun, 24 Aug 2025 14:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k1RvGBeE108ZCUP1seDcatK/mCtKGC1li0OfncC2/yvciZBuKRt
 nVzf4cuLAC2xcGxyBpmaKd1t7dav+a41oQzMczwfvXjwC0WihzW44VWfFOxi490EIn3dtHR
 PRpRAlij62zWOq/P4L3QbEMVnhB20vwX51usQ+089rQKmB1JzTaneSGwKE7C7G+Ahw/bCUh
 +8JDIqRqXkQGvNOXOMQKw==
UI-OutboundReport: notjunk:1;M01:P0:+l5MbhXVxTY=;CnCmaCD5KqCYjyFSfAWFfvfSZ0g
 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
 kKxjMIo=
Subject: [cocci] [RFC] Choosing =?UTF-8?Q?=E2=80=9Csemantics=E2=80=9D?=
 better for SmPL script parts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2980
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/574a6fa0-00a0-43c2-8e66-cc6443f5cfd4%40web.de>

Hello,

A bit of information is provided about special =E2=80=9Csemantics=E2=80=9D=
 (also in the manual
for the semantic patch language).
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/face14907c0791b93397d=
5788d2a94c7c6a4b886/docs/manual/cocci_syntax.tex#L1007-1014

Usage possibilities are indicated for the key words =E2=80=9Cexists=E2=80=
=9D and =E2=80=9Cforall=E2=80=9D.

* Would any more software users like to discuss and clarify safer applicat=
ions
  of these system configuration parameters?

* Would you be looking for better =E2=80=9Cconnections=E2=80=9D according =
to computation tree
  logic (or linear temporal logic) variations?


Regards,
Markus
