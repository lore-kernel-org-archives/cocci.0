Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521B2C47DD9
	for <cocci@archiver.kernel.org>; Sun, 25 Feb 2024 15:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BRp2cdCuojYChRMgN5rmyZlEdEwsOKWAb84ogvaiYjo=;
  b=O+GZ9Z476sQMQCcTl42P1JHiORR8BfjwGPcOYYWX50A0JoBQ9qZd9/fW
   oAIFddbtjgcHr9zxI9m1TtDcQpBXv4GKnR5txvQ4qEHkxCWL9as6QIx1R
   l1FzTtaoLCo3ebBAQwC5BegaJ9pC9IjF5mY0oploWLZAK7WTIY1nUmKOa
   4=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,185,1705359600"; 
   d="scan'208";a="153671121"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2024 16:34:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D03AAE0CD9; Sun, 25 Feb 2024 16:34:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 90F1BE008A
	for <cocci@sympa.inria.fr>; Sun, 25 Feb 2024 16:34:04 +0100 (CET)
IronPort-SDR: 65db5deb_ZnwojsJYYXNENo5Pg6WOiJzpWSp2WxOdga45FDRqoFZh+p4
 83ZGZrrSGKZCn1w/3iHq72ZhgEccqRztWvLkzYQ==
X-IPAS-Result: =?us-ascii?q?A0FEAACkXNtlhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4gVIyBAtIhFOPRIF1MIQ7hziHTohwgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEhHYJAoduAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBASMXBw4QJ4VsDYJcARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQ?=
 =?us-ascii?q?QECAgEjHQEBEScECwsaAiYCAlYGARQBAYJ8gisBAw4jB656gTKBAYIKAQEGr?=
 =?us-ascii?q?1wfLCJWgWEJgRouAYglAYVvhDwnD4FVRIE8glIxPogegmigaVR/HAOBBQRcD?=
 =?us-ascii?q?RsQHjcREAUODQMIbh0CMToDBQMEMgoSDAsfBVQDQAZJCwMCGgUDAwSBLgUNG?=
 =?us-ascii?q?gIQGgYMJgMDEkkCEBQDOAMDBgMKMTBVQQxQA2QfMgk8CwQMGgIbFA0kIwIsQ?=
 =?us-ascii?q?AMJChACFgMdFgQwEQkLJgMqBjYCEgwGBgZdIwcPCQQlAwgEAxAbKQMgdBEDB?=
 =?us-ascii?q?BkHCwd4ggmBPQQTRAMQgTSKJgyDEQMZKx1AAgELbT01CQsbBiIBHQKiOnOCL?=
 =?us-ascii?q?KULoRo0B4I1gWCBYQyfOQYTL4NyAZM+DgaSYphaIKhZgWsDMIFcMxokgzZPA?=
 =?us-ascii?q?xkPjiAZhBSPR0I1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 NTCxvubwNJq7N/eu8cRVZC8FQ==
IronPort-Data: A9a23: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
 FUI
IronPort-HdrOrdr: A9a23:2WQJHalKZXnYviHrFmjQIJW3xDjpDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:KHhxHmOFwc0lGu5DG3Nd2Ws3QeEcXlb+wVnuIR/mByVoV+jA
X-Talos-MUID: 9a23:D1QWkwtIv22b5+o2Mc2nhwpsBchN846UUWMcrKwmuOi2BCxbAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,185,1705359600"; 
   d="scan'208";a="153671109"
X-MGA-submission: =?us-ascii?q?MDE9jwvUtxuf4NXcyi5OukU/DwXWZ+GvwHyGAs?=
 =?us-ascii?q?64/hRS8x6k7ZA65RowM4s0mxzIR0JfWrP/9XRj4Y4rBpSEbMeyRWgV2c?=
 =?us-ascii?q?hNrJsaj+3CWY+1AgHTwzWBGFWhnbsaDy7ZpGFEqgYNlK5NmT3aiHrGVL?=
 =?us-ascii?q?oOPdm/wCFfx+0mY4wEkCqF2g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 16:34:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708875243; x=1709480043; i=markus.elfring@web.de;
	bh=y/CDs/DrfiwNFq2tq3REbPjc1XZSySg8MJ9qLPYMbcc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=on/xbqEU5GRv0SBUueN5EOhpj4VtxGuxcGoPeul2iibwW6OfAn7mvrjR+gYX7S8d
	 w8xfi68wel8ObhRv0kYLBCmg1uLXcgAstvS+sSce9sYuFIgt+vB1e9hPHY7EoxjCl
	 x1kmasp0VGlPYcP/T4GbClge9ELYAlxfmEmG+wtp2ioNC9sfpMkuAVh+6p7ht4q85
	 9vp9xi4RMV+5buhIjwcwi8UsUpN/rG+eted+VQpLv3YrHU8ar1apScqVkYANYDCYQ
	 HKBaulhlaBkEG7uzRbBdA0GIAhJ0iFgo/Qhv32I7C7K1jIKaKT6ip3tHR0agt6hpP
	 HEeOxxAWG+ZzXA+pXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECGX-1rnv141BKf-00AO6a; Sun, 25
 Feb 2024 16:34:03 +0100
