Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CD2CF34B0
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2024 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6YtWEy943w6XN6R2AHNa0OznWZOmWncdEFICHNQpfYU=;
  b=UonO4yTw6YY5LAGMbeSx+sg3k3gVHPPZOBuoWNauLmpkz/DRqnJPhHX6
   6WaC9BZa3XQ0YZugt4wKHI1SI7+EguOJc4qjAne3+pgRK3h6B9WyG1a8M
   pybBmhdDEki+reeP80pm5L/9AEhoMSYsarHHmpxzVuRdy3JlcFTzt8vbX
   g=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.11,174,1725314400"; 
   d="scan'208";a="186826539"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Oct 2024 17:47:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 46C28E0CD0; Thu,  3 Oct 2024 17:47:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A5EB5E0035
	for <cocci@sympa.inria.fr>; Thu,  3 Oct 2024 17:47:36 +0200 (CEST)
IronPort-SDR: 66febc97_EiDBJpcnZhD852NHXiMPAszpqniw2f5/PnGRfT/LhNfqY51
 40IhoOTrjjkl//UXcXOv15GDwtCEN4H4hkL7kbQ==
X-IPAS-Result: =?us-ascii?q?A0EHAAAuu/5mhwsR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYJDfQZUMwQLSIRWiB2HMIF1MIQ7jw6Eb4QIg?=
 =?us-ascii?q?VYUgSw+DwEDAQ07BgECBAEBAwMBhQACihgCHgcBBDAJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBOgcOO4V7DYJjARCBFIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDTpEAQEBAgEjH?=
 =?us-ascii?q?QEBERsLAQQLCxoCJgICVgYBEgIBAYJ9AYIvAQMOIwcNBrFLgTKBAYIMAQEGg?=
 =?us-ascii?q?UYCDAJD2EIfLCJXgWMDBoEaLgGISgGFZzuDQnonD4FVRIE8gwM+gmEDgSE+g?=
 =?us-ascii?q?1uCaZINhWFvhR4liFxwkXtSexwDWSETAVUTFwsJBYk4CoF5fQUhKYFFJoEgg?=
 =?us-ascii?q?nUIgSsTgQYCgleBZwlhhDuCPHBigQ2BPoFZAUWBF4FcLxskC16BQ38cARYGF?=
 =?us-ascii?q?QSBJQU4Cj+CUWtOOQINAjeCKCRqglqBJwQFg2uBSB1AAgELbT01BgMLGwY9r?=
 =?us-ascii?q?F2BWwFHggyCBQLIMDQHgjeBZIFjDIonlSsGEy+EBY0BhjgOBpJ3LodjkGUii?=
 =?us-ascii?q?2GBeJsigWc6gVwzGiRPgmdPAxkPjiEZH4N1gQuDVooqAbBaQTUCOQIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYZPgUsBAQ?=
IronPort-PHdr: A9a23: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
 UljKSuCWL9bybdtJzgDYOr0ppZFX/JRH/UsXQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:9a89UK7gYDx0vaGWigPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:9iU6JWNPco0dce5DYhNs+m9TAtoeWXDX1GvKCECxMUZgYejA
X-Talos-MUID: 9a23:ftgrRQVSLwUdBdTq/BzrnRBEKvVT34izLHIngZMWuNS9LQUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,174,1725314400"; 
   d="scan'208";a="98155857"
X-MGA-submission: =?us-ascii?q?MDGffWRLbPq9cbTewIYFwpNfjJqNYwqu7+mHe+?=
 =?us-ascii?q?WlFdYvZI3L9cn2k/pivCLV2WjtOnksIMeIHgvygdtrJHftkG5u9Th5Cq?=
 =?us-ascii?q?AyqM+64N/uuMbDCF46I4ibc1jvgshpPU/T+JLkie2o6T3E9+4V4zMrlp?=
 =?us-ascii?q?ZXk+ZLvNaA7q+cvTiu1IpTUQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 17:47:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727970445; x=1728575245; i=markus.elfring@web.de;
	bh=6YtWEy943w6XN6R2AHNa0OznWZOmWncdEFICHNQpfYU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uRKwIq89YSdIDUSSN6xXQU2nxgDwzu+GmR2DgpocW/h55ZNLZnSWP9uBlEFhQnPs
	 9L6jHYFdPAFZp9magrXVsE3kkyBVu2IkLUt1R559o0aP/pMcbyDfG2006txOwD5wb
	 wACAJtxuxztRUk/CZiNLcjh8W7OWCsvvmVRZF3w1Zuv5SyyNGQtTsQfkbfLHcdCOq
	 6osE6+vaBsOjhy6nIwdMNWbdlhoDDbOuuCk7TAoiICbE/1RxKkDIXpL1TWVbK2Gkk
	 Cv8xmq8/Ucthxov1RL07qgsmCc2y11DzZQ5ivRa4VxF3MKw2NBHxDyK5K4GRjJKnR
	 CMakiobT8kqbkFynog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MS13Z-1sTXja2faV-00QQXB; Thu, 03
 Oct 2024 17:47:25 +0200
