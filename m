Return-Path: <SRS0=EMux=RG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55F4C43381
	for <cocci@archiver.kernel.org>; Sun,  3 Mar 2019 17:01:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7EC62070B
	for <cocci@archiver.kernel.org>; Sun,  3 Mar 2019 17:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="qvggzn78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EC62070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x23H1Fv9008263
          ; Sun, 3 Mar 2019 18:01:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DC0217654;
	Sun,  3 Mar 2019 18:01:14 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2E2D13ACF
 for <cocci@systeme.lip6.fr>; Sun,  3 Mar 2019 18:01:13 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x23H1BjV010666
 for <cocci@systeme.lip6.fr>; Sun, 3 Mar 2019 18:01:11 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1551632471;
 bh=MVJANlj/zKWbE/vrbr6VgBqNvZLrEnLb0cf9Q3a91jE=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=qvggzn784Oz2tYYVrqJwH6oC0zFfnXWbq5UufqzZGyWeN5m5QCU1PHu8rmANVnQyT
 TkSV8nsOY5NHlQnEC9IqUfJCkZTmcpveSDDTA2MdEgltnN/zSfQYFsqG+uIxiQQG60
 A3/lEwBDFmz/S9zr/a5O40psMizmpMVgRk4/2gW0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.130.197]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LZvrx-1hO28o12dx-00lp08 for
 <cocci@systeme.lip6.fr>; Sun, 03 Mar 2019 18:01:11 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1a6012be-719c-a970-9e9f-8dc4c0a4f09c@web.de>
Date: Sun, 3 Mar 2019 18:01:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:8AaXTIDqlU7tdj6C1un4zk0pZLzwwk3yVIg38PuxBVdDhuSV0FO
 VwgDh5dQbBnJdZ1BHp1ObFqypwuVWi+hmS+a+LRr5uuKbrOXhX0Vb4I/A6W3bPV4BH8IxiG
 weya3eqxgpvIEChvRhq4smQfVcFe2eDz3/R0FOZITQr3VfrOU2OmrpokwFHUtpNR7fqko19
 lRMsqqQFztHLeN47336Bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:onIMX4FABS0=:h910fadkK7fCYNcG4aA5RS
 C9G1i37CZzQ2oyrZmqdJTChhRlQPg2avd2ZDFUKgZwrmFWLHgEIiLz06WZCIXtej35M/LF9/u
 qhIMUCoKdkxsI4sqfHMNxNvAqoB+MuIFksct16XqchTigb//ppJcGJhDiQOId+79F8yKOmqrH
 eiMbcKAlQ7FkaIEbYPiTykfHzo6jL5i/eFDwQcSrVdvUt0IY2kdWkh0o6fHQWWEbzHmQSmEk7
 l/xmv1qbVygW/1eEVHHZb1jRXEQWMFV8IWxuTEhEfOoPghpyJH2WRqFlnp0aX7xecoTqUVpgX
 f8Bro77ysi9jH73lZh2fp2Q4/ZLBd3o8TeX8yZyzdsXq5VmU+ILny8L0VJlFK1TpLpMkd/686
 HJgaUtw9aF04pQ2sHJ+Owqq2A1AzuT39HwYeaJOiyjqSMNd0Lk62/nrcBbM1DqQyqJtzpy5vz
 cuOucT5d3SF5IwENHN1hReCxy29XcnhzVd/5VplSVJF5feUayhwTujZsZfX9Sz6bU+m/BWyzm
 x5P11fP46ExdTZDj3CagoLuM6baCagod32vfGaikM4MDc8haKlXIaXij/RfZlgwWIQsZ6jUWP
 tP50WgX7iBsrikn4BlMrODCp6OqdAHS0lpuQnSwVrzqE/jHGN63Tld18S++pmDR/7IRfy0ptj
 dzq4r3TS5/kUM9zs95GMh0SBokKzlp/i54inngtqFYShnh35SeCO2B56LbFFN8qip3GltPp2J
 j8WGi3IFksm5SaHhFn4JlhKKKks6XvHBuU4iXVu3nHf7rwhIDBALHBo6gSyiu3kMOcnOY3VBE
 ey1t7vG9nN50DN9Coc3Kap32rvUGZNsTQrn8UHNsXMAwhgTWEj6xKwwbC+i3+5d1Y4zlKnC6R
 GCN1aYJ+aBFJgJ8vqH5Gt0eh+LedpcMvubS1xQSGP/JrJeVLq0DtRo+YjNkP4wA8G2/6zcMRC
 c/VNUciMQ/g==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 03 Mar 2019 18:01:15 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 03 Mar 2019 18:01:11 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking varying accesses to members of local variables
	with SmPL
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

SGVsbG8sCgpUaGUgZm9sbG93aW5nIGluZm9ybWF0aW9uIGlzIHByb3ZpZGVkIGluIHRoZSBtYW51
YWwgZm9yIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZS4KCuKAnEEgbWV0YXZhcmlhYmxlIGRl
Y2xhcmF0aW9uIGxvY2FsIGlkZXhwcmVzc2lvbiB2IG1lYW5zIHRoYXQgdiBpcyBhbiBleHByZXNz
aW9uCnRoYXQgaXMgcmVzdHJpY3RlZCB0byBiZSBhIGxvY2FsIHZhcmlhYmxlLiDigKYgQSBtb3Jl
IGNvbXBsZXggZGVzY3JpcHRpb24gb2YKYSBsb2NhdGlvbiwgc3VjaCBhcyBhLT5iIGlzIGNvbnNp
ZGVyZWQgdG8gYmUgYW4gZXhwcmVzc2lvbiwgbm90IGFuIGlkZXhwcmVzc2lvbi7igJ0KaHR0cHM6
Ly9naXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxsZS9ibG9iLzE0Y2U5NGFiNDgwNWY3MDQw
NTUyNTgyOWI1ZTExZWE1NWY2ZjFkMWIvZG9jcy9tYW51YWwvY29jY2lfc3ludGF4LnRleCNMMjgx
CgpJIHdvdWxkIGV4cGVjdCB0aGF0IGEgbG9jYWwgdmFyaWFibGUgY2FuIHJlZmVyIGFsc28gdG8g
YSBkZXRhaWxlZCBkYXRhIHN0cnVjdHVyZQooaW5zdGVhZCBvZiBtb3N0bHkgdXNpbmcgc2ltcGxl
IGRhdGEgdHlwZXMpLgoKKiBDYW4gaXQgYmVjb21lIGludGVyZXN0aW5nIHRoZW4gaG93IHRoZSBh
Y2Nlc3MgdG8gdmFyeWluZyBtZW1iZXJzIGZyb20gc3VjaAogIGEgZGF0YSBzdHJ1Y3R1cmUgaGll
cmFyY2h5IHdpbGwgYmUgc3BlY2lmaWVkIGluIHRoZSBTbVBMIHNjcmlwdD8KCiogSXMgdGhlIHNw
ZWNpZmljYXRpb24gb2YgYW4gYWNjZXNzIGFwcHJvYWNoIHBvc3NpYmxlIHdoaWNoIHdvdWxkIGJl
IGluZGVwZW5kZW50CiAgZnJvbSB0aGUgbmVzdGluZyBsZXZlbD8KClJlZ2FyZHMsCk1hcmt1cwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWls
aW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21h
aWxtYW4vbGlzdGluZm8vY29jY2kK
