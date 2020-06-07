Return-Path: <SRS0=6Z8s=7U=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D82C433DF
	for <cocci@archiver.kernel.org>; Sun,  7 Jun 2020 21:20:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67F82073B
	for <cocci@archiver.kernel.org>; Sun,  7 Jun 2020 21:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67F82073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 057LKgsd026900;
	Sun, 7 Jun 2020 23:20:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 61E243F9A;
	Sun,  7 Jun 2020 23:20:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 711B63BAB
 for <cocci@systeme.lip6.fr>; Sun,  7 Jun 2020 23:20:40 +0200 (CEST)
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.45])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 057LKdUc016341
 for <cocci@systeme.lip6.fr>; Sun, 7 Jun 2020 23:20:39 +0200 (CEST)
Received: from [192.168.1.8] (unknown [213.87.137.116])
 by mail.ispras.ru (Postfix) with ESMTPSA id 68588CD460;
 Mon,  8 Jun 2020 00:20:36 +0300 (MSK)
To: Julia Lawall <julia.lawall@inria.fr>
References: <b273ce70-5527-6e79-9e1e-7a6c3f83eda4@ispras.ru>
 <alpine.DEB.2.21.2006072203095.2546@hadrien>
From: Denis Efremov <efremov@ispras.ru>
Autocrypt: addr=efremov@ispras.ru; keydata=
 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
Message-ID: <50deacc7-b68b-69ec-b2cc-eb751e457f65@ispras.ru>
Date: Mon, 8 Jun 2020 00:20:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006072203095.2546@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 07 Jun 2020 23:20:43 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 07 Jun 2020 23:20:39 +0200 (CEST)
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


>> @r depends on !patch@
>> // It doesn't work. Is it normal?
>> //position p: script:python() { matches.extend(p); relevant(p) };
> 
> "Doesn't work" means you get a parse error?  The parser of the code inside
> the {} is pretty fragile.  Perhaps this could be improved somewhat, but it
> is limited by the fact that Coccinelle doesn't know how to parse python
> properly.

It prints "hd" and exits.

> This seems entirely reasonable.  You can collect the places that are
> matched in a variable declared in the initialize, and then look at that
> variable in the finalize.

I need a list of all files spatch tries to process. A list of files in which
spatch finds some matches is not enough. Otherwise the approach will incorrectly
work when cocci script runs on a subset of kernel files, e.g.,
make coccicheck M=drivers/net

Thanks,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
