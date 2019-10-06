Return-Path: <SRS0=YDxQ=X7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D378C10F14
	for <cocci@archiver.kernel.org>; Sun,  6 Oct 2019 05:21:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD012080F
	for <cocci@archiver.kernel.org>; Sun,  6 Oct 2019 05:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ikJYTCbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD012080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x965LdSG002094;
	Sun, 6 Oct 2019 07:21:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 954A3779A;
	Sun,  6 Oct 2019 07:21:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 12E527792
 for <cocci@systeme.lip6.fr>; Sun,  6 Oct 2019 07:21:38 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x965Lain022098;
 Sun, 6 Oct 2019 07:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570339275;
 bh=Gzwjj7P9wQpJ+/SFZL5s/IigHlX0dcbFlXIX9fH7eVA=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=ikJYTCbcHu82jjzFxtXbePWLIr9nCdQFyNt/ip0qveDzK5Bhu5SrwCoZwhgBln0q9
 AD9CXYoaACmNa632XUl9mxtI92tGsvTRAeoe6XtL68nz+OEHgvU0N3TpUwWftIS2je
 vyQnvG0KNgsEzEQ6oTpsAqpwEcO7yfaKB7oi2qcA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.114.140]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYO45-1icaJX306L-00VAOa; Sun, 06
 Oct 2019 07:21:14 +0200
To: Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu
 <jeyu@kernel.org>, Martijn Coenen <maco@android.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix
 <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
 <21684307-d05c-1856-c849-95436aedeb86@web.de>
 <alpine.DEB.2.21.1910051425050.2653@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f64fc086-7852-b074-6247-108b753dc272@web.de>
Date: Sun, 6 Oct 2019 07:21:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910051425050.2653@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:XVYI1s9CF/DzmkQbhpyKPdghNbOybt89fDNSP+wQNrMXl6wQC9M
 StU/7dwi8q0jN9nxp7vYWjtPbDyi4sbQYLyUNL/wQdlXTNq8H7CjGfzNsl9Z4CqvOd4VMg3
 sljBvqrOZxXYlQ2Rs75cNpxWcGXu9O/j/fjAPfOtnwtbTXkyUAIus6CZcoySSV/za42AEdD
 PMrKt5BjhtbbVMdrEGXvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y18Sm5TQzm0=:MlGQbqacqjgkdIs11qgG84
 JpLb05MQe5mkGqDyWACsnsIQlaKUvOfqEhK86VFcPpMy/UmpV3WqWU7lJ6uSJehk/W3CToj9n
 EsuOHIL4q2ZifX44NFBMA3ay1TzuRndkehTbXz2sHGCo56PbEr0VlIn3VcIFuWapLSRu/EpI7
 K8GbD1aFkJB6EpYwzPKVN2miv2YMuZotkcUKn+MGGR7nw/h6zET3hoof1lYIEfdR5o8M8s/t4
 lwby92SAKsYGPg2KlJaeRs8iRn27yolfaZjHriXZclB08tWeEIfr4W44/EGuC0zAwAZLmxAHl
 jXgEYwf+Uy2UccCvq5vz95E7o/6VV403pH1U2so/wO1ifG7ClfEPZpbWva9qHtppE6CUTP0aw
 Ozg4uR4ZM4ou303CP/2oKpEn7VBxltAWULb2Tj/CQ9NuUGgCYuP/HokIHp0mCeS5zVCSjepks
 UjdjvChk+LEKhT1KSmy7UuhH5F7a6dKSlnyjiSD/6z3m9SwLf2pPkF2bQW8h1J1rN+FqVYZp8
 4vASkrrSIfNI0emDnyKWdicgwIiXh8IU7g+D3qiI9CgR3m5nE45J9PYAfataYiVQg1acm2rFH
 R20tu5/1Z/Ga1Jt/KUlVL+aL46KTFe6nVUv7ZtY8qegIY2WxcJzDe6gR8Fwb/oik04GaEvB67
 TUupbKGXu4dW50YbY75NtKW7jaRL9G9ZhRnvURSlz/ZuQzp+uPe3MOiPvhHGGPubCbHkRmgYQ
 xysLgzPQqjvlUgpg4z+SZuIxVZ7pxcxOnnVM5TE7ED77p8sDbSTleKR1nvB85FRjziRsDm7Sm
 HsOdCAWUzumeO6qPRfaZBiyL8fZ6vQ0Dk81//ubhkRUyNm751iZfmxyRXrsDqaEp/+OXMKoWu
 PDqc6rdOt7iSty4tGC298iFJF74ksUr9hA4LD8MYGJqnaJp9U8D9wameM0ZJKZjHfi84Tu8dB
 Gm1xopg3cf039T2HyjUar4d96PVsGSe78LOymFxDvd269Ex5qhNlRxpP8TBp4gFtGg8PUCMqo
 iQSFi6WWwqHdHaTPdJFfvFFrFdOWlnloSJTwzYsaImxi2otCz5yObbsV0VX7FVNK5AxYun2X5
 BklY6grplEhz93FLKNe9gxTGk9JS5qeAG+HY4aN1IqxPzxhG74VMr1c2rQC7e8hr5XsKrpMbo
 5LXHkvaRE6JzGayxEQH0oypaW85GpQWkLhRm+8CqPPe0rbn41hesJqa+sFgWE6B0eM/7eAY9y
 QhHR4XvaLYzjGNgjT4UEWUq84xSHgbxp0+89wlri3byrYMyjx6CAoqhWazQU=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 06 Oct 2019 07:21:40 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 06 Oct 2019 07:21:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [RFC] scripts: Fix coccicheck failed
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

