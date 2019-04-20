Return-Path: <SRS0=4SgN=SW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763D5C282DD
	for <cocci@archiver.kernel.org>; Sat, 20 Apr 2019 18:51:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD47208C0
	for <cocci@archiver.kernel.org>; Sat, 20 Apr 2019 18:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="MJeepMZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD47208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3KIpHv4010088
          ; Sat, 20 Apr 2019 20:51:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0D162772E;
	Sat, 20 Apr 2019 20:51:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B73227725
 for <cocci@systeme.lip6.fr>; Sat, 20 Apr 2019 20:51:15 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3KIpFhi005434
 for <cocci@systeme.lip6.fr>; Sat, 20 Apr 2019 20:51:15 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1555786274;
 bh=R+6ldolwrsZDCyy7lXXSctziytHO3U13sPInozg7YJk=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=MJeepMZWtTPGuSIDGop0YmWS7WELyoqOsa/PoLCIk5k9F1mZzjt/Ozp6mdMwc7nEj
 xdS2fIVEHPvDbKb+ay1bNyNbwpWYrB6DzhDQCKjRbOdxy+y6Bbiy5Nb6LrIoUnIbpC
 nRGrLvTDXASm3wItV6q5MVCzQTxGmcRpi9jPcnZ4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.4.177]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MLDEn-1hHe672FBh-000Ho0 for
 <cocci@systeme.lip6.fr>; Sat, 20 Apr 2019 20:51:14 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <bed744fe-5c5c-cf28-f8b2-40a487709010@web.de>
Date: Sat, 20 Apr 2019 20:50:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:3fv+a8jOy4twHsvZS1LGn8wrvToyDT2TXqr9BuTcZ2fyx2jpEWJ
 BljBHpZhllQH5wAF0fAaolpf2y+ObBnsNzP+J9twFxyMrFJiUkYg2y2zFfzhNJQLdAEsHSg
 GfyxxQw1gi9hhsYz1NGXuMHGRmYd8w59s8MMT3qNnNKaHvfZ8sgWyi1fOhuefg/XIGaP9SM
 W2Aset5XvFXyi1/B8SpFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YvMQBMGfEFI=:VTCg2zOwJ58Pls1FOwaMFh
 yG0WKnM1Iwb14kdUuFj9y/Njbi8ySR8rqXcW668VUcINIDVe6y7hvtDjJHaUF3awIq28p82mk
 1TxO6UPfczmxKx7TtG2DZfphFMhFc+kS/otVoFXwij/CflKeTc16qMLUSIf/lBPEP34Q748dd
 EHpKjCyQTNPlH+WQxuHHgZjJGyCX8yarxid8TwEpPxLDXFpTGd8mgnkcKMTQEWvme3i1McnpG
 vTwpDsHUsN/Nnem18M0MANR1QXk7hta23enEReItMWM7MV3//dEyH1CFXaeAaw8N3jZyAJrJQ
 M/lZZ4ZPRych2qmTEf5Hzn+pPkJLThyMcZNexo1WDA0lDPDM3i0x6vLQrb0hwAu0un9K7YnPq
 KxFYI8YSAkGzONs7slM0S3M4itx0kKXSs/Y8aex26XioopMIQyQYBTwlmrYy0vlKUJrVOppE1
 +XodaF0F+FKqujUho0Vlq6eFFiwd+KUkB6KmGwdaF0irArAXKB0po2AK2jGiNSo26lq9UXvGs
 0+eHLtGzq8iwPiY+VVFP2+ztED/C4kIYDqJuRxX9v16IF5YQ/Hnek/Wd/Fs44ocAfcM9RzCEU
 +6VBLHaYXPmYnxyttHeJnLYYAuTnhGX1k3X3Kvx5Qnbixp/GlPQQPiZ+P9cs9aGQ5WJ1/0HDH
 Vxtgncbw60l6be/xwVxQM6TslynEtiKL6kAecIfMK+3hKdZNvuGEsakS/0CI5LvhmFaHJkF5n
 hiXbXmqXPiu39hMR9zAxSgXku/bHoJl8QHUNLEhF1+f8EWdXlm1AR9Sz8MI2k9HhOUH6jwFHk
 a4kAa32jfwzmKDA+MDsROgB2fkok9JgibdsDf7/1kq0Ed9RmmYKBplSWgGmKAjgqoRWpJsDGZ
 mPwYuJIx5T9BYBxjcGh3baKknNbLO4/+RsiJ5qt2vHXLa3B7dT2R+NUoGRrdYNHXiBTosQgvJ
 UIx7rwZVhxQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 20 Apr 2019 20:51:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 20 Apr 2019 20:51:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking import of code search results into a table by
 parallel SmPL data processing
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

