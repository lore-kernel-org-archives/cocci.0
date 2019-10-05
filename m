Return-Path: <SRS0=uzOD=X6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A73DC3E8AB
	for <cocci@archiver.kernel.org>; Sat,  5 Oct 2019 12:26:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDDF92133F
	for <cocci@archiver.kernel.org>; Sat,  5 Oct 2019 12:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDF92133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x95CQBrk022870;
	Sat, 5 Oct 2019 14:26:11 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BCD0C77AA;
	Sat,  5 Oct 2019 14:26:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F106877A9
 for <cocci@systeme.lip6.fr>; Sat,  5 Oct 2019 14:26:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x95CQ9qC009548
 for <cocci@systeme.lip6.fr>; Sat, 5 Oct 2019 14:26:09 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.67,260,1566856800"; d="scan'208";a="404856155"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2019 14:26:09 +0200
Date: Sat, 5 Oct 2019 14:26:08 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <21684307-d05c-1856-c849-95436aedeb86@web.de>
Message-ID: <alpine.DEB.2.21.1910051425050.2653@hadrien>
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
 <21684307-d05c-1856-c849-95436aedeb86@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1481532127-1570278369=:2653"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 05 Oct 2019 14:26:12 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 05 Oct 2019 14:26:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Yue Haibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?ISO-8859-15?Q?Matthias_M=E4nnich?= <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>, Martijn Coenen <maco@android.com>,
        cocci@systeme.lip6.fr
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

--8323329-1481532127-1570278369=:2653
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 5 Oct 2019, Markus Elfring wrote:

> > You gave Acked-by to the one-liner fix "virtual report",
>
> It was (temporarily?) accepted to use the script “add_namespace.cocci”
> without such a type of SmPL variable.
>
>
> > and I am happy to apply it to my tree.
>
> Would you like to take the change possibility into account
> that the coccicheck system configuration should be adapted instead?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccicheck?id=4ea655343ce4180fe9b2c7ec8cb8ef9884a47901#n257

I prefer the one line change for now.  If more issues arise one can see
what is more desirable at a larger scale.

julia

>
> Regards,
> Markus
>
--8323329-1481532127-1570278369=:2653
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1481532127-1570278369=:2653--
