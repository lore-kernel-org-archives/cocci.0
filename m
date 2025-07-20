Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E02C83F1A
	for <cocci@archiver.kernel.org>; Sun, 20 Jul 2025 18:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uCwKAqrLqEFy2riVXDK/NvbdIxhXcGkH/CmM/N42YyM=;
  b=fKUotQ9BcS23zwkAwRpJYnCMubwdWwcoKCjPN+E7VlqpW5cIY9mTsQVv
   zyJmab7ixrgRHrgJ5uHoQ49PXfFqeaf6SJyr03+TN6tePj8lBMCpYOnb9
   xfBN57AG5RotQuUKBIvnLWxCGvz+7C2XL+9EqtzexU3C9vLYPsYtPMFIH
   4=;
X-CSE-ConnectionGUID: B4PnqWvZTkW1GHBlcPW/eg==
X-CSE-MsgGUID: dOkYF/XLR+6X+ktGAhjJ/A==
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
X-IronPort-AV: E=Sophos;i="6.16,327,1744063200"; 
   d="scan'208";a="232364803"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jul 2025 20:08:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8E992E0CD5; Sun, 20 Jul 2025 20:08:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5D651E0171
	for <cocci@sympa.inria.fr>; Sun, 20 Jul 2025 20:08:30 +0200 (CEST)
X-CSE-ConnectionGUID: sZGwq7R2Qbu5ST8xtVcC6A==
X-CSE-MsgGUID: nILQqYtrQcG7LhZh3+3dqA==
IronPort-SDR: 687d309d_SwRlYmLkE8F1A6gRS69lx7LcvCOPH1PtznwKX8NJbplH9bw
 c9wyvyLtv2/npqiwRosfQ8Z8gaGEZ6hgQqvRLTg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E/AQA/L31ogAMP49RaHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?QGCQoEGVDMEC0mEVY9QgiSEO4c8h1SIeIFVFIFpAg8BAwENTgECBAEBAwSEd?=
 =?us-ascii?q?gEJAowTAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBOwcOCjGFew1JARABggcBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECA?=
 =?us-ascii?q?SMdAQERJwQLCxoCERUCAlYGARQBAYJ+giIBBhABAw4kB69JgTKBAYIMAQEG2?=
 =?us-ascii?q?l4fLCJZgWQJgRsuAYVsgmQBhieEPCcPgVVEgTyDAz6DfIEGgxyCaYImgRZ3R?=
 =?us-ascii?q?FWBVJUGUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMKgQ6EJytPgiIBd?=
 =?us-ascii?q?YF5QRk/g1UeBm0PBoEYGkoCAgIFAkNFd0ACAQttPTcJCxsGPZJirBWhQzQHg?=
 =?us-ascii?q?jiBZ4FkDJ9rBhMvg3EBk18OBpMEmQYiqR2BbwYtgVwzGiSDNk8DGQ+OIYQzw?=
 =?us-ascii?q?VtBNTwCBwsBAQMJhUYBAYZxhiKBSwEB?=
IronPort-PHdr: A9a23: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
 hwV3fXnII5VOoCpgyRf
