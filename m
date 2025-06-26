Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896E2C77B7F
	for <cocci@archiver.kernel.org>; Thu, 26 Jun 2025 07:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XAlmZE5sqJznz1ZOVmY23rTj5suSZitJAP3G+ySumjg=;
  b=fEPQO0HU1EOqNGfcetImfta+j7ENsFzjQqwxFaM1NNLzOzjLHSEnkVTk
   W0mJ/y/tPcpvrp4V5Hp2T2qdS0wx+oiYGJJN2I/2b2fC4lSzbf8Xwe/sD
   d681kbtu9eXGGhj/G2HxxRUrtKsvb/+YTuz+ApxFnP67zxLclc76wGa4Q
   A=;
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
X-IronPort-AV: E=Sophos;i="6.16,267,1744063200"; 
   d="scan'208";a="229084400"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jun 2025 09:43:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 83E56E02E4; Thu, 26 Jun 2025 09:43:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0734BE02E4
	for <cocci@sympa.inria.fr>; Thu, 26 Jun 2025 09:43:26 +0200 (CEST)
IronPort-SDR: 685cfa1d_tdpB72U36LA7MigflVi7TBxvtPbNzAiLK0Tdr9FkjXOwn4m
 YdTjpXBEquOOTc92jwQdH2mjXXj0Xt2B7Q1ZZTw==
X-IPAS-Result: =?us-ascii?q?A0EzAADK+Vxoe07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAQGCQoEABlQzBAtJhFWPUIZfjw+Id4FVgX0CDwEDAQ09EQECBAEBA?=
 =?us-ascii?q?wSFAAKLcAIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAUIOO4V7DUkBEAGCBwGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBFwINOkQCA?=
 =?us-ascii?q?QMjHQEBESYBDwsODAImAgJWBgEUAQGCfgGCIQEGEAEDMgcNBrE8gTKBAYIMA?=
 =?us-ascii?q?QEGgVhB2EUfLCJYgWUDBoEbLgGFbIJkAYVsO4JZaXonD4FVRIE8C4J4PoJhB?=
 =?us-ascii?q?IFeg1uCaYImgRaCX4Juk3FSeBwDWSwBVRMXCwcFgSAQMwMgCjQUHQIUDRASD?=
 =?us-ascii?q?wQWBS0dcwwoE4I7HIMhgRuDf0YrT4IoAXuBAnxMGUGDXh4GbQ8GgSEcKUACA?=
 =?us-ascii?q?QttPTcGAwsbBj2TA4QJVwKZDa9iNAeCOIFmgWQMii2VPAYTL4NxAZNaDgaTA?=
 =?us-ascii?q?i6YVyKNZZYVhSCBagM1gVwzGiSDNk8DGQ+OIYQzhGCKKgGqD0E1AjoCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGIYYFrgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:HQpJEKuBk16nIll7CPkWrD5C7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:5muqsmFyDleAiSoKqmJD0xcSNOB5NUHv61PQfRaiGWFHRZusHAo=
X-Talos-MUID: 9a23:z5GGPQah9mhs3eBTtGXqvxNuJsdR0vqTJ1wMvY0kovWlKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,267,1744063200"; 
   d="scan'208";a="229084377"
X-MGA-submission: =?us-ascii?q?MDFh+Iuun/wqxrISQkIfPskEKJbIYjVhNO0VQU?=
 =?us-ascii?q?IJkwrhetKR2esIaqeuoL7bkDd7Jdqi4N7KwDSbAOKh7sohQ8jDZ9IrEW?=
 =?us-ascii?q?WkybCNgcVww12yY0/IPch2jIVOK/dGMQw15Ig2P1TXr3F7qHUfXQDLde?=
 =?us-ascii?q?p5OpF1uIgpi/keOi2jwszFqA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 09:43:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750923798; x=1751528598; i=markus.elfring@web.de;
	bh=XAlmZE5sqJznz1ZOVmY23rTj5suSZitJAP3G+ySumjg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bIyahW5mm2qpE8AFH5gjK/utL2agq9Z0N5YZDciofzckFEqc1P485V+T75hcIKN6
	 wP/BuhvfviuPSQPnxp/1cWTuo4QPkUul3fbcjQrml+SXPP26iou4aI22qujorODvc
	 +Crua7nLC+E0hSPzVaYFOVv4VibX2q9YZeUDba+H3gzpYOYO2GPX80uRILWXdMMdf
	 7Qc2+mtc189dG8afRHYHwyicBl/jEA9zRYz3uhV0259jFIhbSgiU60apnOrad5Czn
	 rFf+RQUXgAtblZIG6EzQRMSUDByyvMxFc5d6JKRCyv6QoLunw5w9qkmWSbpqi36PS
	 2EBM+umcUW8HhBJ27g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.202]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7QUJ-1unPVg3bhN-00yIXx; Thu, 26
 Jun 2025 09:43:17 +0200
Message-ID: <e52cb86b-01be-4560-a1da-a6b07108d651@web.de>
Date: Thu, 26 Jun 2025 09:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Luo Jie <quic_luoj@quicinc.com>, cocci@inria.fr,
 Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly <joey.gouly@arm.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Marc Zyngier <maz@kernel.org>,
 Nicolas Palix <nicolas.palix@imag.fr>, Oliver Upton
 <oliver.upton@linux.dev>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Suzuki Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Yury Norov <yury.norov@gmail.com>, Zenghui Yu <yuzenghui@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 Andrew Lunn <andrew@lunn.ch>, "Kiran Kumar C.S.K"
 <quic_kkumarcs@quicinc.com>, Lei Wei <quic_leiwei@quicinc.com>,
 Pavithra R <quic_pavir@quicinc.com>,
 Suruchi Agarwal <quic_suruchia@quicinc.com>, quic_linchen@quicinc.com
References: <20250626-field_modify-v6-1-200dffa38a07@quicinc.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250626-field_modify-v6-1-200dffa38a07@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0cV8rpMonBMa03MwBG5b9wDd3SivW48JmY+eNd/HyLgmaL/AP8S
 iAXAH9Uq8D9vY9wt+wRclCy3ivXE4uV8zlGCzmw7ySKxlkZP/2I270005Yy7gHXFEU78AMY
 U6qFt30HM15TWA6DjLuv3XHaVAf74gmX1iCyAsd9H+//EyH7lW/TK1UYSxD7B2+VZrCkgOe
 kJvCOI98NladPaZ9nhTWQ==
UI-OutboundReport: notjunk:1;M01:P0:MJqKDaA6sIU=;pJ+ZZbo0sKDE1wfR4GV5UWpoSAE
 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
 Z9jDK7UGhwdiWoeiQlzDyLgvT4Lu4mvA=
Subject: Re: [cocci] [PATCH v6] coccinelle: misc: Add field_modify script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2795
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/e52cb86b-01be-4560-a1da-a6b07108d651%40web.de>

> +coccilib.report.print_report(p[0], "WARNING: Consider using FIELD_MODIF=
Y helper on %s" % (x))

Would you find it a bit nicer to use also another formatted string literal
as a function call parameter?
(The recent code adjustment indicated something for the operation mode =E2=
=80=9Corg=E2=80=9D.)
https://docs.python.org/3/reference/lexical_analysis.html#f-strings

Regards,
Markus
