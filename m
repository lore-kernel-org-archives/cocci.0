Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1877FD13588
	for <cocci@archiver.kernel.org>; Mon, 28 Oct 2024 09:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hRmqB3r47WFaTfOl6RkO8QCJnvk+TKkVsDavFIbNkdw=;
  b=ugnsExVGedGrmSK7rtNt8mfaciF7uC94hN9vNe4BkuFxLnalyDdBWwnH
   fnshsUSejOE4rJTLnQ43yAl8YQgcY4qFBW3zJ/iKhrcr4pwt8fSc5ZQK1
   xyCQiHH6sS5gMDholjzPcemRInOUaCnmjJ+Igb8dx1X6UJnIrj9cPzIAl
   s=;
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
X-IronPort-AV: E=Sophos;i="6.11,238,1725314400"; 
   d="scan'208";a="190999659"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Oct 2024 10:01:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 13D69E0133; Mon, 28 Oct 2024 10:01:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E8A5EE00B7
	for <cocci@sympa.inria.fr>; Mon, 28 Oct 2024 10:01:00 +0100 (CET)
IronPort-SDR: 671f52cc_ExMvg+dSJS894wKLajqSXmcQSQ09IEP5LnJqFpICHZ5GBW9
 zYR5zAYDRv07kBbd5cKXFmo+4dt2TqGGNZQrEJA==
X-IPAS-Result: =?us-ascii?q?A0EGAAAIUh9n/wQP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDB1sbBlQzBAtILYQpiB2HMIF0MIQ7jw+Id?=
 =?us-ascii?q?YFWgX4PAQMBDTsGAQIEAQEDAQOBSUOCdAJ3iTACHgcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQKBCggLhTVGDYJiAYEJG3QBAQEBAQEBA?=
 =?us-ascii?q?QECAQEBIgIBAQEBAQEBAQEBAQEdAg06RAEBAQIBIx0BAREmAQQLCxoCJgICV?=
 =?us-ascii?q?gYBFAEBgn0Bgi8BAw4jBw0GrmuBMoEBggwBAQaCaNdzHywiV4FjAwaBGi4Bh?=
 =?us-ascii?q?WmCYgGGJIQ8Jw+BVUSBPIJSMT6CYQSFOYJpglWHXyWIN2iRQ1J7HANZMgFVE?=
 =?us-ascii?q?xcLBwWBKyYuA4RuW3+BO4FTAUaCZkqDRxyBRThJgk1pSzoCDQI2giQkWYJQg?=
 =?us-ascii?q?SUEBYM6gjYdQAIBC209NQkLGwY9m1BHhCClTYE1oTY0B4I4gWWBYwyKJ5UuB?=
 =?us-ascii?q?hMvg3GTTg4GkniYdyKNXJUThhCBZz2BWTMaJIM2UgsOD44hOINCM8wjQjUCA?=
 =?us-ascii?q?TgCBwsBAQMJhUYBAYpHgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:FLOIJK6dQ4Bj8SzJD4KxTQxRtP7GchMFZxGqfqrLsTDasY5as4F+v
 jdMWD/Sa66IYGL3L9siaN/n/U8OuZSEmNZkQAFv+X9gZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOC6UoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhXgtawr414rZ8Ekz5ayo6GtB1rADTakjUGH2xyF94K03fvnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFV7tJOp6iGqE7aua60Tqm0hK6aID+6vR2nRHe545gXBYqhei7vB3S9zx54
 I0lWZVd0m7FNIWU8AgWe0Ew/y2TocSqUVIISJSymZX78qHIT5fj6/BgT0wPHYsCxuV2J0NJx
 /U1GD4rUw/W0opawJrjIgVtrsEkMdWtI44V/H1tpd3bJax/G9aZGfqMvIIegF/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUB+QrE9PtpuDi7IApZwOjzCfTPUP6xf/5flRmkh
 WHrxWTwHURPXDCY4X/fmp62vcfRkir+UoMfDpWq9/tgmlTVx2oJCRRQW0HTifK+gUW/c8lOL
 lQdvCsot6k7skKxJvH5VgKxpHqsrB8ZUcBZVew88gCEjKTOizt1HUABSSNdLsMrvok6SFTGy
 2O0oj8gPhQ32JX9dJ5X3u78QZ6aYED58Udqie44oQo5Dx3LpYYuklTQQ9wlHKPdYhgZ393v6
 2jikcT8r+x7YQ03O2GT4l3NxT6hznQMZhBg/R3ZBwpJ8SsgDLNIpOWUBZzz8vtKaoqUJrVEU
 L7ohODGhN0z4VqxeOBhjQnD8HxFJxpIDdEEvWNSIg==
