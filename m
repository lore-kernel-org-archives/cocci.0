Return-Path: <SRS0=ITTA=PZ=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C06EC433EF
	for <cocci@archiver.kernel.org>; Sat,  6 Nov 2021 06:44:51 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855C960ED7
	for <cocci@archiver.kernel.org>; Sat,  6 Nov 2021 06:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 855C960ED7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,213,1631570400"; 
   d="scan'208";a="2272101"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Nov 2021 07:44:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EDA9FE006A; Sat,  6 Nov 2021 07:44:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A2604E004C
	for <cocci@sympa.inria.fr>; Sat,  6 Nov 2021 07:44:45 +0100 (CET)
IronPort-Data: =?us-ascii?q?A9a23=3A3WB8haKaiNpWLV6VFE+RFJclxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHDt0D8k1T1SmzcZXj2OP6vYMTemLtxwOo2/o0oPu8DQzoNqS1BcGVNFHysb8?=
 =?us-ascii?q?5KdbTi6Bh6tZH3KdpWroHqKXqzyU/GYRCwPZiKa9kjF3oTJ9yEmjPjRHuSkUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWHULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssItO?=
 =?us-ascii?q?snqz6f0tirrz6bVXI1CoQAvL7xEEd/UTe0Y5iXBYYQUVKjzSA2dR419xJsbSxT?=
 =?us-ascii?q?x0oN+vCgozxVjECSX4kZPUekFPACT3l2SCJ9GXDeHT2xPtGD0wsO4AcvOFtDgl?=
 =?us-ascii?q?m6/YRIjMERguenO/wy6DTYuJrjc8iBNL6OZsW/HBm1zDQS/g8Ka0v6Y2iCcRwh?=
 =?us-ascii?q?WhrwJkURLCAN4xJNHx1YQqGeBNVfFEaFPoDcC6TriGXW1VlRJi9/MLbO1Tu8TE?=
 =?us-ascii?q?=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ai2CNoamHcsDZdRnIdusoS/RVQMXpDfJG3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw+PrBoB12737JYUgqN03I8OroUMK9qBjnn6Kdj7N9AV7bZmXbhF?=
 =?us-ascii?q?c=3D?=
X-IronPort-AV: E=Sophos;i="5.87,213,1631570400"; 
   d="scan'208";a="2272100"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2021 07:44:46 +0100
Date: Sat, 6 Nov 2021 07:44:45 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Luis Chamberlain <mcgrof@kernel.org>
cc: Vlastimil Babka <vbabka@suse.cz>, cocci@inria.fr
In-Reply-To: <YYVZva1hfwanXdyB@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.22.394.2111060744320.2974@hadrien>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz> <YYVZva1hfwanXdyB@bombadil.infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Need some help with spatch
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 85
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111060744320.2974%40hadrien>



On Fri, 5 Nov 2021, Luis Chamberlain wrote:

> On Fri, Nov 05, 2021 at 05:12:09PM +0100, Vlastimil Babka wrote:
> > 1) patching complex variable declarations;
> >
> > I need to perform changes such as:
> > -struct page *page;
> > +struct slab *slab;
> >
> > This I was able to somehow specify in the .cocci, but not for situations
> > where the original declarations looks like this:
> >
> > struct page *page, *page2;
> >
> > or
> >
> > struct page *page = NULL;
>
> For this, this seems to work well:
>
> @@
> @@
>
> -struct page
> +struct slab

Agreed.

julia
