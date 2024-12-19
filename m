Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD36E77184
	for <cocci@archiver.kernel.org>; Thu, 19 Dec 2024 09:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fBkdN24c7TFwR68QHtCzVXhg12Q/kCT36eZ/C0S81MU=;
  b=UG8M8grfRf3pxtYBQk6ll5kD3MwpaWdRxkWpW1S+XjP1pjgyDISQ6m82
   nw/QdRP6yILvcqohXKld9mvgtnPWUbGroVqgXaM0g4E7iDxGBqqEzL3OV
   PZMOFNqRgCDZv4Dls55oUTP9161wbS4GB+BEY9r5N15UJNXVfXD1zKMvW
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.12,247,1728943200"; 
   d="scan'208";a="200006334"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Dec 2024 10:53:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EF35CE0D1D; Thu, 19 Dec 2024 10:53:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8D2C0E007A
	for <cocci@sympa.inria.fr>; Thu, 19 Dec 2024 10:53:10 +0100 (CET)
IronPort-SDR: 6763ed06_39aA/a/xsJpjs3hNQ8nfjKsc3zmYJmvm/AGbZnVp1PU1c+N
 H6NZ+RGsjNU72spbW5NJdMDjFmlX87OWlDW+8HQ==
X-IPAS-Result: =?us-ascii?q?A0GGQgAc7GNngAMP49RaHgEBCxIMQIFVgkKBA1QzBAtIh?=
 =?us-ascii?q?FaII4cqgXQwhDuHO4dWiHaBaoFqDwEDAQ1BAQIEAQEDBIIMgnQCim0CHgcBB?=
 =?us-ascii?q?DUFDQECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7D?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAhEVAgJWB?=
 =?us-ascii?q?gEUAQGCfYIwAQMOIweze4EygQGCDAEBBtpbHywiV4FkCYEaL4VqgmMBhiaEP?=
 =?us-ascii?q?CcPgVVEgTyDAz6DfIEGgxyCaYI+gieCI4EvZ4gThheCGCh7jERSexwDWTIBV?=
 =?us-ascii?q?RMXCwcFgSkfKwMuNjGCBYFbBTdHOoIQaUk3Ag0CNoIiJFiCTYElBAWBLYI9h?=
 =?us-ascii?q?GGEV4YagheBaAMDFhIBgS4dQAIBC209NwkLGwY9nXiDJYNCjj2XFKE6NAeCO?=
 =?us-ascii?q?IFlgWMMmFaHBgYTL4NxAZNRDgaSeph7IqNFhUOBfyKBXDMaJIM2TwMZD44hh?=
 =?us-ascii?q?C2/OkI1PAIHCwEBAwmFRgEBiiRqYQEB?=
IronPort-PHdr: A9a23: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
 m3eo4w2y7lDuvaCwHxrXUgWwgs=
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:5udfOauhcedLQOM7ZtEr39cc7skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: 9a23:xtuR/Gxcm9FOxEo1qqFLBgUVQcwKXD7dzUuTYH7pEEhFYpbPdkGPrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3A6QBoBA4k89aF9leLT8SuWxiHxoxMyIH1JG8Qtq4?=
 =?us-ascii?q?qlOymEG9uOxGFkxioF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,247,1728943200"; 
   d="scan'208";a="200006306"
X-MGA-submission: =?us-ascii?q?MDEyL/Rt0lN/dvj4CZbLye7qGC3QwiMXjLewD4?=
 =?us-ascii?q?7EN1qab6fAt70su5RsECAXGRAo2/Jhhp4adzbti5T1F+ichCdgWsadEt?=
 =?us-ascii?q?i7dbV/NXlOWHPJvmQzDbKBXrVxLa5pH4D0ndcdmKHnH96UGw4xByWGkk?=
 =?us-ascii?q?X9dscpjAnxqTKXXqe+ci4fcw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 10:53:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734601989; x=1735206789; i=markus.elfring@web.de;
	bh=fBkdN24c7TFwR68QHtCzVXhg12Q/kCT36eZ/C0S81MU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hc9sT7AMjzUB9by2JEATrDZGup6Yahnaj5QoguXVTl6Vumrcu0Z8+N9KsJ9Tat7Y
	 d313GnEzJy4d5hadpmoQJ/s7maq0PpyGxR0Stmis/mkEZ+xx1im8Yr2cU6OsdP2Hr
	 2sKplUUNNxsLQJ30QkbQqK+wKzV1DWzMPjb2g1qmoMvAjrHghD+Jj18kI43wdHX8w
	 yj7pnZ2rZAtobaBCttNggA7HO0LTY91hcWFhBYrAGxToTYzFWHRrwL6VqkycHLZzu
	 fC5nuoNg5Ip4PF8Q9FJVxSdhaCYZQzEgckkhVEZX0F0s9/yHK08Mxd7/BaOjHiukY
	 wLMg/NISiAp5+nly9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.70.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeDMR-1txXpi1pmZ-00fqJr; Thu, 19
 Dec 2024 10:53:09 +0100
