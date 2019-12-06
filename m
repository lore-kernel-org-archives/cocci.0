Return-Path: <SRS0=/zSI=Z4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C232AC43603
	for <cocci@archiver.kernel.org>; Fri,  6 Dec 2019 19:44:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9F42173E
	for <cocci@archiver.kernel.org>; Fri,  6 Dec 2019 19:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="CiadqBxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9F42173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB6Jil2u013538;
	Fri, 6 Dec 2019 20:44:47 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1551477D9;
	Fri,  6 Dec 2019 20:44:47 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 84EF577D8
 for <cocci@systeme.lip6.fr>; Fri,  6 Dec 2019 20:44:45 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB6Jii32011684
 for <cocci@systeme.lip6.fr>; Fri, 6 Dec 2019 20:44:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1575661483;
 bh=pgeV7fN24vleFgFPoDCMyB7UuwyPV3WP8YZwr4R/udc=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=CiadqBxT/jEvT1qidz+L/F3yp0u5+TF3XASqW9835GLfR90cevOBpRDuANBUplKQS
 si4rYJW4cIwN3apVVKi7rpzEP2aXbc238bTTl3UcMoq+WbYjj2IOf4sw+n5GdOh4/I
 MYUoS1ViN1UmqKZ8EY+ic2upIdGrprXr605yXvaA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.146.60]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lhev7-1hzpqF3c93-00mvaV; Fri, 06
 Dec 2019 20:44:42 +0100
To: Julia Lawall <julia.lawall@inria.fr>, stracelabs@gmail.com
References: <1624931283.11188831.1575442063589.JavaMail.zimbra@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cedae0df-9cc4-b81b-25e9-a38c800af6b5@web.de>
Date: Fri, 6 Dec 2019 20:44:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1624931283.11188831.1575442063589.JavaMail.zimbra@inria.fr>
Content-Language: en-US
X-Provags-ID: V03:K1:FPTcyFXs5mxfqUav8L6EwfXgacROaCkcZYQVLbml9elJEslasfc
 e3d2jzPLB3KAyi8hlkzswhjYpotjFq3S4p7kFLghWrBb8luO4OCircoRVpAxPppoQOvrW26
 THZch/EcxZP06HrzmnwYxnVAAoT2R6uM5cqMFTjQ4C0a5Q0OXTMzK0/HL8v7iBaKJ3GHVuE
 MAFBTWeMgrt4o+GQj3wSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O96htWJcrx4=:nqowwShfR0ILKuiYlE9D9R
 MHugP5rFm0+d8uXcpTb/Mjmo2rs7mM9+NdzYhqysQyrlbkhKQ5/Ix0xIU1pI4Lrd+T6dolEcv
 F3XoYjtzXySjeXisw4xePKrit6n4Ib5iXnUhr7eVIXv9176kKVq1C0n5O9Kg5Tqi4v+KbS7cc
 u+ddf+bpSAZdQ4+2pbJ0iptD7aPWQPymraK9paEgms6+hK5wIUUD1di/qHDrpKzkdcjW0b4kl
 5uCXPw9pOK/74QyKfiDqWhB/nII9yEbJAidegvpXW34WxhWH/awzWf+b8InIdoRe4rguiy3XU
 TW4Fdr5OhdGj9vSCzUq1PStwzEfwiKrcJHfmvzFW7MdQcrbS0dRTkRKYcC9B93mrR5M+CBSG0
 ErloDFg3nrgNUelSsm1u6uRiWVOrzYKRmem9xpPPzlDXmRoPP3mTm9uyNec+wViadckonxcjO
 wnZ9b5bupuz0Ux9ZvMAtmbPPGW6uuGnzSsgWMiuWYyAYHmQ0rKy69M6M87XN3xoaex4fwb4Ql
 EUS2M01TDcLgCjr6LUmfAwNMNS7y6NSfmr/FJ/yi0RmkAVXxu6RgCWel4kHNQmJhov57PQlCS
 aPbRnR1NM01rQ1MVIIreKm0aQTXxFhLmjR/PfdyteUrmxDprncaG+zUS1urimWo171bOtjaVx
 xwqMkCrJTvteczrcfWMkT41cGeKRK7OLL1yJ+QdaQfT5HyA6zqds+D2pD23FoZJBPDjRWyc6e
 yPnFXIwl9bAijZHpVkdggYMt3QrGY6bZHlUDN/0FPu5WtP5CSS7H/OKwoIO2SfQhoaNXZ4wEW
 XAy6NXWWlbnSAGx9RQyBiVVWJe1PgYWd/Tq/6hry1PcAsutqvKwH1ZFFAfB9OCJ96bmI5dwQf
 pQ5zZg4IEvf8orWxxKBnpn7mE3ZfYAq8sAuU9cxuo5ym2T7Ed4Pq0ZnojBRuhO4TnN0CjHlUp
 eZZIXl/1gea8hcpNdwRyA4V0yaz68o20V6oIgJKX0c6IoqvE2/xIxg/0GU8ayQstl9BYUP7oE
 PnmEPlhsTDGOzjRxuuz5wXl5rvBWFbjX1wKCealA75ZFM/XdV0ZbmkYdTk7IZPrNpC+XJnP8S
 5lflCF+bmPBd5jL+k92eIARJUo/uCDuzxqjY2eQvcHBanslM9CbP/EdbtlQYWzfN/Pmu5x5ak
 8ys6fNKdkf6gsaDkiK2RBqRjkHsrlEU9/Cr5oBUZyw+yzO1k1mFWwm4xPzk+R2uboLl5d4LPT
 o53SDL7dCh6fxpfbS3L90VrBmFgKLWKHQ6bAbbzx3pOvY++xzQ+imiRoA4Ns=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 06 Dec 2019 20:44:47 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 06 Dec 2019 20:44:44 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Changing format string usage with SmPL?
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

> Could you fix up the expression list first? Then you can write a rule like
>
> char[] s;
>
> fn(s, ...,
> - oldcode
> + newcode
> ,...)

Can it be that such a transformation approach will only work if the number
of passed function parameters will be fixed?

How should the data processing work with variable arguments?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
