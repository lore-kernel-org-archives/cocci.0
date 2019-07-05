Return-Path: <SRS0=jYvI=VC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB2FC5B57D
	for <cocci@archiver.kernel.org>; Fri,  5 Jul 2019 05:58:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D28F218A0
	for <cocci@archiver.kernel.org>; Fri,  5 Jul 2019 05:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D28F218A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x655wSZ1002958;
	Fri, 5 Jul 2019 07:58:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CAC3D777B;
	Fri,  5 Jul 2019 07:58:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C4C5476B2
 for <cocci@systeme.lip6.fr>; Fri,  5 Jul 2019 07:58:27 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x655wO2Z029084
 for <cocci@systeme.lip6.fr>; Fri, 5 Jul 2019 07:58:25 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id ACA26330BB864B775139;
 Fri,  5 Jul 2019 13:58:21 +0800 (CST)
Received: from kjyxapp02.zte.com.cn ([10.30.12.201])
 by mse-fl1.zte.com.cn with SMTP id x655vOjJ091509;
 Fri, 5 Jul 2019 13:57:24 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp05[null]) by mapi (Zmail) with MAPI id mid14;
 Fri, 5 Jul 2019 13:57:24 +0800 (CST)
Date: Fri, 5 Jul 2019 13:57:24 +0800 (CST)
X-Zmail-TransId: 2b075d1ee6c4e9cef63c
X-Mailer: Zmail v1.0
Message-ID: <201907051357245235750@zte.com.cn>
In-Reply-To: <alpine.DEB.2.21.1907050727550.18245@hadrien>
References: 1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn,
 201907041103003504524@zte.com.cn, alpine.DEB.2.21.1907050727550.18245@hadrien
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <julia.lawall@lip6.fr>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn x655vOjJ091509
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jul 2019 07:58:29 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jul 2019 07:58:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, Markus.Elfring@web.de,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?=5BPATCH_v2=5D_coccinelle=3A_semantic_code_sear?=
	=?utf-8?q?ch_formissingof=5Fnode=5Fput?=
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

