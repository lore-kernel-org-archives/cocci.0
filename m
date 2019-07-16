Return-Path: <SRS0=uYVO=VN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7321AC76192
	for <cocci@archiver.kernel.org>; Tue, 16 Jul 2019 12:06:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58282145D
	for <cocci@archiver.kernel.org>; Tue, 16 Jul 2019 12:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Ew94lgP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58282145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6GC6FfV016397;
	Tue, 16 Jul 2019 14:06:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EFB9E7788;
	Tue, 16 Jul 2019 14:06:14 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 39BE1777F
 for <cocci@systeme.lip6.fr>; Tue, 16 Jul 2019 14:06:13 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6GC6C1q005648;
 Tue, 16 Jul 2019 14:06:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1563278745;
 bh=fQ2avAzYiPevEbhCwSjxbKxm382jCizRyfFyZNtG3Ek=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Ew94lgP5Zie6bRKv5mnw5smaZfl5NLJo5yPIugbQ5UwzOP2NRAV4+IJFD8GwbsAqq
 u8tpoAbUCysFlijuxgQpUV7lVLZjgzzOwAOS7L5gxqzTfKZOX1J2JRe4QSiyBsMiii
 7JqLKWRzm1NQnxp/nArhri7X/TxMLSK0TBr3Ihco=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.184.87]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlWRb-1iLaZS0Rnz-00bJj2; Tue, 16
 Jul 2019 14:05:45 +0200
To: Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
References: <1563246347-7803-1-git-send-email-wen.yang99@zte.com.cn>
 <663d8141-5740-a452-1f4a-8335203e65ba@web.de>
 <alpine.DEB.2.21.1907161307550.2885@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ba3266e0-3ba1-f53a-9342-6619fe8724d8@web.de>
Date: Tue, 16 Jul 2019 14:05:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907161307550.2885@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:2AQG7v3nyhXmxjHoOuevoYZzAhZdgkRJLeDl2aKfKyoeZPa2cc2
 If/cD51U2yID/zgAdHORP/A//S5X/ZGj+eL5DN+22zKLrmqs063j6SatJ+hcru5uzK/N81q
 NWiGstMKMYcj0VNF/OdwSA7KQ2Z5rcWmPGpsnvdW597sywDob2hoplx5zWy0IO7CZudv17k
 znWV9jKlhlhrDclRaiHtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NXNbAPvHxgo=:SGhgiRUbeQXw4IsS0I5Ci4
 TXoOsOGEr/kmSz5z2jjpfjpu8fdv6YJ1U2wdpAkgFdZ5oHwYTt3J3nTNrT0kszXAjRRK6J9/J
 wNhR/JGblde64Vtiaaw7DmTZGXOst5QtdOHPnnHbkyr9jSkjQSpqaQHSZcJvjdl7fdRvqgFME
 u65yiF6f+wCKGd8AsBkjXma5qGrFm3KqQ02v4JoCpqCvz5AA5b54VKxRadhvmi4czb2mP+Lp2
 O0EOs73iDPRWUQPmvE9VMyeGKeIAAmMBc3CZcg1hIzo/1HCOFw9TtG7iBTx7jVBC+7l1jYfXk
 cUwpIbNPMT6pf4hX91TyVkgseXABBg/AzeL4gqsvE+xalWUJRIhZmZggvO7sFcWSm9pGR/rZg
 7suAM+Rp6fqOBJqkYi7BxMGuwwVkQwcdK1nqq9zMz5LeNSqNAlHctffJFChaW9wyjVHwmWP/R
 7ZUPeKzxerdu2yb3pYjgu7qMC/J6bPWmi7TTpmj9047v6USjp2igcjOvscZokh7Z8RRlJbnUx
 tgRE9XKCAKd0VKJOJOm26Lmp4ZMprcmfA4oq7iFfiNN0kybw8T1+P+/i3K5RLJuH+iHUZLrbG
 ILBPry/h6WYNs5YjlYr5k97EGjfCWPITzZAIC4wGm1tHiQ9IVbSTxOjx3nWiYUyDfsqlzwu6r
 Seb/XfTJhhbuEoE7p+ZOA5E/Ec78vGy9UwlHxeEHUTktbZPoLLGosjwlK//DwDmTtWyxQvHud
 QmN9xgEabmyEL3Qacyheyv3tGvbVBW8+lbfQ2T16o04XcKzq+4qnj3OsuB3M3eUpz4xxS14k4
 YenZ8wIcl/cZRhkUNzey9zzkwxhwkZGJ3ztAUkglKYavao+1EQjK/Q7R9a6dho+KmECWVt+0u
 Bk4aVeayMoTFH0mSe/RYBxzdBZKsvZyGHfDqqINAqbVw/c4KAR57x9VzkeF/pRctSdFNGRlW2
 7vlI4qqGJ6yY5b+PHqsJMxudIX6IJeqKoF84iryFcy2FGuHas9hEVAWL+RzoTIyjpXgz8CTDG
 15Q8qAYZwZ1fbtgT/NKcPQ8Entgv2zqQrbj7AutnfmjyLjpFoKxBpsLY30akM/WLy8nmVTgy7
 O+o6PG0WydU0qpN+LF/Z5IyBOpoh9YW1nGq
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 16 Jul 2019 14:06:15 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 16 Jul 2019 14:06:12 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [Cocci] [v3] coccinelle: semantic code search for missing
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

>> Why would you like to keep this SmPL code in the commit description?
>
> I don't know indetail what you are proposing,

I imagine that you can get more interesting software development ideas
from links to previous messages.
I hope that the desired clarification can become more constructive.

How are the chances to move such code into SmPL script files?


> but I would prefer not to put semantic patches that involve iteration
> into the kernel, for simplicity.

This view is also interesting.

But I hope that this functionality will become more helpful
if we can agree on value combinations which should be iterated
for powerful source code analysis.


>> I would prefer software evolution in an other direction.
>> https://lore.kernel.org/lkml/44be5924-26ca-5106-aa25-3cbc3343aa2c@web.de/
>> https://lkml.org/lkml/2019/7/4/21

Would you like to add any more advices for affected software components?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
