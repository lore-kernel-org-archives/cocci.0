Return-Path: <SRS0=XR0D=ZH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1E0C432C3
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2019 11:11:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E59206C0
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2019 11:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="kMpCx0MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E59206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAFBBKRR007974;
	Fri, 15 Nov 2019 12:11:21 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A6B2F77CC;
	Fri, 15 Nov 2019 12:11:20 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5E4AA77C5
 for <cocci@systeme.lip6.fr>; Fri, 15 Nov 2019 12:11:18 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAFBBG8e024652
 for <cocci@systeme.lip6.fr>; Fri, 15 Nov 2019 12:11:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573816272;
 bh=rIVAt5NjqgnjpMg0W6FbKpwXu03opeByzuVXjlt/xYk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=kMpCx0MFGNeqFmp7Yg+P5+/7JNwOLNWSKDky2g4J/4nVIAvB7pFaxrFb41quVVzuL
 XXHdw6HB6HJjK9f240MIMn2ohPIlTUyQjYWeqCKFmsSuIJGAcOpgAHO7/d/CMnExp3
 HJ2br5fDFoBroogrwgse7M9LtPZlZUQAYP3iXAPo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.93.34]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lc8rF-1i4Euj1QcH-00jdkZ; Fri, 15
 Nov 2019 12:11:12 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com>
 <fe9b8c08-6fd4-d378-f3ff-8170381b10e0@web.de>
 <xmqqr22b9ptk.fsf@gitster-ct.c.googlers.com>
 <ba5d609a-16ea-d7e9-66e6-19aab94b2acd@web.de>
 <53346d52-e096-c651-f70a-ce6ca4d82ff9@web.de>
 <6c4ef61f-5fef-ffc8-82d6-ee42006756b4@web.de>
 <aed296a6-bae0-6fcc-515e-ef96fed24ca6@web.de>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6fffd13a-738b-e750-9f5a-f0bfb252855b@web.de>
Date: Fri, 15 Nov 2019 12:11:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <aed296a6-bae0-6fcc-515e-ef96fed24ca6@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:3JLiDdjFnIuaXWVj3YavJ2Ip3X07n3DMfUXqMGH2uQbDQTsZQby
 WBLQnDn//mBgrooUXJydl3vkHd3LR4NTXh43P+hIH2LFQ0WWs/zQRcjdlLLpWbOOsIyhVOc
 PRvVsH1tuQcZglM/TxsCmVZCyGO8MC2M0W427kGHNjIRF3OT+NSHm4Qz1je4VIv7i7b9Rne
 pc5nGRLzeufQle1sJn32A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dsz2rt24rOc=:iDonXNDM+FivrzBIdami0U
 74zHMaOPGb6F2YG8fwTb1W6tzOV3vULMmQ2v/nmkdmr8KAxJuMemB5tozKTxuE8AIfG0gnSiK
 a3y5IWgI3XClN6nVxmMukqxDHeYwSpK3PrYEzX/lLoAcf7lVOoizn6gDqT9Qahx02hOYa6FKC
 VkecWm9onmPJVb1+RQFTEtJa0eE1iIuwUxSbS2kCmsWGoCFnCfSjgRobjEZfa80sJfJP2xnjh
 9HNgJUus9mAs01Aj2CDhdnfN5n/xEObn8DhgkUcjus5ni7ASJZRUhhHNRWNtoaOELWpRSggkG
 clchrldo4g7JzSEW/hYnOUwUDZrxQj7yEVF6zaWursPbEi9Vc4Yaa2rNtlEBODd5tQ60QWTsX
 zua5DJV56NC+Nx0DLDLhsIsitVGAKUUSvT8EheCEZh7rgNcaheDKPuS5xtxKjxPHZ5i4wmWfG
 v3OmiZvnilR+YjVntSGml/FSc4fT49Yx8TC3pDHZ82Dqr6LSs3Q/ZoTIvpVRk+NA6qt0jH+k8
 CpTwyRN9//sG/tFAARdBbJTyWxIFunhG86BYQ7bz1STA//wYqNaUYsWC8/k5i1fAHzCb7YRw5
 5KOy2SHaC4rOkYx7HRq0jZwSusgIT7Sec2mVlyVoFENBGy4i6oX4qx1TdHvAFeJ5EK7mf/TM3
 nIU4orzn4qPvUeYK4nbqf/LA6nW3rtmgbzC4Ob6odA7S8bS1K0yYZgG6jmtRALidSd6AJ3klR
 +lsbBFuYE8rctWlHt97ot1suQDRyCHByOiSXK+ri2KLfORNMgyTd0Lz1EfmWbJ4iKYLHAbIKW
 hX76Sq6AyowatitNJMf2UmEtutrUxFVkPM9TVpl7AfFKJx11R/n6Xwb0w7e2AO1mKba2Nm8ab
 gHIE2Zz3F0p/mNW9s8RddCIjQ2mWl8GpcNE/LFoL2uQSiod8VORy4y+RdshXpZsnt3T9ar4xh
 blVDqWZmJbzOV3awP1kZu8aBOHzw9JGFkrb22/3USu7/mgWjunE5wSgo3UoQkfty35QHSxZwq
 c5SBe4u4n3NpZsFoRjNWFvTO3miL0Prk1WJ3jFgpLNtV0d80Ng4jG1KoNK2HlDuXDz6Qv4eax
 qgRzNJVW9Gd3CT+nrbUUhO1sDFnR0KFnhTQIBbIC+Qzmb+bSW273/8MPBgq2Eqb7uQZi6BrKt
 yBXdtqxlNzB7024K19JIEwXvd7giU7lZn4+Y5Vw19NRGadOcCcQTSyNbqP+4X7jgLmIXPoT3p
 CkObWukdSScOpYTvoifMzFxuo3JSH3l/tkcXYHnKUHZxCXkFB6gHLLATvGk4=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 15 Nov 2019 12:11:22 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 15 Nov 2019 12:11:17 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [Cocci] git-coccinelle: adjustments for array.cocci?
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

