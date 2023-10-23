Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F535CDB474
	for <cocci@archiver.kernel.org>; Mon, 23 Oct 2023 06:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/ITTznk3u4J3akdg8pi68ODTLEVlIHnklCV4/xJALpY=;
  b=VyJaYp34G0vz9nwZHdJpMN5mIW0dv6Y1rXH8PNoyHPC1MhmWo2Jl2LA9
   mY6WkOszH8G5ho59spXm6QSS7nle8oiXFv7FpS4Unx7Bkear+/GJzF4TZ
   WVg27B1UFdOm2mXUx7ZUEa0xcYgvqihttUzUQGAglm/CweRyTy9l5A1Bs
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.03,244,1694728800"; 
   d="scan'208";a="132601667"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Oct 2023 08:56:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 41A05E0205; Mon, 23 Oct 2023 08:56:07 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 319F0E00B7
	for <cocci@sympa.inria.fr>; Mon, 23 Oct 2023 08:56:03 +0200 (CEST)
IronPort-SDR: 65361902_cGEmN+vX+7DAlq+hPKgS4Qz5/7c0n8d6Cx4qHjvZ32nnOmf
 C/lSOJJnOA6waU1XYhYIvmSt/rGpqgdlpB0TGdg==
X-IPAS-Result: =?us-ascii?q?A0HoAwDfFzZl/wwR49RagQmBT4I5B3MDUzAEC0iEU488g?=
 =?us-ascii?q?XYwhDuOfIhvgVaBQD4PAQMBDTkIAQIEAQEDBIILgnQChxcCHgcBBDAJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQKBBhOFaA2CNysBEYEMXwk2A?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBARYCPQpCAQQBIx0BAREnBAsLGgImAgJXBgEUA?=
 =?us-ascii?q?QGCegGCKQEDDiMHDbEegTKBAYIJAQEGr1QfLCJVgV8DBoEaLogKAYVRhDUnD?=
 =?us-ascii?q?4FVRIE8DIJHMT6CYQICAYFdg1uCaIN1l0FeIwVCcBsDBwOBAxArBwQtGwcGC?=
 =?us-ascii?q?RYYFSUGUQQtJAkTEj4EgWeBUQqBBj8PDhGCQys2NhlLgl4JFQw0BEl2ECoEF?=
 =?us-ascii?q?BeBEQRqHxUeNxESFw0DCHYdAhEjPAMFAwQ0ChUNCyEFVwNEBkoLAwIaBQMDB?=
 =?us-ascii?q?IE2BQ0eAhAaBg0nAwMZTQIQFAM7AwMGAwsxAzBXRwxZA28fNgk8DwwfAh4ED?=
 =?us-ascii?q?gMZKx1AAgELbT01BgMLGwY+AiedCANtgmSBQVQnZAs1xQI0B4IxgV6BXwyKF?=
 =?us-ascii?q?pUNBhMvhAGMcoYqDgaSRpg8II1FmmyBYz2BWTMaJIM2TwMZD44sFoQJhGGKZ?=
 =?us-ascii?q?z81OwIHAQoBAQMJhUYBAYNagikBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Imw
IronPort-HdrOrdr: A9a23:44dehqF73xAAelEnpLqENseALOsnbusQ8zAXPjNKOHlom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4xgPM
 xbE5SWZueAbmRSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: 9a23:G7SOdGAqdl//l6n6Ewk8+FIlO9IgTkH63nHBOG6HDD90Q7LAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AvEEJXg1AIl9goWkNS7Qu8bqOPTUjx7aDUl0Njso?=
 =?us-ascii?q?968ypCgJ8ZDi70h+Ha9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,244,1694728800"; 
   d="scan'208";a="132601655"
X-MGA-submission: =?us-ascii?q?MDENlpZ6l/z+TUB2bVoYsvRnv7uanf+ccEQhn8?=
 =?us-ascii?q?JZqQwiFYik7fqFSiIYX1jMbw//nSkl+t8Xl/ASH24Dq5s4+MQQI7hY8O?=
 =?us-ascii?q?1O4uC5rVYExXaSpQKKLn6vd/oNkfa9xE3ndFacF55tg+v8FBZq0rx13H?=
 =?us-ascii?q?/BGKtXZBu9AMC47fqOqPdeXw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 08:56:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698044153; x=1698648953; i=markus.elfring@web.de;
	bh=/ITTznk3u4J3akdg8pi68ODTLEVlIHnklCV4/xJALpY=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=E65tq1yosUrH2Un2vboOJVGkBImK9s2qTDunPwe1SJtUCegzUEj/US7CU3JNeaxN
	 XLTwkN1LVpxUQWDDgPvF4R0e3FhHmCoCnSGgW0ZdV4obfjR3wsRSU4US6gZbRjlkG
	 7cw/YCP1Iiiqw9F8DtKAK8x3m4DOr5t9GR1tS4M6U+bBjThbXupjryZpMb4IpCUZ9
	 dKhzFj40+8fAMpY6cP1drFTWdq8Xu1qJI02+3eJkJY3vNWInNLUSb9Hkj3SSlBc61
	 Hqhmh1cOODcy4QSlWDMQRqZWtVXITKg16u4s7v7/9dVONOPKwTUTPdnwxkcQmiFrs
	 7Ra5RFYHFS6CJaCDdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfol-1r55pU1Ojl-00U8Ox; Mon, 23
 Oct 2023 08:55:53 +0200
