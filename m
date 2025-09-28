Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2157DCAC5BB
	for <cocci@archiver.kernel.org>; Sun, 28 Sep 2025 17:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WKMCyS3jCeMTkJ4zg8ja5dS+2dWHBVk0U6vBjvU3Aew=;
  b=r67wh7BiufdmTII2JvsEVE+M5v658cC4J4bD7/xh/+GgGnSmuGXmDq97
   pxl8AXtFyzG3NZhDKwTQi1tmhuE8LIc9G3leKccw8KWUfxI2ICXXUUOkO
   Lp2H4ok5EGHnJ/liAIST/mbk3xWIECITrZSLWluAgSqvYk+7XBvYmPTH+
   Y=;
X-CSE-ConnectionGUID: 2OYteYKnQEOOkYVs8CPZaw==
X-CSE-MsgGUID: p2JEB3TnR8i3qwuNzOaTTQ==
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
X-IronPort-AV: E=Sophos;i="6.18,300,1751234400"; 
   d="scan'208";a="241387330"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2025 19:52:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 09F87E0BE9; Sun, 28 Sep 2025 19:52:08 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E570AE0171
	for <cocci@sympa.inria.fr>; Sun, 28 Sep 2025 19:51:54 +0200 (CEST)
X-CSE-ConnectionGUID: Gij6+lRuSOumXmREwxuYVA==
X-CSE-MsgGUID: 2cGOjJdjQeORRTjRnxf7WA==
IronPort-SDR: 68d975b9_U3YS8CnWQYx/05PIjJUd4hOMUnTu7Mah1xucvZJ2RHJrgS2
 IqN9xbELxeow+h/9Y0F657WGR9j3rFeeFkdkIJQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EDAADbdNlogAMP49RaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAYI/ZR0GVDMEC0mEVYgchzSCJIQ7j?=
 =?us-ascii?q?xGIeYFVgX0CDwEDAQ1KBAECBAEBAwSFAAKMRgIeBwEEMAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgmIBgSSBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CDTpEAQEBAgEjHQEBESYBBAsLGgImAgJWBgEUAQGCfgGCI?=
 =?us-ascii?q?gEGEAEDDyYHDbQWgTKBAYIMAQEG2l8fLCJZgWQDBoEbLgGFa4JkAYVsO4NCe?=
 =?us-ascii?q?icPgVVEgTyDAz6CShcEGIUhgmmCJoEWg1g2giiYLlJ4HANZLAFVExcLBwWBI?=
 =?us-ascii?q?BAzAyAKNDECFA0QEg8EFgUtHXMMKBJlgweBDYNZRStPghxygQB0PhlBg1MeB?=
 =?us-ascii?q?msPBoEVGUkCAgIFAiwXPoFrBQEcBh8SAgMBAgI6Vw2BeAICBIIvgRKCDwtAA?=
 =?us-ascii?q?gELbT03BgMLGwY9mDOEdwQrmF8BjiahRTQHgjiBZ4FkDIoulT4GEy+DcZNhD?=
 =?us-ascii?q?gaTBS6YWCKNZps5gWg6gVwzGiSDNk8DGQ+OIYQzhGCKKgG4YkE1AgEBOAIHC?=
 =?us-ascii?q?wEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:qaw7LaxvSs8BaZWaBdh6t+frwirEfRIJ4+MujC+fZmUNrF6WrkUFn
 GROC2+AOKyNamKjLt1wOtjgo0hV78eDyoRkTlM/+FhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliOfVAOO6ULOZUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDtEg06/gEk35qmq6WlI5gZWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x138FFtO/n7/nRVYBS7jUMBLmoiI+t3+K33CuDgRrukoKHKJ0hXV/011lrPgto
 Dl5jqFcfC9yVkH6dEvxZDEDe812FfUuFLYquhFTu+TLp6HNWyOEL/mDkCjalGDXkwp6KTgmy
 BAWFNwCRj+Chbz1xIimcc5xg/QmFuT0LJ4uhFg1mFk1Dd5+KXzCa6DN+MMewzo6wMxDdRrcT
 5BAM3w1NkuGOkAJYT/7C7pm9Ausrlz2aT5FsxS4oaQt4m7c5BN82v7hPbI5f/TTH5sKwxbG+
 TmuE2LRWBo1E969xTi8/1WWvNPNpyXrVt0tPejtnhJtqAbPljRIWEJ+uUGAif2wlUe6X/pNK
 kke4CNorK4o9UXtQMOVdxa/q3WFlgUNXsJZVew88gCEjKTOizt1HUABSSNdLsMrvok6SFTGy
 2NlgfvGBD4x87mvVEm667KkqAmfJjgIHFErMHpsoRQ+3/Hvp4Q6jxTqR9llEbKogtCdJd0W6
 2/TxMTZr+tC5fPnx5mGEUb7byWEirWhc+LYzgDQQ37j8Q5zIoKoD2BJ1bQ5xacQRGp6ZgDf1
 JThpyR4xL5UZX1qvHLVKNjh5Jnzu5643MT02DaD5aUJ+TW34GKEdotN+jx4L0oBGp9bJG+4M
 RCC5lsMvsY70J6WgUlfPNzZ5yMCkveIKDgZfqyKNoMmjmVZL17erXowDaJu9zq0wRRy+U3AB
 XtrWZ3wXS5BWfsPIMueRuAb1qRj3S1W+I8gbcCT8vhT6pLHPCT9Ye5dbjOmN7llhIva+lm92
 4gFaaOilU4FOMWgOXa/zGLmBQpaRZTNLcqm85QPHgNCSyI6cFwc5wj5nut+JdI6wf8F/goKl
 1nkMnJlJJPErSWvAW23hrpLMdsDhL4u8yxpDj9mJluyxXkobKCm6apVJdN9fqAq+KYnhbR4R
 uUMMZfISPleaCX1yxJEZ7nEratmaEuKgyCKNHGbezQRRcNraDHI3d7GRTHR0hcyIBC5j/Zjn
 I345DjnGcICYy9AEPfpbOmeygLtnHoFx8N3cUj6AvhSX0TOq7pVCjHDocI2B+ouKhzz4CSQ+
 CjLIBUfpMjL+5QU9vuQj4+6jo6ZKclMNWsEIHv+8pCNKjj8wmqv5aRiQdS4V2nRe02s8Zrze
 NgP6e/3NcM2uWpjsq1+Iu5N9r0/7d6+nI1q5F1oM1uTZmv6F446BGeN2PROkah/xrV5nw+Sc
 WDX8/l4PYS5Au/UIGQzFiEEMNvajeo1nwPM58sbOE/5vS973ISWWHVoYiWjtnZvE6tXAqgEn
 8Eap88k2y6ugEELM/GHrBxu2UaiE3gia5gj57YmWNLFqwxz0VxTQ43uOgmv6rG1Vth8GE0LI
 DiVuan8u4ph1nfyK3odKVWd3M52p4g/hxRR/VpTe3WLgoXkg9E07j1w8BM2bBhflSsf9+R/P
 llqak5HHoSV3jJSnMMYdXudKwJAIxy4+0LK1FoCklPCfXSoTmDgKG4cO/6H2VIwqUZwWyd9x
 66J7lrlXRLBXtDD7gFrVWFL8/XcHMFMrCvck8WZLuG5NpgdYwu9pJSxZGAN+iDVMeloiGLp/
 eBVrftNM4vlPistooo+OYmQ9ZIUbDumfGViY/VQzJklLFHmWgOZ+GaxchiqW8Z3Ofb131eyC
 JVuKuJxRh2O7nuygQ5BN5EcAY1fvaAP38UDSIPJNGRdkrq4rxhVirzy2BX6plcWR4RJrZ5gB
 KLXLymPA06Bt0tywmXtlvRJCkC8QNsDZTD/4tyLzfU0J8oDndxoIG4P0eqSnnSKMQFY0Qqek
 yHdaoT3keFz64ResLH9M6dEBgnuF9LXUd6M0QGssuZhacHEHtfOujg09HjmHVVyFpkAV+tnk
 Y+itIbM43rEm7ItQUX1poKkFZQV1f6tXeFSDN37HENakQSGRsXoxRkJoEK8FrBkj/Jf4ZOBa
 zajSc7ta+MQZchR9EdVZwdaDRwZLab9NYXkhCGlqsWzGgov6hPGIPyn5E3WQzliLAFQAKLHC
 yjwp/qKzfJbpt4VBBY7WtdXM6UhK1rnAaYbZ9n9sAeDNVaRg3SAh6DDkCQx4jSaG1iGF8fHu
 aj+fCbcTyjrmq/0z4B+ibdQ7y0nVCM3xaF6e08G4Nd5hgyrFGNMf6xXLZwCDYoSiSDoko3xY
 DbWdmY5FCHhRnJ+fA7h5Mj4FBKqbgDU1gwV+hRyl69VV8u3OG9EKL5m6zsm/Hp8PDfupA1ix
 Rfy5VWoViVdALkwLQrQ2hB/qfhqzLXWyxrkPGjjxtfqDU927aoijRRc8ckkacADO97AngPHK
 ADZgIyCrF6TESbMLCqrR5KZ9Nz1ct8iI/XEoBpjGOrihrg=
