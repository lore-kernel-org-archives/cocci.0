Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE713606A32D
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=NP+dyepw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4IVs2I6BQUGApkdf4lP8lToqI5JAWoaEnyulw32K3vg=;
  b=NP+dyepw/uU1DRlEkiACRXzET1V/L2jCJYAlHP5EoyQ/WixLexm0EvZF
   ICBSxamJUCCyXC5GUTgcF537UZHBndtgAT5RJqV89Aql+c+u4bNrkbiYb
   /+Uk1rTKE0wMJgjyUOqujh/qBdV7epyBG0kj86Knk6DuxiroG24SgNuiq
   U=;
X-CSE-ConnectionGUID: 3jAx/SqCQlq/sNCsHyS1tQ==
X-CSE-MsgGUID: wKu6u+uwRUSlrWYT5Ol9nQ==
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
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323587"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:26 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5C30481832; Sat,  7 Nov 2026 11:59:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5CFCF81A5D
	for <cocci@sympa.inria.fr>; Wed,  4 Nov 2026 12:12:36 +0100 (CET)
X-CSE-ConnectionGUID: /hXqZs1oSeGTFi5B0XbQ2A==
X-CSE-MsgGUID: rGyP4r8pTCeunKI49wADGg==
IronPort-SDR: 6aeb1323_IonoyLxuHgc1p5ecTdtuYQCGZCN62YIF/I5oErGWyseQmDN
 hRxR4phuAfUAdDdJSqLfDBs7pOe9vC06liPrYqg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EaAAAYEutqgAQP49RaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBgkCBazQEC0mEWIgbhziBdDCLeIdWiH6BVYF8Ag8BAwENTgECBAEBA?=
 =?us-ascii?q?QIEhHYIAo4dAh4HAQQwCQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBA?=
 =?us-ascii?q?gQDAQEBAQIQAQE7Bw47hk8NjBoBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECA?=
 =?us-ascii?q?SMdAQERJgEECwsaAhgOAgJWBgEUAQGCfoIjAQYQAQMQJwe5QIEygQGCDAEBB?=
 =?us-ascii?q?tprHywiXYFrCYEfLgGFcYJtAYY0g0h6Jw+BVUSBPIJMBzE+hT+CYIJqgiaBD?=
 =?us-ascii?q?Jc5UngcA1ksAVUTFwsHBYElQwMqLy0jDzwFLR2BIyEdFxEeWBsGBRIgKkFDW?=
 =?us-ascii?q?4ESgQddgSsoXQECH0YtFYF2AoJRgSMCWwIBSUEOB0VTCSVDEkckIggSCQETG?=
 =?us-ascii?q?iwKgRo1PAkmBDsVDFsLCxoFGkcIAgsCDHQoERATHR4kLwUcJkAbChRtPTcKC?=
 =?us-ascii?q?xkEPZMjg2mDH6R6oUg0B4I5gWqBaAyfbwYTL4NxAZNhEJMOmQgjqSGBaDqBX?=
 =?us-ascii?q?DMaJIM2UAMZD44ihDXOCEYyPQIHAgcOAwuFRAEBjFaBTAEB?=
IronPort-PHdr: A9a23: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
 10XzLm+IYlBbuUTNGR9Z1M8kImYQiLt
IronPort-Data: A9a23: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
 FUI
IronPort-HdrOrdr: A9a23:A1CPdK/UAOZ8DTmEgiVuk+DzI+orL9Y04lQ7vn2ZhyYlAvBw9v
 re6MjzuiWE9gr5NEtQ6OxoW5PwNE80l6QFkrX5VI3KNHiYhILCFvAR0aLShwHFXwf69uJbyO
 NJfqVkYeeaZzUX4qiagHjaYrRQpajigcfY45amvg8dNnARGtwQkztENg==
X-Talos-CUID: 9a23:qheB92G7Yp0VDQSAqmIg9H4NKNt8dUbQ40v+IhKSUVZjcee8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ALzyEEQ8A3af29Oc0MERFuBSQf91H8pzyEhAVrb4?=
 =?us-ascii?q?Lps+nFHAhJB6xozviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,195,1787004000"; 
   d="scan'208";a="161722976"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGaRX/MjmqZ9bui9tlxQkH4FAvhms94tv2/m9?=
 =?us-ascii?q?IS1V3akLmvUSqzgucpBy77BCYFFOJlktHjWZaBaph3Ef2Rd1tIPXUVWM?=
 =?us-ascii?q?/a2DJr4s3lHugi/3/Foznts3/dHCPDYzI8j4LVQxNLgewE3cHfIOK/in?=
 =?us-ascii?q?Urzz3lz16BXJpqQaVKDN3jsQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:12:35 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxs3-1xBgtH2MbP-00TjHy; Wed, 04
 Nov 2026 12:12:20 +0100
Message-ID: <1aa14886-503b-4e35-8ab1-f63c1942c7f1@web.de>
Date: Wed, 4 Nov 2026 12:12:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: tools@kernel.org, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <52418f50-b3ff-461d-8e66-c10f70e35b2a@web.de>
 <161f567a-f33-7865-8787-844a299ef9c1@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <161f567a-f33-7865-8787-844a299ef9c1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JebthncGfwuVXPr1DYhkIAV8c7xV0vnUxPKZgLIvW51HNQwxnkH
 QgU/NdJUEW4akGI455DgRTJekIFVu208xOZomT89AYEy6VSwoe99snNVtf/rjQ+4f4c2xt/
 iafcxEufdmi03/BVCiGRsMbzcvhQsEUGTEfU4lGeXZ6OiJNPpkwp4Nec7c+XAfxGGZeuyBi
 JULLvJpX6BUaVISgG+eig==
UI-OutboundReport: notjunk:1;M01:P0:qu5W9QmvmTk=;x8TQW3vaTlT8+RJy8VtBZkkR+Qp
 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
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [RFC] Replacing special goto statements by direct
 returns?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3778
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/ndoMqvlTtLT1uQEwnnnSgw>
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> I think you can do:

Which computation tree logic variations do support data processing
for unreachable source code fragments?

Regards,
Markus