IronPort-HdrOrdr: A9a23:7KwgBa3b8ITsKn8lddU99QqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV96faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3AUBQpAWvN/+g7AeRhof3fp4vk6IsgfD7Q9VfWOXO?=
 =?us-ascii?q?7CEBLT4+cZG+e3p57xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AZCvO8A2WK2iU0egjrTvrrLP51jUj8/SwMW4Xu7c?=
 =?us-ascii?q?9gfKOPnNMGDSwtjS+Xdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,238,1725314400"; 
   d="scan'208";a="190999638"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDGACnlbe5MPClQDhI9BoezuP+TSgvVrihd8XK?=
 =?us-ascii?q?BWHuZE8ayj/kNT4lt1vLQfvZoMUhLrw0erV9UWrSx3BJrZ8tiJRqug5S?=
 =?us-ascii?q?WQsPyNq/JuJdIbEvaBSM2e8oPa+UL5dqpELbv5GDymRkL8Gymk9q56ar?=
 =?us-ascii?q?Prx7eqHMA7O0DAZCAGxojEww=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 10:00:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730106049; x=1730710849; i=markus.elfring@web.de;
	bh=hRmqB3r47WFaTfOl6RkO8QCJnvk+TKkVsDavFIbNkdw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=b5R01XOFqTyjSHSTF3LGV7dUdGk8xJkDvb7tWgU4ToGAJZqczDEbZNcVYYwQt/60
	 gHN7sNr5rtEzIa57zUGVD6SXr1r3EKqA2Fzsc0Ds4oWvT/ZBukT7gs14kwLyPpwaG
	 Xx3UEHwoz9DI7KK0s2vJh+M76CUxU3XksDzLSMAvu9I0dgWJYnL/2KZXfbjyu9nHU
	 lzH/YboqyOTBczBUvM4WaHVZljMlI4tEypy0bpGPHkBjqalvyYXqwGV9Wo9/MMU97
	 I/idEhmA5j3Cdl5uyiRKRUqRfZf1Qbl5aPEc3Z5ooP447NS/WwsVj0xpJuLhTfbEQ
	 M+TfCbyodWGECOPQ4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6BN-1tLVYa2qxx-00Y035; Mon, 28
 Oct 2024 10:00:49 +0100
Message-ID: <656ad840-5a97-445d-8f70-5244402bc111@web.de>
Date: Mon, 28 Oct 2024 10:00:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: "Derek M. Jones" <derek@knosof.co.uk>,
 Victor Gambier <victor.gambier@inria.fr>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
 <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
 <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de>
 <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de>
 <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de>
 <alpine.DEB.2.22.394.2410271429560.3498@hadrien>
 <80d4b3c8-f29d-466e-b9e2-15f2c78a2f74@web.de>
 <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
 <4893c41d-bdaa-44b9-9381-d04bde2fedd8@web.de>
Content-Language: en-GB
In-Reply-To: <4893c41d-bdaa-44b9-9381-d04bde2fedd8@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VfH1O+9zXltQ6PHHDpAlQ8HnUHQkfkjl97qybxwbrUoRZ2T0TJp
 765lSZMV8rfscDeYT5Y4EIVAgqgFb8lTq6aDTRt7o1n9NbkNbSlQj5upRLlJTvAAt7XT2Qv
 9YNZc8PF+jbP5WNafaAiLcbyPgbK8Di1vR5UpytIS5J0QvAiezPEBMyrjdJzNyThDRhsvVJ
 f318vtkjpMZxbVsTkgWdw==
UI-OutboundReport: notjunk:1;M01:P0:ojKJ+/Gm1Ic=;SzZFsMhHFdTXg6MjZVgBcVvoZ16
 m1ja3Vv/wMf0FoTT21UXeS6qyOM94FjLam5Hpis/uwCl27yoR0FylO/TMA9AwII80fvYnB7ig
 QF9+a95OM2QUlOQDmQ/Hv14Qc+MT45cztwI4RRvF6J+BxCrfdPyLHLdQVtO8Z3Xd2Gv++58rB
 Ywn8jav7gs5E2vDEAkP3JUKmHoORclesizDNh4Y20C9zKlxWpbQSS7NtWB3gn4i4F3OvH5VDW
 KEaYfRLnXHkLxkh7tNDy0spSF7xyCHKnfV88mtLmjvQmDxiw4FhJu+SCadlOE+f++aXEARDqu
 xVjYQEGHtcP36kNv9IDhRK7bvCggc8sCk3u0zQMXBevvaE39I8mEU2YVu7Yr+C4WY0zMyrcOW
 gJuVpaVBO6x/7hWUpzo1UtN0MU4Qgj2BHeeEvlFWey4s2qM9awhWSulZr7ngQZ9iHZHB0X5lf
 QuhqkuJbTvnfg6QYhZ2d61HkMVTuKa48axLcIFgF7ZVyWGuFiqSmyZo2auWwkC53mWVghnaiY
 DnewpWi8217eUNmZ97Ff4NVjQFINP/o0JM/zMKmwI1KNVFSvLtdsEjobF8JJaDyeXOXK8lE+k
 xCOuHZNx4VtAkLaaq2wYKGnsqwkZ4JjA5KxVERo2g3Qcaj0lGqOp5UAQAXLhzjHFMNlJrZnDR
 iWzxoTUElJnzmhISSk8VfCAZvLSZ8KLB9/xb4RcDYQMqeRs5brkzhy9Lwg/TPWK1zOiG+ZJGc
 5JaVTDk7GpLfGq6aaPvAELsX08+NSvRiaguB3ZLB8hS8k+E5Gm+nP0Ji+N68yKXFQCV0lvQTo
 RlCvAfVDsPFWho58d6Dq9gng==
Subject: Re: [cocci] Searching for macro calls besides function
 implementations (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1955
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/656ad840-5a97-445d-8f70-5244402bc111%40web.de>

> The mentioned test output indicated a questionable function name generation.
Will it ever become possible to find macro calls (between function implementations)
which can construct further functions?

A tiny source code search approach (like the following) does not produce desirable
data processing results so far by the means of the semantic patch language
(Coccinelle software).


@display@
@@
*EARLY_PCI_OP(...)


See also:
https://elixir.bootlin.com/linux/v6.12-rc4/source/arch/sh/drivers/pci/common.c#L33

Regards,
Markus
