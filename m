Return-Path: <SRS0=XtGu=TJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54059C04A6B
	for <cocci@archiver.kernel.org>; Thu,  9 May 2019 01:47:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F67B20675
	for <cocci@archiver.kernel.org>; Thu,  9 May 2019 01:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F67B20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x491lIrx024740
          ; Thu, 9 May 2019 03:47:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3B2367739;
	Thu,  9 May 2019 03:47:18 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4D1207736
 for <cocci@systeme.lip6.fr>; Thu,  9 May 2019 03:47:16 +0200 (CEST)
Received: from mxct.zte.com.cn (mx7.zte.com.cn [202.103.147.169])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x491lC5i005606
 for <cocci@systeme.lip6.fr>; Thu, 9 May 2019 03:47:13 +0200 (CEST)
X-pt: isis.lip6.fr
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id 16755A15FEBB90D676DC;
 Thu,  9 May 2019 09:47:11 +0800 (CST)
Received: from kjyxapp03.zte.com.cn ([10.30.12.202])
 by mse-fl1.zte.com.cn with SMTP id x491l1F8093017;
 Thu, 9 May 2019 09:47:01 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp03[null]) by mapi (Zmail) with MAPI id mid14;
 Thu, 9 May 2019 09:47:01 +0800 (CST)
Date: Thu, 9 May 2019 09:47:01 +0800 (CST)
X-Zmail-TransId: 2b055cd386955599c184
X-Mailer: Zmail v1.0
Message-ID: <201905090947015772925@zte.com.cn>
In-Reply-To: <3a3ad66c-833a-b35d-7d75-32189ca67436@web.de>
References: 1557216744-25339-1-git-send-email-wen.yang99@zte.com.cn,
 3a3ad66c-833a-b35d-7d75-32189ca67436@web.de
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn x491l1F8093017
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 09 May 2019 03:47:18 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 09 May 2019 03:47:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?=5BPATCH=5D_coccinelle=3A_semantic_patch_for_mi?=
	=?utf-8?q?ssing_of=5Fnode=5Fput?=
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

