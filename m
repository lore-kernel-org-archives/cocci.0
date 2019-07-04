Return-Path: <SRS0=5Xvi=VB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBCEC5B578
	for <cocci@archiver.kernel.org>; Thu,  4 Jul 2019 03:04:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476A42189E
	for <cocci@archiver.kernel.org>; Thu,  4 Jul 2019 03:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476A42189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6433tid017721;
	Thu, 4 Jul 2019 05:03:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 31EA8777A;
	Thu,  4 Jul 2019 05:03:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 97C417777
 for <cocci@systeme.lip6.fr>; Thu,  4 Jul 2019 05:03:53 +0200 (CEST)
Received: from mxct.zte.com.cn (out1.zte.com.cn [202.103.147.172])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6433pW2026586
 for <cocci@systeme.lip6.fr>; Thu, 4 Jul 2019 05:03:52 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id D57739BFE4E305052E10;
 Thu,  4 Jul 2019 11:03:50 +0800 (CST)
Received: from kjyxapp04.zte.com.cn ([10.30.12.203])
 by mse-fl1.zte.com.cn with SMTP id x64330YM009054;
 Thu, 4 Jul 2019 11:03:00 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp05[null]) by mapi (Zmail) with MAPI id mid14;
 Thu, 4 Jul 2019 11:03:00 +0800 (CST)
Date: Thu, 4 Jul 2019 11:03:00 +0800 (CST)
X-Zmail-TransId: 2b075d1d6c64f4912dc0
X-Mailer: Zmail v1.0
Message-ID: <201907041103003504524@zte.com.cn>
In-Reply-To: <alpine.DEB.2.21.1906281304470.2538@hadrien>
References: 1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn,
 904b9362-cd01-ffc9-600b-0c48848617a0@web.de,
 alpine.DEB.2.21.1906281304470.2538@hadrien
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <julia.lawall@lip6.fr>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn x64330YM009054
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jul 2019 05:03:55 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jul 2019 05:03:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, Markus.Elfring@web.de,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?=5BPATCH_v2=5D_coccinelle=3A_semantic_code_sear?=
	=?utf-8?q?ch_for_missingof=5Fnode=5Fput?=
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



--=====_001_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PiA+ID4gK3ggPSBAcDFcKG9mX2ZpbmRfYWxsX25vZGVzXHwKPiA+Cj4gPiBJIHdvdWxkIGZpbmQg
dGhpcyBTbVBMIGRpc2p1bmN0aW9uIGVhc2llciB0byByZWFkIHdpdGhvdXQgdGhlIHVzYWdlCj4g
PiBvZiBleHRyYSBiYWNrc2xhc2hlcy4KPiA+Cj4gPiAreCA9Cj4gPiArKG9mX+KApgo+ID4gK3xv
Zl/igKYKPiA+ICspQHAxKC4uLik7Cj4gCj4gRGlkIHlvdSBhY3R1YWxseSB0ZXN0IHRoaXM/ICBJ
IGRvdWJ0IHRoYXQgYSBwb3NpdGlvbiBtZXRhdmFyaWFibGUgY2FuIGJlCj4gcHV0IG9uIGEgKSBv
ZiBhIGRpc2p1bmN0aW9uLgo+IAo+ID4gPiArfAo+ID4gPiArcmV0dXJuIHg7Cj4gPiA+ICt8Cj4g
PiA+ICtyZXR1cm4gb2ZfZndub2RlX2hhbmRsZSh4KTsKPiA+Cj4gPiBDYW4gYSBuZXN0ZWQgU21Q
TCBkaXNqdW5jdGlvbiBiZSBoZWxwZnVsIGF0IHN1Y2ggcGxhY2VzPwo+ID4KPiA+ICt8cmV0dXJu
Cj4gPiArKHgKPiA+ICt8b2ZfZndub2RlX2hhbmRsZSh4KQo+ID4gKyk7Cj4gCj4gVGhlIG9yaWdp
bmFsIGNvZGUgaXMgbXVjaCBtb3JlIHJlYWRhYmxlLiAgVGhlIGludGVybmFsIHJlcHJlc2VudGF0
aW9uIHdpbGwKPiBiZSB0aGUgc2FtZS4KPiAKPiA+ID4gKyAgICB3aGVuICE9IHY0bDJfYXN5bmNf
bm90aWZpZXJfYWRkX2Z3bm9kZV9zdWJkZXYoPC4uLnguLi4+KQo+ID4KPiA+IFdvdWxkIHRoZSBz
cGVjaWZpY2F0aW9uIHZhcmlhbnQg4oCcPCsuLi4geCAuLi4rPuKAnSBiZSByZWxldmFudAo+ID4g
Zm9yIHRoZSBwYXJhbWV0ZXIgc2VsZWN0aW9uPwo+IAo+IEknbSBpbmRlZWQgcXVpdGUgc3VycHJp
c2VkIHRoYXQgPC4uLnguLi4+IHdvdWxkIGJlIGFjY2VwdGVkIGJ5IHRoZSBwYXJzZXIuLgoKSGkg
anVsaWEsCgpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMuCldlIHRlc3RlZCBhbmQgZm91bmQg
dGhhdCBib3RoIDwuLi54Li4uPiBhbmQgPCsuLi4geCAuLi4rPiB2YXJpYW50cyB3b3JrIGZpbmUu
CldlIHVzZSA8Li4uIHggLi4uPiBpbnN0ZWFkIG9mIDwrLi4uIHggLi4uKz4gaGVyZSB0byBlbGlt
aW5hdGUgdGhlIGZvbGxvd2luZyBmYWxzZSBwb3NpdGl2ZXM6CgouL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vcWNvbS9jYW1zcy9jYW1zcy5jOjUwNDoxLTc6IEVSUk9SOiBtaXNzaW5nIG9mX25vZGVf
cHV0OyBhY3F1aXJlZCBhIG5vZGUgcG9pbnRlciB3aXRoIHJlZmNvdW50IGluY3JlbWVudGVkIG9u
IGxpbmUgNDc5LCBidXQgd2l0aG91dCBhIGNvcnJlc3BvbmRpbmcgb2JqZWN0IHJlbGVhc2Ugd2l0
aGluIHRoaXMgZnVuY3Rpb24uCgo0NjUgc3RhdGljIGludCBjYW1zc19vZl9wYXJzZV9wb3J0cyhz
dHJ1Y3QgY2Ftc3MgKmNhbXNzKQo0NjYgewouLi4KNDc5IHJlbW90ZSA9IG9mX2dyYXBoX2dldF9y
ZW1vdGVfcG9ydF9wYXJlbnQobm9kZSk7Ci4uLgo0ODYgYXNkID0gdjRsMl9hc3luY19ub3RpZmll
cl9hZGRfZndub2RlX3N1YmRldigKNDg3ICZjYW1zcy0+bm90aWZpZXIsIG9mX2Z3bm9kZV9oYW5k
bGUocmVtb3RlKSwgLS0tPiB2NGwyX2FzeW5jX25vdGlmaWVyX2FkZF9md25vZGVfc3ViZGV2IHdp
bGwgcGFzcyByZW1vdGUgdG8gY2Ftc3MtPm5vdGlmaWVyLgo0ODggc2l6ZW9mKCpjc2QpKTsKLi4u
CjUwNCByZXR1cm4gbnVtX3N1YmRldnM7CgotLQpUaGFua3MgYW5kIHJlZ2FyZHMsCldlbg==


--=====_003_next=====--

--=====_001_next=====
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--=====_001_next=====--

