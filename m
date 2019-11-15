Return-Path: <SRS0=XR0D=ZH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20596C432C3
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2019 14:20:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC5720730
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2019 14:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="iDu/Jj/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC5720730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAFEKZae006842;
	Fri, 15 Nov 2019 15:20:35 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 60F9B77CC;
	Fri, 15 Nov 2019 15:20:35 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 29F6077C5
 for <cocci@systeme.lip6.fr>; Fri, 15 Nov 2019 15:20:34 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAFEKVVj010257
 for <cocci@systeme.lip6.fr>; Fri, 15 Nov 2019 15:20:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573827627;
 bh=HtBJXt5/TsniHP44rGk4+AQbyFEiQC2c9FTtZBBTNqA=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=iDu/Jj/vAMObhHvmeuGSiel95BcN5qB9EayzVIg4LO0g1w6/97SpL5fspDAFhw7d1
 TxICIkNo4D/ZGh8MEbGMRExYAUCLDJoXrITUel19fjm79iBeHQWpk0m3/2rJQz93en
 6vkI56QgbaI4neiZ7HOVRt/xk0AaZ3LplgP/9J3s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.93.34]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MbMg8-1iCz9C3fRk-00IlX3; Fri, 15
 Nov 2019 15:20:26 +0100
From: Markus Elfring <Markus.Elfring@web.de>
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
 <6fffd13a-738b-e750-9f5a-f0bfb252855b@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d2fe2be3-f68f-d5fb-076b-3c740fe5a29a@web.de>
Date: Fri, 15 Nov 2019 15:20:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6fffd13a-738b-e750-9f5a-f0bfb252855b@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:E1qtbQ2evR3+HIJTNotekPrcJYN7+T/R2LhOrbThPuegfjoFHpP
 Ol3/jrnJ86cRYU+vwSngNI1dY26A6/NCprFM/k2owPSgX7owHOaSF8nd3U5oIh0LtqKW+d3
 PfJzEKMolACfJVKknPyuFjXGU1eWmLnMIJpK6CHICYgGvPyQ87JQgmVCXAC752I2iPliroS
 kLip59P9hI9UBrKiScKAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eCS2vGDY9Vs=:2DkdduAXBzntqoz6dOkUzQ
 +3rU9l+Gy7cihwV+tS0IJU79ZSOccTKXMgJ3YsdfMJdDjBVN4Ut1gvIX27y+Duis2yPaUOJKA
 ImhOF2MfOpeQ/zhVWP7PP4/FTdwl3k+xoUygBz+XSrD+fc/yU47kx41i4/pO7J3I1cYPlyW5o
 2dmh0w0KNkc3e5YigTfktdrjUWlhRvJt/VC2ZSO6CJmpxoVXgXvtsXJpgpyqBOPPN22+4fzqg
 9XHjRCYaYZbGcPAGNI1npEpxxe0XDw6h4C/S2TMsy6GvuIltD6NtIV4piwgZUjNeKJ/rfUR3q
 UT/TOPuHiKdTNSYxKEG8w9BM7lOaU+DTDZRm9YLjB0AWiWYJqvBsj/QPAEAX0+gAPtiu8s8ih
 5UWiX9P+KkLpZuxGFZInRU46HpI0ams2CAr08TmoDj0XUtgMzI8B3/p2HdC6wpClhnE59Dpms
 xX6NLs+PbVPfo75yHNHNOCurVGTFKbrNCTWtQ9l1OoworJ7smsAOchkbb0aAr5/vpP2FhnqUw
 Fp7ADrbOqRH6Zx+VbrGO4Y7k5uzYZMZR5imgfcJ8GMaFMhPXj5eXVBUzGhO2PVE+KllM9mrvP
 DAR7zVKNkgF3jA2xrAjleiEe1iS9ghCq1NwjKSRgxSRjPC1NQb3XEVIw+3DLGWCGB9mvcdqhj
 OlGkTwiWZoAQJiZ9MZDoFu7NGtKXiMISxObeAm0VySak2HMGOhCBXutpjXCGmuGu/rLETb/v5
 CyEv8N1ltZz26NGPekLRxkvNNFDCQEgc3FiTU0IcTE1JEvv3Y5h0Q8rS/Yc829CHqQFG4B1o0
 3hMb2hcPXr8TXseLibfpz5LR94fYAI24eWQAhGie1X05kwTtFfWffGq9mUZgNpoazQYiVo2pr
 j6u7REdjVhycFIEIlUh1r2oHWsIwRdtJSEjwOW9T4PkFghUzcUCnm+4M77WjMWgEdfyrU3+9M
 ZL69+BzFX9SzbA2hBFy9XiFvPAuwpFH1TutHLdbOSq/lNo5QOlWs/Z9+iRlZaaEQ0EMa5GENi
 +jeJP85bvbATT4vTWM79Bbx+RbRV1WMe2DNFXlEEIBJittuuAD4aHcFGPiFcA/LMpRqE4HgNZ
 8gE5GbZ5qvygVz7+hQVKoqs3ouiz+WkpRM8aMnpq+Y3SviItDju4uLUN630iaYHmpSDxJw9XN
 AueB59bQa0U2mBSDZwgnD8J/WqbL5xFM34/8aUv0UCIdL+F/ZdsBSAmhkbkgUt4w4lguX68DU
 ko8yW///Uxmu3EiSyqxXYnBoRQ/xPL3GAU8GrgDQsEjRSEu+oONl7smYGo1o=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 15 Nov 2019 15:20:37 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 15 Nov 2019 15:20:32 +0100 (CET)
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

