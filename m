Return-Path: <SRS0=2FHN=YM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DA5CA9EAB
	for <cocci@archiver.kernel.org>; Sat, 19 Oct 2019 15:34:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B9D2082C
	for <cocci@archiver.kernel.org>; Sat, 19 Oct 2019 15:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="aU+xCDvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B9D2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9JFXxuQ023586;
	Sat, 19 Oct 2019 17:33:59 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F127377B8;
	Sat, 19 Oct 2019 17:33:58 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 129BF7792
 for <cocci@systeme.lip6.fr>; Sat, 19 Oct 2019 17:33:57 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9JFXu9B024051;
 Sat, 19 Oct 2019 17:33:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571499236;
 bh=ADy4qVUKtoQ+5DCYwE5iA3vRJ7eskZv3QhoWRWAn7mg=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=aU+xCDvmCMcSGabGmP3ZsN0A4nwb9D0wAvGAjoLKVsy2geyfWUfppHCMuGJ68Hv8G
 A/CBYDTR/bafoSjXPflT0yH88N2I0OWvUNq093A5xc5ntlsfyNNw5n1fHGbtSpNU3Z
 7hp4BPboe4kWckwCckDe+ZzpYXHi4HtK6EE/3xnI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.29.47]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MaJc8-1ibJC0070i-00JqHh; Sat, 19
 Oct 2019 17:33:56 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <45be389f-23f9-cbff-fa5f-8ad111124f94@web.de>
 <alpine.DEB.2.21.1910181530460.3697@hadrien>
 <1a3776fe-7f18-e072-9bda-30d10ffd1c07@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <32b67cc6-0dd9-6615-d8ed-5c2dfe2af863@web.de>
Date: Sat, 19 Oct 2019 17:33:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1a3776fe-7f18-e072-9bda-30d10ffd1c07@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:f5B0DdmsqjYbNpegl1AA60wa1nhbjZfqTKe79y+BvZXl1DKYLU7
 A2p46BWCmkEqdQuQ3rCgbU7+xkJaON3+HhG6SlJjZNr0rjIsLzHYcuMDQMMWt7/ufDeIXiK
 Q16nxFPoUODzsMPPUl5Y9YeqII2xH3OFlrYNMPkYoZFO/elxda5fvTswe4Iw84+e0+C6/e6
 qFuHW/S7vgYlwsQgb51yQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s6xwvpHfJlE=:ABybyWwgES/6f0V2STfDQQ
 1hHqbA7ff5ucbN3SZtHTIaSCo3FGYzVvTK7JmTMlySuuE4WAce2UioweJ+0o/ZV5IkgLTw7ax
 5rbDE2uf6YEojwo+D/yysi87gA5KTErfxDq38DUybgQcOQepDWfsCrXxX/ob40CZjFrxbVQ48
 akcyP5ZX7C5iLAuO9rx2cYezYSiSLQXCx4A8r54Us2bqfFWgtWSOPI3/SFQ/dq/Tkt5J2OSvR
 fcWfK1Bpp929a6GUIBvV2RNEJqFjZn8ZQ5vVVMk60DeEFtNJRYF6RoA9dd9nvxV29KSnoneMC
 8b9M3UMDU4j1tkXJvNmOyyclF2rOZCRMjmWCncY3SGBl2EvrgkZFSLG1A6X12Ns8qWhbbbeLa
 oLUl+uZeQpQ4zn9RPAKUhUHVrsiAaAmEjmUycT3fA7ECCTvGMN3BD11I9os8xzgFLErf2zgJu
 B8HISQnTfSRg0L8VrGPLrwvLU0wqtHD/rUI+rYYVY//uvFZcmrxum+fzy79slPynXiFyrh7cn
 bksaWRim19MV9UAbHJLbK9Cs/5r0Kal3qywyTfXpnm6pzrUuRI7JjMGK9f7cs47JOS+gf6RC6
 jMTGdk1jfPwnToCqecE4cfrpLInztdCEae6z1GI1GnXw6MU/+CwZZyFzzP2EFabgwlIiJ4CEn
 v8XLnl+qLDI1Qg8qSU4nVzEEuaRaWy62Q0HAzSoXMWqOZ+6XxA4DQqt9t6PBfyumYTdhIFL4Q
 P28KKRHT3jufuqrqid9DpeJ7uD1CfcziMlw0ZmnQuigJ6EuuQ6uEqdIZdaeAyPtiRkcRe+pBk
 oOfntQ8VmyNdVFlvhEFWnAm91qHl0LZ8RKCkcaHwDbJbgt0hw5m8vgHaRduq8hW85/nIdBTPW
 3Iwz3aUbDRW4ColgxQGmUsbQya1I0SZIEm6Pw22jvOt7hcyiwZXMTK3zGnzuFmN57mIDFH22S
 Okkb2zFEvIvU2QiESx9K34nHsVKjG/qmjKaxmICmv38vrE8tXqXTB3oM0AyOO90MVoheH9AYv
 HDmix9LQmO+7PRBlz7KY62pHsLuMoj0DdWsgineiLL2YifaJ+bM6mV7+9xvOJ9hdut55PONAG
 y1x1m0ZIixsFRbjMb+rhJGz41ofSm3l5hn1FUer+P5vd1BSgEoKyaES5Ae2+3R7AewyRSpigB
 hYLh0H/OX+/9LZX0ylYT2+gO1xYk5kemgFNxbkSY7w1c6kFuaa2Oe3IiWJlNbzi9PIMOdw9R6
 k5/z8G/tBk7blYDjSkHkxWyTBThfs5alWfypjRImiwHvHSx6Jy03VnAK9r6o=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 19 Oct 2019 17:33:59 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 19 Oct 2019 17:33:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked pointer
 function calls
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