Message-ID: <f47f0ad6-7827-45dd-af1c-6b315642951c@web.de>
Date: Mon, 23 Oct 2023 08:55:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Martin_Schr=C3=B6der?= <info@swedishembedded.com>,
 Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <CAEqMKof5Ke4yV0KBZm2FW8z-Ct1UHZRDz5=Sd3gaO3a-f4+y_w@mail.gmail.com>
 <6213b47a-3ae7-d316-b1a4-8fb5d3bf9b5@inria.fr>
 <608e77e0-a36d-44ef-a2fd-9c0c50cf61b3@web.de>
 <CAEqMKoco-UjiPu4bwm69t1HexJi0y+cCPEH6NZ10xZCfn36=5w@mail.gmail.com>
 <0352f48a-47e2-492a-a263-1916a7065157@web.de>
 <CAEqMKoeoLmEsxFsTAmF2TQv1DE+SeYgXEYh1OZdfC=vL=q+BoA@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAEqMKoeoLmEsxFsTAmF2TQv1DE+SeYgXEYh1OZdfC=vL=q+BoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YI5dYq3XWpEuRi7LCi6m7Gfdl15jslBqqkVURw2WKdZCa4E+AyW
 BBK4eOLvadYDn3Sp70tmccRniCCe4Wl8BsKntOZXE1NmzT5uB3LGMeFNgb292lYMtqmy9Vo
 loIRmuLuOUi8+NiOwDy2UoGh4Qd/D6D46QTDMWwJ6+I46Hk/w8q897BaXJ7Q0/YGxnav420
 mHFc3AkZRSzptF98rPnsA==
UI-OutboundReport: notjunk:1;M01:P0:EP0ueHeNJoQ=;bcVSR3cc+lWy9tBq6fwJIJTVxKX
 9RLg0as4TFVmsDbyU9drCH9MCdwyVCdARt8ocCg5GV+sl3dKkaNIMElLV8/I1ZLVshxZURrVh
 w3iUnlx8mctrbq7OKw5Bf+vPjHJXq2a72MyH26rmWQOScTTljCgD7Azwsv7+UYP7hLUSKljKS
 k0ORajXGPX+mPNyaeH2x3uzPDyJ23ejCDiaR5Auxyjx7YpvqPzBEp8mhdbW9bQm5B7nXuxqp5
 3qtJlENVxUQuSJIDcEgQlUGgXH+LGsLK9FwY5mEdt2MTsAnJHTHIsO1hQaB0GYLyA8AEBwmxU
 Y1VhX8Nk/m8knXczwaXeG8fbZoSRyvpHmx3opusx7ISP2DdySXAep2aPlt4r56KrBcyki0V9n
 Mxrj8gm7cZ/X281IA8+gUv1S1R3nD15jl/TihGn8yTLK7GI1/wfWo8f7fWGYlj2StG0szwABD
 8Z7zMwZyCTbXEi4SAD8TtPSEkqxIt5tgUhMYKBrzYxjx3EZScyKfRaGJttDOLom/wXgKbd7go
 UAAZBLUbHrN2AU496g69oOdTLHQ1mB9GzJ9lNVsIx1+CjDaT7AAeqmHa8YUKQl4EjMMmDPrSU
 VCOJDQnZuRTJT1Z/H1eNsdvlWOYPkRWVkHgo8M5NC+/4tlq0w4MQfQT2iF5sJlSJDjJpStQR2
 60MGFb7Acp6/d/EoVw/iB37UXHTohKKvXIx8K2U9TGiZO4KF5COS0OOivC+JJpkSt3RuFxlMT
 rW+/UiPiQBs93Gc4aKojdFtUpQrMyAoaR8dKG7mkOhHrJ70NVX6PcyqvlhdQEomQin1CEwTbu
 DZKmJHvhR0GmVcLXysLxCP4teF8Vs0iFT/JSSep6uY7NNj2GM+H3NiPSdDlAyKUcQqm8T1xWQ
 eLRW5BgXSxzm7HR3k8Qh6YsMWsNDVd6W1w6RUeTFTipHPXCy03/HnXsYdm3IUfdqb8hxixlqa
 A3XJ5SlQjqrz3LdyEW3TWHieNoU=
Subject: Re: [cocci] Finding functions that do not unlock mutex in the same
 function
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1268
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/f47f0ad6-7827-45dd-af1c-6b315642951c%40web.de>

> I explicitly want to disallow lock scopes that are distributed over mult=
iple functions.
> Instead, semaphore should be used in such cases.

Have you got any special preferences for locking primitives?


Did you get the impression that the proper handling of various scopes trig=
gers
further development challenges also for the safe application of the semant=
ic patch language
(Coccinelle software)?
https://en.wikipedia.org/wiki/Scope_(computer_science)


> Markus, how would you recommend using disjunctions?=C2=A0

Please take another look at known information sources.
Do any SmPL script examples indicate how desirable case distinctions can b=
e achieved with them?


> Here is my slightly updated rule:

I would appreciate further answers for presented questions.

Regards,
Markus
