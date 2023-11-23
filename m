Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08673C5AD4C
	for <cocci@archiver.kernel.org>; Thu, 23 Nov 2023 17:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TsLyCShoJOqLCSs7uU3Wn4vtrtA0R8woS0vFmR+SRe4=;
  b=l/pJvABEoIqczcnQkjpbMrG2vpiy6Rg+jUJldPaX/1ZRW5h+MNmiwALJ
   vtPekgTvHbqFJvjpX4Xnz43VZjid+CsyJsMq0AW8j61KsP+iBI4cKAqzc
   xM6bqPqsldopD17Plg13zxKTNX7XAS+3fwZxXWsWmL3x641Ri2ooNJPAb
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="138193517"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Nov 2023 18:55:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 422DCE0CCC; Thu, 23 Nov 2023 18:55:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 03DEBE004E
	for <cocci@sympa.inria.fr>; Thu, 23 Nov 2023 18:55:25 +0100 (CET)
IronPort-SDR: 655f920d_jHeo7bVwDJeS0kJFuTAupqFCe1W0meNvxEc/kXRdLbWx30m
 hdXS8WLAvG+W4LaUZTkd7hMvcLPR2ss7rgUBbOg==
X-IPAS-Result: =?us-ascii?q?A0GaBAD1kF9l/07ASNlaHgEBCxIMQIFEC4I5B4FJMAQLS?=
 =?us-ascii?q?IRTjz2BdTCEO4c0h0qIb4FWgUA+DwEDAQ1BAQIEAQEDBIR2AQgChykCHgcBB?=
 =?us-ascii?q?DIHDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQKBBhOFaA2CXAEQg?=
 =?us-ascii?q?QyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBBAEjHQEBEScECwsaAiYCAlcGA?=
 =?us-ascii?q?RQBAYJ8gioBAw4jB7EXgTKBAYIJAQEGr1UfLCJWgV8JgRouiA0BhVmENScPg?=
 =?us-ascii?q?VVEgTwLgkcxPogegmieUF0iBUJwGwMHA38PKwcELRsHBgkUGBUjBlEEKCEJE?=
 =?us-ascii?q?xI+BIFggVEKfz8PDhGCPys2NhlIglsVDDRKdhAqBBQXgRIEahsSHjcREhcNA?=
 =?us-ascii?q?wh0HQIRIzwDBQMEMwoSDQshBVYDQgZJCwMCGgUDAwSBNgUNHgIQGgYMJwMDE?=
 =?us-ascii?q?k0CEBQDOwMDBgMLMQMwVUQMTwNuHzYJPA8MHwIbHg0nJQIyQgMRBRICFgMkF?=
 =?us-ascii?q?gQ4EQkLKwMvBjgCEw4GBgkdBA4DGSsdQAIBC209NQkLGwY+AienHKQMoHs0B?=
 =?us-ascii?q?4IxgV+BYAyfIwYTL4NuAZMzDgaST5hAIKg0gWoEMoFZMxokgzZPAxkPjiCEK?=
 =?us-ascii?q?49HQDU7AgcLAQEDCYVGAQGDWoFAAQE?=
IronPort-PHdr: A9a23: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
 PLmr5dEWVZzGv5IUiyN8/QdLZ0xUj52yNam
IronPort-Data: A9a23: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
 YmwjQ==
IronPort-HdrOrdr: A9a23:bUeuaKq2dyIufRHc0lY8Z78aV5r1eYIsimQD101hICG9Afbo9P
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AOmS5BGieoOZLIh2Fgjb3rr2OazJuIkKB8SnbL0W?=
 =?us-ascii?q?CMCVmS4GOWFSQ2og/up87?=
X-Talos-MUID: 9a23:Aw1o/Aiaw4RiadrDcp0lkcMpHttZ3qWLDxs3q64J5JGbcjF7PBagtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="138193513"
X-MGA-submission: =?us-ascii?q?MDFzbu0KUgkGjB3cERl2Ok2gGbJZThjXppo5Gp?=
 =?us-ascii?q?4oHe6C5VwbKXhBfrwRAv19qNuHwP1iiv0OLqTjPIqRCSr3XVYcd/4IaK?=
 =?us-ascii?q?8KRgSmcpIBq/45b+7vyaZCQy1qzGdiH8TkIynkcayNDUCZUD3jiSf8rU?=
 =?us-ascii?q?dQWB+9vTp9NkXBzFTZLZp2fA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 18:55:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700762116; x=1701366916; i=markus.elfring@web.de;
	bh=TsLyCShoJOqLCSs7uU3Wn4vtrtA0R8woS0vFmR+SRe4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=u6CUIOoC7SQGf9O7d4bozSNle2LdOmAcvyHyXLVwjxqpHDMTtrc1M+M63mnQqO5o
	 ZyozRzlxq18fN4ojwf3baX23VIE8noepd8x2x87zetbC2B2VdsSbcXoordioK9Nnw
	 9V5e8PbPtbXJL8HtmzhMiudclBjd5vMsDpwRPuaxhz85oc1wLLu3OVrZEBGbI9G6n
	 8KUkXlIHpfZ7tOzVb9z1RLgbQH85G1vREbIQa3T0AkXFFrDafyW9uHAjJnNpELXsD
	 n/0v+GvbXGPfvV24NddF7f40rZQ0nRLgQFFf7RyE6f5z9RJ6uWbij8cfcAV8Mo9Yr
	 B6doB/HzioKYv6YI1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMXxF-1qmlvP0ZJX-00Jawj; Thu, 23
 Nov 2023 18:55:16 +0100
