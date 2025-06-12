Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7062BC61CE8
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=v/+L6f/1uHzWnn9d+9wYdEO6UW4NdjChdkgAdlxXmrg=;
  b=ea1Yo8x+ZW6ht3D+b/VGCvjDtI7CBuy7BTPJV7fEtPRt4TFGtBfvi5F9
   BS1HFCPkJ0q0FwYi1xv7uPQ5IHxzwtxww7u3j8iXPvOqZWWWaAW0wo74k
   B34QeYpkeZHuZVXnZpJ4sjDL4xAglDckKy+z9ezW+6rusW0lLkCTLIA7K
   I=;
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
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226935831"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 18:49:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8111EE0AF1; Thu, 12 Jun 2025 18:49:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 68779E0131
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 18:49:07 +0200 (CEST)
IronPort-SDR: 684b0503_K67dFywR8OypGS6d5jVaXDMJ2M7bXCERoszVAwLz0MS3LAV
 nat7wusHVXAT375DjAMNeELVH92FhS6//iSIXMw==
X-IPAS-Result: =?us-ascii?q?A0EpAAA4A0togwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCQoEAWjMEC0kDhFKIHIc0hl+PD4h3gVWBfQIPAQMBDUoEAQIEA?=
 =?us-ascii?q?QEDBIQ6RgKLZwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQE6Bw4KMYV7DUkBEAGCBwGBJIEmAQEBAQEBAQEBAQEBHQINOkQCA?=
 =?us-ascii?q?QMjHQEBESYBDwsODAImAgJWBgEUAQGCfgGCIQEGEAEDMgcNsHWBMoEBggwBA?=
 =?us-ascii?q?QbaXh8sIliBZQMGgRsuAYVsgmMBhWw7glmBYycPgVVEgTwLgng+gkoXBBiBR?=
 =?us-ascii?q?oNbgmmCKIEWhCSEK4E+gwlLgl+QXlJ4HANZLAFVExcLBwWBIEMDKjQxI0sFL?=
 =?us-ascii?q?R2CDYUZH4FzgVkDAxYPAYQCHINCgSOEA0YrT4MigX9MGUGDYR4Gcg8GR0ACA?=
 =?us-ascii?q?QttPTcJCxsGPZh/hSqBTZc/Aa9eNAeCOIFmgWQMii2VOwYTL5dLDgaTAi6YV?=
 =?us-ascii?q?iKNZZYRhSCBaDqBXDMaJIM2TwMZD44hDA0JhBGEYLJGQTUCAQEMLAIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYhhggaBSwEB?=
IronPort-PHdr: A9a23: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
 JdcEtezu3QqG/lcBkk3RbQ/
IronPort-Data: A9a23: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
 YT4qa6oja17pYPM/R5cRkNo
IronPort-HdrOrdr: A9a23:PCodA6r08ZJwuyQyUM4OmxsaV5r/eYIsimQD101hICG9vPbo8/
 xG785rsCMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAb2SS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3AFgTkLmql0zE2ImI8eR6KchnmUecDNX3SkFrUGX6?=
 =?us-ascii?q?pV2d3U5mPTE6ypZoxxg=3D=3D?=