IronPort-Data: A9a23:VX6eoK+6KnpVSOQVjQcPDrUDXHqTJUtcMsCJ2f8bNWPcYEJGY0x3m
 GpOCjuOM6yIM2uhfIt0at/g80lV65/SnYBkHANtqS9EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjPzOG/ylTraZZ0idfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNtcpvlDs15K6v4GxC5gRkDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9FIs+liLvybnoRSbfUOwWU4lIOM0R1qkUqSoQai87XBdJEAatlo23hc+NZl
 L2hgaeNpTIBZcUgrgiyvy5wSEmSNYUekFPOzOPWXca7lyUqeFO0qxli4d1f0ST1NY+bDEkXn
 cH0JgzhYTiYtc2p2e2BENBmm5kYEJn7IL0UkS9JmGSx4fYOGfgvQo3P4sJEmig9jIZCEJ4yZ
 eJDMGApNk6fJUQSfAx/5JEWxI9EglHaeidbtUnTiK45+WnVwyRu3bKrPNe9ltmiHJ8MwRfD/
 j6Zl4j/Khc7EOWG+Cafy3mD2cvPryOgG9keDZTto5aGh3XImjxLU01JPbehmtGyjUW1WvpEO
 kkM82wvq7Iz/QqlVLHVWxSnqXqAlgwdXtBKGqs77huMw+za+W6k6nMsSzlcdJo5ucVwSTFCO
 kK1c83BHg5Ar6TKcyik/KrJlg/iKTQrJkRcTHpRJeca2OXLrIY2hxPJa99sFq+pk9H4cQ0cJ
 RjV9EDSYJ1M1KY2O7WHwLzRv967jrTkJjPZCy3SWX+5qBx0bsipauRECGQ3D94Rd+51rXHY4
 hDofvRyCshQVflhcwTTGo0w8EmBvartDdElqQcH82Md3zqs4WW/Wotb/StzIkxkWu5dJmKzM
 ROC6FgLtMADVJdPUUORS93vYyjN5fewfekJqtiIPoUQCnSMXFTWpXA1OyZ8IUi3yxBzwcnTx
 qt3ge73USZCUvQ4pNZHb+Ya17gwjjszrV4/trirpylLJYG2PSbPIZ9caAXmRrlgsMus/l+Jm
 /4BbZXi40sECoXWPHKImbP/2HhQfRDX87is+5QPLoZu42NORAkcNhMm6ex8ItQ0xfgJyY8lP
 BiVAydl9bY2vlWfQS3iV5ypQOqHsU9X/Cxlbx8/d02lwWYiaouJ5aISPcl/N7o++eApibY+Q
 /AZco/SSr5CWxbWyQQ7NJPdlY1FcAj0pASsOyH+XiMzUaQ9TCP0+/jlXDDVyg8wMgSNu/ATm
 YaQjjHgfcJbRiBJLtrnV/a0/lbg4VkfgL1TWmXLEPlyeWLt0tNYFA3svNAKIuUnCxbK9h2F3
 Sm4XDYaoujspdcu0d/r3KqrkaagI9FcLGF7QVbJyKmQDjbL2Fajzatrcve6TRqEWEzaoKydN
 PholdfiO/g5rXN2motbEYcz65kh5tHq9oRo/i49EFrlN12UW65deF+Y1sxyt4pI9L9TmS2yf
 mmtotB6G7G4CPnJIW4rBjgOT7q8jKkPuzzo8/4KDl3w53Z38Jq5QExiBUSwpxIHHoRlErEO4
 LkHg9EX2TydmxBxE9ehjwJozUquAEEEcZ0assA9PNe2pCstkkpPcL7NOB/QuZuvUehBAmMuA
 z2ThZfBuYhi+1r/QyIzO0Tgjet5rrYSiS9O124HdgiomMKap/oZ3y9x0DUQTyZJxE55i8Z1N
 mxaNhB2F56v5BZtvtBIBEq3KjFCBTqY203/8EQIn2vnVHuVVnTBAWk+GOSV9mUL2jh4Uh1E2
 oqH2UDZUTrOV+Pg7BsYAEJKhaTqco1sy1fkhsuiIfWgI7A7RjjU2omVemsCrkrcM/Mb3UHoi
 7Fjw7dtVPfdKyUVnqwcDrua35Q2TDSvBjRLYdNlzZMzMVDsQhOA8hnQFBnpYeJIHeLAzmGgA
 c83Js5vaQW35BzTkh8lX5wzM51Gt993wuEde4HbB38M6JqeiTtLjKj+1AbDgE0TftE/tvpld
 63wcWqZH32ylElkvTbHjPN5N1qSZfgGYwzB396JztgZKqJbjsZSdRAd77jlmVSULwptwDyMt
 izheaL97rJv2KZsraTWA4RBAAS4c+3ycOGy9CGyrNV8QtfdOujetw4uiwfGPiYHGZAzSthIh
 bC2n9qv53z8vZEySHL8t6SaMqt0ufWJQ+tcN/zoIElgnSetXNHm5z0B8TuaLaNlvcx85M79Y
 SeFc+q1KMAoXulCyE1vayRxFwgXD4L1ZPzCoQK/t/G9NQgP4zfYLd+I9W7bUk8DT3UmY6bBM
 w7Tv+qiwvt6r44WXR8NOKxAMq9CeVTmXfMrSs31uTymFVKXu1KluIb5tB8e+DrOW2ilEsH73
 Mr/fSLAVi+O4YPG8NIIlLZJnEwnPC4oy614NEcQ4MV/hD2GHXYLZ7ZVe4kPDpZP1Df+ztfkb
 TXKd3EvEjj5QS8CSxjn/dD/RU2KM4Ti4DsiyuABpCt4qhtaBb9sxJNk8Tp8pWh7cH3vwYlL7
 D3YFmLYZnCMLlNBHI7/JcBXRc94y/mcyn9gFYXVjZnpGxhHaVkV/CUJIeeOPBAr1+nSmU+NK
 WVdqaWohq2kYRaZLPuMsEK51P3UUP0DAtnogeqyLA7jhrim
