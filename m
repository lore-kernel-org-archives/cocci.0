Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC16C3DA64
	for <cocci@archiver.kernel.org>; Sun, 28 Jul 2024 07:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xzD4KxQ1FyOh3/YSnAI3WpRrsHk95goMt/zzRj1/OuA=;
  b=kZh8eqSeumHkj/TWLYQgx9oGlscSJl5tr3xLHNxuVB6yIogh0nUzbOmw
   aVK5g40gz3Hpg3xlW6ReHE/7qkZG53N+HK9geKz45fZ5pp9EqcdOKzRur
   7zdipKog7V8xtVGOh2EXU4rAvemUhI8og7WvWIkNqRXNKG/N1h1VBsI9l
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
X-IronPort-AV: E=Sophos;i="6.09,243,1716242400"; 
   d="scan'208";a="177251532"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jul 2024 09:20:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 000EAE0141; Sun, 28 Jul 2024 09:20:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 59C4CE0035
	for <cocci@sympa.inria.fr>; Sun, 28 Jul 2024 09:20:17 +0200 (CEST)
IronPort-SDR: 66a5f131_usp/lJ0MNZBFFD47ooCPDs/uRZNNAMvEEClWLu8wUq9mszG
 63Y0BliKK2D92nRQL4aAX7MbKds8TowCG/Clg9A==
X-IPAS-Result: =?us-ascii?q?A0EWAACb8KVmhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDgVYzBAtIhFaIHYcugXUwhDuHOodRiHWBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwSCC4J0Aok9Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBAToHDjuFdQ2CZwEQgRKBJgEBAQEBAQEBAQEBAQEBAQEBARcCR?=
 =?us-ascii?q?0QBAQECASMdAQERJgEPCxoCJgICVgYBFAEBgnyCMAEDDiMHrE6BMhNuggwBA?=
 =?us-ascii?q?QbaWR8sIleBYwmBGi4BiDwBhg2DTXonD4FVRIE8glIxPoRDg1uCaY8cgxCCH?=
 =?us-ascii?q?4NHcoUjJo13UnscA1khEwFVExcLCQWJTwqDJSmBSyaEGQiBLRWDZIFrDGGHd?=
 =?us-ascii?q?mKBD4E+gV8BSYJ4SoNnHIFlgSQdQAIBC209NQkLGwY9phmBFoJoxWU0B4I2g?=
 =?us-ascii?q?WKBYwyfTwYTL4Nyk0oOBpJumG4iqHGBZzqBXDMaJIM2TwMZD44hGR+DdcwKQ?=
 =?us-ascii?q?TU7AgcBCgEBAwmFRgEBg1qBSgEB?=
IronPort-PHdr: A9a23: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
 /DKk7/vbihP+ZTY8JlEbyAxAN2KOjwtPEixcAM=
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:Og5vz6pTtitTIz5XPLqTKc0aV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: 9a23:ddESl2y3s0C5MxABeA6oBgUrPJ0lcXTW506XfVXiAGJmVoKbVm+frfY=
X-Talos-MUID: =?us-ascii?q?9a23=3A2acuqQ8lp4mgPfgAc7HmrTaQf/w3/avzIkESrYl?=
 =?us-ascii?q?cvserCHBoKSfC0A3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,243,1716242400"; 
   d="scan'208";a="177251531"
X-MGA-submission: =?us-ascii?q?MDECoUZrBX6OcvOQ1fWKC2YAPszlfHvllqs/HS?=
 =?us-ascii?q?AcNX0TEGmQs9SSMbI3KZuwOwkTZ3bJ9xQnl5RGHOEGI9ZGx4peqWYJz9?=
 =?us-ascii?q?LOMj0XL7n2h5IB3VnXEslQ5HQ+zCmUXFb/FA1ONBQtxfFk2S7hByIM41?=
 =?us-ascii?q?T1d8OxnuKRfRePNCI984wtVg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 09:20:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722151206; x=1722756006; i=markus.elfring@web.de;
	bh=xzD4KxQ1FyOh3/YSnAI3WpRrsHk95goMt/zzRj1/OuA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gZrPWrmAwT9meD0F3PpmS/endXmQLCpi2+/6n1j0OVjad5yt+O5FKo/y6b/u3/ds
	 pFSmMeEN8zJtGepGVAUBcVNtXJj0+or2qLFutv6+OPWXL0xYft+SsiU7Bfvol/2+R
	 DGfYCmrjgj7fMk0nSgbI+P2s6WJm5WQPz4XmcCCgAM7IqMlWO0RV/cwa7SncI7GkX
	 gs93R9heaPeuy980xuATwv+hX7l2pTDkdK09Dt2OOHzhJksEmopHK6TMbvC6OnEEt
	 y77/HK1ZzVxrhRnQRqHE+r4IFewb8QsKrCaJcYz3+HJFbtbgcwQ1NL6o+HrBCGseE
	 moecDezUzEgXGUiH1Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBB86-1sQnii0X6s-00HOkv; Sun, 28
 Jul 2024 09:20:06 +0200
