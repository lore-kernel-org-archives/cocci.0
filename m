Return-Path: <SRS0=z6Ab=ZP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDE2C432C0
	for <cocci@archiver.kernel.org>; Sat, 23 Nov 2019 07:55:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0AD620719
	for <cocci@archiver.kernel.org>; Sat, 23 Nov 2019 07:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="TcABUAV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AD620719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAN7tb4N029386;
	Sat, 23 Nov 2019 08:55:37 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5354E77D0;
	Sat, 23 Nov 2019 08:55:37 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4696877C9
 for <cocci@systeme.lip6.fr>; Sat, 23 Nov 2019 08:55:35 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAN7tYSk001766;
 Sat, 23 Nov 2019 08:55:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574495734;
 bh=7hHzw0C0YGRwlgIt9S82k7Yv78dkvOiWFZ7ENmcGiqg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=TcABUAV2FNqH9UrEZgrGUfuBbiNFVPsuyRJUBZawmUGcit+L6aUHLSeg0o/KQ5FbA
 +05ClIhYVq0zFJTHy+4vr0udLC9kpjCfrVybw738yPYHGpa24i7wAXwZmlrXikugvc
 tE/F7TMGFax72sikjTkDo4u+5tJlqvpZr2lBV0CM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.18.189]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxfGh-1hkR6D0vnv-017G8Q; Sat, 23
 Nov 2019 08:55:34 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <cc561358-4d00-9f1f-eaa2-8fae400ccc8b@web.de>
 <alpine.DEB.2.21.1911221025570.2793@hadrien>
 <8a44f286-72ad-14c4-6ee9-b8aa25ccba3e@web.de>
 <alpine.DEB.2.21.1911221050320.2793@hadrien>
 <46f7430f-8176-27ed-1150-af9fc69b03a7@web.de>
 <alpine.DEB.2.21.1911221134210.2793@hadrien>
 <da29f2ea-7037-3237-8ec5-4464379e7a54@web.de>
 <alpine.DEB.2.21.1911221155320.2793@hadrien>
 <599a5c47-75c5-f0a8-afe9-3563a20b70d3@web.de>
 <alpine.DEB.2.21.1911221351470.2793@hadrien>
 <87ef6d2d-a66c-5566-ee27-db360235c332@web.de>
 <alpine.DEB.2.21.1911221609420.2793@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <af01dfa7-3fce-732c-6f62-279a1d39c7a7@web.de>
Date: Sat, 23 Nov 2019 08:55:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911221609420.2793@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:sbVq5Cxr5iVKexqD6HWEwGJLZPL5vzekNmsONmhmKhXf6qM8QiG
 LBRqXd4AxV6uUY2KUThPQZTsRW4sD4eyLJRDUn16eJ+7fsadgPYtROME+l16j8F20fnHe/l
 LeC/BMkELSGu/EA33sxVQgRBvRBi6GxN1zDOIoi3zE0gTH6uTHBMcbAaD3wYKcWamhVnFx5
 xZtzOs9/Fie3r5VZKlZeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qAsqDOZmrwg=:4WcLPrWH1fH8EBOtc4vF8W
 65G2SJMsNorCBfQfcLTwxWg2nxkT0IqeJXjhA7pFV+yLInflJyqZ4R7WL5rioTEQxwnF7RXBq
 9TZBDhokUkQ45ysS2V5wFA0zgYtyR19i9e60JWrrfhRYoLbOxVa63Apt48ax5VEkTijGs6ebR
 KjVy4Jqy0Bc+9GtXlkt047wD6erBlwBaUt6BVLMlxCnS5PGoauAjXNPlWqLQiI4mxVATQZwK4
 FxQMJn5lZKVFJUjzAXoqSus1qGf2sdwLeso9MDkTcbwzMIymT9p4nZjDWE5kicvh+6L9C313Z
 HuRuvQnUsY1Rqpn87BvLIucOvCPmXPsOYzb5MQNyIcfJcuiLJuqmgXmbo1FG1WX8ZsJZRYyCY
 k169znVRaMeg13Qzkll4w9/J9orJFDT1ZF17gJ9HNE+/K7fjtkVs2kbUThQ22vUB+LBoyJhPC
 MQIr5tIqOA/xqkMf+N5O7X4xCEzAi0ck1exgre1MsCuxoK1y5331/01pvTIch4NCJZvdrZTyk
 5L0vf7YBAUZ6pbu1uycbdVyPukF2dqKYzexCuMHk5r3bQQ/NzUtj4XTpCxeIqWSvrLm/pmaFl
 s/aOhxuyVD9ImIQeQ+JuJhDxdtbYwvMZnpwW8+bP4gmWkU1+aT8fZgeNK/qSHq2XOSKdOdIOT
 PYbg3NA3J+ibUTyV8K1E7/ut4XZk5QdjWYywnJmtGhc0Y8bVgoI7imF0r8M+oy07UJhdpNzWM
 j4wbJMGeFf7CdosB0+W4gyHD7eZRU4TRgAiSWtPCUkYhnFm2Q76uQ2p8mTNyd2PmHl/2ZH8Dz
 14zOGpa5X73+ZQcbCtQYHIXYJFvQuEAS31AWZzWeKRpcZtvexkdPP/jpiPuFzGU1L3mB8dHGB
 +5PKRQVAf5eClVJcwPqz15J8ED0/GOvh4Zv42jh7/UA344ocZYGwsbOosyzWT9yDI8AMwS1uj
 86P68YazCTikj98R/uSqDcgHcJOUN6shpgzbaF5LsUBSJ9eIi/7XQ2wpkG0widIlJe2IPXkQL
 XRTLy9yqWglbNp+LTvz732tbDqMV62c1j/gJ5XVv5KeZqbPQITTqhksws34Xt0ENkxp2NgZUa
 hJw9gmHkGNdFB4CwVKXABa5mrNzR/Q8KeCJvAvlCAsYHk7aFS07+kMlHxbZUl3qUnNbfTIUsI
 fKp1DqojhfrnspwDR0Od7Rl5+xDwahNQaL24GPRkrmtG5vqCeYRLa6CmRSD6GUUeTQj1zzUL4
 lbF+45yXebabcv9eUu5Fv8ptgGyQbKi4aqOapcEXO+Nz//+9hAJuajFABEYo=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 23 Nov 2019 08:55:38 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 23 Nov 2019 08:55:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking influence of variability with SmPL
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

Hello,

Metavariables of the semantic patch language provide common information.

1. A fixed type (or kind)
2. An entity which can be variable.

These properties can be distinguished further.

Another example:
char c;

Such SmPL code looks like the specification of a fixed data type selection for
the C programming language.
Do you know anything that could be still variable for such an item?

The situation is different for metavariable kinds like the following.

* identifier
* struct
* expression


We would like to achieve source code transformations which can be compiled
(or not). How often will it matter then how these selections will be applied?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
