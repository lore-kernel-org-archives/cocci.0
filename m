Return-Path: <SRS0=nFVp=U2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D696CC48BD7
	for <cocci@archiver.kernel.org>; Thu, 27 Jun 2019 08:34:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D3A2082F
	for <cocci@archiver.kernel.org>; Thu, 27 Jun 2019 08:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="n5WYuumH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D3A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5R8Y6Ig003937;
	Thu, 27 Jun 2019 10:34:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0EB607772;
	Thu, 27 Jun 2019 10:34:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DBB897771
 for <cocci@systeme.lip6.fr>; Thu, 27 Jun 2019 10:34:03 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5R8Y1pu018573
 for <cocci@systeme.lip6.fr>; Thu, 27 Jun 2019 10:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1561624441;
 bh=a4zXoSrifzay153+HzjEy+MrJ5GARAU0v1dM06DNggQ=;
 h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
 b=n5WYuumHiGzHatMANapukDXgVVN4n/N7XYx+6uFZZdIte0w2xG0KeYWozTUHJ9KGd
 ndkKbHkDHbK8ZqwBa8ljapiXTHtsCqdqovgCfLWkTI7ONjL5sm1Y67IqJkKmo1JWy7
 h5CXAfiKps03h5ip8PFF/wzHmx2P2vybIdf0A7jY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.74.178]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxODe-1ieMux0Bqs-01712p for
 <cocci@systeme.lip6.fr>; Thu, 27 Jun 2019 10:34:01 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
References: <708207db-69d7-8962-e507-cd705142d0c4@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f79ae892-a674-5f69-1d25-88594a89ebff@web.de>
Date: Thu, 27 Jun 2019 10:33:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <708207db-69d7-8962-e507-cd705142d0c4@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:kSNbFTa61PwuV76COKj4cMnzJDLldI4DwHgZtp1Wb0pWJLDJgTm
 O8gnzKlbF8Hy8QmXckxehgSCpqPDn2VkPmn2zHEkPZQ9iO8K5SPmqgSlSj+hWcUIDiuVAi5
 mIpGcPGDzqOfnyj7lk8X+CYfu+yEPibOkDwBgmZgy/LCh4Z4pIr5nnzpmGOHXFEQU3AJgXA
 7mWdJRhle+YU3DGsYihvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0pEyhVbl5Hw=:TSsfXzLSS59BbgOZ07lfRl
 ogGkI6DqBIflR7HvEVlT6p2CMFKA3jGddXaXj3OU/h67mMgRFbOhqqtQdAzVbmZXCB8r3mWw/
 hd5zuikPFRef/J1R4xnJBfGNqRcfesEJJsDz0t2C59H7icJpp3oZqVeD9ukuqU+O/4fm6loSv
 Bzd2j5lOUFmotVbgRPjTRSQ2pwEfRsnU6Op81w99zZNjuDUNZDbjIi/4t29AMFRdFZ/ttUSJG
 XidEPL0Z39nR8SiKO2/kdS/bh9Jbb0kuydkjLFDz/mLIhyUQi66FcZ3rN3mrkgZ/onvXJYl2T
 xKgz+YDTkuAxEFBvZulx4yVhT+67PAu5Cnex+THAKWIPczr6VrW8+2GrMbFdO4wEn0refHF1N
 utO1sNOozgGoYDvImXk4DZBv314Lg51YwaQCNc0xnYO8qsO9njC7++FwgO3sooBHt9+EPdhjv
 G+7Dwu9vDw2FS1Nnc5lswgBGwFJktb0erMwQiDjV/Dq1vDby/SJiqKK2DvTPOfSxWh9IMtoOD
 gf4ycUaSc+ThQnxwT5fDHa0+XJK2xezeBKRm6SkguXGI3YAXdRKrjp8UojUm+jORHkInCMcQq
 B84Ik+xtK2oZI1nZpeLc2CyCD+W3HKNBnsRdo2QU9PLfD6ZgJ6lMhkyILiradUQB0UZRzD6FJ
 G1xe3kCmkEREG70pTbZRDrQp41Keap2p64BR0Q6i6N1lK7HwTae+aiL5tgLRmUBO1mpW8E5eD
 3Qg4NOkAgbGIsxFktXLvtjp96PS5hKZIoxBQjP+6rHAnsbm4J5vYpERZhJ3EJlxPkcnn9bQlE
 gWqjoKR7dwKbXAqfn8NNBmsjcnPnhHrP2sKKcF+E9mvcXTsVbyRfA5V82VZbHFu3skJlqKtGd
 9FBPVfzjozCxWlgIAbwYxX7pVYxpZoMpBJpZsy3CzmsLi6E5sdgu4MZDsrvO5Ik3H83IY8Vil
 58DYCASwp/b09dst1ZY7uxbVNIgDnnoU+RFXevbIRIBfqY27nC3fu
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 Jun 2019 10:34:06 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 27 Jun 2019 10:34:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Moving exception handling code to the end of a function
 implementation with SmPL?
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

