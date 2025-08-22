Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161BBCA0EEB
	for <cocci@archiver.kernel.org>; Fri, 22 Aug 2025 07:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KB8KN7O/ROdUlho57DUwYoncuwLw5vbJ9F3ackP7T8w=;
  b=bjt0SofQtUQuzgWcH3BVoWIYId3pa5B1sVQkPBFuah2aMlvOfkZf10jR
   UK316wBJHn89QsA5mSvRK1KGMfgusjfnT05B42HY2TnnUEQOyvnMhNzlg
   8tOwHBxPGw2d7Q5N5qlnbJcBIomBRIRxqu/+xzAw9m0LYcc5/FoWvjPFr
   k=;
X-CSE-ConnectionGUID: ExRL4CLlQWuHyT93d0ajhg==
X-CSE-MsgGUID: 1bgoRmTMRiyQ3Mzq00QroQ==
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
X-IronPort-AV: E=Sophos;i="6.17,309,1747692000"; 
   d="scan'208";a="235736732"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Aug 2025 09:13:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 22B90E0264; Fri, 22 Aug 2025 09:13:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7071CE0172
	for <cocci@sympa.inria.fr>; Fri, 22 Aug 2025 09:13:07 +0200 (CEST)
X-CSE-ConnectionGUID: uoXRlpCiS2+ar2A4UWQ5+w==
X-CSE-MsgGUID: fcUKLKtTSmqK8AtO0b3nzA==
IronPort-SDR: 68a81882_Wsv9MYdHx6K5XsNgGzmY8Pwv2xpl3VdotH92Fjw+fphniAR
 xyqq7bqCAyFWMCvY8ZgBDj0UwA8gzsi99qq6q5Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HNBwDEF6hog07ASNlagQmBU4JAgQdUMwQLSYRVj1CCJ?=
 =?us-ascii?q?IQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIUAAowlAh4HAQQwCQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAToHDjuGTw2CW4EsgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEXAkdEAQEBAgEjBBkBAREnBAsLGgImAgJWGwEBg?=
 =?us-ascii?q?n6CIwEGEAEDDyYHtCJ/M4EBggwBAQaCadd1HywiWYFkCYEbLoVsgmQBimMnD?=
 =?us-ascii?q?4FVRIE8glIxPoRDTYMOgmmCJoEWg2GWe1J4HANZLAFVExcLBwWBIEMDgQ8jD?=
 =?us-ascii?q?zwFLR2BJ32DC4EOhCcrT4IidYF3QRk/g1MeBmsPBoEVGR0uAgICBQJDPoFcF?=
 =?us-ascii?q?yQGHxICAwECAoEWEAIRQAIBC209NwkLGwY9lE6HGKUEoUU0B4I4gWeBZAyfb?=
 =?us-ascii?q?AYTL5dSDgaTBZkGqUGBaDqBXDMaJIM2TwMZD446hBq4DkE1PAIHCwEBAwmFR?=
 =?us-ascii?q?gEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:XUDLManmR03Ni7W+H95CVfnrQPXpDfNtimdD5ihNYBxZY6Wkfg
 6V/cjzsiWE7gr5OUtQ/uxoXZPrfZqyz/NICOUqUYtKGTOW21dBwulZnPffKn7balDDHtc079
 YeT0EGMqyPMbEit7eK3ODbKbYdKai8gcSVbLzlvg5QpGhRAskK0+46MHf4LqQRfmZ77PECZf
 +hD6R8yQZIUE5nHfiTNz0qX/Xju9aOs5T6YREXQycj4BSAiyitgYSKYySw71MxUy5v3bxnym
 TMiQr/j5/Tyc2T+1vz13Lz858To9fqysJCCMuQ4/JlUQnEu0KHZJlBR7bHhzw+oPiu5FE21P
 HArgwtJd4b0QKlQkiF5TXsxij923IV53juxUTwuwqaneX1SCgmC81ImIJedQGx0TtTgO1B
