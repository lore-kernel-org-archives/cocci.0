Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912BBC87FC5
	for <cocci@archiver.kernel.org>; Mon, 21 Jul 2025 08:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MJWTQF23n+kgxjgZ98C1ckQYF+Z3nKLOW+2bIKDnfXI=;
  b=fGmJBQpEuCc8MHkpbn+HgsWDCDYx63HXVQl2GAztsEkVW8cBkWwIJSIy
   wn+BayuU7BBICXa7ZXitC/lrymjt/KMmDmR9O0h8BZhh/iR36MoJ5lq//
   e+WMkVWL1gbALNzH2JWhOKVo4JwKoQAZPFcmW9o8DMnDoUACSlCyFTXfy
   k=;
X-CSE-ConnectionGUID: l0Pkzx6+SQuDaH9dknQDSQ==
X-CSE-MsgGUID: X01MErBJQr+UPzoQbIGWTg==
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
   d="scan'208";a="232413737"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jul 2025 10:11:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4F9A4E0CD5; Mon, 21 Jul 2025 10:11:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4CA9CE0171
	for <cocci@sympa.inria.fr>; Mon, 21 Jul 2025 10:11:09 +0200 (CEST)
X-CSE-ConnectionGUID: IN4WncP0TSCuV/z6SgnWAQ==
X-CSE-MsgGUID: nOD/7B8bRs6bCRtouHgNnA==
IronPort-SDR: 687df611_NX4KsCUDOi8r/8hWLIcUQSvkq4rgpmwZY5Mq3sqCZrDvdfn
 hkGWS/w5EwnYEdpF0jErSe1muzvRNtJvbeU8mww==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FvBACQ9X1ogwsR49RaHgEBCxIMQIQXgQZUMwQLSYRVj?=
 =?us-ascii?q?1CCJIQ7hzyHVIh4g1ICDwEDAQ1OAQIEAQEDBIUAAowTAh4HAQQ0EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBOgcOCjGFew2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnDwsaAiYCAlYGARQBAYJ+g?=
 =?us-ascii?q?iIBBhABAw4kB683gTKBAYIMAQEG2l4fLCJZgWQJgRsuhW2CZAGGJ4Q8Jw+BV?=
 =?us-ascii?q?USBPIMDPoRDg1uCaYImgRaDZIZ1hhOHflJ4HANZLAFVExcLBwWBIEMDKjQxI?=
 =?us-ascii?q?0sFLR2BJ32DCoEOhCcrT4IiAXWBeUEZP4NVHgZtDwaBGBpKAgICBQJDRXdAA?=
 =?us-ascii?q?gELbT03CQsbBj2SYoIzg3LHMzQHgjiBZ4FkDJ9rBhMvg3GTYA4GkwSZBiKpH?=
 =?us-ascii?q?YF/I4FcMxokgzZPAxkPjiEZhBrBDkE1PAIHAQoBAQMJhUYBAYl8gUsBAQ?=
IronPort-PHdr: A9a23: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
 /Pn6az1J8IfO9+is6SHQkZ3lsLGFhiINe0=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:L+zPb6FRg4voZ1TnpLqENseALOsnbusQ8zAXPjNKOHlom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4xgPM
 xbE5SWZueAbmRSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: =?us-ascii?q?9a23=3A+I4pYWpAH6AxqXbUclOlD3TmUeEDLkLbx0+IH3S?=
 =?us-ascii?q?TFFguWuOuRlmv0Zoxxg=3D=3D?=
X-Talos-MUID: 9a23:+OCkEgjUcFKI4f9AuaDIT8MpMuBEpPuEWEo3issMkPOYMjFQNBGbpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232413661"
X-MGA-submission: =?us-ascii?q?MDGoXt+0LJORLJ/NbJR3hucEBhJ36aqH/jd5+/?=
 =?us-ascii?q?QjYNacr2a0OGeAjADBYHymL3F+xv23htamWii3jHriT9PxOLiqKcuizj?=
 =?us-ascii?q?kbOlHxZ15KR5QlV/p/CTET2oRIaCRF1N6SdUP1jzLyMk9RXeTOfJGF3Z?=
 =?us-ascii?q?/g8Zj0E/hNDVk++YLeymkliQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 10:10:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753085456; x=1753690256; i=markus.elfring@web.de;
	bh=MJWTQF23n+kgxjgZ98C1ckQYF+Z3nKLOW+2bIKDnfXI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uhrkS9TFVsZ8PN7jOXUO1iiNxO7JtfBG0vmb5wn0cuUg2hEOg4YrhKhBxr5eac8X
	 /3z3BSdyf9PcCtLFjn+pfMDNBxYFhkDqpxLsOZtEEcC6uGLqV6q0s8n0CBAyav02A
	 pNcnNVeAKyMd47N1QZt4pJ9mhvs0H9uPK+kRlAihENF2GjjJw4fRRVPmtsOLDj1rj
	 NUydyCPR/Tiot5QEDNgVsi7y2tVxBuC06ZoaoN28uF39mjrR+7FnyTzuVxYTcTZNV
	 Nil19hiPlHnfGx+vm1gh5dgi1/tlvGYk/mF8rqKhqrkK2+QVPwK5vAPYmAe6GII4h
	 yMi6QoJkEYjwJ+NuCA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhWkj-1v8gVf2It9-00nlAr; Mon, 21
 Jul 2025 10:10:56 +0200
Message-ID: <b725f4d0-3c8b-40f8-872f-c79ee0d74c30@web.de>
Date: Mon, 21 Jul 2025 10:10:55 +0200
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
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4752963-ce2-3e23-fe61-9cbd1acbbdc1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e/JM0XOpQlaYMvOywryyQ7/WI9IKkzjr4I6wHKhtP6L70hnPiWa
 CCINTd5JxKYvcYAmmGLYlNk7WmHGFpkSC+CtQpJ4SJuz055WRHbXI++8x0ib3+8wdRf6PQv
 Ad6zNw1+mgh6ZrOakh3SNWZrAEsrURz7Eu0pjiHwXQtG9d72B/Y01oy7kF1lBS7o+9ktFZ/
 wzERyGCS5N3BFNRB9nw0A==
UI-OutboundReport: notjunk:1;M01:P0:XtvAf2Qm7j0=;Payx9X9Gg8M5Uex38yT/iDcsqBl
 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
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2889
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/b725f4d0-3c8b-40f8-872f-c79ee0d74c30%40web.de>

>> Would you find it really easier to clarify known data processing challe=
nges
>> with the help of another SmPL script example?
> I at least understand th script.  But I don't kjnow what problem does it=
 raise?
=E2=80=A6>> @display@
>> expression e;
>> statement x, y;
>> @@
>>  if (
>> *    e
>>     )
>>     x
>>  else
>>     y

Repetition:
Would we occasionally like to put the found expression as a subitem
into another SmPL plus slice specification?
Will additional parentheses become relevant then (or not)?

Regards,
Markus
