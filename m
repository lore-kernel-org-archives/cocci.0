Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58A0CA0FFD
	for <cocci@archiver.kernel.org>; Sat, 30 Aug 2025 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JhTvZm8e0TflWESTkr1bUqq2GuDC7V6j/qIQQwwPnAY=;
  b=FLOlXkpT6j0SYvd79Lid1HC2H93E0HjRG4tGpZ31sN1RQl5zfsF+NqeV
   HaiilR5iy86eJbI2tkgDEVm2vaTeuuyYGgoxPPPVfl3bAwIp+0gu6vQW6
   t8dajoiILVTkkkEJ/e8BKcQ/LuLY0/maLh6r4SgIbGPnZB7wIR/w9D4Ny
   Y=;
X-CSE-ConnectionGUID: 0FslD3xdRH6BNAxA07exAQ==
X-CSE-MsgGUID: jVoYQ2PwTK2XYmnNsvHa1Q==
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
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; 
   d="scan'208";a="236735065"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Aug 2025 14:20:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A0139E0BE9; Sat, 30 Aug 2025 14:20:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 012DBE0172
	for <cocci@sympa.inria.fr>; Sat, 30 Aug 2025 14:20:52 +0200 (CEST)
X-CSE-ConnectionGUID: s6qNDmhgR3+P26X5QeL4Lw==
X-CSE-MsgGUID: LACkAQ47QDGsHhSFnfjtsA==
IronPort-SDR: 68b2eca4_CXiMztUEFlxeslkFjnh7tRGXY6MVmrxh82U9sC7Ej6sN+Fi
 br6kOZXoZ4nuu18MKw2xizmUitDSc+w5wagyChA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E+AACI67JogAMP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQQQBAQELAYI/gQdUMwQLSYRVj1CGX4c8h1WIeYFVgX0CDwEDAQ1OA?=
 =?us-ascii?q?QIEAQEDBIUAAownAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBOwcOCjGGTw2CYgGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBF?=
 =?us-ascii?q?wJHRAIBAyMdAQERJgEPCxoCJgICVgYBFAEBgn6CIwEGEAEDNQe0YoEygQGCD?=
 =?us-ascii?q?AEBBtpeHywiWYFkCYEbLgGFa4JkAYYng0J6Jw+BVUSBFSeCUjE+iB6CaYImg?=
 =?us-ascii?q?RaDWIxaiwRSeBwDWSwBVRMXCwcFgSBDAyo0MSMPPAUtHYEneYMHgQ2EHStPg?=
 =?us-ascii?q?htygXU+GUCDUx4Gaw8GgRUZSQICAgUCQz6BbwYcBh8SAgMBAgI6VxCBfQICB?=
 =?us-ascii?q?AhAAgELbT03CQsbBj2VRocZll2McaJ7NAeCOIFngWQMn2wGEy+DcZNhDgaTB?=
 =?us-ascii?q?ZkGIqkfgW8EL4FcMxokgzZPAxkPjiGEM7xnQTU8AgcLAQEDCYVGAQGMVoFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 hwV3fXnII5VOoCpgyRf
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nktWY6oRkrhLUMRuI1h1Ec8aV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: 9a23:FAZeb22dHc8i+oBlIgjicrxfAZ48VFHYzHjqeAyAUzhZFYSYbQO05/Yx
X-Talos-MUID: 9a23:nGeEQASzZ6Qz5suLRXTIrRphHf40vJ2CJ1stka4ovceGKTdZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; 
   d="scan'208";a="124232399"
X-MGA-submission: =?us-ascii?q?MDH4gQ8m62pczCsUfGlTVPnQHao4bZsEXyuLhE?=
 =?us-ascii?q?Sq/FCgt1NqeNhN/trRFcPcXiWlT0e50FJ5KZs/uDH5sLZAhVjCpNw4cj?=
 =?us-ascii?q?H9g+u+ZPJIR9LmLuLn9sBcvvVlkcAYQ5iMP92hpp+UmVzkP6BdnXVhRf?=
 =?us-ascii?q?Edq/8hd9Y9IsKRXk5KQv3qdQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 14:20:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756556451; x=1757161251; i=markus.elfring@web.de;
	bh=JhTvZm8e0TflWESTkr1bUqq2GuDC7V6j/qIQQwwPnAY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kE955Vtd0n8AQiGLs+8QAQCwJnXaPzLJwYYlkSYjfEl07kQ/k2T7LBggkkYDvIN5
	 6huNtlisTY/feQhNgQCXUfHaR5N8gvcdKk6uBYWNFAwvON3SMdvJFUhLf6sVY+wid
	 e9KsNH6vZ5ZKb4HldFoFjNzWTi1EKV8YavJR8P/orUUkRXQRpbcW49m0ZN95dBSRK
	 6fHXpPZ48x2gIRCl8XFEV7zigq+zGZbQ3sZovxtokAcv1dsTwBtFx7MkMgKs2AKmq
	 h0egBipymFNTVn2+j990VI8mh7/PrFnrkWmoUwEbof3a4vZzLCWqJK2J2tAwDjfI4
	 Yjoqc2N8MtTo73jfJQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.198]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL0C-1ugD5T0ZuO-00CMbE; Sat, 30
 Aug 2025 14:20:51 +0200
Message-ID: <d50936c0-ec28-4f8e-95b1-e065d3b3bc3c@web.de>
Date: Sat, 30 Aug 2025 14:20:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: =?UTF-8?Q?=C5=A0erif_Rami?= <ramiserifpersia@gmail.com>
References: <ae674fb5-8cc6-4807-97f7-92e2c4208149@web.de>
 <ba58f313-5edb-4ff1-91fc-1682321e4d61@web.de>
 <cb904f74-22a7-49e3-8999-34fc06b1054f@web.de>
 <fa82455f-6294-4200-ad6e-c31add12b303@web.de>
 <alpine.DEB.2.22.394.2508301400410.26590@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508301400410.26590@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C+pa/8eoZddxSqgyC3sPW3cp316lXU955RRSvDQWtoKR0zbBQC6
 g07bpXvp5WQZUPhu9dQqYFgb5/PrbkZMu8/sx6uXQ5AEOwirwbN2jr1mPcQ9aNSus/HqTvN
 lQXSEcBIUmfqiAEg/ZxC3zVGLMiOhFEGX5Pf49Ylj9N1vM2lRCLmOuEmUrKnxb7SIXfLxD0
 XfMh1RgGlbnjC4a01NooA==
UI-OutboundReport: notjunk:1;M01:P0:bF2quYPCvW8=;2WSqtc4b9ADr1FFRCaen2FqS3w4
 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
Subject: Re: [cocci] Reducing the scope for a selected variable with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2987
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/d50936c0-ec28-4f8e-95b1-e065d3b3bc3c%40web.de>

>> @adjustment@
>> attribute name __free;
>> identifier i;
>> type t;
>> @@
>> -t *handshake_buf __free(i) =3D NULL;
>>  ... when !=3D handshake_buf
>>      when exists
>> +t *
>>  handshake_buf
>> +__free(i)
>>  =3D kmalloc(...);
>=20
> This is not correct.  There may exist some path where there is no
> reference to handshake_buf, but that doesn't mean that that is the
> property of all paths.


Do you propose to generalise such a source code transformation approach
any further?

Regards,
Markus
