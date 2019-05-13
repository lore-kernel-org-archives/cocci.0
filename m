Return-Path: <SRS0=7Hyx=TN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBD0C04AA7
	for <cocci@archiver.kernel.org>; Mon, 13 May 2019 12:23:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3989B2085A
	for <cocci@archiver.kernel.org>; Mon, 13 May 2019 12:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="qsE0OJiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3989B2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x4DCNACX017457
          ; Mon, 13 May 2019 14:23:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 898287751;
	Mon, 13 May 2019 14:23:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 14AE0773E
 for <cocci@systeme.lip6.fr>; Mon, 13 May 2019 14:23:09 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x4DCN7gU005139
 ; Mon, 13 May 2019 14:23:07 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1557750174;
 bh=20TVBHRuTWtg0alTE2UCtQ/s952TDCeQX9+E0IqGVcg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=qsE0OJiBQbEK4Ml5D1pPa/IEt+pNscq2taNdMXAD2Of/o9tDbe5JKcyslNkc3V22K
 4UjVB+FGbG/gXVqFGDcB+qOsYoEJ9MibVyluvVtm9KVGRuot6qF+W4yF2XK6dEDdmc
 9O/+OJGUdoXEHXKpvSawdRywzE+130nt+ceH8yWs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.147.80]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSGXj-1hFLIj2vlr-00TWlW; Mon, 13
 May 2019 14:22:54 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
 <6f08d4d7-5ffc-11c0-8200-cade7d294de6@web.de>
 <alpine.DEB.2.20.1905131130530.3616@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <66250f72-c433-28c7-a224-6f248339ec4c@web.de>
Date: Mon, 13 May 2019 14:22:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905131130530.3616@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:Z+kVEjxzeiese5IioESc091OQOP+yS11c4nDuaM7p2xzPWhUsPz
 h1aBiOrUX/YGa1uUDwWhdPiGo8BkccdpRXp+4Rxp/RIwzrtkG0sTk8RdG/qRGu0UwF/xn+u
 JItgEx2ijotITjazC+z/FIMI/nOzkfsgLosmXEhvQv5k7Pbi19yAA5ADtdTa5MovgLyQGRG
 tyiMga3JoennL8b0qOSWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B9xl4uTWLwA=:PemekqlA209qJ1xFCCw78y
 2gxvVMU46Qr74cvHkxncpGRtkVh3joLxdZq5qy/g5R/fVhhIsGRk1bRyExk+1HJnh5M3v5Yrx
 UHaJAAwR9W0SBZWJhPqfe3cIqE0L1gYJMk50l+FvZOIw8W6T8ChpSIA0ukTBZ+RTay5zHvctW
 YynPVLa0i3VW8uObat+YubHWeq9EItUQ4ool9fJ+eJmA51wzVb5mwTF3YYB9lWsXZ3o9gPRRv
 xAZO/6ywSy98QeKsX0zHov8smVJ08TYn9ZoJeYHjrzLN2gIzXITDFxamX30tcfQ6y3prI4dVN
 2EUXuNLSWqcWIUb7KBweOj/PXFIhw6Al9LleC2VRGjLYDXhI81E+h3Rp2ehT+BAvfOc5CMM84
 Bz5ceIa2aioOrZiM2Bbv1QGNaqsodpnFCKpy+39tszBlCkMawi2VcG1x4VN8YkIw96cyuLPdq
 RB0Qr8xz0UV+8IuJwjilqQvoVfmtIWO5h7JnGAkaYJflXoZLq56002V7N2pR8VH8JZzevJXgo
 SCrZHwwaWWGy02I6SEWDGN1kaBnesGZrqLgp0jfPyO4Yqtt3eBy8L85EYQoBMDe+GfILGjfjU
 gHHaUfgaxn0lHyufgkQuaTIlLlBDiHzb6VDpFelvsgn0DqVkoVxTWCcSVPZfS9bFG7v4/sSIR
 XMn+SKqVeX7DWPTikJL0+PNYbQIpP02Nwt1t3nU7V6MA4kGb2/0SsG2e9Jp4pVZSh4zui1jSw
 ggYo8N4jtVlc9O7xMIuQvZ9SuG6cjdX5sbZQniBDEl/F7aHKFHfS8Fu34HXY2+5+NI+hLKjbY
 26l9a7ATwu3kHArrMBLRYGkG8roNeipgrhxjET3xeIRGXQvkHh2vHxJ8yS/cUlLYyAVGlpIFa
 kvEHNSlyRFnOkfqQN4xbJKNLJI33E8AseawvYQqYZmbNl5yL5u4s7HvpmhUR9UT6uqX4GAzpc
 ZgAHB/w6BGg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 13 May 2019 14:23:11 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 13 May 2019 14:23:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [4/5] Coccinelle: put_device: Extend when constraints
 for two SmPL ellipses
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