X-Talos-MUID: 9a23:3jei6AYo3K06cuBTrgGxny95F4RR2fqgU3shj4s34/CYKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226935824"
X-MGA-submission: =?us-ascii?q?MDGIblcFgJXn9hzsIowKPexmIRO6fLCdFZ6sDL?=
 =?us-ascii?q?k3LPicKqZervddH9yKRwUkqcAMqQu6BHp+bf3oacq316mYccsnFaWdPJ?=
 =?us-ascii?q?XDG1RwEgS+hEP4yzy2MlQjTCTw/EVlJAKLkjuvLpq7T7J+ultBzAMh5c?=
 =?us-ascii?q?qqbOpI/EK+QhJHV2+2ACI84w=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 18:49:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749746907; x=1750351707; i=markus.elfring@web.de;
	bh=v/+L6f/1uHzWnn9d+9wYdEO6UW4NdjChdkgAdlxXmrg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oULeuCSf9Sbnd3qn8vGzLM1Fvxw/fzfSMKT3bFwAWJMVklyRvL6LpNwZsYp1bEV1
	 xMKeFvnz1WauR9T7jYaPKffjtP7gl1EPhPwnIHPnhhWSIElS3M6GL9L14upE5GeW3
	 HHfSWgkn0BabMBL7qNJ/tGSpfLGuOVQhBLfcY9tF3BqLJUQt1qD/bQd7MgxTa1G4O
	 Wti9SJOeE8L3QO1a1PuuuFEfra4ChN3vl3T1K16qJ9F+x4yBQANcjkg59vQ15Q3cq
	 6dHVOMxGaXOEGJ3hZYkKInhAgSptyqrOPKvOmQB+1gXYBvD0Y/JzxLZ3d3FPxhX/9
	 JdFru0RoyB58W8GmPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.213]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5CUp-1urDcU1OZJ-00riKD; Thu, 12
 Jun 2025 18:48:27 +0200
Message-ID: <77406d43-230f-4690-b306-4d698449c01b@web.de>
Date: Thu, 12 Jun 2025 18:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Luo Jie <quic_luoj@quicinc.com>, cocci@inria.fr
References: <20250612-field_modify-v4-0-ae4f74da45a6@quicinc.com>
 <20250612-field_modify-v4-1-ae4f74da45a6@quicinc.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 Andrew Lunn <andrew@lunn.ch>, Catalin Marinas <catalin.marinas@arm.com>,
 Joey Gouly <joey.gouly@arm.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 "Kiran Kumar C.S.K" <quic_kkumarcs@quicinc.com>,
 Lei Wei <quic_leiwei@quicinc.com>, Marc Zyngier <maz@kernel.org>,
 Nicolas Palix <nicolas.palix@imag.fr>, Oliver Upton
 <oliver.upton@linux.dev>, Pavithra R <quic_pavir@quicinc.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Suruchi Agarwal <quic_suruchia@quicinc.com>,
 Suzuki Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Yury Norov <yury.norov@gmail.com>, Zenghui Yu <yuzenghui@huawei.com>,
 quic_linchen@quicinc.com
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250612-field_modify-v4-1-ae4f74da45a6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UzKkftK+8VBIQ8zZF1Grhg2CG5pgrqfHBd7AQzZq0RLtAcod8Gk
 EMQmvWcuAKpkDnY30sv8oPuXMFXm8WWJdnXJTVbs0wZ+6Wj38MIeOyvcBfJJwhaedbVR9SN
 K35gc21Uync3Bf6bVP3s22rzYrdFyR9lHgR4PfQ9ir9TLBEv2X+GyQrK37aHesGQ2ZrvNDL
 5NQIGiKfHrR0c8C0nbeSw==
UI-OutboundReport: notjunk:1;M01:P0:xmzVfNKDDmw=;EUX4lV23la1vGW48h/NMjdiIgwW
 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
 HZYrzrjuPjG33emz
Subject: Re: [cocci] [PATCH v4 1/5] coccinelle: misc: Add field_modify
 script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2784
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/77406d43-230f-4690-b306-4d698449c01b%40web.de>

=E2=80=A6
> ---
>  scripts/coccinelle/misc/field_modify.cocci | 61 +++++++++++++++++++++++=
+++++++
=E2=80=A6

Did you overlook the addition of patch version descriptions?
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.15#n310


=E2=80=A6
> +@ depends on context && !patch && !org && !report@
=E2=80=A6

I imagine that the condition selections can be simplified.


=E2=80=A6
> +@script:python depends on report@
> +p << r.p;
> +x << r.reg;
> +@@
> +
> +msg=3D"WARNING: Consider using FIELD_MODIFY helper on %s" % (x)
> +coccilib.report.print_report(p[0], msg)
Do you know that a string construction can also be directly passed
to such a function call?

Regards,
Markus
