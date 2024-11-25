Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB83D58D69
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rwcINGyXKw732e0v52Ty2QvLTe/0M9+pnRfPFXNwvSk=;
  b=U3ytovEY86Q1TXtxGGDzz44YG5DX8pO0rM0ll9JI80gOreBsDleikPq7
   QZygWmk0TFKhVO/lLlg5whPaMfr4OTsadxsAZ2CicDET2JXIiuJPQnvlx
   2tH0kHIFvexhu6qgTxwjfdqWFZRbaTEV+rFdulnC1EMNaGGCTlzVox5rC
   E=;
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
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195726173"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 18:04:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B7CDDE0133; Mon, 25 Nov 2024 18:04:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C1AA6E00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 18:04:11 +0100 (CET)
IronPort-SDR: 6744ae0b_KwsGfEmliTPITYzdUzoVsSyAO2YKHU4mlI9yYkdA9sQ0F2/
 FXrZ178ooNW/ScJaGaEugeBq2EFjx7kbjeHO+kg==
X-IPAS-Result: =?us-ascii?q?A0H2BQBNrURneAMP49RaHgEBCxIMQIQXYiFUMwQLSIRWk?=
 =?us-ascii?q?UGEa4c7h1aIdYNUDwEDAQ1BAQIEAQEDBIUAAopbAh4HAQRHAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABQw4KMYV7DYJiAYEkgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEdAkdEAgEDIx0BAREnDwsaAiYCAlYGARQBAYJ9gjABAzEHsCaBMhNug?=
 =?us-ascii?q?gwBAQbaWx8sIleBZAmBGoYYgmIBhiSEPCcPgVVEgTyCUjE+hEODW4JpgkSFD?=
 =?us-ascii?q?yWIGGibOFJ7HANZMgFVExcLBwWBKSEsA4F5Tn+BNoFRAUKCTkqDLhyBQgU3R?=
 =?us-ascii?q?4JKaU03Ag0CNoIkJFmCTYElBAWDa4ELg16EXoYLHUACAQttPTcJCxsGPaFcz?=
 =?us-ascii?q?Uw0B4I4gWWBYwyfWQYTL4NxAZNRDgaSeh6YXSKpBoIhgVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?YQtxxlCNTsCBwsBAQMJhUYBAYtygUsBAQ?=
IronPort-PHdr: A9a23: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
 J7DmfCrQN+n283Z940QCpqMQP8=
IronPort-Data: A9a23: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
 QAIeIyPfK13pYMd3yqtl7651Sz1ZA/S8gg=
IronPort-HdrOrdr: A9a23:HxsDW6El1U74hijxpLqENseALOsnbusQ8zAXPjNKOHlom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4xgPM
 xbE5SWZueAbmRSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: =?us-ascii?q?9a23=3Au6lESmvH6cLJ1D30KLCajs/A6IsEdFv5102TEnO?=
 =?us-ascii?q?1DH5lcIHMGFTPo697xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AmwcL5Q2/2RHOFNsWHLXFk2ab8TUj6JyONhkPg7M?=
 =?us-ascii?q?6utjDNAFZMRTAjR6We9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195726166"
X-MGA-submission: =?us-ascii?q?MDF/UXW5OwcASCmCTTLCuNp4baDK05TVFpDwts?=
 =?us-ascii?q?VATeLwHvrWCyjWow4DuwkoSI0jfPZkqKMdMRKTFXTQ5819fTAyoUjGtD?=
 =?us-ascii?q?62pmqgBS0QgkY87pxdIkCLpoNca8dGRd1AlEkh6aLGlyNxmh9b4XO8dV?=
 =?us-ascii?q?QtXxumHyRl7c0KMcurXCQ+tQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 18:04:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732554251; x=1733159051; i=markus.elfring@web.de;
	bh=rwcINGyXKw732e0v52Ty2QvLTe/0M9+pnRfPFXNwvSk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kHB/ClrGGaboc8NFLbQAblqU2WG8E+jGRb15AXAGxZ++FdfNJaOa+BWsylC8HGgf
	 Zth00/wEStjWnO7CsVgHP94ARbz49cWDpy7l/VlqHS9h7QGZapw69cAruGTbKtYuI
	 SjRuay79PQ04plhUbsy6ARzm9/0W57BwVcLG/HAXJZE4jbdP5LG4QzM3ZH3UiPm/s
	 0WoBVp+MlS1C+nutoF7aK6tj+Wx+7U0isLtkTy8s+QdNImttdMV+ckLLkpISMVqPU
	 MxVnjHsh9WFblbNk/2aisWuRGTfFsLUstzDflBLQ46OWKtGk9pJCDwHG56Zc5rVNZ
	 eRXzorTjXzl8oPQ22Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8TBM-1tK2ME3qQC-004K9w; Mon, 25
 Nov 2024 18:04:10 +0100
