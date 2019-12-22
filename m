Return-Path: <SRS0=O4HC=2M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF8CC2D0C0
	for <cocci@archiver.kernel.org>; Sun, 22 Dec 2019 14:06:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A483220665
	for <cocci@archiver.kernel.org>; Sun, 22 Dec 2019 14:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ZKcxc+7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A483220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xBME6QHp016930;
	Sun, 22 Dec 2019 15:06:26 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8A03C77D4;
	Sun, 22 Dec 2019 15:06:26 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 00FD97713
 for <cocci@systeme.lip6.fr>; Sun, 22 Dec 2019 15:06:24 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xBME6LCM022968;
 Sun, 22 Dec 2019 15:06:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1577023572;
 bh=fZdwIbEempXk+mzDmtOCh784uO+uWeO8eHUh38o5lak=;
 h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
 b=ZKcxc+7z79zL5ZTFXHZP+SruSb+dQoI+SPeZQT2RUWLCHZelxhG8LuSIIVRI00Dq2
 uD+Rb/fKi8zLwAlGBaAUlXLpKm5Vwi1D2JZcfrHV7C5OxVZPyHCzfAb8qzwvoFuLdT
 dOsZDYVvwGOXtjDL46TzhHKvT3p6Zz3DU6bGIGwk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.52.160]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MY6lc-1iE6vE1NL6-00Uvun; Sun, 22
 Dec 2019 15:06:12 +0100
To: Julia Lawall <julia.lawall@inria.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>, David Lo <davidlo@smu.edu.sg>,
        Ferdian Thung <ferdian.thung@gmail.com>,
        Hong Jin Kang <hjkang.2018@phdis.smu.edu.sg>,
        Jiang Lingxiao <lxjiang@smu.edu.sg>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1323608f-5a8f-2fd6-2202-2b2f6624825d@web.de>
Date: Sun, 22 Dec 2019 15:06:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:vSVumvA6pgXOlkJZjvrr6MI72HJ0RMDVJhTq9BSlNJ68PIB0fhV
 ONuYcSyAacmQL7AG2uwWntqC7miPasFZFrbm5Ic2mhzVW7aZApHWwPCGBITvKzykRFfEAv2
 z31RlCIdVkiA+RPqB162SobhyqKG1Y7lAIoBfB0jaxfO3BoprVp1LApFQKk+AjTnU25Szzt
 thKx+A3Dw236yHaWCqsgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:foJVo4Fj25I=:XwpMj73khE4feK/n+GD78X
 FkXV5vYs6up7LHLS0RDUA+9zCRJvkR5InCrHUdomTKV/76gH9ouGl03n7E/BUURiNJ/FCPVjy
 zCq8tNen1F5qguWxt1hnE/NhKPH8qMV1j9/1ef7aahP+HEeDekM+lpMzeTNkV58mhAlpeEj+K
 odgW9fArw0d9yZnciQblWhmvCk8oGrLXCEs5ILZ4YtjzgPWZaCXFbTwBVBXrdiTGbcarKqc/P
 S40LvnU9sYk+zehaPdN2Emkh5NukvbyHMVaIqdlmoBKEPhCwK5iWZPEgLhDoHD/g2XWJA6HkE
 XHbMeaChQq0K9VqkU/6tPdmGtjngIXgvoN0G7vLqnpbYBzKVcEODl3iM5+OQnDm2SjwLhldTc
 +D1lY8OXudWAeZTdOD0w+vjYQvq8w3qEXVGqM+5qGvrWGAkf8m+4KE2v+4ZZMPqIYVLtZqBgB
 9nbHLI28JRzJ+LizJitJTLCNuOiyJM5DvHWdRMDap+ASp62nQdHSTs1qXLLO1kw34aGfyCNan
 iqL1pM9BFzHAv7J2e9l3P3oeATlBVOEeCQYo/GpsonojpYKW6pqp8r93LyRn0Y8YPet2KPh47
 nsF/tErdpWX+0WYXX2faJlN1DEIUOjjkoTBrWPeu9ziH8TqcsBHr8Lm9G19ttt6+EJ9PKaqu2
 Bl/01AD6j6ipEJnPz81ZODlnBvVGqipJHubICsfDlejd0Bmm8y86ErTvlEDA7df0CmS3my7bM
 Nk4cYhanqA2f7c002VRTQnb6zEaAKLs82k8bhuwhstlJYKql0O8XpqZATS7haqAMAO4Cli6tT
 67miapHbINzXwXLJIMQAzVSYCxcohMaR6p2JoeDEOeEMxxfikZqzg1mZYJ6E9NI5ABzfnQL3A
 oozMgETLoVPJZAEFGFAeM5y3H3WE1IDCVCMq0mXPSZ1irmDgvNj6En3St7iLlIx/RVkghRP8a
 N1kmno+EAlo/3sg9IVDKzkIBDX19WZUAWgmH93syUCe6hOIQVK3MUb8gSFE69wHvVE0XDJVHE
 /78/RnBFYrRqyGWao0OFKAFtXake4Q/WV0QPOfWODMbhfqfYCU29BD5gT+xPucxaS1W+KVU2Y
 ZiUjFyrXqBmxo2HuczPlAe4TethPeGhkSGIVgndEPIuydq7pNiSKh/rIMQ6s8y1Byv22ANmRv
 TzcD8eGs08DxpOEpUzQg7kccKwGaYEuDxs8I6KtONpShbLZiD3pJqjUj3bcXjXTWybdRv0E4c
 i1uwxMPa1IhxCoIw0LmCEEjzqokshu4Ls+os89hNmRgdMUxu/lHQMecMOv7Y=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 22 Dec 2019 15:06:27 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 22 Dec 2019 15:06:21 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: [Cocci] Experiences around program transformations (including Java)
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

