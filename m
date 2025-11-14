Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B87CE7AFC
	for <cocci@archiver.kernel.org>; Fri, 14 Nov 2025 12:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Z56RuAVnJYHWormPtSLQKHvil9KvDUm/uAuyjaFOWV8=;
  b=lqbZu1VCgMdgWcrTVvdU7URpnFIPLeOzpmQ2FZPGwbz3TPBgqFid9FRg
   droB6f4e7HcpoL8/edYtIPwtpymDxf534gbiUOB8NnLC9qIMmktvzxD6w
   bUYlr5JdgkQXTMn2rXnlHPSB+Tx5zwzFJgkdV5b5bLL4aQ86mlEVTgkrD
   c=;
X-CSE-ConnectionGUID: eYAznNqSQ0e35q6bCYRsww==
X-CSE-MsgGUID: 1sbh+LN4Rz2i/xyB2CObjA==
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
X-IronPort-AV: E=Sophos;i="6.19,304,1754949600"; 
   d="scan'208";a="249183279"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Nov 2025 13:17:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4E494E0264; Fri, 14 Nov 2025 13:17:12 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A770FE0172
	for <cocci@sympa.inria.fr>; Fri, 14 Nov 2025 13:17:08 +0100 (CET)
X-CSE-ConnectionGUID: JrOJrD1QR6WzTdIIXb6qIA==
X-CSE-MsgGUID: 3+wnxFoURCy8B3c8kiOKZg==
IronPort-SDR: 69171dc4_UHpzqcj8k2TlOFh9s8azrIFUvlT/jWfegV1Rnb1P1AvKNJU
 DBAPdoarkLTmVYQhzHZQ2yDmUncZY/gI+5cqZqQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EzBgDOHBdpgwsR49RagQmBUIJAZR0GWDMEC0mEVY9Th?=
 =?us-ascii?q?l+PEYh5gVWBfQIPAQMBDUQKAQIEAQEDBIIMj1ECHgcBBDIHDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBOgcOCjGGTw2CW4EsgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEXAg06bR0BAREnNAImAnMBAYJ+AYIiAQYQAQM2B?=
 =?us-ascii?q?w0GsGSBMoEBggwBAQaCadd2HywiWYFkAwaBHC6FboJKGwEFbooaD4FVRIE8C?=
 =?us-ascii?q?4JHg1ADgiyDDoJpgiaBDplggUocA1ksAVUTFwsHBYFjA4ELbjIdgSRBGHE9V?=
 =?us-ascii?q?4NJImgPBoESg1GJHA+DXIEDhgICAQttPTcJCxsGPZUVLCWDZQKBX5NyKJE8o?=
 =?us-ascii?q?UU0B4I4gWcFgV8MiQiBJpU+BhMvg3EBk2AOBpMFmQaOCJVghVmBbgEzgVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OOoNnM4Rgv11CNQI6AgcLAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 PwhrIfvNMklYQl5TA==
IronPort-HdrOrdr: A9a23:zXUW4qMrVfCDoMBcTuOjsMiBIKoaSvp037BZ7TETdfUzSL3+qy
 nOpoV+6faQsl0ssR4b9uxoVJPwI080lqQa3WByB9uftWDd0QPEEGgI1/qG/9SPIU3D39J8kY
 F9bqN5FNr8NlRii93miTPIa+rIjOPnzEiy792uqUuFoDsaEp2JZGpCYDqmLg==
X-Talos-CUID: =?us-ascii?q?9a23=3A6MHxfmqNR1KP0aLS0Q0GZzXmUeI/VV/H4C7pGRG?=
 =?us-ascii?q?HG1plaZylQwGJ2Yoxxg=3D=3D?=
X-Talos-MUID: 9a23:A9+bLAmTvHAkT45vQedLdno5d9hu84qpNXomgMUs4MLUNi1XGAWS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,304,1754949600"; 
   d="scan'208";a="249183260"
X-MGA-submission: =?us-ascii?q?MDHcp5DkcU2ikY4tx9gRtkVqtx2jaa6p+LWMfH?=
 =?us-ascii?q?SAvQ0VgU1UbyHVGAQcUM3w81te0thx0MJiBkb4l/UDVU/8Ubmnd+EsNo?=
 =?us-ascii?q?TbhUA1g+aZialEXEnGYvc9mJZgvt/JEJ546GGNYGgBu9k8fxhXwj9IRr?=
 =?us-ascii?q?gyZrKXiE5cCEp18OAyl/bW8Q=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 13:17:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763122627; x=1763727427; i=markus.elfring@web.de;
	bh=Z56RuAVnJYHWormPtSLQKHvil9KvDUm/uAuyjaFOWV8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LH6nvUwMNHxanTmhYmo4bbEzhb3qfjHS4v1t330q42HC2T0XBhI51rHUYRRIs6EI
	 0pBLmlApp4ozsj7kUNXU+LcDrqs6qckXa54JQipGLpL4c+mQvfB3AwsyDsxto7Plj
	 lUg56Z2jzQFhwp2nca5LS0Uw2KBO5t1+5y7VFrNmWeWCSv7I5rV6mWzMxjwiFbqnO
	 X0EruTEQTxKEpCykl/V3jA0KmcD5kNwgESjE1ui+j/9Mbgm2Da7rF1w1iQ9q0Q/pA
	 I89eE05yiG7IccNCnNwE7zwpn8ok7JWp55vfYKg93C0TbYuI9jra4KgwXo+l8c9fG
	 M8tPqwxkFo7wk4vHNQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.197]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOli-1vlTDT1mua-00IK5m for
 <cocci@inria.fr>; Fri, 14 Nov 2025 13:17:07 +0100
Message-ID: <25c98ca2-68ce-4722-834a-8a012780c002@web.de>
Date: Fri, 14 Nov 2025 13:16:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:q7CpzFbXp3AuImAF/SUeoR8CcnmyyeRi9Xu1jujzOc/b5EkTsMN
 RS1p+9u1Ev2vN3+0OXHyJj0XNXx6RPb7ORpvD98E2OFC1yqqX9HvgZBywaiU2/kMtWEWxpY
 dNgZ7X1Q5545THvKK0tOKUm1d7qpUjQwJafxiA4sstLT9wl+8akb/neEhaFhIdtqT52Z2BN
 9LqZg8mVM4SqZhtS16pDQ==
UI-OutboundReport: notjunk:1;M01:P0:mk4MFjXUhQo=;p0pU/9NgniDwp7EzeS83TK+tI+7
 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
 s8vuw==
Subject: [cocci] Searching for unused input parameters with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3176
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/25c98ca2-68ce-4722-834a-8a012780c002%40web.de>

Hello,

It can happen that input parameters would not be used within a function
(or macro) implementation.
https://stackoverflow.com/questions/3599160/how-can-i-suppress-unused-parameter-warnings-in-c
https://clang.llvm.org/extra/clang-tidy/checks/misc/unused-parameters.html

Can components of the Coccinelle software help any more to detect such
technical details?

Regards,
Markus
