Return-Path: <SRS0=XR0D=ZH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F512C432C3
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2019 18:51:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448572072D
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2019 18:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="lEtZAWXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448572072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAFIoxEd013757;
	Fri, 15 Nov 2019 19:51:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B9FAF77CC;
	Fri, 15 Nov 2019 19:50:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 04AB177C5
 for <cocci@systeme.lip6.fr>; Fri, 15 Nov 2019 19:50:58 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAFIouT5018080
 for <cocci@systeme.lip6.fr>; Fri, 15 Nov 2019 19:50:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573843850;
 bh=dv2JdBUW5gbndxZObEHckTbMZGeyCZu2WMaCOyd7UI4=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=lEtZAWXOv/X0UxGX2g8z14V4DG4tCNRxyxDPUrbBr5D4jxG47yxvjtKwR0MY1jl9L
 wi+Y4Vr0+v9y2GoV5Nbj767OKjEhLaN4yQZ8pP3beRyc0UfxiIAZj1hwCzo45Kf8cu
 8tvGy+S/trYBeFDEuVxdiKqhAhCHT99Zb5aBZTp8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.93.34]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCIoz-1iej6Z1jlJ-0099wl; Fri, 15
 Nov 2019 19:50:50 +0100
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>, git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com>
 <fe9b8c08-6fd4-d378-f3ff-8170381b10e0@web.de>
 <xmqqr22b9ptk.fsf@gitster-ct.c.googlers.com>
 <ba5d609a-16ea-d7e9-66e6-19aab94b2acd@web.de>
 <53346d52-e096-c651-f70a-ce6ca4d82ff9@web.de>
 <6c4ef61f-5fef-ffc8-82d6-ee42006756b4@web.de>
 <aed296a6-bae0-6fcc-515e-ef96fed24ca6@web.de>
 <6fffd13a-738b-e750-9f5a-f0bfb252855b@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <94301b9c-a397-ae04-c617-92679f4bb018@web.de>
Date: Fri, 15 Nov 2019 19:50:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6fffd13a-738b-e750-9f5a-f0bfb252855b@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:gF2Wa4xqKvgV34Lm7ioCwEuVgGHx5to0FNnBULlEjvQKXWiT78b
 pVIONiASjQ9CI/3Z15rgrjOTZ3a6AHqHkLQJkAf5fWogP1sJgwpPPY/qBgo/zQrTiQnynBj
 Zk8RZPRYcEmfrCRztvrtsHbqPb5qOmqOpdRrGvyAYWzGwydXEpg1ewzDF2Mp+QJ3Ik3krI5
 rn72eFxtuDCw/8iboikQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TdDLBi86klU=:tgguMzQz2MKodyTIHp9z/8
 hPuPoVM71mk8QCMgqPT6BsV5awo3WQiwzmMEdB8YH6CajVDml/8A+3mJ2WZBIb0SkLKXiFMjL
 3B8NBeShXqYg+CXbmlhxRaaCovbZXqjCiOd3SILDxBJhUG/YegK5MA+BX1HyaFSTE0h6Ie+rJ
 RFMJsD4pBaA88OA0208yxGO0ol+DaZ/WM5ihgvFwh6jNXQ/vPvpRwip4QUsBlu1dfhFGJVlf4
 m8Y7aguqVrTBXcUM+JvzM/umA08FAnm7rZP6QWCGuRR3/9cqtbd0Z8dJv2u0KtnS5NZfy3pM3
 HCIwv1r3YwZCFWO5pPIAXsZqd88WX5w9FeM8WTEUIJ5XzCWT8NpEcx1vna6ADWTVca6ekQrCJ
 a4eUpsiMd4x6Nc18zG7zePMoLsF0KkgNajkIsqE6MLoTlb1qWDCZSyi1qFs+3ia1vnxR8fNTF
 ZelTLELQvXCCTH3UHvB9uejKNRLYiFaYalBwU4JWbOSiotmhRj0ZVxmmoxC6+EMhuTukEwfq+
 wOmWZp45espI2/ina94tRaeOtQQH2TL7KK/zWsBVTkNZa7HfE55xYpmJ/YWFH2IbDweCdfCCD
 Gq9hdXzLw6Ka1bE71Puh7ElCpAc1S5PtCpc+z0y5aaNDsKCcMJLrR4xTC8t59Quf8FCk95KK+
 nPpKNDnjSHoAgyssvspBvL3Pmacz3aV03LAHB8FBuN1gxBabyjMfENQxIla4891mPa6frBe1E
 JfxUOz8VZnrDG90p2zcwZwwx9UROvz1oXiSmrdTF689yKxHc9ALABANmCbuDxKIykqmyAC43H
 YocJlZDTk2Xf0+AgeDLfr+ynCNTGPuACt2mICNEjQfW5ntAs2sB1kfIK9qmg71SG6E1nU0Kgw
 I00GfINWv05O+YnoQzS+MZAess+qcJ/I5VLW6zKhoS3K9ncnfJZFVffF4fT3QeoMlfpkntEB1
 v9rica0WELX5VZ+SNzMBxx7ft7Sbl8mlc2+Q5rvKua0eBeA6L6gU78rhh2L/potfwZwbYnYKO
 uAg7jEP7aRRm2UhA+23qAXZr21fcYBwdTdzaXx2lJoUxvpxtqF0KB30AR6Y/s3fOwK/jhZNX+
 oJ1cQ/NjQeU2g5SQo7sHCAKyBu31NxO2n57f9fsaaP0b0GRL7NFWF9Hc4HUdptrnmGZ6+spIp
 lIKsgApkESz7yhdDqI+Ndxkw6nBczpNxxQexS/FhgLPKnGswviu3rgXNrISThq12cpvbhqhWj
 2fPUrp7QJzpGSi+8ryhOXn5yRWLGHmqfBHjkZ7pEnG6b2T6NuT/eQJl91GXg=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 15 Nov 2019 19:51:00 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 15 Nov 2019 19:50:56 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
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

