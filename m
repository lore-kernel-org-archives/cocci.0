Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC10CE8E8B
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/bG56akzzDWoUqh2QxHd2GhlXR8ZYOKrA9EJ2AICNuo=;
  b=nc496hh7dOJ1Xax7Mg5tiDGZ2eVRFXRUdvjWYWNUhxy3Ua/lvQxMvnwK
   +yLNs+p/jQI36DAZ3I+FkUNeTo7MoywC38zMkyuMqH0w6cU8fjUYFlGUC
   4o6vtUGno0NwkhTqDW1PACgaS2dxeiRUcFpgQSpB+yGPMzP9ut4khkrPq
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190596017"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 17:35:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E3957E0D20; Thu, 24 Oct 2024 17:35:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 12ABEE0133
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 17:35:42 +0200 (CEST)
IronPort-SDR: 671a694d_vBoGnAIPlWQo4i/5WEcK+/7Y8XAvSCq3RLH6UH9lanBqA5/
 IDYxhYqB0QqB5lHktzfIl4bBbw6aKinuGkmXF1g==
X-IPAS-Result: =?us-ascii?q?A0HIAgBKaBpneROg6VVagQmBU4JEfVozBwhIhFaDT44in?=
 =?us-ascii?q?hSBfg8BAwENNQ8EAQEDAQOCDIJ0AookAh8GAQQyBw4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBEAEBBQEBAQIBAQIEBgECEAEBQg47hXsNgls7ghYsDX4BAQECASMVRgsLG?=
 =?us-ascii?q?gImAgJWGwEBF4JmAYJBIwMEsByBMoEBgxzbF4FmBoEaLoVqgmIBimAXEBUGg?=
 =?us-ascii?q?g2BPA6CPTg+hRCDDoJpBJIFi2oliS+RYlJ7HANZIQIRAVUTFwsJBYk1CoMcg?=
 =?us-ascii?q?W4mhBGBMxIBg1+BZwlhiEKBDIE+gVkBgzhKg0yBYQU4SYJNak43Ag0CN4Ikg?=
 =?us-ascii?q?QCCT4ElBAWDPIEpHUACAQttPTUJCxtDq3uBWUeDIH17SqU7oWmEJIwWlS4GD?=
 =?us-ascii?q?wQvg3KTThSSeJh3qSCBbgYtgVxNNASDIk8DGQ+OLRaDWMpRQjU7AgcLAQEDC?=
 =?us-ascii?q?Y8hgUsBAQ?=
IronPort-PHdr: A9a23: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
 yWUpdkovlL0yoGy
IronPort-Data: A9a23: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
 E7K
IronPort-HdrOrdr: A9a23:A6drA6r7jjycgOmN+tQk8joaV5ooeYIsimQD101hICG9Afbo9P
 xG+85rsyMc6QxhP03I9ursBEDtewK/yXcx2/h0AV7AZmXbUQmTRr2KPbGSpgEIcheWnoVgPO
 VbE5SWY+efMbEVt6fHCUWDfOod/A==
X-Talos-CUID: 9a23:kDpmX28ghyoCzw0o2IqVv1wdO8cGdlz79zDBKWGcLFgxeI+qSGbFrQ==
X-Talos-MUID: 9a23:N5Ot1gWnMrLaDgvq/ADHljNyNd1n34+jA3AGza4lkuy5bgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="99972091"
X-MGA-submission: =?us-ascii?q?MDEeIknZKAauWhK1RnFUo9OIi+eHW1Pj+KbzJo?=
 =?us-ascii?q?mBsLUd/uZwTvsS5zhrzW2374UAz1WH2JHkHUaOPGzXpB9MO1mccYjZ26?=
 =?us-ascii?q?fPp1tWZLeFRmHJla0mMQKQ8rZGX7TdX36AwFYxZqxgwNIkcd2vVevORd?=
 =?us-ascii?q?6O7vW7ybvPIMgP+hDoRyalkQ=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 17:35:41 +0200
Received: from [137.220.76.70] (helo=[192.168.1.187])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1t3zsC-0000000067M-5Wba
	for cocci@inria.fr;
	Thu, 24 Oct 2024 16:35:40 +0100
Message-ID: <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
Date: Thu, 24 Oct 2024 16:35:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
Content-Language: en-US
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Multiple returns significant performance impact
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 1923
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534%40knosof.co.uk>

Julia,

>> Is there an option that reduces the overhead, or perhaps
>> an alternative way of writing the pattern?
> 
> Maybe using when exists on the ....

Would checking an always true condition have the
desired effect?

> But the solution I proposed was created for precisely this problem.

I did not understand your comment about any position variable.

Would changing the current code
printf(",%s,%s\n", loc_2[0].line, loc_2[0].column)

to use
p[0].current_element_line
make a difference?

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com

