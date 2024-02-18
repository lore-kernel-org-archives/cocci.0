Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC3EC48BC4
	for <cocci@archiver.kernel.org>; Sun, 18 Feb 2024 19:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9AwQ1G0l9rJJD21zJD5xFGAvnVr3ICGe3uTjQwKF0GQ=;
  b=h0eBusiWz67q4hoeytlhpPm3P574xpZuOFpYSQJKy/uGUC0g8PyHy6hr
   qM20b63885sSnXQyBXWtYXkktOT2H5x5OQwf0wLJQaerPlcNB+i2BDL4X
   ol3aD11dGSUcMdTSeoJq6CDBiSGJvJqbZ7S13sUDtJ4Pnkdb7cOpPm2Lg
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,169,1705359600"; 
   d="scan'208";a="152519637"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Feb 2024 20:33:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D2F65E00B7; Sun, 18 Feb 2024 20:33:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 657E7E008A
	for <cocci@sympa.inria.fr>; Sun, 18 Feb 2024 20:33:30 +0100 (CET)
IronPort-SDR: 65d25b89_bpRNyr7S+yvPqVUoeWyWoQ29i3L7tQjz83fNuMFbwZq89wg
 +To2AWpyowDEKXl0SQvWiJO8FYGFXwabiDj+Xcg==
X-IPAS-Result: =?us-ascii?q?A0EoAABKWtJlhw4P49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YI4YhoDUzIEC0iEU4gdiUyEO48FiHCBVhSBLD4PAQMBDTsGAQIEAQEDAwGEO?=
 =?us-ascii?q?UYCh2QCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBIxcHDhAnhWwNglwBEIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQINOkEBAgIBIx0BAREnBAsLGgIRFQICVgYBFAEBg?=
 =?us-ascii?q?nwBgioBAw4jBw2zZIEygQGCCgEBBoJnrHQfLCJWgWEDBoEaLgGIJQGFb4Q8J?=
 =?us-ascii?q?w+BVUSBPAuCRzE+gmECgRmBBoMcgmiFU5MEhwdUgQIdA4EFBFoNGxAeNxEQE?=
 =?us-ascii?q?w0DCG4dAjE6AwUDBDIKEgwLHwVUA0MGSQsDAhoFAwMEgTAFDRoCEBoGDCYDA?=
 =?us-ascii?q?xJJAhAUAzgDAwYDCjEwVUEMUANkHzIJPAsEDBoCGxsNJCMCLEADERACFgMdF?=
 =?us-ascii?q?gQyEQkLJgMqBjYCEgwGBgZdIwcPCQQlAwgEAyspAyF0EQMECgMTBwsHeIIJg?=
 =?us-ascii?q?T0EE0QDEIE0hTiEbwyBUgMZKx1AAgELbT01CQsbBiIBHQKfFAGDeRCmTqEZN?=
 =?us-ascii?q?AeCNIFggWEMihuVHQYQAy+DcpM+DgaSX5hYII1PmwiBZDqBXDMaJIM2TwMZD?=
 =?us-ascii?q?44gGYNhM4ELjjxCNQswAgcLAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 bILTaJHEkM4HLUWBxY9dDTnCIh6VHUonOzD5PM=
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:nWRnaK0DsBaXTfrWafLlngqjBBEkLtp133Aq2lEZdDV8acaYl9
 +jkbAyyHbP+XQssREb8uxoWZPwM080kKQbkO8s1NiZLXLbUQGTXeJfBLXZskvd8kHFh5RgPU
 kJSdk8NDXfZWIKwfoSyjPIXurJWLK8geCVbd639QYtcemBA5sQoDuRczzrXHGeJzM2fabQyP
 enl7V6TlibCAUqhxSAdwo4trP41pS73K4OCCRub3RKhmj+70LMmdmKaiRwuC1uLw+n7o1Sul
 Qt+DaJk5lL3cvLtyM0m1Wjkai/prHau69+7aG36vT8el3X+3aVjI8KYcz0gNnrmozfjGoCoZ
 3KpVMpJM5z62zcF1vF6yfQ5w==
X-Talos-CUID: 9a23:tDJAGm30CastiKT3nXxymrxfNeYOLnrzyF3qGnDmFzhIRaWrVWDLwfYx
X-Talos-MUID: 9a23:/oi+WwRjBbiyuHPARXTRiGhSCMBQ2p2FFWY2z6UqlvGcPxdZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,169,1705359600"; 
   d="scan'208";a="79956584"