Message-ID: <3d07b481-066e-49b1-96c0-e63391975ad8@web.de>
Date: Sun, 25 Feb 2024 16:33:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <814fc9f8-9ef1-42fc-ae9f-ef8d4a82979a@web.de>
 <8548519-fb2f-5860-bd86-3a4d20669c5c@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8548519-fb2f-5860-bd86-3a4d20669c5c@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zreZsY00hb7rRWzTcN6aPzzkt7G2xS0w9HKBTTjRM2SEYpdQ44A
 VIAPw0UUqlaaHZnSywEcFgsPOKExwBI85DDVq3qGzWpdbXhYeNf2+cUYFNyFkXin3jocL/L
 K7JSWVlkRv6vSYIwS0qWODu8lqpc1i01zJc40elC1o6FGnmMNgmTVlzJu7XcVI1862auyHc
 dGVA+tqViEUexLim/VfCA==
UI-OutboundReport: notjunk:1;M01:P0:h8jpLC0bTrA=;0bcwLII7M5711NBUhMNjqloRbRf
 ydQqlPsYSQyN9SD7Eese14DorvvMLnKpjA81hhPaLWgiHVaX9xkFXNrtLmlQS7dgQZYASJ0EV
 B8gWC8MknhW+mF+MopjmuG/na1ftm2qxoAVMkMINfak4XC8G1pCZav9hGm4yc4UZkg7BgqAaE
 PpJ+dy3YRPhu4AjjufpDUElzIVDYvavHgPk1fgtuFp+tW1DtDFoFlVh8AhSOYLMNjVSnRylQD
 flptbSabHT7hHEmPDkCl8oU1bXq+KHLspLGAtNE2xA6Dp9fIAiGxLcCkHmEeCyyC1sSFYFGQU
 EMjGVsDU34itLtL5YPpDiVhtFXKWj3XS668PyGs3q0unXpDJsutaM4VsZOJLvR+dN9VVC3HbE
 JdNsTbvDg3SLZIuB2m3WDsWbAF/pSjtMQwc/2zrn5+UDfPr7kciBhIcDpfQNIU0P7GVY2npMR
 9TqrarKncZz0z5/EwP/20YAEGhVidUD7YXBVeLMuzb7iO8a9gF7WEQyaJZjLl3HFfgUEVZtsI
 vYgeKfctEWxq2lXEnE+9IR4g4xFNbqZ2XuZLvy2McVJNi8+HXML07K2d7EmwwJFNbEsO9FyV3
 o+P8rk+hjffnEJmhUuMyArn85lpDj769ZaJ5JNHaaeWEEU0g4pV7JbYWvTb29N+GWkRR8wudN
 2XTRduK8vxBLNALGzYfcstWsN9T4eL1vRyeF4YYznqxg0LXN+GQbWZRa46k510UlDYlmkCBhl
 zfxySZBDqPs/rgQQMpvyR7z9KH18DAjAjGfrlzxIqstIBr5NGX7uTRLYDsJ0X8x134BFZTbKq
 bWVr5P9MjntmYq+N/AZ8soxV+0OmPbpbZL7VN7OXb2Yyo=
Subject: Re: [cocci] Searching for code within block by SmPL ellipsis?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1604
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/3d07b481-066e-49b1-96c0-e63391975ad8%40web.de>

> The fact that no * is detected does seem like a problem.

Will variations of a source code search approach (like the following)
including the usage of a combination of SmPL asterisk and ellipsis
between curly brackets become supported?

@display@
@@
 {
* ...
  ;
 }


Regards,
Markus
