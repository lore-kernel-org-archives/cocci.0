Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD32BC61CE8
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 20:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6qiWD4JXlRTSkr0OCRaCLJF5LrOxAnEBQoG5YvQMX2A=;
  b=FpokR4w7uy3IryDCfij57tjzz+5PQP+FVWFLk5R2MEXkf5WS7ss1LEVY
   GDU1BgVlAjjQPkzx3Z5++C3Gbj1/NZh9yDCWNvqYg5hjIZ005JmxSTY6g
   2VPme43Gb4YykiifJDd4kAyTGPrXcrE4xT3FvNw968qqiJ7sfTLuyv6HE
   E=;
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
   d="scan'208";a="226951829"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 22:16:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9AB36E0131; Thu, 12 Jun 2025 22:16:14 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D3BB6E0131
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 22:16:07 +0200 (CEST)
IronPort-SDR: 684b3586_FJ0eSuuS4ISEzBGntN+dHwOYV0Ha/Y91vN5AE6Iv3XA/lBF
 uId4X5Bo5pHEOXiNlwBrLyiu+GJyT3cOssaTSqA==
X-IPAS-Result: =?us-ascii?q?A0E3AAAzNEtogA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDgQBaMwQLSYRVj1CCJIQ7jw+Id4FVgX0CDwEDAQ03FwECBAEBA?=
 =?us-ascii?q?wSFAAKLZwIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CQQZEAQEBAgEjHQEBE?=
 =?us-ascii?q?SYBBAsLDgwCJgICVgYBFAEBgn4BgiEBBhABAw4kB7BbgTKBAYIMAQEG2l4fL?=
 =?us-ascii?q?CJYgWUJgRsuAYVsgmMBhWw7hDwnD4FVRIEVJ4MDPogegmmCKIEWgkuHVIJ3l?=
 =?us-ascii?q?AhSeBwDWSwBVRMXCwcFgSBDAyo0MSNLBS0dgg2FGR+Bc4FZAwMWDwGEAhyDQ?=
 =?us-ascii?q?oEjhEkrT4MigX9MGUGDYR4Gcg8GR0ACAQttPTcJCxsGPZh/g2+BOpkNAY4co?=
 =?us-ascii?q?UI0B4I4gWaBZAyKLZU7BhMvg3GBapFwDgaTApkEIo1lmzGBbwIxgVwzGiSDN?=
 =?us-ascii?q?glGAxkPjiGEM4ELthtBNTwCBwsBAQMJhUYBAYphgUsBAQ?=
IronPort-PHdr: A9a23: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
 pYDGOczaQ==
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:nqBxWqll2SZvEqPuS/yDw6by0CPpDfL43DAbv31ZSRFFG/FwWf
 re+8jzpiWE7Qr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQ+VxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK7/oSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:e19mjGMS4UMSze5DATBj7mcIBpEZcl79w1baOHSfOFQ4V+jA
X-Talos-MUID: 9a23:SBSyvgon225mjNxJSrIez2olMd5YwbW+MWUyqpUdm5S4GBFpfA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="118933490"
X-MGA-submission: =?us-ascii?q?MDH5nTgriDt4SpsBcGChPThQlr6RTTt1yHwx7d?=
 =?us-ascii?q?216jPejUQmFuN4MykE+VyJVA+mwVvByKaSezFFE9SKXon9Ul+XiRIiER?=
 =?us-ascii?q?JcZVEl9Ms4NsM8T427NmDlc/O/WHI5vrBXoaG7U04fVj4OK04ke04se1?=
 =?us-ascii?q?dWTUqRRAy171Zj6zEq688REA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 22:16:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749759321; x=1750364121; i=markus.elfring@web.de;
	bh=6qiWD4JXlRTSkr0OCRaCLJF5LrOxAnEBQoG5YvQMX2A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=O/61qFsWC+jsy2q8T+nUj4Cth0ry95AIGHDhC2oaqerD3418OvlNptTBmW85AMoC
	 mnyO8xQh2OpmWDbicbE8bQQk8B3iYE6BJaiIwTArq0wxp1czYYIDHAxB+DFHp/yml
	 DFfoZfRFkuzKLGe6ltaIAukKIWIbBhjY9bX1D/FiQUeF0huZuJpFqzdlCNB/6PGF9
	 N81vNLLSvlfCKOOj85gJgHbkySGlgZxTMj8jkipr1bDP0yeMduLpmgpts2W/5PyOo
	 QbKRuimmOM+k8m9J5oR1G4GLsHH/jTBJj2cdu/dJr0dJpLkrrOyoQymTpdxK5HwTK
	 myNP377FjEkEG4k3sw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.213]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0qqv-1umon62TMT-011GGb; Thu, 12
 Jun 2025 22:15:21 +0200
Message-ID: <3537a4ce-b5e8-44d5-a884-70a81562068d@web.de>
Date: Thu, 12 Jun 2025 22:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Luo Jie <quic_luoj@quicinc.com>, cocci@inria.fr
References: <20250612-field_modify-v4-0-ae4f74da45a6@quicinc.com>
 <20250612-field_modify-v4-2-ae4f74da45a6@quicinc.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
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
In-Reply-To: <20250612-field_modify-v4-2-ae4f74da45a6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pA7EGEjfJnflF4TE9tOyoGXxUB/CzNseX2uUxJifNOawy2xR3sw
 EpfU8UgiCF7Gkwcx+fgXhi8wIvPzl+Z1knLjb45m3UDFMU8K/nfuWw9NUvJ3Evp0bONcLYm
 6pRgCRt5Hwqlt+w524mTGSeQuG0RXzixxhhasYuD7PsfvRW2QzHuFbVbd1wisbV7nM8DrjW
 /Kdo1s6l3WTQSOLXK/9Mg==
UI-OutboundReport: notjunk:1;M01:P0:W0k8pYu0TLU=;0N+yz1Jd+j/p7C7cl3SIf5Tx+gs
 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
 THSY34RPGLT/+AIU
Subject: Re: [cocci] [PATCH v4 2/5] arm64: tlb: Convert the opencoded field
 modify
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2785
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/3537a4ce-b5e8-44d5-a884-70a81562068d%40web.de>

I see further refinement possibilities for such a change description.


> Replace below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
> - reg &= ~MASK;
> - reg |= FIELD_PREP(MASK, val);

* How do you think about to omit leading minus characters?

* Subsequent blank line?


> More information about semantic patching is available at
> http://coccinelle.lip6.fr/

I suggest to omit this information here (and in similar patches).

Regards,
Markus
