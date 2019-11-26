Return-Path: <SRS0=psvK=ZS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB60C432C0
	for <cocci@archiver.kernel.org>; Tue, 26 Nov 2019 07:24:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5251F2071E
	for <cocci@archiver.kernel.org>; Tue, 26 Nov 2019 07:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ftFrfjFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5251F2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAQ7OMvG010584;
	Tue, 26 Nov 2019 08:24:22 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 62CE777D4;
	Tue, 26 Nov 2019 08:24:22 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4544B77CC
 for <cocci@systeme.lip6.fr>; Tue, 26 Nov 2019 08:24:21 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAQ7OK3l009439
 for <cocci@systeme.lip6.fr>; Tue, 26 Nov 2019 08:24:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574753059;
 bh=DFVNvAE+nn0aUAkU/AEB3QNdUmBbIfAhUQpY5rIzgN8=;
 h=X-UI-Sender-Class:To:References:Subject:From:Cc:Date:In-Reply-To;
 b=ftFrfjFLmhJKZnTA99vMAXJf7QFdyBIVJNwnf3PIlfM0qGD7y/EWKc0OxTZjqZ/V0
 XBnz+9ZHIJ5foILKofSTzyVjDRSgkSMu8dLe7RhP35c3JRV/Pf44RWjPg+3bTLHIgr
 KODjYIa0AKURIn3F3I8XE9PErDJkX0cmHPEWV9LU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.133.92.219]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lp760-1huegR0MoW-00et8J; Tue, 26
 Nov 2019 08:24:19 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <alpine.DEB.2.21.1911252208260.2656@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <51e6eb8b-ad70-b9b9-30da-8dd1c8bb8f82@web.de>
Date: Tue, 26 Nov 2019 08:24:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911252208260.2656@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:JpBxw1RMy2TXNy4hBaX9pZ5ST89PuSAwrzL+BFR/Q6pw+lOKUzg
 oHs/TBQxV/M6wBoSdCo68nenIhdQ+44v8ActYLmy0zJlkpZbzD2ErHxImqBoI/1VkeOfm66
 FHJVHDpvD57lHzri6gfpyFIRDKUSW6B0m3gb+VKCZo+6ci2SK6mb15AgdhbwjKe26uSZYsz
 qGwr1slhnhpEugNQDh32g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xKc7WNEN/vY=:XcwDxotF+Qel6JhhzU/Ngz
 vPsIOmQvF7HRqW575VCDxP5JOKweR0dzHaZVN9VUTW4eFqQ4EqNNYx6Nfdhz6zMggUDqHpqDv
 4/B1U6SwyYHJpfauk1BDR76tS3pE4HKEx8EN8cPpCM1+tKaUx6KNEUE3ZdX28WdgftNkOwZXJ
 HipxPifUAuC/OuOY4oC/hOhMzJ3r0N+1KQeqOSgEJTAIduKdJAGxw21wkNDLlQeuQef43kiWP
 PgdcfZtT6jJgB9+kz20mP/OfR9wfAWvbVnibBUcCdM6ZGDgqTNJAbRlf1JVqitm5XqNXaAqLl
 NcaIPvo98m0cVr6v7pyrmaCgixzJiJ406Va2zES6DWCXg5hjFnaN0COgq1QjpXmqbo9lq5dQ1
 V1I6bQUstWJmHE3ZdscZ2ISZ9MeC8teJHfMVxo9+sTfwDbnS/gcSPRr8UydkNQ9peEBkn2HS8
 mrH0N5eXN8lXhwkLfw1kbfIk5QANh9nUj4f5gsH5nq830t4k3dtuiFJwxF5Ws2J1foD0D4sj3
 7UqGkmE+EhBfg2E2my+KE6dRfaH2FZK1UDqItK1fSoy/MhwzQ8BvtiV9H3vLb7UhFbYKB3RhK
 qPI9g987bmbMt5olmE72LjHUwyLskTlPtth/FGG6IC1D+sF+nry7BvcLLjy3AHx62/IZflRxF
 gLTSM1xdK5TSQ2DeQumYaxAUFgN6boeP0SpXfaZPP/rpef7ntyRlk2j6wiS+OSWutcGH53EfN
 TjiW5KGk0DRQlJFl114QyffBu8E6tOGBFmFdSp2NzbfV0ZI+2AzajAnAKZuqcFsuw2orZ8m9m
 PqTdGxR+7uPDArrruwM2bGNtVVHtAcxW7kJTtt2RESW/ebOGMhHRtgWn0E1NY7oTRez0yXSzi
 NyFZeXvAyNU+WL8U7FJHbZWx8Tbl/hHN6VO1737EbAA6KcRnvbz91dQQhcyqXHqTqrdQuHhcx
 66eBSb/LbRnsPtPvu9s6Nw2ZA1W65Xn3tw3OaIMtBYD42dHVc6Qt4N5NcNLR+uZW5IOJ8jYFK
 Hd7iFFjoTAAGjBOUjJWrU9ybkz5hHIAmkcSPxmd7rD1c9VVnemreKRjfAaE+RNT30IWFFPE9C
 lKJLHf2A1dqfyqxmqVHKT/ryNCx9j4s1qX34LcGHZrpFJ3c6Q0a8rTwvOt6tUnMjU31e9wPgk
 wkzUKsG9fzt/cL06K5vCgZzYno0T0ADuTErApkTQTiM1TJjWV2dfmMI4JwYFsWjoEDqtMkYaK
 wJ+4H5q3WTH8dukJ+nv9n+epCcUWLvlMGSneYZd5agFX6df3w4RV4IU88Ijo=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 26 Nov 2019 08:24:22 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 26 Nov 2019 08:24:20 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Specifying conditional compilation with SmPL
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

> Coccinelle doesn't currently support adding ifdefs on expressions,
> only on statements.

Can the following transformation approach ever work

@adjustment2@
expression x;
@@
+#ifdef USE_F
 f
+#else
+g
+#endif
 (x);

in addition to this code variant for the semantic patch language?

@adjustment1@
expression x;
@@
+#ifdef USE_F
 f(x);
+#else
+g(x);
+#endif


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
