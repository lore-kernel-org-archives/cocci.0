Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754FBEB64D9
	for <cocci@archiver.kernel.org>; Sat, 17 Jun 2023 08:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=khCI9JZpQnK/tB1MOssAvUjAUvsBk7hRAVJeb7mbNFU=;
  b=CN03dTWOgakylcYa80KNyFS7v+aAsqg2il2lhTKwYmXvp+mouMmSNXqQ
   /kAIzcbm5PGSKcNs/fCRLBTPEBbiXfRWnX9CDlw2d0oNcbBRCvpKI6CKn
   ECOSijrNWbSCrtWpfR1RhR1wcvqbvJB4w9RRkpuZteN1glsvRLTWwHYe5
   4=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.00,250,1681164000"; 
   d="scan'208";a="113334696"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Jun 2023 10:02:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 45DE8E03AD; Sat, 17 Jun 2023 10:02:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 53424E0157
	for <cocci@sympa.inria.fr>; Sat, 17 Jun 2023 10:02:17 +0200 (CEST)
IronPort-SDR: 648d6887_StCBsn8fmP7+gO00W0YOFQJvR9scaeNm62tlfIQNDGMZkga
 yx7eDrYFuFLg3725X/eUUN4TAe1DBaCIqfUqo3w==
X-IPAS-Result: =?us-ascii?q?A0ELCABxZ41khw4P49RaHgEBCxIMQIFEC4IvdQNTMAQLR?=
 =?us-ascii?q?4RSjy2BdjGENo53iGyDFj4PAQMBDTkIAQIEAQEDAwGBTD+CdAKFfgIdBwEEM?=
 =?us-ascii?q?wYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEjFwcOECeFa?=
 =?us-ascii?q?A2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAg06PwECAgEjHQEBEScECwsaAiYCAlcGAQwIAQGCegGCJwEDDiMHD?=
 =?us-ascii?q?bBWgTKBAYIIAQEGnA4fLCJVgV8DBoEVLQGNLoQxJw+BVUSBPIMEPoJiBYU4g?=
 =?us-ascii?q?meOMIVnCos+gShvgR6BIn8CCQIRZ4EICGCBcEACDVULC2OBHIJUAgIRKRMUB?=
 =?us-ascii?q?U15HQMHA4EFEC8HBDIeCQYJGBgXJQZRBy0kCRMVQQSDWAqBDT8VDhGCWi02P?=
 =?us-ascii?q?xtTgX0lBA4DGSsdQAIBC3A9NQkLHwYmAR4CKIFXMFhwCkigIAOEPxAgAqVWo?=
 =?us-ascii?q?Fk1B4IwgVuBXQyKE5UJBhMvg26TJw4Gki6YGCCNOppdgXkkgVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIBmDWzOBC449PzQ7AgcLAQEDCYVGAQGGAAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 T3TFrMc8/RxLlxUqT4v28GG
IronPort-HdrOrdr: A9a23:q0k/DK1CYXLitnw9wJalqgqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:hByHzG/hYWiox8rCWG2Vv14oPMs+b1LE9krvImbkFEdSFIa7UGbFrQ==
X-Talos-MUID: 9a23:rgsNxQSu22Vepof1RXTRrghNOYBOpJ/+K35SnKwX4vC7NghZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,250,1681164000"; 
   d="scan'208";a="113334684"
X-MGA-submission: =?us-ascii?q?MDEVNsnZ1JnnT+CyEdBsOe2MRDW1zM5yYx8hao?=
 =?us-ascii?q?Ybw82T3Wk+z+VF1shbvBQLQu02sg59f0yZdtTJjWNe6E/PSxPh8yxrJA?=
 =?us-ascii?q?OxktH8Rqmj4jUX2ML9zCdgXAzDLoV3RmxgDXS2forKXv6H6Ds2UV4mrB?=
 =?us-ascii?q?efN8IRsHgSWGdI5zRjVVtDTg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2023 10:02:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686988936; x=1687593736; i=markus.elfring@web.de;
 bh=khCI9JZpQnK/tB1MOssAvUjAUvsBk7hRAVJeb7mbNFU=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=DVxMX/CAY8mnEGF1MkjtqsXT2h4LQKMt5V8lgq2FdoI6Mqk1eH+YMSiiksnIdkOhhAechSp
 84NhuhEYKH9UPoRwRdvb60PbcNRN18RS5xq6k/pGpZ/RXJ0CkRAflLsTMz0mM4t5D6N+vrxvH
 VBm4lS60NWKYFbydMrslT7Hx8N4AFc8uAedU7S06NclMzcVqDGFADGYRjG0qPbwGzo7m/Vc/s
 aoCGLbr3uwXUOScqflNVpkfnwcwvochy2nBLt6KM+8yD756seK+MtEKoW3ZY0wAgxVHYos2H0
 7dZTny/VtRLmlX/bHtmvHoh5WGeosBks+6darklwRgH7+ng0ARUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Myf3x-1ptk171KVJ-00yih7; Sat, 17
 Jun 2023 10:02:16 +0200
