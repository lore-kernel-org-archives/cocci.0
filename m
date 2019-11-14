Return-Path: <SRS0=zifB=ZG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DF9C432C3
	for <cocci@archiver.kernel.org>; Thu, 14 Nov 2019 16:12:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92F6206F4
	for <cocci@archiver.kernel.org>; Thu, 14 Nov 2019 16:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Nu/p8u/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92F6206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAEGCBVO016107;
	Thu, 14 Nov 2019 17:12:11 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 64A8F77DB;
	Thu, 14 Nov 2019 17:12:11 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 44CEC77D4
 for <cocci@systeme.lip6.fr>; Thu, 14 Nov 2019 17:12:09 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAEGC7KJ025031;
 Thu, 14 Nov 2019 17:12:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573747927;
 bh=TUGsz9b5GtE6HSpP6yyt3w2ZPoni4V2aSL60UDFObXc=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Nu/p8u/V7ozKlS/FV4w8umIUL/3EdC0yVbjCJvgf0K2nQRKx2m8m2RGSOVLwkFblr
 BmYOtVebfxVTEB2oyPzp7+h17hFOVecAkHjIhQRqSEupm5fyYUFfMiE/JwV5sv8MXH
 Q1h19TKSoAkmhzV36Jte6BInZe/Ec+05XRf73kN0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.120.12]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWj7r-1iOpnY0geZ-00XpgV; Thu, 14
 Nov 2019 17:12:07 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <12ee1bd3-9849-ce84-f03b-104b1c1cc86e@web.de>
 <alpine.DEB.2.21.1911120524180.2536@hadrien>
 <162df2a3-b989-c244-0fa7-f26596df7722@web.de>
 <alpine.DEB.2.21.1911140735150.2239@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <42fd0ee0-d4b7-5f30-2896-57bd10900be7@web.de>
Date: Thu, 14 Nov 2019 17:12:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911140735150.2239@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:bphPpF/eniuiKqkG5Rsd08yyxTm6yMWtxirwJco27oA1WcY7ikN
 HsPa1J2Mpad4sSqhrzTfNplS9OSREpl6VVBZJbNxZq6CPhjFSE5v2dn49CKBrbWM08UknuJ
 sTiB5d+mu3yw66Bh9E6NNwACz4ZZnSclOupGRjJRRHkXoRsdoEXU6I3ZXxa1sok387ddWlU
 k7j3iSs5KDLttRNbHZGuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EESJ+nbUuEI=:Z5B0jMOjIgI3Wva/lJ2TJl
 HlN+Gfq1ROEQr9VUqgJkXRh9TlhCLjKjr/kiiURtWDiQ3KF1pGTcjsUaWa0OA4BqKvO9CkJiA
 c8SOI22N1D5ws/5y4naqUXM9dVZShlM/NM2XzmkPZU3emzmot6evng3qTBghY68m0bMUvu16a
 Nj0WN8/NiGLhjpBxZBqjz+V3jB6LXoyFrle2I4h2qnKlLf+SbHLqxQN/JcBKzD+R4YIZTjOE2
 xSGUSuh8yoQidPHMnXcdigL7Iv0pTyYYXkjSU45K454a2AjWZJBYcJCB+44LdJ+ytOiGqOg2q
 eWzpm3BM/Rwz9Lsx4eLpplOZ/QJqpBeUvzEa8AIE7X0DPOY7e9lPeLutkowdZqI6q0yc310+Y
 Ju1d6DCwgoFapv3DRBaYwiTP60nrEzxofSmT3Hskk8kMEg5iRotK7p3KqC9t6bc0tC2ldmLr8
 YaVUjzxE7k9vXkfdYU+j09ootwky9tFHgO5vJMefUU4Etvjzb866RXDNsrWWsJhJCdtQoZnIO
 0gWGwdS4PGFa9lDftMlabzyoKW9FeQfTmtqHkfEunvt/7HTYK8fzgywOGvQolRXHFTOPjnIBE
 hLE1tAILbqLil+WdwIdaS5S8H0aGvm5TRPpfpk4fZw08p9d1rYQSL2irIvf+Ln9+nS2IwXemv
 bZQ6h0bivpZafWCtedy5FFwQCzIXb1+mT6pWUjLrVEdtxAs05jmxiH6u/jvV5/JKBVIbJdcVr
 VWIYoMhyF0/vjfEsYkMJoUdBYP7Q2iuC4X1McEEbskGrEhjVNCx8c7l2p5UhQN117C+BSfJ9A
 gLRR9m8nuOlMRAU7Y+kX2vuNL8cY08M6q1M+SCgHAWyUmAffn0H6ey8hTv+VytHMulfvtqEU9
 +VXAcKqTNkSOjJjdmrmiFXcJUFt2qq7hxseGgGxs/d7Z8N/RqkDiO+C87El8UMZ+5cCMQ6ICt
 sQRcjQ5ISjjP1PpSBtWoztuwjiqtyKgXL2rGhZoGZIJCVxDH6gkOSPpCB7ZxOgeV3RyWOAebp
 IJKFW6zdK0lDMOsVgOaXx4VtHNADs2MdKQC3Yl2WDYmc/jEWpju3WQ4+TOQospi/6wPe1lcfL
 HOtU2A3fFjzXpL5PIb6dMw7o2o9zBaITLTJG8z3y8j3aVfPuNfNOZrrzCml8bmbKHp7X8U7xD
 IzqgRMlJ9bC2HCo5ur5iPZYWz/wiUWURyOBFgDmr5kj1TH0fSC3rXpTESg7u/RguelIbBe7CD
 axoJBoPaXZh7jFGg6uQAn9eykwu/0ekPAq1Xsrh7MSvChzNK4qfdzGCgLFJw=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 14 Nov 2019 17:12:12 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 14 Nov 2019 17:12:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Using the same replacement for different source code
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

>> @replacement@
>> binary operator bo = { +, * };
>> expression x, y;
>> @@
>> +compute(
>>          x
>> -        bo
>> +        ,
>>          y
>> +       )
>
> I can't figure out what this is an example of?

It shows just a possible transformation specification where a SmPL constraint
is applied instead of a related SmPL disjunction.

See also:
https://lore.kernel.org/cocci/59c2f820-af2b-030f-3f8e-1dc0fd23f4ba@web.de/
https://systeme.lip6.fr/pipermail/cocci/2019-November/006582.html


> Does this work or not?

This bit of SmPL code gets parsed by the Coccinelle software as expected.

Does it demonstrate similar development opportunities?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
