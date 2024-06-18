Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41472C27C4F
	for <cocci@archiver.kernel.org>; Tue, 18 Jun 2024 05:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2cZfhV69bKXAnsDNTsMS3rApQebdo17KRkQpojcknIE=;
  b=VmY2IhJtA2n2dJyRyGf+4fxv7WpvrNtPC060tP4RVYdnAdOlVwjDaTwk
   f/2gieRYOaHdVC4Qpp6EjIM6tzFJVUcTo/ytQ/wGFIetZX5cT4JpVOOH9
   7PUsMke47+kPsFXAEtVS4SJF7wO6v+GdmsO97TJkTpsCBVBj640jlk8Ah
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,246,1712613600"; 
   d="scan'208";a="171153387"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Jun 2024 07:21:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2B28AE02E4; Tue, 18 Jun 2024 07:21:00 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BE341E0131
	for <cocci@sympa.inria.fr>; Tue, 18 Jun 2024 07:20:58 +0200 (CEST)
IronPort-SDR: 6671193a_7kNVamHV6pT5GRWTD0BNzr/SyfbFtVYMax/9+VBOxSil5i/
 IhlVhHv+zIBQbjQwARliQTz0VTP5M3Wb4CMheBw==
X-IPAS-Result: =?us-ascii?q?A0EtBwBJGHFmh07ASNlaHgEBCxIMQIFEC4JEfAZUMwQLS?=
 =?us-ascii?q?IRWj0iBdS0DhDuPCohxgVaBQD4PAQMBDTkIAQIEAQEDBIR/Aoh3Ah4HAQQxC?=
 =?us-ascii?q?A4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4V0D?=
 =?us-ascii?q?YJnARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwINOkIBAQECASMdAQERJwQLC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgnwBgi8BAw4jBw2ub4EygQGCDAEBBoJn13IfLCJXgWMDB?=
 =?us-ascii?q?oEaLogxAYV8hEAnD4FVRIE8C4JHMT6CYQQBgV2DW4JpmVyMEiYLjQdUfRwDW?=
 =?us-ascii?q?SETAVUTFws+CRYCFgMbFAQwDwkLJioGOQISDAYGBlk0CQQjAwgEA0IDIHERA?=
 =?us-ascii?q?wQaBAsHd4FxgTQEE0QDgTeJbwyDL4F0J4QaCENsFYNugWsMYYgKYoEQgT6BZ?=
 =?us-ascii?q?gFLgwVNhD0dQAIBC209NQkLGwY9qheDWxkGAYE6BIIbkx6ySDQHgjaBYIFiD?=
 =?us-ascii?q?IohlScGEy+XOg4GkmuYZSCNVpsUgWYBOIFcMxokgzZPAxkPjiEZg2EzymVBN?=
 =?us-ascii?q?TsCBwEKAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
 nO6RjFGvFys1OWCmGMPuP9mtTtBwo6G7x0KBA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:rr7XQq0o1BfjYMORnuC5rwqjBGwkLtp133Aq2lEZdPUnSL39qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQU3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 JdmsNFeb7N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:jR9azW5ZLVlLQFadKtss00wpGc09e3vn03LBYH28FSV4V6yVYArF
X-Talos-MUID: 9a23:ZXpzgAYrER8J2eBT7S3jjStMbetTvKmSMx5TyZQN5vDbHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,246,1712613600"; 
   d="scan'208";a="171153383"
X-MGA-submission: =?us-ascii?q?MDH8IZCa09RO5TfPeo7YwLlmVYsLWlOFIJfqJQ?=
 =?us-ascii?q?swB0b1BO0p7djhuRqjXjWhQe1lzIy6c3lzGG54l+KwAB0msIQWxYVQLz?=
 =?us-ascii?q?EeucBfSMOmTlwSLBpMMDH066w21qvC8uEbOUhdX/zSYfDLUKXUHRVgu6?=
 =?us-ascii?q?rsz5PijVssEikkU3m5hnoPrg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 07:20:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718688056; x=1719292856; i=markus.elfring@web.de;
	bh=2cZfhV69bKXAnsDNTsMS3rApQebdo17KRkQpojcknIE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B0XhDEZ9Adh3oIN+nflW72y1yLraHdbgiErLW2L63E1+QqUnRjp3lMAERpshqae2
	 tHZFcWS2CGh7HvxsyFwNfDycDCxEG+LheqYSs5cNwF4rhYu5MqoJdMtDiIhhwoDLN
	 qMZqWE1fuomtdY2XKq2y2gKyimAsYDxTu9pbyRV73RXBD5BRq0+PNtrRebYvLiF1Q
	 kpS4vbohof3hSxLmFN5l1TLE5XsRc7u651PYnHFTkOc8FeV6Xsn9ThAYWGjvX6dPw
	 F7W0DvtxL5In5ehYhmlJKgj8ybxB/i+AhwWXZj9r4uRRj/w5eImvxCgPLbpsv/3nZ
	 WfM3N2koYosjmUXBbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnX1L-1skpzx0Y8j-00cVu4; Tue, 18
 Jun 2024 07:20:56 +0200
