Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A064EC77B7C
	for <cocci@archiver.kernel.org>; Tue, 24 Jun 2025 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nAspC3WP7Npov8DZfWyyVTwC7r8mOQn9CIkK1tgRJnI=;
  b=kcfcRRsIaz6T+5QpRFyZCZ7mYaJF13ySzFtLFhkK3eOMbeBRxlLMBvrU
   664UJQPAYEHI6BwbAWOWD3vM3hESybB47j3zHVRnpRPG6Z/+ptEIx2TBd
   23IvZ7IN3bh/xniELGfgYqV07lpqlNmRo+p9dIN2Dh1Jcnzhh5VVxMF2/
   8=;
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
X-IronPort-AV: E=Sophos;i="6.16,261,1744063200"; 
   d="scan'208";a="228778435"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jun 2025 15:54:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5F845E0AF1; Tue, 24 Jun 2025 15:54:24 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2FE73E0131
	for <cocci@sympa.inria.fr>; Tue, 24 Jun 2025 15:54:21 +0200 (CEST)
IronPort-SDR: 685aae0c_iyqSwiAcqv58bHplFZKuAUTc+fEF9fI9//x9BQ1qDejhVLq
 nDyusOR6UqsWh5vg6nxyOhdtpgnOTucWEFs8yVQ==
X-IPAS-Result: =?us-ascii?q?A0GbCQB9rFpogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRIEGVDMEC0mEVY9Qhl+HPIdTiHeDUgIPAQMBDU4BAgQBAQMEhQACi2kCH?=
 =?us-ascii?q?gcBBDQTAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxh?=
 =?us-ascii?q?XsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QCAQMjHQEBESYBDwsODAImAgJWB?=
 =?us-ascii?q?gEUAQGCfoIiAQYQAQMyB7EGgTKBAYIMAQEG2l4fLCJYgWUJgRsuhW2CZAGFb?=
 =?us-ascii?q?DuDQnonD4FVRIE8C4J4PogegmmCJoEWgl+CbpM7UngcA1ksAVUTFwsHBYEgE?=
 =?us-ascii?q?DMDIAo0FB0CFA0QEg8EFgUtHXMMKBOCOxyDIYEbg39GK0+CKHuBAnxMGUGDX?=
 =?us-ascii?q?h4GbQ8GgSEZQAIBC209NwYDCxsGPZJhnW6OHKFCNAeCOIFmgWQMn2gGEy+Dc?=
 =?us-ascii?q?QGTWQ4GkwIumFYio3iFIIF/I4FcMxokgzZPAxkPjiGEM48KAa99QTU8AgcLA?=
 =?us-ascii?q?QEDCYVGAQGKXYFLAQE?=
IronPort-PHdr: A9a23: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
 YgBvJxpIw==
IronPort-Data: A9a23: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
 IT7qa2ogK12dKIpLftdRg==
IronPort-HdrOrdr: A9a23:aVfEgKj8U71Nj4sa7sRpitkYVXBQXg4ji2hC6mlwRA09TyVXrb
 HNoB1p726RtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: =?us-ascii?q?9a23=3Akv8p2muO+rCkz7I1mKSmMEJN6ItiLCXUnXnBMnT?=
 =?us-ascii?q?jKmBnQYOLFWCdpa17xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AaG/zSw5y4pjCfdim0UWYd2UwxowxuI+2Bx0nyqk?=
 =?us-ascii?q?esvOLF2txYC+4iDqoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,261,1744063200"; 
   d="scan'208";a="228778429"
X-MGA-submission: =?us-ascii?q?MDHCnb8KGUe9zx8kSHuJntEZFrLEz9TTTmCDdF?=
 =?us-ascii?q?RD6tzcdkrI6MHLTZMWAg882R77rbafTqeBhVsJ+VZxnRJUQGKJjGwloG?=
 =?us-ascii?q?awsGxz+zA9i2XqHvaGoi6Qzr+lB+1VNv/2GVErwlgOSQS9BUUhree8uU?=
 =?us-ascii?q?ncOKJCGpDWkyv76cWPgTDSig=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 15:54:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750773258; x=1751378058; i=markus.elfring@web.de;
	bh=nAspC3WP7Npov8DZfWyyVTwC7r8mOQn9CIkK1tgRJnI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JmQfGbdrycpf7iW1IaEmxK9XgDFX7goswEPbfiNqzDUfbjDn2AfASqGC7NxwgHDw
	 Yq8NXs5p2vUlW1yPyUl+NOXNzTzsPmMc9eQmpOPlQPMqMP6CjngQpfKMQkVLfVINX
	 h79nCuGUjSAROTkYzHzsggf58JN40aLpoe5CrF1LggPd3TJOTTNI1QhGahsVtuaBq
	 QNYw9Nu4Ze76Hmrt2x2xzB93cmMA9KulOjbkm941fB2Y0CethWUo0ZqPKnkLi6/G9
	 nnuCzGswGOqUf3mIlC99cgo8oC0+K/A6fbvxP0jE1hMO+X3RsYrWpNV1pVdvPhKz9
	 4PygHQsydPue8x6JHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.200]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCXZh-1ucYQb2ZZj-001XJX; Tue, 24
 Jun 2025 15:54:18 +0200
Message-ID: <e694666a-ec94-4443-bae7-54ac2f0f0e7d@web.de>
Date: Tue, 24 Jun 2025 15:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Luo Jie <quic_luoj@quicinc.com>, cocci@inria.fr,
 Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly <joey.gouly@arm.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Marc Zyngier <maz@kernel.org>,
 Nicolas Palix <nicolas.palix@imag.fr>, Oliver Upton
 <oliver.upton@linux.dev>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Suzuki Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Yury Norov <yury.norov@gmail.com>, Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>,
 "Kiran Kumar C.S.K" <quic_kkumarcs@quicinc.com>,
 Lei Wei <quic_leiwei@quicinc.com>, Pavithra R <quic_pavir@quicinc.com>,
 Suruchi Agarwal <quic_suruchia@quicinc.com>, quic_linchen@quicinc.com
References: <20250624-field_modify-v5-1-cd67127030e4@quicinc.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250624-field_modify-v5-1-cd67127030e4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BxwhYr5KPqaoChoZS4nBRipO+hb3znKQbMhT2/FewqmcxGiFGXm
 oChwojR/Ygi3iDg4j7kznTwoKuaAZakLFtDxb0W5BEeZKWQPyZU/UcUTV0p3RelvLTq2TOi
 FoELt62MsZEUdfIuU3EJwMibjHNJcyMsfO5IvkfnMOJ7hhxqGckQd/lAG4CrabfYzEK2Sva
 4kZsMB3Vo/2Faa6nasy4Q==
UI-OutboundReport: notjunk:1;M01:P0:jweyu8AFEUU=;KIKiMtgt6YoBvgg1ereISGrRNuy
 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
 bqQ3P+e
Subject: Re: [cocci] [PATCH v5] coccinelle: misc: Add field_modify script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2794
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/e694666a-ec94-4443-bae7-54ac2f0f0e7d%40web.de>

> +msg="WARNING: Consider using FIELD_MODIFY helper on %s" % (x)
> +msg_safe=msg.replace("[","@(").replace("]",")")
> +coccilib.org.print_todo(p[0], msg_safe)

How do you think about to use the following code variant instead?

msg = f"WARNING: Consider using FIELD_MODIFY helper on {x}"
coccilib.org.print_todo(p[0], msg.replace("[","@(").replace("]",")"))


Regards,
Markus
