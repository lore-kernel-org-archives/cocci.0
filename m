Return-Path: <SRS0=0+7Q=ZO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6476BC43215
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 09:45:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D93720708
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 09:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="fHWlpB5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D93720708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAM9jXEI005022;
	Fri, 22 Nov 2019 10:45:33 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7FECB77E3;
	Fri, 22 Nov 2019 10:45:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2D12B77D2
 for <cocci@systeme.lip6.fr>; Fri, 22 Nov 2019 10:45:32 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAM9jV0Q014423;
 Fri, 22 Nov 2019 10:45:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574415931;
 bh=ddgsZ0yudlRDEyPWAnh0B48bxUp2sqBz+d2kAm9FuHU=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=fHWlpB5y+/XCltruqwbg2rQtjH5d54odscFL5VZwHRGFF1qo7sFpwQVRhwYb6JGHV
 GplCsx95QR4cIKxWwxCSpY71VaQ50RP0q2MOOYSRvo918Ti5TcbEIJInBeoHcO4NnZ
 GuloZGLQwOJN773fLdFcCKC0HykgAq96HuZwOb6M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.174.75]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MhDlp-1iBtww18oT-00MLFz; Fri, 22
 Nov 2019 10:45:31 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <cc561358-4d00-9f1f-eaa2-8fae400ccc8b@web.de>
 <alpine.DEB.2.21.1911221025570.2793@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8a44f286-72ad-14c4-6ee9-b8aa25ccba3e@web.de>
Date: Fri, 22 Nov 2019 10:45:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911221025570.2793@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:jXS5rNFv2mGh92GQeR831cUpAA7CiVLFbM+7tUpuNLqatse9PVR
 DJ8O/eFyO+HiKVOXZWzpHHPlQ6FSoPcrup6JxAvdCEYN7/cGaxOVLsijMmRcdl2tq395kYK
 VzKQqT8tOpo7OuTYtGMPUWg135Nj57u8NR9nMxp9OI3mya+8gjDO1yckTlQrMjj5lB/TimL
 o9EnuOxR9CUPtZjMY6qSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SkuPb/Y3KHI=:sPBKYTfmtHUnVjbzPGtu/N
 2VLOksX1Kp/4fEKd46rixbuynXJsuwgUcAJ7VInDGMeTMAjJS+uEMVwf+eNgsd5E7L8g5zFXl
 uXli2rIHv0k6DxLW4rdO2xdW/Vhnz7bbaM6XSv6v9UL5MQNPHh/0AYOxnv55E3cUFcc/tfUzK
 nIBSL1XwdDIP2vtQWQ+UoRoPjztbJIjfq+yqv6Uf0qIclulc1eMMFRDyLDArBhipqZaYLg7dD
 onzXYyWt7Tw1VSWWk8+4r1xo7eLbpWuz4pb7dkpjIUzLShr5GeOAfxPjnOCkTgang/8XODVvE
 zf1cNC+OwBvrCAAQl6Up52VxpCQfhjpev2BiKOb8Kxjyai4cfdYLj326RVE2KZMTt+w/7twUt
 0PbQ0oP3mHM9I442igVapwEUL3R23a8h+cShHNNh71ZuAUy7tfdmPPHJRHMMuFA/+oQ5p1Ovg
 jLNpyDqOz3eTzJwOBb7HwC8GGBguI0a1L5shTKwnzmcW1XL7xM98gdHIA1wky75A/mbY0lBoc
 /tkiO/bgh/QDEi0b8Fo5D0DnCUfR4yZWI3lj1RryzrLkv01K1ATKunMzAPMfhp54b2e/81QNa
 iNng10h3KeVCR9AHXva+rLNhFy929XzY23UxqAxbi4YyA4msJoWM+5YJLQi7WRTxEA7kq1WRF
 gVmFDT90a8OXGvaqJrB2M8AcW3Zq3VQNe0XX2HU780apdZqtz1mJarsUstrnS4pBBMyTGkBAb
 9IXVSWJbiYpQaFP3LxQ/HQYsihoO8l3RpygFgBvEWD6i4eecZa0jS1g/39dRdQ4obMtu54YTH
 d+atEswOSHUMFsIj5D4pGZuv9ykAoqT6s57pAT2IGqvXQOOU1wQsQUC9Gr/nv0WxZFt++En22
 x88gHfPjPEpmf/nQapl9x6hkE7eywqSRQuc6oDVoN26CYoOuuduUc6q+JD/hR3hPZid+d6L7q
 e+YRfba5yuHglEa/7dDsOlSiQaqXYa3X6VI5p4/86g/4X6GpsLEbjACQuBPoko7aAvLh/iXqZ
 fCIdtdaWroutde6KjVHdmAt0JiOR8Pg/fz+X33ehXoUE5hJ/FGdn/pJnmKVL03aA++U1iAsr3
 utzklaaHPzm3YRuyDIPGvK/j78Es5eW6PUE4chuPEV7h7qOWdR2RGgSgLdklYNIrr5Q4meIni
 vJZaXZqW6LPbeo7gauDU4r6E8OXqMfEXEhi+vqicPgH4gupW/hyR+thopNZ5Z/GFeRY5SJzOm
 XbaQZldGm86nyZQUmdB9F54UId3Z0M/H1uCwcx4fc+l2v05zMhCj0D7yNVno=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 22 Nov 2019 10:45:34 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 22 Nov 2019 10:45:31 +0100 (CET)
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

PiBZb3UgY2FuIHNwZWNpZnkgdGhlIHR5cGUgb2YgYW4gZXhwcmVzc2lvbiByYXRoZXIgdGhhbiBq
dXN0IGV4cHJlc3Npb24uCgpIb3cgaXMgdGhpcyBhcHByb2FjaCBkaWZmZXJlbnQgZnJvbSB0aGUg
c2VhcmNoIGZvciDigJxzcGVjaWZpYyBkYXRhIHR5cGVz4oCdCih3aGljaCBJIGtub3cgYWxyZWFk
eSk/CgpJIGNhbWUgYWxvbmcgYW4gdXNlIGNhc2Ugd2hlcmUgYSBnZW5lcmljIHNvdXJjZSBjb2Rl
IHNlYXJjaCBjYW4gZmluZAp1cGRhdGUgY2FuZGlkYXRlcy4gQnV0IGl0IHdvdWxkIGJlIG5pY2Ug
aWYgc2FmZXR5IGNvbmNlcm5zIGNhbiBiZSBoYW5kbGVkCnRoZW4gYnkgdXNpbmcgdGhlIGRldGVy
bWluZWQgZGF0YSB0eXBlcyBzb21laG93LgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2Nj
aUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5m
by9jb2NjaQo=
