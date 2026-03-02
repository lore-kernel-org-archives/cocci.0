Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A97E9B365
	for <cocci@archiver.kernel.org>; Mon,  2 Mar 2026 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YlbZ1ce0yGSs4PtfUj2PrGZpf3vidkjkjWQBOV5xjgo=;
  b=vnLG9MXO7k0pWbLQwLLQ0bbu6K1lzVa8Dh+Yu1SHQppSCovGpH16BJ62
   o6HWRvBTVD+K9mOesE2INsC/glMy4xpne23U0WOfH3I9huDJQAZMBTP2g
   2BVF5hYdB1ZGJDPHMMgpgXl0Ir6H3CMl3Z9MaERAv/FzEu3oIyYFNTf9o
   w=;
X-CSE-ConnectionGUID: RlqpKs7YQUiO6PCBQTheSg==
X-CSE-MsgGUID: CpFcg1DIQomliEM5NRd4bw==
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
X-IronPort-AV: E=Sophos;i="6.21,319,1763420400"; 
   d="scan'208";a="265781359"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Mar 2026 12:16:00 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 75CFB806DF; Mon,  2 Mar 2026 12:16:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 76BB7806DF
	for <cocci@sympa.inria.fr>; Mon,  2 Mar 2026 12:15:58 +0100 (CET)
X-CSE-ConnectionGUID: qKN2GU6eTiSjI10J6K+lzg==
X-CSE-MsgGUID: syzxyjCcStqQbKmqtE3rfw==
IronPort-SDR: 69a5716e_9Pj8nzVEgHNDxgDh6klpyFVVVxsjua+5pZFaE9mIT2NDPsX
 XGafnZg4sZlg5USiej+Ug0/iXhyGuG0Gcs6eLGQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EkDAD3b6VpeAQP49RagQmBUoI/aH00BAtJhFiPU4Zfh?=
 =?us-ascii?q?zyHVYxLAg8BAwENTgECBAEBAwSEdwkCjSACHgcBBDUFDQECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAUMOCjGGTw2CW4EsgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEdAkdEAgEDIx0BAREnDwsaAhgOAgJWGwEBgn6CIwEGEAEDNgenSYEyg?=
 =?us-ascii?q?QGCDAEBBoJp13sfLCJZgWcJFYEKL4VugmUBim4nD4FVRIE8glIxPoUQgw6Ca?=
 =?us-ascii?q?YImgQ6TD1J4HANZLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0XFB9YGwcFEiEqg?=
 =?us-ascii?q?iR4ggEPhmt5Ay54DiICPFxKPgoBWgWBNwIBC209NwkLGwQ9jmI/gjWDRiSlB?=
 =?us-ascii?q?KFFNAeCOIFngWQMn20GEy+DcQGTYA6TC5kGqUGCACKBXDMaJIM2TwMZD5JUw?=
 =?us-ascii?q?j5FMjwCBwsBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 MT6sdNk5V2rwLDn9w==
IronPort-Data: A9a23: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
 AzwUQ==
IronPort-HdrOrdr: A9a23:e8Mdw6t0U9zM1xb7klZQVvkv7skDf9V00zEX/kB9WHVpm7+j5q
 WTdZUguCMc5wx/ZJhNo6HlBEDEewK6yXcX2+cs1NWZMDUO0VHAROoJ0WKh+UyDJ8SUzI5gPM
 lbAstD4ZHLbGRHsQ==
X-Talos-CUID: 9a23:ZhFfu2Psnnp4LO5DQQpBrmEpRM0Zc0bf7S6IARGbSmJ7R+jA
X-Talos-MUID: 9a23:z8PEBgimSYcbSMIahfZJjsMpL9Z687WsI0s2jYw/seqBLDBdYC2Tk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,319,1763420400"; 
   d="scan'208";a="265781347"
X-MGA-submission: =?us-ascii?q?MDFPzy/UbSEc/GxzIoWx0oR3s/2LaoWEidar9v?=
 =?us-ascii?q?ldHacRDe/f/luCvNHmGm4lwsQe655IIblVx9+F2C2mYbsrUpoV01VXCO?=
 =?us-ascii?q?oS20WwPbZ2NJdfoIetE1+FqFJtU+fKqMeLbqb6cQwaTJ7NJmIkZpqBKM?=
 =?us-ascii?q?PE5nny5wc2d71jsTGgRu7ueQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 12:15:57 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaS7-1vhyRK0W9T-013cUL for
 <cocci@inria.fr>; Mon, 02 Mar 2026 12:15:57 +0100
Message-ID: <6c9a5362-0c5c-4e1c-abd0-ac1e7c6759fe@web.de>
Date: Mon, 2 Mar 2026 12:15:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qaKB86ZrMggle6Hb6FGpfG9CU9ts+vEiZTDALtX9WwQlji9gqfq
 gTvPHsUOIC5zAEZpOUZTbQbXbKEoM60bu/phZZc2UXjhd5Vg3+mNu1tG0kxAczAkgpKl3Kr
 1nWNiGC3upNpTFGn6WcAU0JodTEAvyjIyDqjjpW6LaKK3tKPAezD8LAj/g8IL+JTv0cxPr3
 0ohOY7+2EaPWCTSwxd1xw==
UI-OutboundReport: notjunk:1;M01:P0:nflSj2beZv0=;rEF0VNotvNYzZPZ2rml1z8sSq2q
 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
 Ps4Ow==
Subject: Re: [cocci] Reproducing a known patch with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3320
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/Jgne0oriFPypqYv75BfFUw>

> * Why was a source code place shown here at all which does not contain a variable
>   assignment before an interesting function call?

May I expect that selected source code should be found in nested compound statements
even if it was not restricted as belonging to a known condition check?

Regards,
Markus
