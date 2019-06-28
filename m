Return-Path: <SRS0=T0lm=U3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0575C4321A
	for <cocci@archiver.kernel.org>; Fri, 28 Jun 2019 11:08:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20FD9204FD
	for <cocci@archiver.kernel.org>; Fri, 28 Jun 2019 11:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FD9204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5SB7sr6002078;
	Fri, 28 Jun 2019 13:07:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B1FF87782;
	Fri, 28 Jun 2019 13:07:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F0D7A777B
 for <cocci@systeme.lip6.fr>; Fri, 28 Jun 2019 13:07:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5SB7p9Q002548
 for <cocci@systeme.lip6.fr>; Fri, 28 Jun 2019 13:07:52 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,427,1557180000"; d="scan'208";a="311767956"
Received: from wifi-eduroam-85-160.paris.inria.fr ([128.93.85.160])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Jun 2019 13:07:51 +0200
Date: Fri, 28 Jun 2019 13:07:51 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <904b9362-cd01-ffc9-600b-0c48848617a0@web.de>
Message-ID: <alpine.DEB.2.21.1906281304470.2538@hadrien>
References: <1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn>
 <904b9362-cd01-ffc9-600b-0c48848617a0@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-202224278-1561720071=:2538"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 28 Jun 2019 13:07:55 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 28 Jun 2019 13:07:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr, Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [Cocci] [PATCH v2] coccinelle: semantic code search for missing
 of_node_put
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

--8323329-202224278-1561720071=:2538
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

> > +x = @p1\(of_find_all_nodes\|
>
> I would find this SmPL disjunction easier to read without the usage
> of extra backslashes.
>
> +x =
> +(of_…
> +|of_…
> +)@p1(...);

Did you actually test this?  I doubt that a position metavariable can be
put on a ) of a disjunction.

> > +|
> > +return x;
> > +|
> > +return of_fwnode_handle(x);
>
> Can a nested SmPL disjunction be helpful at such places?
>
> +|return
> +(x
> +|of_fwnode_handle(x)
> +);

The original code is much more readable.  The internal representation will
be the same.

> > +    when != v4l2_async_notifier_add_fwnode_subdev(<...x...>)
>
> Would the specification variant “<+... x ...+>” be relevant
> for the parameter selection?

I'm indeed quite surprised that <...x...> would be accepted by the parser.

julia
--8323329-202224278-1561720071=:2538
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-202224278-1561720071=:2538--
