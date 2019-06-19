Return-Path: <SRS0=2Vp3=US=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDF0C31E49
	for <cocci@archiver.kernel.org>; Wed, 19 Jun 2019 08:11:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120B520679
	for <cocci@archiver.kernel.org>; Wed, 19 Jun 2019 08:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120B520679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5J8B7cN014165;
	Wed, 19 Jun 2019 10:11:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 531EF777F;
	Wed, 19 Jun 2019 10:11:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6FE0A7768
 for <cocci@systeme.lip6.fr>; Wed, 19 Jun 2019 10:11:05 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5J8B5Bu014706
 for <cocci@systeme.lip6.fr>; Wed, 19 Jun 2019 10:11:05 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,392,1557180000"; d="scan'208";a="388080285"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Jun 2019 10:11:05 +0200
Date: Wed, 19 Jun 2019 10:11:04 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8d56d773-2b91-3ed0-385c-cb2e8c3c3d72@web.de>
Message-ID: <alpine.DEB.2.20.1906191010530.3726@hadrien>
References: <f9e28910-d42b-cdea-31f4-1b084db33023@web.de>
 <alpine.DEB.2.21.1906162214390.2537@hadrien>
 <bbf7e602-0a78-9595-31b1-b4dc70195df2@web.de>
 <alpine.DEB.2.21.1906170747030.2965@hadrien>
 <20258ea9-f69b-a0c2-01ed-e3ee8681bdf0@web.de>
 <alpine.DEB.2.21.1906170807290.2965@hadrien>
 <f66261cf-b6d1-5b2c-7756-a17585cc0ce6@web.de>
 <alpine.DEB.2.21.1906170830240.2965@hadrien>
 <c5a19a87-4948-196c-4f74-872c207061ed@web.de>
 <alpine.DEB.2.20.1906170938530.3699@hadrien>
 <edbc59ca-2c16-bd0c-df27-ec2b9983d0e7@web.de>
 <alpine.DEB.2.20.1906180936090.3707@hadrien>
 <c375e3ba-d197-8c78-0797-74505b534208@web.de>
 <alpine.DEB.2.20.1906181932030.25567@hadrien>
 <8080bdd8-74d4-ad15-0ff2-c65219d572a8@web.de>
 <alpine.DEB.2.21.1906190843070.2687@hadrien>
 <8d56d773-2b91-3ed0-385c-cb2e8c3c3d72@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 19 Jun 2019 10:11:07 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 19 Jun 2019 10:11:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Handling of pointer expressions by SmPL
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



On Wed, 19 Jun 2019, Markus Elfring wrote:

> >> https://github.com/coccinelle/coccinelle/blob/19ee1697bf152d37a78a20cefe148775bf4b0e0d/standard.iso#L151
> >>
> >> It looks like that it should refer to a pointer dereference
> >> (according to a view for the semantic patch language).
> >> But the really desired meaning might be different for the support
> >> of pointer expressions by the isomorphism definition language.
> >
> > Metavariables have types.  Here X has pointer type.
>
> Our understanding of this software detail seems to match.
>
> But I assume that the asterisk can be treated in a different way by
> the isomorphism definition language in comparison to the semantic
> patch language.
> How much does context-dependent interpretation matter here?
>
>
> > There is no need for X to match a pointer that is dereferenced.
>
> I got further development imaginations around the places where
> you would specify pointer dereferences by metavariables instead of
> leaving asterisks in source code search fragments.

This is incorrect.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
