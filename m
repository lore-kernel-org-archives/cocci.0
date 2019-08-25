Return-Path: <SRS0=RP4p=WV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D02AC3A5A1
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 13:45:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824722080C
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 13:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="l1uKbw6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824722080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7PDjdai001688;
	Sun, 25 Aug 2019 15:45:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AD1FF76C5;
	Sun, 25 Aug 2019 15:45:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 28FE67694
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 15:45:38 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7PDja12022990;
 Sun, 25 Aug 2019 15:45:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1566740736;
 bh=KhgGz+McswdrVoJuahgC2O80NBuI94Ftq8iO368pyhE=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=l1uKbw6CTryOD++kpHiXtEdb0Rb7XmlwqYmLEZKd+ob1c+FUKEA9FnHpG9VOsaZmt
 QcRTvaEJVEyX6oiikLVkYkI4UDquD3UwHxXp1NlknxCPzGyb+sVHb7P6bG/xakQSci
 Nggs3VNzYCe+rTjMmNbd19ujamJNyMo2eD2dVh0Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.160.204]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlWRb-1ibm5P06pL-00bJoI; Sun, 25
 Aug 2019 15:45:36 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <a7f12c28-0f96-d388-f1f4-57db4d3d880d@web.de>
 <2AE15A09-F219-43DC-81A9-73C13CFC0753@lip6.fr>
 <661aa3dc-3514-3d75-eb3a-9e46843fd02d@web.de>
 <alpine.DEB.2.21.1908251547420.2283@hadrien>
 <c6f15b8d-561e-fda4-1531-191334f1142c@web.de>
 <alpine.DEB.2.21.1908251741460.2366@hadrien>
 <3d06c34b-ad1b-2d5b-f36a-0de6429ad361@web.de>
 <ba5ad931-38a1-ffab-6730-2bf5b9981203@web.de>
 <alpine.DEB.2.21.1908252118210.2801@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3f66998b-6203-aaf3-6476-ac324a6df809@web.de>
Date: Sun, 25 Aug 2019 15:45:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908252118210.2801@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:JcQdYI2G6Nc/FDLQGgs2Eld7vOxVYtO1684DXA5dzPp2OO6ufUP
 iuo3DqPf2c4caLfW/Rb2yhzoSouQdB9Ns1Yn0K40yBGZr35ozPF83+xQEbiYupHzznUVAgv
 DSHqhZ7zvvr/2XhaYFKhS+HZN+X1qHX2E5tPDoBv+NUq415o/7K1l1TuHUv6TQhZoDH4yRv
 ulzkg7fqxGtCIWY8Rl6Sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wiHOLl76aFs=:spMSWi2Kd5G2Mkn0cgSUay
 LBz1UCOkIMQn67NYFFBw7Ah9nA92MnOEXyDIseqOoggWtOehh7t9dHXStBaABtL1ywCdo5cle
 aGLHCoDW3rmOh1dWAiXhAu8KCi7i45Yhvjh0uGQ5pfeBIqYRYZZSjJil8xhIvXjSjc35QjFSG
 9W9JT8lThOoy4HWJw/qNoDojn3eOZI0QLhgS8F3ukaf4avA3oLKAG7EsnlbYFBHeLYV4KChby
 /tFLRisXkgocLvd/Q/xLdiRvi09xbdoXP18wuxcRLkPEGaUAUX59+538br5y0tiaEokOt/LI1
 S3EVsfCuMsNi88ZLVop7g5u1ZVyacQ1lBcTfX445vdLmxclEKfgjNTeh4SV56vOvAhWmu31FB
 4T4KXoPkbqnaByT2BlnC2RMm+O72IttJ6ZXm4gYe6CuUy8obBoPvSVNLXytcUAFukKGE/GMof
 CjWSafBhS4ReWxe2F9DqEReaqG+T81+t86H6qzhcbvzpd3sClzseerw8qaQwfQILiI9kQD4/h
 n9K5HnDrSZXvejGoXzU/O0mt0lyLDFlG9u53LEIpdT7hq25j5NDIet/WGezao/G+E14qcWrVY
 /C2+y3TCBjJAStmTb9iy/jCM7nlJFF/00Q3T45F/7pCsuFgAjVKoT6LtOxTiPUAryKBSincuM
 CBVbWGBZUrK9hGL4QQgLBiQI66j9Craxjnbc7KZF4mTN2X32g9JpAdtsW84tQTK83BnlsH7fq
 /Uc2es3LbrtC5IDkJKLhB0vUKLEpI0c5xBttpr0PhWl8qR6tvnigPVn3xgpBeVWqLSNlEKi6M
 /2PaedcHyVbjpuEZgY4X4CeFeFSKpMy07cBTbkYDpn0MeA+MTaqqMCmbGSMt1Rktk8BKF+tHL
 LbbPX9ueEhDFIyswF5tmMbX9fzWADcwHaBmq3keZsgV+N/WlEBcJ+eBLNzxX6MrBe5jgHgoID
 yFuZ3/dd+/J0TEOw61njqAQ6Zxgu9Vbmm88iCiM2IQhl/MaqhQKNwG/+h74lgCZSTafXrN33B
 dfGTn6PBQ5vAKeDo8AouLuyHdQqEa8QkmkxfXPWp2CSyb7VU9t1wwCdT/yLw/dyYQjGP/y4x7
 KyJlv++ucCCtUUuEd0lysK7agN8kkHpc2/g4q9vup4ZSiasXgPXTVWixwNHjXDuo2gowluGFk
 Yec7w=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 15:45:40 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 15:45:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci]
 =?utf-8?q?Checking_information_from_=E2=80=9C--parse-cocc?=
 =?utf-8?b?aeKAnQ==?=
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