PiAqIFRoZSBjb21wbGV0ZSBzb3VyY2UgZmlsZSBzZWVtcyB0byBiZSB2ZXJ5IGNoYWxsZW5naW5n
IGZvciB0ZXN0aW5nCj4gICB0aGUgcnVuIHRpbWUgY2hhcmFjdGVyaXN0aWNzLgoKSG93IGFyZSB0
aGUgY2hhbmNlcyB0byBjbGFyaWZ5IHRoZSBkaWZmZXJlbnQgdGVzdCByZXN1bHRzIGZvciB0aGlz
IHNvdXJjZSBjb2RlCnRyYW5zZm9ybWF0aW9uIGFwcHJvYWNoIHdpdGggdGhlIHNvZnR3YXJlIGNv
bWJpbmF0aW9uIOKAnENvY2NpbmVsbGUgMS4wLjctMDAyMTEtZ2VhYTEzZDU5LWRpcnR5CihPQ2Ft
bCA0LjA3LjEp4oCdPwoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0xpbnV4L25leHQtcGF0Y2hl
ZD4gc3BhdGNoIC0tcHJvZmlsZSB+L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvci9tb3ZlX2Vy
cm9yX2NvZGVfYXNzaWdubWVudF90b19mdW5jdGlvbl9lbmQxLmNvY2NpIGRyaXZlcnMvc2NzaS9t
ZWdhcmFpZC9tZWdhcmFpZF9zYXNfYmFzZS5jCuKApgp0aW1lb3V0ICh3ZSBhYm9ydCkK4oCmCnBy
b2ZpbGluZyByZXN1bHQK4oCmCipmdWxsX2VuZ2luZSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgOiAyMDAuMjc5MjAyIHNlYyAgICAgICAgICAxIGNvdW50CipiaWdsb29wICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgOiAxOTkuNDkyNjEwIHNlYyAgICAgICAgICAxIGNvdW50CipS
dWxlIHJlcGxhY2VtZW50ICAgICAgICAgICAgICAgICAgICAgICAgOiAxOTkuNDkyNjA4IHNlYyAg
ICAgICAgICAxIGNvdW50Cipwcm9jZXNzX2FfY3RsX2FfZW52X2FfdG9wbGV2ZWwgICAgICAgICAg
OiAxOTguMzkwMjA5IHNlYyAgICAgICAgICAxIGNvdW50CipteXNhdCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgOiAxOTguMzkwMTc3IHNlYyAgICAgICAgICAxIGNvdW50CipjdGwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiAxOTguMzg5OTU1IHNlYyAgICAg
ICAgICAxIGNvdW50CnByb2Nlc3NfYV9jdGxfYV9lbnZfYV90b3BsZXZlbCAgICAgICAgICAgOiAx
LjEwMjI5OSBzZWMgICAgICAgIDE3MSBjb3VudArigKYKCgpSZWdhcmRzLApNYXJrdXMKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBs
aXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFu
L2xpc3RpbmZvL2NvY2NpCg==
