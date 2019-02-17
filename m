Return-Path: <SRS0=/UbJ=QY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7745AC43381
	for <cocci@archiver.kernel.org>; Sun, 17 Feb 2019 12:21:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3EC5222E0
	for <cocci@archiver.kernel.org>; Sun, 17 Feb 2019 12:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="HttOiCVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EC5222E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1HCLNbX002175
          ; Sun, 17 Feb 2019 13:21:23 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DDC7C76F4;
	Sun, 17 Feb 2019 13:21:22 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5B81776E1
 for <cocci@systeme.lip6.fr>; Sun, 17 Feb 2019 13:21:21 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1HCLJ3c002021
 ; Sun, 17 Feb 2019 13:21:19 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1550406055;
 bh=Hjmz4fiuQ5T8kjSQeyvr89A84AbZO1//ge8xdoWobHk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=HttOiCVsQsHJLapZnByjvRImXIh8CfpomWykOy6xQ80JwXK1viCUewkPzHictCfT4
 StxCTfxDvDKt3qym5WAdQWsyS3svgJU//AiarasxtAIxWUxvo5rJqcxcvbzqx/zupl
 DtFFRb1ffvHDEZijLy/QI+EbpLSFF5n9MszRZWVM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.167.97]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0McneT-1gdOwo1iAj-00HycB; Sun, 17
 Feb 2019 13:20:55 +0100
To: Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <yellowriver2010@hotmail.com>
References: <HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com>
 <8e7ba7c0-b7fe-a1f0-d28b-0c716ecbcfdb@web.de>
 <alpine.DEB.2.21.1902171235570.2444@hadrien>
 <1c152067-0135-79d7-1285-4bb9925054c8@web.de>
 <alpine.DEB.2.21.1902171246560.2444@hadrien>
 <782fd1c3-80ff-a296-b3a2-351257bb13b3@web.de>
 <alpine.DEB.2.21.1902171304520.2444@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <10836645-5b19-a748-56d7-c0572a76ab4d@web.de>
Date: Sun, 17 Feb 2019 13:20:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902171304520.2444@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:XbvCgCMiVVL2XYRRWmqnZFQsTRD1W9+g//GesciW7YZ1ipykgsj
 OvUJu729vIWe9sJpVSSYbSEe1z0XxltkmqQQ1T8qJsFvsgEC/4lXbIGlf9ITAj89jkwmzZx
 Y1SQJ1PJ+iM5tIDHACIUoZH3V3VoQdn9x5eur9fvhSRTEkNdHmRjcjNQ+/CiIW9fdQ3LOWO
 DnG2+USieSOcBOA3h3tBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jEhbihcQYWQ=:xccmEVsWLfZpG99HJpyQPf
 Xbuj7o4mo0qP8k+02R4zAq1aY+pnd2f59aVb61nQxBEEIERoc/jOsIhrZ+0UcJoPBTSaJNVOk
 JtlTLW2PvFDk4yHFnZx4U18oCrH3tY+O382ZJldwFQk/mquSQngEDFcL/HyUFGKSHVW3IGOTq
 IBKthSDNhQzpj6PbbGu9qaUDxtoQ863+liEy1CDC3KokB/jSAscaxlGvrEJ2HP7D67YLtFQWB
 Y0rwBp56SF0OhtDqk46/Aj5jHp+xTvsoMEJy+3IjgnEbVfLOlKfBVJ3TRE+Op8dntIpnZynLp
 2N0XQqjElg5xowfL5DSUU0U8WlzcCObTJevsTf5vRo5WgUFRWoCucBpYhVaTRMJ7HNJ31YSXU
 zsYMGV1aaC+kifMuST2eGsqp2ij9ZjBJOQZRVoVBG0doVmrvvX8k7+IdnaXKoJ/t9gNEDSwZZ
 GPm3ikLCyW5lI2ozK5MP2XGxyP+xJg+hRmG5A7Q0dgW1RW6RaGsY9vNBmaIn09DBzUI2jHuBJ
 3BFs1OxYMcsmjdi4tqz3hBn1+vwosGChpKN2qBlV3XXhuH20w/JLMNLa/umVwRJRVfDUd3NjQ
 clzbDehbn+y4Wyo0eDSmHkycxPPpJVhtSpRUStWH7VqfBehLkO4ki8TKcwJRDy4DHBPqF4e+m
 Be1p7MHmj6lVt8bZ79to4vElIKZk57mpGRQH9+0QgAJ6I7MFuFeDr54ss6rrBGCg2IOU36UYK
 VnJgxnn1JhRe4dgK9j4/yKFQ3Rvtq4C5P1qUFV/h0fChJnvSnnF6dC7Fkool32F91nhUAiDNW
 pSg2YNlaC2GwSSPPLJmbR8QMexd/YFsfdXxZV1tBtC/iIYBrPfGZNAtDROMnfCMRbjpadTFuX
 g1iHVRzcCPsihH+enCR5Sc10vgJ1XIXHtmmoYREkBSlQRyGKjokFS+TTtH77YlaFWmd5023nf
 cnZbnLXpgdQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 17 Feb 2019 13:21:23 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 17 Feb 2019 13:21:19 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [Cocci] [v6] coccinelle: semantic code search for missing
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

