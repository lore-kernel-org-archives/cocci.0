Return-Path: <SRS0=h9ga=P2=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59261C433F5
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 13:22:29 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF9E61215
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 13:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2DF9E61215
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AD73e0609apxLhEWIVvbD5cBwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ3Wtz3mBRzTMdWmDTO/iLMWL0fdx2bNvgoEtVsMXXnNQ2QQE+nZ1PZyIT+?=
 =?us-ascii?q?JCdXbx1DW+pYnjMdpWbJK5fAnR3huDodKjYdVeB4EfyWlTdhSMkj/jRH+KjULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YDdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?+g7PjewsLRKTTNE6AkBK6WYD72EgE93d0i/hhcqNCMS+7iB3Q9zx14N5KvpexD?=
 =?us-ascii?q?AA2OKDWsOUbSRhRVS9kVUFD0OWcfifi6pb7I0ruNiGEL+9VJEoxNoYZ0u9tCmF?=
 =?us-ascii?q?P6/ECbjMAdBaOg6Sx2r3TYuNtnd8yIsfDM4YWu3UmxjbcZd4tRp3FTqPi6tpR3?=
 =?us-ascii?q?TN2jcdLdd7Sbsxfa3xwbRDEYhRKIX8YDZs/mKGjgXyXWzFRtlOZvq0x72bcyCR?=
 =?us-ascii?q?+1bHsNJzefdnibclY2F2fu3DPuW/+GBwcKN2Z4TWA+3OowOTImEvTU5kPELmp3?=
 =?us-ascii?q?vFth1KXyyoYDxh+fVG2p/S1i02ic9JSKkoZvDAppqspnGSgSt76RDW6oHWAuRk?=
 =?us-ascii?q?HHdFXFoUS5AiLy6fQpQKUFGMNSDlpbN0gvdUxAzsw2TehlNPzBCdzt6WVD3ia+?=
 =?us-ascii?q?7eRsjq2NSUPBWsDYyUFUU0O5NyLnW2ZpnojVf57Cqm5y9n0Ai392C3T/G4/ga8?=
 =?us-ascii?q?ShIgFzc2GEZn8q2rEjvD0osQdv1+GNo590j5EWQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,216,1631570400"; 
   d="scan'208";a="2377532"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2021 14:18:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E9F4FE0295; Sun,  7 Nov 2021 14:18:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CF21EE004C
	for <cocci@sympa.inria.fr>; Sun,  7 Nov 2021 14:18:09 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AGWARl6hwhNTBtSzC3V3qLyjm13BQXt0ji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1173TJYVoqMk3I3OrgBEDiewK4yXcW2+ks1N6ZNWHbUS?=
 =?us-ascii?q?mTXeJfBODZrQEIdReTygcQ79YDT4FOTOy1N1R8gMrgiTPUL/8ryrC8n5yVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398456140"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2021 14:18:09 +0100
Date: Sun, 7 Nov 2021 14:18:08 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Vlastimil Babka <vbabka@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>, 
    cocci@inria.fr
In-Reply-To: <000e221f-1bac-6e29-8c68-2c1eab5b2128@web.de>
Message-ID: <alpine.DEB.2.22.394.2111071417560.2988@hadrien>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz> <a02a8c42-011d-0f9c-6a2f-7d45a3f216a5@web.de> <alpine.DEB.2.22.394.2111071321530.2988@hadrien> <000e221f-1bac-6e29-8c68-2c1eab5b2128@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] mm/slab: prepare for struct page conversion by spatch
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 90
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111071417560.2988%40hadrien>



On Sun, 7 Nov 2021, Markus Elfring wrote:

> > > * Will any guidance help to find nicer solutions?
> >
> > Luis already proposed a perfectly reasonable solution.
>
> His proposal can look a bit too terse (for affected implementation details),
> can't it?
> https://sympa.inria.fr/sympa/arc/cocci/2021-11/msg00017.html
> https://lore.kernel.org/cocci/YYVZva1hfwanXdyB@bombadil.infradead.org/
>
> @@
> @@
> -struct page
> +struct slab

It looks fine to me.

julia