Message-ID: <6619fd74-fea1-4ccd-ab69-fab324c4917e@web.de>
Date: Sun, 28 Jul 2024 09:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Chen Ni <nichen@iscas.ac.cn>
References: <959b8771-76a1-4cee-a7b1-2b391deb23cc@web.de>
 <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr>
 <74d26d15-2c7f-49d7-8081-3fdaedcac273@web.de>
 <alpine.DEB.2.22.394.2407271844070.3211@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2407271844070.3211@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZKAL5aN8S1Kp/FVWhV1FK8oSmJodxRgYTsvha8x9unbCm84SZWm
 R9FOHkg5cpifVduOsx+autQzOgXsUjFS60Q6tfOxyIT255Hr6q1085EHLueF2SiyZ4rqOz+
 iwMxpQ98quWUzacAlD4honHzbo8ndM2mcTOAcc6RMO6+KDpix+fB0glEcN49/xb6cV/bsNX
 3rlj5MkanokvzW8pvEh2Q==
UI-OutboundReport: notjunk:1;M01:P0:3Hwm7Mj73WU=;ll051NFzdXeVOzk/v0k3mA4JNrG
 fbACrsJyAz6xcNRY9vTwlhlS5dg22Oh+IDVLWpUE2GaR5Z+nEUR15pdj06Epx5H3LgXrd0Pn7
 rAZZAKE+nmQDmZR0gmjlFA4KcfonUg0HEgQ1lXnP0ZoGJH2yHB685E8x4ijiHE4RcnuSHpF5U
 d2oB4WO+WBk7q8ZZDh9RJN/tDCjWqgoK28oe8Nv7BTwjIvFSjDGZSZTPMpKz4TzHMMphILcWQ
 ri2h23TUcoVGC2YbGAPRBljyBmvuP9+MUcgQ4J50nahFMl7PHw+yvwqFScBGlBMk6ovFYCjLo
 caLRINOd7NtOkVfuQjejqw+vwOQhefBrf9i0yBJS4YlO90lIB39VUsua5QTPC+vBCNAGLRTnV
 d5av1VaJJ0b/srQi8f+M+ep/JrFerTOLKSy9HUEQoqthaWboe6TJwjeNqcjGEeeKR1HzzKnkL
 mAoCidE0GNF3qdJeCGJiVZfuln4+T7sLJbwDbzZERET2tsIE1CfNsaFpiX3S3qO+5TbQ6Ef4Z
 25D/iK8CCrW61PIOT6a/+b2DVxLExloUq2o+wY2VxVzODcBdvRajBS051wM4zNbzjR3ryWeIM
 U6i2fGjKfVcLM1lJR4dLmidZluiRaWFIx8Rnq0ItSMKFsEtUZPldgEaSOZkOHg4VSV7qyS249
 VvDCbE5SoGiPzSSLIRHmAfb1Dy/WC2B7rzM856esPgKTHY+FOcqUpmTgaNxti4IPqeTVyjnoO
 k60MArAShyCU1KAB7uKJheSFuIQ4D328cPnAeUXXGKI1xJt63lWDQTPAHKejRcqhIbZpuz/24
 +CcJEAItzbNtN83j09kvStCc43hHGLg7zrc32pd6ARJZI=
Subject: Re: [cocci] Code adjustment challenges according to the comma
 operator (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1827
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/6619fd74-fea1-4ccd-ab69-fab324c4917e%40web.de>

>> I would like to point out that such a simple source code transformation=
 approach
>> found 156 files from the software =E2=80=9CLinux next-20240726=E2=80=9D=
 for possible updates.
>> Will further collateral evolution become interesting accordingly?
>
> I think that you have to look at the examples and judget whether the use
> of the comma operator is helpful in each case.

Would you become interested to support the integration of another SmPL scr=
ipt variant
for the coccicheck tool?

Regards,
Markus
