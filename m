Return-Path: <SRS0=kVpy=LR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95431C4743C
	for <cocci@archiver.kernel.org>; Wed, 23 Jun 2021 08:54:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E1A611AD
	for <cocci@archiver.kernel.org>; Wed, 23 Jun 2021 08:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E1A611AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 15N8sUc6015377;
	Wed, 23 Jun 2021 10:54:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 682A34108;
	Wed, 23 Jun 2021 10:54:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1653C3783
 for <cocci@systeme.lip6.fr>; Wed, 23 Jun 2021 10:54:29 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 15N8sSAL008947
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 23 Jun 2021 10:54:28 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AUHW4RqGLwIzQJ/EApLqFBZHXdLJyesId70hD?=
 =?us-ascii?q?6qkvc3Fom52j/fxGws5x6fatskd2ZJhSo6H4BEDgewKVyXcR2+Us1NiZLW3bUQ?=
 =?us-ascii?q?eTTb2KjrGSiAEIeReOkdK1vJ0IG8cRNDSaNykYsS+O2njcLz9W+qjkzEnHv4fj?=
 =?us-ascii?q?5kYoaTsvR7Br7g9/BAreOFZxXhN6CZ0wE4fZztZbphK7EE5nI/iTNz0gZazutt?=
 =?us-ascii?q?fLnJXpbVotHBg88jSDijuu9frTDwWY5BEDSDlCqI1SvVQt0jaJqZlLgcvLiyM0?=
 =?us-ascii?q?5FWjr6i+X+GRieerMfb8xPT97A+cyDpAKr4RHoFq9wpF2N1HoGxa6+Uk5S1Qdf?=
 =?us-ascii?q?ibokmhBF2dsF/j3RLt3y0p7GKnwViEgWH7qci8Xz4iDdFd7LgpBicxxnBQzu2U?=
 =?us-ascii?q?6pg7ql5xdqAnfC/ojWD4/ZzFRhtqnk27rT4rlvMSlWVWVc8bZKVKpYIS8UtJGN?=
 =?us-ascii?q?NYdRiKnrwPAa1rFoXR9fxWeVSVYzTQuXRu2sWlWjA2Eg2dSkYPt8SJ23xdnWx/?=
 =?us-ascii?q?zUEf2MsD901wg67Vi6M0lNgsF54Y3Y2mYvVmEp6VNd1xMfdfUFa9PS4kGFjiX2?=
 =?us-ascii?q?gPOpt3Rk7wlw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.83,293,1616454000"; d="scan'208";a="385892741"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Jun 2021 10:54:28 +0200
Date: Wed, 23 Jun 2021 10:54:27 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Fuad Tabba <tabba@google.com>
In-Reply-To: <CA+EHjTxxAb4fsg1bUi2E1FpNjOXFrRCFvw9CzDyquSQ5fWA5Ew@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2106231052390.91948@hadrien>
References: <CA+EHjTxxAb4fsg1bUi2E1FpNjOXFrRCFvw9CzDyquSQ5fWA5Ew@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 23 Jun 2021 10:54:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 23 Jun 2021 10:54:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Adding a newline after a variable definition
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On Wed, 23 Jun 2021, Fuad Tabba wrote:

> Hi,
>
> I have a semantic patch that inserts a new variable definition into a
> function. I would like it if that variable definition is the only one
> in the function, then it should add a new line to separate the
> definition from following statements (Linux code formatting style).
>
> I thought that doing this in two steps might be easier, i.e., add the
> definition, then check and add a newline if a statement follows:
>
> @@
> identifier x;
> identifier func;
> statement S;
> @@
> func(...)
>  {
> struct kvm_cpu_context *x = ...;
> + newline;
> S
> ...
>  }
>
> The above works as expected, and it adds "newline;" after the
> definition of x. The thing is, is it possible to add an actual new
> line, as opposed to a non-whitespace string? I tried just using a +
> but that didn't work.

I think that the problem is not that the change is not being made, but
that spatch doesn't think it's worth showing you the change, since the
only change is in the whitespace.  Try adding the argument --force-diff

Note that you can cause this argument to always be used with your semantic
patch by putting

#spatch --force-diff

at the top of the file.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
