Return-Path: <SRS0=jS6P=YE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69805C47404
	for <cocci@archiver.kernel.org>; Fri, 11 Oct 2019 09:23:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645432196E
	for <cocci@archiver.kernel.org>; Fri, 11 Oct 2019 09:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="WXojfzRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645432196E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9B9N4aB011483;
	Fri, 11 Oct 2019 11:23:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E157477B1;
	Fri, 11 Oct 2019 11:23:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E84F977AE
 for <cocci@systeme.lip6.fr>; Fri, 11 Oct 2019 11:23:01 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9B9N19a010054;
 Fri, 11 Oct 2019 11:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570785781;
 bh=P7C+YP1ZQYOEZzJMZDOBAjJs95aWyalQBdcb0AlnU+o=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=WXojfzRo9s4pfSQszFiJklbrXSjpwgUZOTM5+bxQ8b4XiyK5VnDOucipZQ6e/YGCF
 ss2E81LdzEsytMBSU5v3e9po/Qzd7Z2u5MQIHNyIHJjuwd1YOTXBpZtGzk1r/oqVay
 t6gEW8qUgPm3mVRoEtWUAuhuWqVns/wGm+YHm4+s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.164.92]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M0hfO-1i5Alu3nbi-00urvd; Fri, 11
 Oct 2019 11:23:01 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <8df6513d-36d3-2049-8fb0-28d84c8f9c85@web.de>
 <alpine.DEB.2.21.1910101537280.2305@hadrien>
 <293c83c3-d7b9-8c55-59e0-eaf7fd2fcc84@web.de>
 <alpine.DEB.2.21.1910101606420.2305@hadrien>
 <678d756b-a8ac-12c0-cdbe-96b49fc4eb2c@web.de>
 <alpine.DEB.2.21.1910102053440.2500@hadrien>
 <b76c96ca-4312-550a-3f56-a509c63faa0f@web.de>
 <alpine.DEB.2.21.1910110806250.2662@hadrien>
 <c9b2c5be-455a-ad69-ad65-6efb910055b6@web.de>
 <alpine.DEB.2.21.1910110906390.2662@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7ee1d94f-44cd-7603-b715-9d62c32c1c9f@web.de>
Date: Fri, 11 Oct 2019 11:23:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910110906390.2662@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:H+04UoRz5CrTEWSmD9AdC8YNvsVkoYJ84LnzWp34upf8bie+F5X
 OQDExPvcZ4DqsmXYpWVclbPByNDCWJ3jaf8BY7WeJlyO698wsZ1Km/HTBD6hVWschi5nfKl
 FErYNgi9s1kgKWV65zuMO3ynT1aHFvfIK/zVJCOhBrE38OTHlKc+k5OiKRPazRfpmLet6xx
 ERyXuqe8bh7ygryic+ILQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MZ0LO477H0w=:4Q16hQgktGe9l/eP8Sn44y
 LOJZmyiPcxQEMyjxluufVqHjGa0KV/e6tsEUIgCbhSFlregotbxt78Hy5N6qnIdOPZ40G9lcJ
 XdGH71d4Gw9hKxf7mZjD6jr8Xwpz0+hJX64UvyP5umT/6EuJTGyQnRR7DhhPhLGhFJVWuszQU
 /JkhuPGNqnTxdLzBmtwoOwzWTWMNow9WRAKHQ8HDSZiD36P2NkVVR+hDz7jS0NzrKgRJlRbfP
 ffriXhMkczYvjsIE4EEcGHJ9AHF8pjTfoBhaUu2UlbjXpLT2nWmGfmAZ6TW8rkwUFbnqI7Itz
 Hs10YIU7Ga1nd4++rWgCyqrid7mBwvIw0yGXswo/M9FqR05eVgCjtGXXAYaspzUCHS3CxHO+5
 UfYkkAiqsUzUKlMRx81XMuTS49ne83/ygzBuEiwkDSTZKFQERmgAqS1B7SFOYuMSPgHIrF2kB
 VTStgrgmj/MyQIDwDcT0D2b0UzMwkWPdzrnzrHhg5hRQIdI9Bp/TNZjf/fjAsYD97Wk/vxFFJ
 nqzIIUKAlc0fZAT41MQi9iN1mDyD9pmS60hSlYGlc2l6kG0ermUn0Se12wmsQmmJ4Fbf2rpXs
 vGQC3fo7VS6KHrEPtKzXZRWsBTveJqDnlcnGdSTUk6XCwqYrkH+UxC9l6GRfxjGQHajaRqIfN
 ZPuK5j7lP8dqIC2APFIKguqaR5J7fAgHgDpwIIZJXCeUOoRHr8zi+Uj2E5fgaMCoH4ss2XnZF
 wgZfyIU+IO1AjdEJpVhqTE8JyUmv00N1USvpCc1nZB8PNntN9YXZeWadBLH2mMumrTqIb2uqM
 7qKKGB7NRSt1JjzqeLbRYTT/Ef83IS9jrlNnCsDkX23ZJt/5vb2zGbqAqGSlsk4RwGKRYgS6M
 qn5xouZ6ENRi5JTvyWZCHuLuqPAkQgB7sn8A1oki/zd+77bZSSOcdtiCRKhSJrnqLfUcWu41O
 glrnwNwUAvaAQnY8zSRVgK7MV8b0OWiyAJzkC+Cc2uf7GLbq4IbLj5MDFqKFCGcRrLd4UMMcg
 IB248S8mhc0kEiuktatN2sFs5kgfGu4asjbiZYfyTWirt1B1wcfYjj75i6y2yWXXRoARYahBF
 JV2mDbSHOT4+WHLKeGxPuGOB9pr3ooXsJxK6LuXLkb6OcAA4QyuDJ5fSyAR2us/efIiyiT7AD
 5pe4UoJjiGHATX18bf+dzuxSyVevtFltU+yLuBYjusT1LDSBQM8mistErxgZDGZ/BQ3/7aHfo
 u2jZqHaRsMx7xeYuRvJqrB6XDZLTemaO9IWL0fZsZ0iC84ASmCt6xPV8zkso=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 11 Oct 2019 11:23:04 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 11 Oct 2019 11:23:01 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked function
 calls
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

>> @display@
>> expression x;
>> identifier f;
>
> You can put f != {likely,unlikely} here.

Now I have got a related impression. It seems that such a search pattern extension
affects also our unfinished clarification for the desired handling of
when constraints by SmPL ellipses.
How will this open issue evolve further?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
