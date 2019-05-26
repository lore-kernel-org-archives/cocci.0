Return-Path: <SRS0=ycDg=T2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D03C282E3
	for <cocci@archiver.kernel.org>; Sun, 26 May 2019 13:33:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38EA2075B
	for <cocci@archiver.kernel.org>; Sun, 26 May 2019 13:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="DBg90anY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38EA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4QDXdpx026849;
	Sun, 26 May 2019 15:33:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 060377747;
	Sun, 26 May 2019 15:33:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7B372773A
 for <cocci@systeme.lip6.fr>; Sun, 26 May 2019 15:33:37 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4QDXb20004023;
 Sun, 26 May 2019 15:33:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558877616;
 bh=pYlVDeEvnd4Nmem/3P3XSdqalZcg3GtLfXKTc0tIi64=;
 h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
 b=DBg90anYOLN764MzBa0QFI9XTcXgO0A/ekmwSuNtPRQyK8PdTEc9fNfa6tj7GKKC4
 lmWqFB0eSm0uIkQ8wScBOpuy/q9Yp7de7VuYRH1SrKy0cOh/iqHiujYeO8yvzc0A3G
 LJYL8l53jd+GGMs6Yi7Imke2CPUahYYttyD7at8k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([78.49.116.98]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Llna8-1gvYSe2hSS-00ZLE3; Sun, 26
 May 2019 15:33:36 +0200
To: Julia Lawall <Julia.Lawall@lip6.fr>, Coccinelle <cocci@systeme.lip6.fr>
References: <alpine.DEB.2.21.1905222114490.2618@hadrien>
 <81b409c6-5986-5961-5edf-843c6737d88c@web.de>
 <alpine.DEB.2.20.1905231500230.3573@hadrien>
 <b5c322d3-3162-953f-a985-53abc5064482@web.de>
 <0782D580-3DD6-4419-B5E1-C04215FB2E3B@lip6.fr>
 <d96051ba-3a49-52aa-cc43-b7e4251fde8e@web.de>
 <eaae9aa05a338fd694057897d830181d@lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4526cd3b-a6ef-c9fe-175a-5c3e05c52555@web.de>
Date: Sun, 26 May 2019 15:33:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <eaae9aa05a338fd694057897d830181d@lip6.fr>
Content-Language: en-GB
X-Provags-ID: V03:K1:RZRMjDzvTQW1XDspBJtRFg6bRrKAEJh5QZzaxuJikwffvQ1JAiz
 VIDtXzNBJucvngyR7hlNEsf5b2/rRpcWO4vdKUKKWRl/BYq48zkLhockCl7KDIobPQUvSal
 Xgb3CVZinfDMpapiF7FIZ4q9B4/C52nLdxV13KHoowmRuahqHlmw8UqaxM+hcxjxrce+5Q2
 aanWKwTG9rXdnGgSTGS9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dbni/1Zc5No=:/TXjluUwNcs69vZsNj/wWZ
 qsGxxUGSIrOeEmrZEVmmfNfmYZ02HZvz3Ucy9+KgrQgjnEYuNxOqD9ecRPtf4X6SglmXDr5gF
 H02l3yJ6uFy9NH3yh5j+sQLlRUkx+5BhILrB3sHv73RWoYYrF8fr85Nc10cocr8Qj49PNiK08
 2bgW7tZRKTG5iV6d4JC8WQyhei7xL7ZxwZqAwPzvQKmQbWQ0YQssIjfV+3JMzRxw0zQo4HK52
 YtVn1DuIO/ju12Yh8KXy1d8qOPl1Fvh1iBE5TbHxzGvv/HbsvGQ/VUuRyx9BcAfEkvq3CWSYv
 WTzs85Y1DF90TQ2+i23rpAjTtfyvbS52/HaidfHD2m601l8me5dAhQ2/0eRP1F54AcbI97xxJ
 uxXVdg614tqY+M0kT8BXjUDGBFBmBNUvlvgDeWgLSZTMWoD5DaJdh+nZxHIidFgRKJtYbjMcC
 6EJi3cjiY2DNHSBwIUH1YGTleQJDvCJ961gzVn2dFmw3oXI32MIrXOm2+vBRuhuIlC6nNQdnj
 9Ap01KaMsCQKaz7QmBn/FYKGoGC5hIAH35zwJfuDTmT530G05ey1DaXAP+jSty5FiNofRSot3
 5GDRkOUnlDdVVrOEcqLy9BD02OSedgOv9a2JEExiq32th5/iDFu92SrawGj4hoRngK6okogOg
 uGKASOVRocEaQpI2KDxd0zNUzUvtfd2JjTsTBNaRzQ9Sf8UEadAB7VOyAcSzaNovGlZnqGww9
 DIdrXTIvVMsit5EBdJ83dZfZv71JxD5ulNCsdAH2wrDlI6IaDA0Gd9AnVTj2HfHOgu/Q3TRVG
 ZuzGQCb+RA9q1t11uTUFYbxRSnze+mEcLE1aFdhJ0BcP7Lv58blfPzKjU9LQvYYIZOLbpajpR
 w4dVdUda1UeCR8sydxvrDZK4fmJBEH6NTcd0zfjfUs5t80KoxNYk8moYmQhb3m7+s5zgBrKGX
 DZ9z92AC/OovYBLxv+hJh9jlxp/P9nj0tUYAZ/qj4ZmCi7gizcNVx
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 May 2019 15:33:39 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 26 May 2019 15:33:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] accessing comments
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

