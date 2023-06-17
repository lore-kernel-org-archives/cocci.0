Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AA8EB64D9
	for <cocci@archiver.kernel.org>; Sat, 17 Jun 2023 20:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4yGN5RfhXqWahmzpkpVv4s62UOSL7J7trPfmYc6zIwU=;
  b=RkPnWao0otwm8b4zLG2daoUen//Zdnze5XGktCvgx9tFTn9VfUzIbk+E
   IFlIhO0dGScCMF3z+H4eDyx2qOhp3Up63trtYFO74yYnjnxABuf8D+CQ/
   wdRNCU3t1xEQovAvcofthVxQk8quyTVhLMHZdSlmbNzUmssvtlo6d3U5e
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.00,251,1681164000"; 
   d="scan'208";a="113371514"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Jun 2023 22:01:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2F0F1E03AB; Sat, 17 Jun 2023 22:01:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 56186E0157
	for <cocci@sympa.inria.fr>; Sat, 17 Jun 2023 22:01:06 +0200 (CEST)
IronPort-SDR: 648e1100_+kwdjg3vQzJ04vtio/q+4yUiXpYeZfE4qvauBZI7uMNq/ms
 vaomr/WJB4ExXX/pNl8QGwd5lff5cQ4zd99jPxA==
X-IPAS-Result: =?us-ascii?q?A0EAAQA7EI5khwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYIudQNTMAQLRwOET48tgieENo53hGiEBIFWgUA+DwEDAQ09BAECB?=
 =?us-ascii?q?AEBAwSBTIJtRgKFfgIdBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAUBAhABAQEjFwcOECeFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgINOj8BAgIBIx0BAREmAQQLCw4MAiYCAlcGAQwIAQGCegGCJwEDD?=
 =?us-ascii?q?iMHDbAbgTKBAYIIAQEGnA4fLCJVgV8DBoEVLQGNLoM3eicPgVVEgTwMgng+g?=
 =?us-ascii?q?ksXBBiFIYJnizAODIJngzSCMQeLO4Eob4EegSJ/AgkCEWeBCAhfgXFAAg1VC?=
 =?us-ascii?q?wsPVIEcUjyBRgICESkTFAVNeR0DBwOBBRAvBwQyCRYJBgkYGBclBlEHLSQJE?=
 =?us-ascii?q?xVBBINYCoENPxUOEYJaLTY/G1GBeCUEDgMZKx1AAgELcD01BgMLHwYmAR4CK?=
 =?us-ascii?q?YFXMFh0JCSgHAODE4E7IIEtpCugWTUHgjCBW4FdDIoTlQkGEy+DbgESjGyGK?=
 =?us-ascii?q?A4Gki8uhzqQMSCNO5pdgWQBOIFcMxokgzZPAxkPjiAZhA6EYYpnPzQCAQELL?=
 =?us-ascii?q?AIHCwEBAwmFRgEBhgABAQ?=
IronPort-PHdr: A9a23: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
 nYL
IronPort-Data: A9a23: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
 RzyNJE90thdD6yFndou28E=
IronPort-HdrOrdr: A9a23:ds02RKAb6zewqdzlHel455DYdb4zR+YMi2TDGXoBKiC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eAaGSS4/yb3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:VkdBFWDMcLT13mr6EzJ130RJIp15SUb28HWIOVTpAG9HV4TAHA==
X-Talos-MUID: 9a23:G3m8sQqlJoYab/vg2hUezxtSGplJzbvzMx0AyJ8Hm9KkGStyBh7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,251,1681164000"; 
   d="scan'208";a="113371511"
X-MGA-submission: =?us-ascii?q?MDFpXZE7f/uHpX0ZOc1hVP3rp/vVqdwyjTDAIX?=
 =?us-ascii?q?DHnFhlbb6FQsVMocLte5WeS3wR+Jr38bPR98i/7a/Bu/XiWQBN4ea8eo?=
 =?us-ascii?q?a3vkX2uLTDixsBfXWbv5f5bYhuzTvgXU0R5z0SxOTVkFGDgrHlvjy1lf?=
 =?us-ascii?q?mfG552yoQ+jcozf7B4ca/+Hw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2023 22:01:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687032064; x=1687636864; i=markus.elfring@web.de;
 bh=4yGN5RfhXqWahmzpkpVv4s62UOSL7J7trPfmYc6zIwU=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=FGQfmGxvcg4J9ZbwPIm7n6XLSfzgcxRidPiM+y4DUwNdExghGCcegFzTbnD4P+XtgWiX8oa
 VXZ4bITH/vPsM276Buyjglma/LYSUGK2+Wm/YUcHyW+la8p1kIhtKAhb3rZdm1pHK+8P+kX6h
 jw5oSbXCVYLegwHghCSXasGJUtF0TUsfLD6Mv6rpVHlSwC64e/d4yYMa0j5DAXfjCd68iX624
 Dox33i1wTXFpcZCnnRjyXhrR0OLBaY4fAZW2qb1+BHjAhKXFCguvbpduqcoXJ3Lx9sMbf8LEF
 cQqP3vqzLvxBIXM4iehhOvFd6/LwakXO4J15U1j3GizDABFrdulA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3Euv-1q7bIr15bB-003YMI; Sat, 17
 Jun 2023 22:01:04 +0200
