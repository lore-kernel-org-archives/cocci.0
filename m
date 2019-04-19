Return-Path: <SRS0=GUP7=SV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6E6C282DA
	for <cocci@archiver.kernel.org>; Fri, 19 Apr 2019 12:15:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1743C21925
	for <cocci@archiver.kernel.org>; Fri, 19 Apr 2019 12:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="U00ztrz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1743C21925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3JCFCTK023034
          ; Fri, 19 Apr 2019 14:15:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 421897740;
	Fri, 19 Apr 2019 14:15:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 79D73773E
 for <cocci@systeme.lip6.fr>; Fri, 19 Apr 2019 14:15:10 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3JCEs2j002450
 for <cocci@systeme.lip6.fr>; Fri, 19 Apr 2019 14:14:54 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1555676094;
 bh=bSUZ1woPhV1SL+Oso6O8m4MZdg4Aa24pBCwaguqI+TI=;
 h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
 b=U00ztrz26/bHDBOH+fUMHcz9YRX5HH7qW7vmrqzTfHasFOjM2X/4NIqkcqETzJB/L
 0a1NixvOaFDPCxSjuyq1F5wiMgV3ywKUDi485jBFJZgGOUFrLTRHmB0UDNCNzi2Te2
 o41xO6O/rhBHU68Bltjm3wrR1uUf99ULKZiPJdvM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.133.75.177]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBTEQ-1hAH8a1Qmc-00AS3k for
 <cocci@systeme.lip6.fr>; Fri, 19 Apr 2019 14:14:54 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
