Return-Path: <SRS0=V8yA=Y6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF3DC5DF63
	for <cocci@archiver.kernel.org>; Wed,  6 Nov 2019 17:48:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A7020869
	for <cocci@archiver.kernel.org>; Wed,  6 Nov 2019 17:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="DRClsB9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A7020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA6HmGnO003987;
	Wed, 6 Nov 2019 18:48:17 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9FE3377C6;
	Wed,  6 Nov 2019 18:48:16 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B6C8877BE
 for <cocci@systeme.lip6.fr>; Wed,  6 Nov 2019 18:48:15 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA6HmFeJ008832
 for <cocci@systeme.lip6.fr>; Wed, 6 Nov 2019 18:48:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573062494;
 bh=TkTdk/BKzUFtvMtw4v00aPli11P/C8CxYQLeEDXHJzI=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=DRClsB9Guu4/LJJhsnh54ccPYkJBvDVrtfH2fLb8tHBKDqY0v7BRKXdIFiFxzW8xQ
 Db1vKZ3vIqu2EoUBHgl8SVWpJVIhiYKRhIZ3KWS2exz/u9cBql+vADU/AKyi3aQen2
 SOmkuLLvqeKPV5FLmWOpnyD3yUC6H8SwYdwCdsLs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.91.235]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LuLxD-1hkv732Xh9-011mJf for
 <cocci@systeme.lip6.fr>; Wed, 06 Nov 2019 18:48:14 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <aefeb780-642e-b5d4-5afe-f767683e4c2d@web.de>
Date: Wed, 6 Nov 2019 18:48:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:2TFGPc3P4P7+b8NdmjuCrHjCgWGJCXoQSaSRGTAj4SsTOx/bet3
 eik3kWDw1YiuYiAFxm8y5Ibu51NrftJAgshrxfhOJwnRJ/dW6uKkGTdIshT6RzFIotgEvqK
 2Zf6icXzGXWvPp9UuLfIeQO0Q2BTKQTvq+MjlnR46cUsjKKBlYruvOZYlYL0G1n0xdM01u+
 77LBzFdsnmjtaQuFZWySQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5Bo4OLdqeoY=:cv9Fpk0EsoEbRKpAULqHHg
 qoXouygzTpf9Jz7yXVUZL7jbrNnbtHZgcFMqf2+BnMb1X1fhy8smNN/R5QhTx1gAVbu0fnSQh
 ghC2ymIUtoXAxRh6QrPzg6jhXacLKDk/D7PwGKM7kDFefMouh4Bie0PFxkc6ccIUNmaVzI3/+
 zO9MIQhLlvXGg6a80/pLldH8bxAxQxmr/F5elUWPOZe/Y9Z13tWWcgHU+8Ix7zoU3LUib4Dh0
 zbkeOMKRFU+zLLiasGhGqZ9TPDXh3x6bCpJYfwwaUsSqT0QHuIH+t4AQzQTNcFmA73g3G7vC7
 D1SDEkpQxfsaJjICV2F19/IkVoiV9O6isiqfETdL0/G+piMZ2oDx9jWnbOfK/vqrgwMg7+bH7
 vcrBIjBe2Fyms1LcgLLgegtXQeIeaEqQo6wzYUfV489aExSmNtD/oAgOUM5b69UNN7gzG0GX9
 QyO8gE6dfA3jSdsLCXb1OSy+q2rcYxachj9qNy3OBQ0tf0Zi36KfPx+gharcu/AM45pMnETnf
 9qDGciOEc/cNMlq9K4Sw+M4iVzT3EIFEkzOYIHBt32zLYpPcmePHCXZsOPTDxhqzuXUIkdHRL
 haQsL2CsPPCsPS0UplLeuCepxR0qmo6L5SEpUEsbANCUahgI4wpBZhCzQzniPSnT/ZNifTtrf
 2sY4Zi4ylATBlCGCjPF79EZ2+uUhqBDf+YePy0sQ2X9KfZukKgwokFN1NjL41Ykv635JYKJ88
 fAGkT6+WAJhixrdTqc0aXoIQ93Ugc1hwOyA9VdU7XLTNADlMycSET6cHpWm7slASd8SJOEnMR
 ZSAJQgeqRyfxLTPnPhzlE1+j8FkuQgwkJwrDgOUENSk3MqnC68h4lppj6tOXwqKURh2scN2vp
 +yzGLCuAPIStg+SQmv0HpHDB++VvqPgVB9AnwkeIMSH6iqxe6mGQJgumDUtT2Te1+2oot1vPO
 jhtCSt0G/xBKkPeksXwhRo7WYfFHiOIXZNv+/EjsGyrwD4xbMXoWKabk3eLfFFVIGtWPkQIM7
 1ziRVQQtwf/ywqv8/WVcDnFJt8I2XEFo/ImnteVNlXvnaO2Qv8mHRWANpUci9jO0YIkbiPv61
 eHv2VzqoFZ6oNubp5lntZlNmMkbq5GdzM6PE6cQcUFZEJu89B59R3EdFdHW+3c7rXkMj54l/H
 hqkxnVbxZ0u0QzIdPhnmjrWEvl+mQcRwawe0GlXFjSdCjobdB6AXefE5gCi8vGLlcYPNStvEC
 Ry/Tv5tNsJCyvRtL8QB8Sals94hm45ITGRzdSIP5WjJM3jmmOpHpzy248mhQ=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 06 Nov 2019 18:48:18 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 06 Nov 2019 18:48:15 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking data processing for clk_put.cocci
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

