Return-Path: <SRS0=lRSE=SP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A2DC10F11
	for <cocci@archiver.kernel.org>; Sat, 13 Apr 2019 17:29:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963E32084D
	for <cocci@archiver.kernel.org>; Sat, 13 Apr 2019 17:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="h8FJURbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963E32084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3DHTLqV017865
          ; Sat, 13 Apr 2019 19:29:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 680EE7727;
	Sat, 13 Apr 2019 19:29:21 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7A4667725
 for <cocci@systeme.lip6.fr>; Sat, 13 Apr 2019 19:29:20 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3DHTJdo024827
 ; Sat, 13 Apr 2019 19:29:19 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1555176559;
 bh=QxQUrMz8x5RmJQqJb8FxMn9HJD8mbhvkj03PNk5nyck=;
 h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
 b=h8FJURbPiCyURgy6HzA1sudg0f3y3JJHJy0xpX4LLisbjx2ttzfDJY8NHSlebfu+H
 jPeGDktIhcgyz9kLX6yu7RuwMbUuKG0Aoo+fPlQatF2mQ32QV97Wi/ZIjGhZrseDc5
 MsEz6EHq3JLw81SB8l0x/RvNu7WYq2Pptrv7KNr4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.84.186]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LaCmk-1gaH8j0nao-00m5Nz; Sat, 13
 Apr 2019 19:29:19 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <ce2b0c4c-bc85-0341-ca0a-9b158804943a@web.de>
 <alpine.DEB.2.20.1904111728380.3143@hadrien>
 <88620f8c-3762-ac4e-5e0f-6115a21635fc@web.de>
 <alpine.DEB.2.21.1904131737540.2536@hadrien>
 <ada8fea1-1b56-1c58-5a78-8fc95006d203@web.de>
 <alpine.DEB.2.21.1904131743330.2536@hadrien>
 <566b0019-021a-0415-4b98-b5d8c74beb83@web.de>
 <alpine.DEB.2.21.1904131802270.2536@hadrien>
 <bedc9f4a-4d02-6898-0226-6f9e67d5d870@web.de>
 <alpine.DEB.2.21.1904131816130.2536@hadrien>
 <b2fc8f6b-b89a-ee77-fdd7-0e219d5bea27@web.de>
 <alpine.DEB.2.21.1904131834510.2536@hadrien>
 <934077c2-a431-afb9-e7f5-0909d45abe2e@web.de>
 <alpine.DEB.2.21.1904131905320.2536@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <be4076d1-419c-2d47-3a79-69921ffac46b@web.de>
Date: Sat, 13 Apr 2019 19:29:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904131905320.2536@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:QsgH7H0Im7alxgApJ/BZBy9BhpsxmMEkem7XqM0uZ1BaxGWSb7d
 DX6ki6CT1LPcp7r/CFujV14oBMioYRLByxBWBQdvtiup/FbHpkeeNulrR7qcUtUZ4XKRBuG
 Yf7kLox6+IiK5mDs88ketYVpxd52OJRc4h0dNsyTfST5Tf8QRmZ97A8oII41xO+5l1dDIBP
 EL9jFbSJCRrh52U6XmUNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PHOrbYXYwqI=:76QlIfmSySrPxSigJiRS0V
 +5O57vwQT3oDbzL+ilikidpT2p1vvAcUzqq+RhB3aKKdPuMkGuWGKLSebYzz9Z2fDrAc3ilja
 Yt30RziI6hvK8woWMpYb6C7IGeHFzbXkAgr0XEeaVCHMl1WtTirYeEoylQnwcdNo6EohiId5p
 iscjREj4mRsBI06fL3VULSJIUHndM9pNo0Z7v0vD6bTV2XR2Z6MOWFDmUlx2i6pBRaG2AO+sx
 2XaDmKT4NuUOGqRFoCG1w7mHtsbzU+Puax59Wu+u30j+MYqb1/iAABGh6BxkdzvbcRX5Ynmcy
 8bafcXPzZiZ1K+4wVD+6P9s3Nfd59pNF6EYu1yxznmjtfnfZ1axQ8tn/hXhUjUfkIwDAtq48e
 zyLN0JiBM8Tasqqamy4L/O6xn8Mic9/465YdIRhU/RWdK2IqunFu3WP1OeNwgkMYJn9ANemw1
 BQPm/h0jFYO4D1GG4/eLcuAz6mwGK3NuTQ1js8MirDFdMO+lHkjgRCYeh/7t5SmG97SCVvryx
 Z5tAOtmurEsgShH5VuTlEy0DqafZgNYfjLy9NBluLQzF/COElxM0evFVusFdpmerFwBH2Z1d+
 5UHKrhWS8xNKbfyM5kvPTwCYn2HIKPSxb1hle4rVa1bBiHImhH/I2R84xMfB+VpeA0Q00WPpo
 HAWj7RkliNNjRv+RpUQ64bPBbl50yskvMewmQn14fSOXvbwVPwNh19xMdV0HNofGyyCIkiwd4
 RmzwWJgAQHZn1UB5C3YPL6cXysnzwnY1w5dTfFSJ3doG/OOAbcmiRhUbtii4PBoYtQLHSY6SW
 mrWBByRv+A5ckuJCeto6M2GYUJdo6lra7wuOhSQUkyZfUmx0Xg67e7XDYoUKQEjXCAUjTQ375
 4WdpZODcZHmxeA2KcoJIcRnfAvcUpPADRehC+ODa8S5WToI61GzG95uQBWdOpat0QCUXH9zjW
 78yhejK5lqQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 13 Apr 2019 19:29:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 13 Apr 2019 19:29:19 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Clarification for SmPL ellipsis functionality
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