References: <8d40a536-c2fe-7d6b-58d5-840e013665f1@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <11a0c402-265c-4bc1-9cdd-244735dbc3e1@web.de>
Date: Fri, 19 Apr 2019 14:14:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8d40a536-c2fe-7d6b-58d5-840e013665f1@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:T68hL/tXKIyMH2EDyLOWT22ZUcDIAXLX4roIfKg0U4rKHdNcYjq
 278+yxnemoH326lioEEZGouCkkZwagfmnzlns04KS29TMjiykK8zivIKpTG4MYcrkXjG+fu
 k8jOGCT3oBmUeeVkX6PyFb1785oHlg8UdM+aBZlX3VWwixWmWT0P/7bH6CpcUIk2TeQzsBe
 Y7b/LVwq9hCXkn2ud038g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qkQ2PkEIfDQ=:UxLamxJYK48IJZX2TB7++T
 +cUTjJwuK6Bp7PemFXTBYezWBYHdgfV7L2Mk4yTaW9dqb63Ss57aJl52eOqYmpdWXaRYOwp/E
 obG9WvLEiDCUIN1H42tgfADwRa/eeChwXfqS3k69K/JcFhKdZy2HkUse98Q7c1lpEQo5FtthH
 qAnBIxAI0uU/ty7RR9fdTXt8pArS+qFdI5LFz217hIFhWrdqQRc9YSM5BVF8XDN7feik250zy
 3FA6o3PxfH40EUI0hh6chBKXMDhbCcmI1i9qdIIHeI88u7uLx/kZ/tvscKXBeKhIR72Uy93yI
 K5JObfNCW04a8CIwZFLNyuQJ34r7iD5n4Ho+pQhSgd/MqlL4D8DNV2XlvhYJSBWP1D8YraJW9
 IlalHBoeHaXnK0MMpcryANZwHjX2jFMijpEXgrhBWluocLsvVMwzBjjGnrU++SpnzAeo1DhsY
 +3KosVT6sO/XRjhrbTrn5kuGOgdp8uCvUg1vR5RAChoMd82DHdHgzx2bGfayPAPvCBnJjE5AG
 pSs9c201XUpsqc/xCcDY0LEXM5+eZuMIR82oYfKG5lcl4UlPXd1VFNf5fHznRfbDbO93LO3xN
 pTcAUsc+il20tBhP/OYRapsBTKW01orQll4FzS6DrKsgzVHLjlYyJs1iGogJnwrFiV2MOAVM0
 tVJ7Mh0aIWQDuJAfcfYZ3saBNVu776gfzCiz3vVqtdzrkmgZhAEo9WrjAP5IQFSy6je9uyHZ2
 rhpdTrGEbgxbeVZFhewX10/KrIZCa9iwUcoBxlclMPQLKHM2D12e+k2LYfULMhhkcawJURCEq
 r89q+Y9MpPHRZvPLAmKD5s16yjBsbB7mddKIjbrP9gbqi+ReYH6tIvCXrjr7KcFXKnkO+5PS1
 Ix1z13mWFcZn7yHuFUnoKWfnnfo0GJhEc3NH2zG+zTmdj9njy2r+NOmV4In6Qe1eh1OEXVP6U
 T1cxIIHhv2Q==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 19 Apr 2019 14:15:12 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 19 Apr 2019 14:14:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking the search for duplicate statements at the end of
 if branches
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgYW5vdGhlciBzY3JpcHQgb3V0IGZvciB0aGUgZXZvbHZpbmcg
c2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UuClNvdXJjZSBjb2RlIGluZm9ybWF0aW9uIGlzIGltcG9y
dGVkIGludG8gYSBkYXRhYmFzZSB0YWJsZSBiYXNlZCBvbgp0aGUgZm9sbG93aW5nIFNtUEwgcnVs
ZS4KCgpAc2VhcmNoaW5nQAppZGVudGlmaWVyIHdvcms7CnN0YXRlbWVudCBzMSwgczI7CnBvc2l0
aW9uIHBvczsKdHlwZSBUOwpAQAogVCB3b3JrKC4uLikKIHsKIC4uLiB3aGVuIGFueQogaWYgKC4u
LikKIHsKIC4uLiB3aGVuIGFueQogczFAcG9zCiBzMgogfQogLi4uIHdoZW4gYW55CiB9CgoKCkkg
cmVkdWNlZCB0aGUgb3JpZ2luYWwgc291cmNlIGZpbGUgdG8gYSB0ZXN0IGZpbGUgd2hpY2ggY29u
dGFpbnMgYWxtb3N0Cm9ubHkgdGhlIG1vc3QgaW50ZXJlc3RpbmcgY29kZSBmb3IgdGhpcyBhbmFs
eXNpcyBhcHByb2FjaC4KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9u
ZXRjcF9ldGhzcy5jP2lkPTc1ZWFjN2I1ZjY4YjBhMDY3MWU3OTVhYzYzNjQ1N2VlMjdjYzExZDgK
CkkgZ2V0IGFuIGV4cGVjdGVkIHRlc3QgcmVzdWx0IHRoZW4uCgplbGZyaW5nQFNvbm5lOn4vUHJv
amVrdGUvQ29jY2luZWxsZS9Qcm9iZT4gc3BhdGNoIC4uL2phbml0b3IvbGlzdF9kdXBsaWNhdGVf
c3RhdGVtZW50X3BhaXJzX2Zyb21faWZfYnJhbmNoZXMzLmNvY2NpIG5ldGNwX2V0aHNzLWV4Y2Vy
cHQzLmMK4oCmClVzaW5nIFNRTEFsY2hlbXkgdmVyc2lvbjoKMS4zLjIK4oCmCnN0YXRlbWVudDF8
c3RhdGVtZW50MnwiZnVuY3Rpb24gbmFtZSJ8InNvdXJjZSBmaWxlInxpbmNpZGVuY2UKb2Zfbm9k
ZV9wdXQgKCBpbnRlcmZhY2VzICkgO3xyZXR1cm4gcmV0IDt8Z2JlX3Byb2JlfG5ldGNwX2V0aHNz
LWV4Y2VycHQzLmN8MgoKCkkgcmVkdWNlZCB0aGUgb3JpZ2luYWwgc291cmNlIGZpbGUgYWxzbyB0
byBhIHRlc3QgZmlsZSB3aGljaCBjb250YWlucwp0aGUgY29tcGxldGUgaW1wbGVtZW50YXRpb24g
b2YgdGhlIGZ1bmN0aW9uIOKAnGdiZV9wcm9iZeKAnS4KSSBnZXQgYW5vdGhlciB1bmV4cGVjdGVk
IHRlc3QgcmVzdWx0IHRoZW4uCgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2NpbmVsbGUv
UHJvYmU+IHNwYXRjaCAuLi9qYW5pdG9yL2xpc3RfZHVwbGljYXRlX3N0YXRlbWVudF9wYWlyc19m
cm9tX2lmX2JyYW5jaGVzMy5jb2NjaSBuZXRjcF9ldGhzcy1leGNlcnB0NS5jCuKApgpOb3RlOiBw
cm9jZXNzaW5nIHRvb2sgICAgOTUuOHM6IG5ldGNwX2V0aHNzLWV4Y2VycHQ1LmMKRHVwbGljYXRl
IHN0YXRlbWVudHMgd2VyZSBub3QgZGV0ZXJtaW5lZCBmcm9tIDEgcmVjb3Jkcy4Kc3RhdGVtZW50
MXxzdGF0ZW1lbnQyfCJmdW5jdGlvbiBuYW1lInwic291cmNlIGZpbGUifGxpbmUKZGV2X2VyciAo
IGRldiAsICJkZXZpY2UgdHJlZSBpbmZvIHVuYXZhaWxhYmxlXG4iICkgO3xyZXR1cm4gLSBFTk9E
RVYgO3xnYmVfcHJvYmV8bmV0Y3BfZXRoc3MtZXhjZXJwdDUuY3wxMgoKCk5vdyBJIHdvbmRlciBh
Ym91dCB0aGlzIHNvZnR3YXJlIGJlaGF2aW91ci4KSG93IGFyZSB0aGUgY2hhbmNlcyB0byBjbGFy
aWZ5IHRoZSBzaG93biBzaXR1YXRpb24gZnVydGhlcj8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
