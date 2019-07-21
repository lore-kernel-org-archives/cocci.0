Return-Path: <SRS0=IrE6=VS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ED9C76188
	for <cocci@archiver.kernel.org>; Sun, 21 Jul 2019 11:46:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F252083B
	for <cocci@archiver.kernel.org>; Sun, 21 Jul 2019 11:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="BLc/WjMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F252083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6LBjmLm008489;
	Sun, 21 Jul 2019 13:45:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E9B0E777C;
	Sun, 21 Jul 2019 13:45:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2A5F6776D
 for <cocci@systeme.lip6.fr>; Sun, 21 Jul 2019 13:45:46 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6LBjham006987
 for <cocci@systeme.lip6.fr>; Sun, 21 Jul 2019 13:45:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1563709539;
 bh=dcrqEbSBzXY8gjW7tpgBZOYA4HRCErAVCHLJ8ltrt7Y=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=BLc/WjMPK+owciQQj2Lm8P2p1BkgaCZPbQ9/i/s7XSBF398sDmZ6HWhbPdCkZkiSn
 U/xj1P8Tfm5UWAbWLetA9OktOM6bHR4k+OLnZaoalfMmU/rYkzcljrASWkZLwB49/T
 KC4TyozM2E3efKSkIZav6PgRtDAl5OJNmB4ck0V8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.144.63]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M0hcE-1ihhBE3yKU-00unYN; Sun, 21
 Jul 2019 13:45:39 +0200
To: Raghavan Raman <ragr@uber.com>
References: <CAEgVsn4+aMn_3pXo1fex6_3oWmHbQERhmr42dO0igdFT1u67nA@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8d566cd5-d693-1d66-3f14-e3a6291f7922@web.de>
Date: Sun, 21 Jul 2019 13:45:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEgVsn4+aMn_3pXo1fex6_3oWmHbQERhmr42dO0igdFT1u67nA@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:bY32xREIxRPl9wTvQRJK4NgzvAf7odeebB+KgCIJucBZOsRudzo
 +RnL5jpTiC5c4S3bXAA/3a+2oJXkZujN7iPsGIAQeJKsgifuRN3DMPvR+ceczSPZZ2PUogg
 NSMli9hTncyEDrwXpZjgDB45KgUQVYCbJ45NhnqkVr3O20css1FBSzbq4OKBW/WqnZZzYNo
 lKunl2jKBsViKL3MgmwKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Np0YZzS3MRw=:1gDMNQFpQaHf7n/3ScdCeb
 qnEm8zVHGCWm7p0j2WmPfNTxY6NnrFLm5Buc/NBxP0cyqrZhB4iSyLXpu9gkYhyzX47w2SSxd
 Zkop3UgekcaiBjOgosF/QUdATTM1noyElFHmGIGoUD38USFxZIfR3iUhgMkhvfWZmeffcpmBu
 uQxa/Cu1zCYiuQjFlqrPznoLjLbf1JMkNAiYahO11R3z7a1IitagQdlfTDjwlKHQ1524TouIH
 AiAWfiqYyW3ZvMc95oF2x6TPkCOZkly0B37+OdMEtnuzwPTNEKuUnhgs3QN3t7uMr9Hk/Sfmr
 aUenXQ8VKO85gBgOkY5q8V3fLwKJ3VQ9Naee5HZuCSpLH5gnwJ6gvsVjqG9Ydils8cu1zKRGg
 GvmvY2ekNE2XmTc6trwFrp1if/a0y1yO/NmyOxrLHs9INLQz8d7guI2zt1Y6y9kJKvE4P/ySs
 0sSEk7QBZillJwFr04rJwuniSvM8lAN2nlbD2yVxxpXTdqwR2Qz7RvYx8E6EiQgUrYj3YVp6n
 IgC1FPQbuEtOwffPhjVRFGyd9yun70AAO2suA2NDVObmLnLaH5s+8sZ4rHuLB/p7vK0JX3BOP
 sytaZy1s3tjNDcvMJT6HJCgG8h7qRKvhGWjX54uyF38d0iEciB5J7+eV7RtADXzBq3dD+LgEq
 S37/PnItL4d69wR6KsPCVBVtFaeVGfCbGDaQWxB5v5BeVBHFTm6ErlLN63gXU+5HHPfdWOhNX
 s9Ci/wT/c5khHnuZhuNfrGjoy+dInADDf+lcFQaIUL16auJSEhZQY+Iddzk//0gQBTsY0hOAM
 MNkNf0w+pRhEp/9asbdTHvMgZw57/xTXB95pu2oKmm96TKNXKPbKU04tUg+1z3nEDlriMAuwz
 0pScEIufGxWk5AWgkE7cyOyOkx6454hL9wCk8edpdi+pcKUgsKBBbC8aCzvVO0kqSTRwbiJI8
 XiEyEg3JO8zD3o/adKoZUbQxgdIVBKUEmFcpQ332XrO46AhIu5r9+jYVmM2mDpQIQwx8pds7X
 9jCZIhaL7lwjVamhavqyjPoX+suR2EopgyTQkX4dc5kJJ6a5orQ38FiJLmFZyKxahSpxJJyDq
 Z3jTqa3MjtlESl8brO6aBQSETBzoVEIa6bY
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 21 Jul 2019 13:45:48 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 21 Jul 2019 13:45:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Coccinelle for Go
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

