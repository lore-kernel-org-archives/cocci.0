Return-Path: <SRS0=TLPZ=22=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BE8C33C8C
	for <cocci@archiver.kernel.org>; Sun,  5 Jan 2020 13:55:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA38207FD
	for <cocci@archiver.kernel.org>; Sun,  5 Jan 2020 13:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="CCmEJeku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA38207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 005Dsk5u015287;
	Sun, 5 Jan 2020 14:54:46 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 252A77718;
	Sun,  5 Jan 2020 14:54:46 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 47B7A73E2
 for <cocci@systeme.lip6.fr>; Sun,  5 Jan 2020 14:54:44 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 005DshHj023140
 for <cocci@systeme.lip6.fr>; Sun, 5 Jan 2020 14:54:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1578232482;
 bh=Tp5Ahb79HFtyW4rnw000dfEQLcOpEidNgeu6xSJRlH8=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=CCmEJekuVcyuTN7naAc9MmBQ7WEr+sNQHiT8hIG9BCaoyJ/e9hK7dWsRUHm+JOfK2
 TTrjrodJZCNmdXXauO9HlB5Zdsfq1xexdYCpyAFmeemD5Us4edWIicMTAEM04mu0g0
 Gwl0qFo9zunhi6028/VlaBQvctoYjsV7eeuRLEpM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.187.152]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lcxw8-1jVvUY1UTg-00iFNo; Sun, 05
 Jan 2020 14:54:42 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <20200103160304.GG17258@pobox.com>
 <08d3a32e-7adc-ff5b-52d0-9e67ed03ae42@web.de>
 <alpine.DEB.2.21.2001051100550.2579@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <58ae2bb2-45f1-49b0-d271-515434d048eb@web.de>
Date: Sun, 5 Jan 2020 14:54:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001051100550.2579@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:B8GiLm6cNWYsTpAtIz+3lQ+6t20zfsnGmAI8sbrMAFcezICDQ96
 BEod8ErF6Hr0XSBC/QwouNM43TMi1LH1GmRGNZOOvEdu3Tg3iOjk5rXh89t1pSjYrCj8/Kn
 u92KqjwdQVGEtx2Addo82w1pVm2pH+5NZ1L819SzKwhjWAgFLRVzLOfmVs7M6Z4rt4x/FU1
 6Iy5a91WDJ2XzjYVbKK4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FFCyx+FRREg=:Bz7ykk8wHVh5jBZGRrDqzq
 x2uqVDnuVeQJoIMOYfog4Q3EoRMH4Ejt3GGYCpFcgXX+F2eyyPZIGdLd2t4r4EIMlgWXCoSrZ
 hiaADkhttYlFG885JeshDh0WxEpIIHRno2/62qesjacGKxhvnQABN5QRhP5tCNjY6+1TiB2c/
 9GDse0iw6QBdAO5f2c7U92nDA/iX0tvJr9h2QbLUm8VU/sLkBtoF4zseJm9KSU90zfomJSBcL
 lWjEtyRut9COrrP2PQic8LJxyfPi9cF7tlQazcaV37CaoR4haMdIbltfAfYvYxEaPyhwK2smW
 miZixUpdIyovmagVaH7uDbdD56R6y+eol/JS3Sd8ccfwUSYmuimKizVT0aMU7I702cmY5kYBr
 zR5l3P0mEVyRoXcqHj0mH8sRa80I7qvOlkcUAONWhkKRhwD6Q0XrSot6Cc94XAMYAwDBt8CbJ
 zMcTeXJO5H+skRPJLchPofHF6wncUtJHzdLqGsBqsfnjOkN3QQgQLQxrk4t3aEDeSzOzpxp+Z
 Iv3Ggi7ftZRddi8X/fPcyvRQlPDfezYvd/RVYli9J710+W4E4E7vEoSzyYmgGoKfRzYbMje/m
 rX5lDb5XU8fkJ+TazYEtrQV5El0OUFOk61MI4/l4Y1bOaa9xVkyPZoqYBDP6n/knt6vTNBPPQ
 f3qpdo7z43mf1X7wsTRnlhwpoL8kNUDI6uJD32nGv9EmWvhtAw1KFh+S42MP2ATSXW4/tb/J7
 yVV6f8bT9ZS5PC7DCSApvO98flwc2lNfCVq+c2cr55xOeLDKxRZBgUiwSwmOLGOBjLdMchqOT
 pU68tVn9Xs5uK6ltd9R7LGgI5SYU4Uo6gScLmkRYM7UnCdvmmyabHMhA3z3yWXy+Db1AyDb6I
 JuOoln9GDjSZrKge3CqoAXkg/PD1cODppYe03xvuDBetcNTvZ81LGC3SE34/sfl7p2dwrxNNe
 mYkOS6zxCIodnyT9Sl+Lak8gvU8SihAKfdPi+NKcupG3Dhv6lFgIScTrps0vneqs0toUdg3wn
 tai4YpPN0O8/PQm3lwkurg2mlkXucYy6JsUtvTCckatwraaEeHPAdNRcbMIcYk2HkxsitLxWN
 d2YQFgeFMmGTXc0U7x/MjBkq/tcQTH7UCJiNmYcrXJ5wrQ95eLaXjRVzQFUHclKDGgicmXkb3
 LsvA18p23vc78o/LkrofLvtMq3ffRH663e/F9Ormn7er9wyxyDPI0ScSktVFBYf/ghb22vl+B
 X2QBTyONDbdzq9KxFSyxM69KFaXz3BAlCGIn02px8mfTVkQG5O1vrqWLr2kk=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 05 Jan 2020 14:54:46 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 05 Jan 2020 14:54:43 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] transforming arguments to statement macros?
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

