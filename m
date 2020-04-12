Return-Path: <SRS0=MFMu=54=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5D9C2BA2B
	for <cocci@archiver.kernel.org>; Sun, 12 Apr 2020 09:01:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6EE206E9
	for <cocci@archiver.kernel.org>; Sun, 12 Apr 2020 09:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="doJOaKfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6EE206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03C91bEo007503;
	Sun, 12 Apr 2020 11:01:37 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8D04777F9;
	Sun, 12 Apr 2020 11:01:37 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BCA12775A
 for <cocci@systeme.lip6.fr>; Sun, 12 Apr 2020 11:01:35 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03C91ZrY029193
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 12 Apr 2020 11:01:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586682094;
 bh=ZlZo9Yf5wBgX/FvYf7j7BH25qhcvOGs5KW8ajRa1fLg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=doJOaKfNqVYlXb30U2JoOWu+H7Hh7CH7Okbc6raf2qmvC/9W0gss/Y/O8WWP0Zq1N
 Bh9G9KCZr5xz7FNsAAjgZKwMk4at0MqJX9jB8DN3n8MUhNe2HlVxJIVGUqhDitv9WJ
 ys1OGrv6z5rkjd7dmMXGlccdtOsv4Nrud18S8BFg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.125.27]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWRzK-1jl9541LLO-00XdkN; Sun, 12
 Apr 2020 11:01:32 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <146360ce-9cfb-e6f5-1601-fa95460c2cd5@web.de>
 <alpine.DEB.2.21.2004101712080.3039@hadrien>
 <f0b37f45-5144-a1c5-3f52-5bfbb6f3635f@web.de>
 <alpine.DEB.2.21.2004111600560.2369@hadrien>
 <fcbca1d9-7375-b488-54b2-a3934b90c6ed@web.de>
 <alpine.DEB.2.21.2004112036270.2369@hadrien>
 <d878a25d-29fd-28b1-fa6f-2e0f44763d73@web.de>
 <alpine.DEB.2.21.2004121050210.2419@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c3096ced-6ecc-b83c-57bc-f4655750fb48@web.de>
