Return-Path: <SRS0=mWdE=DZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAFFC433E7
	for <cocci@archiver.kernel.org>; Sun, 18 Oct 2020 16:11:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9040A20773
	for <cocci@archiver.kernel.org>; Sun, 18 Oct 2020 16:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="HfyyW1fi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9040A20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09IGAsiX010690;
	Sun, 18 Oct 2020 18:10:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 437E57797;
	Sun, 18 Oct 2020 18:10:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3233C74CE
 for <cocci@systeme.lip6.fr>; Sun, 18 Oct 2020 18:00:14 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09IG0Csd027348;
 Sun, 18 Oct 2020 18:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603036811;
 bh=TBl5rO+N/U1i9vHDf+n9N3sBR9RoHWUKMDCmAHLLIWQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HfyyW1fiHZ0YEl0xQjc6mVuc+Gx+wSw6qdARhFZ1bJ8AZIHLC/7G9wrCSJY6QZg1n
 PFKtT4gS3TYS7udD3Osa12c1msbO2KIdWt3rqu7poRGUNx7Ik/cvQQbDXq/qilxG6T
 CH9uDBlu/I/Q2MMiH72aC7yrs8wN7xxk/sfwVH6c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from sonne.localnet ([93.133.46.65]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lwq0e-1kNdeV1wbY-016OpW; Sun, 18
 Oct 2020 18:00:11 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Denis Efremov <efremov@linux.com>, Coccinelle <cocci@systeme.lip6.fr>
Date: Sun, 18 Oct 2020 18:00:10 +0200
Message-ID: <2774601.u91sIFNy1E@sonne>
In-Reply-To: <3528117.7ODa3CK5J5@sonne>
References: <3528117.7ODa3CK5J5@sonne>
MIME-Version: 1.0
X-Provags-ID: V03:K1:HhEvM3xvpF9e68yPcKAa6vhXNXMQy3GFOFQ1yDkE+6jzOW0WBby
 GNKN9fTOCPdyQbz4H81o0M58rdrYfOv/3FviccCEwcJ/zQRTynAHS1Dyx+n2ORSMgZ/uU7N
 5wa5tEx9gD4pgrmvdIoM9p0KoouP3irm35PBrv2ZVLV/c0sAzRHgb1csMTABstp5gpOvqPM
 mwK+y5RATWswR+g3qUVMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+IpXbgDFasQ=:YfoJtEZzRGYx2qp6cAng2L
 Dhe46K3w0HfzmB/irbkhm6hi7d6xMAWfAd/B2l1LiP8COLxZGYxD7PGHeHdFgKvFi2aLgA9wK
 hLbWMd5eQF6iOQDJTFr3JwQlYErCtB7HHVsGucCyWK7JEwt0e0lyDEfdTvQFYeLE8FfG+Sk4X
 k5GFQMRylSFjlGbN13N/SsNOHiPnHyTuuDC6YRHnwR9EHORVOl5yY1O8nw1C+y2zi+7vYL4oB
 uVRNBO7h6fvBkn/fg51q7Yg/NGbweJDHzKKY4EXt90aTH0euowE64Ocn+/AJs1VXDp1lywfZI
 tyK4GiobDw0Yhj/HDWofVjzxN/PLLLMC/7FBqnSOoGWVVwB9KF1n2lYPcWkB9W/ro72Qu+tj6
 eOuDg2hniw9Q/N/yfQ2MWl4z6mrUPFvtSsQqqCzOVyjw8RKoECW/3zvhP0VBCoP7bhZJN2o76
 O+9kNFIQNcccuQzwp5NRzh2bibvsusnikstAwehFxGCAbmDMj140G1Z/bxkNqUp6rLiAvMjHk
 PTS/O2q8N+19dzw4U2toIGQiLsnDRPeWEOTzZcw8h3jm5tZwD9EbcSdZrqroHOy2XTM+9FOL/
 rP7efDmNui3PfEAXkAecrQkE+K2DtEGZhyVYIzeaiR8O+TCzVRaT2KyWZfFxQ6Txl5KgKHJYq
 MGpv8tpZHyoYwYw5EgEHnDILwgmM85zUzQ2+kw8zDqGMYPMTzIOquAA7+VCYeE3DS9b6k3MEL
 ZVCL6ulIr7jc14Qc+0ittDgwjkkAaXUrBq6FJ8h/vQIjBhJgPSRXizvK6THMX7osQFGRcn0du
 dUKT56MUkMtzuZVePNDHCxbMlN304JUBfze9XYIXvroERHdYtsoQNS/qIoRZO8ZY0sPxkjg0m
 oHahf5OV9/n5l/QPq9kQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 18 Oct 2020 18:10:54 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 18 Oct 2020 18:00:12 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 18 Oct 2020 18:10:52 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Alexander Popov <alex.popov@linux.com>
Subject: Re: [Cocci] Determination of an usage statistic for memory
	allocation calls
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

PiDigKYKPiA+ICsgICAgRSA9IFwoa21hbGxvY1x8a3phbGxvY1x8a3JlYWxsb2NcfGtjYWxsb2Nc
fAo+ID4gKyAgICAgICAgICBrbWFsbG9jX25vZGVcfGt6YWxsb2Nfbm9kZVx8a21hbGxvY19hcnJh
eVx8Cj4gPiArICAgICAgICAgIGttYWxsb2NfYXJyYXlfbm9kZVx8a2NhbGxvY19ub2RlXCkoLi4u
KUBrb2sKPiDigKYKPiAKPiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRoZSBwb3NzaWJpbGl0eSBm
b3IgYW55IGFkanVzdG1lbnRzIGFjY29yZGluZyB0byB0aGUgb3JkZXIKPiBvZiB0aGUgbWVudGlv
bmVkIGZ1bmN0aW9uIG5hbWVzIGluIHByb3Bvc2VkIGRpc2p1bmN0aW9ucyBmb3IgdGhlIHNlbWFu
dGljIHBhdGNoIGxhbmd1YWdlPwoKCkkgd291bGQgbGlrZSB0byBzaGFyZSBhbm90aGVyIHNvdXJj
ZSBjb2RlIGFuYWx5c2lzIGFwcHJvYWNoLgpJIGhvcGUgdGhhdCB0aGlzIGNvbnRyaWJ1dGlvbiBj
YW4gdHJpZ2dlciBmdXJ0aGVyIGhlbHBmdWwgc29mdHdhcmUgZGV2ZWxvcG1lbnQgaWRlYXMuCgoK
QGluaXRpYWxpemU6cHl0aG9uQApAQAppbXBvcnQgc3lzCgpkZWYgd3JpdGVfaWRlbnRpZmllcihz
b3VyY2UsIGNhbGwpOgogICAgbmFtZXMgPSBbXQogICAgZm9yIHggaW4gc291cmNlOgogICAgICAg
bmFtZXMuYXBwZW5kKGNhbGwpCgogICAgc3lzLnN0ZG91dC53cml0ZSgiXG4iLmpvaW4obmFtZXMp
ICsgIlxuIikKCkBmaW5kMUAKZXhwcmVzc2lvbiBlOwppZGVudGlmaWVyIGNhbGwsIHg7CnBvc2l0
aW9uIHBvczsKdHlwZSBydDsKQEAKIHJ0IHgoLi4uKQogewogPCsuLi4KIGUgPUBwb3MKKGt6YWxs
b2NAY2FsbAp8a21hbGxvY0BjYWxsCnxrY2FsbG9jQGNhbGwKfGttYWxsb2NfYXJyYXlAY2FsbAp8
a21lbWR1cEBjYWxsCnxrc3RyZHVwQGNhbGwKfHZtYWxsb2NAY2FsbAp8dnphbGxvY0BjYWxsCnxr
emFsbG9jX25vZGVAY2FsbAp8a3ZtYWxsb2NAY2FsbAp8a3JlYWxsb2NAY2FsbAp8a21hbGxvY19u
b2RlQGNhbGwKfGtjYWxsb2Nfbm9kZUBjYWxsCnxfX3ZtYWxsb2NAY2FsbAp8dm1hbGxvY191c2Vy
QGNhbGwKfHZ6YWxsb2Nfbm9kZUBjYWxsCnx2bWFsbG9jXzMyQGNhbGwKfF9fdm1hbGxvY19ub2Rl
X3JhbmdlQGNhbGwKfHZtYWxsb2Nfbm9kZUBjYWxsCnxrbWFsbG9jX2FycmF5X25vZGVAY2FsbAp8
X192bWFsbG9jX25vZGVAY2FsbAp8dm1hbGxvY18zMl91c2VyQGNhbGwKfHZtYWxsb2NfZXhlY0Bj
YWxsCikoLi4uKQogLi4uKz4KIH0KCkBzY3JpcHQ6cHl0aG9uIGNvbGxlY3Rpb24xQApjYWxsIDw8
IGZpbmQxLmNhbGw7CnBsYWNlIDw8IGZpbmQxLnBvczsKQEAKd3JpdGVfaWRlbnRpZmllcihwbGFj
ZSwgY2FsbCkKCkBmaW5kMkAKaWRlbnRpZmllciBjYWxsLCB2YXIsIHg7CnBvc2l0aW9uIHBvczsK
dHlwZSBydCwgdnQ7CkBACiBydCB4KC4uLikKIHsKIDwrLi4uCiB2dCB2YXIgPUBwb3MKKGt6YWxs
b2NAY2FsbAp8a21hbGxvY0BjYWxsCnxrY2FsbG9jQGNhbGwKfGttYWxsb2NfYXJyYXlAY2FsbAp8
a21lbWR1cEBjYWxsCnxrc3RyZHVwQGNhbGwKfHZtYWxsb2NAY2FsbAp8dnphbGxvY0BjYWxsCnxr
emFsbG9jX25vZGVAY2FsbAp8a3ZtYWxsb2NAY2FsbAp8a3JlYWxsb2NAY2FsbAp8a21hbGxvY19u
b2RlQGNhbGwKfGtjYWxsb2Nfbm9kZUBjYWxsCnxfX3ZtYWxsb2NAY2FsbAp8dm1hbGxvY191c2Vy
QGNhbGwKfHZ6YWxsb2Nfbm9kZUBjYWxsCnx2bWFsbG9jXzMyQGNhbGwKfF9fdm1hbGxvY19ub2Rl
X3JhbmdlQGNhbGwKfHZtYWxsb2Nfbm9kZUBjYWxsCnxrbWFsbG9jX2FycmF5X25vZGVAY2FsbAp8
X192bWFsbG9jX25vZGVAY2FsbAp8dm1hbGxvY18zMl91c2VyQGNhbGwKfHZtYWxsb2NfZXhlY0Bj
YWxsCikoLi4uKTsKIC4uLis+CiB9CgpAc2NyaXB0OnB5dGhvbiBjb2xsZWN0aW9uMkAKY2FsbCA8
PCBmaW5kMi5jYWxsOwpwbGFjZSA8PCBmaW5kMi5wb3M7CkBACndyaXRlX2lkZW50aWZpZXIocGxh
Y2UsIGNhbGwpCgoKVGVzdCByZXN1bHQ6CmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9MaW51eC9u
ZXh0LXBhdGNoZWQ+IGdpdCBjaGVja291dCBuZXh0LTIwMjAxMDE2ICYmIFhYPSQoZGF0ZSkgJiYg
dGltZSBzcGF0Y2ggLS10aW1lb3V0IDIzIC0tcHl0aG9uIHB5dGhvbjMgLS1qb2JzIDQgLS1jaHVu
a3NpemUgMSAtLWluY2x1ZGUtaGVhZGVycyAtLW5vLWluY2x1ZGVzIC0tZGlyIC4gfi9Qcm9qZWt0
ZS9Db2NjaW5lbGxlL2phbml0b3IvcmVwb3J0X21lbW9yeV9hbGxvY2F0aW9uX2NhbGxzNC5jb2Nj
aSAyPiB+L1Byb2pla3RlL0JhdS9MaW51eC9zY3JpcHRzL0NvY2NpbmVsbGUvY2FsbF9jaGVja3Mv
MjAyMDEwMTYvcmVwb3J0X21lbW9yeV9hbGxvY2F0aW9uX2NhbGxzNC1lcnJvcnMudHh0IHwgZWNo
byAiJChlY2hvICdjYWxsJyAmJiBjYXQpIiB8IGNzdnNxbCAtLXF1ZXJ5ICdzZWxlY3QgY2FsbCwg
Y291bnQoKikgZnJvbSBzdGRpbiBncm91cCBieSBjYWxsIG9yZGVyIGJ5IGNvdW50KCopIGRlc2Mn
OyBZWT0kKGRhdGUpICYmIGVjaG8gIiRYWCB8ICRZWSIK4oCmCmNhbGwsY291bnQoKikKa3phbGxv
YywxMjY1MgprbWFsbG9jLDQ5MDIKa2NhbGxvYywyNTY0CmttYWxsb2NfYXJyYXksODU5CmttZW1k
dXAsNzk3CmtzdHJkdXAsNDY5CnZtYWxsb2MsNDA1CnZ6YWxsb2MsMzU5Cmt6YWxsb2Nfbm9kZSwx
NzcKa3ZtYWxsb2MsMTU0CmtyZWFsbG9jLDE1MQprbWFsbG9jX25vZGUsNDkKa2NhbGxvY19ub2Rl
LDQ0Cl9fdm1hbGxvYywzNAp2bWFsbG9jX3VzZXIsMjgKdnphbGxvY19ub2RlLDIxCnZtYWxsb2Nf
MzIsOQpfX3ZtYWxsb2Nfbm9kZV9yYW5nZSw4CnZtYWxsb2Nfbm9kZSw3CmttYWxsb2NfYXJyYXlf
bm9kZSw1Cl9fdm1hbGxvY19ub2RlLDQKdm1hbGxvY18zMl91c2VyLDEKCnJlYWwJMjJtMjUsMDQ5
cwp1c2VyCTg0bTExLDI1N3MKc3lzCTBtMTIsMTY4cwpTbyAxOC4gT2t0IDE2OjU1OjA4IENFU1Qg
MjAyMCB8IFNvIDE4LiBPa3QgMTc6MTc6MzMgQ0VTVCAyMDIwCgoKVGhlIGxvZyBmaWxlIGNvbnRh
aW5zIHRoZSBpbmZvcm1hdGlvbiDigJw5MjExIGZpbGVzIG1hdGNo4oCdLgpDYW4gc3VjaCBmYWN0
cyBpbmZsdWVuY2UgdGhlIHNwZWNpZmljYXRpb24gb2YgZWZmaWNpZW50IFNtUEwgZGlzanVuY3Rp
b25zIGFub3RoZXIgYml0PwoKUmVnYXJkcywKTWFya3VzCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3Rl
bWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2Np
Cg==
