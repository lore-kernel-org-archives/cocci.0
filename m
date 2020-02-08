Return-Path: <SRS0=lWmI=34=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20587C35242
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 19:06:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A4322464
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 19:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="W7vuvJBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A4322464
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 018J6OMm018466;
	Sat, 8 Feb 2020 20:06:24 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 55A0877ED;
	Sat,  8 Feb 2020 20:06:24 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A9FF77718
 for <cocci@systeme.lip6.fr>; Sat,  8 Feb 2020 20:06:22 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 018J6MZ7012550
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 8 Feb 2020 20:06:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581188780;
 bh=wmhFFWeoW5+9Ixoy2ruxiTAkR1QkYHFRWYBYZJITJtY=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=W7vuvJBYUVKQXXhzFnoOLp7zfmN0KDKMyFmhGLhBhzAVB4LgVoJLoPMRenoYDWQJ5
 r1aD2xA90hqHsp7AumCJmytpcICc/al1oJ4h+FZ+h3N/mYbBevRSflrDKxAAHiqBWx
 9MfisYpc/mifIEkhSmBQ5yTL5Nf47obSAxGSieWg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.138.97]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMFFF-1isYPh1ihB-0086n3; Sat, 08
 Feb 2020 20:06:20 +0100
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Julia Lawall <julia.lawall@inria.fr>, cocci@systeme.lip6.fr
Message-ID: <6bff29ca-8cb6-66f8-a470-34c0c1734363@web.de>
Date: Sat, 8 Feb 2020 20:06:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:IrGzzzjxQNXUkOJkETD5qAr3s6uBOLVCZ+DpmxDPVSYeXlc+Wpv
 Bw0gJBYQXndbbP+9IVM32DcMsjrW85H4OG8lpnfNRCBsV0ASR0qtVd3aWNDgbeGQjbp1T8j
 Xm1AQ0vI6r06cmipmUUFndxq1W4kTDdmnjJr4t7ypgzS8KFwHM5Z9YBIVy6/bpROjvQTCRj
 /ZMR1c6dzl87FfJ2BbE9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y64OGl6XvRU=:+wrj+H1h70iP8Wro7/alLm
 4QrHcwA1JRKZ5ypX+te+YV4Yirzcss29CsYfUTn5WXVOGnl1ujoa+Sn6cP7+MgpszTg/oSGD0
 +J50S6ugC+k62Npc+gvpCzGOqKLbSS+JaDls0ub0hdPLNk34297EymdwQFdXLvoZvRlVnhI/J
 TEdGuJcJjgEp3Chm8sxVPMVUoSZullE9oSSwl9plqd+K9hU1sk6Iq2BL61g+rcavOcSgR+3N0
 PidRP/vLRKhXvmyBdcRue9rRRQTIj80jliDA+iy5nSBIwQ1mc4IsjxMQbqrnhJ7Ar+X3WrU8e
 cqM+cxtMbG1HeYSvsOtbtWd5AeOAmENU+m7mldDoFrPvWihYFcmAhpTXXUaKleaHeCVremeKe
 nlveQiCsIpQ8OaArfQiuBfb4gmkXScZ0jpXaFqjpQx9py5ciRTCyqJ+QpaUc1V2nGmMxBBe62
 seNgu/T7yGjMgoTjex4Jb+WUnKUWq3bOkJau34fGmiBI9JzvJVqgll9TLt/l4u4Jr3TmdF3IW
 vS40BnzvGeYt0lmD9MvTtJUao3ytRF/ZT64OJdsYHpdFmKd91dFn48Xh77nDRSGZsszZHC6JM
 2M2Qb7wsCDf/8iSsshowofu9+VatWfm6kcW+F7OoRuKjl3mzRR3exjVYSYKzLbP640X8Vc53Y
 Z/kzI7pRA2MKTXGu5ae37ak1BsmAOYPF48g+LPuQjDIC7YkuHFFUfLsYaKY/7A50dVNb3xxSf
 F9OtkWcPDo9IWq3pf7dlj5AF1uqsgUJVJrheSilYRWCM3t/dVgAZ05gTU5FgH0UZ/GrGuEbxO
 CcQ4hwzW81AWXf/wBGc9p5kbj+K6C9yB1o+p4u80M8o2lzHHiop3GEQ61p2TyZbQ4D6vB7CrQ
 aKkMscXSkX5sPqVcDJgBvgANJqD6zATwgbMF+nTanIWY4WPnWWqtMDbn8zbbykXb2jFSYDp4i
 lNXF0z97WgJxgFpaonL0VrLrncjuDBd0bQHP67i6LE6IolUI71lFrxAVXteQrOYsqu0inhWjj
 hSin1louiGKYpmjHyb8rXeu6ll0onjATKGMTnxP3f82wK+A1a69z52X7wU0zUP4W1dOFemUUa
 T/jG38/U+p8COFYBBwCu9Q+A08m5UOQgAPCDkgxZHf7uFgczcyec6kdBia4l5D5wjQ3fuHnjS
 8WDNb0mi/tfO+M9l/PMtAKxb73e0q4GaT5Ybw2lGJPOFT73fd7L/QhjVB8H6GW6gJl+N2oV0/
 LP3Kz4t+sMuaylAPV
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 08 Feb 2020 20:06:24 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 08 Feb 2020 20:06:22 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Replacing the type casting
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

PiA+IEkgbXVzdCBiZSBtaXNzaW5nIHNvbWV0aGluZyB2ZXJ5IG9idmlvdXMgYXMganVzdCByZW1v
dmluZyB0aGUgdHlwZSB3b3JrcywgYnV0IGFkZGluZyB0aGUgYCsgKGRuc19yZGF0YWNvbW1vbl90
ICopYCBsaW5lIG1ha2VzIHRoZSBydWxlIGZhaWwuCj4KPiBDb2NjaW5lbGxlIGlzIG5vdCBhYmxl
IHRvIGluZmVyIHR5cGVkZWZzIGluIGNhc3RzLgoKVW5kZXIgd2hpY2ggY2lyY3Vtc3RhbmNlcyBj
YW4gdGhpcyBzb2Z0d2FyZSBzaXR1YXRpb24gYmUgcmVjb25zaWRlcmVkPwoKSG93IGxvbmcgd2ls
bCBhbiBleHRyYSBtZXRhdmFyaWFibGUgc3BlY2lmaWNhdGlvbiBsaWtlIOKAnHR5cGVkZWYgZG5z
X3JkYXRhY29tbW9uX3Q74oCdCmJlIG5lZWRlZCBmb3IgdGhlIG1lbnRpb25lZCB0cmFuc2Zvcm1h
dGlvbiBhcHByb2FjaD8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5s
aXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