Pj4gV291bGQgeW91IGxpa2UgdG8gdGFrZSB0aGUgY2hhbmdlIHBvc3NpYmlsaXR5IGludG8gYWNj
b3VudAo+PiB0aGF0IHRoZSBjb2NjaWNoZWNrIHN5c3RlbSBjb25maWd1cmF0aW9uIHNob3VsZCBi
ZSBhZGFwdGVkIGluc3RlYWQ/Cj4+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL3NjcmlwdHMvY29jY2ljaGVjaz9p
ZD00ZWE2NTUzNDNjZTQxODBmZTliMmM3ZWM4Y2I4ZWY5ODg0YTQ3OTAxI24yNTcKPgo+IEkgcHJl
ZmVyIHRoZSBvbmUgbGluZSBjaGFuZ2UgZm9yIG5vdy4gIElmIG1vcmUgaXNzdWVzIGFyaXNlIG9u
ZSBjYW4gc2VlCj4gd2hhdCBpcyBtb3JlIGRlc2lyYWJsZSBhdCBhIGxhcmdlciBzY2FsZS4KCkkg
Z290IHRoZSBpbXByZXNzaW9uIHRoYXQgdGhlIHNjcmlwdCDigJxhZGRfbmFtZXNwYWNlLmNvY2Np
4oCdIHNob3VsZCBuZXZlcgpiZSBhdXRvbWF0aWNhbGx5IGNhbGxlZCBieSB0aGUgY3VycmVudCBk
ZWZhdWx0IHNldHRpbmcgb2YgdGhlIHRvb2wg4oCcY29jY2ljaGVja+KAnQphbHNvIGJlY2F1c2Ug
aXQgcmVxdWlyZXMgdGhlIGlucHV0IHBhcmFtZXRlciDigJxuYW1lIHNwYWNl4oCdIChTbVBMIGlk
ZW50aWZpZXIg4oCcdmlydHVhbC5uc+KAnSkuCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvc2NyaXB0cy9jb2Nj
aW5lbGxlL21pc2MvYWRkX25hbWVzcGFjZS5jb2NjaT9pZD1lYjgzMDVhZWNiOTU4ZTg3ODdlN2Q2
MDNjNzc2NWMxZGNhY2UzYTJiCgpXb3VsZCB5b3UgbGlrZSB0byBpbmNyZWFzZSB5b3VyIHNvZnR3
YXJlIGRldmVsb3BtZW50IGF0dGVudGlvbiBmb3IKZWZmaWNpZW50IHN5c3RlbSBjb25maWd1cmF0
aW9uIG9uIHRoaXMgaXNzdWU/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3Rl
bWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2Np
Cg==