Message-ID: <f52f8bb8-1730-4f01-9b4a-71cff1c3386e@web.de>
Date: Tue, 18 Jun 2024 07:20:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Thomas Adam <thomas@xteddy.org>, cocci@inria.fr
References: <CAOhcEPY3QqNFMzfGT4Zy8We5Y0+SLaG=A+5YZ5+O0MZAkGEKhQ@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CAOhcEPY3QqNFMzfGT4Zy8We5Y0+SLaG=A+5YZ5+O0MZAkGEKhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UpTiOLnZvXgLEZDESpYZXUi+QraYLgQxjoNqUyO8ExBof6aYuL9
 V3LXnBfqH7MD3Qor42fOqVnoznSEow6fUSlW98mPgwJs1lIOoY795Lr8/WI5AyutYvTpgpe
 UZEkmW6WT0fozPwM/Crzw+dZ1iOQag3Uze2FnaVrHmoVCh1v3QCUSDcdd8tGoOXTvx6a0Cn
 /KMvwFen8A64neyaH9vCQ==
UI-OutboundReport: notjunk:1;M01:P0:q2r1b7kVqv4=;cvatSLVNmesq3E8MfFCmfmW4JKA
 Y8YyEdWdqIDcpezYF04Za973R1V7FYuicVtKzWYwB8lL/IVhCK9K32CTfsftmreaT55gRl/0y
 M0XqVMBdAMP61441Tcexq/HQ5IEcNjXk36DcU8NaJq2cF40rGayB5875WiM1Ef2PCadradD4L
 UdI8ZSU3DAl3tT0cAhvE9r9SZPQ4HD/p5UYWQQdlHAV8HgYmAEd3owO2DCWSwZqduoiwA85XF
 A0dAQLCSqfqsmBN7ln0vyFh5cznm5eskTdafBWBJ/LK1rMJ98Pd+WgQVQTnmA2QbEHqc9nY8M
 56mKf/rAPUqFUPlhzvbXVFdEdBaOc65eOEG03fqtHWoiTkMJwAzCH8xegnrBTcz5AXwamiBwB
 wBn8VpjJR43Jjo2wEoK2sXe/X8GI3Q4c+JRin6xWfZFmrakGS6psgBwME0WW7K7dotTae+OQ8
 W9CmyxjD01Sjq3g6jREFsSliMxOQTblsYs6lim8pqy354vao06bf9dC4hOU0VFCh6IWoq8Jvr
 P7y8P0e8Wl39wZDl4ZkwYYEpRl3Z06R4Ne0d4GU6JBGKTu4bpkok87MpLuohJX4baIifpQ+ee
 +48Mx7PKs7mb90fs2ZQxQh7m+h+OvN6tncpGxjajjcSi+ElkgtrZGdYJwZ1wX56knLeTifC4K
 yvVbLjgZm4tavxNFLBWUM6PqgQKK1XVUYsoYTeBMht9lc1+RDU/N5hVIuRgNpsxnMIgCOI1nX
 /tiHaUgiJzom9J/hrN0jfuZpYOXePzl3bs6Urmu2ahvP3/FWxBzB2OtIeGqQRNLToLR/Yu6OD
 dXKzFNFdQzshv6d7PRZAbcmUDjUDCl2WgMrYJGB5iuYp8=
Subject: Re: [cocci] Conditional handling of code blocks with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1794
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/f52f8bb8-1730-4f01-9b4a-71cff1c3386e%40web.de>

> Is it possible to make a rule to make spatch ignore code sections from b=
eing changed?
I suggest to clarify some case distinctions accordingly.


> For instance, say I have a rule to change calls to strdup() to xstrdup()=
. What I=E2=80=99d like to do is something like:
>
> /* start of ignore block */
> a =3D strdup(=E2=80=9Cfoo=E2=80=9D);
> /* end of ignore block */
>
> Such that, for code defined between those two comments, spatch would ign=
ore it.

How do you think about to achieve desirable data processing effects
by the means of conditional =E2=80=9Ccompilation=E2=80=9D?
https://en.cppreference.com/w/c/preprocessor#Capabilities


> Is something like this possible?

Probably, yes.

Which details do influence your desire to skip (or exclude) source code pa=
rts
from data processing with the semantic patch language?

Regards,
Markus

