Return-Path: <SRS0=CDLA=S3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E487C10F03
	for <cocci@archiver.kernel.org>; Thu, 25 Apr 2019 10:32:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 400C82084B
	for <cocci@archiver.kernel.org>; Thu, 25 Apr 2019 10:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="kJRR2O+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400C82084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3PAW6Ed029499
          ; Thu, 25 Apr 2019 12:32:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 22FC5773E;
	Thu, 25 Apr 2019 12:32:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 18356773D
 for <cocci@systeme.lip6.fr>; Thu, 25 Apr 2019 12:32:05 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3PAW418015503
 ; Thu, 25 Apr 2019 12:32:04 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1556188324;
 bh=qC9SK6QOzshk9LSGXRtkDFRrsB0/CcoZeFyg6oFbnMQ=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=kJRR2O+tyAOZSPQPy1hxMn5NBTyfFvZxQKU5Vlz6Wl746ldCJ4ZeNIfl1kOoSnYay
 ZbzTr/cr5LIb9FpPFlmtQmJPw8CHsBKaEZO483LsNrfsHdYWGAKtL5GRgSmg/bp3N4
 +/6WDvnLylV+8LDiQKBfcIAUUtPC4Ax5zZNmO45o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.179.241]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqUan-1goPis3kSf-00e241; Thu, 25
 Apr 2019 12:32:04 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <bed744fe-5c5c-cf28-f8b2-40a487709010@web.de>
 <30df39b4-6f45-45c7-1c37-1f8991f3f6e2@web.de>
 <alpine.DEB.2.21.1904251039000.2550@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2f138dc8-74cd-3766-cc78-c4bace8579c0@web.de>
Date: Thu, 25 Apr 2019 12:32:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904251039000.2550@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:/+xHJLgPRPC5fpS0WOvli2FZh2tHV3AMYVTnt3Mhx1D+ckRk0qo
 0mrHnNgt4Y2UsENk4ICnwA/PMYKTgNjcXLxkyDUsknZxkzUscDBrxbTytfB0Mrw68aatqoe
 N7mRcsWvVjyaRvx98d7W5eVILFc7wCPs/dCaPnzHRAYwIfTBxts3TX+DXOr70asR2ODPQL7
 r0mBRWvKgnItc5Bkv06mQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8PzlxAzYhzw=:wqHlMhA0sJdSygsW0R1wWf
 04kdi37gSKDjbmgSuPDPBvwNBOhQZtDMV7tf3TRO7LZMbbXvgKFHXcv6yS30jSUhOeNhIS5Uw
 w8E3Lw44V21Zg1SG3MVsq2EWWVB1xQtwiD4BwTb2LWd5EZn0XGZIR4LNaW1Kw+l4YJVM4eVtP
 E00z+60QsqbMMMefLoHuspwUGcqGVvWABginNuDeR1O4tofRpHnUQjIhnpHbzk6FSB/ib77Mn
 gBNsf0z7eS2BlIhbnFPlGnLfGKq91DvV7c0LkLsIy7HLItiOOOiM2ysW8BSBHrTuFwyENbZit
 3UEKUJljYDjbaZjjvv/Gj+amxUr9FyWvSxHEm7r0aQUlCYGKpYgLvw1jtrJyE0CnZngWT7C1g
 NQqOtyxnlFWmFP8VA/Th1q3KoaQOk4cOUCYxaTSsONez4Ma9igI6YVyxNQFq2Rs4rD4vwE5ZD
 Lg8zWk5BEpy9+FS7rqnR1Rt8O/bvBd2+ChYxY+Kfpvbx+VRkEJH7m6Bfzc2jPc+NR7/TbjhUt
 tx3leP9c2TpqJEKsY+d5K0WazW8Rj3Rtpspu1UYbngt+DTK6TPiMexmwG2XnPpDG1FATn4N6g
 OoN5HcStxLJaV0d5F/frq2HXznkTUe4nIQPNIEvt7AAYF0SH5Rl1xmW7nVgbUYLpA0FWrIuSZ
 xac1XJycYUCQz3+Y8lHzgTtenOYX3l+b94n5QrTU8toQLJlEk85HjaG8BWKbCLcLdDkpXxn1h
 vxG3n60DBVlEOQ01rIntxANahwNAjnZTZNwUHT+4nZNcU+Sg2cgOHo3UCN0NzxAKh+i1sKoG0
 huAxjfHB+T+8NXzMqzdBIg2yFCFJJDSsut/ZwOj8nZV+085rEcTP7j3c8GHqAfc/RRUOpmM5Q
 Wa63La1X+roeA89I8jv5okpVGUXEfNbDnqeEdshkglR+fsnQtRxp865aHEyFuqecwh3BFKl28
 Wqa5VVDBZGw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 25 Apr 2019 12:32:06 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 25 Apr 2019 12:32:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Data exchange over network interfaces by SmPL scripts
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