SGkgTWFya3VzLApUaGFua3MgZm9yIHRoZSByZXZpZXcuICAKCj4gPiBUaGUgY2FsbCB0byBvZl9w
YXJzZV9waGFuZGxlKCkvb2ZfZmluZF9ub2RlX2J5X25hbWUoKSAuLi4gcmV0dXJucyBhIG5vZGUK
PiA+IHBvaW50ZXIgd2l0aCByZWZjb3VudCBpbmNyZW1lbnRlZCB0aHVzIGl0IG11c3QgYmUgZXhw
bGljaXRseSBkZWNyZW1lbnRlZAo+ID4gYWZ0ZXIgdGhlIGxhc3QgdXNhZ2UuCj4gPgo+ID4gVGhp
cyBTbVBMIGlzIGFsc28gbG9va2luZyBmb3IgcGxhY2VzIHdoZXJlIHRoZXJlIGlzIGFuIG9mX25v
ZGVfcHV0IG9uCj4gPiBzb21lIHBhdGggYnV0IG5vdCBvbiBvdGhlcnMuCj4gCj4gSSBzdWdnZXN0
IHRvIGltcHJvdmUgdGhpcyBjb21taXQgZGVzY3JpcHRpb24uCj4gCj4gKiBQb3NzaWJsZSB3b3Jk
aW5nOgo+IFRoZXJlIGFyZSBmdW5jdGlvbnMgd2hpY2ggaW5jcmVtZW50IGEgcmVmZXJlbmNlIGNv
dW50ZXIgZm9yIGEgZGV2aWNlIG5vZGUuCj4gVGhlc2UgZnVuY3Rpb25zIGJlbG9uZyB0byBhIHBy
b2dyYW1taW5nIGludGVyZmFjZSBmb3IgdGhlIG1hbmFnZW1lbnQKPiBvZiBpbmZvcm1hdGlvbiBm
cm9tIGRldmljZSB0cmVlcy4KPiBUaGUgY291bnRlciBtdXN0IGJlIGRlY3JlbWVudGVkIGFmdGVy
IHRoZSBsYXN0IHVzYWdlIG9mIGEgZGV2aWNlIG5vZGUuCj4gCj4gVGhpcyBTbVBMIHNjcmlwdCBs
b29rcyBhbHNvIGZvciBwbGFjZXMgd2hlcmUgYSBvZl9ub2RlX3B1dCgpIGNhbGwgaXMgb24KPiBz
b21lIHBhdGhzIGJ1dCBub3Qgb24gb3RoZXJzLgo+IAo+ICogV2lsbCB0aGUgd29yZCDigJxwYXRj
aOKAnSBiZSByZXBsYWNlZCBieSDigJxjb2RlIHNlYXJjaOKAnSBpbiB0aGUgY29tbWl0IHN1Ympl
Y3QKPiBiZWNhdXNlIHRoZSBvcGVyYXRpb24gbW9kZXMg4oCccmVwb3J04oCdIGFuZCDigJxvcmfi
gJ0gYXJlIHN1cHBvcnRlZCBoZXJlPwo+IAo+IAo+ID4gK0Bpbml0aWFsaXplOnB5dGhvbkAKPiA+
ICtAQAo+IAo+IFN1Y2ggYSBTbVBMIHJ1bGUgd291bGQgYXBwbHkgdG8gZXZlcnkgcG9zc2libGUg
b3BlcmF0aW9uIG1vZGUuCj4gSSBoYXZlIG5vdGljZWQgdGhlbiB0aGF0IHRoZSB0d28gUHl0aG9u
IHZhcmlhYmxlcyBmcm9tIGhlcmUgd2lsbCBiZSBuZWVkZWQKPiBvbmx5IGluIHR3byBTbVBMIHJ1
bGVzIHdoaWNoIGRlcGVuZCBvbiB0aGUgbW9kZSDigJxyZXBvcnTigJ0uCj4gCj4gKiBUaHVzIEkg
d291bGQgcHJlZmVyIHRvIGFkanVzdCB0aGUgZGVwZW5kZW5jeSBzcGVjaWZpY2F0aW9uIGFjY29y
ZGluZ2x5Lgo+IAo+ICogUGxlYXNlIHJlcGxhY2UgdGhlc2UgdmFyaWFibGVzIGJ5IGEgc2VwYXJh
dGUgZnVuY3Rpb24gbGlrZQo+IHRoZSBmb2xsb3dpbmcuCj4gZGVmIGRpc3BsYXkxKHAxICxwMik6
Cj4gaWYgYWRkX2lmX25vdF9wcmVzZW50KHAxWzBdLmxpbmUsIHAyWzBdLmxpbmUpOgo+IGNvY2Np
bGliLnJlcG9ydC5wcmludF9yZXBvcnQocDJbMF0sCj4gInByZWZpeCIKPiArIHAxWzBdLmxpbmUK
PiArICJzdWZmaXgiKQo+IAo+IAo+ICogUGxlYXNlIG1vdmUgYW5vdGhlciBiaXQgb2YgZHVwbGlj
YXRlIGNvZGUgdG8gYSBzZXBhcmF0ZSBmdW5jdGlvbiBsaWtlCj4gdGhlIGZvbGxvd2luZy4KPiBk
ZWYgZGlzcGxheTIocDEgLHAyKToKPiBjb2NjaS5wcmludF9tYWluKCJDaG9vc2UgaW5mbyAxIiwg
cDEpCj4gY29jY2kucHJpbnRfc2VjcygiQ2hvb3NlIGluZm8gMiIsIHAyKQo+IApUaGFua3MuCkkg
d2lsbCB1cGRhdGUgdGhlIHBhdGNoIGFjY29yZGluZyB0byB5b3VyIHN1Z2dlc3Rpb25zIGFib3Zl
LgoKPiA+ICt4ID0gQHAxXChvZl9maW5kX2NvbXBhdGlibGVfbm9kZVx8b2ZfZmluZF9ub2RlX2J5
X25hbWVcfG9mX3BhcnNlX3BoYW5kbGVcfAo+IAo+IElmIHlvdSB3b3VsZCBsaWtlIHRvIGluc2lz
dCB0byB1c2Ugc3VjaCBhIFNtUEwgZGlzanVuY3Rpb24sIEkgd291bGQgcHJlZmVyCj4gYW4gb3Ro
ZXIgY29kZSBmb3JtYXR0aW5nIGhlcmUuCj4gSG93IGRvIHlvdSB0aGluayBhYm91dCB0byBwdXQg
ZWFjaCBmdW5jdGlvbiBuYW1lIG9uIGEgc2VwYXJhdGUgbGluZT8KPiAKPiBDYW4gc3VjaCBhIG5h
bWUgbGlzdCBiZSBldmVyIGF1dG9tYXRpY2FsbHkgZGV0ZXJtaW5lZCBmcm9tIGFuIG90aGVyCj4g
aW5mb3JtYXRpb24gc291cmNlPwo+IChBcmUgdGhlcmUgY2lyY3Vtc3RhbmNlcyB0byBjb25zaWRl
ciB1bmRlciB3aGljaCB0aGUgYXBwbGljYXRpb24gb2YKPiBhIGRldGFpbGVkIHJlZ3VsYXIgZXhw
cmVzc2lvbiB3b3VsZCBiZWNvbWUgaW50ZXJlc3RpbmcgZm9yIGEgU21QTCBjb25zdHJhaW50PykK
PiAKPiBXaWxsIGl0IGJlIGluZmx1ZW5jZWQgYnkgYW55IHNvcnQgY3JpdGVyaWE/Cj4gClRoYW5r
cy4gCkl0J3MgaW50ZXJlc3RpbmcgdG8gZ2V0IHRoZSBmdW5jdGlvbiBsaXN0IGF1dG9tYXRpY2Fs
bHkuCkknbGwgdHJ5IHRvIHBhcnNlIHRoZSBkcml2ZXJzL29mL2Jhc2UuYyBmaWxlIGJhc2VkIG9u
IGNvbW1lbnRzIGxpa2UgdGhpcwoiKiBSZXR1cm5zIGEgbm9kZSBwb2ludGVyIHdpdGggcmVmY291
bnQgaW5jcmVtZW50ZWQsIHVzZQoqIG9mX25vZGVfcHV0KCkgb24gaXQgd2hlbiBkb25lLiIKdG8g
YXV0b21hdGljYWxseSBnZXQgdGhlIG5hbWUgb2YgdGhlIGZ1bmN0aW9uIHRoYXQgbmVlZHMgdG8g
YmUgY2hlY2tlZC4KCj4gPiArICAgIHdoZW4gIT0gb2Zfbm9kZV9wdXQoeCkKPiDigKYKPiA+ICsg
ICAgd2hlbiAhPSBpZiAoeCkgeyAuLi4gb2Zfbm9kZV9wdXQoeCkgLi4uIH0KPiAKPiBJIGZpbmQg
dGhlIHNlY29uZCB3aGVuIGNvbnN0cmFpbnQgc3BlY2lmaWNhdGlvbiB1bm5lY2Vzc2FyeSBiZWNh
dXNlCj4gdGhlIHByZXZpb3VzIG9uZSBzaG91bGQgYmUgc3VmZmljaWVudCB0byBleGNsdWRlIHN1
Y2ggYSBmdW5jdGlvbiBjYWxsLgo+IApUaGFua3MuCkkgYWRkZWQgdGhlICJ3aGVuICE9IGlmICh4
KSB7IC4uLiBvZl9ub2RlX3B1dCh4KSAuLi4gfSIgc3RhdGVtZW50IHRvIGF2b2lkCiBmYWxzZSBw
b3NpdGl2ZXMgc2ltaWxhciB0byB0aGUgZm9sbG93aW5nOgouL2FyY2gvcG93ZXJwYy9wbGF0Zm9y
bXMvcG93ZXJtYWMvc2V0dXAuYzo1MTM6MS03OiBFUlJPUjogbWlzc2luZyBvZl9ub2RlX3B1dDsg
CmFjcXVpcmVkIGEgbm9kZSBwb2ludGVyIHdpdGggcmVmY291bnQgaW5jcmVtZW50ZWQgb24gbGlu
ZSA1MDMsIApidXQgd2l0aG91dCBhIGNvcnJlc3BvbmRpbmcgb2JqZWN0IHJlbGVhc2Ugd2l0aGlu
IHRoaXMgZnVuY3Rpb24uCgo0ODQgc3RhdGljIGludCBfX2luaXQgcG1hY19kZWNsYXJlX29mX3Bs
YXRmb3JtX2RldmljZXModm9pZCkKNDg1IHsKNDg2ICAgICAgICAgc3RydWN0IGRldmljZV9ub2Rl
ICpucDsKLi4uCjUwMyAgICAgICAgIG5wID0gb2ZfZmluZF9ub2RlX2J5X3R5cGUoTlVMTCwgImZj
dSIpOwo1MDQgICAgICAgICBpZiAobnAgPT0gTlVMTCkgewo1MDUgICAgICAgICAgICAgICAgIC8q
IFNvbWUgbWFjaGluZXMgaGF2ZSBzdHJhbmdlbHkgYnJva2VuIGRldmljZS10cmVlICovCjUwNiAg
ICAgICAgICAgICAgICAgbnAgPSBvZl9maW5kX25vZGVfYnlfcGF0aCgiL3UzQDAsZjgwMDAwMDAv
aTJjQGY4MDAxMDAwL2ZhbkAxNWUiKTsKNTA3ICAgICAgICAgfQo1MDggICAgICAgICBpZiAobnAp
IHsKNTA5ICAgICAgICAgICAgICAgICBvZl9wbGF0Zm9ybV9kZXZpY2VfY3JlYXRlKG5wLCAidGVt
cGVyYXR1cmUiLCBOVUxMKTsKNTEwICAgICAgICAgICAgICAgICBvZl9ub2RlX3B1dChucCk7CjUx
MSAgICAgICAgIH0KNTEyIAo1MTMgICAgICAgICByZXR1cm4gMDsKNTE0IH0KCldlIHdpbGwgY29u
dGludWUgdG8gYW5hbHl6ZSB0aGUgY29kZSBvZiBjb2NjaW5lbGxlIHRvIGNvbmZpcm0gd2hldGhl
cgp0aGlzIGZhbHNlIHBvc2l0aXZlIGlzIGEgYnVnIGluIGNvY2NpbmVsbGUuCkJ1dCB0aGlzIHN0
YXRlbWVudCBpcyBjdXJyZW50bHkgbmVlZGVkIGhlcmUuCgotLQpSZWdhcmRzLApXZW4KCj4gCj4g
Q2FuIHRoZSBzcGVjaWZpY2F0aW9uIOKAnHdoZW4gIT0gXCggb2Zfbm9kZV9wdXQgXHwgb2ZfZ2V0
X25leHRfcGFyZW50IFwpICh4KeKAnQo+IGJlIHVzZWZ1bD8KPiAKPiAKPiA+ICtyZXR1cm4geDsK
PiA+ICt8Cj4gPiArcmV0dXJuIG9mX2Z3bm9kZV9oYW5kbGUoeCk7Cj4gCj4gQ2FuIGl0IGJlIG5p
Y2VyIHRvIG1lcmdlIHRoaXMgYml0IG9mIGNvZGUgaW50byBhbm90aGVyIFNtUEwgZGlzanVuY3Rp
b24/Cj4gCj4gK3JldHVybiBcKCB4IFx8IG9mX2Z3bm9kZV9oYW5kbGUoeCkgXCk7Cj4gCj4gCj4g
UmVnYXJkcywKPiBNYXJrdXM=


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

