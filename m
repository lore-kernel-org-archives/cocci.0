Return-Path: <SRS0=mNwD=XV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08100C432C2
	for <cocci@archiver.kernel.org>; Thu, 26 Sep 2019 06:58:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD8B222C0
	for <cocci@archiver.kernel.org>; Thu, 26 Sep 2019 06:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="OW77rq80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD8B222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8Q6w7fJ023482;
	Thu, 26 Sep 2019 08:58:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0616F77A2;
	Thu, 26 Sep 2019 08:58:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8BAE677A1
 for <cocci@systeme.lip6.fr>; Thu, 26 Sep 2019 08:58:05 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8Q6w5Q1008992
 for <cocci@systeme.lip6.fr>; Thu, 26 Sep 2019 08:58:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569481084;
 bh=ODip6wxAEMDaWUobZJfp6eGiZOLHedHOgXNAisQXgHo=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=OW77rq80KnK+8/Q4h9aKKkzEzD6pn4Am6RejjuCu0WMsG4Ebm2eZji5QHINF/vCeO
 482b06N8aHGAiAApHn56UMq5oBb3RSBHBMFYakB1veLYI+dS6hO3mH4rT89bpniuuR
 KuRS1ll0bz9nuc+bkFHLz3ns0ESixSk1AwGikAY8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.81.241]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MK2FR-1iCY8Y3gA9-001RpE; Thu, 26
 Sep 2019 08:51:11 +0200
To: Michele Martone <michelemartone@users.sourceforge.net>
References: <20190925165414.23602-1-michelemartone@users.sourceforge.net>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <35aa94ff-b101-75b1-9bca-20afef883715@web.de>
Date: Thu, 26 Sep 2019 08:51:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925165414.23602-1-michelemartone@users.sourceforge.net>
Content-Language: en-US
X-Provags-ID: V03:K1:/9qKGM43Xrx/U91GP49hIF8wpd1bChOhkszTndKTgbtB4pwv0wy
 PBOqLlpm/GYs1LG4sViPyUD/GVVMXzJllFBao76DB/A8OB7P9Dh2hXwxODLkzUuldir085M
 nqZ0bQLQfF5KlqaulyjjnGZWjix7bk5AtL3qNF/aw2wN31h6B4JMnLxHALRyUFyD4zBoQ1j
 ND66/X37IiS+CL3X7/FoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fG5TlyT8qpc=:SnMvfYsVZ3uAZUU8pZXxIL
 PMZLUlswk40jkZV13PgeiSOu4fkL4pZbQS0NwdDdHAC64+y3MWH0kA4ee785X+8wjaCrPemdp
 Q0xQUROPtnY00Qo8oC79qCR7s21t0smyo63aB09EsUB7gLyifk4imsfwXz6nGE2gHh7F99Gdb
 cTYZjGWSES2ZEntvcnX6pPAlvYUNsrsZ55godM9NoNG9Yy4+Gf3sP2CciHMfdzupdCkVJ5w0m
 +fStLMRU4Pl3K/1ZgwEgqBUuCyAITjWPqxP582PY+qUtWqwnxA4CK6LagMj/RZkAZDUdKx08d
 wnAbozk2+KguPvXCd9fRY7JkwThBL+rnHb+EiRcCMOCaC/czPmv4z+vdJhNHfh2SBRkiDHJbl
 MgqHd7OVgzzJr3Ee/GY+KMCQtLYP14NUJGN0z6GwhyNGrPPXXzc6qLhyZM1kU5VDO9vPYBvZj
 1QsZme0qdaGGQtqqtkFYzFvWJm1vwRkWnBvEQxsrFkZNHfQAUBZWUT1D98o8iWLkCmxPthV8x
 KkDi+QSZoAInirjQvJ+/fdv1qTGub+UZ/Xbva3CvhsdXSS7tdoLFKbe9FWD+GaKEn+bRPnUnk
 3d9+i2JUQc0swX9jBJYhGyt3xWPoMqdcRwW+JC/3g4i3X7y6S6olfDyyx7TgtDf5/zmM8yruZ
 2DwoUvXN3/8m5JTzXL1PUW/Ju1s3f4JRIbRPJqZc0pXcanCQ2mx346G5YGwSBBdK+GY8WhQi0
 ICTMnMBPn6ik+6Bw0gBrw+Qa1dR3VHmvPb8UNNW23HhtoJI3s6d2XaSh+8g9SJkKjwNJopkUv
 qd0wy0kJtooFBmZ6/3Cq0Gf48QHdAPbmS66EHpDHu+ioJXb0G5zugTPfRU/ryo+pDyhAt6QSJ
 4qbgBhHrFPLJM6O9AkwtOj49tdqeszYgPsIRgKxnsOY0IbUGzYt74y3uf/veBAsatN80LT8T3
 6U+XwEhv3rfWq1OM+TiM21Qb658qODmPgV9MEfJZil6Bsr377urQMc+PpxGJuTzQYnDeAqDiq
 MB5UgA4VKLZeYtBfagIPFuRWVRwk0MyTSJ33zpZDmwdk1rNnSdYKZW3Wc/bviaQG+mQF66bQE
 ROdHzZ6nSMuchRjQgv9ss2APG3hE2JnXSSLl5pExX7BJ2chb+3WaA/aFDwDpex0zqJam5ONFK
 PlRKR5Hp+K30aJq/qPsSoLjt294FSbIhmI5p5MQ2pgD9gFV08y2EyMZQkcJgafIWzIHWeXXv+
 jVM5wQXKFtw3vc1ICV/LHaFsti/vGJI6RA8J4o1tEGZ+sRywfkyeJ7WdignA=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 26 Sep 2019 08:58:07 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 26 Sep 2019 08:58:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] clarify misleading warning message
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

PiArCSAgICAgIChQcmludGYuc3ByaW50ZiAibGluZSAlZDogc2hvdWxkICVzIGJlIGEgbWV0YXZh
cmlhYmxlPyB0cmVhdGluZyBpdCBhcyBzeW1ib2wuIiBybCBuYW1lKQoKSG93IGRvIHlvdSB0aGlu
ayBhYm91dCB0byB1c2UgdGhlIGZvcm1hdCBzdHJpbmcK4oCcbGluZSAlZDogU2hvdWxkICVzIGJl
IGEgbWV0YXZhcmlhYmxlP1xuVGhpcyBpdGVtIHdpbGwgYmUgdHJlYXRlZCBhcyBhIHN5bWJvbC7i
gJ0/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRw
czovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