Message-ID: <71168ceb-8273-4067-d0e0-c6c219d4618e@web.de>
Date: Sat, 17 Jun 2023 22:00:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Fei Shao <fshao@chromium.org>, Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20230617160901.1.I2b151cdf7a72d9e3ecc7ab2ff38409ebe6d65d6b@changeid>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230617160901.1.I2b151cdf7a72d9e3ecc7ab2ff38409ebe6d65d6b@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:WqdNPGdTZ4aZfM9211hE8+gUYvDCZd03zauWtHveb0G6mB8tBft
 Sh/NWG9Xv+enZWgGTY8s3Q+eqt1ibENKtGSRuea39MSvxAzL/b3IcCwea4W7hZYaDOMWup0
 p2KzlZ48i3E8SjNMIyMa3HhCHyw/xg9J+5xjpZjzHJY4RPS+NIgUf9O5Yz1qWh0WdDanqh+
 nk25Tmyhg+qaJRb0k6vsQ==
UI-OutboundReport: notjunk:1;M01:P0:CfhnqTl4zGU=;AV7KkAZ5ioGKWthfm0/OTJMhYeF
 ZBoj+zyvB3pK2k6bJXFwUSq4FKYVq73Q/eFjdf52ygu/3ojWSWFFUF3LH0DLGgMWRJMBKs/kp
 z9UGRvIZKE4XPSk9q31jidmh0gXVw8BU3T6avPHjuVaWC/9GPl4RQVks0IhPn0sG0DoUiRsqN
 0gw1D3pUx1wQWWsbnXaH+oPH/hFqkJDK7ZcFYpFGb9gxaQoxeY/vAEwupfdRC/OG/xkFjgwuB
 UEYgvTCCn2rtZc+DdhFvkhfanLX3L1peC0RZGdCf2iLtU0K2si6mZzDB+1Nr/3ujE98lxs5DH
 UqIoYW0TvDmtbk+ackDRvf69JLUWZ6Jz82V4JPqTDpdTJw5UE9NxJIDxY4A6h+a1ZqT/qnOfn
 O6MkA1STH0A+optG2sHzpxPiK9RWpxGZtpgDD8uPNHGI0L4h9lzrgCEt0w3mMP4Pwgej5YfMT
 xQzq8qeGhf7a3lDqcg04snaqdw88EwiuUxN9xmha0bCBFs7SPmkJ+UBUmqW35zuWhzrbbbwkZ
 teT1ujMncltYfbEXR5EkzQk5+R2cNuzhQAVYEfOzN088ZGKlCGCVMH8eKNFC8GCXqENHCrzF9
 w19Iz8TikaZJ4KgUd7/V37Hv9hN2NvS0wApJgDIXVWTHIb0sZESx6INPX1ek9znI0sImWciMq
 BfzWAlmBN3b1VNJLuDwUfqilrmbEW+q0PVBBatzjZ1n46FE5gkIIMCGk0QiKdIAAM74fnqtE7
 7eNVCEE9xvqM3UoaMEiEvXDDOviwgJAzAKeIpDpGjXj1FE+4RfIB/nnwNM1hGCLRGUqvZF585
 yYqp85Nlz2QuUJ8wi2Hdx7VXqegE+jQXfkNrpZq0Vaal17favCM9EA7A/SIFpXAUwKvugY6Vc
 Sno+7TqqxpYz3W4ppXdcX8U5l7ZayVekteO9oZR87MBJKR5b15Pv8fBf52b8EFDc1wHkMFyG9
 L0PlIQ==
Subject: Re: [cocci] [PATCH] clk: Fix memory leak in
 devm_clk_notifier_register()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1189
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/71168ceb-8273-4067-d0e0-c6c219d4618e%40web.de>

> This fixes the issue.

Please replace this sentence by an imperative change suggestion.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4-rc6#n94

Regards,
Markus
