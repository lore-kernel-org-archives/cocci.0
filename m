Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01560C83F1A
	for <cocci@archiver.kernel.org>; Mon, 21 Jul 2025 08:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=tPF4/pobHwNnMz4ll8GgFUJ8QuRgWr3OMXriUBicy3g=;
  b=Jsnk7jOkJ7N/fgQh/NATnIO5DsllpS8h5XOYvtf/rML60BnJI2VeIPIz
   CtVuzJD0sTUbzlY7k1EkidQv3I9jAwPYRKeNCGNwvdbfnsdB2NVyVKgfE
   0PaApqWNrg1t39TWyCTWulXHv+6RUF6mwHJFmom9MRdquZweUwqoiz4Gc
   8=;
X-CSE-ConnectionGUID: 6zlcfaMKRPasTSNgXT2L/Q==
X-CSE-MsgGUID: So/jbMdFRpuD+qD/d5ca3w==
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
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232422694"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jul 2025 10:45:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5B830E0CD5; Mon, 21 Jul 2025 10:45:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 29783E0171
	for <cocci@sympa.inria.fr>; Mon, 21 Jul 2025 10:45:36 +0200 (CEST)
X-CSE-ConnectionGUID: QTrbCjupT6iWgyWqu/MRnw==
X-CSE-MsgGUID: QnzjHIuFT06aDZ05vELo7g==
IronPort-SDR: 687dfe2f_fI/oDZFkPv9d62ynaY9/FJr7ToWoZLIaorwvCgSxiCNVvV8
 1udzr2NcQuNc9O7FjqQaxR1Cr6gTOln4UzWwfsw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GuCQCz/H1ogAwR49RaHgEBCxIMQIFVAYJBgQZUMwQLS?=
 =?us-ascii?q?YRVj1CCJIQ7hzyHVIh4g1ICDwEDAQ0UATkBAgQBAQMEggyCdAKMEwIeBwEEN?=
 =?us-ascii?q?QUNAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxh?=
 =?us-ascii?q?XsNSQEQAYIHAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaA?=
 =?us-ascii?q?iYCAlYGARQBAYJ+giIBBhABAw4kB68vgTKBAYIMAQEG2l4fLCJZgWQJgRsvh?=
 =?us-ascii?q?WyCZAGGJ4Q8Jw+BVUSBPIMDPogegmmCJoEWg2SVBlJ4HANZLAFVExcLBwWBI?=
 =?us-ascii?q?EMDKjQxI0sFLR2BJ32DCoEOhCcrT4IiAXWBeUEZP4NVHgZtDwaBGBpKAgICB?=
 =?us-ascii?q?QJDRXdAAgELbT03CQsbBj2SYoIzMINCgQWTGJFToUM0B4I4gWeBZAyfawYTL?=
 =?us-ascii?q?4QEjRKGOw4GkwSZBiKpHYIAIoFcMxokgzZPAxkPjiGEM8B/QTU8AgcLAQEDC?=
 =?us-ascii?q?YVGAQGFFoRmgUsBAQ?=
IronPort-PHdr: A9a23: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
 hFOzb6qdOz716X+3FF+LEZ3lsLGFhiINe0=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:LYnyW6gQtAngxqmidg4xpL9einBQXgQji2hC6mlwRA09TyXqrb
 HKoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: 9a23:2vVDK2GJl0oAw3WJqmJeyFQeMcI4akGDzUjfMnChFCFMcruKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AgdUcJw8ZNfeCousv8lLN1QSQf/5u8aaOKV0jrc1?=
 =?us-ascii?q?YsuW2bXFuFhOa0zviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232422686"
