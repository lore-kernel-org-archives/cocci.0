Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4ACCA1015
	for <cocci@archiver.kernel.org>; Fri,  5 Sep 2025 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LCAvWYHsBSFyqI2uNAKAmi52zNXLw+pNRZnW2lCla9s=;
  b=lTXNuJGhhL4QV7ry3QUM2XJrdJM+WgZLCUuY6Lxne4fuT+YVWLuj4ubA
   rrbktqdSCM5jPEetleFOQVW+GtsS+XIoL0/tSC7KW5AGhssMMNUcem0TN
   6xq3eJW/HBGktOul0izGkegnl+cWC5TF8BvR2Zpm/5UIlHwOctgm2AIQs
   w=;
X-CSE-ConnectionGUID: Vpc0/W0MRvuKcfERFLo5cQ==
X-CSE-MsgGUID: qQIEk0lkR/eHRHr2Bw8JOA==
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
X-IronPort-AV: E=Sophos;i="6.18,241,1751234400"; 
   d="scan'208";a="237689942"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2025 13:14:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4944FE0BE9; Fri,  5 Sep 2025 13:14:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BDBC5E0171
	for <cocci@sympa.inria.fr>; Fri,  5 Sep 2025 13:14:10 +0200 (CEST)
X-CSE-ConnectionGUID: o3tTPXRyTtu8bLFO4+kOhQ==
X-CSE-MsgGUID: lGKiRD0AQJmoE4zcLrOMww==
IronPort-SDR: 68bac602_Bb1OK6y7FF7Qlhch24WUmkfqWk2RHmYCkqWyRrLgYiETDd5
 823wXZ4OM/M6qq3CppqctZv9PoNaSEKpFiu7iIQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EEAADlxLpogAwR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYI/gQdUMwQLSYRViByHNIIkhDuHPIdViHmBV?=
 =?us-ascii?q?YF9Ag8BAwENTgECBAEBAwSCDIJ0AowpAh4HAQQwCQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw2CYgGBJIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBFwJHRAEBAQIBIx0BAREmAQQLCxoCJgICVgYBFAEBgn6CI?=
 =?us-ascii?q?wEGEAEDDyYHsjyBMoEBggwBAQbaXh8sIlmBZAmBGy4BhWuCZAGGJ4NCeicPg?=
 =?us-ascii?q?VVEgTwLgkcxPoQtFoNbgmmCJoEWg1g2giiJfYs2UngcA1ksAVUTFwsHBYEgQ?=
 =?us-ascii?q?wMqNDEjDzwFLR2BJ3mDB4ENg1lFK0+CGnKBdT4ZQINTHgZrDwaBFRlJAgICB?=
 =?us-ascii?q?QJDPoFtBhwGHxICAwECAjpXEIF9AgIEQkACAQttPTcJCxsGPZVvgjOBEnmCX?=
 =?us-ascii?q?MZJNAeCOIFngWQMn2wGEy+XUg4GkwUemGgiqR+BaDqBXDMaJIM2TwMZD44hh?=
 =?us-ascii?q?DO5IkE1PAIHAQoBAQMJhUYBAYwjM4FLAQE?=
