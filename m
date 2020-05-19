Return-Path: <SRS0=x7/Q=7B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C6AC433DF
	for <cocci@archiver.kernel.org>; Tue, 19 May 2020 11:15:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B87620708
	for <cocci@archiver.kernel.org>; Tue, 19 May 2020 11:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="qNe3f4nM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B87620708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04JBFKQ7027882;
	Tue, 19 May 2020 13:15:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 586C47559;
	Tue, 19 May 2020 13:15:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5F82B3DC8
 for <cocci@systeme.lip6.fr>; Tue, 19 May 2020 13:15:18 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04JBFHuj004367
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 19 May 2020 13:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589886915;
 bh=VvvJIqeXJc4Q9VoT61EToyKlznQkGBpvzgSHZnQiQnk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=qNe3f4nMcuf4wVdopAhifaA2MlPBhEu5Bg2Qcb63/uE9wIQaHDGKGPUQapx41XiYn
 O5Qyd3NHKdjT82pdKmo6ZN5SDvYhxAxz+kfxAyI8izWBcnXPlFL3QE0j16LSs5O38s
 0iGb8BgToErRdyLJHOo/Zr4BMBgMFMv7oHGM0JHQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.146.173]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MElZB-1jpVtI3Q3n-00GIm8; Tue, 19
 May 2020 13:15:15 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <4a677190-b494-138c-4782-eec033a77377@web.de>
 <alpine.DEB.2.21.2005181118540.2467@hadrien>
 <0a93e321-42de-3534-9c4a-d67132a1289e@web.de>
 <alpine.DEB.2.21.2005181217580.2467@hadrien>
 <8f3cbbd1-653e-ab2d-5a41-18eec00ae828@web.de>
 <alpine.DEB.2.21.2005181234210.2467@hadrien>
 <e3d5a92f-0c78-c1ca-47ab-d2bb2864efaa@web.de>
 <alpine.DEB.2.21.2005181248310.2467@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5c451649-4077-e54c-e01d-6bdbc0d02046@web.de>
