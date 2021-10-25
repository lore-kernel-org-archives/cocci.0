Return-Path: <SRS0=o+tk=PN=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB98C433F5
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 19:55:36 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5253F60C49
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 19:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5253F60C49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3ASUtr86jcyAToS554ln0qk6MTX161dhEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUHmzEXCGzSOfjYZDCmeY12aIuypxsC6p+ByNA2GQo4qXw8FHgiR?=
 =?us-ascii?q?ejtVY3IdB+oV8+xBpSeFxw/t512huEtnanYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?cYH0pH2eIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYsWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WlYbR6bbewmIkHtfHaa46vRAjnVoguBqb7xFNx0R0mvR9zxy4IwlWZiYQ?=
 =?us-ascii?q?gAiNayJn/sbXgNwEidkPKQA9qWvzX2X7ZXInxSYG5fr67A0ZK0sBqUT/e18AEl?=
 =?us-ascii?q?H7/cYKS4AdFaAiviwzbb9TfNj7uwpLdLwLY0Rkn5lxDDdS/0hRPjrSKLH49Je9?=
 =?us-ascii?q?Dg1j8FKW/3ZYqIxZTNpKhaGfBxLPlYeDYkWk+Khh325eDpdwHqZrLQ273PUygB?=
 =?us-ascii?q?/37zFP9/ce9jMTsJQ9m6UqyTd+HnrC1cRM8aSzyaE9Fqjg+bOmWXwX4d6PLaj6?=
 =?us-ascii?q?/pukXWcwWscDBBQXly+ydGzh0izV9NcN2QU9ysooO4o80eoVbHVVBm/p2WsvB4?=
 =?us-ascii?q?XX91XCKsx7wTl4qbd5QeUAi4AQyxKYdohnMs3QzUw0RmOhdyBLTdvqryOVXWF9?=
 =?us-ascii?q?vGeqj6yPDccKWMPfwcATA0P4sWlq4Y25i8j5P4L/LWdlsfyFXT0wiuWoTMj3uV?=
 =?us-ascii?q?VjMgR1qz980qvvt5lnbCRJiZd2+kddjjNAttFWbOY?=
X-IronPort-AV: E=Sophos;i="5.87,181,1631570400"; 
   d="scan'208";a="413816"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2021 21:55:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 90DA0E001B; Mon, 25 Oct 2021 21:55:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C13CBE0015
	for <cocci@sympa.inria.fr>; Mon, 25 Oct 2021 21:55:27 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ABqODQqq/rIORDC9FcoT+qJ8aV5ojeYIsimQD?=
 =?us-ascii?q?101hICG9Ffbo9fxG/c5rtiMd6l4qMk3I/OrsBEDuex/hHPJOkO0s1NSZPDUOxl?=
 =?us-ascii?q?HYSb2KhLGKq1bd8kbFmNK1u50OT0EzMrzNMWQ=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397330067"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 21:55:27 +0200
Date: Mon, 25 Oct 2021 21:55:27 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Sean Anderson <sean.anderson@seco.com>
cc: cocci@inria.fr
In-Reply-To: <3b48efa4-4bff-0990-8b21-fffc14cd47e1@seco.com>
Message-ID: <alpine.DEB.2.22.394.2110252154510.2956@hadrien>
References: <3b48efa4-4bff-0990-8b21-fffc14cd47e1@seco.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] IRC channel
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 39
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/alpine.DEB.2.22.394.2110252154510.2956%40hadrien>



On Mon, 25 Oct 2021, Sean Anderson wrote:

>
> Hi,
>
> On the Contact page [1], it says that there is an IRC channel #cocci on
> irc.freenode.net. Is this still accurate?

I haven't connected in a long time...  If you have questions, the mailing
list is probably a better choice.

julia