IronPort-HdrOrdr: A9a23:WUcn5a2XL7U/VqaC02pvHwqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:6Vigc2FO9my0EB7LqmJI9UxKWcQfb0b60XLgJnWVFnZ0eYO8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AAVrNBQ5RWG8o0buEWpLpiOpyxowy6IuJCmIBk6w?=
 =?us-ascii?q?LnPO+CS5KPSeT0wueF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,300,1751234400"; 
   d="scan'208";a="126758673"
X-MGA-submission: =?us-ascii?q?MDFLX2H8JlzcQH5uybE8A5GrJr6jjJrsrkeobc?=
 =?us-ascii?q?+Rlon38bBcDnRx/WIBkLH1Bs9R74fE7bJG13JIQoGakOdcl32HnwhTV1?=
 =?us-ascii?q?tcoWaRblDlqO7qML4TNL5+lsMW5Tm55xNuOVrYLQEaGQf52KQruu0QfD?=
 =?us-ascii?q?ufyY4H8fhdXBAGcoVuBn4A5Q=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 19:51:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759081900; x=1759686700; i=markus.elfring@web.de;
	bh=WKMCyS3jCeMTkJ4zg8ja5dS+2dWHBVk0U6vBjvU3Aew=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZY6ga6yfjUXspR/ETGHdoVVP04rac4VeOUmyLvoennKVWORquiVMG6MuhB8wh7Ck
	 sGoopK8QK2ng7f1CVGEesxPcdq3MiS6tSvlx5c3Cj+e9uvk1nh0+VIKYe+Sw7g4FX
	 kb4TueUe+A9psvc/uciTTifKI5y3obzotM6Zrj72rhkKwjDBJo8NbzR08k8KSIwtK
	 luAf7Rg+VmrqS9CZdcwGQ7MnVexXVaXUE/bKfbgFKvn0yAmjSTHXCJe9FpwPNrwI3
	 zqDta1tZP1b+rLTZxB/61/Mtz3AZQb13O791TNbZN9U/j+SomnM8uBSwnrR8ffCNq
	 E5rtIeNPuiX/NPgNmg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.189]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59n6-1v41UG1LqW-000Oci; Sun, 28
 Sep 2025 19:51:40 +0200
