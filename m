Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3D5D6E2DB
	for <cocci@archiver.kernel.org>; Wed, 20 Nov 2024 08:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6mKzJhR4EufnpN6+osEPBuWrj2+ZbTKhySVB4mYTb0M=;
  b=TPVAv9E8rtkcN3JyWLwcxpHeL3QmJjNvjGbZOfZDI4PwI8FWya2/xZp3
   3P7+75adkZfuqHns8264LSJQEfAVnq1fP7uSWUnCVrq/QNorMU/geGyNj
   42yweKzmsiAA5XjGsscTT7s9d6wHwT2s5DkVZCjWziyMlXbBw9z6uGGIQ
   A=;
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
X-IronPort-AV: E=Sophos;i="6.12,169,1728943200"; 
   d="scan'208";a="194821350"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Nov 2024 09:47:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CE9FAE0133; Wed, 20 Nov 2024 09:47:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 42130E00B7
	for <cocci@sympa.inria.fr>; Wed, 20 Nov 2024 09:47:11 +0100 (CET)
IronPort-SDR: 673da20f_rlBROM+kDOWfrEA+GVe2eCg0y+SgmfhJUYi0dX6ww6Qlv7k
 GZCprJkb4LD7JL5zBFRkmc1DCkcdw+uKKe2hWlA==
X-IPAS-Result: =?us-ascii?q?A0FTAgCJoT1ngA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VMCgkKBVzMEC0iEVo9NgXQwhDuHO4dWiHWDVA8BAwENQQECBAEBAwSFAAKKV?=
 =?us-ascii?q?AIeBwEENBMBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOC?=
 =?us-ascii?q?jGFew1JARABggcBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgn2CMAEDDiMHshKBMoEBggwBAQbaWx8sIleBZAmBGi6Fa?=
 =?us-ascii?q?oJiAYVZS4Q8Jw+BVUSBPAuCeD6IHoJpgkWNS2iaYVJ7HANZMgFVExcLBwWBK?=
 =?us-ascii?q?SEsA4F5Tn+BNoFRAUKCTkqDLoFeBTdJgkppSzcCDQI2giQkWYJPgSUEBYNpg?=
 =?us-ascii?q?QuDYYRehHIdQAIBC209NwkLGwY9oQmEQ1Omb6E3NAeCOIFlgWMMn1kGEy+Dc?=
 =?us-ascii?q?QGTTg4GknqYdyKpBTWBSSOBXDMaJIM2TwMZD44hhC3FPkI1OwIHAQoBAQMJA?=
 =?us-ascii?q?YFVg3ABAYF8iCiBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:6LlZJKpWPZTltf49hdkMmNMaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:701ZgW40T90aydb2YNss019LH9k7VmXh0UiMKROAB0hGdI22VgrF
X-Talos-MUID: 9a23:khePVwqxGtC82SaVSzgezx0/BtZowomMMXEElKs+n/KuJAY3GTjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,169,1728943200"; 
   d="scan'208";a="194821337"
X-MGA-submission: =?us-ascii?q?MDFUU06wHaAZDOXJgQUn8ok+pgQbd7Vo3IYQ/J?=
 =?us-ascii?q?qCLi7h2k1kX3NOxAp3N+zLdywsr31dZ/RgOIXfAKTFyaUwUIp570PU8i?=
 =?us-ascii?q?/kNa54cj/OLFHM9ITErC2fd4TQnxb334k2sK7Ttn4LHKdvTRc1NADowG?=
 =?us-ascii?q?x755Xxzba4TeMR5eFFuA+Eeg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 09:47:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732092430; x=1732697230; i=markus.elfring@web.de;
	bh=6mKzJhR4EufnpN6+osEPBuWrj2+ZbTKhySVB4mYTb0M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=seAdtX3MoCpe5e23VrNV4V+01BZSNyG1HM24uoWRjtVpFc9iyLAiuMd0JcA8+vDW
	 CxTaqRpMxfhnvC5fJ9NVm0gtG5SVYZPyE3oEVqgRTSK1C6gywA3GF31bjRHA+mioz
	 U5murWzMzn5CyDNcWLJEKt1NUMOHwjeDYR91jXMd9UASsQbepQQ134Gc3vO7eoOFa
	 L1AsHFAZb9CHBKTgjPRTE5lNkqqTiIkUjHox7F3qyQ/CLK6lCFeu+iNZwFHFyP1v+
	 nYYtCAPnHTyKuBlRiyNKEHh7xvsYiK97hdFAzYyqvexBnXalGmZ61ILGUq1LcEzgh
	 SsMkrBs/tM6P26k87Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJWoe-1tT9ug17LU-00IJnq; Wed, 20
 Nov 2024 09:47:10 +0100
