Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03D0C46CD2
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=8Q39MoEE5c2BAEWzv/X1MK6xCyDVtHPrdDifClLPsc8=;
  b=lu8EUkkqrD1bcr19mTIGhJ9Z5RUh1kEMhKdrDHe/S3RhMuEAzCt16ZzK
   JvjUyig9Q3gbeL9Hf5zBJw8UCLaXCSZdJjWDIZHnUZGTSVlFQSkry4hJ4
   sPT5pcAwNcv3knHjbVYqTZ9x55XCgKIp6hamTOl641956gTddsy/cB58e
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="144142005"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 15:43:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 99ED2E004E; Wed, 27 Dec 2023 15:43:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B38FDE004E
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 15:43:26 +0100 (CET)
IronPort-SDR: 658c380e_0yQ3NizqH0ZibiDf5N2sRYzjzhoLSktpeuADDXESrHkrD5k
 WZcu9O2aKvjtlj0hxjun094SHhLvj2ATdm5hfOw==
X-IPAS-Result: =?us-ascii?q?A0FRAADKNoxl/wMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYI4B3hTMgQLSIRTj0GBdYEFg2aHNYdMiG+BVhSBLD4PAQMBDUEBA?=
 =?us-ascii?q?gQBAQMENwGER4c4Ah4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECgQYThWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdrHQEBE?=
 =?us-ascii?q?SYBLgEFAhEVAl4BEgIBAYJ8gisBAzEHrj2BMoEBggoBAQavWB8sIlaBYAmBG?=
 =?us-ascii?q?i4BiBoBhEWBIoRiD4FVRIE8C4M2g3yBBoMcgmiDZoU2BzKCHINPiiKHNH0FQ?=
 =?us-ascii?q?XAbAwcDfw8rBwQwIgYJFC0jBlAEKCEJExJAgzEKgQE/Dw4Rgj4iAj02GUiCW?=
 =?us-ascii?q?BUMNARGdRAqBBQXgQ5uGxIeNxEQFw0DCHQdAhEjPAMFAwQzChINCyEFVgNCB?=
 =?us-ascii?q?kkLAwIaBQMDBIEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMTwNsHzIJP?=
 =?us-ascii?q?AsEDBoCGx4NJyMCLEIDEQUQAhYDJBYENBEJCygDLAY7AhIMBgYJXSYHDwkEJ?=
 =?us-ascii?q?QMIBAMrKQMjdBEDBAoDFAcLB1IDGSsdQAIBC209NQYDCxsGPgKmTXsTgnbFA?=
 =?us-ascii?q?TQHgjSBYIFhDJ8rBhADL4NuARKTJQ4GklQuh1CQTyCCMaYVgWUCOYFZMxokg?=
 =?us-ascii?q?zZPAxkPjiCEK49HQDU7AgcLAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 jMNxq7ka5sePMv31h46ArGVtJvHEQzcUIIUyhA=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nx5shKj75Z4CWGR+eAY5J+hVjHBQXgIji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBHpTngAtjmfZq4z/VICOYqUotKMDOW2ldAT7sN0WKB+VHd8kTFn4Yx6U
 4KSdkaNDSfNzhHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNj2CJ5sA0+9jYDzra3GeqTM2fabQn/
 enjPZ6mw==
X-Talos-CUID: =?us-ascii?q?9a23=3Anq+2KWnDJsGny96ARpR7dZcCE+LXOS2a6nbwLmW?=
 =?us-ascii?q?pMmVWFeaMVWSv1bM/ycU7zg=3D=3D?=
X-Talos-MUID: 9a23:9AoqzwsqaXKQVcqM4s2nlTZ4MOxB5J2SLhoBiZIcntnVciYgJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="144142002"
X-MGA-submission: =?us-ascii?q?MDGHT5pe7ugLEcgJ7KYozU8djodoe7uq0w0yWO?=
 =?us-ascii?q?cVHkerkKjFsn3QWLvu/05QxF+q25rKackAWl9lWEfqm0IBDHomQbhLOG?=
 =?us-ascii?q?N+vJxaNi4y2AFYiJlrbgZs3RpN4lInTSSdNxz6iMms7vcoQyAT1Nd8zC?=
 =?us-ascii?q?sWmufl6nPET4ufK5RBY6EVPA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 15:43:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703688187; x=1704292987; i=markus.elfring@web.de;
	bh=qJhNb+kflSF1W8E0uefEQKaq7Lmn3gr9mOpVQlydGAM=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=fImLcrjOQv1M2gBUJ9+AmQ7HgWVkmqfCT+qA2E0bzmefyQ1fc0RDrY6btGR6wAmj
	 XQDgLCeEAbUZ0XjZ3yrMtCWIxn8grVwBpOzEs+OZwzVcycVJV5pwjC247+913WwlR
	 GjW9CNOvKox5pkXuyOP7QloxefEqcNj0GiNaiRwrAoigKZVfEwTWnY/vjPrru0hs1
	 WZF29NqLX2V+D6dnH4ADubzW9BhoVDErIaZpZZ7SB5rVy3Dlt6AFB9Q7HFSKViH1v
	 4jN4TlQwZgSEbblJkRnwHfL8XnDNzylPZ1bXseUINk99OmoGgvb/DcT4GNYvfzWS3
	 UezFww1+5QauPMe2fA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSIJA-1rgk433024-00T993; Wed, 27
 Dec 2023 15:43:07 +0100
