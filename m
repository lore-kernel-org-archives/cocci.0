Return-Path: <SRS0=AtCD=PY=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2E9C433F5
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 20:56:52 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBD460EDF
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 20:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EBBD460EDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AwxWJiKmnSZSvURX2eYAgT/Lo5gyQJ0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzIPzDAeCmqPOfeIZGejf4gibIS19EtTvJKGmtRrSQZu+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x8hGQ6YnSHuClUbe?=
 =?us-ascii?q?cZ3gqLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTaVwPWreUPA6Ui3MQVbLKbhpq/3ZilPdgcqNCMwEO1W3hc9NZkb2hsbS7T?=
 =?us-ascii?q?gwiP+jLh+IQSTFZFTt/NOtI4tcrJFDl65HKlxeYG5fr67A0ZK0sBqUT/e18AEl?=
 =?us-ascii?q?H7/cYKS4AdFaAiviwzbb9TfNj7uwpLdLwLY0Rkn5lxDDdS/0hRPjrSKLH49Je9?=
 =?us-ascii?q?Dg1j8FKW/3ZYqIxZTNpKhaGfBxLPlYeDYkWk+Khh325eDpdwHqZrLQ273PUygB?=
 =?us-ascii?q?/37zFP9/ce9jMTsJQ9m6UqyTd+HnrC1cRM8aSzyaE9Fqjg+bOmWXwX4d6PLaj6?=
 =?us-ascii?q?/pukXWcwWscDBBQXly+ydGzh0izV9NcN2QU9ysooO4o80eoVbHVVBm/p2WsvB4?=
 =?us-ascii?q?XX91XCKsx7wTl4qbd5QeUAi4AQyxKYdohnMs3QzUw0RmOhdyBLTdvqryOVXWF9?=
 =?us-ascii?q?vGeqj6yPDccKWMPfwcATA0P4sWlq4Y25i8j5P4L/LWdlsfyFXT0wiuWoTMj3uV?=
 =?us-ascii?q?VjMgR1qz980qvvt5lnbCRJiZd2+kddjPNAttFWbOY?=
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="2251026"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2021 21:56:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D19E3E006B; Fri,  5 Nov 2021 21:56:48 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 06BEFE004C
	for <cocci@sympa.inria.fr>; Fri,  5 Nov 2021 21:56:43 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ALo2N7qvq5BMjKhLYioxEdCvD7skDcdV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZsgviMc5Ax6ZJhko7G90cq7MBbhHPxOgbX5VI3KNDUO+l?=
 =?us-ascii?q?HYT72KhrGN/9SPIUHDH6JmpMVdWpk7OZnLAV92gd2S2mSFOtwrqePpzJyV?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398383018"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 21:56:42 +0100
Date: Fri, 5 Nov 2021 21:56:42 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Vlastimil Babka <vbabka@suse.cz>
cc: cocci@inria.fr
In-Reply-To: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2111052154260.3000@hadrien>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Need some help with spatch
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 76
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111052154260.3000%40hadrien>

> 4) unnecessary indentation changes for multiline function declarations or calls
>
> This is the least critical, but maybe there's a way to preserve original
> indentation and not do reindenting like this?
>
> -static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
> -               void *freelist_old, unsigned long counters_old,
> -               void *freelist_new, unsigned long counters_new,
> -               const char *n)
> +static inline bool cmpxchg_double_slab(struct kmem_cache *s,
> +                                      struct slab *slab,
> +                                      void *freelist_old,
> +                                      unsigned long counters_old,
> +                                      void *freelist_new,
> +                                      unsigned long counters_new,
> +                                      const char *n)

You can try the --smpl-spacing argument.  The original idea of that was
that people might like to put eg

+ if ( x )

Without the --smpl-spacing argument, Coccinelle would drop the spaces
around x.  With the argument, the code will be written as is.  But for
your case, it seems that --smpl-spacing also eliminates the reindentation
of function headers and function calls, when one of the
parameters/arguments changes.

julia