PiAtLS0gYXJyYXktcmVsZWFzZWQuZGlmZgkyMDE5LTExLTE0IDIxOjI5OjExLjAyMDU3NjkxNiAr
MDEwMAo+ICsrKyBhcnJheS1yZWR1Y2VkMS5kaWZmCTIwMTktMTEtMTQgMjE6NDU6NTguOTMxOTU2
NTI3ICswMTAwCj4gQEAgLTYsMjQgKzYsMTAgQEAKPiAgIAlyLT5lbnRyeV9jb3VudCA9IHQtPmVu
dHJ5X2NvdW50Owo+ICAgCXItPmRlbHRhX2RlcHRoID0gdC0+ZGVsdGFfZGVwdGg7Cj4gIC0JbWVt
Y3B5KHItPmVudHJpZXMsdC0+ZW50cmllcyx0LT5lbnRyeV9jb3VudCpzaXplb2YodC0+ZW50cmll
c1swXSkpOwo+IC0rCUNPUFlfQVJSQVkoci0+ZW50cmllcywgdC0+ZW50cmllcywgdC0+ZW50cnlf
Y291bnQpOwo+ICsrCW1lbWNweShyLT5lbnRyaWVzLHQtPmVudHJpZXMsdC0+ZW50cnlfY291bnQq
c2l6ZW9mKCoodC0+ZW50cmllcykpKTsKPiAgIAlyZWxlYXNlX3RyZWVfY29udGVudCh0KTsKPiAg
IAlyZXR1cm4gcjsKPiAgIH0KCkNhbiBhbm90aGVyIHZhcmlhbnQgZm9yIGEgdHJhbnNmb3JtYXRp
b24gcnVsZSBoZWxwIHRvIGNsYXJpZnkgdW5leHBlY3RlZApzb2Z0d2FyZSBiZWhhdmlvdXIgYXJv
dW5kIGRhdGEgcHJvY2Vzc2luZyB3aXRoIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZT8KCkBA
CmV4cHJlc3Npb24gZHN0LCBzcmMsIG4sIEU7CnR5cGUgVDsKVCAqcHRyOwpUW10gYXJyOwpAQAog
IG1lbWNweSgKKCAgICAgICAgZHN0LCBzcmMsIHNpemVvZigKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAqKAogICAgICAgICAgICAgICAgICAgICAgICAgICAgRQotICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFsuLi5dCisgICAgICAgICAgICAgICAgICAgICAgICAgICkKICAgICAgICAgICAg
ICAgICAgICAgICAgICApICogbgp8CiAgICAgICAgcHRyLCBzcmMsIHNpemVvZigKLSAgICAgICAg
ICAgICAgICAgICAgICAgICoocHRyKQorICAgICAgICAgICAgICAgICAgICAgICAgVAogICAgICAg
ICAgICAgICAgICAgICAgICApICogbgp8ICAgICAgIGFyciwgc3JjLCBzaXplb2YoCi0gICAgICAg
ICAgICAgICAgICAgICAgICAqKGFycikKKyAgICAgICAgICAgICAgICAgICAgICAgIFQKICAgICAg
ICAgICAgICAgICAgICAgICAgKSAqIG4KfCAgICAgICBkc3QsIHB0ciwgc2l6ZW9mKAotICAgICAg
ICAgICAgICAgICAgICAgICAgKihwdHIpCisgICAgICAgICAgICAgICAgICAgICAgICBUCiAgICAg
ICAgICAgICAgICAgICAgICAgICkgKiBuCnwgICAgICAgZHN0LCBhcnIsIHNpemVvZigKLSAgICAg
ICAgICAgICAgICAgICAgICAgICooYXJyKQorICAgICAgICAgICAgICAgICAgICAgICAgVAogICAg
ICAgICAgICAgICAgICAgICAgICApICogbgopCiAgICAgICApCgoKZWxmcmluZ0BTb25uZTp+L1By
b2pla3RlL2dpdC9sb2thbD4gc3BhdGNoIGNvbnRyaWIvY29jY2luZWxsZS9hcnJheS10ZXN0My5j
b2NjaSBmYXN0LWltcG9ydC5jCuKApgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBz
eXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9j
b2NjaQo=