IronPort-PHdr: A9a23:FtBqfR/xT+S/9v9uWUK1ngc9DxPPW53KNwIYoqAql6hJOvz6uci5Z
 wqHub490wSBHd2Cra4f0KyO6OGocFdDyKjCmUhKSIZLWR4BhJdetC0bK+nBJGvFadXHVGgEJ
 vlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+I
 A+5oAjfuMQam5duJ6k+xhbKoHZFdfldyWd0KV6OhRrx6cm98ZB5/yhMtf8t8tNLXLnncag/U
 bFXAzMqPnwv6sb2rxfDVwyP5nUdUmUSjBVFBhXO4Q/5UJnsrCb0r/Jx1iaCM8L5VLw5Rzus4
 bpzRBDnlCkIOTg58HrKisNrl6JUvAihpx1kzIHKZoyeKedzcbncfdMeQmpBQ9pRWilcCY6yc
 4cDE+wMNvtDooLju1UBswexBQi0BOPu1DBIgGP23bYn2OglCA3KwRAsE84LvHnSsd77NrodU
 fqtwafLwzvMYP1Z1yrj5oXWfBAvofODUq5/f8fK1UkvDhnIgkmMpYD7PT6Y0PkGvWiB7+pnU
 OKik2kppBtrojis28cskZTCiI0RylDK7yV5wYA1JdKlQ0N8ZtCrCoFQtyKHN4ttWM8sTGVou
 Cggyr0Hv567czMHyZo5yBHEcfCIbpaH7wvlWe2MLjh2mGhrd6ijhxau70eg0Ov8W9G03VtIs
 idJj8XBu2wT2hLc5cWKSftw8Ei81TiA1w7f9u9KLF41mKfGJZMswKI8mJQcvEnCHCL7m0T7g
 LOSe0gl/OWj9ufpYq3+q5OCKoN4lBvyProwlsG9G+g0LwoDU3KG9eiizLHu+UL0TK9Eg/Eri
 KXUsZTXKd4FqqKkHwNY1Jso5QylADe8ytsYmGEKLFJbdxKDiIjkI1TOIPflDfejmVitnilky
 OvcMrL8HJrBNnnDkLH/crZh80NQ1hc/wc5F655KFL0MIuj/VlLzudDCExM1LRS4w+P9B9V80
 oMeV3iPAqicMK7KtlGH/PgvI+qRZI8OojrzJPwl5/D0jX84n18dcrKk3JUJZ3+jBPhpPluWb
 WL2gtgdCWcKohY+TOvyhV2GSzFSaWy9X6Y45jwgCYOmDILDSZu3gLObxiu7H5tWZnpHCl+WC
 3voeZ+EV+8WaC2OOs9hjiAEVb+5RoA90hGhqBP1y7t8I+rP+iwYsIrj28Jv6+3SkxEy7z10A
 N6H32GDVWF4hmUISCQu06BlvUN90kuD0bR/g/FAC9Bf//xJXRk9NZDf1eJ3E978VA3ZcteTV
 lmmXNaoDyspQ9I0xN8Oflp9F8+sjx/dxCWmGaIamKKTCJMp8aLc3n3xKt5lxXjJ2qYvkUUoT
 9dJO2G+m6F/8hLcB5TVnEiBj6ikbLwS0iHV+GeY1WqOsllVXhRsXKvYQH4TflDWrcz35kzaT
 7+hF7AnMgxZxMCaM6VEctLn3h16Q6LBJdDfaiqVkni5ARLAkrGRaIvjPWEUwyzZDGAFlRoS9
 DCIL156TiymqGnfJD1oD1PmJU32osdkr3bua0YuzByRJ2Bl2aC0/BFd0dmVUfAOxfQpvCk7q
 jN7NEmw1ZTaBozT9EJaYKxAbIZlsx983mXDulk4Z8T4R0gDrlsXcgAt+ljryw0yEIJL184js
 HItygN2b6OeylJIMT2CjtjrIrOCDG708Vi0brLOnEnE2YOz870M9e9+hlHtpgCvGWI9/n8h3
 9QGm2CE6MDyBREJGYn0Tl5x8hF7o7/AZSxoworO1mB3d4SwvCXD3d0BG+YvjBqtLJ9EKK3RM
 gj0HoUBAtS2buwnn1/8dhUfIOVb77I5JeujcOaanrGmNqBskVpKlExh54ZwmgKJ/it4EKvT2
 oodhuuf1U2BXiv9i1Gotob2n5pFbHccBDj3zy+sH4NXaqBoGORDQW6zP826wMl/jJ/xSjZZ8
 lCkHVYPxM6uf1KbcVX82QRa0Ulfr2agnGO0yDl9kjdhqaT6vmSG5u34dwccfENPSnNji1jEP
 oW+ydwXHQCpYwUviBq59BPi3aEI7K97LmTVXQJJZ32sdjskCPHv8OPdJZcVu/ZK+W1NXe+xY
 E6XUOv4qhoeiWb4GndGgSo8fHess4n4mBpzjCScKmxypTzXY5IVp1+X6drCSPpWxjdDSjN/j
 GydI1GmPMSyu/iQmY3CtO+WSG+rEJFeO3qOr8vIpG6g6GtmDAfq1dW6gN76Ck4X1SHh1t9lf
 TrFplDwb8O4ssbyefIidU5uCljm7sN8EYwriYo8iqYb3n0Cj4mU934K+YvqGe1Swrm2LH8ER
 DpRhsXQ/BCgwkpoaHSA24P+UHyZhMpnfdizJG0MiGox6MVDCaHc67Ih/2M9h1Oirh/KJ9V5k
 C0cz/QG93MQxe0E8AYg1SSSBLkOEFIQZ3W20U7SsJbn8+MOPi6mavCo2VB7nMy9Ab3nwEkUQ
 3v/dpo4XGdx4sh5LFPQwSj244DgdsPXaIFbvRmVnhHcyulNfchozLxQ33UhYD275Cd2roxzx
 QZj1py7ooWdfmBk/abjRwVdKiWwfcQYvDfkkadZmM+SmYGpBJRoXDsRD/6KBbqlFiwfsfP/O
 kOACjo5/z2+EKDcABTZxUNotXPJHLi0OnvRKHRTnrAADFGNYVdShgwZRmBwu5cjFR2xguHlf
 l144D85+VPy7BdBgLENVVG3QiLUowGmbS0xQZ6UIU9N7w1M0EzSNNSX8uN5GywLto3ktgGGL
 XaXIhhZFWxcEFLRHEjtZ/P9gLuIu/jdHOe1KOHCJKmDufALHend3oqhi8NvrTOLK9nJIXRoS
 fE2kkMRWHdkB4HJlTIVVCUNm2TSYsTdqBrZmGU/p5K69+n3HQjo+I2EBv1NPN8p9x3+iPWGM
 POMwS1iIytc1dVVzHnEkf4U21t36WkmfmuoFqkc8CXWR6XKgukOBhgXMmV4M84A+as42kMl1
 dfzrNTz2/Y4i/c0Dw0ATln9goSzYsdMJWihNVTBDULNNbKcJDSNzdulKaW7AaZdiulZrXjS8
 X6SDlPjMzKfljLoSwHnMOdCizueNQBfv4f1ewhkCGzqRtbrIhOhN9o/gTozyLwyznTEUAxUe
 SB7aF9Ip6aM4Dlwh/JiBype43AjIeTF0yeV4u/EK4oH5PtmBiMn8oASqH8+yrZT8GRFXKkvw
 XGU9IQx5Qj51LDVmV8FGFJUpz1GhZyGpxBnMKTdrNxbXGrcuQgK5iOWAggLoN1sDpvuvbpRw
 57BjvGWSn8K/tTK8M8bH8WRJtiANS9rFBPzGyPPSiYBQySqM273mEFX1v2fvC7wzNByut33l
 ZwCR6UOHkQyDe8fA195EcYqJZBqQnU7nLTdgMNCth/c5FHBAc5duJ7ATPebB/7ifS2Ygbdzb
 BwN2brkLI4XO+UTNGR9Z1M8kImYQiI4vPhIpTB9KBA5qgNB/SomJoXW813oYEWh7S1LfcM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:djICoKBR1Mqla67lHel455DYdb4zR+YMi2TDGXoBKyC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:oBZ+aWO2Gc3fvu5DX3J7yHYkINEZbmCNxlP+BBP7CkFpcejA
