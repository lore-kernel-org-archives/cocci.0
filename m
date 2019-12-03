Return-Path: <SRS0=z6Nh=ZZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B675C432C0
	for <cocci@archiver.kernel.org>; Tue,  3 Dec 2019 15:44:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0EB2070A
	for <cocci@archiver.kernel.org>; Tue,  3 Dec 2019 15:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="jotzpW9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0EB2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB3Fho2u013615;
	Tue, 3 Dec 2019 16:43:50 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1815477D7;
	Tue,  3 Dec 2019 16:43:50 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 15D6D4386
 for <cocci@systeme.lip6.fr>; Tue,  3 Dec 2019 16:43:49 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB3Fhm3i017469
 for <cocci@systeme.lip6.fr>; Tue, 3 Dec 2019 16:43:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1575387827;
 bh=AMzCbRv6vcIBTLW3h/vee2DTMU8mymeRoeKXRB7knzo=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=jotzpW9dcLKJZQQPCOGUfPNNI8sSxH8JGQepiDttdRBYJsfB9kZ18zdOlMpG04fW1
 bnDZ6lahZnvbRDLuJp6Bqcw56vZmekS5f4XGTPnwKzcnvTATll/NPr8cFTAoxVcboN
 gdD6pDt1ibAfkH/v0tnFd7spuo9Qd1yyZD14mDSM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.47.193]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9GN8-1iTxfA3XW2-00Cf06; Tue, 03
 Dec 2019 16:43:46 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
 <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
 <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
 <alpine.DEB.2.21.1911292154450.3140@hadrien>
 <CABvP5W3hmmovw09n6gJQ5m=Cps2YAYJFFfOPmKY6Zu_SJOU=NQ@mail.gmail.com>
 <0c03f84d-a05b-2811-96aa-6f82541fb8a3@web.de>
 <CABvP5W3E3zP28kUsmrvUOqv-Tu1YT3zvi6c=mqx+ahbMTycqAQ@mail.gmail.com>
 <1865799483.10870980.1575350298758.JavaMail.zimbra@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <92fa3538-84f3-4ef3-81e0-473700833dc1@web.de>
Date: Tue, 3 Dec 2019 16:43:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1865799483.10870980.1575350298758.JavaMail.zimbra@inria.fr>
Content-Language: en-US
X-Provags-ID: V03:K1:/RGTm96u8CXpXpm8nPjOd2kzBZYy15MgjQYkttOs38fHzqo83GH
 gOsMKNECVvEO2ORuOxQINyTI2/iTCQ1ICqX9Mqq1Ks8P1T9JzprohASXntdJXKAW6EMRj17
 KdOb+b+tjvUWPZH7NMQ7m2yVtApRLBCQlFRtw73gIFd6Tif6GkE5wG2CKJojKsSZ2rfZKKc
 +gBCFuz0CNENCh8q5O4Vw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xoe/9MgNBfk=:ts21SVa8CXMYLgQGZ8yHtV
 txPXF0j1GRlciqwcwMjOBqCobS6WOX3YCal/CYxX9gwFp4/Zo0uP/C4cc2brNXdoyZxmwrAou
 wLz/4ugHpv6/7hMJEnoMqtSDqmREDdFRyyarc6EMQ5AaTSA7oQy28vQ/LzVp4OI0TiskSRDd4
 Mgj1D+OWuIlN0NZSno7Uh+himxRAs0MpEQV1mutDa10R+9pvRNjJChD/LY69ZuORMVkjBiLmP
 3y1IYVvEAztA12xC6J5wYoO1b0bS2NWq1AQqSu2q0yOMTloVh4f32MHoY92E7MuKl35oIOeIk
 zhxHhLFt8eBn7GZQsXxuJHnjxiTPD+YnbEpds46MBWntmF4L9C1tSPNPjaIVWYvdIPXnjPHRs
 9GdpMNjolTD8UMW/8VED9nntaWcCRozqMFkJ6dE5fGQokbFcV9GhUHON7q3nDgvRCXqzs0/km
 rpsqTx0sOngy1RtPZs6SE4KOOX4zB4UVo/SCeJbNZiz73/G313Ioc+Oo+xL7cjTvvabUkrZZM
 YwMswaUJYsfE3i3zWtCvSYPsNrKdRnOvnEpCj39kRc8/YaVavAdq9uxyKmrlXHAwXmjaP7K5x
 8g8vwZaCvMwM23XywYEIsiqBdIinSCP9C9utluekB0Gpvsb1CkbEmH/QJOlsJ3XyM1qS5OzXx
 YPEyUATjvnGD13K+torV+iKb9NUfvABp3NKeQMNJvnSDTOhc2KVfVYjzoKWMAkT00tT+rh0Wj
 cxUijw+uzDqO4ocGunci9R7RsGCxuHb1I7v0iKZVW7mcnqtnwgs5QwSrMjg13lzD0SJ9PXCGi
 g8h5xMXKAGGRSXOB3rD3QzJhnbsUubS7pdH2jBvryEtEsxZ6clAjFACF/2kBAHHA1tvmjhzUA
 XgfujmSR3ukzsZvGsQca+5yIesKEbgbYfjU3ziVSWGNwyD3Bvfglx2iYx7t1Aj6IVbBYJuxcy
 w0+ZUg55JZwLJcKuv7ITPBysNoxxvi02HvF2ka/uQleEbPCwy+RB8glgejn1gEWL+Wu2+o+W+
 SUWlYsAvkUhI1aBkOyUHvL3BycKl1ZPXXZwEJ9Nms4zBYdsEtoiEJpP4nkcdhs6WbtMMTo+4G
 7Kzt7x2xZUN0eI5WAsPa/jHeAvclvrbGdX4TGzoFS5cYq8tNeZWGaAl/QgE22vzYhKgDyNtsR
 K6rfiKGcrbzTeNInopf8aY/PPdFNoN7odtiMWZ9TWk5rjpFPhEgJUzV61adIhP6XcFgGVjvHj
 ZU2FXoHnT3NkSmaqV1kmZE9pb+ncf6fkLjajufyxUe5DiF2V5nwvKMkzfa2Q=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 03 Dec 2019 16:43:50 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 03 Dec 2019 16:43:48 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Generation of expression lists by SmPL script rules?
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

> OK, if you may have more than one argument to your print,
> then you can find the offset using an expression list metavariable:

How challenging would it be to add support for the construction
of such expression lists by programming interfaces (besides =93make_expr=94)
of Coccinelle's software library?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
