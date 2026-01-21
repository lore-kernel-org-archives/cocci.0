Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE318D262B2
	for <cocci@archiver.kernel.org>; Wed, 21 Jan 2026 08:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WCDtZpS7uwMdOy+5fiAuVcOLzWVFz5m2gd2Zl90RUmU=;
  b=NycctvmC3qAuCyfNV0kmOkEYhDoDSy5vciwRAJbAr4i9eEdcyrkiioSw
   +5sUuILfZQ1YPeu4wZrEncfOykb4MBPv0MOjxpTqdZUAebQn87f5NGnb8
   /JD2AmqNfJ0RAQ1vAtpl/qpb1i7kaRf+GcRpvMMmXrksJkWgRmdkFnpYT
   w=;
X-CSE-ConnectionGUID: X0f5unsbQg++ZidjzASVqg==
X-CSE-MsgGUID: NhexOssOSsaEEz8zlVEwAQ==
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
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="259584899"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jan 2026 09:19:55 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0BE5081830; Wed, 21 Jan 2026 09:19:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4F92881807
	for <cocci@sympa.inria.fr>; Wed, 21 Jan 2026 09:19:53 +0100 (CET)
X-CSE-ConnectionGUID: BsNWyOgeRVqZQpUyCtboAA==
X-CSE-MsgGUID: qWKYlp9jTOys0MSTGPRljQ==
IronPort-SDR: 69708c28_oC/9kCWJ/L7zaetJHhdt0z7wyrMvl3U7fWY1lImQkUyqsCf
 PrfR33CrgygRI27y5JfLnL6pSAXbXikzqMoPQWQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FrBQC5inBpeAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VCCQWh+MwQLSYRYj1OCJIQ7hzyHVYh5g1ICDwEDAQ1OAQIEAQEDBIIMgnQCj?=
 =?us-ascii?q?QICHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABQ?=
 =?us-ascii?q?w4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjBBkBAREnBAsLG?=
 =?us-ascii?q?gImAgJWBgEUAQGCfoIjAQYQAQMPJwewB38zgQGCDAEBBtpjHywiWYFnCYEfL?=
 =?us-ascii?q?oVugmUBhiqEPScPgVVEgTwLgkcxPogegmmCJoEOgxKHDQaJYlJ4HANZLAFVE?=
 =?us-ascii?q?xcLBwWBI0MDKi8tIw88BS0dgSMhHRcTH1gbBwUTI1MhBhwSAgMBAgI6UwyBd?=
 =?us-ascii?q?QICBIIQe4IBD4cFgQAFLm8aDiICQWsCAQttPTcJCxsEPY92RYYlpHihRTQHg?=
 =?us-ascii?q?jiBZ4FkDJ9tBhMvg3GTYQ4GkwUemGgiqR+BfyOBXDMaJIM2TwMZD44hPoN1x?=
 =?us-ascii?q?x1CNTwCBwsBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 V0EzOGgRWz8HpL20QpuZwsj9Lk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:4Ca6F64Oy1OSM4qfqAPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: 9a23:CA9sVmweJj4NpjYgojbqBgU+AeYaY1rSwU3uOn2BEVt4Y6GfTna5rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AbtLHJQ4njg6s0MQRQ0SmnuW1xoxx3IefDFhck6k?=
 =?us-ascii?q?hqtLcEBdMFA+niDaOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="136581641"
X-MGA-submission: =?us-ascii?q?MDEdyDfYh8uUYkYZyvnh9o5MV/ho41w9LjDxrs?=
 =?us-ascii?q?mbMlLXpzxyZpH9TXa60xsIfj34gx7j0VXJujWqcPcOvBhbdS9xfeCjLH?=
 =?us-ascii?q?SN7QlqI2vRfes8VW2+HPgvm8y1Oxur5phhVIyeXEt9pD5QrF8gzhE16M?=
 =?us-ascii?q?LdzKV3ytUajGkgFQbwzqO22g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 09:19:53 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.226]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPKB7-1vQ7mU2B9J-00LvC3; Wed, 21
 Jan 2026 09:19:51 +0100
Message-ID: <fa2638d8-305d-4d74-9747-5c239ff3a669@web.de>
Date: Wed, 21 Jan 2026 09:19:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de>
 <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr>
 <15bca19e-5a87-4efd-8da7-c6ea2cad27f1@web.de>
 <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr>
 <78df0ed3-2bb4-438a-bba5-c858dd20c1f1@web.de>
 <2e04b3-525f-c970-4d51-ae20a9cd7a2@inria.fr>
 <3eb7e985-02b5-4be3-9414-78d7e155bf84@web.de>
 <ba44f42c-202e-4fc2-b906-ff06f0aca80a@web.de>
 <c3137d6-dcfc-b982-9db-4edf95a12ae3@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c3137d6-dcfc-b982-9db-4edf95a12ae3@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6JsgcqU/fWyJN212kgp3nuv5xihOTTFLK0eedxCyu+GAZ+Eqd6w
 qzMITkEN/boAyz07l5qNZS9gd/Rfom8kGDo1rROuZsURsqGcVHqf2jSLe8Vxx1fHehhWLqX
 iwsgdUx2XHLA1e68bRCz+96OHIIvUKl7GWmM7xY4joxXh2OpRZyWlw63cBF30T0/9roKRiL
 +2PwFCuACxZAs90yILhGg==
UI-OutboundReport: notjunk:1;M01:P0:QtSIs7QwWGM=;cOigDY5yBofUs2Usoy29aMBLG7z
 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
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3291
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/hNXRCDlWW5oUjbNWHTqjjQ>

> This should you give what you seemed to want, with pointer->member in the
> immediately following statement only.

Can we benefit any more from this software design aspect?

* Would you support to integrate another enhanced SmPL script variant
  for the detection of undesirable null pointer dereferences
  into the coccicheck system?

* Would you be looking for any source code search refinements
  according to involved function (or macro) calls?


Regards,
Markus