SGVsbG8sCgpJIHdvdWxkIGxpa2UgdG8gY2xhcmlmeSB0aGUgZm9sbG93aW5nIHNvdXJjZSBjb2Rl
IGFuYWx5c2lzIHJlc3VsdAp3aGljaCBjYW4gYmUgcHJvdmlkZWQgYnkgdGhlIHRvb2wg4oCcY29j
Y2ljaGVja+KAnS4KCi4vZHJpdmVycy9idXMvdGktc3lzYy5jOjE3NzY6Mi04OiBFUlJPUjogbWlz
c2luZyBjbGtfcHV0OyBjbGtfZ2V0IG9uIGxpbmUgMTc2NyBhbmQgZXhlY3V0aW9uIHZpYSBjb25k
aXRpb25hbCBvbiBsaW5lIDE3NzUKLi9kcml2ZXJzL3R0eS9zZXJpYWwvYmNtNjN4eF91YXJ0LmM6
ODUxOjItODogRVJST1I6IG1pc3NpbmcgY2xrX3B1dDsgY2xrX2dldCBvbiBsaW5lIDg0NiBhbmQg
ZXhlY3V0aW9uIHZpYSBjb25kaXRpb25hbCBvbiBsaW5lIDg1MAoKCkkgaGF2ZSBnb3QgdGhlIGlt
cHJlc3Npb24gdGhhdCBmYWxzZSBwb3NpdGl2ZXMgYXJlIHJlcG9ydGVkIGZvcgp0aGUgaW1wbGVt
ZW50YXRpb25zIG9mIHRoZSBmdW5jdGlvbnMg4oCcc3lzY19jaGlsZF9hZGRfbmFtZWRfY2xvY2vi
gJ0KYW5kIOKAnGJjbV91YXJ0X3Byb2Jl4oCdIHNvIGZhciBiZWNhdXNlIHZhcmlhYmxlIGFzc2ln
bm1lbnQgZXhjbHVzaW9ucwp3ZXJlIG5vdCBzcGVjaWZpZWQgYXMgd2hlbiBjb25zdHJhaW50cyBm
b3IgdGhlIGludm9sdmVkIHNjcmlwdApmb3IgdGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdlLgpo
dHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS40LXJjNS9zb3VyY2UvZHJpdmVycy9i
dXMvdGktc3lzYy5jI0wxNzg0Cmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjQt
cmM1L3NvdXJjZS9kcml2ZXJzL3R0eS9zZXJpYWwvYmNtNjN4eF91YXJ0LmMjTDgxMQoKSG93IGRv
IHlvdSB0aGluayBhYm91dCBpdD8KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvc2NyaXB0cy9jb2NjaW5lbGxlL2Zy
ZWUvY2xrX3B1dC5jb2NjaT9pZD0yNmJjNjcyMTM0MjQxYTA4MGE4M2IyYWI5YWE4YWJlZGU4ZDMw
ZTFjI24yCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpo
dHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
