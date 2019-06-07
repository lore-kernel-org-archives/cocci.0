Return-Path: <SRS0=qtAw=UG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE90C2BCA1
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2019 12:29:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94426212F5
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2019 12:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94426212F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x57CTeux020260;
	Fri, 7 Jun 2019 14:29:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E63AE7770;
	Fri,  7 Jun 2019 14:29:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E2638776C
 for <cocci@systeme.lip6.fr>; Fri,  7 Jun 2019 14:29:37 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x57CTb7E012972;
 Fri, 7 Jun 2019 14:29:37 +0200 (CEST)
Received: from [192.168.1.110] ([77.2.74.140]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MVNF1-1h9c2K2daZ-00SLpx; Fri, 07 Jun 2019 14:05:43 +0200
To: Julia Lawall <julia.lawall@lip6.fr>,
        Markus Elfring <Markus.Elfring@web.de>
References: <69c34970-8b6d-a2a3-2e8b-0b6560f78505@metux.net>
 <6ebd6ec8-bcd0-3dac-8992-a6c8d9a14939@web.de>
 <alpine.DEB.2.20.1906061137570.7612@hadrien>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <9745086a-cb39-b751-9cb4-faea0308e3a6@metux.net>
Date: Fri, 7 Jun 2019 14:05:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1906061137570.7612@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:m/lkINROpZD9HYaPMHohN70Ays5w9FF+0vaHpQN6ZDJY5BeiZ1o
 HEWI6y4HVheO8kJyn2Ofm+ec1qX5AEumEaXjupybwnIANIsLJhfC0joyLUDcj3l1mZKQgDz
 Pik9kv5bne74mCpCXhbVeMjqfGdjCmOmLamXmopPmD8hKawGcN/6qBGq0u/K3xArljC7ftG
 wCG32fz43zrz839ZKv/Pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n1aP8duL1i4=:5Sa1M/Yw5zNvpA1yj7Mcd4
 /eLgaxQk62Dw63O/bJsfHJNzhP6u/8oWh+i9XNzS7x1vz35d8q91oBs9NQH+82B5Xoj0ulXfc
 5nHxfWlF25nu7EN+7aLZPp/jsFWH445TAopHnRVMgWzh2dm8IM9sSO/3R5KAR1p5mm1enR+dd
 T4bKRg388kmuWbzsflXalqQnTJ99o2j9g/3B8xBDBeh8qoS8NRRoiPQs8VbCLtcGny4JbKKiv
 lB+dk5dyxX1zj2NYTH3mxD4mWqz7kIfbyQMTHxmyZfnNodNyGlVG2GamkzhO/I6zu6zXDoH0W
 ApFqXA151+3g1fOG95GTUpBa0M8dPRtVaV9WpGXY/qL/xRbNZ5C2u9rAiVLTYAQa9jSPPlZDb
 OT//NMAFZnfoxeINxQHrbEXRa7EeIo+bOEH6lBN+Unyiq8xxvwvFP6RFgj6M5UqODaHuboGjy
 5Zee1oOPLRzCbpj0U76zRsnEw1ff7pHP3ZK9m4dv6Ii+GzWjI8ad8n266jiuo9Fo32CIw5Sqf
 9ggU6rm2+ovPaA6nKTTH0lUQW3aQOPmzTdO2FHvSn4w8QLraG4pATyF6nS0SO9t8QAAHK9Hrz
 dJLOsqEKlri9Aqm+Zyy9Cf1EexFo2jU441YPB+Mzes7xyJ9vNKeF7AKtDN1iyvcuObkGRRH6H
 4M2IkRZ6MEuqmYkf9sqGopjDeRNzhjbkuoFyt6x+Hrdzj+1zMjgudztOmyqp2C4iaNfqvQ/7O
 jprJDzbwYFfp4RBuyvYisb6D5sgVQaJi6oQBq2/dP0okb9APynWdhpIfFGSUwh4hwDjqyPBas
 sytxxZIFdGj2Qctn6ZWoDEDsehds8IyVy+aqiDDn/vzfoEKxQOAW4ahaKdsDIY3HxHV3VKdZ1
 lYuDQVjJeBfH93kApl1BIw4yP7hJIDYaDPF/HSQMITqpYQspvPeOY83FBzwKoJGhqp5ohO8GV
 evJ4EKAif3LQdZVn/+28ljNc8lAZv2Hg=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Jun 2019 14:29:40 +0200 (CEST)
X-Greylist: Delayed for 00:27:47 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Fri, 07 Jun 2019 14:29:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to replace obsolete #ifdef's?
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

On 06.06.19 11:39, Julia Lawall wrote:

>> See also:
>> https://github.com/coccinelle/coccinelle/blob/cad4c0705f9e37f501531e133d3a47bc56ed0ce2/docs/manual/cocci_syntax.tex#L1765
> 
> To be less cryptic, Coccinelle supprorts matching and transformation for
> #include and #define, and addition of comments pragmas and ifdefs.

Could you perhaps give an quick example for a newbie ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
