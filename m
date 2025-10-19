Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26C1CCD183
	for <cocci@archiver.kernel.org>; Sun, 19 Oct 2025 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7t/hnFXP5RAEWKxKIkA/a5UPSymcxfxj8oW+FpN9ju0=;
  b=VOZzTGDClLGTLsASh4t2GpxK6k3BmbX6ZGWX3OwOm7JQGohgWALdjW/S
   W0cTKDdPXgPD2euk3TgIHzLL8uB8UEiJ+EWZM3vVdPTxmHCDV0HuienGE
   kQpAuQ1YRlh/nUTCQG6w6u4Ij+iXtUpjo0D8x65udh+ewhcUFnT0AeKSG
   U=;
X-CSE-ConnectionGUID: bisFdLNCTCyqLPdK0r8y4A==
X-CSE-MsgGUID: D/bFAlaqQy2chnGW0IH6bg==
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
X-IronPort-AV: E=Sophos;i="6.19,240,1754949600"; 
   d="scan'208";a="245013927"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Oct 2025 16:50:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 39D7FE0172; Sun, 19 Oct 2025 16:50:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1841CE0171
	for <cocci@sympa.inria.fr>; Sun, 19 Oct 2025 16:50:17 +0200 (CEST)
X-CSE-ConnectionGUID: VChd2TmPTZS6Qt5SagIeYg==
X-CSE-MsgGUID: WZP5YJFwQRK6stuZpTa+Wg==
IronPort-SDR: 68f4faa8_PxQ3XLIayH99PZ2VVvMn2m59YJq7KudVuXnjd75nhF9BTK1
 uFPBjGo1Poku2Fez3GbbnMa9zp0hrP+MNAe8Rmg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HkAACZ+fRogwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8EAQELAYI/ZSNYMwQLSYRVj1KCJIQ7hzyHVYh5g1ICDwEDAQ1OAQIEAQEDB?=
 =?us-ascii?q?IR2AQkCjEwCHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBOgcOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjH?=
 =?us-ascii?q?QEBEScECwsaAiYCAlYGARQBAYJ+giMBBhABAw8nB60hgTITboIMAQEG2l8fL?=
 =?us-ascii?q?CJZgWQJgRwuAYVsgmQBhieEPScPgVVEgTwLgkcxPogegmmCJoEOl1tSeBwDW?=
 =?us-ascii?q?SwBVRMXCwcFgSBDAyo0LSNLBS0dgSciHxwTYD0XQINJGwZoDwaBExlJAgICB?=
 =?us-ascii?q?QJCOoFpIgYfEgIDAQICOlcNgXcCAgSCMYEQgikPhkICAQttPTcJCxsGPZM4h?=
 =?us-ascii?q?VWmFaFFNAeCOIFngWQMn2wGEy+DcQGTYA4GkwWZBiKpH4F+JIFcMxokgzZPA?=
 =?us-ascii?q?xkPjiEZhBrGbUE1PAIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 Fg6h1kmCdk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:MlB6QK+peaepuh/HIc5uk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:N3XgzWyivrsjZeCXsts7BgUqMcApKEHY9EviGBGBFTtSQbK0RG6frfY=
X-Talos-MUID: 9a23:pQTWBAmxVmBUqvfK310LdnpdBv810oaAF3k3sssdp9S2LRB5eAiS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,240,1754949600"; 
   d="scan'208";a="128611455"
X-MGA-submission: =?us-ascii?q?MDG1BIRG4ssiPAJ9PyH1fhL3143Izeq/eLokiu?=
 =?us-ascii?q?K190ReITS1EIpuRrGOqq3aqM1/t61dQBnwR6MU39pmGGr9ZmGTh1bA2i?=
 =?us-ascii?q?o8mfayJEja8FxHEfu6VoD/s+eWe6S6+w1YgNkpfPpPjp8zEexbN1kFQH?=
 =?us-ascii?q?CvWB9UF0E+PuaKIU3oEThWUg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 16:50:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760885415; x=1761490215; i=markus.elfring@web.de;
	bh=7t/hnFXP5RAEWKxKIkA/a5UPSymcxfxj8oW+FpN9ju0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Di39oho6y/bMLqCmXwKz0yW9SjftUvX1zOkgg5pBDBaVn/a+1hgwxXtGs1i0obm1
	 JhltKpZQbVw/zP4x0yEJn7ds5zBpIllecmODtlrIXYjB6P3h/66r1o6lmVQ8d7ZHn
	 Kyn1yDVWVEkIH8HJsloVERnClp8uMbKx9gPU2snMynAFNzMOizygdov7yuCSYE+79
	 xMidfCKB3hwtQntIh4pHZUwPZEY70tdLZwKMWmmLB79t9qXGxlbB/u1/55yYRa8bb
	 VX1YElyWt60xZKwzP2BgcahSPIvCYg9zSv1IMEN/q6CBaiHJEyZORIG44Qsvs2HzW
	 EJ8t4QxAXaS7x5gdxA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.180]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSIEs-1umBW336cq-00L26A; Sun, 19
 Oct 2025 16:50:15 +0200
Message-ID: <4043431f-03e0-4784-b6ec-924f5ecc961e@web.de>
Date: Sun, 19 Oct 2025 16:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <4afdfd37-3177-4480-9648-ab0d7f59097c@web.de>
 <d1b6d33d-cfc0-ff6b-47de-7bbc28e8a7d@inria.fr>
 <c55ea172-2c1b-4bbf-b5d4-e2d421e18b1f@web.de>
 <e5b2ceef-31a0-a54-dd74-c4dcdfcba5a@inria.fr>
 <769428aa-9801-4805-bfc3-cd789f7541d1@web.de>
 <9636e097-8570-7d37-3e6c-68de116cbb85@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9636e097-8570-7d37-3e6c-68de116cbb85@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JUNf1DRd23b3J+0efNszrjWs4tMW4T1JYBVcFlIBI/MoGeqdfim
 PNY3Yh16t0FkZz6lhhz3RrieLHsOB+IczD4MmGrNBkFGjlH45CXGNGAgXZ96hA++XsWL8sH
 1+j355CyVWGTWH/iGKtn1SQkMpZKHV9a8Hy29/4fGeI3ssq2pnmJBl5B6WxmMzUsLFI+voR
 JR01H1yR3dcvnnzjtlszA==
UI-OutboundReport: notjunk:1;M01:P0:s5fyn6DkUAU=;JN/a4F0xatRGf3L8X3TtfVSA7nV
 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
Subject: Re: [cocci] Analysis challenges with SmPL for pass-through
 functions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3082
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/4043431f-03e0-4784-b6ec-924f5ecc961e%40web.de>

>> How many searches would need to be performed for the evaluation of
>> SmPL disjunction elements?
> I don't know what you mean by counting searches.

Data processing statistics can become clearer.


> How is one search defined?

I guess that distinctions would become helpful according to the granularity.

1. SmPL rules

2. SmPL disjunction elements


Some data processing is probably repeated then.

Regards,
Markus