Message-ID: <ee6bacc9-eece-40b5-b86a-fa022532af9e@web.de>
Date: Mon, 25 Nov 2024 18:04:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <434d257c-f0a5-483d-9fcb-3303301ad867@web.de>
 <9e8d6626-f8a2-19a7-33d3-b0cc48d2fa68@inria.fr>
 <100663c2-6281-49cb-bb9f-55656dff80ca@web.de>
 <d05cde6b-6189-4c2-a452-a0851430dcb@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d05cde6b-6189-4c2-a452-a0851430dcb@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qSf8uRzgnfEViMIMC6PRD6+q6hcy0faDRVN3Sd8RRGevBP30SRb
 2KcSJ6f3j6SClPBbjL5LCCZgsstq5M4ig4HgRXkEDn5YGqeNTAjnB7CR3bMsxfgTQj/gk4l
 v44cw24Q6dTXUv5gVfy6QguBfpqUE9qHuHwW03416LUXEA1qs9BRhpW1OGPxUCOjNiLZllQ
 2JkqZUgc9RD3ns4sa7Ykg==
UI-OutboundReport: notjunk:1;M01:P0:MuRJ1ZYryjc=;3JnQyPm8cUmFzyY8y4khUBlk1sw
 ZMW2BJZ0V4LzzR2E/O/9rmAPUaPwFAf0OZ200hMyPpiP7hCYu3fRLYlZ/NXapNkF5DWAcNmlv
 5ERSDKoAfvvwa6sWbKj8OMhxgC+Pv7va9R3ycICdmxUQM7VAy+vXtkzj/eC2ONRamrrDkjv9o
 6Sj2sMS2uS2N5KRx+2cfq8mlkCIylh6cJX/Zd74hp9aoa1bXyypCt7drgcyI7ixwqwwpMAmA4
 scdSM641H1xRRokqCCnhXhESLqzNewopXWv+mxLTJDNgKShySmd91t7PaQO1KmxYL/x2HCh5V
 FmcM3uxCtR9EXnQkt40XS7TDMOvPhfjTLhlFcINI4OlPvWV243fhC7Xbgba0fHLfA9IPnNa5z
 B76zRONmRcxAMqdFEOsxHAfoYATreB+BT6e99C6UdVj5JwTM2fpdk/DIhIzBjCqslKTxGtjLG
 GnhvIQ8P0qKmai7x68vJZrRfEhGOkCGG52l2KBLCr31kgcZ0nx1V/PSJbO1uAVAxOK3j2ij1Q
 X8necsEV/PkkMYasbHzc/fNZBhz2ChMfdHnOTCwidX3TpyGWekqB5lQd/K17NHF4Bw9h6sTZ0
 7R5naMH4O9lRd1MevLb4jG0o8fI+d/Meg9fx1co7NL+iZp4Vx9zqGPQlpeB9k+AadiGS/rPR4
 FA540TZxPfxjpwaiURTeD07ZxZWyjJn7qXO/hqONapl95xFAz4gOvxkAkUshX9nz4kS3qYcEw
 HYEheUTH7gCD6CjesG2I3/cRFTwIuma2ZlSYM3lpxmnli7asrGffSmHQrtz7XZXUcBRp32kjB
 H4Cpr95B8mVsQKU0XVv0Yyh6uhW5In6vyEaFsEUloKzxDrjZWbw3HIumFcsRme8ZBKugfdeku
 UqUvNKq3lLasZBT9/lBIE2j7i1Hjrf5+bpz7YPgDcnOxxNwobZ7IQFqacZQ47m/YZ7myrdtCi
 PlK+4ushOB6ljcONfLnZy5aRyCfYwlQ0Q8tJDi53zIsppRQHPAxBH2WUgLT5UNPUlRsfwEFVg
 t5DRO0ah8/0ZXwxXrJjrq9nIZtCQIbW6d9kzyXWMM04iJdKaYaY0+cEY0sDsBDsobKMBBWSt5
 pXfplP4Hc=
Subject: Re: [cocci] Data processing challenges for pointer expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2122
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/ee6bacc9-eece-40b5-b86a-fa022532af9e%40web.de>

>> * I would occasionally like to restrict the source code search to point=
er expressions.
>
> expression *e;
There are further data processing challenges to consider with the determin=
ation
of involved pointer types, aren't there?

Regards,
Markus
