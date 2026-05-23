Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7B4CD5BB8
	for <cocci@archiver.kernel.org>; Sat, 23 May 2026 16:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YzWNBBKkVQHQcVSJWpAPFHzcCB1LJY077Ho5bk0YwFk=;
  b=nmYz8S7DLuw858NemB1+kMxXHnQApUnBhawt3wiIWaBxOtcJLYnbNOTl
   nuF9XaC9NBclkGotddJMek5ErecfCDt7qXxY8Pul4tyOL5zSZdUCzeMIl
   Gv6Wa8YiFw44Gb5WHPnV9CgsA0/kC6eg4DdU3OYqY0fp0us2luzttd+Ih
   4=;
X-CSE-ConnectionGUID: RVwV02EcRZWhuB0SQ5gOUA==
X-CSE-MsgGUID: QqUy+1MWQ8y6Vkb2OHimvA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.24,164,1774306800"; 
   d="scan'208";a="277970257"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 May 2026 18:17:13 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7C78B83A11; Sat, 23 May 2026 18:17:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 793A483502
	for <cocci@sympa.inria.fr>; Sat, 23 May 2026 17:24:26 +0200 (CEST)
X-CSE-ConnectionGUID: puMeB1aoQo6pdnuOAeK+6g==
X-CSE-MsgGUID: 6c6lvbAtQMGyjzcBgm1IRQ==
IronPort-SDR: 6a11c6aa_zqF+KK7nPioAIj6aMrAdTGlq0EohjHHmyhAAUDx4LBTa/Wt
 rXaliC+mvBf7SBdhuVrXZMHwSVYNi1ijAx0Wgnw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F5AwBBxhFqgAMP49RaHgEBCxIMhFGBCF40BAtJCIRQj?=
 =?us-ascii?q?1OCJIQ7jxGIeoNSAg8BAwENSgQBAgQBAQECAwGEfwKNMwIeBwEENBMBAgQDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQE7Bw4KMYZPDYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QINOkQBAQECASMdAQERJgEECwsaAhgOAgJWBgEUAQGCfgGCIgEGEAEDDycHD?=
 =?us-ascii?q?QayZIEygQGCDAEBBoFYQdhNHywiWoFnAwYUAYEKLoVxgmgBhjGDRnonD4FVR?=
 =?us-ascii?q?IE8C4JHMT6CYQEDgV6DW4JpgiaBDIRcihlSeBwDWSwBVRMXCwcFgSNDAyovL?=
 =?us-ascii?q?SNLBS0dgSMhHQ8IFR5YGwcFEiEqbkpMGgMDDSE1WUE4CgFGBYFtAoIaTiMvA?=
 =?us-ascii?q?06BLYFvAgELbT03CQsbBD2LUBsPgxI4IYFRxys0B4I4gWeBZAyKL5U/BhMvl?=
 =?us-ascii?q?1IOkwqZBSKNZ5s3gX8jgVwzGiSDNlADGQ+OIQwWg2AzgQvFWUUyAgEIMgIHA?=
 =?us-ascii?q?gcOAwuFRAEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:xzouRqoZnyYxWWRuSWFNUYAaV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: 9a23:qu2WlmMN8JLIiu5DQDRC+WRNE8ccdSPFwHHNBGa1KiU3R+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AWzxmuA0+xH/iNLz63eF8kr7epzUjva/wDF4HuIk?=
 =?us-ascii?q?/nuaVNz57ETiY1RWNe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,164,1774306800"; 
   d="scan'208";a="277966893"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDH1PXRvdlJAM2370HOcoKoHbNC4VjMWPbA2F9?=
 =?us-ascii?q?sOgqwz3eMWcOVCbVmISB+RG57lOsZBAjunMIl2Pn5hMIFEnNcLPyPB1b?=
 =?us-ascii?q?qApWjCf9W0O5ZtURZwgCnvE8zaoWvNSUiP22+bi3bYCr+/GRF4+DxkM0?=
 =?us-ascii?q?xXiPSEq21zKKFXOGTLfQnP+Q=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 17:24:25 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Phi-1wUf1r12fW-00HPDV; Sat, 23
 May 2026 17:24:25 +0200
Message-ID: <cef99ad6-ecb4-4266-a674-2317554d31cc@web.de>
Date: Sat, 23 May 2026 17:24:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: vulab@iscas.ac.cn
References: <47a6aeca-6c58-4be6-9a4e-a1d6726b5a0a@web.de>
 <8397220-4b66-acd4-32e2-cfa72ee7ac66@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8397220-4b66-acd4-32e2-cfa72ee7ac66@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2TpSjY5t0y1v5yceA8KnDC0sNVUZvOaTsyw1w25gV5VKGSLt/YW
 UGJDuCMRXAJwSpm1HLsScHsalUdACtYfZo23V9QMp/YdkUrBeoR7WIfY4vrofckLhdacdfY
 rkKB+SHrFi2Fosw/6pbSFdEclmXJw6UGUb8FLfFPHbnzatbw+f90NrbhiotZiKSMtWwjTST
 3TVFrqZEbKzUlqtTiK4Og==
UI-OutboundReport: notjunk:1;M01:P0:Vjq8PR8tPz8=;tCKOiF0eEbke1hZWP4oXFYtXo2V
 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
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Checking evaluation of another SmPL script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3504
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/txXjqT7KAitZhNGM0pX2ug>

>> I find some generated diff hunks inappropriate for the mentioned source=
 code
>> search pattern.
>> How can such questionable data be avoided here?
>=20
> Due to the goto, they all look fine to me.  What did you intend?

Does the statement =E2=80=9Cgoto lookup_again;=E2=80=9D represent a jump b=
ackwards?
https://elixir.bootlin.com/linux/v7.1-rc4/source/fs/nfs/pnfs.c#L2170

Would it form a loop?


> If you consider that some output is unsuitable, it would help a lot if y=
ou
> would indicate which output you are concerned about,

I am trying again to clarify development challenges together with variatio=
ns
of the semantic patch language.


>                                                      and not just dump
> the whole thing and hopw taht the reader will figure it out in the same
> way you did.

Wentao Liang pointed only a single source place out for an improvement
according to the affected function implementation.
Thus I hope that the other diff hunks can trigger more desirable collatera=
l evolution.

Can the program parameter =E2=80=9C--no-loops=E2=80=9D have a bigger effec=
t?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d=
827b8b9627a841c85c9/docs/manual/spatch_options.tex#L373-375

Regards,
Markus