Pj4gSWYgeW91IHdvdWxkIGluc2lzdCBvbiB0aGUgc3BlY2lmaWNhdGlvbiBvZiBzdWNoIGFuIGFz
c2lnbm1lbnQgZXhjbHVzaW9uCj4+IGZvciBhIFNtUEwgZWxsaXBzaXM6Cj4+IENhbiB3ZSBhZ3Jl
ZSBvbiBhIGNvcnJlY3Qgb3JkZXI/Cj4KPiBJIGRvbid0IGdldCB5b3VyIHBvaW50LgoKSSBwcm9w
b3NlIHRvIHRha2UgYW5vdGhlciBjbG9zZXIgbG9vayBhdCBhIGJpdCBvZiBTbVBMIGNvZGUuCgoK
PiBUaGVyZSBpcyBubyBjb3JyZWN0IG9yZGVyLgoKSSBoYXZlIGdvdCBhbiBvdGhlciBzb2Z0d2Fy
ZSBkZXZlbG9wbWVudCB2aWV3IGhlcmUuCgoKPiBFYWNoIG9yZGVyIGV4cHJlc3NlcyBzb21ldGhp
bmcgZGlmZmVyZW50LgoKSSBhZ3JlZSB0byB0aGlzIGluZm9ybWF0aW9uLgoKCj4gVGhlIG9yZGVy
IHRoYXQgaXMgY3VycmVudGx5IGluIHRoZSBzZW1hbnRpYyBwYXRjaCBpcyB0aGUgb25lCj4gdGhh
dCBpcyBtb3JlIGxpa2VseSBpbiBwcmFjdGljZS4KClBsZWFzZSBjaGVjayBvbmNlIG1vcmUuCgri
gKYKK0BzZWFyY2ggZXhpc3RzQAorbG9jYWwgaWRleHByZXNzaW9uIGlkOworZXhwcmVzc2lvbiB4
LGUsZTE7Citwb3NpdGlvbiBwMSxwMjsK4oCmCitAQAorCitpZCA9IG9mX2ZpbmRfZGV2aWNlX2J5
X25vZGVAcDEoeCkKKy4uLiB3aGVuICE9IGUgPSBpZArigKYKCk9yOgoK4oCmCisgLi4uIHdoZW4g
IT0gaWQgPSBlCuKApgoKCldoaWNoIFNtUEwgc3BlY2lmaWNhdGlvbiB3aWxsIGFjaGlldmUgdGhl
IGRlc2lyZWQgc29mdHdhcmUgYmVoYXZpb3VyPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApD
b2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0
aW5mby9jb2NjaQo=
