Return-Path: <SRS0=hgwh=XT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F60C432C2
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 15:28:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE8F20665
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 15:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="AdaEDwB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE8F20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OFSDqR015045;
	Tue, 24 Sep 2019 17:28:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A6DA177AB;
	Tue, 24 Sep 2019 17:28:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6F8E6779E
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 17:28:11 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OFSAnT021891;
 Tue, 24 Sep 2019 17:28:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569338890;
 bh=8Iq7QyiGDVB4fXffBMtx+oJWppRDP7TU9XBtLR6f40g=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=AdaEDwB+rzEu8nVgc3xjBq6kruLbzy82N/l6yb9vr/zowgWr2mmyEjtbyu65KVJtq
 R/P8cx05oZxfomirQvgy7K4GWhzhbWywi32yn3a/az+s7SguODNs7iapDk62ZrRokc
 uiRIRnKvR8AVsLyAGemkEr2ZeUm8O6rTfys84lC8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.71.162]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LlniO-1hdj221wJ6-00ZMgP; Tue, 24
 Sep 2019 17:28:10 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c4437d9b-8795-fdfa-7914-fc30ead14cf7@web.de>
Date: Tue, 24 Sep 2019 17:27:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909231058380.2283@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:SgPywZO7tpZLulnQkEKxOtfWukKyx+h46joXTCPJ/Tyu7RLBEWz
 rzgGgBDADjVQK9jJ7hzuYMTXXuYEwDOg63F1Wqzgkehv1E2Bm/NEFbskmJE6p2Jd2stciZ8
 DuVarrE2dtho5krjSSGxcm5Tm6fTDVBLSyNQJ51mmMx7R0FZrNKGTTx6S3+3E5xq59p51Lc
 xGbTjIRhaHBUySc9d5M6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B8QKHMcV/YM=:GnJ4n4WJNGFA5JvyhPJDuq
 S12ALUTz/oFRcL9RfXXMZO2dFthLCRxV/te+NxerVTWOV4zcOEVW5Tr8IYHGQxaQJRIZ+89A+
 9ht1ncfn5Cq4FVZFRDza3RoX1dTHl6hYD+EcBfjPh7iHXk/FeKporwitVCC3ewDfzVuBNn67D
 d7ZRfqlAI02GJeejsEgGiTooBtEPCZZV4YJICPrS4s3CQHnO7b30ipMchWs/56omiv61gq7q6
 UtB8+nAAxuuWKQHjA1vOZyylGn6Sq3ps5ng9LF+Kn3/tAM7n7/2fn4pxXcR15Rgz812K1wRzN
 dANdC3umYIoXj1hMaeZN4J3ObKp4EDQcoCXkI0O14QQnzHh8mKSho4roizVGX7XVLnY9KjWHT
 O8CHPllOfM4cNVNQjzk7vlAHo+z0pzRRZ/hg7Y1DhWTz6amXz8PvMW+MKdPKto/qeOCzd0Pq8
 JX3H41kThVp5oyPLn0/LT13AWw7qNb4wt/0NYVbaV9eRfzyQ930WRStNN4+qvoINtFISAjnEx
 gxeVeXOXTpIiWDDtg9+eVXcfov6qqOf3u8OLQjvhD15+6pylN3hwDxy7F564TiDbQ/msbgn+6
 z3ga4RPNEwC6eOy6EYQVfz2WZkEoUedtEb/qWCdiux4mlj96ehUr+4x/aq8iIUEwI5gJRrCUq
 0E1ShmZfdpbVbfUYLqSFXdzl5Pbn/M8XO73LL79YNoOrDErzC+ZUScRcrtaQ+X2wvW7TJ2Lrx
 Rr6wqEAWBddfy74UPqytOAbxSUJ0zHpHMDeSlRS9+RFMvYQ1IDd265jSo3C1MBbQ3LUG9y3IU
 GJelUrxK8KKWXBKbBpiRITrdWysZa99NjnvjvDeGn+BdnwBOWyWGggOn+3QLzGi1tAd7gz5GG
 vVe8gCeNCEAXd3nf/L9lK6wFfZVgRXf4pBa3JQ8UzGWDLBmOnSYaQjlEQuJCkXt+A4qAvwZap
 uYgFtr+h+mdzKlIp8tUKjOaxb9Y3VwEG1Dma7k09eksC1VCN5S1mvWDlIelsrPZFH+2ZFQ75x
 zgT5otloyFRMU7+irbpy/bhvp+vuRC5cTQPFa+90h2WrBN0Nn7gs3noYNBItY1QR1AIoqEldu
 X558jch0n9CThuQYkWOlVMPThZZHwTCIv6iPY8KAhtPTU5q+9BuEBq79CUsLiEUffxujTDdXs
 N2aLPT3GhD9Byi3W+q+9+cf4TPKMlu5kjfFWP+aYspvgrJDZ7plhVWQrlBIKNHjAYsV5LteEa
 x4A9EhPXHn2Gh/NtItAf61tfF2KkdD4rnIbUDgkH78abggkG1rYg7vBuTvcM=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 17:28:14 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 17:28:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reducing source code around return statements with SmPL?
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

