Return-Path: <SRS0=6Z8s=7U=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB527C433DF
	for <cocci@archiver.kernel.org>; Sun,  7 Jun 2020 21:23:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7057C2073B
	for <cocci@archiver.kernel.org>; Sun,  7 Jun 2020 21:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7057C2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 057LNLQP019623;
	Sun, 7 Jun 2020 23:23:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 306C13F9A;
	Sun,  7 Jun 2020 23:23:21 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 071373BAB
 for <cocci@systeme.lip6.fr>; Sun,  7 Jun 2020 23:23:20 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 057LNIut023518
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 7 Jun 2020 23:23:18 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,485,1583190000"; d="scan'208";a="453407069"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Jun 2020 23:23:18 +0200
Date: Sun, 7 Jun 2020 23:23:18 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@ispras.ru>
In-Reply-To: <50deacc7-b68b-69ec-b2cc-eb751e457f65@ispras.ru>
Message-ID: <alpine.DEB.2.21.2006072322050.2546@hadrien>
References: <b273ce70-5527-6e79-9e1e-7a6c3f83eda4@ispras.ru>
 <alpine.DEB.2.21.2006072203095.2546@hadrien>
 <50deacc7-b68b-69ec-b2cc-eb751e457f65@ispras.ru>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 07 Jun 2020 23:23:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 07 Jun 2020 23:23:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Python interface
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



On Mon, 8 Jun 2020, Denis Efremov wrote:

>
> >> @r depends on !patch@
> >> // It doesn't work. Is it normal?
> >> //position p: script:python() { matches.extend(p); relevant(p) };
> >
> > "Doesn't work" means you get a parse error?  The parser of the code inside
> > the {} is pretty fragile.  Perhaps this could be improved somewhat, but it
> > is limited by the fact that Coccinelle doesn't know how to parse python
> > properly.
>
> It prints "hd" and exits.

OK, it's a form of parse error.

>
> > This seems entirely reasonable.  You can collect the places that are
> > matched in a variable declared in the initialize, and then look at that
> > variable in the finalize.
>
> I need a list of all files spatch tries to process. A list of files in which
> spatch finds some matches is not enough. Otherwise the approach will incorrectly
> work when cocci script runs on a subset of kernel files, e.g.,
> make coccicheck M=drivers/net

OK, just make a python rule that will run on every file.

@script:python@
@@

do something with cocci.files()

---

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
