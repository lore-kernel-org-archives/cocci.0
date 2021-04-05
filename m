Return-Path: <SRS0=wKae=JF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB5FC433B4
	for <cocci@archiver.kernel.org>; Thu,  8 Apr 2021 15:44:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B40DE61107
	for <cocci@archiver.kernel.org>; Thu,  8 Apr 2021 15:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40DE61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 138FhnmF017898;
	Thu, 8 Apr 2021 17:43:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D5CDA3CA1;
	Thu,  8 Apr 2021 17:43:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 83BC33C26
 for <cocci@systeme.lip6.fr>; Mon,  5 Apr 2021 12:37:24 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 135AbN9o003514
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 5 Apr 2021 12:37:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1617619043;
 bh=+FrERo7FrhS617n/sbgZ/U+UUMorQq+8mnFtaSkQ8gI=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=YPwdBt0zjtZq/Ts8q+LpDyJ2Duc8zWr9ZQWpz0RXHqTGmNZiu+qIIFh0WXp1+H/wH
 bqq2aP/1/D8DonyuyCaUl7S3vsEjkUYXhPmonMIgSqXVR3FN6xF+MYmOWgbfMCRnN+
 yhuVPYsTbENig9HuwPHbgenwf0r/yb0LwPS8EQPE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.144.25]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGRZc-1lOwkt0XqK-00DK1Z; Mon, 05
 Apr 2021 12:37:23 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <0756b630-a2d7-f300-3b11-59af33b48631@web.de>
 <alpine.DEB.2.22.394.2103281128560.2854@hadrien>
 <1b5f6d22-5b89-097f-37bd-13b3b2ab011a@web.de>
 <alpine.DEB.2.22.394.2103281244200.2854@hadrien>
 <173fa182-4127-aaba-262e-e3953a81a1e2@web.de>
 <alpine.DEB.2.22.394.2103281343310.2854@hadrien>
 <f720b262-708f-a603-3470-b374db625578@web.de>
 <alpine.DEB.2.22.394.2103281644480.2854@hadrien>
 <fa66fce2-e60e-1907-7c8b-fd9ceedb8086@web.de>
 <alpine.DEB.2.22.394.2104041357060.2958@hadrien>
 <addb2edb-98cb-2834-b1b9-7d44cacda965@web.de>
 <alpine.DEB.2.22.394.2104041419290.2958@hadrien>
 <b9f6aceb-7e68-303d-bd1e-d41a7992b58b@web.de>
 <alpine.DEB.2.22.394.2104050907270.2981@hadrien>
 <8561006e-7dc6-0f62-ecf0-c93146976925@web.de>
 <alpine.DEB.2.22.394.2104050953290.2981@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <8504fcf1-9736-81f4-430b-9e24a77ff816@web.de>
Date: Mon, 5 Apr 2021 12:37:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2104050953290.2981@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:dTZore94u2SNBPfoNwKl1BhVmWgwvOo6NqbTC2ZH2uzQQsKNQbK
 i5eJc8V66B7C+il2dCGql9fSk9rBQS9+6rA4xv5UZ2Gikm/ZZVkxxy05lOdGjouO97fUKT8
 XLgWAhNGZrXil7w6kzqhfWt2vT9Kd/GYzjqGrv1AwwhodI5QFau6Qn3LWn5v86FytdVh5+0
 W3dRqvWL6M6hJ1yEGJ9LA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6UzDVBcz/uE=:rWV/2sJUktoVqC8/L9WcdC
 dxOqPjdStudZW9yG/xA7I13m0RovbCSwjLFvPRies1Zk6wCaUjWmMGUrrTJSatNqix0D1Vpa9
 wwH5IktPE2GK/qIiovB8K5WVCnstd/ocWKj1MMI61zWp3ipV7aPynhOs0EbPPrsBZ2H5cm5SC
 mle1INDkRtXij9sZLklso7XVS3aFzzCxK1ZFmwvKWTcDIIT1UeCY8LZiqYmvA2PG01PwOvFO0
 iEAIcUobvtCn6i9BSPnpj67O1OTQ2WYZHIoMTyIWpETRbVzl1xjM8XgFjYLBYUYcWFc0UbgNB
 fbnyEU/D5UyGuWK37wFVAVxjOhgl0+bVuWsNopYtS0wm9LSA/5G82gdIbWiEiLuFbX12dSQUq
 2D1Q4XeTPCrEdE/f9DfbCcW+eihA6KXP89uOhWuhpdTwdFJ9TDVoe/lz6h2ROZvoUcPmib1cv
 OSDX6iw59Dp5iogixiSNIatT+a2oDKcrqtB80C7oNLXkqjKdVsQZHLTxayJDejCnqYtfu4VK6
 Nrisex5OiwblgpTwz1Bwc98hcd4o5nRl0QA80ph5Xwr9YhjTAz1XFcZR6c16JOogNZdL46YSf
 vAkcj77lEuhwrJO+ULzr7puDl7D0NG5yLkCdyia20tK7awKUvbcrh1o9Iqz1+/hENNfWX8w8B
 QD6aY7qKaAyLxD/wHn5tfU15EFbCaNMChAf69Yu3eQlmuGyrJYSD7eC+rgSAEzbhAm/U3a+Oh
 mYRBDYaM11dvWoOy5MCHWRB8nIwRrPpKBfQtsvwv1zwlo8tcj3vBOIJ2LWoEmDdw5TZ18qx4L
 8pyjgGo/pii3cJK+jfOHTIlJxd5IkoWdffvjxF+fZi1lH5zTlrre4ZnyEpGGGt9cc0nk6TpMB
 jV6BmZ0aqR2AFPPJq9Cm6vaTpDqnMC3OKsAg++UWyqNFO5ykugW8NY1PBonJogimkuQMJwY+L
 Zy0bKcTDGnv3r/qkTvpj7I9JeI4+SiauUwuvSEyKjIchcEhzvwBYtDnsOOAaKlGeTtX/Xy87B
 i4G9nqog3CRgM4bRVeUSRl2yerafiLNrYM8uk1QujKY7esvPKSghZHpGOfpuAE/JBI1cZJOR5
 bUxRft46iH4iKAkF8hxeJuVJyGsYMUKINhUW2n3y0ffy7XUWvnYXP0jWMRJxJ0rVKBkTKtwcH
 hBtLcnoUh+YfHDQMuCi7lI6NxVDF+YGn2mSrrm2M1rTYBGqJ6vqjG9iaZwXMjoKt7xgp3QoXj
 t1Pt7wLoejn5k8HVs
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 08 Apr 2021 17:43:51 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 05 Apr 2021 12:37:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 08 Apr 2021 17:43:47 +0200
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Improve the handling of string literals with SmPL
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

