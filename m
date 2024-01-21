Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF21FC47422
	for <cocci@archiver.kernel.org>; Sun, 21 Jan 2024 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dFe4s3Xk6af+DmJPrm+2KbPp27MD2Bm2lbhUYb8jQoM=;
  b=DhPOTlIPHA8DNTC0nyAjbL9HZE90T/bQhiCE2G5F4hXLIehIkx+xGN/r
   FzHvROFW4YKevECiKMywkLPRMKBDX7+u3DtwXgZ399EfolLPZi5cEJQih
   M2bbNSVW7P6JCiGxqXjoKzB12DVijtf6mGIdw9NzlGbECPeyHQvNi1Ine
   0=;
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
X-IronPort-AV: E=Sophos;i="6.05,209,1701126000"; 
   d="scan'208";a="147777200"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jan 2024 12:04:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4EFB6E0CD6; Sun, 21 Jan 2024 12:04:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 36EAEE0035
	for <cocci@sympa.inria.fr>; Sun, 21 Jan 2024 12:04:26 +0100 (CET)
IronPort-SDR: 65acfa39_z3kYdbaz8BZCX1gzkx2ZLWV4gcjyDBKr4nTAnHuhT0dK/90
 Nimd+oeYJr41I3U5XdsakM0o+B+qkgU7wjdScUg==
X-IPAS-Result: =?us-ascii?q?A0F0BABg+axl/wQP49RaHgEBCxIMQIFEC4I5B3hTMgQLS?=
 =?us-ascii?q?IRTkTYwVYNmhzaHToRrhASBVoFAPg8BAwENQQECBAEBAwSEfwKHRgIeBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAoEGE4VsDYJcARCBD?=
 =?us-ascii?q?IEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgEEASMdAQERJgEPCxoCHwcCAlYGA?=
 =?us-ascii?q?RQBAYJ8gisBAw4jB7N4gTKBAYIKAQEGr1kfLCJWgWEJgRouiBwBhEWBIoNBe?=
 =?us-ascii?q?icPgVVEgTwLgng+hEODW4JGIoEbf4NDkVJUfx0DgQUEXA8bEB43ERAFDg0DC?=
 =?us-ascii?q?G4dAjE8AwUDBDIKEgwLIQVVA0MGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJA?=
 =?us-ascii?q?hAUAzgDAwYDCjEwVUEMUANoHxgaCTwPDBoCGxsNJyMCLEADERICFgMkFgQ0E?=
 =?us-ascii?q?QkLJgMqBjcCEgwGBgldJgcPCQQlAwgEAyspAyN0EQMECgMUBwsHeIIQgUIDG?=
 =?us-ascii?q?SsdQAIBC209NQYDCxsGPQLiODQHgjSBYIFhDJ8vBhMvg24BkzgOBpJZLoUFg?=
 =?us-ascii?q?lAWkDsgqE2BagE1gVkzGiSDNk8DGQ+OIDiDc49HQDU7AgcLAQEDCYVGAQGDW?=
 =?us-ascii?q?oFGAQE?=
IronPort-PHdr: A9a23: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
 MfCnuT/JWUamzox1dQRDY7YJZDfWEc=
IronPort-Data: A9a23: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
 Imw
IronPort-HdrOrdr: A9a23:fFlo/KCM6Jom3DPlHel455DYdb4zR+YMi2TDGXoBLCC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:ozE0zmP1+4YA2u5DRwdr1kcxP8QcNT7xxXnuJW6iVW0uYejA
X-Talos-MUID: 9a23:NDfCvgRz5pjNZOwgRXT01C4zb5diwJ2cGXpcsYU5q+DVNCV/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,209,1701126000"; 
   d="scan'208";a="147777186"
X-MGA-submission: =?us-ascii?q?MDHFItM8IvAJ4OyuYOeEaa8buNyBRkrV7sjGO3?=
 =?us-ascii?q?BvC7UMat0EWki6LlqJbkWR16tYkKydNO5WPV61MfC8HFlqqVG8spIwdc?=
 =?us-ascii?q?zB4mrU6sp/qkOlm+gSzFh6nz3KEC2AtyBFffXwk3xRq46IwYu6ckbzwG?=
 =?us-ascii?q?RI2fuQlJUzBKytqCjesZKP1g=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 12:04:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705835057; x=1706439857; i=markus.elfring@web.de;
	bh=ZBf5wsr0zVlRl65bLe/eDTt74wMuP9MVSgGfpJd5uQM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=a0gXouY9MXY2SSbkxiwUbIR+pAywqxkENiFDsYUK0H9pntG7Zm8NmkGHAD0oNdL/
	 kPhZvbPw1bJIB+5UL0v4/FFsIguUkVokSOcckPHJ/3XfIRT+etxKqIIjCRJUPtBf7
	 krxHoyJ6Y1wVBALOWhCui9BTrpWNEUREkCJJ2/MfKY1nSDGjsJ6FiYtZRgay59I3S
	 O6zod7PtPhpWUEfjcnM/U4sS1wMOb+VulhITKN5TUNbGyELKfBOaBCYFWfWlqguah
	 WdGujMMKU4Nhvp7lfFB2l7AfB7Bs85x46WessfMQN+T9ThWJuJNhKG6pV4/a5BC/u
	 DFD+/LFPQYzfSexiag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1VL-1qph6N3jOZ-00dUho; Sun, 21
 Jan 2024 12:04:16 +0100