PiA+ID4gPiA+ICt4ID0gQHAxXChvZl9maW5kX2FsbF9ub2Rlc1x8Cj4gPiA+ID4KPiA+ID4gPiBJ
IHdvdWxkIGZpbmQgdGhpcyBTbVBMIGRpc2p1bmN0aW9uIGVhc2llciB0byByZWFkIHdpdGhvdXQg
dGhlIHVzYWdlCj4gPiA+ID4gb2YgZXh0cmEgYmFja3NsYXNoZXMuCj4gPiA+ID4KPiA+ID4gPiAr
eCA9Cj4gPiA+ID4gKyhvZl/igKYKPiA+ID4gPiArfG9mX+KApgo+ID4gPiA+ICspQHAxKC4uLik7
Cj4gPiA+Cj4gPiA+IERpZCB5b3UgYWN0dWFsbHkgdGVzdCB0aGlzPyAgSSBkb3VidCB0aGF0IGEg
cG9zaXRpb24gbWV0YXZhcmlhYmxlIGNhbiBiZQo+ID4gPiBwdXQgb24gYSApIG9mIGEgZGlzanVu
Y3Rpb24uCj4gPiA+Cj4gPiA+ID4gPiArfAo+ID4gPiA+ID4gK3JldHVybiB4Owo+ID4gPiA+ID4g
K3wKPiA+ID4gPiA+ICtyZXR1cm4gb2ZfZndub2RlX2hhbmRsZSh4KTsKPiA+ID4gPgo+ID4gPiA+
IENhbiBhIG5lc3RlZCBTbVBMIGRpc2p1bmN0aW9uIGJlIGhlbHBmdWwgYXQgc3VjaCBwbGFjZXM/
Cj4gPiA+ID4KPiA+ID4gPiArfHJldHVybgo+ID4gPiA+ICsoeAo+ID4gPiA+ICt8b2ZfZndub2Rl
X2hhbmRsZSh4KQo+ID4gPiA+ICspOwo+ID4gPgo+ID4gPiBUaGUgb3JpZ2luYWwgY29kZSBpcyBt
dWNoIG1vcmUgcmVhZGFibGUuICBUaGUgaW50ZXJuYWwgcmVwcmVzZW50YXRpb24gd2lsbAo+ID4g
PiBiZSB0aGUgc2FtZS4KPiA+ID4KPiA+ID4gPiA+ICsgICAgd2hlbiAhPSB2NGwyX2FzeW5jX25v
dGlmaWVyX2FkZF9md25vZGVfc3ViZGV2KDwuLi54Li4uPikKPiA+ID4gPgo+ID4gPiA+IFdvdWxk
IHRoZSBzcGVjaWZpY2F0aW9uIHZhcmlhbnQg4oCcPCsuLi4geCAuLi4rPuKAnSBiZSByZWxldmFu
dAo+ID4gPiA+IGZvciB0aGUgcGFyYW1ldGVyIHNlbGVjdGlvbj8KPiA+ID4KPiA+ID4gSSdtIGlu
ZGVlZCBxdWl0ZSBzdXJwcmlzZWQgdGhhdCA8Li4ueC4uLj4gd291bGQgYmUgYWNjZXB0ZWQgYnkg
dGhlIHBhcnNlci4uCj4gPgo+ID4gSGkganVsaWEsCj4gPgo+ID4gVGhhbmsgeW91IGZvciB5b3Vy
IGNvbW1lbnRzLgo+ID4gV2UgdGVzdGVkIGFuZCBmb3VuZCB0aGF0IGJvdGggPC4uLnguLi4+IGFu
ZCA8Ky4uLiB4IC4uLis+IHZhcmlhbnRzIHdvcmsgZmluZS4KPiA+IFdlIHVzZSA8Li4uIHggLi4u
PiBpbnN0ZWFkIG9mIDwrLi4uIHggLi4uKz4gaGVyZSB0byBlbGltaW5hdGUgdGhlIGZvbGxvd2lu
ZyBmYWxzZSBwb3NpdGl2ZXM6Cj4gPgo+ID4gLi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3Fjb20v
Y2Ftc3MvY2Ftc3MuYzo1MDQ6MS03OiBFUlJPUjogbWlzc2luZyBvZl9ub2RlX3B1dDsgYWNxdWly
ZWQgYSBub2RlIHBvaW50ZXIgd2l0aCByZWZjb3VudCBpbmNyZW1lbnRlZCBvbiBsaW5lIDQ3OSwg
YnV0IHdpdGhvdXQgYSBjb3JyZXNwb25kaW5nIG9iamVjdCByZWxlYXNlIHdpdGhpbiB0aGlzIGZ1
bmN0aW9uLgo+ID4KPiA+IDQ2NSBzdGF0aWMgaW50IGNhbXNzX29mX3BhcnNlX3BvcnRzKHN0cnVj
dCBjYW1zcyAqY2Ftc3MpCj4gPiA0NjYgewo+ID4gLi4uCj4gPiA0NzkgcmVtb3RlID0gb2ZfZ3Jh
cGhfZ2V0X3JlbW90ZV9wb3J0X3BhcmVudChub2RlKTsKPiA+IC4uLgo+ID4gNDg2IGFzZCA9IHY0
bDJfYXN5bmNfbm90aWZpZXJfYWRkX2Z3bm9kZV9zdWJkZXYoCj4gPiA0ODcgJmNhbXNzLT5ub3Rp
Zmllciwgb2ZfZndub2RlX2hhbmRsZShyZW1vdGUpLCAtLS0+IHY0bDJfYXN5bmNfbm90aWZpZXJf
YWRkX2Z3bm9kZV9zdWJkZXYgd2lsbCBwYXNzIHJlbW90ZSB0byBjYW1zcy0+bm90aWZpZXIuCj4g
PiA0ODggc2l6ZW9mKCpjc2QpKTsKPiA+IC4uLgo+ID4gNTA0IHJldHVybiBudW1fc3ViZGV2czsK
PiAKPiBJIHN1c3BlY3QgdGhhdCB3aGF0IGlzIGhhcHBlbmluZyBpcyB0aGF0IHRoZXJlIGlzIGEg
cnVudGltZSBlcnJvciwgYnV0Cj4gdGhhdCBlcnJvciBpcyBjYXVnaHQgc29tZXdoZXJlIGFuZCB5
b3UgZG9uJ3Qgc2VlIGl0LiAKClRoYW5rcy4KWW91IGFyZSByaWdodCwgdGhlcmUgaXMgaW5kZWVk
IGEgcnVudGltZSBlcnJvci4gClNpbmNlIG1ha2UgY29jY2ljaGVjayBhZGRzIHRoZSAiLXZlcnkt
cXVpZXQiIHBhcmFtZXRlciBieSBkZWZhdWx0LCB3ZSBkaWRuJ3QgZmluZCBpdC4KCiQgc3BhdGNo
IC0tc3AtZmlsZSAgIG9mX25vZGVfcHV0LmNvY2NpICAgLUQgcmVwb3J0IGRyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vYW00Mzd4L2FtNDM3eC12cGZlLmMKaW5pdF9kZWZzX2J1aWx0aW5zOiAvdXNyL2xv
Y2FsL2Jpbi8uLi9saWIvY29jY2luZWxsZS9zdGFuZGFyZC5oCkhBTkRMSU5HOiBkcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL2FtNDM3eC9hbTQzN3gtdnBmZS5jCmV4biB3aGlsZSBpbiB0aW1lb3V0X2Z1
bmN0aW9uCm9ubHkgaGFuZGxpbmcgbXVsdGkgYW5kIG5vIHdoZW4gY29kZSBpbiBhIG5lc3QgZXhw
cgoKPiAgQ291bGQgeW91IHNlbmQgbWUgYWdhaW4gdGhlIGVudGlyZSBzZW1hbnRpYyBwYXRjaCBz
byBJIGNhbiBjaGVjayBvbiB0aGlzPwo+IAoKVGhhbmtzLgpUaGUgZW50aXJlIFNtUEwgaXMgYXMg
Zm9sbG93czoKCiQgY2F0IG9mX25vZGVfcHV0LmNvY2NpCi8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wCi8vLyBGaW5kIG1pc3Npbmcgb2Zfbm9kZV9wdXQKLy8vCi8vIENvbmZpZGVu
Y2U6IE1vZGVyYXRlCi8vIENvcHlyaWdodDogKEMpIDIwMTgtMjAxOSBXZW4gWWFuZywgWlRFLgov
LyBDb21tZW50czoKLy8gT3B0aW9uczogLS1uby1pbmNsdWRlcyAtLWluY2x1ZGUtaGVhZGVycwoK
dmlydHVhbCByZXBvcnQKdmlydHVhbCBvcmcKCkBpbml0aWFsaXplOnB5dGhvbkAKQEAKCnNlZW4g
PSBzZXQoKQoKZGVmIGFkZF9pZl9ub3RfcHJlc2VudCAocDEsIHAyKToKICAgIGlmIChwMSwgcDIp
IG5vdCBpbiBzZWVuOgogICAgICAgIHNlZW4uYWRkKChwMSwgcDIpKQogICAgICAgIHJldHVybiBU
cnVlCiAgICByZXR1cm4gRmFsc2UKCmRlZiBkaXNwbGF5X3JlcG9ydChwMSwgcDIpOgogICAgaWYg
YWRkX2lmX25vdF9wcmVzZW50KHAxWzBdLmxpbmUsIHAyWzBdLmxpbmUpOgogICAgICAgY29jY2ls
aWIucmVwb3J0LnByaW50X3JlcG9ydChwMlswXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIkVSUk9SOiBtaXNzaW5nIG9mX25vZGVfcHV0OyBhY3F1aXJlZCBhIG5vZGUgcG9p
bnRlciB3aXRoIHJlZmNvdW50IGluY3JlbWVudGVkIG9uIGxpbmUgIgogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICArIHAxWzBdLmxpbmUKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKyAiLCBidXQgd2l0aG91dCBhIGNvcnJlc3BvbmRpbmcgb2JqZWN0IHJlbGVh
c2Ugd2l0aGluIHRoaXMgZnVuY3Rpb24uIikKCmRlZiBkaXNwbGF5X29yZyhwMSwgcDIpOgogICAg
Y29jY2kucHJpbnRfbWFpbigiYWNxdWlyZWQgYSBub2RlIHBvaW50ZXIgd2l0aCByZWZjb3VudCBp
bmNyZW1lbnRlZCIsIHAxKQogICAgY29jY2kucHJpbnRfc2VjcygibmVlZGVkIG9mX25vZGVfcHV0
IiwgcDIpCgpAcjEgZXhpc3RzQApsb2NhbCBpZGV4cHJlc3Npb24gc3RydWN0IGRldmljZV9ub2Rl
ICp4OwpleHByZXNzaW9uIGUsIGUxOwpwb3NpdGlvbiBwMSwgcDI7CnN0YXRlbWVudCBTOwp0eXBl
IFQ7CkBACgp4ID0gQHAxXChvZl9maW5kX2FsbF9ub2Rlc1x8CiAgICAgICAgIG9mX2dldF9jcHVf
bm9kZVx8CiAgICAgICAgIG9mX2dldF9wYXJlbnRcfAogICAgICAgICBvZl9nZXRfbmV4dF9wYXJl
bnRcfAogICAgICAgICBvZl9nZXRfbmV4dF9jaGlsZFx8CiAgICAgICAgIG9mX2dldF9uZXh0X2Nw
dV9ub2RlXHwKICAgICAgICAgb2ZfZ2V0X2NvbXBhdGlibGVfY2hpbGRcfAogICAgICAgICBvZl9n
ZXRfY2hpbGRfYnlfbmFtZVx8CiAgICAgICAgIG9mX2ZpbmRfbm9kZV9vcHRzX2J5X3BhdGhcfAog
ICAgICAgICBvZl9maW5kX25vZGVfYnlfbmFtZVx8CiAgICAgICAgIG9mX2ZpbmRfbm9kZV9ieV90
eXBlXHwKICAgICAgICAgb2ZfZmluZF9jb21wYXRpYmxlX25vZGVcfAogICAgICAgICBvZl9maW5k
X25vZGVfd2l0aF9wcm9wZXJ0eVx8CiAgICAgICAgIG9mX2ZpbmRfbWF0Y2hpbmdfbm9kZV9hbmRf
bWF0Y2hcfAogICAgICAgICBvZl9maW5kX25vZGVfYnlfcGhhbmRsZVx8CiAgICAgICAgIG9mX3Bh
cnNlX3BoYW5kbGVcfAogICAgICAgICBvZl9maW5kX25leHRfY2FjaGVfbm9kZVx8CiAgICAgICAg
IG9mX2dldF9uZXh0X2F2YWlsYWJsZV9jaGlsZFwpKC4uLik7Ci4uLgppZiAoeCA9PSBOVUxMIHx8
IC4uLikgUwouLi4gd2hlbiAhPSBlID0gKFQpeAogICAgd2hlbiAhPSB0cnVlIHggPT0gTlVMTAog
ICAgd2hlbiAhPSBvZl9ub2RlX3B1dCh4KQogICAgd2hlbiAhPSBvZl9nZXRfbmV4dF9wYXJlbnQo
eCkKICAgIHdoZW4gIT0gb2ZfZmluZF9tYXRjaGluZ19ub2RlKHgsIC4uLikKICAgIHdoZW4gIT0g
aWYgKHgpIHsgLi4uIHJldHVybiB4OyB9CiAgICB3aGVuICE9IHY0bDJfYXN5bmNfbm90aWZpZXJf
YWRkX2Z3bm9kZV9zdWJkZXYoPC4uLnguLi4+KQogICAgd2hlbiAhPSBlMSA9IG9mX2Z3bm9kZV9o
YW5kbGUoeCkKKAppZiAoeCkgeyAuLi4gd2hlbiBmb3JhbGwKICAgICAgICAgb2Zfbm9kZV9wdXQo
eCkgLi4uIH0KfApyZXR1cm4geDsKfApyZXR1cm4gb2ZfZndub2RlX2hhbmRsZSh4KTsKfApyZXR1
cm5AcDIgLi4uOwopCgpAc2NyaXB0OnB5dGhvbiBkZXBlbmRzIG9uIHJlcG9ydCAmJiByMUAKcDEg
PDwgcjEucDE7CnAyIDw8IHIxLnAyOwpAQAoKZGlzcGxheV9yZXBvcnQocDEsIHAyKQoKQHNjcmlw
dDpweXRob24gZGVwZW5kcyBvbiBvcmcgJiYgcjFACnAxIDw8IHIxLnAxOwpwMiA8PCByMS5wMjsK
QEAKCmRpc3BsYXlfb3JnKHAxLCBwMikKCkByMiBleGlzdHNACmxvY2FsIGlkZXhwcmVzc2lvbiBz
dHJ1Y3QgZGV2aWNlX25vZGUgKng7CmV4cHJlc3Npb24gZSwgZTE7CnBvc2l0aW9uIHAxLCBwMjsK
aWRlbnRpZmllciBmOwpzdGF0ZW1lbnQgUzsKdHlwZSBUOwpAQAoKKAp4ID0gZkBwMSguLi4pOwou
Li4gd2hlbiAhPSBlID0gKFQpeAogICAgd2hlbiAhPSB0cnVlIHggPT0gTlVMTAogICAgd2hlbiAh
PSBvZl9ub2RlX3B1dCh4KQogICAgd2hlbiAhPSBvZl9nZXRfbmV4dF9wYXJlbnQoeCkKICAgIHdo
ZW4gIT0gb2ZfZmluZF9tYXRjaGluZ19ub2RlKHgsIC4uLikKICAgIHdoZW4gIT0gaWYgKHgpIHsg
Li4uIHJldHVybiB4OyB9CiAgICB3aGVuICE9IHY0bDJfYXN5bmNfbm90aWZpZXJfYWRkX2Z3bm9k
ZV9zdWJkZXYoPC4uLnguLi4+KQogICAgd2hlbiAhPSBlMSA9IG9mX2Z3bm9kZV9oYW5kbGUoeCkK
KAppZiAoeCkgeyAuLi4gd2hlbiBmb3JhbGwKICAgICAgICAgb2Zfbm9kZV9wdXQoeCkgLi4uIH0K
fApyZXR1cm4geDsKfApyZXR1cm4gb2ZfZndub2RlX2hhbmRsZSh4KTsKfApyZXR1cm5AcDIgLi4u
OwopCiYKeCA9IGYoLi4uKQouLi4KaWYgKDwrLi4ueC4uLis+KSBTCi4uLgpvZl9ub2RlX3B1dCh4
KTsKKQpAc2NyaXB0OnB5dGhvbiBkZXBlbmRzIG9uIHJlcG9ydCAmJiByMkAKcDEgPDwgcjIucDE7
CnAyIDw8IHIyLnAyOwpAQAoKZGlzcGxheV9yZXBvcnQocDEsIHAyKQoKQHNjcmlwdDpweXRob24g
ZGVwZW5kcyBvbiBvcmcgJiYgcjJACnAxIDw8IHIyLnAxOwpwMiA8PCByMi5wMjsKQEAKCmRpc3Bs
YXlfb3JnKHAxLCBwMikKCj4gSSB0aGluayB0aGF0IHdoYXQgeW91IHdhbnQgaXM6Cj4gCj4gd2hl
biAhPSB2NGwyX2FzeW5jX25vdGlmaWVyX2FkZF9md25vZGVfc3ViZGV2KC4uLiw8Ky4uLnguLi4r
PiwuLi4pCj4gCj4gaWUgeCBvY2N1cnJpbmcgc29tZXdoZXJlIHdpdGhpbiBzb21lIGFyZ3VtZW50
LgoKVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBzdWdnZXN0aW9uLiAKQXBwbHlpbmcgaXQg
d2lsbCBzb2x2ZSB0aGlzIHByb2JsZW0sIHRoYW5rIHlvdS4KCi0tClRoYW5rcyBhbmQgcmVnYXJk
cywKV2Vu


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