X-MGA-submission: =?us-ascii?q?MDGvB+uZwD3xWluFwFBH+Pa8dWCxwcKM9j19Vb?=
 =?us-ascii?q?z0ltnABf9eiWhCXOp+mT7ofgC3P10eU8R/4zKCMMvvdfmB1aAul9pogR?=
 =?us-ascii?q?CR6XSO6mASMQ4YemXhbyiK33TooCoGlmeCWQn7POWY7C9FBPiC6v9jbC?=
 =?us-ascii?q?L/HQ6PGIumucKEaGV94aJBmg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 20:33:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708284808; x=1708889608; i=markus.elfring@web.de;
	bh=9AwQ1G0l9rJJD21zJD5xFGAvnVr3ICGe3uTjQwKF0GQ=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=mWlMvFAt+iHX9PmpA0yLDZwPWSeX1mAuJZcmKUYAZhyssE7ayhEhJGWSY1u+JB16
	 CNDUUpYK4K7rmzv/tkeEwVRMdtBD68kaSdoY7Y5p5paftcebPvRfvW8cJdsBupy3+
	 NdAPuw2QcnwLeK6yfLH6Uwe0qMBllZdv0QnvH4rhLdzYqciBkSemN5HufgnCmfs/V
	 pXUxkfuBeu3wMsMl/PYKNJybm4+30TLboZ/gtU4D48k9uPaY2nxkZkgt5BMPDrjTA
	 1Xq4jseQ5wrdozA/3ogvhUW3+4uwmweDXZLNkPat3deiWkZt8a0KOTMYcqGv6EE4t
	 HNwDva3PYDITb0wHpQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MidDH-1qz8W72Axr-00ffYg; Sun, 18
 Feb 2024 20:33:28 +0100
Message-ID: <69055964-fc08-430d-a620-70e02d20de16@web.de>
Date: Sun, 18 Feb 2024 20:33:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
 <6d5d2b50-2878-4d39-b1f3-ae894f880dc4@web.de>
 <alpine.DEB.2.22.394.2402171623280.3095@hadrien>
 <7a9ea69a-2699-4fb3-9863-2eddadb5670b@web.de>
In-Reply-To: <7a9ea69a-2699-4fb3-9863-2eddadb5670b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZIpVwGrXS38opUeszDVZNPotB1awOf0TA4DfQjawNB/xLKs0KEP
 nl/DZdPoByJpUKTqMWg6TnX7j3ihcZoeu4ohbQV0iBQFxIwRW5aje+U910/f0/mTtXtqD8W
 FhFKps0tNEh2cVNbO3atHH4UwSowj0lLbdudTIwG79FqHamlsfhxlhKivK6/XD+gEC9rMHt
 iWJfyj6zlV+bedVG9AV/w==
UI-OutboundReport: notjunk:1;M01:P0:sPRuQ/gOZ5I=;w0CTD8AEdQTnLStW6NwoW3G2u2J
 1dFYR67hIb7gyvIsV3nNRx4eKdU40/okPfuhK3m/F3CUb6WNhbu6ztJp3h5SuqOHXIf/Gp7Cm
 kNrz35WbSz+V1o3SOLpcfE/hdRCDGnJy4ap1UmVyg7A8AuJ+aY5Bat+SM3WpkaZkka664NX6q
 Zsjwfm8w4lDAUtBdgNd7I+/PC5u5FBFqmuZUJO/HRpzSsfk+6iw8WtgceWBX241vbGy1m4fvS
 U58DIOiM5yp6kCnJgP8XaIafIIWsXV7MKNcvz1Y0fA7Mgb32Ji/y+qKCwOrjtLk3G1u9D6w5P
 ALw4K8nN/mWcv5NcoiLd8gR6eHfjDB8imwUWFB7k8MN5av8n8t9JEgoO89Ri1Ax5tgN3WRtQG
 ZTfqCvGflBEcmSXxvaKsYaSe1Upu3T4CVPOpXisvtRQ6bfHa/krdzOAqk1fD69V3kU/PbigUO
 8m6BpEIEWyiNmNyjb38nFJpXCrk0cjNhwoXMHxGuy+J4Q9N+0A5+jyU7FT8K1BAhc7PvgTWUL
 g5Ftnx51RnxhH03zrbn6WD6hR0se4g4yMJXNtQwavsM5LtaeJ6Ec6jgIl13GKZIb2auPdrzZH
 qEReVLshbody6Lq3f5rdRnA1BWHSjYUZ80SrCLZfLdaqblvPF7lZVwpSJsOfWaNDbkDQ+NU39
 bdhE0Lt6YbpFYZbq1gnLYfFlVGV+25Ociuf5AkBZkR3Ks0Wm7kV/NAogN5k/Yqv+hJ36isVEm
 2/72wxEECavJ2An/oPf9+7x85V/XMNX+ly06yY1TEFRaIDzDVCKdxIOO+U8TCDrtKuDu0Ezya
 NoNvT/sHHIB3nsw1EXMjHbbdUUrdQmEwap1TOZ45GE6NQ=
Subject: Re: [cocci] Fixing the SmPL search for a bit of duplicate code
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1581
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/69055964-fc08-430d-a620-70e02d20de16%40web.de>

> Will any collateral evolution become more appealing accordingly?

How good does the next contribution fit into the discussed development story?

account for the fact that binops and assignops are now stripped
2023-02-18
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/b916699c924986392e876d30f0b838602fdd9ec1
https://github.com/coccinelle/coccinelle/commit/b916699c924986392e876d30f0b838602fdd9ec1


Which adjustments will become more interesting?

Regards,
Markus
