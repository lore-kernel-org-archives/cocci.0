Return-Path: <SRS0=0+7Q=ZO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B71FC432C0
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 13:18:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E129C20714
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 13:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="iHLHfJNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E129C20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAMDHwGD020183;
	Fri, 22 Nov 2019 14:17:58 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8A59077E3;
	Fri, 22 Nov 2019 14:17:58 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8837377D2
 for <cocci@systeme.lip6.fr>; Fri, 22 Nov 2019 14:17:57 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAMDHu9h000308;
 Fri, 22 Nov 2019 14:17:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574428676;
 bh=kwyzn8ZVhQ6pXet1AZ9uTW74AIU1ztIhg4bLEUbo5uE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=iHLHfJNuTaWx9gjCUhzbvFh8FhOUlR6MN9AuwXtu47TtMxtqDHMHELbG1ykdYkIwD
 OszCHGOhwbJtZzHoxuCWL1G+WMPnklg5xUpaOWUbkIaj6RwrZiNGX2o5eLCN4N7hr+
 PLHUVC7krtFYINp+rD+bwQSUnefmRHhujVHe2rJE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.174.75]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9XQB-1ihCJP23LT-00D2pW; Fri, 22
 Nov 2019 14:17:56 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <cc561358-4d00-9f1f-eaa2-8fae400ccc8b@web.de>
 <alpine.DEB.2.21.1911221025570.2793@hadrien>
 <8a44f286-72ad-14c4-6ee9-b8aa25ccba3e@web.de>
 <alpine.DEB.2.21.1911221050320.2793@hadrien>
 <46f7430f-8176-27ed-1150-af9fc69b03a7@web.de>
 <alpine.DEB.2.21.1911221134210.2793@hadrien>
 <da29f2ea-7037-3237-8ec5-4464379e7a54@web.de>
 <alpine.DEB.2.21.1911221155320.2793@hadrien>
 <599a5c47-75c5-f0a8-afe9-3563a20b70d3@web.de>
 <alpine.DEB.2.21.1911221351470.2793@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <388a4927-6321-a4d6-a65d-265dfd2a5637@web.de>
Date: Fri, 22 Nov 2019 14:17:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911221351470.2793@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:FJFNpvNAE2PFWmpnUbajMThs8Tu++G9UntLR6dh1CwT7XmDtKck
 ZeQh8C/yvZ5ZLCqFHtWPQDtnYB8tLoaEBW5OnQODMXxUyMyXbOVvK2tPNcr8KSs+ygKudCl
 6y3gRXcfvc8M06d2jt702l1YVWDZjv1a99wJnGV9U1eb+nTiIxi2wYn5cNxUpGCz9mIzJDB
 e1bj2Cgfj2d0+rkNzJtkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w341CgwwpWg=:E983mzV8JRczFQNmArBiHB
 X04J/NVHsQqE6nKpnDRnO+mKB6qcfeVoEa/M7DlbkjGTk0vmBTUFzV5/CDOjxUym/WDja77bR
 Ww436OsB9vkuAPgVjwtkppIQGfldqSQ/BlU1Lepk2y1WZF8W2bNDmXVPlHcaSVXQ6Oo8WeD+1
 u69icFlVT86EKKqnK6pbCAciRg1tlwp568Rzrr6mmQNN9RCNi2WRUkAqq0i15JMXGtEqKnRlL
 LVh9ZMiSfBe/czm0Tho22QycLzJswu1X7fia8Edk8e/kOT3dgerloLNVVrXIPatTXhsNoY0zC
 48PsAwq4hBDrnU98AYSHfH+1WTRkoqkxz+RAoPb6ZUGQdyeBPwm+kHnqe8lZmiGR/Du1THkhw
 cvg7M7TFPST2odwf1mq4CUgulWqfWVJsXncLKQVi+4OaW88GEU2toVUvDxRdVcUQ2h375X68m
 G3C+46CBxvn2V+GsW/aJuBmL9v7wOLPGG8duOjSK4aDlfrOy3yi2jD6undWf78iipP+yKnWxC
 skHB04mndWd68nCdWeaNOqXNdU2COslFiBIgmE6E5+EJ61xKjyzTOG44X8z1+uHfVg+iV7UPg
 RSda8MrTFzKQFi80oiPVgT11LVKp8iO3fljImFyPRZfMrmFHGS9w8mnj8WZDLKDY1A3zY5+li
 bsX6BwPCR8Yqxe67azd2PUaUlsEU/Xtiwwdm+PUe2PC5JE2ve6P+GghyYBlDLiYFUwoyO9yHk
 yIA38HwLKHLBe1ku0UG3y3yOepfPS5RjVm+7H+4XXXsMJIS+MTzmOIMqrFelT6hEvSwTQG1SX
 F4GdKsX+gQb1Q4vRL4dmwHuppeXq55Ftn/f+yTycaeNRxULuw8KDZY/W7OJRYdNNHArJsmiaC
 KKjFS5iT8RaPHwKgUr82ZPvagRyiwvF82N93MZdinqAmM5LQ1nGfKXeBwhEW6C295y3TGvGhS
 yV2fxE3vI8CqhNiTtwh990hgP8PYRGciwbhINQV5+MoWhYv0iv9XytWDhk2u89mA3KYO34Meb
 wOuTl4V24RTcALMBEsxifmgjHJCwu+l1fjgvnsC+c01ZgW6F1cTTyJVZQNjkhNDWfDVeSdXsd
 dD7IAcWs36XXI/MXffZ1L3eiAbOwfgewMrZK7UbhayP0lo02+oyZZU4K/YLXXaLLNj6EzAYht
 0vrpI+kcKAMtx7+4LEKcVFQxjFT6susXP7CxzHALjkajk9hIZIDzC5gOUv1kKjEbQbC1xbrP0
 7YXQEczgh9WntjSjIm/f6pOdhrL9ODe9xzfDn1gbKmHUDgNisti4UNGa1m8c=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 22 Nov 2019 14:17:59 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 22 Nov 2019 14:17:57 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Concerns around type safety for usage of expressions
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

