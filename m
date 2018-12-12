Return-Path: <SRS0=XveF=OV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1925FC04EB8
	for <cocci@archiver.kernel.org>; Wed, 12 Dec 2018 12:18:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF2C2086D
	for <cocci@archiver.kernel.org>; Wed, 12 Dec 2018 12:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF2C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBCCHe61020844
          ; Wed, 12 Dec 2018 13:17:40 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0DE1476AB;
	Wed, 12 Dec 2018 13:17:40 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7BDB560D7
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 13:17:38 +0100 (CET)
Received: from mail.sysmocom.de (mail.sysmocom.de [144.76.43.93])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBCCHYDK008930
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 13:17:34 +0100 (CET)
X-pt: isis.lip6.fr
Received: from public-mail (mail.sysmocom.de [144.76.43.93])
 by mail.sysmocom.de (Postfix) with ESMTP id 799DD4765C6
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 12:17:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([144.76.43.93])
 by public-mail (mail.sysmocom.de [144.76.43.93]) (amavisd-new, port 10024)
 with ESMTP id wKyf930BhoaJ; Wed, 12 Dec 2018 12:17:33 +0000 (UTC)
Received: from [10.9.1.140] (ds9.sysmocom.de [90.187.64.137])
 by mail.sysmocom.de (Postfix) with ESMTPSA id 93C824765B5
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 12:17:33 +0000 (UTC)
To: cocci@systeme.lip6.fr
From: Max <msuraev@sysmocom.de>
Message-ID: <a752b0e8-8ed0-1e86-eff7-3d91e87b11ae@sysmocom.de>
Date: Wed, 12 Dec 2018 13:17:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 12 Dec 2018 13:17:58 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 12 Dec 2018 13:17:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] replacing defines
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

SGkuCgpJJ3ZlIHByb2JsZW0gcmVwbGFjaW5nIHBhcmFtZXRlcml6ZWQgI2RlZmluZSB1c2luZyBz
cGF0Y2guCgpGb3IgZXhhbXBsZSwgaW4gdGVzdC5jIEkgaGF2ZSBmb2xsb3dpbmcgZGVmaW5lczoK
Ci4uLgoKI2RlZmluZSBvbGRfanVuayhhLCBiLCBjKSBpZiAoYykgXAoKIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcHJpbnRmKGEpOyBcCgogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZSBc
CgogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7IHByaW50ZihiKTsgfQoKI2RlZmluZSBuZXdf
c3R1ZmYoYSwgYiwgYikgbXlfZnVuYyhhLCBiLCBjKQoKSSB3b3VsZCBsaWtlIHRvIHJlcGxhY2Ug
YWxsIHRoZSBlbnRyaWVzIG9mIG9sZF9qdW5rKHgsIHksIHopOyB3aXRoIApuZXdfc3R1ZmYoeCwg
eSwgeik7CgpJJ3ZlIHRyaWVkIGZvbGxvd2luZyBzcGF0Y2g6CgpAQAppZGVudGlmaWVyIG9sZF9q
dW5rLCBuZXdfc3R1ZmYsIGFib3J0OwppZGVudGlmaWVyIGEsIGIsIGM7CkBACi0gb2xkX2p1bmso
YSwgYiwgYyk7CisgaWYgKG5ld19zdHVmZihhLCBiLCBjKSkKCivCoMKgwqDCoMKgwqDCoCBhYm9y
dCgpOwoKV2hpY2ggdXNlZCBhcyAic3BhdGNoIC0taW4tcGxhY2UgLS1zcC1maWxlIG15LnNwYXRj
aCB0ZXN0cy90ZXN0LmMiCgpVbmZvcnR1bmF0ZWx5IGFsbCBJIGdvdCBpcyAibWV0YXZhcmlhYmxl
IG5ld19zdHVmZiBub3QgdXNlZCBpbiB0aGUgLSBvciAKY29udGV4dCBjb2RlIi4KCkkndmUgdHJp
ZWQgdXNpbmcgImZ1bmN0aW9uIG5ld19zdHVmZiIgaW5zdGVhZCBhbmQgZ290IGFub3RoZXIgZmFp
bHVyZTogCiJNZXRhRnVuYywgbmVlZCBtb3JlIHNlbWFudGljIGluZm8gYWJvdXQgaWQiLgoKV2hp
Y2ggaXMgdGhlIHJpZ2h0IHdheSB0byBtYWtlIHRoaXMgc29ydCBvZiByZXBsYWNlbWVudHM/CgpJ
J2QgYmUgaGFwcHkgdG8gZ2V0IHBvaW50cyB0byB0aGUgZG9jcyB3aGljaCBjbGFyaWZ5IHRoaXMg
cGFydCBhcyBJIHdhcyAKdW5hYmxlIHRvIGZpbmQgYW55dGhpbmcgcmVsZXZhbnQgb24gCmh0dHA6
Ly9jb2NjaW5lbGxlLmxpcDYuZnIvZG9jdW1lbnRhdGlvbi5waHAKCkkgd2VudCBvdmVyIHR1dG9y
aWFsIHNsaWRlcyBhcyB3ZWxsIGFuZCBpdCBmZWVscyBsaWtlIEknbSBtaXNzaW5nIApzb21ldGhp
bmcgb2J2aW91cyBpbiBoZXJlLgoKSSdtIHVzaW5nIHNwYXRjaCAxLjAuNCBpbiBsYXRlc3QgdWJ1
bnR1LgoKLS0gCi0gTWF4IFN1cmFldiA8bXN1cmFldkBzeXNtb2NvbS5kZT4gICAgICAgaHR0cDov
L3d3dy5zeXNtb2NvbS5kZS8KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KKiBzeXNtb2NvbSAtIHN5c3RlbXMgZm9y
IG1vYmlsZSBjb21tdW5pY2F0aW9ucyBHbWJICiogQWx0LU1vYWJpdCA5MwoqIDEwNTU5IEJlcmxp
biwgR2VybWFueQoqIFNpdHogLyBSZWdpc3RlcmVkIG9mZmljZTogQmVybGluLCBIUkIgMTM0MTU4
IEIKKiBHZXNjaGFlZnRzZnVlaHJlciAvIE1hbmFnaW5nIERpcmVjdG9yczogSGFyYWxkIFdlbHRl
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBt
YWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZy
L21haWxtYW4vbGlzdGluZm8vY29jY2kK