Message-ID: <66655a11-888b-4c50-8e57-06552b82f922@web.de>
Date: Thu, 3 Oct 2024 17:47:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Stefan Roese <sr@denx.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <72a7bfe2-6051-01b0-6c51-a0f8cc0c93a5@web.de>
 <ecda8227-d89a-9c23-06b7-54f9d974af5e@web.de>
 <e68a714b-32f2-de9f-066e-99a3f51a264f@web.de>
 <8edc93c8-b146-4507-8336-0709b2596cb9@csgroup.eu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8edc93c8-b146-4507-8336-0709b2596cb9@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7MPgs994GP7PFwTjO44hqBW56mTWsQeui4bBMdSxXLvJc+I18VO
 s3LsKLJlB0WoxgwzjZ3tpXnNToRVLOajOQJrK5FHuToJD9iwBaTwB3/EYIyHLfak5541MD4
 z+J/lsV1Ae+bTBuAk96TDFTiscjOfyOrECsQUkwKqq8FY+kMmfdCeB0a1TdZ+DpOjv0/T3O
 ehS3hOXBDffyRnAy/y4yw==
UI-OutboundReport: notjunk:1;M01:P0:GJwRiYMBY8M=;LW10UzlCbGnHFde9E838MAi2OIL
 wSC/ml98zkbeD4DWod8gSxUewZX3IEkJ5aExpsgM3RjbNjXc1PEtBUvuv7gOczmmdtqArMJAZ
 3czz0b56geNY56a8I6Pde7f9u0Lpz2ByxceN4jElHLmdKCDkPuTXACBmPZQVvxG3vJmPB42ZM
 nHPrJLCvnp2qz8H1swUjXdHY93ft1ten354QN1DeyeDzxOM9XvarY9sc2mTJedPK9C78yOROL
 svdUlaxvCGJ/o1nf06qMfLEc4SaYgG/AlmzFTpYk3WYiPmEekwyuIydN6t6+ujd7h5SL12DxD
 0yeUZifEA7Z3Au8tXix2iIh/PPo6YpM3O4P3nx00is0Lgmvv9TKxBRa/D+R5ai736S4KiN/GA
 7CQb89+v6OvVXWnxF+xUTliWQMD/VHtlD6EPcOaA3Hb35mWZigPOP1sTZNVawgdiqNX/ENM0N
 ALQw/4ri9OPoQhi42TzkJXUHlaLBOfGbCuBebLKqoqq1b2XQZL79tZPDQf6ZBOKStk7epP1XZ
 OvxsdVQzRv2GoSZL3pWUYHvYL84eFkme/bjS8oH/H/9UOttoeKaME+rZEn1geQ2thpRIUl7tt
 we0NIepxreeXWJA1xyOId/kD0mFoKnWvaicqFYXAAkYkvHPND7Nze62E5lfEzQRmTfT6dhl93
 Of8/rbbkxHPsBpXT9l4TzcwVnMPrJpxu3cDL+iFvbW/YNjJzUPXQ/jeJHYizZlAX+fhA486x3
 ePgbTSI7opOvpCjqhWv+IY4f+TvpzNiqh7owCEn+4FTfl8lNDApOHpTKaoUfAsYVNZNiagFyH
 pF/EzXXeriqSBJZ3hj8VYbjw==
Subject: Re: [cocci] [PATCH v2 1/4] powerpc/4xx: Fix exception handling in
 ppc4xx_pciex_port_setup_hose()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1905
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/66655a11-888b-4c50-8e57-06552b82f922%40web.de>

=E2=80=A6
> Looks like you have messed up your patches,

There were special communication settings involved which hindered desirabl=
e
data processing for known information systems.


> there is no much we can do it seems:
>
> $ b4 shazam e68a714b-32f2-de9f-066e-99a3f51a264f@web.de

Please take another look also at published information according to furthe=
r
mailing list archive interfaces.

Example:
[PATCH v2 0/4] powerpc/4xx: Adjustments for four function implementations
https://lore.kernel.org/cocci/ecda8227-d89a-9c23-06b7-54f9d974af5e@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00079.html


Regards,
Markus
