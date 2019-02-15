Return-Path: <SRS0=7OsK=QW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5163BC43381
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 09:11:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79FCE21B1C
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 09:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="C/IwIIl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FCE21B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1F9AdaD010270
          ; Fri, 15 Feb 2019 10:10:39 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0CD9A76F7;
	Fri, 15 Feb 2019 10:10:39 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F308B76F3
 for <cocci@systeme.lip6.fr>; Fri, 15 Feb 2019 10:10:36 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1F9AZ0e024153
 ; Fri, 15 Feb 2019 10:10:35 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1550221815;
 bh=tpa24uNeIZdVTqFIDErsJqAXslQy0amY9YHKXz7tWAE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=C/IwIIl1n5WhnYSvzzYlUc9AUlyNegomQp+fRskzIsaCrQqCJmalAzYAVxwLdUagX
 5W1B26fJ8ced/8Y5mdeQW8lH2mt508PYYJLVMSSNJOICKJSdRJWwWJOV9hFFcqD61h
 EoQAnruJFlHjuYiNSiciaxR2nM57dJMeCrrJeUbk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.88.109]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEEa4-1gsQpy3pZA-00FSBD; Fri, 15
 Feb 2019 10:10:15 +0100
To: Wen Yang <wen.yang99@zte.com.cn>, Julia Lawall <julia.lawall@lip6.fr>
References: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c096c774-bb52-de01-7608-286b4d416cda@web.de>
Date: Fri, 15 Feb 2019 10:10:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-US
X-Provags-ID: V03:K1:ywipB2Awkf/FhwVzDNhJnz6+ni9zfWnccyTc0vRBfh1lkzV/0DU
 U4ioQqP2p0EpfPbUCJCGSBn2oFEFiFTW3w9LkFQBdV3Sky+HtVqH2QDT/l6ISB7+Tq7tZC/
 BQ7bUftYcZ/4Pt/xW+3IIgunHcxUjnlqa225S49kpWd1GVUAq9Y9CsP1EtbY5qxmjKNp9aS
 5ky543+noAwqb5/MQmITw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:40lqxceOduc=:QlEa9i80bATDqzi/AtNjz9
 ozJoP0g2leuH/Tox3785leY8A18vvQF3l9Oxt+j1M88pPf8iKBT74F2KZr9UZF6ysvvKaFgQ8
 KtIOATk3XYwl884/KmvhrBCfqaCPeiGfUlhglKjW9wb2/WacdRANLAqdgaPeK3tIdbvSr0El2
 //h1h0OUCNsL/QfPN7wyK6FTLS2QxYwV3vwHg40BzaS0+4kYgDBu6PqAVuHxg/+vqoZeq+6NG
 V0POwiGNRfbHMEdMto4zwgA0Jueyp8hPJfjps8lqz31CdxC6BpQ5bgLGxxNrjeW1pGW9NuCxp
 Xx84VmXZabZrajA2UceujI0EpMXEBxZG41McfpvwmrMrHAK11nUHkZD1J1pVQfIUUE79qyEVS
 p8liLKksNnnyRqz3IxrGJfG/0VBEvr9syMy6FXOVUUBFDjULcEI9LTHzNXmWH3c1uTVOVIDHN
 eaAMNO54b8bfkta8Oxikw3EmDM0y10nq94LI58pJcaukT8cKwF6ucU0Eaie7R51z3jpbWk3bv
 BWy256IDITqpknbVUJNOdQbs0ZSoS5K3pJPjYOGBD2FvGgzrjeeDnxpGeoTmpqrdvjmFCmsvD
 lQJW8La53duz7Gzr7Gkb+m/BkEjNnFmEDMmkmmGe+QfRvgifP431u1VEi07Y9E9Zt7C6vUCNy
 6gXq8tuRmUc2IKvDLic+9IN8CRskLL87iWr6gH2ZtM70TmlFFH42z3yj91ImBAlW4sEi1AvKT
 Fgzf0/UVeWdH2uk1ehWXtROCLtV+GRLpi+TjPdVX5gG1vmWnfZUIzvt6OZN/IEUFi6WlWfZzt
 yTCQ5FSGdRnC0LEWm1sMxOq0oFGFH0y3SghjCZc+pYvBBXEdyfZHhhoVRj8IiOGON2/W3ZrYi
 uMrP3LA5FS7beh6VaYuhXC5hbwPyxiwXpLA5mGJDlogeIayALrpQ0ocFOHLbC4+KzlOfzCCIY
 Rlt1RMUSipQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 15 Feb 2019 10:10:39 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 15 Feb 2019 10:10:35 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, kernel-janitors@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v5] coccinelle: semantic code search for missing
 put_device()
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

