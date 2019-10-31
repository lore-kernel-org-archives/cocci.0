Return-Path: <SRS0=W2E7=YY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1BACA9ECB
	for <cocci@archiver.kernel.org>; Thu, 31 Oct 2019 13:51:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7077C2080F
	for <cocci@archiver.kernel.org>; Thu, 31 Oct 2019 13:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="OEJwO0av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7077C2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9VDoreC029905;
	Thu, 31 Oct 2019 14:50:53 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9BF6D77CB;
	Thu, 31 Oct 2019 14:50:53 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6696B77BA
 for <cocci@systeme.lip6.fr>; Thu, 31 Oct 2019 14:50:52 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9VDopHE015955;
 Thu, 31 Oct 2019 14:50:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572529851;
 bh=Ka04FjMlFrx+4xntY5eirJSUCewd1rBUgBfDKDnMl6s=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=OEJwO0av9vm5ZARBzmdlp8T5dCioS7r6sPsw9Q3AqTTFSXvJoJMROjIcamQMNFCP8
 w5w+17A4qMyXlgoBszHHp3zeLQmCFzD62sRsHL0WDDtWl+O3M2hz6yjHIYnDOZA/QN
 XfQSF7Di00RlvkkFwrPnY/WozU+rwTNni960NbRY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.137.160]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lpw6t-1hnH7k1sut-00fmnv; Thu, 31
 Oct 2019 14:50:51 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <708207db-69d7-8962-e507-cd705142d0c4@web.de>
 <226b4ce7-8284-ed03-a478-98e3e532cb15@web.de>
 <alpine.DEB.2.21.1910311341240.6010@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <af873f42-1d0c-57f0-a06c-04a3ce02e5d4@web.de>
Date: Thu, 31 Oct 2019 14:50:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910311341240.6010@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:TObUmTC4mic3gzCuTOP0iTnlw1o1QdVVhkZtLT0l7Bfy4fzhP9e
 mzDUc0tTHt3fnLTqcw2z5ALGKHXIJRt2L28fPoEJOPLJho4tfkmaDgICFXx1YDRuT/nOl08
 FRKyKQnqt2nXNu8WkUDZk9LrWh+UsKyAlvGDVw8UxL4M9m7XGy1MyvQy4GoIQ80of35/7W/
 PpZHhbVFk+8lMBwNfC+GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sOk4d13DHIs=:e4v4wm4sE7e7ePlJB/eEJV
 1KPc0Pbj929XqrZKXF4UJOalfSq2feXlSmXv9WsSX2UXN+sNbqk0GLHexF0F8T+j6Us0V97AA
 xhoxJoqWMGMjkNgFnBGGS0kR5yXnnDJqkl4Y8b+MRpUXyH4xFGz1z7RIo2zTY2BbfBNsGq5ZU
 B7GHoXOJNkV7JJ0oRTEwdHd0AySVXm8a8w8jCCDg44GJUkIJTqFPT2low4Lcam854iwPW4fAe
 lio5WK1z+Z8F54H0jgvA0fPa+rK10f+ko47pU5h0isYGrW2zY0cNRCTAl9bDWLPboKr0TMY+G
 hN5qJY9zp4mVkaIKCq5tZqsFK6AkW20D3saVPYDZ+Gcbpo5JbSL/udThtjenpLpGVd8Wtu7Vy
 djqOK3Dm5ogLcmOjxmtntxJfNTaQ8wPzX4NAdJC06/NrQu8KBrfdA1zXlTQDL3SE99WEvLXcO
 1JQ7FIzxWuZJIVmYhw6rJLrYAmovByIp/A5i4HfvYR5F22PjIOkkBE854Md6KvZzlsQ/ZGaOk
 PAG9ZK018ZPM79KeY9GxmLrZGvkgxjLbI2CxAPeXIVyLxruZww5veWLpZc8Eimsqbc49XwxqB
 PZ1TWjEbRKPaF3hHJDuIU2fhp98cwLvkeLXqavDuxgzDsogU0tU4II5KjVSb3zdfqZcCEA+GQ
 7QW5KFPBwDKkYV0Asz7kwApTNiMOLHQBZKZ/lISbZPLMKF2KgAwJh485Rx/NO6Gm4xwN0y8e4
 mdbSJqhX3C5ZaQupHSJH+K0WZeUd5Paae/otysuN3dF734a5J+gAb2rYGs+EB6/cM0+3iWPSp
 +gV5OLNy5TLZ7o//DdJr0iVf5w2WwwkDa0KVLD2WHdfFUknc6oTDkNk99cMVbvK1/gOmFAmN9
 MfqbIcuv/QnCmsSyBLKUcdHsilu6hqozzpeJf7xnT5RDcE5Idg8BBQISTSzNzvs7yax0OpPmU
 7H4vGWvocSXB5wHrUUKUpMiCEzEq55tVPeX3A9eB3rGmkJpBNeVpj6et57fCbxcbLw7YrTmvi
 LHeBrdqR4Lyg3CA6mIS6glUDHcmDq/MZHJQ7/fpxu4swasU9KkDw/YTrXAEw34rCy+xO+XoXD
 W+uiwmIRMGwfVEYgBy1K0ruAAuLvEdsGIy3W8blTMJi3GD4mbJMgPwkmi3NHN+9PImcjzOjMD
 wDAVPxfaZJB8wKDOv+RS9ssytkDHdQKkaj4adXXMjKWaeCZhwKXVy82e0OiI8a0ICSyHPsh8z
 VcVUc5zSyUi/9L3iVwPqcZiiugS9BI0ZAPHH/119mtMJayMjCYz8W/FU+UR4=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 31 Oct 2019 14:50:54 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 31 Oct 2019 14:50:52 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
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

