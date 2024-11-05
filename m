Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DDFD2B920
	for <cocci@archiver.kernel.org>; Tue,  5 Nov 2024 13:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EExH8DrmfrF68TAGPLvdOj/yczk50b3EK+4Mt4fWYLQ=;
  b=MoD+GefeA/tMu4QB/tbNc4ZpZqlwpSTtxEHu88Y9OGF++kdUyd0Cd4AB
   jK5oKHreIE0GZi0pK71lInrotNSNoQU7d82LT+oRgOGzftT4jsAdyHsDT
   REpjWxrVheMxbE9ZDmuNLMV7cNNuJc4Co6hLW1E9VAw6G3Z8iKTnZ1o7Y
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.11,260,1725314400"; 
   d="scan'208";a="192252029"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2024 14:04:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B6A93E17DA; Tue,  5 Nov 2024 14:04:08 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 379FFE00B7
	for <cocci@sympa.inria.fr>; Tue,  5 Nov 2024 12:52:14 +0100 (CET)
IronPort-SDR: 672a06ee_ckDxj0t77yiZnKmMhEHG9kRdnMsGRzyNWob9/cgNzqk46pO
 GhSXhTF+UB8fusKcqtRPPqyHImjhx/sLyhCWW3A==
X-IPAS-Result: =?us-ascii?q?A0EcCAAyBipn/xOg6VVagQmBVYJCB3YGVDMHCEiEVoNPj?=
 =?us-ascii?q?iKgEw8BAwENOwkEAQEDAQOCDIJ0Aoo0Ah8GAQQ1BQ0BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBEAEBBQEBAQIBAQIEBgECgQoIC4U1Rg2CWztxgSUBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBFwINfgEBAQIBIxVRCxoCJgICVhsBAYJ9AYJBIwMEDa8WgTKBAYMcU?=
 =?us-ascii?q?EHaBoFnBoEaL4VpgmIBimAXEBUGgg2BPA6CRDE+gmECAoIrgw6CaQSCMhWFH?=
 =?us-ascii?q?yWJFZdjUnscA1khEQFVExcLBwWBKSQsA4JSf4E5gVEBgx9Kgz2BXgU3SYJKa?=
 =?us-ascii?q?U06Ag0CNoIkfYJQgSUEBYNvgQuDZYRsfR1AAgELbT01CQsbQ55aR4QMWS+mV?=
 =?us-ascii?q?qFrhCSMFpUuBg8EL5c/FJJ6mHeNf5sjgX8lRoETTTQEgyISQAsOD5IbxBVDN?=
 =?us-ascii?q?TsCBwsBAQMJkAaBSwEB?=
IronPort-PHdr: A9a23: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
 YqW/J8=
IronPort-Data: A9a23:uOnBcamEE09hZNd1i0FvIBXo5gy0J0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbDz2OaPuCajPzeoxwb4ix9khUsZPUndRgTwJppXg2QVtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTrSs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82Ayazt8B56r8ks14K2r4G5A5TTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN1+IlNpGY0DwdosBDl11
 PIbIwIJNiqq0rfeLLKTEoGAh+w4KdXzeoMYoW17izreS+slKXzBa/WXo4UDh3Fp2JgIRKe2i
 8kxMVKDaDzMbgdCOX8UDpUlm+nujX65bj4wRFe9/PttuTOJklcquFTrGIDvIfeyT4Zop3vbq
 HOB9laiCT4/F9PKnFJp9Vrp3IcjhxjTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWiolW7R8oZK
 0sP5jFopq906U/DosTBYiBUaUWs5nY0M+e82cVggO0g4vO8D9qxboTFctJAVDDinNQzWSRs1
 liSg8ivDjsprb79pbe16OKPtT3rUcQKBTZqWMPGZVJtDxrfTEUbjRTIVdFtVqWyyMD2cd016
 y7ftzAw3t3/kuZSv5hWPjn7b/aEpZ7OVQk7oA7QGH+mhu+8iEhJeKTwgWXmAT18wEp1g7VPU
 LXoWyRT0QzWMaywqQ==
IronPort-HdrOrdr: A9a23:K2GVTKExFR2WQGWCpLqE68eALOsnbusQ8zAXPjNKOH9om6uj5q
 aTdZUgpHjJYVkqNU3I9erwWpVoBEmskaKdgrN8AV7BZmPbUbuTXeRfBOLZqlWKJ8S9zI5gPM
 xbHZSWZueQMbE3t6nH3DU=
X-Talos-CUID: =?us-ascii?q?9a23=3AZjlyjmmwInyxtv++K7Loot0WhL3XOW3z3ij0I1S?=
 =?us-ascii?q?DNT1sEIa0R1ybyqc8qeM7zg=3D=3D?=
X-Talos-MUID: 9a23:FTxuLgtmwGp0DVHitM2n3gs5H/9ioJmXNQMDgNIPiZKPGglTNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,260,1725314400"; 
   d="scan'208";a="192232633"
X-MGA-submission: =?us-ascii?q?MDHxYbtdpIKbBvg1K7wwkubprwWy8ab5oHa6uz?=
 =?us-ascii?q?KhnDj/fvEmZ6ZwPGJwsVGKlUCfL80Z+WCAYP6OWFsChAbQvLe/icEwL/?=
 =?us-ascii?q?lV++/MGugK6T1qTGLJKhhZZh7s+gXuYAz4aiUN4Bm0GBizd0yd7KSPcp?=
 =?us-ascii?q?W8lE4wWvLcP7wiQUzXH9aWXg=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 12:52:12 +0100
Received: from [137.220.76.70] (helo=[192.168.1.187])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1t8I6N-000000004w6-8eR9
	for cocci@inria.fr;
	Tue, 05 Nov 2024 11:52:03 +0000
Message-ID: <98b5857d-52ae-43d2-9b3d-ffff4de4e8a9@knosof.co.uk>
Date: Tue, 5 Nov 2024 11:52:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <9aea38d0-4738-475a-b354-f26b44766544@web.de>
 <05354787-2a60-4c3d-8818-0d23c8e2e015@knosof.co.uk>
 <9dbf4109-9cf4-44d2-8b96-7354e73bba0d@web.de>
Content-Language: en-US
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <9dbf4109-9cf4-44d2-8b96-7354e73bba0d@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Importing source code into graph databases?
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 1967
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/98b5857d-52ae-43d2-9b3d-ffff4de4e8a9%40knosof.co.uk>

Markus,

>> Using a graph database implies that a particular kind of
>> query is so common that this representation saves time.
> 
> We are trying to optimise data processing approaches to some degree,
> aren't we?

If you plan running lots of queries against code, then there
are probably performance advantages to prebuilding a database.

If you are making one-shot changes, then I don't see the advantages
of a database.

The GitHub tool, CodeQL, uses a graph database because they expect
to run many queries against the code
https://codeql.github.com/docs/codeql-overview/about-codeql/#codeql-analysis

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com

