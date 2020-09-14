Return-Path: <SRS0=jMis=CX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3808CC43461
	for <cocci@archiver.kernel.org>; Mon, 14 Sep 2020 07:27:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B13217BA
	for <cocci@archiver.kernel.org>; Mon, 14 Sep 2020 07:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B13217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08E7Qi31029838;
	Mon, 14 Sep 2020 09:26:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 89370778A;
	Mon, 14 Sep 2020 09:26:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EA4BB5F8F
 for <cocci@systeme.lip6.fr>; Mon, 14 Sep 2020 09:26:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08E7QgB8026936
 for <cocci@systeme.lip6.fr>; Mon, 14 Sep 2020 09:26:42 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="358870821"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 09:26:42 +0200
Date: Mon, 14 Sep 2020 09:26:41 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e5d90bca-c264-c154-25ad-5046ac00b3e8@web.de>
Message-ID: <alpine.DEB.2.22.394.2009140926030.2357@hadrien>
References: <44ab7442-1473-f267-4487-af98631a9338@web.de>
 <alpine.DEB.2.22.394.2009140821041.2357@hadrien>
 <287a8c82-6359-9a7e-c2ca-d26aa5be9650@web.de>
 <alpine.DEB.2.22.394.2009140913480.2357@hadrien>
 <e5d90bca-c264-c154-25ad-5046ac00b3e8@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1699748661-1600068402=:2357"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 14 Sep 2020 09:26:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 14 Sep 2020 09:26:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [RFC PATCH] scripts: coccicheck: Improve error feedback
 when coccicheck fails
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

--8323329-1699748661-1600068402=:2357
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 14 Sep 2020, Markus Elfring wrote:

> >>>> How do you think about to use the following check variant?
> >>>>
> >>>> +	if [ "${DEBUG_FILE}" != '/dev/null' -a "${DEBUG_FILE}" != '' ]; then
> …
> > I have no idea.  Why can't they be nclosed by double quotes as well?
>
> Both script variants can work.
> Such coding style variations can trigger different run time characteristics
> (besides expressing specific intentions), can't they?

Again, I have no idea.  But the runtime cost of these tests must be
microscopic as compared to the overall cost of make coccicheck.

julia
--8323329-1699748661-1600068402=:2357
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1699748661-1600068402=:2357--