Date: Tue, 19 May 2020 13:15:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005181248310.2467@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:u12REkLjTEvpRiMw0xxxMS/vhnzA3i3LYsJ+jMDGm399sGQOWFu
 J3jkHoBkMyd3qXtNsPnfmtOjEtksUKlqtHi3GneKSNMpaH6ifhl996JCGfZRBjg0ps3NpxL
 1696+TT12xdUpBK9ajWkj6CH5q534ROBFwpgsh8ezUPGOuf1vRL+O1vW/pBJRunIailJfJT
 LLAWmOHHB6zMC+2o2/TGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0hj5rLFFv+g=:d5kISaI84qFqQ1jHsRAHss
 i28TIaD+tZdc485Jk1K6xataimvLey5yw64KIA1/n5B3VAKJ4mijbdE08lyiK8MPhSUZiZHtT
 5a8oEQQ8z47+NribQd6fFsnvMugSwo4GcYg19l6in8Ips57goNGQH9403w/TPPo90wVw3DiZM
 J8h8KNojD3ckzgMU/cgAk/uHthT9x+s8ltlb3uSSvhkSIn4Uv7BLWiZ1+G9BygaObkE3OywqP
 30S0E2ULvOIanWJq4e9HCAlEfNhimmzQ55JV2Mp1NQJu8J47xAc5q6phBAoIaSiAFtkTGcEjt
 GQX9Wkd3VqNZaVvIvgb9YOPHSZTCkFNoDhwqkZxWYrOaDehK40UkKSJ+0mOhFI1PIsKmG72mp
 tVb4OnUZr8qKKAgkjMzzVAJrmfCCP6r6xITky/3SJWT1N+XAgjs8iFqqIEGIj82RKsjt7odiw
 HxA41kmZnrFkC6t05/fw7UiN0hQtub9yEFky1VBhXjnnWnuCu7D/lOaa92czagqpY4xHg2AOO
 of2eox+rL2QbLhuFJK/U4nihiPk1tfhAxmsMNVhptJRCi5mwoKWfWXoV29ij6tTuCIu0pDakk
 G/FBh0+i8PglAmbqqd+yVA86Sy5ALlNw+AvAyDOGhg714El9Fm3yJpjDJAZEbNeXpbxum7aWM
 NpmR75+o9JbW2EM4vYRROJ9SDLCmvRT3inV3TVNuYVhzt70I5tBuqjmTkd0Y1fwRhudgh7/wL
 9uWBCT08tU4pRLHBwHe+REt1p6bpu7NhgbS02bqfxIq5taOuAy5rsIeBBzFBEGO9+bCa6eRjs
 BJhvCm8dKx6SactNTG6Y1Yef0ALiAM7P7q0tdlIGVw4NlR3gby6b6Dw1SbcNju5Q3w7exUx7a
 qFNbSPzJcHVYOu1YC6fGQd+NLEyL6HCeyPyo0JNgUghpBMBcxvO4lHk68WG6s+FgCs09XzlL2
 p7w2enudoaHJLhRjIiVW4frFtbxOA/ZCYup3F9uI28+6zmp4WQ53uuYVkSQfHBv/y/1m1ZqVC
 OijALvFSMptdq/tNJROT34ka9TeyCXWuNmaC2FzXtX//ENJlb4zHZ7LANNpj+d6BAx8kFYTmm
 ZbNsPfXDrj57H6h6A/VBkoibVl3TT1zUOiLiINBRPz06HtKQBPfdw9cX6CGprLTOss76bVvPR
 6Yssn7xJa7/sRD56j1NvpgPpWTxpyLl0AY7RBjZcp23BWSgtQf9/bhRBotvhnPll1rdGiMgDA
 K6473yHL0vUPXQp+B
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 19 May 2020 13:15:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 19 May 2020 13:15:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Chuhong Yuan <hslester96@gmail.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to match function calls in macros?
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

Pj4gQ2FuIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZSBoZWxwIHRvIGluc2lzdCBmb3IgYSBz
ZWFyY2ggdGhhdCBhIGJpdAo+PiBvZiBzb3VyY2UgY29kZSBiZWxvbmdzIHRvIHRoZSBpbXBsZW1l
bnRhdGlvbiBvZiBhIGZ1bmN0aW9uLWxpa2UgbWFjcm8/Cj4KPiBUaGF0J3Mgd2hhdCB0aGUgc2Vh
cmNoIHRoYXQgd2FzIHdyaXR0ZW4gZG9lcy4gIFRoZSBwYXR0ZXJuIHRoYXQgY29tZXMKPiBhZnRl
ciAjZGVmaW5lIGhhcyB0byBiZSBpbiB0aGUgZGVmaW5pdGlvbiBvZiB0aGUgbWFjcm8uCgpJIHN1
Z2dlc3QgdG8gY29uc2lkZXIgYWRkaXRpb25hbCBzb3VyY2UgY29kZSB2YXJpYW50cy4KV2l0aCB3
aGljaCBTbVBMIGNvbnN0cnVjdHMgc2hvdWxkIGJlIGVuc3VyZWQgdGhhdCBhIHNlYXJjaCBwYXR0
ZXJuCmxpa2Ug4oCcPCsuLi4gZiguLi4pIC4uLis+4oCdIHJlZmVycyBvbmx5IHRvIGNvbnRlbnQg
ZnJvbSB0aGUgc2FtZSBsb2dpY2FsIHNvdXJjZSBsaW5lPwpodHRwczovL2VuLmNwcHJlZmVyZW5j
ZS5jb20vdy9jL2xhbmd1YWdlL3RyYW5zbGF0aW9uX3BoYXNlcyNQaGFzZV8yCgpSZWdhcmRzLApN
YXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29j
Y2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlw
Ni5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