X-Talos-CUID: 9a23:mM6zMGBkKMNb4PH6EzRgxHQQAuskSSeexW2KChOFNl80C6LAHA==
X-Talos-MUID: 9a23:fzxSIQrsB33gSxETN8kezz9pCeRMwLiSM0UUssUvp+7cP3d2KR7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,309,1747692000"; 
   d="scan'208";a="123681230"
X-MGA-submission: =?us-ascii?q?MDGSfa0YgByDzu1VfR6Nqt0EmXULl3HkVKrAKu?=
 =?us-ascii?q?5LtNdg70sb2osqsip9ohltoQK4P+a4lC7cXPVnOPeLyKqCeMlYrLA/5b?=
 =?us-ascii?q?GRDRetHB+MwP9E8Gh0YyYdVorBVKCMAIRL94NHY41dFCT4wpO8Nl/hlf?=
 =?us-ascii?q?1fsyBY5WQSAPMrzTn2xWHd2g=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 09:13:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755846785; x=1756451585; i=markus.elfring@web.de;
	bh=KB8KN7O/ROdUlho57DUwYoncuwLw5vbJ9F3ackP7T8w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FoCnjlj9JHAgN9sK7oM00On2xoTzuBIec1gwKH+j3WTS0tgViqDKJddMZv2PZ0ND
	 lSnim8SKYlfCnJ5LrHe71b1sHZklSNtso9LbvJZvJDM5cd5W/6TvVirvRb+rUfUtk
	 s+FbSE4VFtwqs07Cjo1s5Gw5o+4SnHOo/tBSy0YEZneumpqcf0avOQz1MjJZa8MxC
	 h64IbeBeRPD/UJOL11BPxoAMZWhVzgxp6FbLoJEEfQX7Ga3wQG/s9kjTn8fBSHwQk
	 +DVXBwW2XU3qTZAAhoVUdRb+TiOWBWf/tqkhUcoKhEp5kyig7j9stzzjVAHHYrc4I
	 Ns/bfOEJJUrewL9Hdg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUCz3-1uz5Hu2L4d-00PefS for
 <cocci@inria.fr>; Fri, 22 Aug 2025 09:13:05 +0200
Message-ID: <ba58f313-5edb-4ff1-91fc-1682321e4d61@web.de>
Date: Fri, 22 Aug 2025 09:13:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <ae674fb5-8cc6-4807-97f7-92e2c4208149@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <ae674fb5-8cc6-4807-97f7-92e2c4208149@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:WivmiL9rmCTCQdnVocFAmSsivEEyNe5JC8jNt9FeBlQNkvqsUHo
 xZV1ghQpwwBn7hRuHrh2ZOCkrEOaexyvuYs2yeMYSdjmLNiJWqG4NrT2+VVFPo+ZFNDQtIa
 j8poVolYGJzbgvM1gpG1GILDJ5lJTMswF0yDf7bHH43CdIUlfTofZeJWGfZTlnxQDbMONsB
 NfBNpIlWEU1KjdBzlsF9A==
UI-OutboundReport: notjunk:1;M01:P0:43VCm/CLdXI=;9jhY3vn80Lms3++m75fYb1YPK6e
 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
 MeN6jtBe9Xab5tUE=
Subject: Re: [cocci] Reducing the scope for a selected variable with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2975
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/ba58f313-5edb-4ff1-91fc-1682321e4d61%40web.de>

> Another SmPL script example:

@adjustment@
identifier xflags, var;
@@
-unsigned int xflags;
 ... when != xflags
-var =
+unsigned int
 xflags = r->flags & PCI_RES_TYPE_MASK;
+var = xflags;


Unfortunately, an expected diff output is also not generated then.


Another SmPL script example:
@reduced_adjustment@
identifier xflags, var;
@@
-var =
+unsigned int
 xflags = r->flags & PCI_RES_TYPE_MASK;
+var = xflags;


An interesting difference display can be generated then.
Do such script variants indicate data processing difficulties
for the handling of SmPL exclusion specifications in combination with
a selected variable declaration?

Regards,
Markus
