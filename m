Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70687D116EA
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 17:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:in-reply-to:references:
   message-id:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RNheUmVdMaNEwHzGV+7h1ZhuoAsWqVHskLyrsK2XcbY=;
  b=Z1s0/3/mSI1yc5iqC1ReiBztiIYUWNewuUwzN6RG19vUzL+0g4jXFe7Y
   cDeFPRRceqHSy1qnFz1Uv4Nq17HM/r9TcxXGX0wlsp9pxwVjpP5Cj6l/+
   4wdzhsCbMkd4FPiWyGLR9ntbaXiHmdwVoOdQALvirmApm4mjHBes/QMQ0
   w=;
X-CSE-ConnectionGUID: zBkn3ZXiQ6CrbHhq1Td+Vg==
X-CSE-MsgGUID: 0uyRTU5KQrOqHCT4NyWgeQ==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@posteo.de
X-IronPort-AV: E=Sophos;i="6.20,237,1758578400"; 
   d="scan'208";a="251899764"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 18:33:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 80E28E0260; Sat, 29 Nov 2025 18:33:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9C363E0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 18:33:25 +0100 (CET)
X-CSE-ConnectionGUID: MYFB6BWrQ8mJ88A4IYqtXA==
X-CSE-MsgGUID: tCDKqHnBT623tP81vb/tMA==
IronPort-SDR: 692b2e64_TSuQ/ecGBPYwsJXFywKm1cceG2BPkBhmPSrTWrD2KJQnbx3
 TYN9ySX4UfS/v5dlv1m3j2FXZankKCe6H6Z35Wg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EQCgDvLStpe0EkQ7laHgEBCxIMQIFSgj6BYDMHCEmNU?=
 =?us-ascii?q?Ih8EZIGjAQTgWsPAQMBDU8CBAEBBIFPgzQCjGUCHwYBBDYEDQECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQFCDjuGTw2CW4JRLIELAQEBA?=
 =?us-ascii?q?zgCBgEBOA8LGC5WIYUdAk8HAbFxgTSBAYIMAQEG3CWBZAmBS4VtgmUBhV6FC?=
 =?us-ascii?q?CcPgVVEhA4xPoNBaBoVOIV3gzSGJItvh0MsJngcA1ksAQ8RNRMXCwcFgSBDA?=
 =?us-ascii?q?4ELIw88BS0dgSMhHRgRYD0XQINJHQZnDwaBERlJAgICBQJAOoFmIgYcEgIDA?=
 =?us-ascii?q?QICOlUMgXcCAgSCFn2CCg+IC4EJBS6BDQMLB2Y9NxQbBgIBgTWUElCBQoEDh?=
 =?us-ascii?q?B6jBYE2oUU0B4I4gWeBXgYMn28SHBeXYJMLmQapQYICDROBXE0kT4JnTwMZD?=
 =?us-ascii?q?44hDBYcg3XEdkM1PAIHCwEBAwmFaROMIoFLAQE?=
IronPort-PHdr: A9a23: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
 xlwhgYsOIwQ
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:H9s/KqMUKNeD/MBcTsijsMiBIKoaSvp037BN7TEXdfU1SL39qy
 nKpp4mPHDP5wr5NEtPpTnEAtjifZq+z/JICOsqTNKftWDd0QPCQb2Kr7GSoQEIcBefygcy78
 ZdT5Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AAwuQGmuDoWQBc/OAVtZcBxNX6IsAQ1P3kl3vOXb?=
 =?us-ascii?q?oDEQ5GJTJaG6J5JNNxp8=3D?=
X-Talos-MUID: 9a23:XgmQMAYQwQZj6uBTqxTApyhCMu1Uvf71FHhdyIsM/NWhHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,237,1758578400"; 
   d="scan'208";a="132288881"
X-MGA-submission: =?us-ascii?q?MDGtwPEdvZWlR77lSJf66NeF2VlIRBQzQS/zDh?=
 =?us-ascii?q?6wOhnMUbjdkQguDhuvz4k1q3BiXbHesgt0nMawddhW7t859in8v6nm9O?=
 =?us-ascii?q?8ffx+u//UmV3SWR9QathYrP87jwBYg7d6I8Z8Yg9JraQOtiZb21CYJ/6?=
 =?us-ascii?q?zY+2X2isWXlXU3jhOJ3dB+qQ=3D=3D?=