IronPort-HdrOrdr: A9a23:HwUe/qN5c0d3wMBcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3A9rgqzmmnF/2oaQZtVEF402F7K3nXOWbv42jJfHX?=
 =?us-ascii?q?iMGx0FYapGU+MxqhPzeM7zg=3D=3D?=
X-Talos-MUID: 9a23:avvtRwn0fo3+sMu5Fq1CdnpkFeNR+pWyEnkGvsoiu/uEbm8rNy602WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,327,1744063200"; 
   d="scan'208";a="121793047"
X-MGA-submission: =?us-ascii?q?MDEZXQT2QZ6G2Jelgq2SGd3Vm2uOqd2E1cmkeq?=
 =?us-ascii?q?5hlJErgVgzdmxYvrdmysh9MgGxBSCfIPSpO6EAlvfhLPsML77zLW8x0u?=
 =?us-ascii?q?7nmVmZERubljFO7gyRFY7cYyfWGa6Fft+TJkVJKVVPNWxaPfXYtDzK56?=
 =?us-ascii?q?S+uUznbMPRrNka5BjVS404SA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 20:08:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753034908; x=1753639708; i=markus.elfring@web.de;
	bh=uCwKAqrLqEFy2riVXDK/NvbdIxhXcGkH/CmM/N42YyM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iJOHB9H5agGNKZ2En0ddVrkvI1bN8UvGUncdrKw/4K5Z5Di/GicmRCeGxDPkzWew
	 X49hP52SSEGzqYXD09GqwL+7tjozqjn1uLEbWUZ78eBtxLC7P/NPJj6cX+OO/dz47
	 HrhCXWPT75OQZIObk7BxYUSI8EqSfkPjrLEetv96/IjCby7hs/0CVUbr2UECYFFK0
	 Abh0J91TyE4t3Oa6xR/QDaAKMI5y1+sBNtwGCCUga0yBj3tHtfHukd3jl/AVAKCz/
	 MMBciuRBurMkCI1H8jVydPdr/a4brQbX+XxmG8OXO3EuK7SMumm8zfBwh+eW/3e85
	 23D4gABkeCzvDXWAKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.216]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JB0-1ubupa1PB4-00DL2f; Sun, 20
 Jul 2025 20:08:28 +0200
Message-ID: <a17047c1-14d5-427c-89c7-59a97f296e06@web.de>
Date: Sun, 20 Jul 2025 20:08:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de>
 <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr>
 <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de>
 <alpine.DEB.2.22.394.2507201608390.3477@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2507201608390.3477@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:aOgrNPXPtbAsNkxBVQDCQEE2ijVkCqyNaeGiTrIn24beAjyPYfZ
 yEGVqqMSM292REOr8H+12u99AnIslVZzeMi68Q2FhrzLQmMJWDzvFfuhXuaoCgYUprNZuC0
 JYv/m1volN6plgvjPzGn1GLLl9gOoxLi9tkhuiqRdu04U/IGcKpa8ys2mKDWYdwybmc91hl
 buL3VCaM4vMUsksxxmH0A==
UI-OutboundReport: notjunk:1;M01:P0:tVlUBvB6kBs=;6kUFimgrohF/exZFLsjQRm5+LjM
 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
 sHFRsbBLOzdCVy2SIVQwrdY=
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2880
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/a17047c1-14d5-427c-89c7-59a97f296e06%40web.de>

> It's not clear whether you want to reduch parentheses in the semantic
> patch (the only thing that is affected by an isomorphism) or in the C code.

I imagine that expression properties should be taken better into account
for both application domains.
How may an expression look like so that parentheses can be omitted?

Regards,
Markus
