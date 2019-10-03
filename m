Return-Path: <SRS0=jkZ/=X4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA56C32792
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 19:36:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CDD520830
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 19:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDD520830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x93JZnLC007115;
	Thu, 3 Oct 2019 21:35:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 67DF077B4;
	Thu,  3 Oct 2019 21:35:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 65C2A77A9
 for <cocci@systeme.lip6.fr>; Thu,  3 Oct 2019 21:35:46 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x93JZkKe016123
 for <cocci@systeme.lip6.fr>; Thu, 3 Oct 2019 21:35:46 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.67,253,1566856800"; d="scan'208";a="404634649"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 21:35:45 +0200
Date: Thu, 3 Oct 2019 21:35:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9e15321d-5b95-c03c-e6eb-1d3d4a62478a@web.de>
Message-ID: <alpine.DEB.2.21.1910032135140.3451@hadrien>
References: <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
 <9e15321d-5b95-c03c-e6eb-1d3d4a62478a@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1604499507-1570131345=:3451"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 03 Oct 2019 21:35:49 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 03 Oct 2019 21:35:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        YueHaibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        =?ISO-8859-15?Q?Matthias_M=E4nnich?= <maennich@google.com>,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [RFC] scripts: Fix coccicheck failed
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

--8323329-1604499507-1570131345=:3451
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 3 Oct 2019, Markus Elfring wrote:

> > Was this patch posted somewhere?
>
> Yes, of course.
>
> YueHaibing's update suggestions are available also by the usual
> mailing list archive interfaces.
> How do you think about to avoid the addition of the SmPL variable
> “virtual report” to the script “add_namespace.cocci” if you would dare
> to integrate my change proposal for an adjusted directory hierarchy?

Perhaps I'm lazy, but i seems simpler to add 20 characters than to move
all of the files around...

julia
--8323329-1604499507-1570131345=:3451
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1604499507-1570131345=:3451--
