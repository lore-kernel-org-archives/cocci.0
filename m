Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0221C433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 13:38:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC93B208DB
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 13:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="AfDVMH2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC93B208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04ODches012399;
	Sun, 24 May 2020 15:38:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E0DC63DC8;
	Sun, 24 May 2020 15:38:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BCF613D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 15:38:40 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04ODcegX003278
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 15:38:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590327516;
 bh=WSX4YH54kabaJwS6XqSdMQdyqWezCI4Wqn5Pul+y9JA=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=AfDVMH2f6rKKuO6Vpb1NR4jywcvCFXBnuaPc/KL0I8PMOyNrJzGZHr9UJKCd3FzXI
 qv/j39porkJ0YDod0Z6Hq7n78o6+N9pX3NyR3LAE4NfsOwOpp6Maop14shW93n9GK2
 Z7Z1gknJPuY26+M97k4Bb5OIkp6L2sSRBzvOae38=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.187.46]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCXVX-1jlLQd2L7j-009iIU; Sun, 24
 May 2020 15:38:36 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <1d595042-0940-3056-5460-bffd58782fe2@web.de>
 <alpine.DEB.2.21.2005241405010.2429@hadrien>
 <a29f1f11-c12c-6b96-0ddc-09b9790fe9af@web.de>
 <alpine.DEB.2.21.2005241501560.2429@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9b9319f3-1c71-d114-ba8b-56dfe0627769@web.de>
Date: Sun, 24 May 2020 15:38:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005241501560.2429@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:jcjLTd4B3PSF8sVGnRZtdsjDepc6KwAvdaDj38QWume/BjNIUrn
 Hd38iHIz8BNB/7PMvwfEk7sAUukXrOFmraywih6hMVsJwiW0Rx5QZWCXJsWQza75m5KprML
 LklQWCvjqO8WgDsJZyc7dfkZGZa/lAIv+Qp9KYDRMTAqo/W9Y89rHpSZYXboGGMDqD6CuWN
 ZF52cGVnwKZWTsjLzup6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8oCg0Ne+hhc=:R4PoyXYbD2YlFViFHjOFp/
 4fzdXjnuGcVn7VHiqOTfjV4TckignAK29chtMX/xL58iV0TQCNcmNL0aJ89HFuwAwrv0OZUsZ
 Ibmr7Ibtvy642snBJ2RrqFrNVni3tk5exZvaeV8RQAfVOdCHMQ20O0OcMfpWM+t0FhrDjQSbR
 24BCvI3yhbQZE8JDujitUf+MpsZERc6xDeRUSWp2dSCTsCnENcw+6LkOI9hvBwY3Fb9Opxbh3
 37g409iR7LY663mgItXxqelHTbcpISQPnmzU5qinZydtWi0aO869xVUY/Z2wLVSM7Tc/HLgjq
 HBYolY4adxoya409HxB4SQaqfbXT3P70cJvaHFLXRF+RDT/z+FAZyFMxABCRoE824ssa+Msuv
 a9S6JOPyW0VC3KAbA0wIFNdI76p/ss8v4Jp0dVYgCqybLDPqugc+puSQo9OEhwWcbjlCMv3/N
 Bxmg8p8Z+e4KdupxhcczwXBTbHo+Ma5S4VgUgjXvS0G3wioCY2W0zebTf6F0L7d2+QAfDRyYx
 reV0rXYic+Hyl3I6fNA71h8OEiF5SczgyET6ScEoz/pi73dhKhvs9XTjjj8bnoW0PD4Ezn5UW
 wLZLNbXExt3cmmWtNJ48WNrsCjO9cK/m1xBUnjPRqzLOw71nM/SVSqjVdRL2Gulq/abFRiGFh
 8MuznkNJIe4rjFN27VlzxrX29Z22Nqbe/HD7QFJWlig2IqrmEEAtnGri7gb00cABJo2ylQ2Yd
 +N5kWOVBi+iEfC4Lkrs7lTBB2WFCv2ztnFqvFYUW6UT80V8iOMwWqyWZqht0ukcMnrE9duY75
 grytzrKs/SMOAMLRWkbzB8h8N56G1ljLSoPhjND29BdCPQzBopYeN0E7vvWqxJ8BkmDtCjpT6
 LtDQ2ljfcEzDZ5CKikTVUTsxxPAYYoUfbeSh+YnN4NRWZ/rJNiOiDDcreT5nxB0t0KXFpXBgd
 yzToTB5Djtm+tlFK1ikDmWZHKBAZplAp4X6O0tTdi09dIPUJsac+sb/Q0Td6zvIV0wteewgLH
 L+XgfGooxP55iYFSN1ekqeiovjhMHY/UYdpSwxUKRDe9Fcy41nUpvxG4S+g05dyBYXAD3Ybwi
 T1ZXZRJ3Y2Fq3cQhBCpSrLcnybP3oCR8bT1W9tiTeOcQMBEtC+CQtMulGIzIUNF5MvgOxH+9S
 lzZKITXyFkiGj0cElYPlVqH/m5tVql6fNsPLBr/lKNFOpE9n/5cYGlid/ksaNgUrnoBfuSmJp
 ZgGcI78oSYbEVXyuD
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 15:38:43 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 15:38:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Converting variable initialisations to later assignments
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

