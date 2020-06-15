Return-Path: <SRS0=AA88=74=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD95C433E0
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2020 14:05:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EDD2207D4
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2020 14:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="I8w6ve+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDD2207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05FE4lFv018593;
	Mon, 15 Jun 2020 16:04:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B22547577;
	Mon, 15 Jun 2020 16:04:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 87708402B
 for <cocci@systeme.lip6.fr>; Mon, 15 Jun 2020 16:04:45 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05FE4iEq017850
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Jun 2020 16:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592229880;
 bh=4v21AZdQnfl4I0lRhOIakIYNWUq/Km4A1kjWkH+LG+k=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=I8w6ve+YKYhThZ5ofnfAiHqCU6Iq0GaKT36raCtasNO/C1hsYDcMCg+shCQretSDK
 2R4ivxOfmD6Q7PJxZN5wEtYBPSi6Z0aUGucyr38L+j7sSnCB95rrOxEVML66BjUcO6
 k/VGonGCrDOX31U126vWYT/MxzRNwupovNjzlGf0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.107.236]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1o86-1ivkAs1QQU-00tnO6; Mon, 15
 Jun 2020 16:04:40 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Denis Efremov <efremov@linux.com>, Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1f028ee6-b014-c240-21d8-0c1950334fe6@web.de>
Date: Mon, 15 Jun 2020 16:04:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:ZHx86tvl9ZN2Q273cNj9qJz+VxDh7ipJR+Ha23Z/58jiwxrAkuX
 sxDc8DXF1pHdiOrY0LFdU4Vpo65k11kXZvoTipRisB+u7lnegNmrRMfv0C2bUDYrEUUy7HC
 n1xDtOrB9aTNlkPLuNqg1otetrw8ccFOPcqdbIFs48bL+hn38TSmUQvqhJy3Fj5AYOjES5o
 D8FVCfiVrIFxi9w/I9lPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0MtBwmoIY+o=:sedTTOKGnKCR6XboMZ0vhW
 T2BHiXqCdkej4yq+NYLSQVHjX1XTsTsNDK2IARqkK1hI5lpzfdM/kMqpMH83IfTyDbFc3cjM+
 6WZ7YhNIWvrrik/k2++CcpX89pZTDmgSHjdQLoV3I8QMHjtmQmqYHPGd4WIxiLQEFItX7t368
 lOv1QOPblDh8BaVCNVTN6jplY+WBSbBQVjgxWKL8+eosRjUS4hhxwGWbpC8ivbNlBjKw3QfaF
 ZQGnnz/f8nETWUIzips7ModFvv7+yRL0xcRGmzpU0qVor0ojfbOYVUWoBi9gSxzjoY2nus7ca
 ne7aPKBS39CTg5X/1l8WK3EAOsfszIlN3CpHkjVPjbw5lurPV4QiIJzq9FeD0cIUHOapV9sSv
 jrOugx2ycYvxHXoO8LiIwdZouUPiKV0G5MuHjpDraPYzqudX7prYsXkHtrCIg4AaJDhYwT6UO
 9xusztz7Xp4DwNnxZGgpm4cyf+wsXibQ3NZKEXvwTkHRIV99LJ/7NrRqy1q9W7fWNkS0GYsRi
 voyP4b62sHsTCo86AQWZfcsbNVT7CKGx+9yGdGJeqpxBimk3FQeueRYWmhMcI08wCCDhDYG/G
 MauZCP2tDVt3C0GaXMl0XcMr1G3kPZ3fGtemWvC+ySLitk2BjOGtHDYjI1gyK6FWNedhuNvkj
 8Jg7Z5EM0FhvAC5CUmz6yNWg4ZbTAtuYmYHm1pIe+S8rg4pZXpGNXNx3r5lxjhw6mj02+v+aP
 v/GJ0AUgo5e/gDLzzXzgaTyyrzP8IOAum57wfk0BLKmG41+bgzpqw13FfgoE1AODiubWsFxzC
 IyrVhNNI+UWOx6sy7qrEtsrunbXKRb09MclwlgQAb+i0hZnwbF9ta9FRSDsrxxEbLKyLfX+rg
 CfjdNhlIFSQul/8N5a1VR5CUWprtcP6k8Eg9ZqpGBp822ub6qSv09jU32BybtDcDzypfQT1jZ
 fyzEEGnYvuxaowjcrwKGnFy51vtrepB9IDc6ISmhv1PkPqoR5kh8+DZqg62QbFI0Ai0mnSGuT
 YMafZGeEN3cBWrCn3yqQ8KTVY7nccAiT6s8/4h4LlGM8oTgbvC2BFgXmK1I6tpEJlt/rsF3RP
 XadVDJrJdyQLgNw8847sS5+aamRBiCaGxoBVZuWAJdw8dlnoEvdRj5rvYM5VjgGiZG43GEExz
 yajQKCTE89ozfsxOYmTPssT/y7T4m97guJniW/DAVIWt0p7mx/eWV8IOq/vC4tyJmVtCUAxq7
 4RtZj0gWVAhtJjm2e
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 15 Jun 2020 16:04:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 15 Jun 2020 16:04:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: api: add device_attr_show script
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

PiArLy8gQ29uZmlkZW5jZTogSGlnaAoKV291bGQgeW91IGxpa2UgdG8gYWRkIGFueSBzdWdnZXN0
aW9uIGZvciBhIHBvc3NpYmxlIHBhdGNoIG1lc3NhZ2U/CgoK4oCmCj4gK3ZpcnR1YWwgcmVwb3J0
Cj4gK3ZpcnR1YWwgb3JnCj4gK3ZpcnR1YWwgY29udGV4dAo+ICt2aXJ0dWFsIHBhdGNoCgordmly
dHVhbCByZXBvcnQsIG9yZywgY29udGV4dCwgcGF0Y2gKCklzIHN1Y2ggYSBTbVBMIGNvZGUgdmFy
aWFudCBtb3JlIHN1Y2NpbmN0PwoKCuKApgo+ICtzc2l6ZV90IHNob3coc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQo+ICt7Cj4gKwk8
Li4uCj4gKyoJcmV0dXJuIHNucHJpbnRmQHAoLi4uKTsKPiArCS4uLj4KPiArfQoKSSBzdWdnZXN0
IHRvIHJlY29uc2lkZXIgdGhlIHNlbGVjdGlvbiBvZiB0aGUgU21QTCBuZXN0IGNvbnN0cnVjdC4K
aHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxsZS9ibG9iL2UwNmI5MTU2ZGZh
MDJhMjhjZjNjYmYwOTEzYTEwNTEzZjNkMTYzYWIvZG9jcy9tYW51YWwvY29jY2lfc3ludGF4LnRl
eCNMNzgzCgpDYW4gdGhlIGNvbnN0cnVjdCDigJw8Ky4uLiDigKYgLi4uKz7igJ0gYmVjb21lIHJl
bGV2YW50IGhlcmU/CgoKV291bGQgeW91IGxpa2UgdG8gY29uc2lkZXIgYW55IGZ1cnRoZXIgc29m
dHdhcmUgZGVzaWduIGNvbnNlcXVlbmNlcwphcm91bmQgdGhlIHNhZmUgYXBwbGljYXRpb24gb2Yg
dGhlIGFzdGVyaXNrIGZ1bmN0aW9uYWxpdHkgaW4gcnVsZXMKZm9yIHRoZSBzZW1hbnRpYyBwYXRj
aCBsYW5ndWFnZT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2
LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
