Return-Path: <SRS0=AtCD=PY=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77845C433EF
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 21:31:22 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B616109F
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 21:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95B616109F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3A/ScDdK/YhRutOzTEENP2DrUDkX+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUom32EOmjMaC22Baf2Ia2CheNB0O4q09hlU6sLQy9RgQVdlrnsFo1Bi+?=
 =?us-ascii?q?ZOUX4zBRqvTF3rPdZObFBoPA/3z27AsFehsJpPnjkrrYueJQUVUj/nSH+OlULO?=
 =?us-ascii?q?cYUideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf9s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kuq3qd1UDBL/UJwmHzHRMM0SgqkEY9mpjieBiaqBaMBkP49mKt4kZJNFlvpu7Q?=
 =?us-ascii?q?gZsObLKlf41Uh9CEig4M7cuFLrveyLi6pHKlyUqdFOpmZ2CFnoeNooT8edfCHt?=
 =?us-ascii?q?F9f0GJSpLbR2Zge+yhrWhRYFEjMU4N9jlMqsQv3hhyXfSCvNOaZvETqPH4/dX2?=
 =?us-ascii?q?T4xgoZFGvO2T8YQb3xtKgvBZxlOM1IMIJ07leaswHL4dlVwpFuLpKYs5G7fwgN?=
 =?us-ascii?q?1+LfoOdvRPNeNQK19kkvevWXb7W2/CRYAOdqDyDyt/Xelh+uJliT+MKoZD6C88?=
 =?us-ascii?q?u9Cj1qUyWgeThYRUDOTq/S/h0K/WM53K0EV/Cdot68591fDZtL5WBqjiHyEtRo?=
 =?us-ascii?q?bXMEWGOo/gCmBw6zV7gLfAmUWRTdHb/Qitck/Xzts0UWG9/viBSZuq6GSUXLb/?=
 =?us-ascii?q?LCZrTatMCwZIHUqYS4CRwoZpdLkpekOYrjnJjp4OLavidGwHTDr3z2RsXFuwbQ?=
 =?us-ascii?q?Vl88CkauhlW0rSgmE/vDhJjPZLC2ONo590j5EWQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="2253510"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2021 22:31:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 09B37E0295; Fri,  5 Nov 2021 22:31:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BE880E004C
	for <cocci@sympa.inria.fr>; Fri,  5 Nov 2021 22:31:16 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A4WbMi6zUViBr5GvgWJmCKrPwl71zdoMgy1kn?=
 =?us-ascii?q?xilNoNJuE/Bw8Pre+sjztCWE7wr5PUtLpTnuAsS9qB/nmaKdpLNhXotLsmHdyR?=
 =?us-ascii?q?eVxcJZnPbfKwSJIVyAygcl79YfT0EdMr3N5ClB/KLHCVKDYq8dKbC8mcjCuQ6d?=
 =?us-ascii?q?9QYOcegNUc5dBmxCe2Om+yNNKjWuLKBJZaa0145opyeAZX9SVciyHH8DNtKz3e?=
 =?us-ascii?q?HjpdbJYQMmGxVi0wWFjSqp5LnmeiLopSs2YndgwaoC7WOAqADy5ryiv/anjjfQ?=
 =?us-ascii?q?2nTe9Y4+oqqQ9vJzQOKNl+kIIXHXhgGkaJ8JYcz7gAwI?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398384434"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 22:31:16 +0100
Date: Fri, 5 Nov 2021 22:31:15 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Vlastimil Babka <vbabka@suse.cz>
cc: cocci@inria.fr
In-Reply-To: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2111052230480.3000@hadrien>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Need some help with spatch
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 80
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111052230480.3000%40hadrien>

> 3) eliminated whitespace including newlines
>
> This is stylistic but will require some postprocessing fixups if not solved.
> There seem to be several cases like this where whitespace including newlines
> is eliminated between two lines that are patched by the spatch:
>
> -       struct page *page;
> -
> -       page = container_of(h, struct page, rcu_head);
> +       struct slab *slab;slab = container_of(h, struct page, rcu_head);

Which semantic patch causes this problem?

julia