Received: from mout01.posteo.de ([185.67.36.65])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 18:33:25 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 43CBA240027
	for <cocci@inria.fr>; Sat, 29 Nov 2025 18:33:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764437604; bh=RNheUmVdMaNEwHzGV+7h1ZhuoAsWqVHskLyrsK2XcbY=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=b3+Pd2vdUkYxD7R0yrikejJYpqoBUy+uZyas1dCbOeT0WjUUUDzFAN2qBexOaY+i0
	 ZQ+2p9AdxuNjCShtsPrdpN1IoVM4uEvg7rYDhFuRMAn0D4JoXWD6doUjDgQqBKP9uJ
	 QqAqyN/IEEsHj248IroS7dbR35B7r5z8wDhn0TI91JedOyJAHH+F3KrcHdy3lA540r
	 eqW7spDV5T3uSuqvoY8L91sHYZJci/oWOA95wfbE10sDhIyF6wkZ8Qqci37/vGJ+EZ
	 pMveoYSCvb3gOhkN92RtdCAOYj7bJmC8g54sQAgYITAQhdHW+WPRXBDh1hjOxRj6Vh
	 hjHB+xCyCxpdg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dJchN08S2z9rxF
	for <cocci@inria.fr>; Sat, 29 Nov 2025 18:33:24 +0100 (CET)
MIME-Version: 1.0
Date: Sat, 29 Nov 2025 17:33:24 +0000
From: Tobias Deiminger <tobias.deiminger@posteo.de>
To: cocci@inria.fr
In-Reply-To: <fd7307f8024706d4bd128d0b7f43bb96@posteo.de>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
 <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
 <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
 <67f9e0f2-fa4e-c7a-d388-3732d8aec1e6@inria.fr>
 <67d1e00d2e22a4655cb10ec55d1a99db@posteo.de>
 <83c8a7aa-9b98-8ac1-d563-e8fe2588f9a@inria.fr>
 <fd7307f8024706d4bd128d0b7f43bb96@posteo.de>
Message-ID: <29c204aa0f1f08074279425b7de42dd7@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Tobias Deiminger <tobias.deiminger@posteo.de>
X-Loop: cocci@inria.fr
X-Sequence: 3215
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/29c204aa0f1f08074279425b7de42dd7%40posteo.de>

Unintentionally removed the list from recipients, thus resending. Sorry 
for the noise.

Am 29.11.2025 18:29 schrieb Tobias Deiminger:
> Am 29.11.2025 17:36 schrieb Julia Lawall:
>> On Sat, 29 Nov 2025, Tobias Deiminger wrote:
>> 
>>> Am 29.11.2025 16:59 schrieb Julia Lawall:
>>> > On Sat, 29 Nov 2025, Tobias Deiminger wrote:
>>> > [...]
>>> > There is no macro expansion in the semantic patch.
>>> 
>>> Sorry, that I don't understand. Here's the complete minimal example 
>>> as I
>>> understood from your earlier advice:
>>> 
>>>   // my.c
>>>   SYSCALL_DEFINE0(foo) { return 0; }
>>> 
>>>   // my.cocci
>>>   @r@
>>>   attribute a;
>>>   identifier fn;
>>>   type t;
>>>   @@
>>>   * t a fn(...) { ... }
>>> 
>>>   // standard.h
>>>   #define  asmlinkage
>>>   #define SYSCALL_DEFINE0(func) \
>>>       asmlinkage unsigned long __SYSCALL_DEFINE0 func(void)
>> 
>> There is no macro expansion in the semantic patch.  You have to write 
>> the
>> semantic patch to match the expanded function.
> 
> Yes, I believe that's exactly what I did:
> 
> 1. The semantic patch is "* t a fn(...) { ... }". It matches the
> expanded function, where return type = unsigned long, attribute =
> __SYSCALL_DEFINE0, fn = foo.
> 
>> Macro expansion only happens in the C code.
> 
> 2. The C code is 'SYSCALL_DEFINE0(foo) { return 0; }'. I assume this C
> code is expanded by spatch to the definition in standard.h to
> "unsigned long __SYSCALL_DEFINE0 foo(void)" before the semantic patch
> gets applied.
> 
> Somewhere either me or coccinelle is wrong. Very likely the former ;-)
> 
> Tobias