PiAtLS0gYXJyYXktcmVsZWFzZWQuZGlmZgkyMDE5LTExLTE0IDIxOjI5OjExLjAyMDU3NjkxNiAr
MDEwMAo+ICsrKyBhcnJheS1yZWR1Y2VkMS5kaWZmCTIwMTktMTEtMTQgMjE6NDU6NTguOTMxOTU2
NTI3ICswMTAwCj4gQEAgLTYsMjQgKzYsMTAgQEAKPiAgIAlyLT5lbnRyeV9jb3VudCA9IHQtPmVu
dHJ5X2NvdW50Owo+ICAgCXItPmRlbHRhX2RlcHRoID0gdC0+ZGVsdGFfZGVwdGg7Cj4gIC0JbWVt
Y3B5KHItPmVudHJpZXMsdC0+ZW50cmllcyx0LT5lbnRyeV9jb3VudCpzaXplb2YodC0+ZW50cmll
c1swXSkpOwo+IC0rCUNPUFlfQVJSQVkoci0+ZW50cmllcywgdC0+ZW50cmllcywgdC0+ZW50cnlf
Y291bnQpOwo+ICsrCW1lbWNweShyLT5lbnRyaWVzLHQtPmVudHJpZXMsdC0+ZW50cnlfY291bnQq
c2l6ZW9mKCoodC0+ZW50cmllcykpKTsKPiAgIAlyZWxlYXNlX3RyZWVfY29udGVudCh0KTsKPiAg
IAlyZXR1cm4gcjsKPiAgIH0KCkl0IHRvb2sgYSB3aGlsZSB0byBiZWNvbWUgbW9yZSBhd2FyZSBv
ZiBzb2Z0d2FyZSBkZXZlbG9wbWVudCBjaGFsbGVuZ2VzCmZvciB0aGUgc2FmZSBkYXRhIHByb2Nl
c3Npbmcgd2l0aCB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UgYWxzbwphdCBzdWNoIGEgc291
cmNlIGNvZGUgcGxhY2UuCmh0dHBzOi8vZ2l0aHViLmNvbS9naXQvZ2l0L2Jsb2IvM2VkZmNjNjVm
ZGZjNzA4YzFjOGYxZDMxNDg4NWVlY2Y5YmViOWI2Ny9mYXN0LWltcG9ydC5jI0w2NDAKCkkgZ290
IHRoZSBpbXByZXNzaW9uIHRoYXQgdGhlIENvY2NpbmVsbGUgc29mdHdhcmUgaXMgb2NjYXNpb25h
bGx5IGFibGUKdG8gZGV0ZXJtaW5lIGZyb20gdGhlIHNlYXJjaCBzcGVjaWZpY2F0aW9uIOKAnHNp
emVvZihUKeKAnSB0aGUgY29ycmVzcG9uZGluZwpkYXRhIHR5cGUgZm9yIGNvZGUgbGlrZSDigJwq
KHQtPmVudHJpZXMp4oCdLgpCdXQgaXQgc2VlbXMgdGhhdCB0aGVyZSBhcmUgY2lyY3Vtc3RhbmNl
cyB0byBjb25zaWRlciB3aGVyZSB0aGUgZGVzaXJlZApkYXRhIHR5cGUgd2FzIG5vdCBhdXRvbWF0
aWNhbGx5IGRldGVybWluZWQuClRodXMgdGhlIGRhdGEgcHJvY2Vzc2luZyAgY2FuIGJlY29tZSBz
YWZlciBieSBleHBsaWNpdGx5IGV4cHJlc3NpbmcKdGhlIGNhc2UgZGlzdGluY3Rpb24gZm9yIHRo
ZSBoYW5kbGluZyBvZiBleHByZXNzaW9ucy4KCkFkanVzdGVkIHRyYW5zZm9ybWF0aW9uIHJ1bGU6
CkBACnR5cGUgVDsKVCogZHN0X3B0ciwgc3JjX3B0cjsKVFtdIGRzdF9hcnIsIHNyY19hcnI7CmV4
cHJlc3Npb24gbiwgeDsKQEAKLW1lbWNweQorQ09QWV9BUlJBWQogICAgICAgKAooICAgICAgIGRz
dF9wdHIKfCAgICAgICBkc3RfYXJyCikKICAgICAgICwKKCAgICAgICBzcmNfcHRyCnwgICAgICAg
c3JjX2FycgopCiAgICAgICAsCi0gICAgICAgKG4pICogXCggc2l6ZW9mKFQpIFx8IHNpemVvZigq
KHgpKSBcKQorICAgICAgIG4KICAgICAgICkKCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNv
Y2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3Rp
bmZvL2NvY2NpCg==