Pj4+PiBAbW92ZW1lbnRACj4+Pj4gZXhwcmVzc2lvbiBFOwo+Pj4+IGlkZW50aWZpZXIgVjEsIFYy
LCBWeDsKPj4+PiBzdGF0ZW1lbnQgUzsKPj4+PiB0eXBlIFQxLCBUMjsKPj4+PiBAQAo+Pj4+ICBU
MSBWMTsKPj4+PiAgLi4uIHdoZW4gYW55Cj4+Pj4gIFQyIFYyCj4+Pj4gLSAgICAgID0gXCggPCsu
Li4gVnggLi4uKz4gXCYgRSBcKQo+Pj4KPj4+IFdoYXQgaXMgVnggZm9yPyAgSGUgd2FudHMgYW4g
ZXhwcmVzc2lvbiB0aGF0IGludm9sdmVzIGEuCj4+Cj4+IEkgY2hvc2UgYSBzbGlnaHRseSBtb3Jl
IHVuaXF1ZSBtZXRhdmFyaWFibGUgaWRlbnRpZmllciBmb3IgdGhlIGRlc2lyZWQKPj4gY2xhcmlm
aWNhdGlvbiBvZiB0aGlzIHVzZSBjYXNlLgo+Pgo+PiBhIOKHlCBWeAo+PiAgICAgKE9yIHNob3Vs
ZCB0aGUgaWRlbnRpZmllciDigJxWMeKAnSBiZSB1c2VkIGluc3RlYWQ/KQo+Cj4gVnggaXMgbm90
IGJvdW5kIHRvIGFueXRoaW5nLgoKVGhpcyBpbnRlcnByZXRhdGlvbiBtaWdodCBiZSBhcHByb3By
aWF0ZS4KCgo+IEl0IHdpbGwgbWF0Y2ggYW55IGlkZW50aWZpZXIuCgpTaG91bGQgdGhlIGRlc2ly
ZWQg4oCcYmluZGluZ+KAnSB3b3JrIHdpdGggdGhlIHZhcmlhYmxlIG5hbWUg4oCcVjHigJ0gKG9y
IOKAnGHigJ0pIGZpbmFsbHk/CgoKPj4+PiAgOwo+Pj4+ICAuLi4gd2hlbiBhbnkKPj4+PiAgICAg
IHdoZW4gIT0gUwo+Pj4+ICsrIFYyID0gRTsKPj4+Cj4+PiBXaGF0IGRvIHlvdSBleHBlY3QgdGhp
cyBjb2RlIHRvIGJlIGFkZGVkIG9uIHRvPwo+Pgo+PiBJIGltYWdpbmUgdGhhdCB3ZSB3b3VsZCBs
aWtlIHRvIGRldGVybWluZSB0aGUgZW5kIG9mIHRoZSBjb2RlIGJsb2NrCj4+IGZvciB2YXJpYWJs
ZSBkZWNsYXJhdGlvbnMgc29tZWhvdy4K4oCmCj4gSSBhbHJlYWR5IGFza2VkIGFib3ZlIHdoYXQg
eW91IGV4cGVjdGVkIHRoZSArKyBjb2RlIHRvIGJlIGF0dGFjaGVkIHRvLgo+IEFsbCBhZGRlZCBj
b2RlIGhhcyB0byBiZSBhdHRhY2hlZCB0byBzb21ldGhpbmcuCgpUaGUgc2hvd24gc2ltcGxlIFNt
UEwgZXhjbHVzaW9uIHNwZWNpZmljYXRpb24gZm9yIHN0YXRlbWVudHMgY2FuIGJlIHJlcGxhY2Vk
CmFsc28gd2l0aCBhIGJldHRlciBzb3VyY2UgY29kZSBzZWFyY2ggYXBwcm9hY2guCgpXb3VsZCB5
b3UgcmVjb21tZW5kIHRvIGV4Y2x1ZGUgZGVjbGFyYXRpb25zIChhbmQvb3IgZGVmaW5pdGlvbnMp
IG9mIEMgdmFyaWFibGVzCmJ5IGFueSBvdGhlciBtZWFucz8KKElzIG1vcmUgU21QTCBjb2RlIG5l
ZWRlZCBmb3IgdGhpcyBwdXJwb3NlPykKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lA
c3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8v
Y29jY2kK