PiBXZSBhcmUgbG9va2luZyBpbnRvCiB1c2luZyBDb2NjaW5lbGxlIGZvciByZWZhY3RvcmluZyBp
biBHbwoKVGhhbmtzIGZvciB5b3VyIGludGVyZXN0LgoKCj4gRG9lcyBDb2NjaW5lbGxlIGluY2x1
ZGUgc3VwcG9ydCBmb3IgR28/CgpOb3QgeWV0LgoKCj4gICogSXMgdGhlcmUgYW55IHBsYW4gdG8g
YWRkIHN1cHBvcnQgZm9yIHRoZSBzYW1lPwoKV291bGQgeW91IGxpa2UgdG8gY29udHJpYnV0ZSBz
aWduaWZpY2FudCBkZXZlbG9wbWVudCByZXNvdXJjZXMgZm9yCmNvcnJlc3BvbmRpbmcgc29mdHdh
cmUgZXh0ZW5zaW9ucz8KCgo+ICAqIFdoYXQgd291bGQgaXQgdGFrZSB0byBhZGQgdGhpcyBzdXBw
b3J0PwoKUmVtYXJrYWJsZSBkZXNpcmUgZm9yIGNvbGxhdGVyYWwgZXZvbHV0aW9uLgoKCj4gQW55
IGRvY3VtZW50YXRpb24gcmVnYXJkaW5nCiB0aGlzPwoKClllcywgb2YgY291cnNlLgoKRGlkIHlv
dSBub3RpY2UgaW5mb3JtYXRpb24gc291cmNlcyBsaWtlIHRoZSBmb2xsb3dpbmcgYWxyZWFkeT8K
CiogUGFwZXIg4oCcQ29tcHV0YXRpb24gdHJlZSBsb2dpYyB3aXRoIHZhcmlhYmxlcyBhbmQgd2l0
bmVzc2Vz4oCdCiAgaHR0cDovL2NvY2NpbmVsbGUubGlwNi5mci9wYXBlcnMvcG9wbDA5LnBkZgog
IGh0dHBzOi8vZG9pLm9yZy8xMC4xMTQ1LzE0ODA4ODEuMTQ4MDg5NwoKKiBNYW51YWwgZm9yIHRo
ZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZQogIGh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxl
L2NvY2NpbmVsbGUvYmxvYi9lZDFlYjhlMDZmODAwNzM5ZDM5OTIxNThkMzY5NDVjMGM0YzZmMGM3
L2RvY3MvbWFudWFsL2NvY2NpX3N5bnRheC50ZXgjTDUwCgoqIENsYXJpZmljYXRpb24gcmVxdWVz
dDogU3VwcG9ydCBmb3IgbW9yZSBwcm9ncmFtbWluZyBsYW5ndWFnZXM/CiAgaHR0cHM6Ly9zeXN0
ZW1lLmxpcDYuZnIvcGlwZXJtYWlsL2NvY2NpLzIwMTYtSnVseS8wMDM0NDUuaHRtbAogIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2NvY2NpLzc2YmYxMDE3LWQ2MjktZDQ0YS01NDkzLTBkY2NjYmJm
YTY1YkB1c2Vycy5zb3VyY2Vmb3JnZS5uZXQvCgoKSG93IGRvIHlvdSB0aGluayBhYm91dCB0byBp
bXByb3ZlIHJlbGF0ZWQgdGVjaG5vbG9naWVzPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApD
b2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0
aW5mby9jb2NjaQo=