Pj4+PiBBbm90aGVyIGV4YW1wbGU6Cj4+Pj4g4oCcW1BBVENIXSBjb2NjaW5lbGxlOiBpbXByb3Zl
IGFycmF5LmNvY2Np4oCdIGZyb20gMjAxOS0xMS0xOAo+Pj4+IGh0dHBzOi8vcHVibGljLWluYm94
Lm9yZy9naXQvMGQ5Y2Y3NzItMjY4ZC1iZDAwLTFjYmItMGJiYmVjOWRmYzlhQHdlYi5kZS8KPj4+
Cj4+PiBPSywgc28geW91IGFscmVhZHkga25vdyBob3cgdG8gZXhwcmVzcyB0eXBlIGNvbnN0cmFp
bnRzIGZvciB0aGluZ3MuCj4+Cj4+IFdoZXJlIGRvIHlvdSBzZWUgdGhhdCBJIGRpZCB0aGlzPwo+
Cj4gVCAqcHRyIGZvciBleGFtcGxlLgoKSXQgc2VlbXMgdGhhdCB5b3Ugc2F3IGEgYSBiaXQgb2Yg
U21QTCBjb2RlIHdoaWNoIEkgcHJvcG9zZWQgdG8gZGVsZXRlLgoKSSBzdWdnZXN0IHRvIHRha2Ug
YW5vdGhlciBsb29rIGF0IHRoZSBjb3JyZXNwb25kaW5nIGRpc2N1c3Npb24uCmh0dHBzOi8vcHVi
bGljLWluYm94Lm9yZy9naXQvZDI5MWVjMTEtYzBmMy0yOTE4LTE5M2QtNDlmY2JkNjVhMThlQHdl
Yi5kZS8KCgpJIGFzc3VtZSB0aGF0IHRoaXMgZmVlZGJhY2sgbWlnaHQgZml0IGFsc28gdG8gdGhl
IGNsYXJpZmljYXRpb24gcmVxdWVzdApmb3IgdGhlIHRvcGljIOKAnERhdGEgcHJvY2Vzc2luZyB3
aXRoIHBvaW50ZXIgdHlwZXMvZXhwcmVzc2lvbnPigJ0uCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2NvY2NpL2YxNTIyNzc5LTVkMTAtYTFkMS0wNTU1LTc5NWFmNjEyZDhiM0B3ZWIuZGUvCmh0dHBz
Oi8vc3lzdGVtZS5saXA2LmZyL3BpcGVybWFpbC9jb2NjaS8yMDE5LU5vdmVtYmVyLzAwNjYwOS5o
dG1sCgoKPj4gSG93IGNhbiB0aGUgQyBkYXRhIHR5cGUgYmUgZGV0ZXJtaW5lZCBmb3IgYW4gZXhw
cmVzc2lvbiBtZXRhdmFyaWFibGUKPj4gc28gdGhhdCBpdCBjb3VsZCBiZSB1c2VkIGZvciBzdWJz
ZXF1ZW50IHNvdXJjZSBjb2RlIHNlYXJjaGVzPwo+Cj4gQEAKPiB0eXBlIFQ7Cj4gVCB4Owo+IEBA
Cj4KPiBOb3cgYWZ0ZXIgbWF0Y2hpbmcgeCwgeW91IGNhbiB1c2UgYm90aCB4IGFuZCBULgoKU3Vj
aCBpbmZvcm1hdGlvbiBjYW4gYmUgZmluZSBpdHNlbGYuCgoKPiBJZiBDb2NjaW5lbGxlIGNhbm5v
dCBmaWd1cmUgb3V0IHRoZSB0eXBlIG9mIGFuIGV4cHJlc3Npb24sCj4geCB3aWxsIG5vdCBiZSBh
YmxlIHRvIG1hdGNoIHRoYXQgZXhwcmVzc2lvbi4KClRoaXMgYXNwZWN0IGNhbiBiZWNvbWUgbW9y
ZSBpbnRlcmVzdGluZy4KCiogRG8geW91IHN1Z2dlc3QgaGVyZSB0byB1c2Ugc3VjaCB0eXBlIG1l
dGF2YXJpYWJsZXMgdG9nZXRoZXIgd2l0aAogIGV4cHJlc3Npb24gbWV0YXZhcmlhYmxlcz8KCiog
Q2FuIHRoZSBkYXRhIHR5cGUgZGV0ZXJtaW5hdGlvbiBiZWNvbWUgYmV0dGVyIGRvY3VtZW50ZWQ/
CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczov
L3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