Message-ID: <79ebcaff-826f-410b-91c8-7659942d9f56@web.de>
Date: Thu, 19 Dec 2024 10:52:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mats Kindahl <mats.kindahl@gmail.com>, cocci@inria.fr
References: <f0764391-b0d3-48fa-8a54-6edddf8d2c8d@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f0764391-b0d3-48fa-8a54-6edddf8d2c8d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:MZ4LixMTbStsbqGlvh5fPaLWMAdRdqDIYrBMEMnIL5aLHSirrsW
 Tp7hLl5xQaYF43DbG64Ge0jpC7YqikVc/ko/uAjHPH2D3kKh9fELh2+cLqUtGm1NIZ6y6Ml
 IllmjuSrwlpgF8GQ8DkUfY5gAlC4wV+hRgZrlCM+wcRecJjHu+6JLNf8COJL9E4wCpPF/SZ
 pRrpgtGAl5lGG/0Zw0k6w==
UI-OutboundReport: notjunk:1;M01:P0:40ZKJUJUBmg=;eHFV7J3WbunNz5ZcBQvtLvVCuzA
 O4A9xd2747h8THRQQ26X5RWILpuvZKs75p6PDWpcsZzfBL084kttz/MzlAwCbj54XHEWf2Vnf
 d454SIA2lH2OUkE4clKbxrQgmYND/j1HXZ+aEBqn2GCeLNq11/TGWZz8I2Tt+C7gN1ldabFAE
 VvqZDi6nmsCEU52EwMhDe26YwUwdYpLCBo7Rvt6qOd4wZSqga3xsls5j3iKZ9FQYeKOt4pUm2
 rIzWrn5HNM9T8kLz/Hy6GArHcXaEm7cQ1QKNdVIxJvsfeBXjt7qYicsVeyPw7533VGtcea//H
 C0aywieaLnQJaTvd1ZJA8JjjM8ScxdRuhUWx9g35GTflzZtk0pq7Na+qbGdhyrGvjwOv9oLS/
 /sqz0oKvxh8wdIEDGhwXikihNGbAnwou2a54TIPU5KuXsmZC4CzCyJBrXyoJZclIIRbwWWeeI
 +j50EWBfAn0s6ppEbDbG5D2Ze6DmI4qwJ/k+iubvTBYi09h0V2d+UiZ7PZ8wX65DiyLkPms6W
 54UJKXCJJChoQ8Za9xgk19YYvd0WsLUN/GVyUn9j/HRyST64S75CM06ZsZrOFKpJEINcbpEyn
 7fSLsh2cuhrpIPo+TW67PLCSYPjCviyqQwUiR+5Adq67aGZZnKcY2SvwKvp0eYAJAUPPTjHV5
 TSny5DIzHA/QNq23lBjh5J9cgiNzqD3DGVnpHi3Kvt0oL3cSoHnkO6bJD3rq6FHPD6NcvZUIy
 9TMNGnY1fR2RQEL/wrsWO5xg5fEcN5osprWnrnHt7my17asfhOqtgD8QiTl2IIeAphdIpBUya
 gpTVGjDbyWHYjphPDn7kLPtlL6XDSjNPTCnVLCHT9cI7pHSMBvvmnhGHBQ39NXwe0dMk8pI73
 UWtGZlKsIt2u6i8zlYelr2eVGYLWar3WQSRyjpGMoDMkLDGJ1kFbRP41W6EoGnpNOaqOqqcUj
 rumEJPrHpvhHuRQsgruhGwTaHguVeFbpip2qtI+FrQ6G+wIWZIHFe3a31/u5vvUxqFvmYxgkK
 MrCfxOfBfdquvygBrOBxoYkdzQx37dKzuqPfFyRG+znLudAkps93OWD2j8Th2zAXImsm5UuW+
 TjmQeImsQ=
Subject: Re: [cocci] Detecting missing resource releases (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2186
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/79ebcaff-826f-410b-91c8-7659942d9f56%40web.de>

> Anybody have some insight

Probably, yes.

Which information sources should get more development attention?


> into what I've done wrong

Some circumstances can make your source code analysis attempts more challenging.


> or if there is a better way to solve this problem?

Further software design possibilities can be taken better into account.
How will technical aspects be clarified accordingly?

Regards,
Markus