Pj4gV291bGQgYW5vdGhlciBkZWxpbWl0ZXIgYmUgYmV0dGVyIGluIHRoZSBvdXRwdXQgbGlrZSDi
gJwpKSBlcyBlbHNlIHvigJ0gaGVyZT8KPgo+IEkgZG9uJ3Qga25vdyB3aGF0IHRoZSBzZW1hbnRp
YyBwYXRjaCBpcywgc28gSSBjYW4ndCBhbnN3ZXIgdGhlIHF1ZXN0aW9uLgoKQ2FuIHlvdSBmaW5k
IHRoZSBPQ2FtbCBwcmludCBzdGF0ZW1lbnQgKGJldHRlciB0aGFuIG1lKQp3aGVyZSBhbiBpZGVu
dGlmaWVyIG1ldGF2YXJpYWJsZSBpcyBkaXNwbGF5ZWQgdG9nZXRoZXIgd2l0aCB0aGUgbWVudGlv
bmVkCmtleSB3b3JkIHdpdGhvdXQgYSBoZWxwZnVsIGRlbGltaXRlciBiZXR3ZWVuIHRoZXNlIGl0
ZW1zPwoKQW5vdGhlciBTbVBMIHNjcmlwdCBleGFtcGxlOgpAZGlzcGxheUAKZXhwcmVzc2lvbiB4
LCB5OwppZGVudGlmaWVyIGFjdGlvbjsKc3RhdGVtZW50IGVzOwpAQAoqaWYgKCBcKCAhKHgpIFx8
ICh4KSA9PSBOVUxMIFwpICkKIHsKIC4uLiB3aGVuIGFueQogICAgIHdoZW4gIT0geCA9IHk7CiAg
ICAoPCsuLi4KKAoqICAgKih4KQp8CiogICBhY3Rpb24oLi4uLCB4LCAuLi4pCikKICAgIC4uLis+
KTsKIC4uLiB3aGVuIGFueQogfQogZWxzZQogICAgZXMKCgpSZWdhcmRzLApNYXJrdXMKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBs
aXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFu
L2xpc3RpbmZvL2NvY2NpCg==