Pj4+ICAgVW5mb3J0dW5hdGVseSwgSSBzdHVtYmxlIG9uIHRoZSBlcnJvciBtZXNzYWdlIOKAnHJl
cGxhY2VtZW50OiBhbHJlYWR5IHRhZ2dlZCB0b2tlbjoKPj4+ICAgQyBjb2RlIGNvbnRleHTigJ0g
dGhlbi4KPgo+IFRoaXMgaXMgd2hhdCBJIHdvdWxkIGV4cGVjdC4KCkkgY2FtZSBhbG9uZyBkaWZm
ZXJlbnQgYXBwbGljYXRpb24gaW1hZ2luYXRpb25zLgoKCj4gWW91IGNvdWxkIHVzZSBvbmUgcnVs
ZSB3aXRoIGFuIGV4aXN0cyB0byBwdXQgYSBwb3NpdGlvbiB2YXJpYWJsZSBpbiB0aGUgcGxhY2UK
PiB3aGVyZSB5b3Ugd2FudCB0byBwdXQgYSBrZnJlZSwgYW5kIHRoZW4gdXNlIGFub3RoZXIgcnVs
ZSB0byBwdXQgYSBrZnJlZQo+IGF0IHRoYXQgcG9zaXRpb24uCgpJIGhhdmUgZ290IHRoZSBpbXBy
ZXNzaW9uIGZyb20gdGhpcyBpbmZvcm1hdGlvbiB0aGF0IHlvdSB0aGluayBpbiBvdGhlcgpkaXJl
Y3Rpb25zIHRoYW4gdGhlIHVzZSBjYXNlIEkgcHJlc2VudGVkIGhlcmUgb25jZSBtb3JlCih3aGVy
ZSB0aGUgbWVudGlvbmVkIGZ1bmN0aW9uIGNhbGwgaXMgbm90IGFkZGVkKS4KQ2FuIHRoaXMga2lu
ZCBvZiBmZWVkYmFjayBldmVudHVhbGx5IGJlbG9uZyB0byBhbiBvdGhlciByZWNlbnQgdG9waWM/
CgpJIHdvdWxkIGFwcHJlY2lhdGUgaWYgdHJhbnNmb3JtYXRpb24gY29uZmxpY3RzIGNhbiBiZSBy
ZWR1Y2VkIGFsc28gYnkKdGhlIGdlbmVyaWMgaWRlbnRpZmljYXRpb24gb2YgZXJyb3IgY29kZXMg
YW5kIGp1bXAgdGFyZ2V0cyBmb3IgdGhlIGNvbWJpbmF0aW9uCm9mIGEgYml0IG9mIGV4Y2VwdGlv
biBoYW5kbGluZyBjb2RlLgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1l
LmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