Message-ID: <74183091-4c8d-4c92-b3f9-cebaacb41efd@web.de>
Date: Wed, 27 Dec 2023 15:43:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HyvYsn29WwCEI9xxdv9RQGBTPB/DqqDr8z3qCvI7bVdjZ4jHkC3
 G/wKAnFyAhII39qmEr7wJVgY8mbhx2o8NQUlZg9VZTJ+8K/W7J1cjSj15ih7EUUP8/Ef9Bw
 EJ5lrihMreoB6jRMk86Qwdu4o5BtYc4+6Rbdb79usx+U3HWsK1bKfI2khRJh/NB0dezmFc1
 SunLP6mSJ4DVppCx803NA==
UI-OutboundReport: notjunk:1;M01:P0:1fr8eEQ0tJU=;pBK/5erE819ePtx/PcpEJfmbBdC
 200Muo8GOIF0KMNeeBy/acJwSq4RAVKjmjqpewB5sjoLYfJ1mGaBiZfd7xHIrLKCrii8bve9z
 GQjPWrJzv5mAKEqkiq5E1w8G7K+GTF3224TeasdccPY7Op9SGXYa3wHIF2DRWPHrtjux6p5eI
 D8OUupxkvGkA7cJKTiBJyLvYy+gAfT5f7uALSKJPDeaISaAPP1YSf5dlC/k9/uZBKmeCaV58j
 hh0dlhV3SwyNlNVdFQM6oO3Nzq6+w0uIH2rbAJbEidGIzRsnHjZVXieMCGWuEZo3qW7Wv1DLB
 tFVG29Ch422AIH8ar4RdY3k0MdHuY8f7CgVY+YV18h+4O5iCqkqZolIB/zImNtbUuk93I7r/Z
 DxPUKEocaCFK3yzQ5ytc8gmua8vD6bkgccjrNEXTI4UUlhEHQ8YV82F0WZh+WnFdX+x0RrleA
 MZOUonFJnmXsVY6dLcz80YCMKB4mKkPqUCaxtxEODQjgyhLnNv/zEbsqWGHE0dzmvmfXEjXzh
 /LUd3+ngayatFTYSfrzp9vXZ+gvpnFZyRJQ1YSS7kC8lTAJFkXh3qGcYlexO24FfSb4arFyKA
 gPJKpJW29MA4uWygLgjZnXL1EbVpTtrpFo2+TfjvoLD90uKF8o89DZDTZlTPU14+L+uE6R+Fv
 T756oa1ZqbIBUtlB6wmpYBDb028VvNGjWxzjMiu2KZMKYhS50rnllD79BnPiJK6BmpYDDffTm
 dKrhlOAwjdKImggd5MDPQAgAl+L5HdDy+dI0IZ7fkJPMeMftMK9ReJFnlw8hGPiB2MPYyS9Pl
 adWtq6/Pedqu65yG7Soll2sVODuh0HyPR+MIu/u2+vUroJv8cNGi0g4vja8KI6uNaxZpAGd8h
 f7NG7z7DFxmzgV+XsCasXFSdVTeft9xP1Zw7xVdI7mNbTwixjpeUcWDT+SRE0JBzzkW3BPpw9
 +HKOPw==
Subject: [cocci] [PATCH 0/3] mtd: ssfdc: Adjustments for ssfdcr_add_mtd()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1413
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/74183091-4c8d-4c92-b3f9-cebaacb41efd%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 15:38:42 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  One function call less after error detection
  Fix indentation
  Improve a size determination

 drivers/mtd/ssfdc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

=2D-
2.43.0

