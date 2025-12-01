Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08939D116F3
	for <cocci@archiver.kernel.org>; Mon,  1 Dec 2025 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jHO6FbN9D4CUDsPsTa6ct208QFmROdu2JqwucfXF7vE=;
  b=H8CvdtychcU9ujm04OdqglQ7x1pfTGxjwRi5TEODONboP2YbPMH7WEVk
   GMdTOEFVpUFo40e/mJKDZzAS1xAJKA3EDKCLlRWjt0m2vY//CQXbiC4wT
   p7ru6t507vUkRI/CFKC9a2zYFJJ9fvAHxQ1B+vUHbETBN+GEB5ytRH790
   A=;
X-CSE-ConnectionGUID: HzPKYArlQpOc7M360/KVPQ==
X-CSE-MsgGUID: 1y680UU7RPKrQ6Ie23OheQ==
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
X-IronPort-AV: E=Sophos;i="6.20,241,1758578400"; 
   d="scan'208";a="252175260"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Dec 2025 17:00:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E660DE0157; Mon,  1 Dec 2025 17:00:34 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5B07FE0157
	for <cocci@sympa.inria.fr>; Mon,  1 Dec 2025 17:00:33 +0100 (CET)
X-CSE-ConnectionGUID: uq+i99QfQMCsUcDVAH8LmA==
X-CSE-MsgGUID: MhjHWkKKSAmRlFAh+qrJ6A==
IronPort-SDR: 692dbba1_BhSL17McJe4K02+fFN9FSkCiTJexi9NEi8/sumrSl3cghLh
 pdrdl0RbZdffYE+oeMowNstXnt1G2Hn37Pt84PQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GQAABYui1pgwsR49RaHQEBAQEJARIBBQUBQIE+BgELA?=
 =?us-ascii?q?YI/ZR0GWDMEC0kIhE2PU4IkhDuPEYpOgX0CDwEDAQ1KBAECBAEBAwMBgUxAg?=
 =?us-ascii?q?nQCjGUCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEBOgcOCjGGTw2CYgGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQECR0QBAQECASMdAQERJgEECwsaAiYCAlYGFQEBg?=
 =?us-ascii?q?n4BgiIBBhABAw8nBw0Gsx6BMoEBggwBAQaBWEHYRh8sIlmBZAMGgRwuAYVtg?=
 =?us-ascii?q?mUBimYnD4FVRIE8C4J4PoJhAQOFOYJpgiaBDplRUngcA1ksAVUTFwsHBYEgQ?=
 =?us-ascii?q?wOBCyNLBS0dgSMhHRgTYD0XQINJHQZnDwaBERlJAgICBQJAOoFmBhwGHBICA?=
 =?us-ascii?q?wECAjpVDIF3AgIEghZ+ggoPiAaBCQUugQ0CAQttPTcJCxsGPZUMUIIoaFkgp?=
 =?us-ascii?q?xWhRTQHgjiBZ4FkDIoujisJhwoGEy+XUg4GkwWZBo4ImzmBbwEygVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OIRmEGoELw2lCNQIJMQIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 jMNxq7ka5sePMv31h46ArGVtJvHEQzcUIIUyhA=
IronPort-Data: A9a23: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
 P8hoYfi5ejAsex4TCjB
IronPort-HdrOrdr: A9a23:Da6gb6PNJVM1C8BcThWjsMiBIKoaSvp037Dk7TEXdfUnSL38qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhbX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AwFzUT2sqeNKr8x2VtDz4sjfV6Is4az7cnSbpLXa?=
 =?us-ascii?q?dIn1UQ5GrYH/A3KZNxp8=3D?=
X-Talos-MUID: 9a23:Jka3ZQXJ/Up6qIfq/BrshhFdN+RL2I2rMkQjuJVFotOmawUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,241,1758578400"; 
   d="scan'208";a="252175249"
X-MGA-submission: =?us-ascii?q?MDHGNmWQP7WxNkA+t3Bxsz+fCVCRqSJC5C9x5p?=
 =?us-ascii?q?aNlF386A6ctXI6QaKQlXX2edTxO93umvbCxXzo2sgXfuLehPbJYS/X1P?=
 =?us-ascii?q?Wk1RJDFJrfUKNHoGssrtaioTVLcp6+eJ8xh22dT4f2i8abqYLBcdgMmW?=
 =?us-ascii?q?WyNdsb6dlMi68WbNsNr3msZQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 17:00:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764604832; x=1765209632; i=markus.elfring@web.de;
	bh=jHO6FbN9D4CUDsPsTa6ct208QFmROdu2JqwucfXF7vE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=du++1MoII1PuiHDAhQcMtXVkvAinNsUGGA/ZRz/Cj9d9jBXb4pkcFKjFj3J8JUJg
	 4brstkYZNspZ+jfGZeOarN9c3XJq2UfJ4hvMzXzNqS+NrtFGpFJltHwhOnRzMmmyC
	 0Fiot+9zRV3lMjYTtvng4slFvni+Rb59/+ClPTHBJLtXfjCUuQGj1p2H/5SrrAGtG
	 Fus26cTKMAsLemQP10SgYt7YiWR36vidvd1PDLrHY6OB9My7s52PF9mF9OilQkpK8
	 bRxN8H1QnbT94+gXBd292Xkpmdv5Y7pj4vJvZnDO6/GE7uIb+9wL6VBiDJHXKGuG8
	 eUeA5wWka4P23mFSwA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M28WJ-1vNcHx0tPV-008KhU; Mon, 01
 Dec 2025 17:00:32 +0100
Message-ID: <6bf5d8ea-5d04-4851-b464-19d2f76379f8@web.de>
Date: Mon, 1 Dec 2025 17:00:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <7bb043f9fd00c7e20ebc75353e697a51@posteo.de>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
In-Reply-To: <7bb043f9fd00c7e20ebc75353e697a51@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xXX6pC4hdUTm0UbniFKsdn0g+kjMrpMXlhGk4/D5tEwkL1z71Z7
 QZHzOG50RKbSObZNaK64Uqv+k+maRmlINRRqJhNNEq7z2a0or2+1EGuxmI8uZrtuKkmFkxq
 aHRsP2ULcBs5X5hETqzfjpn9R2oNUV2SyBtwhD6dQ/lby3UYrFtYZMWOtIV42ZGlhZAiv3/
 2G8PCI9OU9APQKxtvb8Kw==
UI-OutboundReport: notjunk:1;M01:P0:/MLrNWh2zo4=;KDZKRK/yxlrAFpSkyErZgJxx6Bu
 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
 uys6wOpEOBT6RkoKrP6MqysHVqmJJ9wsogdR4h
Subject: Re: [cocci] Matching a specific declarer?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3231
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/6bf5d8ea-5d04-4851-b464-19d2f76379f8%40web.de>

> Could you confirm, and maybe suggest a workaround?

Julia has pointed another distinction out a moment ago.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/4c9d00ae071800cb447efaffd753f3bb2be28800/docs/manual/cocci_syntax.tex#L473-478


> I used the coccinellery example as reproducer because it's public,

Thanks for another look at this information source.


> but actually stumbled upon the issue in a simpler case: I searched for all occurrences of DEVICE_ATTR_RO(attr) in the Linux kernel,

Will it become more interesting to clarify your own source code search approaches?


> but actually found every place where *any* macro was used to declare something.

Would you be looking for any better documentation also in this application area?


> PS: I'm using spatch 1.3 from Debian trixie.

It might become also interesting with which delay subsequent software tool revisions
will be usable.

Regards,
Markus
