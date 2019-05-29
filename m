Return-Path: <SRS0=gowI=T5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DB0C28CC0
	for <cocci@archiver.kernel.org>; Wed, 29 May 2019 12:29:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF5E2070D
	for <cocci@archiver.kernel.org>; Wed, 29 May 2019 12:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cHrFE/vZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF5E2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4TCSXo7007115;
	Wed, 29 May 2019 14:28:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EA8947762;
	Wed, 29 May 2019 14:28:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 24A867756
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 14:28:31 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4TCSPOj004285
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 14:28:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1559132905;
 bh=F7A7g3gr5qBNc7OjnHHPne8owrt4sXjKLPKQ6T0rjqQ=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=cHrFE/vZklKPytTDmJ32466YEbVrtkbTERa66kXgex5y3ARvB9mI/56jpModlBiw1
 Qm8t1Q+aUomyk0UGD6iEW/zzO/YP776D+bQ37do3lxyRjCe+i8exoqrs/cZliwxa5Q
 0cBcfS9kv+qAnnor4fSWNp5WmUY1Gersb3C8ATUE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([78.48.118.255]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MISsx-1hSNio0gMJ-004ALp; Wed, 29
 May 2019 14:28:25 +0200
To: Timur Tabi <timur@kernel.org>
References: <CAOZdJXVuNYEkFOiUWYq0GbqRUfuTNV35FGt7EViSSq6AqAY2-A@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <88a6a825-9691-33bf-150c-4b5b096475d9@web.de>
Date: Wed, 29 May 2019 14:28:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAOZdJXVuNYEkFOiUWYq0GbqRUfuTNV35FGt7EViSSq6AqAY2-A@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:TtB/NPL0KZkkOcyrIRoifubU6BYorQkMKZz1vjLcWhYhHZze2eP
 gZ4axtjVsdM4pTH2AUsScDnod2l/D0+Q96UVBFL5PcZxkm4XU0rzic8NigeUyEmI0yIhowk
 pAtbAe+kFA9YlYFhREVCVY8fG6xqVMfR0t/X5EDQuluxNKyqc73yGMig2ryZZ9ipghK6/9X
 pYAmLZV3wMJj7ZaDjrvhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SE4nVgwB3Xw=:3q3RLhsQuv8lUTag/v4GYu
 DfbzNU3pfROkhvAP71OCJrvaLlxappmee77fudf0Naj6goWVAxOwcNS5kaTUUn6vjh7RErcEU
 7YcxTVv4lMqfUmt7GzPKGTz9Ei2EDnFFd1m4ivrDwhzc36fLU6A9KONJk8ji2bc6ynVj7OEZk
 Ka6dW7lFhMt53pG8iTjFC5VuvSuBdqAjULO61VtUf2hKZWhv4tJXyvkHfMNt4RKxcMzA6ZNwG
 LX2XGqF3kX+3etw3RChyLb6Zz/nz6U4+BcBx6bBjkGXGZZz7MgOtLejRccWYtovVzGeuui4Ag
 fsHSHntbFw8J/Wfr4Z3Ca1M7gLAV7YJwKLcaCwrFVCfM4Wqi1mUFTuOrI60TXRLBHErymXW8n
 DOAmeywzbgL87JUmSArnzMJHcmXeV07GZnvGIB5xQ/a8qrdgaZCtBw2MNtCklAMWCZlUB82vP
 lSMGzHpUg7WJznjNApBh2Q4rIfAQJWb9sCWVmFBfC8Un1MHghiE//lZVYgVRT2B4iefY6UqS3
 qTYTGw2Qi5QqT7REn697beiW5tK0XdAu38qdYyWkWAURWDoRgHT7kiIBpky6/nKrKMQJRauau
 UmvkaYfJpu/tLvsXlwzV2+ru0JIpqSliRVNYv2v/yR0x/OSCkMs1fxG0sLFiWQGrnFqPJhiHU
 VijMxMftT8KJ8gdNrS9tXgxe4HA3LPSn0OzqqHInPlHSA4uOuQHysoZYui1We/2QcDNDJIEO/
 k9WV8FDf4yj0t246DsVjUIvTsatfXA1UKeuap2RETZCK9vvFjEq8qUey4KsffOw0sSUJNDWEL
 oQP/2WTYmI1XcVPiu1erGIlAG6pbqy9PZaJegg/yK5DKRMBpkJtl1zSvmTNVyd7pPep7n25cQ
 rJ/it740I66y7RnvjOueC7l2v6MiBC6t7PiFVqhmt9Cv6CxsrEclvvQ+zvYmAePcBmmR1ugme
 8/AQQkhzd+Ba2hkVwwXKa2ZOqbTyWLcbjg56tZKALAoojryjkNX+E
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 29 May 2019 14:28:33 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 29 May 2019 14:28:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Controlling where braces are located?
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

PiBJIGhhdmUgdGhpcyBydWxlLCBidXQgc3BhdGNoIHB1dHMgdGhlIGxlZnQgYnJhY2Ugb24gdGhl
IHNhbWUgbGluZSBhcyBpZi1zdGF0ZW1lbnQ6CuKApgo+IEhvdyBjYW4gSSBmaXggdGhpcz8KClRo
ZXJlIGFyZSBzb21lIHNvZnR3YXJlIGRldmVsb3BtZW50IG9wdGlvbnMgYXZhaWxhYmxlLgoKKiBE
byB5b3UgZXhwZWN0IHRoYXQgdGhlIENvY2NpbmVsbGUgc29mdHdhcmUgc2hvdWxkIHBpY2sgYSBj
b2Rpbmcgc3R5bGUgdXAKICBmcm9tIHRoZSBtZW50aW9uZWQgc291cmNlIGZpbGVzIGF1dG9tYXRp
Y2FsbHk/CgoqIEkgd291bGQgYXBwcmVjaWF0ZSBpZiBtb3JlIGRldmVsb3BlcnMgd2lsbCBjb250
cmlidXRlIHRvIGEgZmVhdHVyZSByZXF1ZXN0CiAgbGlrZSDigJxNYWtlIGNoYW5nZSBpbmZsdWVu
Y2UgY29uZmlndXJhYmxlIGZvciBjb2Rpbmcgc3R5bGUgcnVsZXPigJ0uCiAgaHR0cHM6Ly9naXRo
dWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxsZS9pc3N1ZXMvMzcKClJlZ2FyZHMsCk1hcmt1cwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWls
aW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21h
aWxtYW4vbGlzdGluZm8vY29jY2kK
