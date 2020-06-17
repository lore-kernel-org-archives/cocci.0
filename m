Return-Path: <SRS0=bgdO=76=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239AEC433DF
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 16:20:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD5520739
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 16:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="rzAm3ReT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD5520739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05HGK5gJ026650;
	Wed, 17 Jun 2020 18:20:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 38E7D7577;
	Wed, 17 Jun 2020 18:20:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CEBAF3D0F
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 18:14:22 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05HGEMe4023027
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 17 Jun 2020 18:14:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592410449;
 bh=L7NPJqF6WRIs5fDwphZDoi0ha33NtLh00PGn9Tln6uw=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=rzAm3ReTB7xW84XXFZjVlk6orUzEsOfEIafImpvArAgnv+Sd8yuNX1m99W4NurWvZ
 WeNZ/eAgqnh1EkaQoLPxQxoElJDT4YhbgmCI2/GOBboFUNjRzeqKKsKP1EXiGL99Wd
 4cMaogv7Tl/iBJTNLg9t0Vmsy5qEUWnYb60lBJR4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.115.66]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0qqv-1j0esW1xjB-00wlu8; Wed, 17
 Jun 2020 18:14:09 +0200
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Denis Efremov <efremov@linux.com>, Julia Lawall <julia.lawall@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Message-ID: <3d375680-cf02-5e2d-fcf0-69b3bdcbf748@web.de>
Date: Wed, 17 Jun 2020 18:14:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:ZWtQepdeNIFRFkkAOBrgKMXcCzYvDhWc/KNRvcjJjTFR5a39IEU
 y9bPS0wnH5WCew+ACOlBKaPqlGOyVJCVU2m6cNTtkitTAZyTz+J8y5liIR4PRzq1tjxh7hu
 AlBaebq3mPjCyp3OvYmiFdfxi3VL25YQU+PKfxGal+gCk8HEycJM41JJgtVxws+2s4ZAwwZ
 g6TviPTlWfXg3xy33/jGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lhx4k/MhV0U=:rmtZNedd+LkTRKx6Cicttr
 RkqwG9R8kuQdAuPbhrgjgIyo2vKgUCPEaJ7/2wu4h4/HU0OCxHagcSkSStN9MQlUcpaL/Ito4
 b/6qIZeyxTuu7gKQemszVgf4uveQWPS/f0EE4CljMkmveqH0i+B9fh38sILAo6dg0PtmMFybL
 zqXPT7QUrmE+dFi2YgyHWTrVgDzQ9AO7zVQ5jnDotUV28QRUc2SqBt8s5JtsACJPIFJkfgU6q
 jaxRycaw+Hj/rGAKSFDiSS/7sJ/9C7eVmJ9Xv3Mm84etVobqTJJpPrapdN1rZPxgY+Gp9eudW
 R+B8VQqzXF2YF0fYdfgFFadbUp1b8HB7I9AikBJ+MKpAoyaC7MBpZDh/KYL5b670bHZGxYsAw
 fgdlzYeNWurREwgwxwhWb9wQJXgXqBqg80j7d2LhbFcS28DZPVdpVCyXlRJvq28Za+NpFYKwX
 YYP6Lfxi9IjAl6NwAhXlIwKjri7HjALeRt8PNDX2hSzChj4Ri2jPpXFyWur1/qOGI31qYXmT8
 Uu8aYhMkLQovakmYmBfwgW+yqFDt/y6o1AaQd9k2mvTjpVWYIbsJZpb/mFRjf5TEiPA/3xMV8
 qw4qIi+LJb42u3y3a14H3RFdusQpid6QfUtQHIzksp9oG9zYUqJYGEaD3z/eLTCeDeO1x37yd
 IBOR2Rioj/VM6BJSubRNUSx6+41yOs1Kxyh7XC0+pbsqTIQWZ5KpKr+58lUhdX9rwT0Lbp94s
 0tgeZhkWVrkMOqSn+8/hrb3conl6jxBH+6L8xQi7gtWIM2/U8YAs+4O+gcpxngSU/el4pqdT3
 7RQ67iWvlinzV9t+YwgVFVKsXMI0oXHJhMLRkvYfCP33udURnG6659QsIF8BoJ2c9Rxc1zxBM
 Mqsvx73TNqwjwRBkqbA9p/tUxXIjZ8IZLsgu5cxmpGgOFvH5ICBe/Paps97uxBhy/YL4Zs9px
 SoNclFit7SktxXCV9iJHWueX2ohwSxp7gKLPbn2XRCwKw+2BoUarznXmNoG35R8GlqOOq5wyL
 gxI6XjAZyJIn7GoYPwi2+FlmnlmaRQ9Yg4Zu7nGwnxoQ42yWEzKRwNjd43bMdsVU6N9XIfpQv
 DJbyvaJBNnfny/o3kLuL84WkTA5BgXQB6+CymvIwrgyjRQutf2DFW4dKrgs5HP4sSQZlTfVHe
 CyIEqET9rA6FXdpxqyfSyPrgOaPXWBf6h5YIgJCvAQu1hMhacvXf+H1xf1JJXkC9CE6Ry8D1p
 7Jyo5fESOL7wOcbnt
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 18:20:05 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 18:14:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Wed, 17 Jun 2020 18:20:03 +0200
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add array_size_dup script to
 detect missed overflow checks
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

PiAoCj4gKiBzaXplID0gRTEgKiBFMjtAcAo+IHwKPiAqIHNpemUgPSBFMSAqIEUyICogRTM7QHAK
PiB8Cj4gKiBzaXplID0gRTEgKiBFMiArIEUzO0BwCj4gKQoKSSBzdWdnZXN0IHRvIHJlY29uc2lk
ZXIgYWxzbyB0aGUgb3JkZXIgb2YgZWxlbWVudHMgZm9yIHN1Y2ggYSBTbVBMIGRpc2p1bmN0aW9u
LgoKQ2FuIGEgY29tcHV0YXRpb24gbGlrZSDigJxFMiAqIEUz4oCdIGFsc28gYmUgbWF0Y2hlZCBi
eSB0aGUgZXhwcmVzc2lvbgptZXRhdmFyaWFibGUg4oCcRTLigJ0gYWxvbmU/CgpSZWdhcmRzLApN
YXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29j
Y2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlw
Ni5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