Pj4gVGFrZSBhZGRpdGlvbmFsIGNhc3RzIGZvciB0aGVzZSBjb2RlIGV4Y2x1c2lvbiBzcGVjaWZp
Y2F0aW9ucyBpbnRvIGFjY291bnQKPj4gdG9nZXRoZXIgd2l0aCBvcHRpb25hbCBwYXJlbnRoZXNl
cy4KPgo+IE5BQ0suCgpJIGZpbmQgdGhpcyByZWplY3Rpb24gc3VycHJpc2luZy4KCgo+IFlvdSBk
b24ndCBuZWVkIHNvIG1hbnkgdHlwZSBtZXRhdmFyaWFibGVzLgoKSSBnb3QgYW4gb3RoZXIgc29m
dHdhcmUgZGV2ZWxvcG1lbnQgb3BpbmlvbiBmb3IgdGhpcyBhc3BlY3QuCgpZZXN0ZXJkYXkgd2Ug
c3RhcnRlZCB0byBjbGFyaWZ5IGNvbnNlcXVlbmNlcyBmcm9tIHRoZSBpc29tb3JwaGlzbSBzcGVj
aWZpY2F0aW9uCuKAnGRyb3BfY2FzdOKAnSAoZm9yIFNtUEwgY29kZSkuCmh0dHBzOi8vZ2l0aHVi
LmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvYmxvYi8zMmQzYjg5YWQ5MDkzMTY0NjQzNDRhNWY2
MWE4MDkyZDhkNzAyMzIxL3N0YW5kYXJkLmlzbyNMNTIKCkluZm9ybWF0aW9uIGxpa2UgdGhlIGZv
bGxvd2luZyBpbmZsdWVuY2VkIG15IGRlc2lnbiBkZWNpc2lvbiB0byBhZGQgdGhyZWUKbWV0YXZh
cmlhYmxlcyBoZXJlLgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0xpbnV4L25leHQtcGF0Y2hl
ZD4gc3BhdGNoIC0tcGFyc2UtY29jY2kgc2NyaXB0cy9jb2NjaW5lbGxlL2ZyZWUvcHV0X2Rldmlj
ZS5jb2NjaQrigKYKd2FybmluZzogaXNvIGRyb3BfY2FzdCBkb2VzIG5vdCBtYXRjaCB0aGUgY29k
ZSBiZWxvdyBvbiBsaW5lIC0xClQgKFQgKWlkCgpwdXJlIG1ldGF2YXJpYWJsZSBUIGlzIG1hdGNo
ZWQgYWdhaW5zdCB0aGUgZm9sbG93aW5nIG5vbnB1cmUgY29kZToKVArigKYKCgo+IFR5cGUgbWV0
YXZhcmlhYmxlcyBpbiB0aGUgc2FtZSAuLi4gY2FuIGJlIHRoZSBzYW1lLgoKSSB3b3VsZCBmaW5k
IGl0IGFsc28gb2NjYXNpb25hbGx5IG5pY2Ugd2hlbiBtdWx0aXBsZSBTbVBMIGVsbGlwc2VzCmNh
biByZWZlciB0byBpZGVudGljYWwgdHlwZSBjYXN0cy4KCiogVGhlIHVuZGVyLWRvY3VtZW50ZWQg
4oCcdHlwZSBwdXJpdHnigJ0gaGluZGVycyB0aGlzIGF0IHRoZSBtb21lbnQuCgoqIEJ1dCBJIGdv
dCB0aGUgaW1wcmVzc2lvbiB0aGF0IGl0IGNhbiBiZSBzYWZlciB0byBkaXN0aW5ndWlzaCB0aGVz
ZQogIGNvZGUgdmFyaWFudHMgYmV0dGVyLgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2Nj
aUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5m
by9jb2NjaQo=