Message-ID: <5f1930b8-8249-4158-b76c-c888d36387f2@web.de>
Date: Thu, 23 Nov 2023 18:55:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de>
 <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr>
 <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de>
 <alpine.DEB.2.22.394.2311222131120.3262@hadrien>
 <471b38f1-fc2d-482b-ba0a-8c7982ba9618@web.de>
 <alpine.DEB.2.22.394.2311222158000.3262@hadrien>
 <09a9b132-5cbc-44df-b445-d8adcac7571e@web.de>
 <alpine.DEB.2.22.394.2311231845210.3125@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2311231845210.3125@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FgpAHEjavEWHfXiKd5AFqjKuXqKdU+/xsqOsLD8pp3mCVnyfnbd
 o3pB6jWwZiipeOjC/WZVSNd2nQ9ZMLyDT/7Y9NTND/AL6QH/YJRJ+w2KE0nkPrKv7wVG4Ag
 M+5TF48CX3IL7vO7z+mnziehZP7Ba02Lr1qRo8/hMQLCqTrZVROYExTYVy8qd5VBWgrkwEa
 7Wlx3UvP+4Ouxxxcr7/dQ==
UI-OutboundReport: notjunk:1;M01:P0:/Ot69px4L78=;z2eOMBIHBaIFTlafwb4PGmJP5EC
 GBQTq3AlLZC1ZB9ArRqowDFQwdhyTP9pziezD38m7fIM5RwVR01IMobCy1CkaqgxRiOlyjOJg
 J+LgtaRvPEJDNykqpuhvEat0l03Y2HNC9DnFg1ilrn9o5dqypQppRnguae8gIJGtaOw5UO1gp
 q4193ee5+9JPdLckhiHWWFOW93EVXfAqliUO83uSQNzTNpVTe8s7A02CV3TKMbSKnyu86er6t
 GTAfGw3Uojfkq4eH3B0yihPpN5uBtHVd1MBwJY7KwLO76YVoXMYtEyiAcNZUVytBt6ksrdrlG
 SlIWisoulDQazU4jLBvBv8gX51zW6vT5phHCDXfvfxt7v+XOsos2KdmEslv0X45o49CoJMe6t
 1TLnJYrlk9N5t7qWS75Vbl4qeARkQyVcURIN4T0DGw4aYRI4x+MD2FHN+1LoUMLIHBUImlGkm
 fc6VYjwIrIA+/ndykEF/gRFNIwGPaDq9twNCoU1YFUAhlyIahQgaLx9BNSnL2DX+NUMCDl8Or
 Add/fzBha3O9CKBPQKUWf6NAD0SyKlIGYBQ8xBqgrKHMhoK17Sarqc2VuB3XPcdXZDvZm9Oc9
 4EaI/pZy608a5ThNi0joafXL56u234plYa2A3D4gM3G3D1Yg4k1udX1tmqVmxbUX/NMNSnvD5
 HJob1qnFaXVIrWCFu14EDWPqOVoyrUtOQQeyjwRTKTvfoK6aFZ+H0XUrI3r7KonKs7lpdi+as
 Z2LkQ6l1sGblxs2jSMifKpIk8TzgKeFjApmSgBtLF9R1y3AODQYiIWODV+0MIbFgyGv8GCaG6
 uTHMUj2RkpjkK8/SANuXEPU8UPD+4HsqPfUnahjkTSUL/c2obR0kkUmxJ+C/xQ5UJddH04MS0
 S5weyNFfADAUoUOaBsDo/XhnOQUnPN7xSmezRfz8bAEsxz4wvQ05ybIc+55Bl9YhIrNnLi2k7
 SFqVPA==
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1319
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/5f1930b8-8249-4158-b76c-c888d36387f2%40web.de>

> Script rules are executed once per unique match.

Does such an information mean also that each script rule can not know
that it would be executed several times because of repeatedly matched source code?

Regards,
Markus
