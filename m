Return-Path: <SRS0=uZfY=SI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0511DC10F06
	for <cocci@archiver.kernel.org>; Sat,  6 Apr 2019 12:37:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274E3218D4
	for <cocci@archiver.kernel.org>; Sat,  6 Apr 2019 12:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dBmP9U2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274E3218D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x36CainV014458
          ; Sat, 6 Apr 2019 14:36:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3E0E17720;
	Sat,  6 Apr 2019 14:36:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0AA48771E
 for <cocci@systeme.lip6.fr>; Sat,  6 Apr 2019 14:36:42 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x36CaeIe009487
 ; Sat, 6 Apr 2019 14:36:40 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1554554174;
 bh=6n4h3SVYecpMQhhJS+8GQxVauQP+RBiV0Jh5Ak+P3Jo=;
 h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
 b=dBmP9U2c2AvwF12k3ii+Wt9RDwk+eH6zl1pim5XoBhc3w/IHy5cGXVFiF9WTcj5bi
 hEAaZSK5WWfmyQERV1m5mi7vZ/F4QZaP8GAxORFuDpWYGlf8M9oOBHbWvrffgDcGNB
 3oPwT8tdZ3x4nS6bl7pJFSy6/q93IwPZ3PFtxr+A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.86.163]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Martm-1hSlGe1HT8-00KU76; Sat, 06
 Apr 2019 14:36:14 +0200
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
To: Himanshu Jha <himanshujha199640@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <842596fe-56ee-5732-1501-85ee95364406@web.de>
Date: Sat, 6 Apr 2019 14:36:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406061112.31620-1-himanshujha199640@gmail.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:EIeaP59Pu1/j8FlbNmYGAFaV3v0ece4pZ8x3bWH01LMpkukH4DP
 HNYEdKjfaYokI6bWhJZ0pn4frljGdKrH6aViS+rN3HkB5xXjmGvb7LoqEQmihnx1geDnJag
 DZK2tKXIprJDU5dZ7R4oTJSn/jB8yIg2gkwxvFO0Vi2DQVgsQ9aRHmYMbUn0FRyzUYaefKu
 Sp2H8TaTbT0J/hvm7CD1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KK0se1u2T1Q=:DczZPllXgA50YjUFcrurUq
 XZWYDFzyHCcyOOS62t8GHe7p9Xx0PXbO6mhusbe55Dd99OM7RRFNj8OZ/1Nt3QeyD+Rnz3So2
 L2WWz11evIuSQ1FhbIksPWySzl2OBQY6qqg0r3BE6XkrxAG1nHunq1O+WPzxuV0fdYMz64AY2
 f+x2MXXwOhIQyeWQsre7gl2BWkH3phOouFJbZW6Vv7leU9+ZI/BN781iXE4+7tPI7kH5lJIg4
 aWgaq0a2xfQLRyNDRIeOzucPOXL6HaMUN6btOkYRpTC8CSJfRoQ7LhqBn1iTKDeOnJ5kdV0F4
 CdorcyzohsKQ7klDJtRRGTiVZfMWgaU+AV4YD0KU3/7XcUcJKkkcJZhjJQdrPncMjSVoQneE4
 oLYxk8iv/nDiFUjee25Fa/AYtV7D1G3CtaPmOh9d+VkvfaRHYts4B5SKIW6FbltyF/J4Wm8+W
 5Qb3z2gJgwvPHS5iv4279MP9BqWoAh0j0852Ys6Dgckp45RfUv9NHrE7PI3UEvot8D7/r3Mh7
 qxZ2IYhAj5M2dYj+SWr8Fke8soVMCMnFj7N1QeDlAp2fcJNF/grGvYYc5HeKFDWOCTvDS8dT9
 USCE8U1mt1Pm1UoFizFwszd87A6gErYDYMR47bV36VyUBqdtvefMOWfNXDBXDh7PAetSfdgJZ
 jDpHBs3Rt5yZNsK1+UPO+a2+7QY2Dd5kOi+Yd8YwXvXh6U8Z8b4hpK30qQIXdd5D5fg9zyGW1
 5qwOHSR5LmhA3m0o/IcwEqhj4ETdoj+m9G+tebchU2sNMFcIgbV07bmidhRntT5uRgkIZj6Zy
 4pi24l1rdqoQbSCqNmxWvoH8UwzgHGUSl2/xUAyHy4Q9tjQVv/Iuz1QKJ2WWvMasH7ExQ+ylT
 wgVSwzwRbLuaM2SBOz5rbiKaGmcqLzYxES1fb4H0wheevqCI6Ns9Zuu3ojfK8Vt8elNuBZsze
 bwDgZlmOBlg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 06 Apr 2019 14:36:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 06 Apr 2019 14:36:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinelle: api: add
 devm_platform_ioremap_resource script
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

PiArLy8gQ29weXJpZ2h0OiAoQykgMjAxOSBIaW1hbnNodSBKaGEgR1BMdjIuCgpIb3cgZG8geW91
IHRoaW5rIGFib3V0IHRvIHVzZSBhIFNQRFggaWRlbnRpZmllcj8KCgo+ICsvLyAtLS3igKYKCkkg
d291bGQgcHJlZmVyIGEgU21QTCBzY3JpcHQgd2l0aG91dCBzdWNoIGNvbW1lbnQgbGluZXMgYXMg
ZGVsaW1pdGVycyBoZXJlLgoKCj4gK3Bvc2l0aW9uIGowOwoKV291bGQgdGhlIHZhcmlhYmxlIG5h
bWUg4oCccOKAnSBiZSBuaWNlcj8KCgo+ICtAc2NyaXB0OnB5dGhvbiBkZXBlbmRzIG9uIHJlcG9y
dCAmJiAhcGF0Y2hACj4gK2UxIDw8IHIyLmUxOwo+ICtqMCA8PCByMi5qMDsKPiArQEAKPiArCj4g
K21zZyA9ICJXQVJOSU5HOiBVc2UgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlIGZvciAl
cyIgJSAoZTEpCj4gK2NvY2NpbGliLnJlcG9ydC5wcmludF9yZXBvcnQoajBbMF0sIG1zZykKCkkg
c3VnZ2VzdCB0byBwcmludCBzdWNoIGEgbWVzc2FnZSB3aXRob3V0IHRoZSBleHRyYSB2YXJpYWJs
ZSDigJxtc2figJ0KYmVjYXVzZSB0aGUgc3RyaW5nIGZvcm1hdCBleHByZXNzaW9uIGNhbiBiZSBw
YXNzZWQgZGlyZWN0bHkuCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUu
bGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
