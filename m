Return-Path: <SRS0=74vx=XG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3134EECDE20
	for <cocci@archiver.kernel.org>; Wed, 11 Sep 2019 09:10:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617DD2168B
	for <cocci@archiver.kernel.org>; Wed, 11 Sep 2019 09:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XBlHNkun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617DD2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8B99xWn026708;
	Wed, 11 Sep 2019 11:10:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D40637797;
	Wed, 11 Sep 2019 11:09:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B0CA976D9
 for <cocci@systeme.lip6.fr>; Wed, 11 Sep 2019 11:09:58 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8B99wpi021957;
 Wed, 11 Sep 2019 11:09:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1568192995;
 bh=yS3EOS6JtbGC6bPeG+O2WAcZENGQp2Uulj2X4DfMzz4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=XBlHNkunC2nxEUnq+RvJYC5fPUKhiWs03Pni6jSvT4Qh6NJVtRW9LGMoYxnze4IIN
 VSMUUPEn0lxfKCmEX4wf0+MCrQmnVJfhd//OnHBbr3NcU6WXfRG7bmn9GlTxrEk3i/
 EODqtSMAOumfG0vp/gwAwapp8Vco0bcmjr//YhPE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.183.158]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4qav-1iKG8E2nTZ-00yvAI; Wed, 11
 Sep 2019 11:09:55 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <0477cddd-0bbd-7e16-adee-91e7e9d3b5d4@web.de>
 <alpine.DEB.2.21.1909111018350.2885@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <50a3dfa9-69ee-0290-574d-3069d08ebc64@web.de>
Date: Wed, 11 Sep 2019 11:09:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909111018350.2885@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:/pIoYGTlyPfQVQbIUwR9yZwXD43SpT3vkR+0fhnJNbsrzsXpZID
 kevSJ1/jYNyiQ8Dn+JBN59bW8sSO6wQ4ji0lMDKNlj2gMYBTbiUU52RU1LWiQyESnoXm/70
 UAo2QIxSfyK5nnTqkqdb/7Jx9NE/fDw14hrvgGNqy0sRypOCtQlJSmKUG461JKwZLW8EiVa
 EPs88md4dTr1yO9re422g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AmaTfuVAs1Y=:hhX6mz5ICA8YXf7OTOZlIL
 d/Y07qLwv84ataQlduXs8ybFDG62uAX7B+g3JIb4EEZEl+HFxtLKJq+f+Vz6huQt0gfy/iIqF
 NiOf9mhxrDdLMKK7svZAG7JBekI7whnQi/ICoojoGCDpqzXgiSqxyMKI3UCbIMJa7AyIbsZj8
 LyMeKHFCI/+kC2Ra1hTHeWP0pjL3B53HXh4WmcWhiXL1vFlk7vNsJOhYA58KeE2A/hhpKl+u3
 Y0YODilvPRKkHKpCwIrSxWRg/0T24G35PaHSngFP3W4X/0GyH+Pm2TJxbx0A8/gKVnwHgdr93
 Nml4pHLKcqLB963Xa1RzYcZo/yBZtlMICVl0nVoXgaZ6aMHKmjSfQTpe3nAZdWRY2diUvt6V4
 /TLKaRvekPXIrGC8dQDq6AKn66A8TeGlHtlDhEm+LSbwiWWVEqDh3PNlwuT9zEH4l2cphbXIr
 ZNPewX1TPDk8BJe1rcTTz7NRu/gzkcgShi4cMpVJ4HSMn8e5/GLlphhZ5eIhY62A9qs0633eb
 d2tihnlTJF7F7MDTRp0MvqZFJVSGD8UjZ3qw6xe8f1xUv8SzMPiMry9nVn4Xdj+qrC1srm4v1
 LaddlugJitpo8Sy/pOq2t3VPnFUsSgvdI0xvziAoQQqyyujE4JpKUqvocujcxJ7cTvzfZ0Ppf
 X9/nF+JDWOqX6454hEESy9JZ0lW05AMKKFOsv6ivFV0WYhOfUR1WBTUH93McJaj/5HsVxF0e+
 BVockeqGzLeMdERp38GFjUmQ3UkAll/wcjJaTTNNLOr3C2LBDIfr18Yqe4jKG89sAftTDtbv2
 5kz8+mMamrNrNut45VNNt4dCI8GVgsJGGEKcOKAwx8iroCCgzMHygzn/khGTw30XYNKfKCi6O
 VQOUK5bM72O8BJBL917VEytj8aiv3Q1Gl6fO16Ai2jxcpHzVOAsd+7e0JW6YYO0sD6/wWkkcK
 qUnEJPZAToNVNN8w3kyXY3JW7yCgC1YBbtg66mIl5Um43TdykYUeev3T9IL3MXrj5EGDl649E
 J4kAutGZm0G3NMTvV06Ar/NaOYa1rYxk1z8XYd0iwdLB9vTUCcrJuY9mz7GSiBBXJwaUHy+Wj
 3hwPfBAbOJEX6ViZTKzC4X2k73j2Pg2CrESjMwQXyR2bOUcmjAGgAMKgDbj1a+9d0q5EQnNB6
 xIWRrPSWyRvphML9Zh6PpbkJDckPA+PziH6Pc/udetnW1laOuL8MAGhtxqCnwu8wvS62nuHaO
 SvFnJWibw5epr71yn
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 11 Sep 2019 11:10:00 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 11 Sep 2019 11:09:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking parsing difficulties around SmPL when
 constraints
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

Pj4gQSBzcGVjaWZpYyB0ZXN0IGNhc2UgaXMgYXZhaWxhYmxlIGZvciB0aGUgc2VtYW50aWMgcGF0
Y2ggbGFuZ3VhZ2UuCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUv
YmxvYi81NjBjM2QwMmUyMDg1ZTgzZTliY2Q0MDg0MmVlYzdlNzc0MTQwMTMxL3Rlc3RzL25lc3Qz
LmNvY2NpCj4+Cj4+IENhbiB0aGUgZm9sbG93aW5nIGNvZGUgdmFyaWFudCB3b3JrIGFsc28gdW5k
ZXIgb3RoZXIgY2lyY3Vtc3RhbmNlcz8KPgo+IE5vLCBJIGRvbid0IHRoaW5rIHNvLiAgSSBkb24n
dCB0aGluayB0aGF0IHdoZW4gaXMgc3VwcG9ydGVkIG9uIGV4cHJlc3Npb25zLgoKSSBmaW5kIHRo
aXMgZmVlZGJhY2sgc3VycHJpc2luZy4KCkkgaGF2ZSBjaGVja2VkIHRoYXQgYSBTbVBMIHNwZWNp
ZmljYXRpb24gbGlrZSDigJw8Ky4uLiB3aGVuICE9IGkg4oCmIC4uLis+4oCdCmNhbiB3b3JrIHdp
dGggdGhlIG90aGVyIHRlc3QgY2FzZS4KTWF5IEkgZXhwZWN0IHRoYXQgdGhlIGhhbmRsaW5nIG9m
IGFzc2lnbm1lbnQgZXhjbHVzaW9ucyBzaG91bGQgYWxzbyB3b3JrCihpbiB0aGUgZnV0dXJlKSBo
ZXJlPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0
cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
