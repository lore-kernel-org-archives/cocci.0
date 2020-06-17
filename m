Return-Path: <SRS0=bgdO=76=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3385C433DF
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 08:52:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130C521527
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 08:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Z1Z1Gs35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130C521527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05H8qAxc024253;
	Wed, 17 Jun 2020 10:52:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3F7B67577;
	Wed, 17 Jun 2020 10:52:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B920B3D0F
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 10:52:08 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05H8q822021293
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 10:52:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592383926;
 bh=IjKGLBgDlTmu4a/bA/djtR70pY0cXBOel72+YMBSSyQ=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Z1Z1Gs35rX3aVvbS+jbzb1ihP3dEuZJ09sKkLt5MkKNLbTxOT/GGVESZ/YnXWR9b3
 9rIBZd1vrlcorzYayWDeaHlaNak1KFm+z4QrGZ9YxjHVzy3EwK6WB/9Ki9irxLDMeL
 k8yHBlP8HCUi1JDz//dKdQNBeXvMgzkxhlqXQwUk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.115.66]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LbIyo-1j1iqi1oj4-00kvNg; Wed, 17
 Jun 2020 10:52:06 +0200
To: Julia Lawall <julia.lawall@inria.fr>, cocci@systeme.lip6.fr
References: <37e4e561-8d88-263a-0037-f58cb8c1861e@web.de>
 <CALOnNCpr_-1BLPN+Bayof6XjLLvVrMgR4Z+EHpC_8RnAOWiD0Q@mail.gmail.com>
 <15347e89-21a9-8e08-8301-fef957c7332a@web.de>
 <e6a9456615df93634d86eb342a3282809fa62acd.camel@gmail.com>
 <781f2962-b651-9849-d52c-f2e7818b6cb1@web.de>
 <alpine.DEB.2.22.394.2006171037170.2501@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <daea11ee-15b7-d85c-76b8-2427d63fb018@web.de>
Date: Wed, 17 Jun 2020 10:52:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2006171037170.2501@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:TNnZq5uefvmC1cQvwqaibMK1+VXOTOpeAVvkyGYTkon3Xma66Bg
 gqqAb7nMvZlVpMP3Ht97gOHT22LSw0qbZt74SbaRERtQvDbhC1M/25ZGljywNI8b7CX+ua5
 +OHlcNappjv7xvdP/xs0LkuLOEc9nVLWeDdH3Rik4eO9D0YzN0W47amNesrOiAm4BybMWWI
 AM3GduCwL1xv+IBbZdg5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uTC29qa3NnY=:oGHPcrnPTRS0Db8HdJ9P4D
 XNii0/nW1kDY+LxBemv4bp6dJfAYanzr6TLptMWQUMW5KRK1QfsGudf8P0qh2LN/LDdXmOFoU
 F1IYxkyeI3O0UWnqMf2SfNclk8D8I8aIbXfXTHdkENun+ynM5mIa50UBDZ5WQKQhwv/3lhoFi
 F4VcQzNkObPnUi0p5cheVYELHA+dvQ6rOyXozN+8HNRgY5KFP7Z8IEu3t+TvL54/KSAOHp4ll
 lfvzHhu62A7lAHHppcXICR9I1L5zxD6Nt1wMM4bWgptPkbxudki0OE+v3YnQRFQ4Wfl9gTRqc
 yWGJyokFmYr63afVUcUxL6dGwtvQtHUidohm6npjdfq7n8hu4DeAych+6Mu2QXq3FIvHkQjne
 mjL5mr20qgSpkl1hmVA6u/8dCHNostmVYKbpLWdl/RkvdcSpGA19/HRF6rCI7dGM7aiskYjQ5
 JyjeKtrtriUhpdCgmGYob8lZQXwFHwCadRx/X7/NVfYiRu0TyIqnaGVcq5gBiPFDq3xosrRRt
 9DUS0Ai1hEttNzp+becvDR33KubbS4yEtZkHTGrSjlZzN6VWsrTpk5/+wl6qNnltzeVUhd05U
 3AEowCaZGl/LRqgNDiz/Sru9Ayy1dBiQlsq6JGgulId53AzGYXJIJj8IO/Rwspzf1SReo9Lfw
 uj+wfXqn3vlphdaWSZGffnqlAQ0aKbutdgLXxoc4ooIxQ5Q/DR9eB0NaiMR9a2h1aevFV3diQ
 cNnkyqwgt10A+rVOgHYYPqyTjIORC+9eX1cTus/8pe8wHcytGK0NNQPTFnhOv3by1ocn3Phs2
 9n3Zf+Wb9SbK7wpfKPOjh8i6oycrX6VXSWKeDua/BWt1VI4sYJiAffQT5JpO0GmLJrqALgC1H
 nQXqs/DwHuexgN5Pq7yw9I5M09ypsJqMGgDIRn4ap+5qBWAi59uRz/VpRq70nYdMvWVQytRVo
 TKb87UJTcsH9pljfUQfT75tg9E5UX8DLEu+fXOXCnZrBVQywTw4TIiooT0ToV36NHE6JCZtIt
 mFJ6C7xj2j1WeheJUp6lVJ+3hFkaaDbs+FG/2G3LQlLpgQNrX0MbosaWY7UJkCc3dzuDV0dXy
 60YVV8mWoTTjk4shmkWlDDMl8swnDQRu6Y6b+YKICR8fUjYBz4Ds9COUu2sV1ZRm9/HbH8qXO
 rKCUPrjmA1J6hQPqHbZcKqOnGUgS5KjGHkOnQHOP14e57mL61YGlOhDfX6YExIH5ZlRTCDlql
 cBd80/4A6iBV2pami
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 10:52:10 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 10:52:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Software analysis around data type annotations
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

>> I am going to present similar questions occasionally.
>
> Please stop.

I hope that I can continue as usual for while according to a desire
to achieve further improvements.


> The chance that people will help you will increase.

This would be nice.


> No one is interested in quantifying software development resources.

Really?

I suggest to reconsider such a view.


> Even your favorite phrase "my software development attention"
> is really really annoying.  Just drop "software development"
> from your vocabulary and it will be a step in the right direction.

Will it become more interesting to clarify corresponding communication difficulties?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
