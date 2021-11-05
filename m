Return-Path: <SRS0=AtCD=PY=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A062C433EF
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 21:13:52 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7D961157
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 21:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C7D961157
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AGi8DQq/SgrOaWjDRvhjSDrUDkX+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUom1mQBmGUXDW7TO/jbZ2b9c4wgb4+xpEoGscTSzYRiSldlrnsFo1Bi+?=
 =?us-ascii?q?ZOUX4zBRqvTF3rPdZObFBoPA/3z27AsFehsJpPnjkrrYueJQUVUj/nSH+OlULO?=
 =?us-ascii?q?cYUideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf9s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kuq3qd1UDBL/UJwmHzHRMM0SgqkEY9mpjieBiaqBaMBkP49mKt4kZJNFlvpu7Q?=
 =?us-ascii?q?gZsObLKlf41Uh9CEig4M7cuFLrveyLi65DCkyUqdFOpmZ2CFnoeNooT8edfCHt?=
 =?us-ascii?q?F9f0GJSpLbR2Zge+yhrWhRYFEjMU4N9jlMqsQv3hhyXfSCvNOaZvETqPH4/dX2?=
 =?us-ascii?q?T4xgoZFGvO2T8YQb3xtKgvBZxlOM1IMIJ07leaswHL4dlVwpFuLpKYs5G7fwgN?=
 =?us-ascii?q?1+LfoOdvRPNeNQK19kkvevWXb7W2/CRYAOdqDyDyt/Xelh+uJliT+MKoZD6C88?=
 =?us-ascii?q?u9Cj1qUyWgeThYRUDOTq/S/h0K/WM53K0EV/Cdot68591fDZtL5WBqjiHyEtRo?=
 =?us-ascii?q?bXMEWGOo/gCmBw6zV7gLfAmUWRTdHb/Qitck/Xzts0UWG9/viBSZuq6GSUXLb/?=
 =?us-ascii?q?LCZrTatMCwZIHUqYS4CRwoZpdLkpekOYrjnJjp4OLavidGwHTDr3z2RsXFuwbQ?=
 =?us-ascii?q?Vl88CkauhlW0rSgmE/vDhJjPZLC2ONo590j5EWQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="2252494"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2021 22:13:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 17183E006A; Fri,  5 Nov 2021 22:13:49 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C930BE004C
	for <cocci@sympa.inria.fr>; Fri,  5 Nov 2021 22:13:46 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AO8kVJqr3UTWYd8YhyP5qItIaV5oseYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG885x6faZslwssTQb+OxoW5PwJE80l6QU3WB5B97LYOClgh?=
 =?us-ascii?q?rKEGgI1+XfKlPbdxEWutQtt5tIQuxOTOf9ClV3lq/BjTWQGdxI+ra6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398383802"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 22:13:46 +0100
Date: Fri, 5 Nov 2021 22:13:45 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Vlastimil Babka <vbabka@suse.cz>
cc: cocci@inria.fr
In-Reply-To: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2111052212190.3000@hadrien>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Need some help with spatch
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 77
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111052212190.3000%40hadrien>

> for example the cocci patch is supposed to change all "page" to "slab", but
> some lines are patched like this:
>
> -       __free_slab(page->slab_cache, page);
> +       __free_slab(page->slab_cache, slab);

I assume that here you are using the semantic patch in 184d9494c1a4.  I
get that both occurrences of page are changed.  What version of Coccinelle
do you have?

julia
