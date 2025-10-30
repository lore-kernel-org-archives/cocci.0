Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69347CCF9F0
	for <cocci@archiver.kernel.org>; Thu, 30 Oct 2025 14:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lEgoBK9QEQKqzg5dzQhfR3LPrJ4cxEj9OaDNR0Pzkbg=;
  b=nU50rWL1l2ByWKqCyIrgQme1pHk2j6tgwlJU7jiZqoyHPo9w1mx/qtdU
   48oCX8yJ/yiDsqb2+MWzI1k4vwAE/YT7i3XvgzaMgdX5rDCbbN4DHPVRa
   EWPQb2LCX4LoLMXtylr8y9IDcZVmnTrg4trhfbUUM5vUfsMibqOH1y+p1
   M=;
X-CSE-ConnectionGUID: SKHKIWwtTyGYM0Odp5z9Lw==
X-CSE-MsgGUID: gMNHujYpS/6BprBoOc/TEw==
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
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246870930"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2025 15:06:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8D167E0264; Thu, 30 Oct 2025 15:06:26 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7644EE0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 15:06:23 +0100 (CET)
X-CSE-ConnectionGUID: wr4uKQk1TxCLYlKgSgTG0A==
X-CSE-MsgGUID: dg24KNynSHmnszxJzlx0Pw==
IronPort-SDR: 690370de_+zRykjYWM8mSIukEq+MbrxzvjNmV6QwMbvRk7EMC2/SN0ih
 8zxtUfFok+YDMZXPouFY3J77O399mrDqOXyF9sQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E5AAD6bwNpgwsR49RaHQEBAQEJARIBBQUBQIE8CAELA?=
 =?us-ascii?q?YI/ZSNYMwQLSYRViByHNoIkhDuHPIdViHmBVYF9Ag8BAwENTgECBAEBAwSEd?=
 =?us-ascii?q?goCjFMCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEBOgcOCjGGTw2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BA?=
 =?us-ascii?q?REmAQQLCxoCJgICVgYBFAEBgn6CIwEGEAEDDycHsEyBMoEBggwBAQbaXx8sI?=
 =?us-ascii?q?lmBZAmBHC4BhWyCZAGGJ4NDeicPgVVEgTwLgkcxPogegmmCJoEOmGZSeBwDW?=
 =?us-ascii?q?SwBVRMXCwcFgSAQMwMqNC0jDzwFLR1wDCgSEB8YEWA9F0CDSRsGaA8GgRIZS?=
 =?us-ascii?q?QICAgUCQDqBaAUBHAYfEgIDAQICOlcNgXcCAgSCG36CDw+JEAIBC209NwYDC?=
 =?us-ascii?q?xsGPZQzg1SZcI4noUU0B4I4gWeBZAyfbAYTL4NxAZNgDgaTBZkGIqkfgWg6g?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OIRklg3XLIEI1PAIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:LwwyV66oiYg5AkOhQAPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:mdv9oGwUCfG9x8V+XexyBgULAJw4UUTelUvACGuJDUVmc7KpZge5rfY=
X-Talos-MUID: 9a23:MzgDvwWHkvah6Qjq/DPj3m1BEtZu2ISrDlsfgbcUv9ncDTMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="129505691"
X-MGA-submission: =?us-ascii?q?MDF4VQmbcScm5HMnmM5UYDcO5ZuqlG7rNSptws?=
 =?us-ascii?q?qGvPzLhQK6XUENUFRwYAMY8ZdiWtiNjloiCMBHP9wtTidFp2qbtBoSPc?=
 =?us-ascii?q?HjViF8pklKkGhCRsjdxxmXFlkpLSr39H6KRRgLfeixuEy9EZcdBqS6eb?=
 =?us-ascii?q?QuopoGv8hVilOdAvSzKUq2oA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 15:06:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761833181; x=1762437981; i=markus.elfring@web.de;
	bh=lEgoBK9QEQKqzg5dzQhfR3LPrJ4cxEj9OaDNR0Pzkbg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R/KsH5Ge21Q3YO6peNOOZbmWDBl6+AzHjWhvfDpXWu7Kl5Sr1DMtocIfIy32ZPYC
	 8VfPPn1txFvLxLQ2rh5dr4kTkbbJ7txfKWfjJsXlg44ywEUjF6cJ0Ny0ANI3NCORH
	 qUyDsTNnznTPKYbyWSa/LpgIeA1MoQSrK+cD7a1y3Qs55GeVHh3OezKLC8uzy98tX
	 aVvw+adWxYEL11M/09jUkliNMHNly1o8Kh09LAy9OtO5QY1Xt9L4mTkv8PTM+PUsw
	 WI1cOcY2wzsSSw7Aaj/7NiodpfZivwuGuIb5ItuNE2nuzoPYAgEO6syUnRR/cmnaP
	 KOowZ2fWKH0D4JHxjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxpiO-1wCU1i3rCw-016pHA; Thu, 30
 Oct 2025 15:06:20 +0100
Message-ID: <d67f27c1-973d-470f-8903-7e5aaf93777a@web.de>
Date: Thu, 30 Oct 2025 15:06:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Miaoqian Lin <linmq006@gmail.com>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uUsLVQMS8kabKTgIQGtxnjZG9WKaZBCviZOgmIs3a1igHQOb94o
 I/A3VTn+H+HaHI9QGftSHIRX/htSnvoyor39Ex7OBTguYwRONrdeAihv+s1aoYDsW6HZ+mc
 DFMecKHtsC33Vom+Vxty78CxXmY5auXG2FNK5mi426N6qLdxcOS5O64SjneGoix5FIlajH/
 kDFKTpVtw2z3SPcZtD3vQ==
UI-OutboundReport: notjunk:1;M01:P0:KEcLI7s6840=;uMLCdw38StnHmRRGlvYpYKkq6TO
 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
 oe8cA==
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3124
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/d67f27c1-973d-470f-8903-7e5aaf93777a%40web.de>

> If you have a concern, you have to say what it is.  It doesn't seem it is
> about the running time, so why do you include that information?

How will the chances evolve to integrate another coccicheck script for
the discussed source code transformation approach?

Regards,
Markus
