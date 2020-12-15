Return-Path: <SRS0=J+fH=FT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DF0C4361B
	for <cocci@archiver.kernel.org>; Tue, 15 Dec 2020 08:53:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108AB20771
	for <cocci@archiver.kernel.org>; Tue, 15 Dec 2020 08:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108AB20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BF8qcXA019752;
	Tue, 15 Dec 2020 09:52:38 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CAB8F77A4;
	Tue, 15 Dec 2020 09:52:38 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1A1313A53
 for <cocci@systeme.lip6.fr>; Tue, 15 Dec 2020 09:52:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BF8qafg023074
 for <cocci@systeme.lip6.fr>; Tue, 15 Dec 2020 09:52:36 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.78,420,1599516000"; d="scan'208";a="483005226"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Dec 2020 09:52:36 +0100
Date: Tue, 15 Dec 2020 09:52:36 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Maxime Ripard <maxime@cerno.tech>
In-Reply-To: <20201215084823.towbaqay5tgdh7dw@gilmour>
Message-ID: <alpine.DEB.2.22.394.2012150950440.2879@hadrien>
References: <20200107073629.325249-1-maxime@cerno.tech>
 <alpine.DEB.2.21.2001071106420.3004@hadrien> <20200107102954.GB1135@ninjato>
 <20201215084823.towbaqay5tgdh7dw@gilmour>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 15 Dec 2020 09:52:40 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 15 Dec 2020 09:52:36 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: michal.lkml@markovi.net, Gilles.Muller@lip6.fr,
        Tomi Valkeinen <tomi.valkeinen@ti.com>, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinnelle: Remove ptr_ret script
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



On Tue, 15 Dec 2020, Maxime Ripard wrote:

> Hi,
>
> On Tue, Jan 07, 2020 at 11:29:54AM +0100, Wolfram Sang wrote:
> > On Tue, Jan 07, 2020 at 11:06:56AM +0100, Julia Lawall wrote:
> > >
> > >
> > > On Tue, 7 Jan 2020, Maxime Ripard wrote:
> > >
> > > > The ptr_ret script script addresses a number of situations where we end up
> > > > testing an error pointer, and if it's an error returning it, or return 0
> > > > otherwise to transform it into a PTR_ERR_OR_ZERO call.
> > > >
> > > > So it will convert a block like this:
> > > >
> > > > if (IS_ERR(err))
> > > >     return PTR_ERR(err);
> > > >
> > > > return 0;
> > > >
> > > > into
> > > >
> > > > return PTR_ERR_OR_ZERO(err);
> > > >
> > > > While this is technically correct, it has a number of drawbacks. First, it
> > > > merges the error and success path, which will make it harder for a reviewer
> > > > or reader to grasp.
> > > >
> > > > It's also more difficult to extend if we were to add some code between the
> > > > error check and the function return, making the author essentially revert
> > > > that patch before adding new lines, while it would have been a trivial
> > > > addition otherwise for the rewiever.
> > > >
> > > > Therefore, since that script is only about cosmetic in the first place,
> > > > let's remove it since it's not worth it.
> > > >
> > > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > > Cc: Mark Brown <broonie@kernel.org>
> > > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > >
> > > Acked-by: Julia Lawall <julia.lawall@inria.fr>
> >
> > Convincing patch description, good catch!
> >
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> It looks like this patch was never applied, whose tree should it go
> through?

Sorry.  I can take it.  I'm not sure that I still have the original
message, though.  If you have it handy, that would be helpful.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