Pj4gICBGaWxlICI8c3RyaW5nPiIsIGxpbmUgMzQsIGluIHN0b3JlX3N0YXRlbWVudHMKPj4gQXR0
cmlidXRlRXJyb3I6IF9fZXhpdF9fCj4+IEVycm9yIGluIFB5dGhvbiBzY3JpcHQsIGxpbmUgNTUs
IGZpbGUg4oCmCj4KPiBJIGhhdmUgbm8gaWRlYS4gIEl0IGxvb2tzIGxpa2UgYSBweXRob24gcHJv
YmxlbS4KClBhcnRseSwgeWVzIChvZiBjb3Vyc2UpLgoKCj4gSWYgeW91IHdhbnQgaGVscCwgeW91
IHdpbGwgaGF2ZSB0byBjb25zdHJ1Y3QgYSBzY3JpcHQKPiB0aGF0IGV4aGliaXRzIHRoZSBlcnJv
ciB3aXRoIHByaW50IHN0YXRlbWVudHMgb25seS4KClRoaXMgc3VnZ2VzdGlvbiB3aWxsIHByb2Jh
Ymx5IG5vdCB3b3JrIChiZWNhdXNlIGFkZGl0aW9uYWwgdGVzdCBvdXRwdXQKd2lsbCBub3QgdHJp
Z2dlciB0aGUgc2hvd24gZXJyb3IgcmVzcG9uc2UgYWxvbmUuKQoKSSBzZWUgc29sdXRpb24gY2hh
bGxlbmdlcyBsaWtlIHRoZSBmb2xsb3dpbmcgYWZ0ZXIgdGhlIGFkZGl0aW9uIG9mIGFub3RoZXIg
ZGF0YQp0eXBlIGNvbnZlcnNpb24gZm9yIHRoZSBuZXR3b3JrIHNlcnZpY2UgcG9ydCB2YXJpYWJs
ZS4KCmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL2phbml0b3I+IC91c3IvbG9j
YWwvYmluL3NwYXRjaCAtLXB5dGhvbiAvdXNyL2Jpbi9weXRob24zIC1EIHNlcnZlcl9pZD0xMjcu
MC4wLjEgLUQgc2VydmVyX3BvcnQ9MTIzNCBsaXN0X2R1cGxpY2F0ZV9zdGF0ZW1lbnRfcGFpcnNf
ZnJvbV9pZl9icmFuY2hlcy1jbGllbnQyLmNvY2NpIH4vUHJvamVrdGUvTGludXgvbmV4dC1wYXRj
aGVkL2RyaXZlcnMvbWVkaWEvZHZiLWZyb250ZW5kcy9zdHYwMjk3LmMK4oCmClVzaW5nIFB5dGhv
biB2ZXJzaW9uOgozLjcuMiAoZGVmYXVsdCwgRGVjIDMwIDIwMTgsIDE2OjE4OjE1KSBbR0NDXQri
gKYKY29ubmVjdGluZwpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAi
PHN0cmluZz4iLCBsaW5lIDQsIGluIDxtb2R1bGU+CiAgRmlsZSAiPHN0cmluZz4iLCBsaW5lIDM1
LCBpbiBzdG9yZV9zdGF0ZW1lbnRzCnNvY2tldC5nYWllcnJvcjogW0Vycm5vIC0yXSBOYW1lIG9y
IHNlcnZpY2Ugbm90IGtub3duCkVycm9yIGluIFB5dGhvbiBzY3JpcHQsIGxpbmUgNTYsIGZpbGUg
4oCmCgoKSG93IHNob3VsZCB0aGUgc3lzdGVtIGNvbmZpZ3VyYXRpb24gZGV0YWlscyBiZSBpbXBy
b3ZlZCBmb3IgYSBzaW1wbGUgdGVzdCBjb25uZWN0aW9uPwoKUmVnYXJkcywKTWFya3VzCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcg
bGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1h
bi9saXN0aW5mby9jb2NjaQo=
