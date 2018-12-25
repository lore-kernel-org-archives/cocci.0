Return-Path: <SRS0=i97o=PC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2492C43387
	for <cocci@archiver.kernel.org>; Tue, 25 Dec 2018 13:43:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1308D217D4
	for <cocci@archiver.kernel.org>; Tue, 25 Dec 2018 13:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="DEFg+62W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1308D217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBPDhWeb027011
          ; Tue, 25 Dec 2018 14:43:32 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8F8BF76DC;
	Tue, 25 Dec 2018 14:43:32 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7729D60D7
 for <cocci@systeme.lip6.fr>; Tue, 25 Dec 2018 14:40:29 +0100 (CET)
Received: from mout-xforward.web.de (mout-xforward.web.de [82.165.159.2])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBPDeTsj011304
 for <cocci@systeme.lip6.fr>; Tue, 25 Dec 2018 14:40:29 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1545745228;
 bh=MyQ77h847vRgzY8tXOWEBS++rmtjqq702w8CUuaer1s=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=DEFg+62WCOiC4h8Dz9G169rixWLhKe5cYCE9jt1fFC6hkzXfNiFSgOGq9VUtIt6pe
 UjgOYtk695jID/WhzGnMGmkU74YlC0n5YjFRnbBA5mX5WN/Rf2zDloruhU/4UKZQs2
 I73V6Y77jgJtFnPvm21ZaTnioFEFlH/93JTwy+oA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.26.192]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LxJVq-1hPzra2p9G-016xSd for
 <cocci@systeme.lip6.fr>; Tue, 25 Dec 2018 14:40:28 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <61e8d3e3-e445-fc51-a9cc-c982dbb73bdb@users.sourceforge.net>
Date: Tue, 25 Dec 2018 14:40:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:MTLC8mFny1iBaDjnEPgC5HoQdY903nNR6kq6RGkXe7S8zqpTYcF
 Si5IbL90EzmQIvgO/FoFeydQQM6YjOvzoOOQ/R40uNM5AWe9LUwcyON0rbLgh47+rNzUHts
 OWCOxcstKmE575HGpHB8pc+mvqoUsgybE0yFn08kfyMIzjYVY0uRA7yNllZRJcPyzRNUeFG
 9ohEJ20+x6Us1jBwdu0fQ==
X-UI-Out-Filterresults: junk:10;V03:K0:34Vgo83mm/I=:ep/fSslBr5lH83I2njbHUemf
 MQ7XI7lKMfARPrywprB5TPPB2rUzFLamOcy2mClFo1x46JfPYCT9nJBiIgdXh/GCbVCDw6cZy
 H+dZGUgaSYFWSPz3zujzJlpSlNY7fkqIfqT25VubZOh8q5yZPqmDQlRKuVKsoPbFiSaSGCluf
 xaQBCxPHE+Cqg2rul1D6eJ7D3JFwASXU0jMb9EOM1smF2BOKnC2U3ckLW1ffbYDVosDI6QF8j
 NASkwmTrqtxh4QpbOfY27YHIKN+FYyaGGuQ9dv7QY2I40cEoOfFWTs+No2LeR9RmB6qQHgfcb
 dUCD8+jJgDwzAgMgk/f5ix6yVVdjJ/b3oZCY4/LVA0SK3CeReS7C/J2d8EpUPL1lrQZmA/wns
 hq/xx2rK+6brV39AOn9YCZPBajBvdx1AZAsAtpV4uq31Bv1VsmjZj5noAdipJArW2cDbelxgF
 qGYR02YrcByTYHKJtmfW6yAkGLocgHFv2HytRQdfJLoc8aBciWB8h9GF1xYje7dFjkoNUYdyb
 XAMbLgAqRZ9O/YnbOelSR6ASvhLRRzUk2+1ovRR9jV5ASjhNJJZ5tpMhCzIN6wXoPpSkkdEwX
 B/EPaVDqbIepR0/Ml+8MzTXNHqYzLHCIQdOdoIutEnEQFklOMXcI1TeylEIK2IRkLVVCJoFQR
 ypJWkTN2DTKllP8bcyfa656dEuE58nssRNtQ7xOpFMSQ4fOxnFrg4ubeKGHttYCHXlPc/OAxB
 Pn4EzR8OTbjzhrTXU7pTOVu8YaO9+xip91zFLFJPkVTCVgoAh1X19+7oqdQbu0Rcr25+qzW3G
 8dNcYwie0/O9cx3asH4+wnRhnNlF3Wa1aLt+Ri2IIe4UmzkZ+U/HhjR0LZXPIEwIHwL/nQtx5
 SUL9zQqmxXv9LiADjxQvk0RiL3Xzth7zPIyZLdchd1Hhglfg2fobnVwXyqB/VWZ7A6R1fEx99
 nFi0R0RioT+MHk9zmCy9yd/fP7Ko+3Bz/fLuYsdVMXM56lnZhjWcACWZMNbZR4uv5S8WgVPX4
 W/ZNYMF/OohPHy47GQoB7zOOomMoo7+bPTUWoD1NxnOk8OxUOQ9RfH9jfOS3ucPA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 25 Dec 2018 14:43:33 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 25 Dec 2018 14:40:29 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 25 Dec 2018 14:43:31 +0100
Subject: [Cocci] Deleting unused declarations for variables with SmPL?
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgYW5vdGhlciBzaW1wbGUgc2NyaXB0IG91dCBmb3IgdGhlIHNl
bWFudGljIHBhdGNoIGxhbmd1YWdlLgoKQGRlbGV0aW9uQAppZGVudGlmaWVyIHg7CnR5cGUgdDsK
QEAKLXQgeDsKIC4uLiB3aGVuICE9IHgKCgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvTGludXgv
bmV4dC1wYXRjaGVkPiBzcGF0Y2ggfi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL1Byb2JlL2RlbGV0ZV91
bnVzZWRfdmFyaWFibGUxLmNvY2NpIGluaXQvbWFpbi5jCuKApgpAQCAtMTAxLDIyICsxMDEsNiBA
QAogCiAjZGVmaW5lIENSRUFURV9UUkFDRV9QT0lOVFMKICNpbmNsdWRlIDx0cmFjZS9ldmVudHMv
aW5pdGNhbGwuaD4KLQotc3RhdGljIGludCBrZXJuZWxfaW5pdCh2b2lkICopOwotCi1leHRlcm4g
dm9pZCBpbml0X0lSUSh2b2lkKTsK4oCmCgoKTm93IEkgd29uZGVyIGFib3V0IHRoZSBnZW5lcmF0
ZWQgY2hhbmdlIHN1Z2dlc3Rpb25zLgpEb2VzIHN1Y2ggYSB0cmFuc2Zvcm1hdGlvbiBhcHByb2Fj
aCBuZWVkIGFueSBleHRlbnNpb25zIGZvciB0aGUgc2FmZSBoYW5kbGluZwpvZiBmdW5jdGlvbiBk
ZWNsYXJhdGlvbnM/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlw
Ni5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