PiBBbnl3YXksIHNvbWVvbmUgd2hvIGNhbiByZXByb2R1Y2UgdGhlIGlzc3VlIHVzaW5nIHRoZSBs
YXRlc3QgcmVsZWFzZQo+IG9mIENvY2NpbmVsbGUgd291bGQgYmUgaW4gYSBiZXR0ZXIgcG9zaXRp
b24gdG8gZmlsZSBhIGJ1ZyByZXBvcnQuCgpIZWxsbywKCkkgcmVwZWF0ZWQgdGhlIGRpc2N1c3Nl
ZCBzb3VyY2UgY29kZSB0cmFuc2Zvcm1hdGlvbiBhcHByb2FjaCB0b2dldGhlcgp3aXRoIHRoZSBz
b2Z0d2FyZSBjb21iaW5hdGlvbiDigJxDb2NjaW5lbGxlIDEuMC44LTAwMDA0LWc4NDIwNzVmN+KA
nSAoT0NhbWwgNC4wOSkuCmh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUv
Y29tbWl0cy9tYXN0ZXIKCjEuIFllc3RlcmRheSBJIGNoZWNrZWQgdGhlIHNvdXJjZSBmaWxlcyBv
dXQgZm9yIHRoZSBzb2Z0d2FyZSDigJxHaXTigJ0KICAgYWNjb3JkaW5nIHRvIHRoZSBjb21taXQg
4oCcVGhlIGZpcnN0IGJhdGNoIHBvc3QgMi4yNCBjeWNsZeKAnS4KICAgaHR0cHM6Ly9naXRodWIu
Y29tL2dpdC9naXQvY29tbWl0L2Q5ZjZmM2I2MTk1YTBjYTM1NjQyNTYxZTUzMDc5OGFkMTQ2OWJk
NDEKCjIuIEkgcmVzdG9yZWQgYSBwcmV2aW91cyBkZXZlbG9wbWVudCBzdGF0dXMgYnkgdGhlIGZv
bGxvd2luZyBjb21tYW5kLgoKICAgZ2l0IHNob3cgOTIxZDQ5YmU4NiB8IHBhdGNoIC1wMSAtUgoK
ICAgU2VlIGFsc286CiAgIGh0dHBzOi8vcHVibGljLWluYm94Lm9yZy9naXQvNTMzNDZkNTItZTA5
Ni1jNjUxLWY3MGEtY2U2Y2E0ZDgyZmY5QHdlYi5kZS8KCjMuIEkgc3RvcmVkIGEgZ2VuZXJhdGVk
IHBhdGNoIGJhc2VkIG9uIHRoZSBjdXJyZW50bHkgcmVsZWFzZWQgU21QTCBzY3JpcHQuCiAgIGh0
dHBzOi8vZ2l0aHViLmNvbS9naXQvZ2l0L2Jsb2IvMTc3ZmJhYjc0N2RhNGY1OGNiMmE4Y2UwMTBi
MzUxNWM4NmRkNjdjOS9jb250cmliL2NvY2NpbmVsbGUvYXJyYXkuY29jY2kKCjQuIEkgYXBwbGll
ZCB0aGUgZm9sbG93aW5nIHBhdGNoIHRoZW4uCgpkaWZmIC0tZ2l0IGEvY29udHJpYi9jb2NjaW5l
bGxlL2FycmF5LmNvY2NpIGIvY29udHJpYi9jb2NjaW5lbGxlL2FycmF5LmNvY2NpCmluZGV4IDQ2
YjhkMmVlMTEuLjg5ZGYxODRiYmQgMTAwNjQ0Ci0tLSBhL2NvbnRyaWIvY29jY2luZWxsZS9hcnJh
eS5jb2NjaQorKysgYi9jb250cmliL2NvY2NpbmVsbGUvYXJyYXkuY29jY2kKQEAgLTEyLDI3ICsx
MiwyMSBAQCBUICpwdHI7CiBUW10gYXJyOwogZXhwcmVzc2lvbiBFLCBuOwogQEAKLSgKLSAgbWVt
Y3B5KHB0ciwgRSwKLS0gbiAqIHNpemVvZigqKHB0cikpCi0rIG4gKiBzaXplb2YoVCkKLSAgKQot
fAotICBtZW1jcHkoYXJyLCBFLAotLSBuICogc2l6ZW9mKCooYXJyKSkKLSsgbiAqIHNpemVvZihU
KQotICApCi18Ci0gIG1lbWNweShFLCBwdHIsCi0tIG4gKiBzaXplb2YoKihwdHIpKQotKyBuICog
c2l6ZW9mKFQpCi0gICkKLXwKLSAgbWVtY3B5KEUsIGFyciwKLS0gbiAqIHNpemVvZigqKGFycikp
Ci0rIG4gKiBzaXplb2YoVCkKLSAgKQorIG1lbWNweSgKKyggICAgICAgcHRyLCBFLCBuICoKKy0g
ICAgICAgc2l6ZW9mKCoocHRyKSkKKysgICAgICAgc2l6ZW9mKFQpCit8ICAgICAgIGFyciwgRSwg
biAqCistICAgICAgIHNpemVvZigqKGFycikpCisrICAgICAgIHNpemVvZihUKQorfCAgICAgICBF
LCBwdHIsIG4gKgorLSAgICAgICBzaXplb2YoKihwdHIpKQorKyAgICAgICBzaXplb2YoVCkKK3wg
ICAgICAgRSwgYXJyLCBuICoKKy0gICAgICAgc2l6ZW9mKCooYXJyKSkKKysgICAgICAgc2l6ZW9m
KFQpCiApCisgICAgICAgKQoKIEBACiB0eXBlIFQ7CgogICBJIHN1Z2dlc3RlZCBpbiB0aGlzIHdh
eSB0byBtb3ZlIGEgYml0IG9mIFNtUEwgY29kZS4KCjUuIEkgc3RvcmVkIGFub3RoZXIgZ2VuZXJh
dGVkIHBhdGNoIGJhc2VkIG9uIHRoZSBhZGp1c3RlZCBTbVBMIHNjcmlwdC4KCjYuIEkgcGVyZm9y
bWVkIGEgY29ycmVzcG9uZGluZyBmaWxlIGNvbXBhcmlzb24uCgotLS0gYXJyYXktcmVsZWFzZWQu
ZGlmZgkyMDE5LTExLTE0IDIxOjI5OjExLjAyMDU3NjkxNiArMDEwMAorKysgYXJyYXktcmVkdWNl
ZDEuZGlmZgkyMDE5LTExLTE0IDIxOjQ1OjU4LjkzMTk1NjUyNyArMDEwMApAQCAtNiwyNCArNiwx
MCBAQAogIAlyLT5lbnRyeV9jb3VudCA9IHQtPmVudHJ5X2NvdW50OwogIAlyLT5kZWx0YV9kZXB0
aCA9IHQtPmRlbHRhX2RlcHRoOwogLQltZW1jcHkoci0+ZW50cmllcyx0LT5lbnRyaWVzLHQtPmVu
dHJ5X2NvdW50KnNpemVvZih0LT5lbnRyaWVzWzBdKSk7Ci0rCUNPUFlfQVJSQVkoci0+ZW50cmll
cywgdC0+ZW50cmllcywgdC0+ZW50cnlfY291bnQpOworKwltZW1jcHkoci0+ZW50cmllcyx0LT5l
bnRyaWVzLHQtPmVudHJ5X2NvdW50KnNpemVvZigqKHQtPmVudHJpZXMpKSk7CiAgCXJlbGVhc2Vf
dHJlZV9jb250ZW50KHQpOwogIAlyZXR1cm4gcjsKICB9Ci1kaWZmIC11IC1wIGEvcHJldHR5LmMg
Yi9wcmV0dHkuYwotLS0tIGEvcHJldHR5LmMKLSsrKyBiL3ByZXR0eS5jCi1AQCAtMTA2LDggKzEw
Niw4IEBAIHN0YXRpYyB2b2lkIHNldHVwX2NvbW1pdF9mb3JtYXRzKHZvaWQpCi0gCWNvbW1pdF9m
b3JtYXRzX2xlbiA9IEFSUkFZX1NJWkUoYnVpbHRpbl9mb3JtYXRzKTsKLSAJYnVpbHRpbl9mb3Jt
YXRzX2xlbiA9IGNvbW1pdF9mb3JtYXRzX2xlbjsKLSAJQUxMT0NfR1JPVyhjb21taXRfZm9ybWF0
cywgY29tbWl0X2Zvcm1hdHNfbGVuLCBjb21taXRfZm9ybWF0c19hbGxvYyk7Ci0tCW1lbWNweShj
b21taXRfZm9ybWF0cywgYnVpbHRpbl9mb3JtYXRzLAotLQkgICAgICAgc2l6ZW9mKCpidWlsdGlu
X2Zvcm1hdHMpKkFSUkFZX1NJWkUoYnVpbHRpbl9mb3JtYXRzKSk7Ci0rCUNPUFlfQVJSQVkoY29t
bWl0X2Zvcm1hdHMsIGJ1aWx0aW5fZm9ybWF0cywKLSsJCSAgIEFSUkFZX1NJWkUoYnVpbHRpbl9m
b3JtYXRzKSk7Ci0KLSAJZ2l0X2NvbmZpZyhnaXRfcHJldHR5X2Zvcm1hdHNfY29uZmlnLCBOVUxM
KTsKLSB9CiBkaWZmIC11IC1wIGEvcGFja2ZpbGUuYyBiL3BhY2tmaWxlLmMKIC0tLSBhL3BhY2tm
aWxlLmMKICsrKyBiL3BhY2tmaWxlLmMKQEAgLTM2LDE3ICsyMiw2IEBACiAgCQl9IGVsc2Ugewog
IAkJCUFMTE9DX0dST1cocG9pX3N0YWNrLCBwb2lfc3RhY2tfbnIrMSwgcG9pX3N0YWNrX2FsbG9j
KTsKICAJCX0KLUBAIC0xNjk4LDggKzE2OTgsOCBAQCB2b2lkICp1bnBhY2tfZW50cnkoc3RydWN0
IHJlcG9zaXRvcnkgKnIsCi0gCQkgICAgJiYgZGVsdGFfc3RhY2sgPT0gc21hbGxfZGVsdGFfc3Rh
Y2spIHsKLSAJCQlkZWx0YV9zdGFja19hbGxvYyA9IGFsbG9jX25yKGRlbHRhX3N0YWNrX25yKTsK
LSAJCQlBTExPQ19BUlJBWShkZWx0YV9zdGFjaywgZGVsdGFfc3RhY2tfYWxsb2MpOwotLQkJCW1l
bWNweShkZWx0YV9zdGFjaywgc21hbGxfZGVsdGFfc3RhY2ssCi0tCQkJICAgICAgIHNpemVvZigq
ZGVsdGFfc3RhY2spKmRlbHRhX3N0YWNrX25yKTsKLSsJCQlDT1BZX0FSUkFZKGRlbHRhX3N0YWNr
LCBzbWFsbF9kZWx0YV9zdGFjaywKLSsJCQkJICAgZGVsdGFfc3RhY2tfbnIpOwotIAkJfSBlbHNl
IHsKLSAJCQlBTExPQ19HUk9XKGRlbHRhX3N0YWNrLCBkZWx0YV9zdGFja19ucisxLCBkZWx0YV9z
dGFja19hbGxvYyk7Ci0gCQl9CiBkaWZmIC11IC1wIGEvY29tcGF0L3JlZ2V4L3JlZ2V4ZWMuYyBi
L2NvbXBhdC9yZWdleC9yZWdleGVjLmMKIC0tLSBhL2NvbXBhdC9yZWdleC9yZWdleGVjLmMKICsr
KyBiL2NvbXBhdC9yZWdleC9yZWdleGVjLmMKCgpIb3cgZG8geW91IHRoaW5rIGFib3V0IHRoZSBk
aWZmZXJlbmNlcyBmcm9tIHRoaXMgdGVzdCByZXN1bHQ/CgpSZWdhcmRzLApNYXJrdXMKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBs
aXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFu
L2xpc3RpbmZvL2NvY2NpCg==