Pj4gQEAKPj4gLXJjID0geDsKPgo+IFJlcGxhY2UgYnkgLSBscmNAcmMgPSB4OwoKSSBoYXZlIGNv
bnN0cnVjdGVkIHRoZSBmb2xsb3dpbmcgdGVzdCBzY3JpcHQgZm9yIHRoZSBzZW1hbnRpYyBwYXRj
aCBsYW5ndWFnZS4KCkBjaGVjazFACmV4cHJlc3Npb24geDsKaWRlbnRpZmllciByYzsKbG9jYWwg
aWRleHByZXNzaW9uIGxyYzsKcG9zaXRpb24gcDsKQEAKIGxyY0ByYyA9IHhAcDsKIHJldHVybiBs
cmM7CgpAY2hlY2syQAppZGVudGlmaWVyIGNoZWNrMS5yYzsKcG9zaXRpb24gcDsKdHlwZSB0OwpA
QAogdCByY0BwOwogLi4uIHdoZW4gIT0gcmMKCkBzY3JpcHQ6cHl0aG9uIHRvX2RvMUAKcCA8PCBj
aGVjazEucDsKQEAKY29jY2lsaWIub3JnLnByaW50X3RvZG8ocFswXSwKICAgICAgICAgICAgICAg
ICAgICAgICAgIldBUk5JTkc6IEFuIGV4cHJlc3Npb24gd2FzIGFzc2lnbmVkIHRvIGEgbG9jYWwg
dmFyaWFibGUgYmVmb3JlIGl0IHdpbGwgYmUgcmV0dXJuZWQgYnkgdGhlIHN1YnNlcXVlbnQgc3Rh
dGVtZW50LiIpCgpAc2NyaXB0OnB5dGhvbiB0b19kbzJACnAgPDwgY2hlY2syLnA7CnYgPDwgY2hl
Y2syLnJjOwpAQApjb2NjaWxpYi5vcmcucHJpbnRfdG9kbyhwWzBdLAogICAgICAgICAgICAgICAg
ICAgICAgICAiSU5GTzogTWF5IHRoZSBsb2NhbCB2YXJpYWJsZSBcIiIKICAgICAgICAgICAgICAg
ICAgICAgICAgKyB2CiAgICAgICAgICAgICAgICAgICAgICAgICsgIlwiIGJlIGRlbGV0ZWQ/IikK
CgpJIHdvbmRlciBhYm91dCBhIGNvcnJlc3BvbmRpbmcgdGVzdCByZXN1bHQuCgplbGZyaW5nQFNv
bm5lOn4vUHJvamVrdGUvQ29jY2luZWxsZS9qYW5pdG9yPiBzcGF0Y2ggLS1wYXJzZS1jb2NjaSBt
b3ZlX2NvZGVfdG9fcmV0dXJuMS5jb2NjaQrigKYKc2NyaXB0bWV0YTogc2VtYW50aWMgZXJyb3I6
IGJhZCBydWxlIGNoZWNrMiBvciBiYWQgdmFyaWFibGUgcmMKICBGaWxlICJtb3ZlX2NvZGVfdG9f
cmV0dXJuMS5jb2NjaSIsIGxpbmUgMjYsIGNvbHVtbiAxNCwgY2hhcnBvcyA9IDQ3NAogIGFyb3Vu
ZCA9ICc7JywKICB3aG9sZSBjb250ZW50ID0gdiA8PCBjaGVjazIucmM7CgoKSSBpbWFnaW5lIHRo
YXQgaXQgd291bGQgYmUgZWFzaWVyIHRvIHVuZGVyc3RhbmQgdGhhdCB0aGUgY29udGVudCBmcm9t
CnRoZSBpbmhlcml0ZWQgbWV0YXZhcmlhYmxlIGNhbiBiZSBkaXJlY3RseSB1c2VkLgpUaGUgU21Q
TCBzcGVjaWZpY2F0aW9uIOKAnHYgPDwgY2hlY2sxLnJjO+KAnSBnZXRzIGFjY2VwdGVkIGJ5IENv
Y2NpbmVsbGUgc29mdHdhcmUKYW5kIHNlZW1zIHRvIHdvcmsgdGhlbiBpbiB0aGUgd2F5IEkgd291
bGQgZXhwZWN0IGl0IGFsc28gZm9yIHRoZSBvdGhlciBzY3JpcHQgdmFyaWFudC4KV2lsbCBhbnkg
bW9yZSBhZGp1c3RtZW50cyBiZWNvbWUgcmVsZXZhbnQgZm9yIHN1Y2ggYSBzb3VyY2UgY29kZSBz
ZWFyY2ggYXBwcm9hY2g/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUu
bGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