Pj4gKiBIb3cgZG8geW91IHRoaW5rIGFib3V0IG15IGV4cGVjdGF0aW9uIHRoYXQgdGhlIE9DYW1s
IHNjcmlwdCBydWxlCj4+IMKgIHNob3VsZCBiZSBldmFsdWF0ZWQgb25seSBvbmNlIGJlY2F1c2Ug
YSBzaW5nbGUgZnVuY3Rpb24gaW1wbGVtZW50YXRpb24KPj4gwqAgZXhhbXBsZSBpcyBhbmFseXNl
ZCBoZXJlPwo+Cj4gVGhlIG11bHRpcGxlIHRpbWVzIGhhdmUgdG8gZG8gd2l0aCB0aGUgLi4uIG5v
dCB0aGUgY29tbWVudCB2YXJpYWJsZXMuCgpJIGRvIG5vdCBleHBlY3Qgc28gZmFyIHRoYXQgdGhl
IFNtUEwgY29kZSDigJwuLi4gd2hlbiBhbnnigJ0gc2hvdWxkIHRyaWdnZXIgdGhyZWUgZGlzcGxh
eXMKZm9yIHRoZSBzaG93biB0ZXN0IGV4YW1wbGUuCgoKPj4gKiBDYW4gdGhlIGRldGVybWluYXRp
b24gd2hpY2ggdGV4dCBzaG91bGQgYmVsb25nIHRvIHRoZSBhdHRyaWJ1dGUKPj4gwqAg4oCcYmVm
b3Jl4oCdIG9yIOKAnGFmdGVy4oCdIGJlY29tZSBtb3JlIGNoYWxsZW5naW5nIGZvciBzdGF0ZW1l
bnQgbWV0YXZhcmlhYmxlcz8KPgo+IFdlIGtub3cgd2hhdCB0b2tlbnMgYXJlIG1hdGNoZWQgYnkg
dGhlIG1ldGF2YXJpYWJsZS7CoCBUaGUgY29tbWVudHMgYXJlIGF0dGFjaGVkIHRvIHRoZSB0b2tl
bnMuCgpIb3cgaXMgdGhlIHNpdHVhdGlvbiB0cmVhdGVkIHRoYXQgYSBjb21tZW50IGlzIGJldHdl
ZW4gdHdvIGV4ZWN1dGFibGUgc3RhdGVtZW50cz8KCgo+IEl0IGlzIHRoZW4gc3RyYWlnaHRmb3J3
YXJkIHRvIG1ha2UgdGhlIHRocmVlIGxpc3RzLgoKSSBkbyBub3QgZGlyZWN0bHkgZm9sbG93IHRo
aXMgdmlldyBhdCB0aGUgbW9tZW50LgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBz
eXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9j
b2NjaQo=