SGVsbG8sCgpJIGhhdmUgbm90aWNlZCBhbm90aGVyIHF1ZXN0aW9uYWJsZSBzb2Z0d2FyZSBiZWhh
dmlvdXIgZHVyaW5nIHRoZSBhcHBsaWNhdGlvbgpvZiB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3Vh
Z2UuCgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvTGludXgvbmV4dC1wYXRjaGVkPiB0aW1lIHNw
YXRjaCAtLXRpbWVvdXQgMzQgLWogMiAtLWNodW5rc2l6ZSAxIC1EIGRhdGFiYXNlX1VSTD1wb3N0
Z3Jlc3FsK3BzeWNvcGcyOi8vL3BhcmFsbGVsX0RWQl9kdXBsaWNhdGVzIC0tZGlyIGRyaXZlcnMv
bWVkaWEvZHZiLWZyb250ZW5kcyAtLXNwLWZpbGUgfi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL2phbml0
b3IvbGlzdF9kdXBsaWNhdGVfc3RhdGVtZW50X3BhaXJzX2Zyb21faWZfYnJhbmNoZXM0LmNvY2Np
ID4gfi9Qcm9qZWt0ZS9CYXUvTGludXgvc2NyaXB0cy9Db2NjaW5lbGxlL2R1cGxpY2F0ZXMxL25l
eHQvMjAxOTA0MTgvcGFpci1EVkItcmVzdWx0cy50eHQgMj4gfi9Qcm9qZWt0ZS9CYXUvTGludXgv
c2NyaXB0cy9Db2NjaW5lbGxlL2R1cGxpY2F0ZXMxL25leHQvMjAxOTA0MTgvcGFpci1EVkItZXJy
b3JzLnR4dAoKcmVhbAk1bTU2LDcwOHMKdXNlcgkxMW00LDc3NXMKc3lzCTBtMCw2ODhzCgoKSSBr
bm93IGZyb20gbXkgcHJldmlvdXMgdXBkYXRlIHN1Z2dlc3Rpb24g4oCcW21lZGlhXSBVc2UgY29t
bW9uIGVycm9yIGhhbmRsaW5nIGNvZGUKaW4gMTkgZnVuY3Rpb25z4oCdIHRoYXQgY2hhbmdlIHBv
c3NpYmlsaXRpZXMgY2FuIGJlIGZvdW5kLgpodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC8zLzkv
ODIzCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvNTdlZjNhNTYtMjU3OC0xZDVmLTEyNjgt
MzQ4YjQ5YjBjNTczQHVzZXJzLnNvdXJjZWZvcmdlLm5ldC8KCgpCdXQgdGhlIGdlbmVyYXRlZCBs
b2cgZmlsZSBjb250YWlucyB0aGUgaW5mb3JtYXRpb24g4oCcTm8gcmVzdWx0IGZvciB0aGlzIGFu
YWx5c2lzIeKAnS4KSSB3b25kZXIgdGhlbiB3aHkgZGVzaXJlZCBkYXRhIHdlcmUgbm90IHN0b3Jl
ZCBpbiB0aGUgY29ycmVzcG9uZGluZyBkYXRhYmFzZSB0YWJsZQpieSBzdWNoIGEgU21QTCBzY3Jp
cHQgdmFyaWFudC4KCklzIHRoZXJlIHN0aWxsIGEgbmVlZCB0byBwZXJmb3JtIHBhcmFsbGVsaXNh
dGlvbiBmb3IgdGhlIG1lbnRpb25lZCBzb2Z0d2FyZQpjb21wb25lbnRzIGJ5IG90aGVyIGFwcHJv
YWNoZXM/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpo
dHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