PiBJdCB1c2VzIGEgcmVndWxhciBleHByZXNzaW9uIHRvIGRldGVjdCB0aGF0IGEgc3RhdGVtZW50
IHN0YXJ0cyB3aXRoIHRoZQo+IHdvcmQgQVNTRVJULCBhbmQgbWF0Y2hlcyB0aGUgbmV4dCBzdGF0
ZW1lbnQgYXMgd2VsbCwgYW5kIHRoZW4gaW4gYW5vdGhlcgo+IHJ1bGUgYWRkcyBhIDsgYmVmb3Jl
IHRoZSBzdWJzZXF1ZW50IHN0YXRlbWVudC4KCkNhbiByZWxhdGVkIGltcHJvdmVtZW50cyBmb3Ig
dGhlIHN1cHBvcnRlZCBwcm9ncmFtbWluZyBpbnRlcmZhY2VzIGhlbHAKdG8gc3BsaXQgdGhlIGF2
YWlsYWJsZSBpbmZvcm1hdGlvbiBpbnRvIG1vcmUgdXNlZnVsIHBpZWNlcz8KCgo+IElmIHlvdSBh
ZGQgdGhlIDsgYWZ0ZXIgdGhlIEFTU0VSVCBzdGF0ZW1lbnQgaXQgY29tZXMgb3V0IGFmdGVyIEFT
U0VSVCwKPiBub3QgYWZ0ZXIgdGhlIGNvbW1lbnRlZCBhcmd1bWVudCBsaXN0LiBCdXQgd2l0aCB0
aGlzIHNlbWFudGljIHBhdGNoLAo+IHRoZSA7IGNvbWVzIG91dCBvbiBhIGxpbmUgb2YgaXRzIG93
biwgYW5kIHdvdWxkIGhhdmUgdG8gYmUgbW92ZWQgdXAgbWFudWFsbHkuCgpDYW4gdGhpcyBzb2Z0
d2FyZSBiZWhhdmlvdXIgYmUgYXZvaWRlZCBpZiB0aGUgc2VtaWNvbG9uIHdvdWxkIGJlIGluc2Vy
dGVkCmJ5IHVzaW5nIHRoZSBmdW5jdGlvbiDigJxtYWtlX3N0bXTigJ0gb2YgQ29jY2luZWxsZSdz
IGxpYnJhcnkgaW4KYSBTbVBMIHNjcmlwdCBydWxlPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlz
dApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9s
aXN0aW5mby9jb2NjaQo=