Message-ID: <2866ab12-ca34-4144-b593-fa110cf89098@web.de>
Date: Wed, 20 Nov 2024 09:46:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <e3af9f65-c923-4fa0-8a7d-be1b27d47fb5@web.de>
 <c46ce4f9-30b1-4791-860c-e93aeda8a0d0@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c46ce4f9-30b1-4791-860c-e93aeda8a0d0@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:K0gZu90E9fUfrXq2ke7Hh5wjiYAoC90TuNtXlc71x2obBmz2cyW
 j7tHlSbhrWZ47njLFhQCtorXI3h7TVnegwg8EdaU+m0vdlUufesoVf3A7WiX1Q82h8cION/
 0o4XvDcrqAV2ettr2B2B/msYqohDwbDpB9S0ZYpBn9HWJWjWeK8KpuCX6d0uqfWrF+wQBxF
 EbgQxYt/cDFnu6RKmIrew==
UI-OutboundReport: notjunk:1;M01:P0:Cv0FLnJNuJY=;Y1YFp4wlPubWGiESxLcoSTB4qGr
 L9MElW7+y/y4uHWkB+XmtakxMw6OwJvT1CDNaw0/yA90F3zhC9F67PGEPOxFFxDG2R6quhDaH
 JXJz52G4D4PAxAPtUSOkmI1/zY7Zko5lOUD+f14qS46+MBFgiMKt0QlYaebNPOSyhE6EotVK9
 nXilwqR2agZflKm2vHIx2IxiBGGH8KB3odh3L20TWKhlqLVxV6WlflZ0qvnQXu5z9GB/yZQ5n
 jkYxm2CaqUJXfPqqg0+5hJEJ+ciiqh6k2vSmShWFpT5VwZdp5W2cpZxHUorHKnD2XmgO3/ztH
 R2ejahkQq73c8HQoF5LZIhuC66XozklDBoGtZCL1T4WFF/xSdJnmy1plnO3HkcNe1vRgfnApn
 mRQ8gHfvjfol2Rg4Kzc3KxkfUu1IfFbXhnm/WRfALFYZhjltnIbkSFXl0Ks8uxc42bo4Kspn8
 VLLVNG8YKPjFiA7NUBLhzKE8S4kY56me9RJLM5ug8A2tIdWPDcQlqMMNBCa2nZLWjtQbN/GO0
 MRL6EGti0fV8lEcpVSCBMPx/trjPPiSqFekkM0ZvkdfIe/XuovYzRC368Z7ontg74CivFtn+Z
 4JhScA2yRVXr1SrLA3MZOZLWID0fX6y9uGLMKnLqTdnAKONZyi8CKd1eg+ERI5gp0u0MOySmJ
 SIFloxMP32rySwLfqgSoiHWgvvepIEug9WF/3yKHdqMzSBI19W4mkENDI9N2fzScYaVNTliH7
 c++IrJ5aeHxu0huGjW+Iimp+y3lAk6OOnrDr1Jplxf0d+sFeek7ub+T2p3BIznNLLFQ140WyO
 e9bfUJwI7Bqjjr9UIp4e5TYQZFEj85xi1J/NU4fx31svhky1WIRkJKV2Ri5mBsXyxVJlkxEwi
 tz0IbiZ4kuVE477Mckiw7gG8KhHf/EhshcGlhu2dQt3zdJq0gQxixS1KS
Subject: Re: [cocci] Marking several issues as =?UTF-8?Q?=E2=80=A6?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2095
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/2866ab12-ca34-4144-b593-fa110cf89098%40web.de>

> If 100% of those were actual issues you found, I would be very happy.

Do any of the presented bug reports make you feel uncomfortable anyhow?

Regards,
Markus
