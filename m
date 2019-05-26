Return-Path: <SRS0=ycDg=T2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAE4C282E3
	for <cocci@archiver.kernel.org>; Sun, 26 May 2019 16:18:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DC420657
	for <cocci@archiver.kernel.org>; Sun, 26 May 2019 16:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dzPghaFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DC420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4QGIYwN013565;
	Sun, 26 May 2019 18:18:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 184E17747;
	Sun, 26 May 2019 18:18:34 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 02533773A
 for <cocci@systeme.lip6.fr>; Sun, 26 May 2019 18:18:32 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4QGIVVT002707;
 Sun, 26 May 2019 18:18:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558887511;
 bh=nEbTNFbfMoAYLv8s3B1uMLj6CyKjdjUXk51xFBbc+zE=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=dzPghaFKERLyF/zcZ9deVaKNXQtePuqLQ6gqt/Nv9xqebxPILnvDDcqi03U0UzQsa
 nKyBvx4vYFZbFjbfuM0qxyyCyP5z/vOxpf0trZITVCQS3Hjw9mlNoUFbjx4B0VzixN
 LLRTNmzbDIFpyZNM4bBSAj89HxbsQh1mqcs8Bmo4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([78.49.116.98]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUnUe-1h7q030czU-00YEB2; Sun, 26
 May 2019 18:18:31 +0200
To: Julia Lawall <Julia.Lawall@lip6.fr>
References: <alpine.DEB.2.21.1905222114490.2618@hadrien>
 <81b409c6-5986-5961-5edf-843c6737d88c@web.de>
 <alpine.DEB.2.20.1905231500230.3573@hadrien>
 <b5c322d3-3162-953f-a985-53abc5064482@web.de>
 <0782D580-3DD6-4419-B5E1-C04215FB2E3B@lip6.fr>
 <d96051ba-3a49-52aa-cc43-b7e4251fde8e@web.de>
 <eaae9aa05a338fd694057897d830181d@lip6.fr>
 <4526cd3b-a6ef-c9fe-175a-5c3e05c52555@web.de>
 <eed4a908bc3de6baffcca94ffb42b270@lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ca17a1ad-5e2b-0c92-b4a3-266face8c567@web.de>
Date: Sun, 26 May 2019 18:18:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <eed4a908bc3de6baffcca94ffb42b270@lip6.fr>
Content-Language: en-US
X-Provags-ID: V03:K1:k0WsAsxiXvKzJeBYEdy855rE4YW8YjSl181HHa2v6GP+Ad2KfjQ
 1UytBylnGCDdE5IR3e6T5bbkdGQQDoq4i5uQ6Wv8WiW/W0Njpffyy/vg4PpZSXlyxZkX+Hr
 mkbyc6MmIUqL4WxAL/9dE3R08rkCUpZkwIuzx43MOUpi0uUJ8bSNbja2/rrrwiQqpfjRzmf
 bL5PtRFzeqJqdk3r+q37g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nGfGJbJrrMI=:C+e33I9uo/wcSWhlDxaJHE
 JqOzYId6AVQnevd3q2sXWdqSrAGX37YGzyuSxdAqUW2bcnCfwLKdn2gfIEGWG4g/0rkEWOYAZ
 pHk4rar3mjEv0l4s3uu+TP+9KpxZejHhcuLI7i9kd5psHODutQ8fm9QIDwoyyvIp6la+l/iX8
 qa2NkUKpKW80hcEfNqUa0KD0hmPV57dk3GBLag0h+2sXW28vlb/9s/tqqTf8fsod7RKYcQtmq
 NUtSI4oQFJRsfw0WUWO61Q5J/C77T55W0niSTrXJcfWKpLarXUrih6l+2HpcAfLquEjbmzgxF
 45IdfflBpYSuoED4OgCEZe96mB7fIv3IjlGIh6A2WMESHAaGuSGoLsT1UyM3J64nzxjrqPq3T
 dN3NKG79XOf/4OH/PUSvKcSTD0utuvP7YeQzxIOqgQ3vvJnqGfymQhirluK/JcuImg3LrP58e
 LUix66lgi7iyNkIrXldA5FNwYo4aVlx3gwbU0x/BfX22pP1xJXYh4KYYgk1HXpncigyA7uzZ0
 09ivZaqPWV6NkT5hIvV90FN5W0lHG7djNXQXWlmF+fYxyIQnpyCCTPCOyNtIflmal7NQoxPZM
 OD5JDVs6fpayeYDJvMkLiL88hdfX/qwrlPCc8dFXrue0S/nwIYcH/oFubHkHQRsdEhgaJDT8l
 k24joZEIIG/aqRbtjEl6PN50BZhsO0Nwpk5sx/lWotkdrh2vXJYOglpWKXs3lV41ULBsPcs1O
 5/MyX2//mz/UcP7XEs3QLOGr8tKRCnNUgfBGl+ZhO0iRT9ejfXn9iEDDlRwAWaHVoP6dClkZS
 +6HqemopNAxyR8yXAEXWFi8REBe6iZ2vK+6VxQPJ+GqP6f7PvEktymgED3M1lRLrNZJeDLAi9
 nOsIP9W0z6Z7Hylbud37nS2PpO7YBggAOvLtNlnl4pjfWCDTRXrlRv58Vhi9/HydyZIm8PCiv
 dIHXOt7EPDwnQQGHphUScQ4P31oMWZQ74wvQj5mRx35YMizQGzu1l
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 May 2019 18:18:35 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 26 May 2019 18:18:31 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] accessing comments
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

PiBUaGUgd2hlbiBhbnkncyBhbGxvdyBhbnkgcG9zc2libGUgbWF0Y2guwqAgVGhlcmUgYXJlIHRo
cmVlIGNhbGxzIHRvIGZvbyBzbyB0aHJlZSBwb3NzaWJsZSBtYXRjaGVzLgoKQ2FuIG15IHNvZnR3
YXJlIGludGVycHJldGF0aW9uIG9mIHVuZXhwZWN0ZWQgY29kZSByZXBldGl0aW9uIGJlIGFkanVz
dGVkCmFsc28gYnkgbW92aW5nIHRoZSBjb2RlIOKAnFwoZm9vQGMzKCk7XCZTQGM0XCnigJ0gaW50
byBhbm90aGVyIFNtUEwgcnVsZT8KQ2FuIGl0IG1ha2Ugc2Vuc2UgdG8gc3BsaXQgdGhlIE9DYW1s
IHNjcmlwdCBydWxlIHRoZW4gdG9vPwoKCkRpZCBJIGV4cGVjdCBhIGJpdCB0b28gbXVjaCBoZXJl
IHRvIGZpbHRlciB0aGUgc291cmNlIGNvZGUgZm9yIGV4aXN0aW5nIGNvbW1lbnRzCihpbnN0ZWFk
IG9mIGFjY2VwdGluZyBhbHNvIHRoZSB1c3VhbCBwb3NzaWJpbGl0eSBmb3Igb21pdHRlZCBjb21t
ZW50cyk/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpo
dHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
