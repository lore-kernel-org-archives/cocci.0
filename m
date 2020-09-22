Return-Path: <SRS0=Ti52=C7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FA7C2D0E2
	for <cocci@archiver.kernel.org>; Tue, 22 Sep 2020 13:15:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5AA52396D
	for <cocci@archiver.kernel.org>; Tue, 22 Sep 2020 13:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AA52396D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08MDEpvn023938;
	Tue, 22 Sep 2020 15:14:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B98B64452;
	Tue, 22 Sep 2020 15:14:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CB11C4316
 for <cocci@systeme.lip6.fr>; Tue, 22 Sep 2020 15:14:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08MDEo5g010672
 for <cocci@systeme.lip6.fr>; Tue, 22 Sep 2020 15:14:50 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.77,290,1596492000"; d="scan'208";a="468967084"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 15:14:50 +0200
Date: Tue, 22 Sep 2020 15:14:50 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <245d6cf2-438b-ed0c-ac60-d5448b408cb2@web.de>
Message-ID: <alpine.DEB.2.22.394.2009221514260.13096@hadrien>
References: <f3c1a592-e179-69bf-33df-15fce69a2cb9@web.de>
 <alpine.DEB.2.22.394.2009211521430.2630@hadrien>
 <38815e95-833b-e2fd-4630-8ae7cfe54aa7@web.de>
 <alpine.DEB.2.22.394.2009211547540.2630@hadrien>
 <12c105f8-80e3-b47d-3bc5-141d6011fe89@web.de>
 <alpine.DEB.2.22.394.2009211626370.2630@hadrien>
 <1367af30-cbff-dd2d-f17d-5b9464fad359@web.de>
 <alpine.DEB.2.22.394.2009221227380.2659@hadrien>
 <cf0e8aa0-67f0-966c-4fa4-6942331069a6@web.de>
 <alpine.DEB.2.22.394.2009221436350.2659@hadrien>
 <eaacd91c-4752-2031-266f-243557dd0f72@web.de>
 <alpine.DEB.2.22.394.2009221453480.2659@hadrien>
 <245d6cf2-438b-ed0c-ac60-d5448b408cb2@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 22 Sep 2020 15:14:52 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 22 Sep 2020 15:14:50 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Searching for functions with linkage specifications
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



On Tue, 22 Sep 2020, Markus Elfring wrote:

> > I think you can follow the model of other kinds of disjunctions.
>
> Which (OCaml) modules do take care of the corresponding data processing?

Probably all files in parsing_cocci and cocci_vs_c.ml

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
