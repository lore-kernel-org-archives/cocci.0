Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE89CAC5B8
	for <cocci@archiver.kernel.org>; Tue, 30 Sep 2025 17:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=a2i0ZDg1Nn9bTTxopVw11ptAfPxZl/mc99E1QunLURI=;
  b=WimR6V8AKpYsq1LfPj57kbczeYorMl8MSbAkKYq6LVIx/e7xEwdb36i1
   c4csHNxJ6FhrcR68yxgNK/oeuG33mcGCooVMTXr544Jjy40Eq0WmaRAqW
   Lx8oSt4ULbFMvMtraYiOOi7qx3+OShrTb/3fqBNchbPF+8wfIj9SgewJD
   M=;
X-CSE-ConnectionGUID: 7iyQMmpSTIqp75pj7/7Qmg==
X-CSE-MsgGUID: nNssRtErSvOrtQwU38amTw==
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
X-IronPort-AV: E=Sophos;i="6.18,304,1751234400"; 
   d="scan'208";a="241840364"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Sep 2025 19:33:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 35E67E0C55; Tue, 30 Sep 2025 19:33:46 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 37E84E0171
	for <cocci@sympa.inria.fr>; Tue, 30 Sep 2025 19:33:43 +0200 (CEST)
X-CSE-ConnectionGUID: 3OT4QQ+VTDC6x7jisjfofQ==
X-CSE-MsgGUID: p4wLSTdRR6Gpg/s3buOQRA==
IronPort-SDR: 68dc1476_rjqaZK7mX8AAZ+8NCqlSL+qTGIFGJm5Ra/6sH6jg8q6ghVV
 5T7rkKFKHK15woLaHO3d2wpO8R2Gt5WKJV4Qz5Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ELAADtE9xogA4P49RaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAQGCPmUdBlQzBAtJBIRRiByHNIIkh?=
 =?us-ascii?q?DuPEYh5gVUUgWkCDwEDAQ1ECgECBAEBAwMBOIFUgnQCjEYCHgcBBDAJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPDUkBE?=
 =?us-ascii?q?AGCBwGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQECDTpEAgEDIx0BAREmAQ8fAQUCJgICVgYBEgIBAYJ+AYIiAQYQAQM1B?=
 =?us-ascii?q?w25ZIEygQGCDAEBBoJp13YfLCJZgWQDBoEbLgGFbIJkAYVsO4Q8Jw+BVUSBP?=
 =?us-ascii?q?INBhAYEhBSCaYM8hA6CKIl7fY4ZgUocA1ksAVUTFwsHBYEwMwMgCjQxAhQdE?=
 =?us-ascii?q?g8EFjIdcwwoEoNsgQ2EHitPhA50PlqDUyRrDwaBFYEbgkAFAYlLIA+BDQIBC?=
 =?us-ascii?q?209NwYDCxsGPZh4YgiCXIEOLIJKkyyDGAGNHqJNNAeCOIFngWQMii6VPgYTL?=
 =?us-ascii?q?5dSDgaTBS6HZZBzIotsgXqbOYFoOoFcMxokgzZPAxkPjiGEM4ELg1WKKgG5I?=
 =?us-ascii?q?0E1AjoCBwsBAQMJhUYBAYpQgVI0gUsBAQ?=
IronPort-PHdr: A9a23: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
 A==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:87AU3Kpjg0ImvnQN9k2jO44aV5r/eYIsimQD101hICG9vPbo8v
 xG785rsiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLWrbUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadD/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: 9a23:8JZafm4FZDkkG7TO2tssr2koRvkcMUPh4FyOMxC6CH1rRrqbcArF
X-Talos-MUID: =?us-ascii?q?9a23=3AnjPGJQ2vc1TvaE9IYSrzfW5jzzUj+/ixLHsxna8?=
 =?us-ascii?q?85eacOmtrYD2Aqw2Na9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,304,1751234400"; 
   d="scan'208";a="126968955"
X-MGA-submission: =?us-ascii?q?MDFsOCk5eem1jd1r3FoUTOkum27oTmCMmpvdjC?=
 =?us-ascii?q?knGK9duAzGxyK4/6vpdrO6mVT0xuK2/ARAWW5esN7EwEeQhbDpefbKzs?=
 =?us-ascii?q?rQD2lBgMUECZX3RLZzgHR9a7eHZ8Rylwqais91duNYOoh0CVUH+gryYW?=
 =?us-ascii?q?f6oXFwnkyhFSuQ9bm23O33Ww=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:33:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759253622; x=1759858422; i=markus.elfring@web.de;
	bh=a2i0ZDg1Nn9bTTxopVw11ptAfPxZl/mc99E1QunLURI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tBBQHV+VbKASaDwvMX9Gv8Dmky6tQscQ2W5UZoBTBxz5pizYocmcZvJOd+XJv7zy
	 hrrK+jmq2tCYX44MMDiahBwKZwa11S/ka8BykmU+8R21dUnCtZqnGcMi+0YLPU+Sk
	 C/222xqWXVXyk+rsgav/n60msYe0XN8uPoBe+Q0ZurqcOURoz5TR17TbaxDTsy83V
	 BHiNkY4qNz7XmZbuSyZx8g3B9MP1vhTwjRR4RLzOjJ2Rpz0ONOFf88oqI6d5Wew9L
	 HypDgxSdWJj2mN3NDsoKIK5qTamDqUiY721a7ATk/mHsCuGeZEwing+zBhi8YUI/c
	 8uXP4RFaMtsB9cbOxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ma0PY-1upQif3MHM-00XxMG; Tue, 30
 Sep 2025 19:33:41 +0200
Message-ID: <fb3aff08-c0d5-4b07-8d05-13f70f6774fa@web.de>
Date: Tue, 30 Sep 2025 19:33:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <d5d3df5c-3cbf-403c-ad89-aa039ed85579@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <d5d3df5c-3cbf-403c-ad89-aa039ed85579@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jd4JiyPtHHL+G5eattRBR6VSpiKThhqekzrA4ShmfZMC3g/Kspm
 ezXqfFsV4CsLrDvX8ylItN5DmmWA1A+m3tZ3QO5+HZgkjnOx6azSOBrwU0W7v4JPotYTwFM
 ZRoz030fwGFzXUeGdsHsBgUUF/wHR3qIY6hScgA2A+1t/vuvpL4xZmRo0i4jnuvZDqpIdve
 JjrtyPbVoaz4FUWWINF5Q==
UI-OutboundReport: notjunk:1;M01:P0:TTGQW9M99PI=;BxrzvepsRdE/T6H207i4JcrvGHV
 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
Subject: [cocci] [PATCH 1/6] Coccinelle: ptr_err_to_pe: Omit an URL comment
 line
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3057
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/fb3aff08-c0d5-4b07-8d05-13f70f6774fa%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 30 Sep 2025 16:57:47 +0200

The Coccinelle software is documented to some degree by several
information sources already. Thus delete the repetition of a known URL
in a comment line.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
See also:
[PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR() to %pe candidates
https://lore.kernel.org/cocci/48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.=
com/


 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccine=
lle/misc/ptr_err_to_pe.cocci
index 0494c7709245..1a373c0a8180 100644
=2D-- a/scripts/coccinelle/misc/ptr_err_to_pe.cocci
+++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
@@ -8,7 +8,6 @@
 ///
 // Confidence: High
 // Copyright: (C) 2025 NVIDIA CORPORATION & AFFILIATES.
-// URL: https://coccinelle.gitlabpages.inria.fr/website
 // Options: --no-includes --include-headers
=20
 virtual context
=2D-=20
2.51.0