X-Talos-MUID: 9a23:Dj0rywslLpwZZ3vRsM2ngB5BNf1Eu42XKkUKvMkUsO2eEglvJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,241,1751234400"; 
   d="scan'208";a="237689941"
X-MGA-submission: =?us-ascii?q?MDGPtBsYFDAtv34qkQnULNmn+NOYRKS3HqG3Tt?=
 =?us-ascii?q?cBti5I7jl7hV5I1qsYMCYK6gkSaiboGqkxZp/lc6U3/nCXiYjmdKRCId?=
 =?us-ascii?q?noTBTnU21x2yKSQ/cfmtClLeTe/nPQIw5TQcyORqnsfh3SAmzqS90lru?=
 =?us-ascii?q?tbPmtrHSBtvJNbA4mA0gW5sg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 13:14:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757070849; x=1757675649; i=markus.elfring@web.de;
	bh=LCAvWYHsBSFyqI2uNAKAmi52zNXLw+pNRZnW2lCla9s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=o96GCiO2042VlA8gMbN9qtejHZo2gVbsGPRLx+OEN4cmWZuMFsRnQP9TuBKU07l5
	 lQXmSqgxy8KTli4JEvNBliEkK/Q6+Tk2Vzp4p6L9AI5p2ufebK39tKnvLmAwaRynq
	 TQjR81NNYlrmPvVdd/md2/eWTO51uG56O6XukTm113vuI3DJIHxpxd74fUFhgUCOm
	 bQDN9q6z2HMzTdzf6bF5dxZDjNLi7Ow9t+G9Gs7iLrUXdzuHDTsDCzuZ4RQGCjgHg
	 jzoieZ/AonBd9200tnDv0czTnqUEi8fD9sOEYdLyggRNwpzNlhbphPMZrm+w5GR6C
	 KxfGkF1mQwLVVAxHow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.210]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrPV-1v7MRu1eFP-00NPYm; Fri, 05
 Sep 2025 13:14:09 +0200
