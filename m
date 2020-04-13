Return-Path: <SRS0=NqNQ=55=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADA3C2BA19
	for <cocci@archiver.kernel.org>; Mon, 13 Apr 2020 08:23:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1699E20692
	for <cocci@archiver.kernel.org>; Mon, 13 Apr 2020 08:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Htie50W0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1699E20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03D8NAj5028050;
	Mon, 13 Apr 2020 10:23:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EE42F7755;
	Mon, 13 Apr 2020 10:23:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 26B2F7750
 for <cocci@systeme.lip6.fr>; Mon, 13 Apr 2020 10:23:08 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03D8N7XX013004
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 13 Apr 2020 10:23:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586766186;
 bh=0RlEJ4gVcSb9XhF4lfFb8eC6gmAy0+dqd+ClsyNFziI=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=Htie50W0IFwjutIQXZxwtQo2IoGX7HP7oQ5+K8gzo+5hDmIYYS0MVk5sQrP2Uqo4Y
 Z9/F91XnV3DGV2oWqTXxK+9gqfoK4gTP69LcSzAXjeFP5VvXG/kpbNoeH99g+QWQxq
 we4cinNeaRMr9zFxwOKhFdICuj3J09pChQeN4sDM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.133.146.177]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LzsC7-1jBiy91JJL-014zH3; Mon, 13
 Apr 2020 10:23:06 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <146360ce-9cfb-e6f5-1601-fa95460c2cd5@web.de>
 <alpine.DEB.2.21.2004101712080.3039@hadrien>
 <f0b37f45-5144-a1c5-3f52-5bfbb6f3635f@web.de>
 <alpine.DEB.2.21.2004111600560.2369@hadrien>
 <fcbca1d9-7375-b488-54b2-a3934b90c6ed@web.de>
 <alpine.DEB.2.21.2004112036270.2369@hadrien>
 <d878a25d-29fd-28b1-fa6f-2e0f44763d73@web.de>
 <alpine.DEB.2.21.2004121050210.2419@hadrien>
 <ab6d402e-3c12-25ab-162a-f200c382dd0a@web.de>
 <d68533a4-554a-fd38-a940-1c3fb15c4dae@web.de>
 <alpine.DEB.2.21.2004130957540.3035@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ec57da8d-0723-931c-c2ed-f055f42444f3@web.de>
Date: Mon, 13 Apr 2020 10:23:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004130957540.3035@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:k1/GdaHM5bbB6wOO94xDrtv0PWixjGSH3kCnWT/v4nPi2/2F/Nt
 jU8CePQDaSxxvfi8NL3wKsZyBzxneyDXENaOdPWcYOiDGU1+ruMjZwhfYa+7z30jbME3VXG
 FLmjj1bJ5kVqqEyu/SO+mYYQc4wEVTtqsmYgnBPHDxHGRosd4wnX6H3gm9KvKY+H9iTjLZA
 D0+e91ctGtFoLPPp0p9SQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/q3WA7m95qk=:e4U98f7FtCSHoDw5xjmn8/
 oz7Cumey8WlTXuodjZVfo4cl1wstdkjyMm5/UMy0zww26FDjwni3o9TWqgKXekqJNDwTT7JES
 UyQSKz75LQ9xPKhT673vpMkrAlMqO1r77Fhba5LOmx4OoH2gDBA9QjGmvRVFGVP7jwAWumzW5
 Ocijf3YHmu9n674q+7mAJJMvixtIhlP3lUHtQReQsNk6QWON0WwomdEyjB+4/OrZ44oyXOgnJ
 9xT25ArT59jcQN+5K5y/8iRJ3tKkUnzkpWPMeZ1DwpafD5AU8CLArL82B0udSRgKeulDCbP2K
 mqeIf6YSgy/m2ZhVB2GEDALNM9nykEoMrc8xYOchn590zXeWCi0T0b4f1Ua1r16QYxWerg41B
 nMNuZ9876uBSsNJHvVtMDf7W9lAQW3JA/ddP05vESty+ilkB6aY0KZ5GthF6K6hFDBhCsEeln
 YVBnVFiFVTRqjMC8A2DjbQ5FqbQsjBbVXEFYLWMxjjHJ5N2xhjZ+lkqcFq62cBonUK9m/IvSr
 hpC41EfghG7eKl5nKSLnmy0jNf/qEw/0pZkJyq9X8ZM48DtqMR2SkhdCQCejivwHqE9jCVCND
 dN/a5YK0qERrLFACn4XCmgF2l2Gj0t5QqWaJnrUAd1CEOe9y/bgA25WlLrEqKdwo28WD4S4/1
 Ac35YO+M+KpI5zlboy1fryysmV8gJQGxq6WBBmX9DkZXIpLjoXvIWvvFzOLpZaq+OyZMSgn/h
 1MbSTfNvNV6yFR4I9p1VIvRrX2Bt2y8IjdIfBVuJcqI7fa87hQI4B0U3mYCflkZkm4mtZ2DbL
 R+EaFUXrYxUMZZsw2RSaZTnSALfrsRkKSVNVZY/7zOLxqbLBBzPUxxyYmBBQPXFwpteBWjdRl
 XTShWFpjxXw6iT4bNGeIegW78ml0IZDYVO6Qx8mx00OaHBqIzT1RSLULUqGp3HLJSeWrORMXb
 cf2tK1U50Uhx8fXzE95dd0TlrGhLQv44L9vaegzzchTgiYSRJiJTZ2FoBv2L8k87TBfSRXbFb
 hbPF0Wu9AcN4qT1c8cQWRuiR3Bqd6ajJiyC9b/J7GyPHy/JlDaheZzLZoqgHjWBdJNsK2NvaQ
 ODA5luYf1rmJFFsJ7smq2/Jv1IgpjKg/cAcIP5cf+nnhwhTzQA6o8DvjGqVxtgJ+S4ZaMb44R
 XSZxvmuTbK7yyK/NqVv0GGXt5X+mTa/iCAVDlrATP6/MCiWIbh/INy3KWWmZrSAwhc2JeeWRN
 WLhv5gg2Y8o3PlOiG
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 13 Apr 2020 10:23:10 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 13 Apr 2020 10:23:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] More support for SmPL data processing with databases?
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

>> I observe that the following SmPL code variant can result also in
>> a significant difference.
>>
>> @find@
>> expression action, check, result;
>> position p;
>> statement is, es;
>> @@
>>  result = action(...);
>>  if (
>> (   <+... result ...+>
>> &   check@p
>> )   )
>>     is
>>  else
>>     es
>>
>>
>> How will the application of SmPL conjunctions evolve further?
>
> I really have no idea what you are talking about.

I suggest to take another look for the software behaviour.


> that contains all of the semantic patch variants that you want to have
> These semantic patches should involve no use of databases.

Please compare details with the following SmPL code example.

@find@
expression action, check, result;
position p;
statement is, es;
@@
 result = action(...);
 if@p (
(     <+... result ...+>
&     check
)     )
     is
 else
     es


Under which circumstances will the Coccinelle software provide duplicate data
for their processing by (Python) script rules?


> The database itself doesn't bring any value.

Another unique constraint violation was noticed by using such technology.
I am curious when you are going to take related functionality better into account.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