Message-ID: <161c3be1-011c-4ffd-8646-1b95f1a461eb@web.de>
Date: Sun, 21 Jan 2024 12:04:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, Li Zhijian <lizhijian@fujitsu.com>,
 cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
References: <20240119062057.4026888-1-lizhijian@fujitsu.com>
 <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
 <f34231dc-186b-4cb9-889b-b3be9224c5a9@web.de>
 <alpine.DEB.2.22.394.2401211159350.3743@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2401211159350.3743@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WeXwUX6Svf5TPxoWwSCSwc03iGGWuP3zbVSv3X8Ju9LtW/rAIF0
 imChZZIHPUfTQEsqZLxBFRS1QMwie8AM8qh3FwTsqt198cMYhwd9bHhp11crr1XZaWCncng
 dM+n0tgfVzGuCNKX9Hn1PFx1K7PG/QC1XUpvzN7oeWUYQRxy7GrCTtg47osDazoLvlewT42
 p3q58llW/wKW+j6SUStvQ==
UI-OutboundReport: notjunk:1;M01:P0:q2jDmcDuYwQ=;C+mzgigO59RSMKBk0llp7W3YQ+A
 hJ6HTdXytOXxE9yN9osp7WJRJxVJB1z0akKW/hN/vWzuV6H8bHFl8Fo2iyxYjRtBLyQLiekTJ
 nJDak9MzxCS4UMWunPzRR5NLe2zwCHfvgnpALqG0hQd3L6Ikk964O2vGabM3rOA4d7J5pWeDE
 9e/wHmWP+GXQGtNR3+/3e/kKhdC2s2I/+ezevTTSpJNyU69bVsvDj5vtv3D5WY6rthRsZaSGy
 yJsQ7jMQ6U3ZaDCFFP+tKwLd/qsbnLO+8zikAPYj2XThyiSaf6xkS8cejW+Hvf/mYLp2n1nch
 AMuMeWtAsbdwKjshf/R61ics7iJaDzN7o99J6HsEx2haTFLWC1iAajZIaWOzcfpWijXiRR+6W
 SUo7hS0fFgeamlkTBzFMLfBXykpK5YGC1pcg1wLPVInSqgyXTQhV7oV8c6roobUBKu5d7wz6i
 SkS3FDObDPortdVtDTXJNl306DVkIHPOz432I0is0YPZmDCjpx8bcNhL63powUTdjrsU+OINs
 PRcFCWmzpXwhoSDw38iI19+L/41iZZAM/OR+Ec6nmWHOVsvvrdCOBLLlzr7UJvQ03ShZQ5Eqc
 co1liF8YRgIe8agUJabA5q5cHOMS6E2CTaD4M1hlqRyVD1bmsksaua5xGBT1xy1jZX2SIebyj
 eKxHkOCT/uAeeR7F13Wg7qNNXzfdE2cCQX8UWpMIPwpv3OnUK5HuBk7RT0ZBj7SY+C5SzL1GX
 i83sHEaTbjQjsvoRYpSakZV3nOP2/l9yrr5LGxK/JKPOxMepLKmuIudYZzKdraKkBwWu1gs+N
 SiE/FFiyqmQjYr5C6mRRMsyGveoYTDG37oPGwr3H6qt0SjFCMEdQgpNWG5stoCgSi79JG1aOZ
 W6pZwECEJ39FhO/VpaNcMzygNvd8CF2fcaRKN9tiLtjRSduIToK1vqGxp3aolhqIw6LHRrqLd
 5YICEQ==
Subject: Re: [cocci] [v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1462
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/161c3be1-011c-4ffd-8646-1b95f1a461eb%40web.de>

>> Would you like to consider the application of the following SmPL code v=
ariant?
>>
>> -snprintf
>> +sysfs_emit
>>          (BUF,
>> -         SZ,
>>           FORMAT,
>>           ...
>>          );
>
> It's ok too.

Are you going to integrate such a transformation approach?

Regards,
Markus