PiBOb3cgSSB3b3VsZCBsaWtlIHRvIHBvaW50IGFub3RoZXIgYW5hbHlzaXMgY29uY2VybiBvdXQu
CgpZb3UgaW5mb3JtZWQgbWUgYWJvdXQgYW4gYXBwcm9hY2ggZm9yIHRoZSB1c2FnZSBvZiB3aGVu
IGNvbnN0cmFpbnRzCndpdGggdGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdlIGluIHRoZSBmb2xs
b3dpbmcgd2F5IGFjY29yZGluZyB0bwp0aGUgZGlzY3Vzc2lvbiB0b3BpYyDigJxEZXRlY3Rpb24g
b2YgdW51c2VkIGZ1bmN0aW9uIHJldHVybiB2YWx1ZXPigJ0KKG9uIDIwMTEtMTItMTEpLgoK4oCc
4oCmClJ1bGUgciBjaGVja3MgdGhhdCB0aGVyZSBpcyBubyB1c2Ugb24gYW55IGV4ZWN1dGlvbiBw
YXRoLgrigKbigJ0KCgpJIGNhbWUgYWxvbmcgdGhlIHVzZSBjYXNlIGFnYWluIHRvIHdvcmsgd2l0
aCByZWxhdGVkIGluZm9ybWF0aW9uLgpUaGUgY3VycmVudGx5IGRpc2N1c3NlZCBTbVBMIHNjcmlw
dCB2YXJpYW50IHBvaW50cyBhbHNvIHRoZSBmb2xsb3dpbmcKc291cmNlIGNvZGUgcGxhY2Ugb3V0
IGZvciBmdXJ0aGVyIGNvbnNpZGVyYXRpb25zLgpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9s
aW51eC92NS40LXJjMi9zb3VyY2UvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9r
b21lZGFfZGV2LmMjTDIxMApodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0L3RyZWUvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNw
bGF5L2tvbWVkYS9rb21lZGFfZGV2LmM/aWQ9YzRiOTg1MGIzNjc2ODY5YWMwZGVmNTg4NWQ3ODFk
MTdmNjRiM2E4NiNuMjIyCgrigKYKQEAgLTIyMizigKYgQEAgc3RydWN0IGtvbWVkYV9kZXYgKmtv
bWVkYV9kZXZfY3JlYXRlKHN0cgoKIAljbGtfcHJlcGFyZV9lbmFibGUobWRldi0+YWNsayk7Cgot
CW1kZXYtPmZ1bmNzID0gcHJvZHVjdC0+aWRlbnRpZnkobWRldi0+cmVnX2Jhc2UsICZtZGV2LT5j
aGlwKTsKIAlpZiAoIWtvbWVkYV9wcm9kdWN0X21hdGNoKG1kZXYsIHByb2R1Y3QtPnByb2R1Y3Rf
aWQpKSB7CuKApgoJbWRldi0+ZnVuY3MtPmluaXRfZm9ybWF0X3RhYmxlKG1kZXYpOwoKCWVyciA9
IG1kZXYtPmZ1bmNzLT5lbnVtX3Jlc291cmNlcyhtZGV2KTsK4oCmCgoKTm93IEkgd291bGQgYXBw
cmVjaWF0ZSBvbmNlIG1vcmUgaWYgdGhlIGRlc2NyaXB0aW9uIGZvciB0aGUgc3VwcG9ydGVkCnNv
ZnR3YXJlIGJlaGF2aW91ciBjYW4gYmUgY29tcGxldGVkIGZvciB0aGUgc2FmZSB1c2FnZSBvZiBT
bVBMCmNvZGUgZXhjbHVzaW9uIHNwZWNpZmljYXRpb25zLgpJIHNlZSB0aGF0IGEgZnVuY3Rpb24g
cG9pbnRlciBpcyBhcHByb3ByaWF0ZWx5IHVzZWQgaGVyZS4KVGh1cyBJIHdvbmRlciB3aGVyZSBt
eSB1bmRlcnN0YW5kaW5nIG9mIHRoZSBzb2Z0d2FyZSBzaXR1YXRpb24gYXJvdW5kCnRoZSBwcm9n
cmFtIOKAnHNwYXRjaOKAnSBzZWVtcyBzdGlsbCB0b28gaW5jb21wbGV0ZS4KClJlZ2FyZHMsCk1h
cmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2Nj
aSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2
LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