SGVsbG8sCgpJIGhhdmUgdGFrZW4gYW5vdGhlciBsb29rIGFsc28gYXQgY29udGVudHMgZnJvbSB0
aGUgZG9jdW1lbnQg4oCcU2VtYW50aWMgUGF0Y2hlcwpmb3IgSmF2YSBQcm9ncmFtIFRyYW5zZm9y
bWF0aW9uIChFeHBlcmllbmNlIFJlcG9ydCnigJ0uCmh0dHBzOi8vZHJvcHMuZGFnc3R1aGwuZGUv
b3B1cy92b2xsdGV4dGUvMjAxOS8xMDgxNC8KaHR0cHM6Ly9keC5kb2kub3JnLzEwLjQyMzAvTElQ
SWNzLkVDT09QLjIwMTkuMjIKCk15IHNvZnR3YXJlIGRldmVsb3BtZW50IGF0dGVudGlvbiBncmV3
IHRoZW4gZm9yIGEgZmV3IGltcGxlbWVudGF0aW9uIGRldGFpbHMuCgoxLiBMaXN0aW5ncyBhcmUg
cHJlc2VudGVkIGZvciBzY3JpcHRzIG9mIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZS4KICAg
SSByZWNvZ25pc2VkIG9wcG9ydHVuaXRpZXMgdG8gd3JpdGUgdGhlbSBpbiBkaWZmZXJlbnQgd2F5
cy4KICAgV291bGQgeW91IGxpa2UgdG8gZGlzY3VzcyBhbnkgdmFyaWF0aW9ucyBmdXJ0aGVyPwoK
Mi4gVGhlIGNvbW1lbnQg4oCc4oCYIDwuLi4g4oCZIGluZGljYXRlcyB0aGF0IGFsbCBvY2N1cnJl
bmNlcyBzaG91bGQgYmUgcmVwbGFjZWTigJ0KICAgd2FzIHNwZWNpZmllZCBpbiB0aGUgbGlzdGlu
ZyAyMi4KICAgSG93IGRvZXMgdGhpcyBpbmZvcm1hdGlvbiBmaXQgdG8gdGhlIGRlc2NyaXB0aW9u
IGZvciB0aGUgdXNhZ2Ugb2YgU21QTCBlbGxpcHNlcwogICAob3IgZG90IHZhcmlhbnRzKSBpbiB0
aGUgc29mdHdhcmUgZG9jdW1lbnRhdGlvbj8KICAgaHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVs
bGUvY29jY2luZWxsZS9ibG9iL2VkMWViOGUwNmY4MDA3MzlkMzk5MjE1OGQzNjk0NWMwYzRjNmYw
YzcvZG9jcy9tYW51YWwvY29jY2lfc3ludGF4LnRleCNMNjk0CgozLiBJIHdvdWxkIGFwcHJlY2lh
dGUgZnVydGhlciBpbXByb3ZlbWVudHMgYWxzbyBhcm91bmQgdGhlIGZvbGxvd2luZyB3b3JkaW5n
CiAgIG9uIHBhZ2UgMjQuCiAgIOKAnOKApgogICBPbmUgcGFpbmZ1bCBhc3BlY3Qgb2Ygd29ya2lu
ZyB3aXRoIENvY2NpbmVsbGU0SiBpcyBpdCBkb2VzIG5vdCBhbHdheXMgcmVwb3J0CiAgIGVycm9y
cyB3aGVuIHBhcnNpbmcgU01QTCBpbiBhIHVzZXItZnJpZW5kbHkgd2F5LiBUaGlzIGxpbWl0YXRp
b24gaXMgaW5oZXJlbnQKICAgaW4geWFjYy1saWtlIHBhcnNlcnMuCiAgIOKApuKAnQoKICAgKiBI
b3cgbWFueSByZXNvdXJjZXMgd2lsbCBiZSBuZWVkZWQgdG8gaW1wcm92ZSB0aGUgc2l0dWF0aW9u
IGluIHNpZ25pZmljYW50CiAgICAgd2F5cyBhbHNvIGluIHRoaXMgYXJlYT8KCiAgICogVW5kZXIg
d2hpY2ggY2lyY3Vtc3RhbmNlcyB3aWxsIGVycm9yIGRpYWdub3N0aWNzIGJlY29tZSBtb3JlIGhl
bHBmdWw/Cgo0LiBIb3cgd2lsbCB0aGUgc3VwcG9ydCBldm9sdmUgZm9yIHRoZSBoYW5kbGluZyBv
ZiBjbGFzc2VzIChvYmplY3Qtb3JpZW50ZWQKICAgcHJvZ3JhbW1pbmcpIGJlc2lkZXMgdGhlIHJl
c3RyaWN0ZWQgZnVuY3Rpb25hbGl0eSBvZiDigJxNaWRkbGV3ZWlnaHQgSmF2YeKAnT8KICAgaHR0
cHM6Ly9jaXRlc2VlcnguaXN0LnBzdS5lZHUvdmlld2RvYy9zdW1tYXJ5P2RvaT0xMC4xLjEuMTQu
NTQxNQoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0
cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
