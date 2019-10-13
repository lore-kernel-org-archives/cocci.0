Return-Path: <SRS0=gEjp=YG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E1EC4360C
	for <cocci@archiver.kernel.org>; Sun, 13 Oct 2019 16:57:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8448D20679
	for <cocci@archiver.kernel.org>; Sun, 13 Oct 2019 16:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="a2kqGZCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8448D20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9DGvTYm016931;
	Sun, 13 Oct 2019 18:57:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A61187784;
	Sun, 13 Oct 2019 18:57:29 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 77AD77415
 for <cocci@systeme.lip6.fr>; Sun, 13 Oct 2019 18:57:27 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9DGvQu1024650;
 Sun, 13 Oct 2019 18:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570985846;
 bh=QizX4gczZ2NdpX5+FOIu1A1zbdHGVN4kFn3SEMoNP08=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=a2kqGZCM5AOd1AHRGKmX2I/CmOS1t/VZCC48GtH1KuWRa7sAW8sPKLo+kbU+uQXGf
 cwed35ZNZEoKa21OojRq6bQOOXXKfYQ59aAp6u1jp1TmKCmiuzMgmNLqTvplJi/RZh
 lw/x0Lo9b+LjOzMlJszKTVdHaVUhe0OXhScmY6gQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.141.172]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUncu-1ia93s1CDk-00YCaH; Sun, 13
 Oct 2019 18:50:48 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1910112200230.3284@hadrien>
 <11a68d96-ace6-889b-596b-e34590b7b965@web.de>
 <alpine.DEB.2.21.1910131806400.2565@hadrien>
 <21abdc24-95d3-be59-0a93-4b60e790a239@web.de>
 <alpine.DEB.2.21.1910131836530.2565@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f6589cb7-ccc0-4b2b-a8bb-26d4c273f756@web.de>
Date: Sun, 13 Oct 2019 18:50:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910131836530.2565@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:/WlvwXITmRzRpkrYjh3RyvVq1CHCU2BUlN8pZANVHd1/ptgcUsW
 fhIo0ww1lJrlK2evnvhpECdFKrvA753KuqkrM3ZaoiwhBNL3eZNZ5aB/l8R4bNUpOK5ht+V
 stli+rMtLpz8ke6Kb9nGD+IxvrAi91DDUC6k37OUUYgYyTqp+hyPPSPH8ICUziHUhRm93xN
 Cyl0ImRcwiL+ZvmunNCaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EXc8E3j+JCY=:4Qx4tJyFaI2TK92RS5KRgN
 qjPBpmG0sAMVVE8mwNVo5MvI8++bgyylU0GQuZIelZZqanxq8hCLYAXhObCeZLvgD+l2b/XLX
 sbAZ3KOeyroi6EyYhzxxKC9lmG1DiUo4Q8eoTQHNUV3HV2RIQXHn1XEOn8LmiVO+8OuIJhJrK
 x4OLrHh2BgLOLm0U1JmBVKsMJyC3fa/prW14+g0ZCQjh1RbGvFK1KJqdFtJbRt5Y8AMz/QOu4
 yVzl1g4nA8CigAw0mvG6gnAUOGeO8UOWjJ/rJPeOOAxpk8vT2BiXro4pNwLBg/V4c+f+aQJDs
 /YTJgfWtFAz7th8M1U6rpzu8xYdUk2mKU81yULKF/kBbHSV8vofSNwUff/2vZebeA07uKHQj8
 3ysPrd0h3z26RaKkymMV7T7Iltew3NqL1r/pPD65jB1Qb+SHC7Vpxp+/in5IUC5C6eyAr2rdz
 aFlp8pnVim9mVVrybUpxyzokdk1zZIQXw4YIR0ru9MrkS/mp3gCqSAGn7w+KjpfhTbb/WHiBl
 WRUAOehZfJnfTive/siWN63gzX3ii9SqfUDWqU4VebmfQPbA9vk/7IrHHIpz3dfY36sPm/x0o
 9Mr5aHHeRvRApgpCSTM0LnziT15BYRm4JRaNTPLeQIlNKffTLZKy5C/C/rr4LBsHKQt61Hi01
 903mgc2ym1otl+ev1AyNwbEj2HNPHdcy7/Efe0eeh5zDSCCtT+7Y1usJ02sypYyXpeaBIR3kN
 QQOgOWZbWtiQXnqoSqrsLA4FOvVaRfHJ5l+UemLf+Bn3knr/5eDikL64LetAkLP1zsWHx8wXf
 RNWggyb6o08HQQL1RNMiURnspjYa13K16BXzt1CM97Oh2lKQJhVCtltYf4WossvuOHLwo/l9m
 2VQHr8Pvo0n94epDnyFP1ntEhffe2oA/zdy/O5P/GcsQ7x+zbrrTTwT59S44BC6bCP1Bqc/aG
 GybAelqSpl2uh+gmTRh2agqOG8z4i2js5WbTRjDANQJNbPC9hazQRlddc1zTYJSF/EG+cBbkU
 J6YwH23sxaNX3BsYHlCpZbOO0itRtJ6P0iBY1GXhxX4AkiIPTOzAgFn2lYFAen6CTW2b3Nen8
 DJZUr9faZWaqXOSP58G6/sbWosTm4CEVxdTIBj+uK8fkN9b0Dne9HqS+yIJ0wOKuEo/PjzfXM
 5+aZXPuap63oCj4XFkcn/QuRYtW7CswHmjAc7Ihu1/noSTqJ8vahYp8QnY8DlpXAd6FrIxpbs
 PZM+he0BWfQDUdZlhrHUS5lhodTyAHlVJjj9HBNrEKykEslvUbNKUFDVw+xw=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 13 Oct 2019 18:57:30 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 13 Oct 2019 18:57:26 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Adjusting macros with SmPL?
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

