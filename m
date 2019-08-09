Return-Path: <SRS0=BmBQ=WF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2E5C433FF
	for <cocci@archiver.kernel.org>; Fri,  9 Aug 2019 06:34:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90745208C4
	for <cocci@archiver.kernel.org>; Fri,  9 Aug 2019 06:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="aUVtR02M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90745208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x796Xm4p006563;
	Fri, 9 Aug 2019 08:33:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1EE17778F;
	Fri,  9 Aug 2019 08:33:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 308CD7788
 for <cocci@systeme.lip6.fr>; Fri,  9 Aug 2019 08:33:46 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x796Xivm025514
 for <cocci@systeme.lip6.fr>; Fri, 9 Aug 2019 08:33:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565332422;
 bh=MNIWJaWzlWnCad1buKZzg47iqcJtu9WQ0fWnXCjAqq4=;
 h=X-UI-Sender-Class:To:References:Subject:From:Cc:Date:In-Reply-To;
 b=aUVtR02MJo7/+pNhUDloIZwV9Sz8VySYTah6F5TlAJJ2pSiFZZH5KhyfDt4/6VV82
 I2xNi1aZIK40KLi4F8ksPEHvRTYJQmYbomVTuHIITBrzW9e8nm2MR+tAE5mr7/Ujbg
 cgYWYtMf2IAMC+gxzcsVkMbQ+PIlQpAKdT0f08q8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.93.105]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lvjoa-1iNhyU3Fmu-017VGp; Fri, 09
 Aug 2019 08:33:42 +0200
To: cocci@systeme.lip6.fr
References: <alpine.DEB.2.21.1908081259010.2995@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3986497b-adbc-c609-3fea-68e914d67735@web.de>
Date: Fri, 9 Aug 2019 08:33:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908081259010.2995@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:p85cKeZOOozX/8N5xf5dSmSqDw5fmAC3gBMspkprSHf721HfDCK
 y9jZ0nb9z7pCLb9sLvn2D8IoNORlTyRFVntuC7x58qjX5A9C7CzpqhdFuOTzKTzec8Dk0a4
 drD3VhTyyMYvB3l4tH/qawn8heAxEPcapjWtxB0m/F3ItN3qDuWSknwpHdzMU6CU84QPW1M
 JHUZdt6nih4x9J6AGF+KQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D2svQGNQpJM=:rUBDEEH6aNOe7f1Z7elUq2
 ZSx9IY5fv9s1Zp2KQeI5A2VS5knbB7EVp7GslP7WQECrmDSr2jKNS9fpu+K2qkjlnRVT39fIZ
 FcEYwUGEoC+uEYDyrxLbbcQFhf8G+NKS+R6LGPnHzbJDWQOjXfXWWL1idqaN6Y47UWUYOQHwu
 AuDllJUel3/Da/NS+0oSHYpcOrFyBf/Tw72QeQyfX9Edr/DM5eFJZcUhEAhUm6ujzkiY9qJBo
 /69OpEQg0xsVqF8ntjR9As/klSTPZcC4PgV/wtEmdvPT9avgsCJGLbiFaYfK0WY8+W4RZHcoi
 1IUzyk/Dc0daMkuAIEDfC5uT5UFNQrh62a+kFqM1QC47K58FuDajpNTfSrKcYGgOjh6TXIob8
 pfpe+e9JZkt1xClhY/RREgWX1F2q7iUgqD+2t5LPVr1JtiKc36p9PaCJrb3gueh+jz47V61wM
 nqWxbEixVhD2texaUe4gmkdCmLI0JMwFrjeX+9Tk6x2bkcRenSjCR0uf8kKxDEv0yMQQ6pSg/
 tcB6OHG8+6DiMENEuc1sSuYNydkCD5ty/fmfudCGkaGBEQHGj7xNUmnO8o2TYeeWToeGmfYY0
 nl7eQ/mp4j7uVGjcRl4xMfAmSNsuQ9TIfkkUi0PJuusbyK7dMPx2b0qAcEWQgS+dKiZj8RH4y
 FIiQMCQbuVrf+nTWiIbUSBalmTvHlxIyOihWl9YRifi5fT9MmDy7KMChw9HJpASV/hpH4VQ8H
 ofi5NjhwKkdMR/qaHkxfTI0iZlEy5DDjIZNlkK5d+KNkSCYTwOdg9MJw/iZnuKscaTGKcmurf
 sHVvFmcGP73xAKWhmKVF0N4AgcDTbSwj03tPhGuNjccsqNVVDYjlU209wgU9lexMRIuZWk9CU
 uO0ZWnhIHuVLXJyl1Gf/58gqXT6/q2FVJJN6GLn1y74yEg7lFuejkaLy6dG8opT/TcJBClwmC
 qQhwzJt/5JUFruTO0NDq1RkD8/qhrTCFefiiGrF15XrWcO23cwyhmrFPajterLC3GKKt7Iw2f
 iY8hsaU6e4oamWJ7rZvyN5pm/33ojHJIfpNogj8kQYM+8sRNocenRm1HFNERqteJUhjTq3xzl
 u2nStobRfXA9LX00HeyoInqgoDU8iwnE1Uv4rGH4H/8PficyMP3cVqsYhzL3TlCYZLgE89+Za
 DXJig=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 09 Aug 2019 08:33:49 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 09 Aug 2019 08:33:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Remove entire multidecl
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

> > Not exactly what I expected...


>
> SmPL doesn't support patterns with multiple variable declarations,

How are the chances to adjust this software limitation?


> because
 there is really no way to tell whether they will be on one line
> or
 multiple lines.


Will it become more interesting to make such a case distinction possible?


> Basically, it is matching the pattern multiple times on the same code,
> once for each variable.

Would you like to achieve that metavariables of the same type (or kind)
can refer to different source code?


> It seems that this resulted in adding a blank line.  That is indeed not
> really ideal.

Was just a blank line left over after the deletion of declarations
(which looks like an addition in the diff format)?

Would you occasionally prefer to omit it (because of pretty-printing)?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