Pj4gSSBhbSBzdGlsbCBjdXJpb3VzIGlmIGl0IGNhbiBiZSBhY2hpZXZlZCB0aGF0IHR3byBzdGF0
ZW1lbnRzCj4+ICh3aXRoIGEgU21QTCBlbGxpcHNpcyBiZXR3ZWVuIHRoZW0pIHdpbGwgYmUgZm91
bmQgb25seSBhdCBkaWZmZXJlbnQgcG9zaXRpb25zLgo+Pgo+PiBIb3cgc2hvdWxkIGJlIGV4Y2x1
ZGVkIHRoYXQgdHdvIGdlbmVyaWMgc2VhcmNoIHNwZWNpZmljYXRpb25zCj4+IHdpbGwgYmUgbWVy
Z2VkPwo+Cj4gVXNlIHBvc2l0aW9uIHZhcmlhYmxlcyBhbmQgdXNlIGEgc2Vjb25kIHJ1bGUgdGhh
dCBmb3JjZXMgdGhlIHBvc2l0aW9ucyB0bwo+IGJlIGRpZmZlcmVudC4KClRoYW5rcyBmb3IgdGhp
cyBzdWdnZXN0aW9uLgoKCj4gSSBhbHJlYWR5IGV4cGxhaW5lZCB0aGlzLgoKSXQgbWlnaHQgdGFr
ZSBhbm90aGVyIHdoaWxlIHRvIHRha2Ugc3VjaCBhbiDigJxleHBsYW5hdGlvbuKAnQpiZXR0ZXIg
aW50byBhY2NvdW50LgoKRG9lcyB0aGlzIGZlZWRiYWNrIGluZGljYXRlIGFueSBiYWNrZ3JvdW5k
IGluZm9ybWF0aW9uCndoZXJlIGFub3RoZXIgYWRkaXRpb24gd291bGQgYmUgaGVscGZ1bCBhbHNv
IGluIHRoZSBtYW51YWwKZm9yIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZT8KCgo+IFlvdSBz
dXJlbHkgZG9uJ3QgbGlrZSBpdCwKCllvdXIgaW1wcmVzc2lvbiBjYW4gYmUgYXBwcm9wcmlhdGUg
aGVyZS4KCgo+IGJ1dCBub3RoaW5nIGlzIGdvaW5nIHRvIGNoYW5nZSBpbiB0aGlzIGRpcmVjdGlv
biwKClVuZGVyIHdoaWNoIGNpcmN1bXN0YW5jZXMgd2lsbCBjb3JyZXNwb25kaW5nIGFkanVzdG1l
bnRzIGdldAptb3JlIGNoYW5jZXM/CgoKPiBzbyB0aGUgZGlzY3Vzc2lvbiAoYXQgbGVhc3Qgb24g
bXkgc2lkZSkgZW5kcyBoZXJlLgoKV2lsbCB0aGUgc29mdHdhcmUgZG9jdW1lbnRhdGlvbiBiZSBj
b21wbGV0ZWQgYW55aG93PwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1l
LmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