Message-ID: <e8f9b6cf-25bf-90f4-2d59-4a0620bb747e@web.de>
Date: Sat, 17 Jun 2023 10:02:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Johannes Berg <johannes@sipsolutions.net>, cocci@inria.fr
References: <a02bbe916c864ebaf407426dda76af34d1bdda6f.camel@sipsolutions.net>
 <d4f38fa8-e590-e62b-c311-ab7f6a868070@inria.fr>
 <80a12cb225f9e709e35e4fcf3473c39156a7b2d8.camel@sipsolutions.net>
 <6b3be36a-6b1d-3e5f-ade7-443dcd6f0de@inria.fr>
 <905b6d0ca2b0c9947b3e7855a7d5be1827da731b.camel@sipsolutions.net>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <905b6d0ca2b0c9947b3e7855a7d5be1827da731b.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Cai6WRdjMlDiJAxfeZrj84w670V8muhhNcUzC2CqUA2LF+cajZp
 pkNuBLkciblR9jljQT1Av0RgU9XDQx+1Jq+BGDxXkVGxKUgiroFSC3GYNpAyWsYwvTCMNzJ
 ssnYuQ212W3e517MFg1egUASqtlubqoeF6FYmY2IhmZgxIN1hq5ljcUK0YviV4gl2s3Uxud
 LwCbV59eTMkktlfVwkyvA==
UI-OutboundReport: notjunk:1;M01:P0:Cq0zf0IHpsA=;rm3qO6CUM7umFAk/kgfY+mtaVFM
 mjH+akRAuCvlKueSQjCGcNss6QJaKllrOCr0lwwNv5h+ELNNxou7+HQc9SBXLd1VSJrZCXXUb
 BRYI4AGLY8iOAwYP+pvejuKvSdmqVDWV/bAIP4BtszCTye0fYgio5rSehAcTTqghSRaojC3Nm
 nMcnl3UeyIwYMGA3k1k+kmBEvjiArYCnpd1OvGjlgSUehaCK3WpaYZq9pj8krmGpmK0tNqPgy
 RXUHOI4QoSRcjhNnQ3AdTX+Q3Fo3+U0X/agq4l9UMeKfJjzIwEtHWEDKR38sE5fMNFmqjQjpv
 JCI5RZZaF87US2utGjgUmOp5B2PNowrNTSNRuW2L4V7wfLCTDZapB2laxWrk1MlZdhp61Q7a9
 MLIQIVcm3updfCGH0EiGyFnuqT2yltEgJEQcCWAORGpnhr+TxdxVPqnuKY9mZQkakAV2MrcDB
 gVluMbeWFBTz4SxthR6xo8zSjW3ldM8jIEOwgMTf9NsmyCVZ0P9MB4WuiFZNaC8nyxVgppCrm
 cYBaVNP5mKnDvolCniHUmHoY8I73hHyKzMu07gHR2qIgyOJw32UNTRxZnV2pJmiUIKWpy7nHY
 xFlqlrqMXHINfiOPgfZqtj9vPspfy8bwEl+ZdpeXFKPpoMyIyFoxR1oWDwz7jiOa/rB17sDDi
 zz45nCsxgGktmVgeId7wVTGcJjLaREgJEC1lKcC8Ap0cOh4OXV2dtnTVAXcCjs23SLViY9CUS
 nzndDIXPGlFwk5euwTHW1Ac6ShzPOz6CFiPjkBBg/WZh9hqtkFxikQ3xlBDuvqEd2cHWYkb1Z
 KxFzgPTcA89bSGfypHow+iVpxlFArmTwpreNmBcX37WkLYUYOlszMNCAPU9Z69VdAmRfxj/BA
 S0Y7G7VbBBHIWuJNslLz0oCkNnnCipJdEgNLsu0gv4p36YhoWD+F3hwreaP/ysFAzJtmmwWYk
 xkwceQ==
Subject: Re: [cocci] macro parsing issue?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1188
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/e8f9b6cf-25bf-90f4-2d59-4a0620bb747e%40web.de>

> I think what threw me off was the "found sync end of #define".

I imagine that better explanations will become more helpful also for
such special data output.

Another example:
--parse-c output
2021-06-06
https://gitlab.inria.fr/coccinelle/coccinelle/-/issues/26


The Coccinelle software tends to operate on control flow graphs.
How good does preprocessor code fit into applied abstraction levels?
https://en.cppreference.com/w/c/language/translation_phases

Regards,
Markus