X-MGA-submission: =?us-ascii?q?MDHwHIZ0dbrY4hDA/wd/5ZerkOqbNcYov+4I/i?=
 =?us-ascii?q?nnLE2nxm1S72Qkl3f0PtD4AXppLE7q0ChY6yD/sbAWYfYtQaPMJ9CKOh?=
 =?us-ascii?q?DgtJ2ic8q3a29Xbypo0hsqXxjat0d9xZm3ZFh4t7ZTTM9F5VEzncaUoy?=
 =?us-ascii?q?0hsjHBNna366WN5tM4gh6gCw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 10:45:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753087535; x=1753692335; i=markus.elfring@web.de;
	bh=tPF4/pobHwNnMz4ll8GgFUJ8QuRgWr3OMXriUBicy3g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q7hlacYwhMLpa1j70fzaw45A7D4SZv5/Hm6KfCcXb4ybgcNrX33bFHVajXSLnrOZ
	 7PrCpHYYSSJO212dbkPOYZCoDV43nYpIAK1jz6HJfDAyVktwSJtkJFXeWyYJ8/UuH
	 waagp8RmDpBl6yq5W5Ag56mlhwW9KgAh2rLdU5ZnTjcwAWHjCNEql4qF6Del3pK82
	 0xewKXVZ7c1VuK5n37fXfAWOyLQIubSEmAHRG9QimwINMhmx4+9MiUV5uPaNG7ZSr
	 +lzjQ7tTbh8by9A8/uMdlDPArKovafOKtCcVOk+gvC1jA+gwPCiM6CT8+4yscRQFb
	 XvzYGx9y1Qi4j3E1KA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mhnw2-1v8Q4k3zqS-00mRcF; Mon, 21
 Jul 2025 10:45:35 +0200
Message-ID: <055e34bb-e0ff-4bc2-8f58-97ae6f49d5cd@web.de>
Date: Mon, 21 Jul 2025 10:45:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de>
 <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr>
 <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de>
 <alpine.DEB.2.22.394.2507201608390.3477@hadrien>
 <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
 <alpine.DEB.2.22.394.2507210747070.18950@hadrien>
 <6fa377f7-0612-42aa-afbc-cdeab8bea314@web.de>
 <8a4b47e2-725e-769e-6bb-43e01113f9fa@inria.fr>
 <52ce78f5-8141-46dc-9ad0-5cbfedfd92a1@web.de>
 <cd40be57-cdef-7834-5c8d-eda49eb3a8b@inria.fr>
 <9083cb34-5f8a-43d9-b908-43a9fe2a4281@web.de>
 <4752963-ce2-3e23-fe61-9cbd1acbbdc1@inria.fr>
 <b725f4d0-3c8b-40f8-872f-c79ee0d74c30@web.de>
 <e4b6fe43-bcf-90ce-3cda-69912574ff45@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e4b6fe43-bcf-90ce-3cda-69912574ff45@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PkouHwsxiWey+T2i5dchfFvQqM6ZXbhyLlHkGz+oDEJvBmGSyrp
 J7/G6VL7Z9Yi92+6ekJeI7woG6nLHuWDe98yXPPWKNjwHMYckikokx7uqjjQrSa5yK50ppn
 oLO1d3MYVYerY+rTIgL0/qyHS+fS67qCDY6YFUu0YiLqvfxGX1XOEZzdIhh1iZCkOjVcnh6
 ag3xXx/xOh/c90P2DEjMQ==
UI-OutboundReport: notjunk:1;M01:P0:IbqurOIT5bg=;OOfT1ScTxDD1QcVTOYxKSP1+ej3
 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
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2891
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/055e34bb-e0ff-4bc2-8f58-97ae6f49d5cd%40web.de>

>> Would we occasionally like to put the found expression as a subitem
>> into another SmPL plus slice specification?
> I don't know what we would occasionally like to do.

Some SmPL script developers (and users) would like to recombine expressions,
don't they?


>                                                      I don't know what
> specific plus slice specification you are referring to.

You are familiar with data processing attempts which can be expected there.


>                                                          Precedence with
> respect to arithmetic operators is handled.

Such information belongs to knowledge for expression properties,
doesn't it?


>                                              If you have some other
> concern in mind please make a concrete example that shows the problem.

I got the impression that I see another need for the extension of supported
metavariable types.


>> Will additional parentheses become relevant then (or not)?
> How about actually trying something and seeing what is the result?

Corresponding software tests happened to some degree.

I am unsure about the circumstances when the problem awareness
and development resources will fit together better.

Regards,
Markus