PiBJbiBhIGZ1bmN0aW9uLCBmb3IgYSBsb2NhbCB2YXJpYWJsZSByZXR1cm5lZCBieSBjYWxsaW5n
Cj4gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZSgpLAoKSSBzdWdnZXN0IHRvIHJlY29uc2lkZXIgdGhp
cyBpbmZvcm1hdGlvbiBvbmNlIG1vcmUuCgoxLiBXaWxsIGFuIG90aGVyIHdvcmRpbmcgYmUgbW9y
ZSBhcHByb3ByaWF0ZSBmb3IgdGhlIHN0b3JhZ2Ugb2YKICAgYSBmdW5jdGlvbiByZXR1cm4gdmFs
dWU/CgoyLiBDYW4gdGhlIHJlc3RyaWN0aW9uIOKAnGxvY2Fs4oCdIGJlIG9taXR0ZWQ/CgozLiBX
aWxsIGFueSBtYWNyb3MgYmUgaW52b2x2ZWQgZXZlbnR1YWxseT8KCgo+IGMsIGZvciB0aGUgcmVz
dCBvZiB0aGUgc2l0dWF0aW9uLCB0aGUgY3VycmVudCBmdW5jdGlvbiBzaG91bGQgcmVsZWFzZSB0
aGUKPiAgICByZWZlcmVuY2UgYnkgY2FsbGluZyBwdXRfZGV2aWNlLAoKQ2FuIGl0IGhhcHBlbiB0
aGF0IG9uIG90aGVyIGZ1bmN0aW9uIHdpbGwgcGVyZm9ybSB0aGUgZGVzaXJlZCByZWZlcmVuY2Ug
cmVsZWFzZT8KCgo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMgY29k
ZSBzZWFyY2ggd2lsbCByZXBvcnQgdGhlCj4gICAgY29ycmVzcG9uZGluZyBlcnJvciBtZXNzYWdl
LgoKUmV3b3JkaW5nPwpBIGNvZGUgc2VhcmNoIGNhbiByZXBvcnQgYW4gZXJyb3Igd2l0aCBhIHNw
ZWNpZmljIGNvbmZpZGVuY2UuCgoKPiB2NS0+djQ6CgpTdWNoIHZlcnNpb24gaW5mb3JtYXRpb24g
d291bGQgYmUgc3VmZmljaWVudCBhbHNvIHdpdGhvdXQgYXJyb3dzLCB3b3VsZG4ndCBpdD8KCgo+
IC0gYWRkIGEgU1BEWCBpZGVudGlmaWVyZml4CgpXb3VsZCB5b3UgbGlrZSB0byBmaXggYSB0eXBv
IGF0IHRoZSBlbmQ/CgoKPiArQHNjcmlwdDpweXRob24gZGVwZW5kcyBvbiByZXBvcnRACj4gK3Ax
IDw8IHNlYXJjaC5wMTsKPiArcDIgPDwgc2VhcmNoLnAyOwo+ICtAQAo+ICsKPiArY29jY2lsaWIu
cmVwb3J0LnByaW50X3JlcG9ydChwMlswXSwgIkVSUk9SOiBtaXNzaW5nIHB1dF9kZXZpY2U7ICIK
PiArCQkJICAgICAgKyAiY2FsbCBvZl9maW5kX2RldmljZV9ieV9ub2RlIG9uIGxpbmUgIgo+ICsJ
CQkgICAgICArIHAxWzBdLmxpbmUKPiArCQkJICAgICAgKyAiLCBidXQgd2l0aG91dCBhIGNvcnJl
c3BvbmRpbmcgb2JqZWN0IHJlbGVhc2UgIgo+ICsJCQkgICAgICArICJ3aXRoaW4gdGhpcyBmdW5j
dGlvbi4iKQoKSSBmaW5kIHlvdXIgaW50ZXJwcmV0YXRpb24gb2YgbXkgcmVtaW5kZXIgZm9yIHRo
ZSBwcmVmZXJyZWQgYXZvaWRhbmNlCm9mIHNwbGl0IHN0cmluZyBsaXRlcmFscyBpbnRlcmVzdGlu
ZyBzb21laG93LgoKQ2FuIHRoZSBmb2xsb3dpbmcgc291cmNlIGNvZGUgdmFyaWFudCBiZSBtb3Jl
IGFwcHJvcHJpYXRlPwoKK2NvY2NpbGliLnJlcG9ydC5wcmludF9yZXBvcnQocDJbMF0sCisJCQkg
ICAgICAiV0FSTklORzogbWlzc2luZyBwdXRfZGV2aWNlIC0gb2ZfZmluZF9kZXZpY2VfYnlfbm9k
ZSgpIGNhbGwgb24gbGluZSAiCisJCQkgICAgICArIHAxWzBdLmxpbmUKKwkJCSAgICAgICsgIiwg
YnV0IHdpdGhvdXQgYSBjb3JyZXNwb25kaW5nIG9iamVjdCByZWxlYXNlIHdpdGhpbiB0aGlzIGZ1
bmN0aW9uLiIpCgoKV2lsbCBhbnkgbW9yZSBhZHZhbmNlZCBlcnJvciBkaWFnbm9zdGljcyBiZSBl
dmVudHVhbGx5IGRldmVsb3BlZD8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lz
dGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29j
Y2kK