Pj4gaHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxsZS9jb21taXQvNWUzZjcz
YzczMjA3NWY3YWZhZGYzODNkMDg4ZjNiNmQwZTEzNDViMQo+Cj4gVGhpcyBzZWVtcyBjb21wbGV0
ZWx5IGlycmVsZXZhbnQuCgpJIGdvdCBhbiBvdGhlciB2aWV3IGFsc28gZm9yIHRoaXMgc29mdHdh
cmUgYXJlYS4KSG93IG1hbnkgaXRlbXMgY2FuIGJlIGFzc3VtZWQgYmVoaW5kIHRoZSB3b3JkIOKA
nGV0Yy7igJ0gaW4gdGhlIHNlY3Rpb24g4oCcdXBjb21pbmcvcGxhbm5lZC90b2Rv4oCdPwoKCj4g
VGhlIHF1ZXN0aW9uIHdhcyBhYm91dCAjZGVmaW5lLCBub3QgYWJvdXQgI2lmZGVmLgoKQ2FuIHdl
IGNsYXJpZnkgdGhlIGNvcnJlc3BvbmRpbmcgZGV0YWlscyBiZXR0ZXIgdGhlbj8KCgo+IENoYW5n
ZXMgd2l0aGluICNkZWZpbmUgY29kZSBzaG91bGQgYmUgc3VwcG9ydGVkIGlmIENvY2NpbmVsbGUg
aXMgYWJsZSB0byBwYXJzZQo+IHRoZSBjb2RlIGluZGVwZW5kZW50bHkgb2YgaXRzIHVzYWdlIGNv
bnRleHQuCgpXb3VsZCB5b3UgbGlrZSB0byBzYXkgdGhhdCB0aGUgZGVzaXJlZCBzb2Z0d2FyZSBz
dXBwb3J0IGlzIGNvbXBsZXRlIGhlcmU/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2Np
QHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZv
L2NvY2NpCg==
