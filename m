Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C583C0218F
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2025 07:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5BLD/YXsVrr465Xy+2dikLtLlRq1lKGR/pqrjopbAvs=;
  b=AaoYipyxBPWRVXA3c41BI6pLR6T3i4YMoVK5gnZJuMqsOS8gNC+WOS3B
   ViiMYVgpHBfHBJx3TyuG0D45ypXuJHqxlDr82AO6BnySAhg2civZgjbbw
   NUBS50s6acf5gQYKMSBoLbyoKCLGNvkaoLABVypqIdWWteHSD12zeSlle
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
X-IronPort-AV: E=Sophos;i="6.13,258,1732575600"; 
   d="scan'208";a="206421366"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Feb 2025 08:56:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 607F0E0D1E; Tue,  4 Feb 2025 08:56:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8A4E8E0260
	for <cocci@sympa.inria.fr>; Tue,  4 Feb 2025 08:56:39 +0100 (CET)
IronPort-SDR: 67a1c837_tmrD3mloL50b56ZzKYgYJ+ny0JzClrwQZ8AEQlgcGpJctFK
 FNuwOtshrTHDXshxB03QQExVJPkSO/5ppw3zFtQ==
X-IPAS-Result: =?us-ascii?q?A0F7AgCtx6Fng07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VMCgkJ9WjMEC0iEVo9PgXQwaYNSjxCIdYNUDwEDAQ07BgECBAEBAwMBOIRIA?=
 =?us-ascii?q?op9Ah4HAQQ0EwECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBO?=
 =?us-ascii?q?gcOO4V7DUkBEAGCBwGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQECDTpEAQEBAgEjHQEBESYBBAsLDgwCJgICVgYBEgIBA?=
 =?us-ascii?q?YJ+AYIvAQMOIwcNBrEggTKBAYIMAQEGgUYCDAJD2EIfLCJXgWUDBoEaLoVrg?=
 =?us-ascii?q?mMBhWs7hDwnD4FVRIE8C4J4PoJKFwOFOoJpgjOESmeiaFJ7HANZLAFVExcLB?=
 =?us-ascii?q?wWBKRA4AyAKNhQdAhQNEA8GEARtBTUKNzqCDWlJOgINAjWCHiRYgitrBAWBL?=
 =?us-ascii?q?YI7hEOEToJGVIJEghJ0awMDFhABgyV6HINIHUACAQttPTcGAwsbBj2eOD2FS?=
 =?us-ascii?q?AKCFaUHoTs0B4I4gWaBYwyKKZUzBhADL4Nxk1MOBpJ7LodkkGoii2mBeZsqg?=
 =?us-ascii?q?X4jgVwzGiSDNh8wAxkPjiEZH4N1gQuDVYoqAbk4QjUCOgIHCwEBAwmFRgEBi?=
 =?us-ascii?q?GGCCoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 YT5qa2ojq12pY4d3PuMo0JoJSw=
IronPort-HdrOrdr: A9a23:LkEG16PClaIQ5sBcThWjsMiBIKoaSvp037Dk7TEXdfUnSL38qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhbX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:3KY2gG/X+ksavZw3OZ6Vv24dAdEIXkLk93mTEXKqLWZQeIW5W2bFrQ==
X-Talos-MUID: 9a23:OdSHdwbxPVyeiuBTtRrIpBpJBJpT4ue2Blgrz8hY5NS6Knkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,258,1732575600"; 
   d="scan'208";a="206421352"
X-MGA-submission: =?us-ascii?q?MDHr4xOMP/4DsHqn2nml3JFyN7Ke9T4ZR1ro6b?=
 =?us-ascii?q?WPTIYHKmOtw6ve/G/5SYVNPluFhucKv/EbX8QrjzYdErKUZTr2bMa5Wp?=
 =?us-ascii?q?gp0iUxO2rYKO7IyvxN/Xx4gJC2DTMXSKCuhw61Wwk9QhpEjYyOSeL3pZ?=
 =?us-ascii?q?r3KG9w9DOp1Uo55wzg8xcZog=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 08:56:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738655788; x=1739260588; i=markus.elfring@web.de;
	bh=5BLD/YXsVrr465Xy+2dikLtLlRq1lKGR/pqrjopbAvs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VS8cyP0ZtaRn7Ltz9iSNzbc76UnXwmi60vJYLu8Iy+3H3yXtujIJZE1a95aAR/yP
	 9gsXJHhR1kXb+oB50IqSm71wuDH7Gh4FkhbNCZMXOOIp5x+1g/5qEr0wTNxdsUl74
	 5yzQGy2xw2WzWV2vxTR7T3l0jeqiewAAGzJ4YzHixUN0Ul4S7TQx3pFLRcYc48hEQ
	 QEKn85Ohbf3TWuKrMLbaUn8dEk6FHNiFoJy3yB93T6EOdKHKwvsriKxxK7iaWgp0V
	 Xi7htv5fhs4/xei0Zq700SN2DT/NBFm5W+W8fmuUnAt2tckUyOoqrnYBJgiZc4jxA
	 q+ff2Yla7sU0vsHpAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.16]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdO9K-1t5t2h442K-00gdth; Tue, 04
 Feb 2025 08:56:28 +0100
