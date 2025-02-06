Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76981C02194
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2025 12:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=z0auJFXiLMixIgXB7GmiZrMKgnBTqH9fa4XJRYZfud8=;
  b=OmFhhcUpT12JzF7oaFwP98KqCMwZxH5/sudyLBUcZbYcLLVEdPrK4MZS
   umY9RKOX31TGsFJp7QIg5xSG8cf1HTUbD+iVdZ591dFMoTspiFVF8iOhP
   4etlARi2Vp7zTmOOA9HdnEb54DsVzLQ6G73BHMgc3AXs8cVd0HjmDTjON
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="206920524"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2025 13:37:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BFE77E0D20; Thu,  6 Feb 2025 13:37:01 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8E5FCE0260
	for <cocci@sympa.inria.fr>; Thu,  6 Feb 2025 13:36:56 +0100 (CET)
IronPort-SDR: 67a4ace8_gPqIHsMp7H6roIdV+YWz6wuL9FQtYXv8YAl+k1Vj55Psnuq
 pwWxsnVhVcTY8MH7tJ7bp+LoTBA4HI1rK92wOUQ==
X-IPAS-Result: =?us-ascii?q?A0H5AACJrKRngwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDgVczBAtIhFaPT4F0MIQ7hzuHU4h1gVaBfg8BAwENQQECBAEBA?=
 =?us-ascii?q?wSCDIJ0AosBAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBAToHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMEG?=
 =?us-ascii?q?QEBESYBDwsaAiYCAlYGARQBAYJ+gjABAw4jB7AZfzOBAYIMAQEG2lwfLCJXg?=
 =?us-ascii?q?WUJgRouAYVrgmMBhWoBO4Q8Jw+BVUSBPIMDPoEFAYMlGINbgmmCM0qDfmeid?=
 =?us-ascii?q?lJ7HANZLAFVExcLBwWBKUgDKjYxI4EjBTUKNzqCDWlJOgINAjWCHiRYgitqB?=
 =?us-ascii?q?AWBLYI6hEOETYVbghKBYgMDFhABgyF6HINdEB1AAgELbT03CQsbBj2fAYMlg?=
 =?us-ascii?q?x6CBsVgNAeCOIFmgWMMn1wGEy+XQw4GknuYfCKpDIFpAjaBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hFwKEFMdlQjU8AgcLAQEDCYVGAQGKaYFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nOlfcK/Jb+zLRcFCd1Juk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re+cjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:suui1GDh8LZLJmn6EyhV5XUxA854Tib+j3vAHXC0K1RWdaLAHA==
X-Talos-MUID: 9a23:LQrG/ApiAMc04N71rE8ezwh4KMJw/YOAMn1OyIkZlsquEi1dAzjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="206920502"
X-MGA-submission: =?us-ascii?q?MDF0swzg6gaQ4kFc+ov6LyDj2UagMMRHXWUnJV?=
 =?us-ascii?q?vQfGJTR5X9SMpF6i5QVcdicIoebGF2MxLBrcag+WJHvUJtEyjU2DGsDZ?=
 =?us-ascii?q?EFX401CSFE3v21bxGlNN4eD4+1jH6q3Bzp5dvO0WMNfoAbhYdzumdS66?=
 =?us-ascii?q?+YUP4n1Q4GlH9QmZZbCDpHSg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 13:36:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738845415; x=1739450215; i=markus.elfring@web.de;
	bh=z0auJFXiLMixIgXB7GmiZrMKgnBTqH9fa4XJRYZfud8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=K9T/NqVfrN3jVgLow6VsTw56WF+S0eeiPn8sg2cbJeG6i6VTGD4i8RohAmwr/8SX
	 czvlAP6QQDQhwbzBoifTY9bPcgbHmzO5dWalvwwV75gCNtZ2JuIPO6Up5vH2/LXMV
	 F4h1fgwUYZLLM3KT9G0J1QuPxFgeAAc1iCe5TEZkDXHuRFn4mXnU3VgNQJnV31MDi
	 bktdxzxf6pJ7o4skFgRv3EOtpT6D3XBrV7jgRMJ4z9GZ4Mb07I+EkDU8MvYdls/Nk
	 35ozvFfFNuj22KLvXSXKEh4JK9GC3TqH5lcGiHnui0qPZD7vZbMy3fq2kj0Vqmuw4
	 qJGyhiL0Nuyuqkb+Zw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.8]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyO0s-1tTqvr0ZHo-015MV8; Thu, 06
 Feb 2025 13:36:55 +0100
Message-ID: <6e422c52-814f-4ac8-9a6b-2acd41e28c08@web.de>
Date: Thu, 6 Feb 2025 13:36:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
 <4ed80c12-f83f-4d4f-aac9-166218943535@inria.fr>