Message-ID: <99ea3145-5df5-4da0-9e3e-269c243f42d0@web.de>
Date: Sun, 28 Sep 2025 19:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
 <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
 <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
 <8b0034a7-f63b-4a98-a812-69b988dd3785@web.de>
 <7d46a1d1-f205-4751-9f7d-6a219be04801@nvidia.com>
 <5b8b05c8-91db-40a2-8aff-c6e214b1202f@web.de>
 <2c86405e-ae95-4567-b359-36c4dca1fa25@nvidia.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2c86405e-ae95-4567-b359-36c4dca1fa25@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0Vd5ev+1IUxNfq8rNbPYQUaHpaERCYaT/18K5Fl5szUxOuB0inT
 +mI148Cl6VZnXfcnRNC+vFG0wOkry3y+gu/2PpQW8EViv8fazPVzEuQXly+uycXqCVhnJ6E
 RK6YpIko9e3wvhjAy7/nED6l4ftiszDf/GBkicL7QJ7Tv4+PilIO4XeUANqTUv5EdwPVQJ2
 sNRifuNRUfsFeki0pDkPw==
UI-OutboundReport: notjunk:1;M01:P0:CpAuMkuyyEA=;NREyE8K8h+aSn0b6ExSYGWHOGzp
 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
 2
Subject: Re: [cocci] [1/2] scripts/coccinelle: Find PTR_ERR() to %pe
 candidates
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3052
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/99ea3145-5df5-4da0-9e3e-269c243f42d0%40web.de>

> I'm not really sure if I'm speaking to a real person or some kind of
> weird AI, so I'm going to respectfully ignore these comments..

Can you get more development ideas from another information source
than from hints by known contributors (like me)?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/coccinelle.rst?h=v6.17-rc7#n71

I hope that the clarification can become more constructive again.

Regards,
Markus