Message-ID: <49533960-e437-4042-951a-0221164bfa3d@web.de>
Date: Tue, 4 Feb 2025 08:56:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr,
 Andrew Morton <akpm@linux-foundation.org>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Ilya Dryomov <idryomov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Ricardo Ribalda <ribalda@chromium.org>, Xiubo Li <xiubli@redhat.com>
References: <20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com>
 <20250203-converge-secs-to-jiffies-part-two-v2-1-d7058a01fd0e@linux.microsoft.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20250203-converge-secs-to-jiffies-part-two-v2-1-d7058a01fd0e@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:aQc8RcrZc7c8bcNHaQ18iCrIJX16D9D0++QdETw7fZSrfDWQqsc
 K4Gk/cqtNbPZ4gSOIiWA/yDQecBHoggZG1iWIlf1browyUtzxnvEU7n+DPN5fyWA26YKWkI
 ZKtYClolm2KTwF1jw0ruRv8/iQ15ULWedSowFddVZQW3Ctia67sQ/eOv4Bwiat+amAPzRzW
 Gwj6TlyCQIJ5htGV5DZRQ==
UI-OutboundReport: notjunk:1;M01:P0:g9xXUJLcnkU=;BPnZKWpwl3c5/Z81VR1BJF2NLey
 7KmTDfH/dErzC57mKitzacacH5QWXShj7dWV31d+qLWzJcEtI1LHG9pbt1CynKTkcrkdJFAkl
 aTVATFbWRAiKBVj1S0WskrCik+niedHj3rXXJuHTid1iLShvda+2ddnAyuzUJCuiWRHncLXnI
 IZ4m64c2X2DWwJv6guJW2jJUfLtKAPVYUcu8N9KkXbaIGXvqeiMr71auJE4p6GGg4ZTLKNmn0
 JmscL4Jwe5MOz0YyQyJhCSAh9V6CFw9sND0IVmhV6eDi4jWDEqafCQwaiiZ8iAhh0/WIxK+nb
 kip0rSSptO79y1CfZEbzOXmPc1wBPDUmtmD5/QzhInOTjl1UqPGk5GDYw4jTbwYafatxp5xvp
 NzZhiT9jb44JLlBS9p1nW2sbo/ONakwvyoQnX+Ddzz0Njde5RkkZWC9dgNIBMIR8T9MtBhaMY
 5GjZ97gnvL1RigBNu9p0ovNQ/KtEy8avOOzXNyPXoYVk+YQSny4f3/niOL3lolUmpGE6a3HLY
 jtZQcc0QLfYq25/t7nyhtoCAoHuJ6CUJoYLb5K5hlq3ISTP+bS+GepLgo/Pt6NgIJ5xmAfR15
 g03gXL+jHbW6kS9SFZu+z8iewAb2Oy85zWtGhSp1Vgu9hL+ttETwanNZemEDesYoAkhYBqip9
 3DnFTHa4Ay9/VvyvHJ4wyXcypTylcsng4vHLBBsULGgHy2sVMUKWIZ8TtT8BdARS4AsGyElnZ
 f1SlkVkszVA8hDByqAcBNeBKirGIKjKWokP7QEkbDYNVJveJ2DArWXLPcEYw/bDlxV+wDPdnF
 x4fa0AWXaCGUGSujljRizjORr5EVnCo+SgU0pn8UI1Oaad6t+JMw2jOXCa+y25LhE3hYusZG1
 6Yv4kSv3e5Hj81Yw10uYjjHyzitolWuv8Ewbi1Y0Cu/HqmVdIlpQ0VuqelLxZ0tQLQFocOxKW
 S34hOQbQzebRXvPbduDdBe0dKDLTbjVcu7KnOQqTIgnChAdnd0WewxdOBmHJQXH0VkhgZbt69
 gmADZ3PJZS+x8rhXoiuMuT78s+au8M+4S1fYvgi+PRRchhC3OT1zB3eJPKKSv+r0AkzPH9cmp
 FqY+sRwfB6raXh48DoNM32mJJIxQuwPj0bpPFPHTwltJ7NPBjOorSmJ5cYKsHxtMIzSqi+PnC
 lwhuAuCDRgrBUyMZgwsfSdagK64Nc3MxGIkvC+9B6FttH6N+JIV9/o/N7MEUr++voAWGE52sc
 nJrzRJmRv5IUUAr2c9kn9hU1SN4wSQMb/QagvbzoBXT/6OYlmyZ1qhWDat6NRMRF9WJjqPq7U
 9VkVJ6ZREp7rOYzYJ8yLkB0T7Hi4ewJX3cnanqf1/cro/ERdUQlrksVO0529gNS5qm9
Subject: Re: [cocci] [PATCH v2 1/3] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2335
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/49533960-e437-4042-951a-0221164bfa3d%40web.de>

> Teach the script to suggest conversions for timeout patterns where the
> arguments to msecs_to_jiffies() are expressions as well.
How do you imagine that the shown SmPL code fits ever to patch reviews?

Examples:
* https://lore.kernel.org/cocci/80cae791-663c-4589-b67e-d4d1049fcd98@web.de/
  https://sympa.inria.fr/sympa/arc/cocci/2025-02/msg00002.html
  https://lkml.org/lkml/2025/2/3/151

* https://lore.kernel.org/cocci/e06cb7f5-7aa3-464c-a8a1-2c7b9b6a29eb@web.de/
  https://sympa.inria.fr/sympa/arc/cocci/2025-01/msg00122.html
  https://lkml.org/lkml/2025/1/30/307


Regards,
Markus
