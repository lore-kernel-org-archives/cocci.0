Return-Path: <SRS0=2FHN=YM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0848CA9EAB
	for <cocci@archiver.kernel.org>; Sat, 19 Oct 2019 16:04:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCAD20869
	for <cocci@archiver.kernel.org>; Sat, 19 Oct 2019 16:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="mrZlfmlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCAD20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9JG4f5F014309;
	Sat, 19 Oct 2019 18:04:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 31C0677B8;
	Sat, 19 Oct 2019 18:04:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 06A7F7792
 for <cocci@systeme.lip6.fr>; Sat, 19 Oct 2019 18:04:40 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9JG4d0G018892;
 Sat, 19 Oct 2019 18:04:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571501079;
 bh=LRDUsn9nILVDi+pJGJCqdf3IFdbEl/c4WCFiPEJSwk8=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=mrZlfmlmF0PoLYMrcDxtB54fvoZfocMOpsgo0nDexMD/RO2PKQIJy+rSXCKg+ZWqf
 ogCESPQlUbxfDMtuEHf3fh9pBVTbPVNan0RCDJ+TPjqjcrWz3/cLX/bgEP+Y0UUlv0
 XYfmt9wIaW+cZcwkR1SMHubEvGBc7hKAQ2rv3F0E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.29.47]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKa0t-1iM8CP3cV5-001zCA; Sat, 19
 Oct 2019 18:04:38 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <45be389f-23f9-cbff-fa5f-8ad111124f94@web.de>
 <alpine.DEB.2.21.1910181530460.3697@hadrien>
 <1a3776fe-7f18-e072-9bda-30d10ffd1c07@web.de>
 <32b67cc6-0dd9-6615-d8ed-5c2dfe2af863@web.de>
 <alpine.DEB.2.21.1910191740020.3272@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dd53c9c2-7ca0-7fb0-deaa-e9ff26c7f90a@web.de>
Date: Sat, 19 Oct 2019 18:04:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910191740020.3272@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:Tau/ZhFA91t1iq8mgAX8+JhCExFmztH0Ouo/JNvu40tnl1La91g
 Ik9/cymgp0ww8SWN0ZRfmTv8XZrIMIJ8H0TyixYsacaaDyHuCptHF1tMKH/mXb8Omnh7M+R
 fv35fYPPWLp6lbC+axpDeayA98g3wSaP54u5NflPj5bMtYe/Jo5lkSdh6eZe8MrbpHGItNT
 yd55prIO20CokpmPSFMQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xqs44B42YzE=:1Wxykqp9A37X9GJy/xw0fw
 PRPNZQKLnumMqj0HW4ck0aywA6+q2/yg/m9Ebj/2PQdL1is6sP1DiZAXx2Ks9K+GQzsnfuAcL
 YnWYY2/BNdIzTM5XILjYMM1fGm3OoIMYUwx67c3le4WwOqSIkvyv6SOU8oO7uNo9X8yJmafoB
 faE8mWtm8FDlk57t5i4Re/hWVvD3C5VawgcVjcKRf1RFrVDVTE9fF6bZ/Js8uc1S0sQye7cUx
 LcldO7/uG393f0JrAmIzvH3W9YgI2A8OkcIbZtufldNDr4lYzWmVze4xSmUpxQ0QoIYnPoqUH
 bxpN6d8kFNUzmEmoinq+ecekBshFr5icth0ZgkNNHtZ+6j0WnUQ9c5YbSMDm61jvgmBVFP6Al
 eUZP1WDmrDU82kWHYt+1Af537ARYskdxOCWuAJlw/6rFCr111b44ntJ368GTtvBjhL8ZEpdO0
 Fg8GmmxWRm9KmTjXSZcIMpLT27OtyGbBdYgDatdBjhHcO9XO6b8jbiBFShpmu3JomL63Q6AQ5
 DLVzWXjboiyPwTdr6IRDdI/lDPyK7Z/D9IU11jWChWiBdY7E7RVItWk4VCZIK1JKVCMyqQuY5
 BzQOu7mms2PSpEyRMs3SAYZH5zR34zfjO1V3ZTDRSRAWUDpeReUOqGucmbq4a6KUjCLfOuh6C
 Qil2RJn6Bz6esQ6LCjKZyeyLTgRmbneLUMy2a4FECW2cUx2kfH5zKJbUTs8NRh7LgCvzIa47h
 bzK56ALk5Q6w3HiM0B6DwBl1JeXUQsbvx1wVxfJ3FSpnAyyA5QM/Lpb8O6om+cqitQzt/7feL
 wV/dDS4GoDCS5dq0vSyYIgNLftzgkVSw+65XLSlfQjFryJR6ELfVZXhja8xANATzZ2gQnw5wX
 4nkfB91WfYhfxM1bQViq9yYdMh0ehY9raKKaxmJOr64daYehhlZebq2WKNSUCONXEVrnxx/MN
 p1dR9AG8lJe6fwstQfcBGq+jNqPiEQ5VkAnRAs5Q00BXB2Xo2vHkpebtbmPframHtb/TJc+97
 fllJe7BO2AjCWF61bDwSiz6SbYfBOMj4jrvSE4Hw47oO1ytYbsjckIloIH+p2HdNY5PIBU6RM
 ds+L0O4CNf4V6xb4ClD7/jbvB2KNFVYNH8LaSu2x880/ESNvHjm7W10tsKogDUh4eKKfRLVLC
 MJWKFNvNnuOzPJwXItscrC7OUuXNoYcLRuYack47h0+rdw2L/RIY9ehNLU4LMTAffhz5k7oBI
 S59gLoPlMZB1Rhy/nbJG5J6eZSVQKjrJMcrGE9P57/l/g/d7T9tagFXLrEG0=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 19 Oct 2019 18:04:41 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 19 Oct 2019 18:04:39 +0200 (CEST)
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