Date: Sun, 12 Apr 2020 11:01:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004121050210.2419@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:ok4fGgtuK3m4kI4FoUTZIghtjmdUAUmaeGZKF6qK4wybuO82KMx
 Zd5zcW8n9Sp5rGjpqLNq/gnHW5I1v96QsJgQwZ8NVSTbqYZc/O5VEfaO6mt/9JZpfjV/TTd
 9PktGEItd5cCSi8jsn/+NsDzKc1WixUyJufJMO/JoXs3rXqFRTeqznYUv/jlaBiLODkFDJe
 FO5MDNTupC39LJ9l9Auaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WdZ9e6D5BwM=:W4SL91J2rimQrTNivFdCsZ
 XWUJlm0Ybxx7LL22hsicTBRAMH7hqR7iyzGBHBKaeOQOAVgTN2UiVKvnr3S+mh+kxx/vnPYOV
 dcsta2rqbLRnDuU4wJ2C1mZBEBTEIM02yTNeTRcRNHYSe54jCr2Vby4+kUGYCWNxjus5NxpbH
 o8hJC3xxTbWzPOOTlI1JmRADwYLdIBG7K1urgA7KgaqrnxZlWIKyQ66eoz4GQu5kPXnva4ImH
 xf4i1OkQ8Rtc6wyn7jQUEwtl6gqCA86XXzRvLqNxvLdUpic5iDnXvfuwsqPNBeOfk/yfg0Ec7
 KMWOJiUjl/AfQ60Y39aFLbIirV5AxQj9Su/fW7mCysWrN4MJLKOyqoE6PWgbtztnuRkKucI4k
 Un/kzq4Hn0WBlUe/o95tozibB2ZXzwFsuHrwPrjF9c8YpyW1/2cE5trSQozygpc4LYD/8gNcG
 tFarfm8uyF++9Om5cCuCY8NOfdBHPOGh2+8eoVu3zNI8chsL58TpGr9pEL2etimM2UJgoyAu9
 UcBy8KkrIXZDDWHIL881qgR5ZSEn5h5vIoKv9NgqHmoxkp6PtvNVCXtxbUoi2GUsK7hLgTCOQ
 Ga4L6H0VYGR5NkfOTsdC6vNlgWAXuqsawEckqDzAm/6B1MSm8uBwEaPmhEaczqbhEAJrbOphw
 yT94a4a7s8w8ihfPVXJJhVpm/JKU2oN7fYrOnEKm1DjoNf7PXFS0Z4M8VO6JzPPIe0OflrRAQ
 ERlCsTw8CeLsaMkS5vCze+jaT6jBFNmFdc5Xcz7Jgf5+CQkblJ2TAZoPCGsBAB7P9PmDatmZq
 yTBHWvr1sf/vSDo3Xj6WpDPOrNo0F3xUXkCHtMyyLm7KsClO56eaf+yt+46kDy+liXB1UsWvg
 Vh4z5KYLqH8HXoCbCNs2WTbgTky6oJUrOaqlpMPKKZyhskV3mkw3t16IQeInthcB7suQUCZjN
 vo3MbisuluR6ZQWYCoSA+tD4Qk8xQjc4oU4bHAPHOFtWfPrtxET4P301xX4rVeOMqnQl8Er5l
 I8qkfZAYYiStwGkEsDeVGiHRIxY2qHaXI4YYEoJTo8prO9qi8w2hcxatGwacScc9mlr/HpEl7
 ABqSXXa+c6QkTdPv2RIjjI55KxUmtpIwiy6Ew/Bx9TcqPuiqNPMjZBSZMRQfXgGtnHTQOhTNX
 jxYQaeMHO0G1Yb6WWTGHO6mCl85DaVTIlJmPwR4lAMMV72JexKjoE5b/+yogA2Jn3ItUw+jaA
 G6UnyxbsV7hKDMaRn
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 12 Apr 2020 11:01:37 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 12 Apr 2020 11:01:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] More support for SmPL data processing with databases?
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

PiBJIHRoaW5rIHRoYXQgeW91ciBpc3N1ZSBhYm91dCBzb21ldGhpbmcgbWF0Y2hpbmcgb3Igbm90
IGhhcyBub3RoaW5nIHRvIGRvCj4gd2l0aCB0aGUgZGF0YWJhc2UgY29kZSwKClN1Y2ggYSB2aWV3
IGNhbiBiZSBwYXJ0bHkgYXBwcm9wcmlhdGUuCgoKPiBhbmQgeW91IGNvdWxkIGVhc2lseSByZW1v
dmUgaXQKCkkgaG9wZSB0aGF0IHRoZSB1bmRlcnN0YW5kaW5nIG9mIHRoZSBwcmVzZW50ZWQgU21Q
TCBjb2RlIGV4YW1wbGUKY291bGQgYWxzbyBiZSBzdWZmaWNpZW50IGluIHRoZSB3YXkgdGhhdCB0
aGUgZGF0YSBwcm9jZXNzaW5nCmZvciB0aGUgU21QTCBydWxlcyDigJxmaW5kMeKAnSBhbmQg4oCc
Y2hlY2sx4oCdIHdpbGwgbmVlZCBhbm90aGVyIGJpdApvZiBjbGFyaWZpY2F0aW9uLgoKCj4gZm9y
IHRoZSBwdXJwb3NlcyBvZiByZXBvcnRpbmcgYSBjb25jZXJuIHdpdGggQ29jY2luZWxsZS4KCkFu
b3RoZXIgY29kZSB2YXJpYW50IGNhbiBldmVudHVhbGx5IGJlIGNsYXJpZmllZCBhIGJpdCBsYXRl
ci4KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBz
Oi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
