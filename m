Return-Path: <SRS0=UZdp=UI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D414C28EBD
	for <cocci@archiver.kernel.org>; Sun,  9 Jun 2019 17:19:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B0120652
	for <cocci@archiver.kernel.org>; Sun,  9 Jun 2019 17:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="X8pQxi+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B0120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x59HJHVv015348;
	Sun, 9 Jun 2019 19:19:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5CEDF775D;
	Sun,  9 Jun 2019 19:19:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0987F774C
 for <cocci@systeme.lip6.fr>; Sun,  9 Jun 2019 19:19:15 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x59HJE6b017023
 for <cocci@systeme.lip6.fr>; Sun, 9 Jun 2019 19:19:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1560100754;
 bh=u7w9H5yaE3KaJzXqzv2rswxOpQEJxQZSldfi9GMRipk=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=X8pQxi+2KDAZPB4VGgoGXv6my7Aitz6osqpgpmfotbhbZpcBnw9Tu3F3+SsUNuHDf
 KUsiwoO+T9ze93N837puxHcWTSq/Y4o3bNoNErDaNV3WY7ihzLIVMka4M/ZWsqnPc3
 yMLSln7x7VtzXUaKNNf5HGeEdl+1emUr0sWrJvow=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([2.244.77.74]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUF8Y-1hACtk0ATq-00R3xM for
 <cocci@systeme.lip6.fr>; Sun, 09 Jun 2019 19:19:14 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4a6a6c17-5190-f2ad-d1ed-981e55fffe4f@web.de>
Date: Sun, 9 Jun 2019 19:19:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:KPBG0eLe3kx1ArRT3YGzZ49xgW5n/E34CVrF3CqQPG394XBj21d
 hWI1muEFzOm4sjRC1Y8MqJRbPiHPY+pw8uJSj6LXXMbGBkEmVo+K9nGM+0jwOCYR3b7dUil
 2Pk1p+Z7A1iFnqU33G2odHYnM/DF0Ldij94ZOQUI5jmxy6dHNhYXdTgFjevG2PsUBUQHbDK
 DGaRxjRTUhR8XDmYiegjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N7CqJqycMwY=:IQJN6pfdNjeTXJUnheIhtj
 BepppUYtdN1rwx4c9L7qcXWkkobUiLq28RU5/qikI0DS7KC90E4U6N/kC9kTjiJR2mjaSilMe
 8wfrPfnZYb3HOHhR7bN19CJfmpdnctrr+FpezalEdrhhygchNElimPpR2Nqjy3dJmWkBSwlLS
 FmD8jL5jKcIcixqyVg03fRJfYECCIpX3g5h2Gnc8Dd71y+k1g2K5jPeHR6X5dS31JyQnHhH56
 2tCRDhns4vkUsEFwgxgRHg5tn/LCFQoe4UjWj4fhSnILGZpX1xLwDC2S0i3CQT0LvctmVxp/j
 6aQ/lOlL07k830N9N62aRyCqtUdEfvnXQWpH4/6HhKk+VlXgJLfjtmWJ54M38TF36Zi67RR0F
 A80azoXsQ5gw6f4LEoFlUai4f3SEh70plsD+tH8H/bc2OCo4vVQv/8NCpWHhj6Oek1cJZgj9F
 pYESyhbgdWgD3LBsTd8QPplVzzXk19NPQ+7+OzZjXLI1xTgdc8bsW6JHpkrLAb0fnIe40V2f1
 0wfwMNYD9SggZR8jGHyiJlwCPHSYB1acie4E0wKRLH/joApPrWY2XnZY2reWS0SYwcdjTOmv8
 qXvFVQCnzOHlKPukShSQI4As0/xjozQqqutN3sZCcfWh7j0OA1fMQJLGxMQUe3FHmMzZw0eYv
 YF6kzdisMzEgX1okk4vwqov0D7Y0dC3L8QjnplfvIzcLdT2b4RU3Q9/5MdCAWXxMqu02UpMNv
 5fHjqSqEmM2XBbmJPWJtsn4a7K4sO9EITJDThq9HGQe6dMK1RuX9K1DY/fiKlYqubu9/y4PI3
 Fnn0nVayFIwzAH37s1WvjJnsDwHXLc3UFhmDbBms0FI+c2l2HLXfq0Uu8bCBGQBxcQomPJhve
 K8hOqFF57Ywc6N7FwdViN6Agrw2eRXqsjbowuFm8lxVzph6WQ1JwFWJAtnbmXIfd3Htvwhdxe
 RPbjV1iM4yxM+Jt7AiF18MvDGmBV1c55w4PhqNXhqIarMdHHEN2+1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Jun 2019 19:19:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 09 Jun 2019 19:19:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Working with pipes for parallel SmPL data processing?
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

SGVsbG8sCgpUaGUgQ29jY2luZWxsZSBzb2Z0d2FyZSBzdXBwb3J0cyBhbHNvIGEgdmFyaWFudCBv
ZiBwYXJhbGxlbCBkYXRhIHByb2Nlc3NpbmcKYWZ0ZXIgdGhlIHBhcmFtZXRlciDigJwtLWpvYnPi
gJ0gd2FzIHBhc3NlZC4KaHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxsZS9i
bG9iLzdlYzMxZWQxZmFkZjczOGJjNDg3Y2NlZmRjNjNiZmUwNTk4ZjQ0Y2MvZG9jcy9tYW51YWwv
c3BhdGNoX29wdGlvbnMudGV4I0w3NDUKCkl0IGlzIG5pY2Ugd2hlbiBpdCB3b3JrcyB0byBkaXN0
cmlidXRlIGFuYWx5c2lzIG9uIHNvdXJjZSBmaWxlcyB0byBzb21lIHByb2Nlc3NvcnMuClVuZm9y
dHVuYXRlbHksIHVuZGVzaXJhYmxlIHNvZnR3YXJlIGJlaGF2aW91ciBjYW4gYmUgb2JzZXJ2ZWQg
aWYgYSBkYXRhYmFzZQpsaWtlIOKAnFBvc3RncmVTUUwgMTEuMy03LjHigJ0gd291bGQgYmUgdXNl
ZCBpbiBzdWNoIGEgc3lzdGVtIGNvbmZpZ3VyYXRpb24uClRodXMgSSBpbWFnaW5lIHRoYXQgaXQg
Y2FuIGJlIG9jY2FzaW9uYWxseSBhcHByb3ByaWF0ZSB0byBwZXJmb3JtIGRlc2lyZWQKcGFyYWxs
ZWwgZGF0YSBwcm9jZXNzaW5nIGJ5IHRoZSB1c2FnZSBvZiBhIGRldGFpbGVkIHBpcGVsaW5lIGlu
c3RlYWQuCmh0dHBzOi8vb2NhbWwuZ2l0aHViLmlvL29jYW1sdW5peC9waXBlcy5odG1sCgpIb3cg
ZG8geW91IHRoaW5rIGFib3V0IGFub3RoZXIgYXBwbGljYXRpb24gZm9yIHRoaXMga2luZCBvZgpp
bnRlci1wcm9jZXNzIGNvbW11bmljYXRpb24/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNv
Y2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3Rp
bmZvL2NvY2NpCg==