Pj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9s
aW51eC1uZXh0LmdpdC90cmVlL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29t
ZWRhX2Rldi5jP2lkPWM0Yjk4NTBiMzY3Njg2OWFjMGRlZjU4ODVkNzgxZDE3ZjY0YjNhODYjbjIy
Mgo+Pgo+PiDigKYKPj4gQEAgLTIyMizigKYgQEAgc3RydWN0IGtvbWVkYV9kZXYgKmtvbWVkYV9k
ZXZfY3JlYXRlKHN0cgo+Pgo+PiAgCWNsa19wcmVwYXJlX2VuYWJsZShtZGV2LT5hY2xrKTsKPj4K
Pj4gLQltZGV2LT5mdW5jcyA9IHByb2R1Y3QtPmlkZW50aWZ5KG1kZXYtPnJlZ19iYXNlLCAmbWRl
di0+Y2hpcCk7Cj4+ICAJaWYgKCFrb21lZGFfcHJvZHVjdF9tYXRjaChtZGV2LCBwcm9kdWN0LT5w
cm9kdWN0X2lkKSkgewo+PiDigKYKPj4gCW1kZXYtPmZ1bmNzLT5pbml0X2Zvcm1hdF90YWJsZSht
ZGV2KTsKPj4KPj4gCWVyciA9IG1kZXYtPmZ1bmNzLT5lbnVtX3Jlc291cmNlcyhtZGV2KTsKPj4g
4oCmCj4+Cj4+Cj4+IE5vdyBJIHdvdWxkIGFwcHJlY2lhdGUgb25jZSBtb3JlIGlmIHRoZSBkZXNj
cmlwdGlvbiBmb3IgdGhlIHN1cHBvcnRlZAo+PiBzb2Z0d2FyZSBiZWhhdmlvdXIgY2FuIGJlIGNv
bXBsZXRlZCBmb3IgdGhlIHNhZmUgdXNhZ2Ugb2YgU21QTAo+PiBjb2RlIGV4Y2x1c2lvbiBzcGVj
aWZpY2F0aW9ucy4KPj4gSSBzZWUgdGhhdCBhIGZ1bmN0aW9uIHBvaW50ZXIgaXMgYXBwcm9wcmlh
dGVseSB1c2VkIGhlcmUuCj4+IFRodXMgSSB3b25kZXIgd2hlcmUgbXkgdW5kZXJzdGFuZGluZyBv
ZiB0aGUgc29mdHdhcmUgc2l0dWF0aW9uIGFyb3VuZAo+PiB0aGUgcHJvZ3JhbSDigJxzcGF0Y2ji
gJ0gc2VlbXMgc3RpbGwgdG9vIGluY29tcGxldGUuCj4KPiBJIGhhdmUgbm8gaWRlYSB3aGF0IHlv
dSBhcmUgYXNraW5nIGFib3V0IGhlcmUuCgpJIGhvcGUgdGhhdCBvdXIgY29tbXVuaWNhdGlvbiBk
aWZmaWN1bHRpZXMgY2FuIGV2ZW50dWFsbHkgYmUgcmVkdWNlZAphbHNvIGF0IHRoaXMgcGxhY2Uu
CgoKPiBBcmUgeW91IGNvbmNlcm5lZCB0aGF0IHlvdSBkb24ndCBrbm93IHRoZSByZXR1cm4gdHlw
ZSBvZiBtZGV2LT5mdW5jcy0+aW5pdF9mb3JtYXRfdGFibGU/CgpOby4gLSBJdCBzaG91bGQgYmUg
Y2xlYXIgdGhhdCB0aGlzIGlzIGEgbWVtYmVyIGZ1bmN0aW9uIGNhbGwsIHNob3VsZG4ndCBpdD8K
VGhlIHVzZWQgZnVuY3Rpb24gcG9pbnRlciB3YXMgc2V0IHRvIHRoZSByZXR1cm4gdmFsdWUgZnJv
bSBhIGNhbGwgb2YKdGhlIGZ1bmN0aW9uIOKAnHByb2R1Y3QtPmlkZW50aWZ5KOKApinigJ0uClNo
b3VsZCB0aGUgc3Vic2VxdWVudCBzdGF0ZW1lbnRzIChiZWhpbmQgdGhlIGxpbmUgd2hpY2ggd2Fz
IG1hcmtlZCBieQp0aGUgU21QTCBhc3RlcmlzayBmdW5jdGlvbmFsaXR5IHdpdGggYSBtaW51cyBj
aGFyYWN0ZXIpIHF1YWxpZnkgZm9yCnRoZSBkZXNpcmVkIGV4Y2x1c2lvbiBvZiBwb2ludGVyIGV4
cHJlc3Npb25zIGJ5IGEgU21QTCB3aGVuIGNvbnN0cmFpbnQKZm9yIHRoZSBtZXRhdmFyaWFibGUg
4oCceeKAnT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZy
Cmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