Content-Language: en-GB
Cc: Johannes Berg <johannes@sipsolutions.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4ed80c12-f83f-4d4f-aac9-166218943535@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:30Fkd0MtST04y9bvRkM1mJc1dHGl73qr+G/z/UlmIWOFPnnJMLr
 KD42ZCGf3PrR6yZKoQNL+TAk8JAvOYp5stJDumyfEC/IIPWUkZWSKLL9fVfn8f0K18s2eY+
 T0x/zzh95GFZwYFMGZ71I7Vix5963Z0EccA5itm8LzAtA8S6fTDGCIai7PIOIAY9b6zmAf7
 +RlgxhL2GQFWNsFuJTyNw==
UI-OutboundReport: notjunk:1;M01:P0:Oo92SxPedLg=;nrpDFLLJnk3omWrcbQQVA2P4zBE
 6E2tkldWuE11XGxdTH1lwx7nJdqIH8Bme195kfwtBBwVyEdzUHd5I/AKfdC6k8y2XfNzabUVM
 urmZ9zWCaPSfBJwjGe9PF7PM0dKliAWg/jMUiXridBT8gzTpJtiKXN3zcmgJnCA+knWxfxtXK
 TQE1ktELdSh0DYon4vxarv+qqdEDNjp6VV4Z0NV2XQ8QKifaOX0l3bCKOT+D7zCW/io1YKFxP
 YrRXGIjvUGlDlsRLwjLLcSeHzhjuNR0gelPAGa81baoEPD0Z6qXeRXTVLzCndvV9dBMT7YqQh
 VCjAyWD+SsZz6wPjl0fR7hhkrd1fStYXZVpPd7aIDX9JirqSEZ6KBILjKDVv1YcyKN8l4uraF
 HG77tfAyAroLwxp13BOOiKk5bsJdina4A5olfolz2YW21ySysMXwfKkvBPH3ODcSqjutKZbqA
 r+Wb3utAHNkrzDaGhA4TZeTopMzPJv1S0EWDPOufHziFnnITD5kI0UCHHlruD4eExrW1Dk8R+
 pHGrHbE70f7QlOjO15m60yYO6dwQdeutcTA5hcnjbVCUF+eKUOiI9lqBnoe0/nuI9iflC4o2J
 S3S2KCUo/utKZRmVjN5Bp+IM5TNBYFVQTiI/mR4ySL8oaw+Eur75J1don6EQanKImiD6yhhcs
 hJPY0eMVnbfZltcG5EGP5LvV0/fzkotkEsBA6k85uzJq1QXnclalf1NubFZGRKIvihuni08YL
 R31Lk+rRVt7aliwXalTwn2oI91wsPPigvcpL4JZ9aM2OVaf/GeUkp17YyVpjLautSA7BEZeoH
 +yvyqnlXZT2plcCeTUb6AN2o3smxCqSDL2HP67D7/efZ5TdSMQ06n3bmFsWv/iEeXAL0vOnau
 rg/yQKqCETugpxBp3ZurgbImNXtAQHsWOhmUNtjPFyXgFnEbvtQ5Tq5jP2se71cEza3eCJJ8d
 PtR4ax+bR97liWduVAMgloAwzmYe7sGN94dKknzO21CPZgVEEtnV/tniT4sRwk7G0dt7F8vm4
 EJpyaeP943DcVbk5IfzJfJP5tjba9DTstS0LjZcj2DzLdl0A+NVuItrnzBitXv+81o9VeGvRX
 zljtCYZq786vW6/l30z7D7S7WVu7oQx2H2RZqBg8TmUbfI6w0l9frkEtQLAk9U8QBleCh3nUK
 YyKYKtNOeMpY/vUm7RiX7stfi8QcBePQ9dghsXHwQdPV+PHqoVRP3XTt63aRER6CeqsdDOrnv
 hTTJ7vcyc8dr4TLOyzNsNGUf2tb+Cmn67AvR17KmEkIFN2JI1SvdfjjRJj/EiVoDK68p6ZLzu
 8cF1LldzfJTcDsP1vRsHtCfnTjk9tD6pKpE4qBy+mIc07jAz/v4VuyAIWxt1E0sWjM5YwOZHv
 O3PD2oQVxy3tHsdQnsCVdmyW4S5rIeXvktAe1+Votv7kxfhn8R0ObpQ1e1J5oEvc8vbcHnjXz
 kirCHdQ==
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2360
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/6e422c52-814f-4ac8-9a6b-2acd41e28c08%40web.de>

>> I stand corrected, I wasn't patient enough. On a machine _much_ faster
>> than my laptop (server CPU), it finished (with warnings about
>> inconsistent modifications) after a bit more than 10 minutes.
>
> Glad to hear! We know there's been a performance regression in 1.2 and w=
e are looking into it. It's a little faster in 1.3.0, but still slower tha=
n 1.1.1. It's unclear at the moment to what extent the performance has bee=
n degraded because of necessary fixes that perform unavoidable additional =
work.
Thanks for such background information.

How do you think about to improve measurement approaches
for questionable software run time characteristics?

Regards,
Markus