Message-ID: <b22df436-7bf1-4909-8150-03b65f657a60@web.de>
Date: Fri, 5 Sep 2025 13:14:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <ba6b7f45-6c59-4ad1-9b4b-a02f34036d7e@web.de>
 <a00a59b-3079-d55c-eaf6-2db4c14f92a3@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a00a59b-3079-d55c-eaf6-2db4c14f92a3@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3dhC7ybqmL23njrt7UT/+4qc5TQDxWVEljRu2NXnAQpARWq3REP
 jlgbJ0TmHVR/07ZaVe/2nWLRQDd34qKISz+7M/d/M5u9H5izkluIYIEk/uAqat32jXmvfxh
 nO/HheGU7lWfkUu1Sjz4stipvBJQSs+JkAgODiJhrh5fmirRr65xt6rI5jty1SAstGhaKG8
 FGrT4d5LHjCoSj+7bISbw==
UI-OutboundReport: notjunk:1;M01:P0:DrOq0z8AcYU=;s9FI7dbLSEfELAA0XS4DA0C3Fhd
 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
Subject: Re: [cocci] [RFC] Sharing data processing resources for selected
 SmPL scripts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2995
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/b22df436-7bf1-4909-8150-03b65f657a60%40web.de>

>> @display@
>> identifier action;
>> type t;
>> @@
>> *t * action(...)
>>  {
>>  ... when any
=E2=80=A6>>  }
>>
>>
>> I interpret such a search approach in the way that it should extract so=
me data
>> from a lot of source code places.
>> Thus I imagine that it results also in special software run time charac=
teristics
>> which matter especially for big codebases like Linux.
>=20
> I guess it would be quite fast,

I am curious how such development views will evolve further
(depending on the data processing environment you may use).


>                                 because it will just find the deader of
> each function.

Header information should be found for several function implementations
from selected directories.
If you would dare to try the shown SmPL script out on the complete Linux c=
odebase,
a huge diff output will probably be generated.
It might be more helpful to try it out on a few header/source files
with a more reasonable size.

Other data structures might become also more attractive for the storage
and documentation of found pointer types in combination with known functio=
ns.

Regards,
Markus