PiBJJ20gYXNraW5nIHlvdSB0byBwdXQgdGhlIHJlZ2V4cCBpbiBhIHB5dGhvbiBmdW5jdGlvbi4K
CldpbGwgaXQgYmVjb21lIGVhc2llciBhbmQgbW9yZSBjb252ZW5pZW50IHRvIHNlYXJjaCBmb3Ig
c3RyaW5nIGxpdGVyYWxzCihhbmQgdGhlaXIgZXhjbHVzaW9uIGFjY29yZGluZyB0byB0aGUgZGlz
Y3Vzc2VkIHRyYW5zZm9ybWF0aW9uIGFwcHJvYWNoKT8KCkBpbml0aWFsaXplOnB5dGhvbkAKQEAK
ZGVmIG9jY3Vycyh4KToKICAgIHJldHVybiAnIicgaW4geAoKQGRpc3BsYXlACmlkZW50aWZpZXIg
aSA9fiAiXig/OltBLVpdK18pezMsM31bQS1aXSsiOwpleHByZXNzaW9uIGUgOiBzY3JpcHQ6cHl0
aG9uKCkgeyBvY2N1cnMoZSkgfTsKQEAKKiNkZWZpbmUgaSBlCgoKZWxmcmluZ0BTb25uZTp+L1By
b2pla3RlL1BpcGVXaXJlL2xva2FsPiBzcGF0Y2ggfi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL2phbml0
b3Ivc2hvd19kZWZpbmVfdXNhZ2U4LmNvY2NpIHNwYS9pbmNsdWRlL3NwYS9ub2RlL3R5cGUtaW5m
by5oCuKApgpAQCAtMzUsOCArMzUsNiBAQCBleHRlcm4gIkMiIHsKICNpbmNsdWRlIDxzcGEvbm9k
ZS9ldmVudC5oPgogI2luY2x1ZGUgPHNwYS9ub2RlL2lvLmg+CgotI2RlZmluZSBTUEFfVFlQRV9J
TkZPX0lPICAgICAgICAgICAgICAgICAgICAgICBTUEFfVFlQRV9JTkZPX0VOVU1fQkFTRSAiSU8i
Ci0jZGVmaW5lIFNQQV9UWVBFX0lORk9fSU9fQkFTRSAgICAgICAgICBTUEFfVFlQRV9JTkZPX0lP
ICI6IgoKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BhX3R5cGVfaW5mbyBzcGFfdHlwZV9pb1tdID0g
ewogICAgICAgIHsgU1BBX0lPX0ludmFsaWQsIFNQQV9UWVBFX0ludCwgU1BBX1RZUEVfSU5GT19J
T19CQVNFICJJbnZhbGlkIiwgTlVMTCB9LArigKYKCgpIb3cgd2lsbCB0aGUgc29mdHdhcmUgZGVz
aWduIGNsYXJpZmljYXRpb24gZXZvbHZlIGZ1cnRoZXI/CgpSZWdhcmRzLApNYXJrdXMKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBs
aXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFu
L2xpc3RpbmZvL2NvY2NpCg==
