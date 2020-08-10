Return-Path: <SRS0=13qy=BU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC70C433DF
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2020 14:25:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A762070B
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2020 14:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A762070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07AEP0MY004796;
	Mon, 10 Aug 2020 16:25:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CDE3A7780;
	Mon, 10 Aug 2020 16:25:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AFF155F8F
 for <cocci@systeme.lip6.fr>; Mon, 10 Aug 2020 16:24:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07AEOtxY016041
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 10 Aug 2020 16:24:55 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,457,1589234400"; d="scan'208";a="463038467"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 16:24:54 +0200
Date: Mon, 10 Aug 2020 16:24:54 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jonathan Corbet <corbet@lwn.net>
In-Reply-To: <20200810081914.37224551@lwn.net>
Message-ID: <alpine.DEB.2.22.394.2008101624380.2466@hadrien>
References: <ffe8c50d-0bb5-9477-a20c-96aa7bb45067@web.de>
 <20200810081914.37224551@lwn.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1836737229-1597069495=:2466"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 10 Aug 2020 16:25:01 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 10 Aug 2020 16:24:55 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, Sam Ravnborg <sam@ravnborg.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [Cocci] [PATCH v2] documentation: coccinelle: Improve command
 example for make C={1, 2}
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1836737229-1597069495=:2466
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 10 Aug 2020, Jonathan Corbet wrote:

> On Mon, 10 Aug 2020 09:30:18 +0200
> Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > > Modify coccinelle documentation to further clarify
> > > the usage of the makefile C variable flag by coccicheck.
> >
> > How do you think about a wording variant like the following
> > for the change description?
> >
> >    Clarify the usage of the make variable “C” for coccicheck.
> >
> >
> > > +C flag is used. The C flag is a variable used by the makefile
> >
> > Can such a wording approach trigger understanding difficulties?
> > [...]
>
> Markus, please don't harass our contributors.  This patch is an
> improvement and, unless Julia disagrees, I am happy to apply it.

There will be a V3.  Thanks.

julia
--8323329-1836737229-1597069495=:2466
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1836737229-1597069495=:2466--
