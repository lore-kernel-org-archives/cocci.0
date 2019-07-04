Return-Path: <SRS0=5Xvi=VB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48485C5B578
	for <cocci@archiver.kernel.org>; Thu,  4 Jul 2019 02:42:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE5621882
	for <cocci@archiver.kernel.org>; Thu,  4 Jul 2019 02:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE5621882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x642g7eU024627;
	Thu, 4 Jul 2019 04:42:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 22BD0777A;
	Thu,  4 Jul 2019 04:42:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9784D7777
 for <cocci@systeme.lip6.fr>; Thu,  4 Jul 2019 04:42:04 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x642g1YP004689
 for <cocci@systeme.lip6.fr>; Thu, 4 Jul 2019 04:42:03 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id 4D8C15AC1EBA2F8B7F18;
 Thu,  4 Jul 2019 10:41:59 +0800 (CST)
Received: from kjyxapp03.zte.com.cn ([10.30.12.202])
 by mse-fl2.zte.com.cn with SMTP id x642fAfx064205;
 Thu, 4 Jul 2019 10:41:10 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp05[null]) by mapi (Zmail) with MAPI id mid14;
 Thu, 4 Jul 2019 10:41:05 +0800 (CST)
Date: Thu, 4 Jul 2019 10:41:05 +0800 (CST)
X-Zmail-TransId: 2b075d1d6741b12e49b6
X-Mailer: Zmail v1.0
Message-ID: <201907041041053843118@zte.com.cn>
In-Reply-To: <904b9362-cd01-ffc9-600b-0c48848617a0@web.de>
References: 1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn,
 904b9362-cd01-ffc9-600b-0c48848617a0@web.de
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn x642fAfx064205
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jul 2019 04:42:07 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jul 2019 04:42:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: [Cocci] =?utf-8?b?562U5aSNOiBSZTogW1BBVENIIHYyXSBjb2NjaW5lbGxl?=
	=?utf-8?q?=3A_semantic_code_search_for_missingof=5Fnode=5Fput?=
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

PiA+IFRoZSBjb3VudGVyIG11c3QgYmUgZGVjcmVtZW50ZWQgYWZ0ZXIgdGhlIGxhc3QgdXNhZ2Ug
b2YgYSBkZXZpY2Ugbm9kZS4KPiAKPiBUaGFua3MgZm9yIHlvdXIgbmV4dCB0cnkgdG8gaW1wcm92
ZSB0aGUgc29mdHdhcmUgc2l0dWF0aW9uCj4gYWxzbyBpbiB0aGlzIGFyZWEuCj4gCj4gCj4gPiBX
ZSBmaW5kIHRoZXNlIGZ1bmN0aW9ucyBieSB1c2luZyB0aGUgZm9sbG93aW5nIFNtUEw6Cj4gCj4g
V291bGQgaXQgYmUgbmljZXIgdG8gdXNlIHRoZSB3b3JkIOKAnHNjcmlwdOKAnSBhbHNvIGhlcmU/
Cj4gCk9LLCB3ZSB3aWxsIHJlcGxhY2UgIlNtUEwiIHdpdGggInNjcmlsdCIgbGF0ZXIuCgo+IAo+
ID4gPFNtUEw+Cj4gPiBAaW5pdGlhbGl6ZTpvY2FtbEAKPiA+IEBACj4gCj4gSG93IGRvIHlvdSB0
aGluayBhYm91dCB0byBkZXNjcmliZSB0aGUgY2hvc2VuIGFsZ29yaXRobQo+IGluIGEgd2F5IGZv
ciBjb250cmlidXRvcnMgd2hvIG1pZ2h0IG5vdCBiZSBzbyBmYW1pbGlhciB3aXRoCj4gdGhpcyBw
cm9ncmFtbWluZyBsYW5ndWFnZT8KPiAKPiBXaWxsIGFueSBpbmZvcm1hdGlvbiBmcm9tIHByZXZp
b3VzIGRpc2N1c3Npb25zIGJlY29tZSByZWxldmFudAo+IGZvciBhIGJldHRlciBjb21taXQgZGVz
Y3JpcHRpb24/Cj4gCgpXZSB3aWxsIGFsc28gcHJvdmlkZSBhbiBleGFtcGxlIHdyaXR0ZW4gaW4g
UHl0aG9uIGxhdGVyLgo+IAo+ID4gbGV0IHJlbGV2YW50X3N0ciA9ICJ1c2Ugb2Zfbm9kZV9wdXQo
KSBvbiBpdCB3aGVuIGRvbmUiCj4gCj4gV2lsbCBzdWNoIGEgbGl0ZXJhbCBuZWVkIGZ1cnRoZXIg
ZGV2ZWxvcG1lbnQgYW5kIHNvZnR3YXJlIGRvY3VtZW50YXRpb24gY29uc2lkZXJhdGlvbnM/Cj4g
Cj4gCj4gPiBsZXQgY29udGFpbnMgczEgczIgPQo+ID4gICAgIGxldCByZSA9IFN0ci5yZWdleHBf
c3RyaW5nIHMyCj4gPiAgICAgaW4KPiA+ICAgICAgICAgdHJ5IGlnbm9yZSAoU3RyLnNlYXJjaF9m
b3J3YXJkIHJlIHMxIDApOyB0cnVlCj4gPiAgICAgICAgIHdpdGggTm90X2ZvdW5kIC0+IGZhbHNl
Cj4gPgo+ID4gbGV0IHJlbGV2YW50X2Z1bmN0aW9ucyA9IHJlZiBbXQo+ID4KPiA+IGxldCBhZGRf
ZnVuY3Rpb24gZiBjID0KPiA+ICAgICBpZiBub3QgKExpc3QubWVtIGYgIXJlbGV2YW50X2Z1bmN0
aW9ucykKPiA+ICAgICB0aGVuCj4gPiAgICAgICBiZWdpbgo+ID4gICAgICAgICBsZXQgcyA9IFN0
cmluZy5jb25jYXQgIiAiCj4gCj4gSSBmaW5kIHN1Y2ggYSBjb25jYXRlbmF0aW9uIHN1c3BpY2lv
dXMgYWZ0ZXIgdGhlIHNwYWNlIGNoYXJhY3Rlcgo+IGlzIHVzZWQgYWxzbyBmb3IgYSBzdHJpbmcg
c3BsaXR0aW5nIGJlZm9yZS4KPiBDYW4gdGhpcyBkZWxpbWl0ZXIgYmUgb21pdHRlZCBmb3IgdGhl
IGNvbWJpbmF0aW9uPwo+IAoKV2UgZmlyc3QgZGl2aWRlIHRoZSBjb21tZW50IGJ5IHdvcmQsIHRo
ZW4gdXNlIHNwYWNlcyB0byBjb25jYXRlbmF0ZQp0aGVtIGludG8gYSBzdHJpbmcsIGFuZCBmaW5h
bGx5IGZpbmQgdGhlIHN1YnN0cmluZyAodXNlIG9mX25vZGVfcHV0KCkgb24gaXQgd2hlbiBkb25l
KQppbiB0aGlzIHN0cmluZy4KPiAKPiA+ICAgICAgICAgICAoCj4gPiAgICAgICAgICAgICAoTGlz
dC5tYXAgU3RyaW5nLmxvd2VyY2FzZV9hc2NpaQo+ID4gICAgICAgICAgICAgICAoTGlzdC5maWx0
ZXIKPiA+ICAgICAgICAgICAgICAgICAoZnVuY3Rpb24geCAtPgo+ID4gICAgICAgICAgICAgICAg
ICAgU3RyLnN0cmluZ19tYXRjaAo+ID4gICAgICAgICAgICAgICAgICAgKFN0ci5yZWdleHAgIlth
LXpBLVpfXFwoXFwpXVstYS16QS1aMC05X1xcKFxcKV0qJCIpCj4gPiAgICAgICAgICAgICAgICAg
eCAwKSAoU3RyLnNwbGl0IChTdHIucmVnZXhwICJbIC47XHRcbl0rIikgYykpKSkgaW4KPiA+ICAg
ICAgICAgICAgICBpZiBjb250YWlucyBzIHJlbGV2YW50X3N0cgo+IAo+IEkgd291bGQgcHJlZmVy
IHRvIHVzZSB0aGUgc3RyaW5nIGNvbnN0YW50IGluIHRoZSBjYWxsZWQgZnVuY3Rpb24gZGlyZWN0
bHkKPiBpbnN0ZWFkIG9mIHBhc3NpbmcgaXQgYXMgYW5vdGhlciBwYXJhbWV0ZXIuCgpUaGFua3Mu
IEhlcmUgdGhlIHJlbGV2YW50X3N0ciBpcyBhIHN0cmluZyBjb25zdGFudC4KCj4gPiAgICAgICAg
ICAgICAgdGhlbgo+ID4gICAgICAgICAgICAgICAgUHJpbnRmLnByaW50ZiAiRm91bmQgcmVsZXZh
bnQgZnVuY3Rpb246ICVzXG4iIGY7Cj4gPiAgICAgICAgICAgICAgICByZWxldmFudF9mdW5jdGlv
bnMgOj0gZiA6OiAhcmVsZXZhbnRfZnVuY3Rpb25zOwo+ID4gICAgICAgZW5kCj4gCj4gSSBmaW5k
IHlvdXIgY2hvaWNlIGZvciBhbiBvdXRwdXQgZm9ybWF0IHVuY2xlYXIgYXQgdGhlIG1vbWVudC4K
PiBJIGltYWdpbmUgdGhhdCB0aGUgY29ycmVzcG9uZGluZyBkYXRhIHByb2Nlc3Npbmcgb2YgdGhl
c2UgZnVuY3Rpb24gbmFtZXMKPiB3aWxsIG5lZWQgZmluZS10dW5pbmcuCj4gSSBhbSBtaXNzaW5n
IHRoZSBzb2Z0d2FyZSBjb21wb25lbnQgZm9yIHRoZSBjb252ZXJzaW9uIG9mIHRoaXMKPiBpZGVu
dGlmaWVyIGxpc3QgaW50byBhIGRpc2p1bmN0aW9uIGZvciB0aGUgU21QTCBydWxlIOKAnHIx4oCd
LgoKVGhhbmtzLgpXZSBmaXJzdCB1c2UgdGhpcyBzY3JpcHQgdG8gZmluZCBvdXQgYWxsIHRoZSBm
dW5jdGlvbiBuYW1lcyB0byBiZSBwcm9jZXNzZWQsCmFuZCB0aGVuIGNvcHkgdGhlc2UgZnVuY3Rp
b24gbmFtZXMgaW50byByMS4KCj4gPiBBbmQgdGhpcyBwYXRjaCBhbHNvIGxvb2tzIGZvciBwbGFj
ZXMgd2hlcmUgYW4gb2Zfbm9kZV9wdXQoKQo+IAo+IERvZXMgYSBwYXRjaCBvciBhIHNjcmlwdCBw
ZXJmb3JtIGFuIGFjdGlvbj8KPiAKT0ssIFRoYW5rcy4KV2UnbGwgZml4IGl0IHNvb24uCgo+ID4g
Y2FsbCBpcyBvbiBzb21lIHBhdGhzIGJ1dCBub3Qgb24gb3RoZXJzLgo+IAo+IExldCB1cyBsb29r
IGF0IG1lbnRpb25lZCBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzLgo+IAo+IAo+ID4gK0Bpbml0aWFs
aXplOnB5dGhvbkAKPiA+ICtAQAo+ID4gKwo+ID4gK3NlZW4gPSBzZXQoKQo+ID4gKwo+ID4gK2Rl
ZiBhZGRfaWZfbm90X3ByZXNlbnQgKHAxLCBwMik6Cj4gCj4gSXQgc2VlbXMgdGhhdCB5b3Ugd291
bGQgbGlrZSB0byB1c2UgaXRlcmF0aW9uIGZ1bmN0aW9uYWxpdHkuCj4gaHR0cHM6Ly9naXRodWIu
Y29tL2NvY2NpbmVsbGUvY29jY2luZWxsZS9ibG9iLzk5ZTA4MWU5Yjg5ZDQ5MzAxYjdiZDJjNWU1
YWFjODhjNjZlYWFhNmEvZG9jcy9tYW51YWwvY29jY2lfc3ludGF4LnRleCNMMTgyNgo+IAo+IEhv
dyB3aWxsIGl0IG1hdHRlciBoZXJlPwo+IAo+IAo+ID4gK2RlZiBkaXNwbGF5X3JlcG9ydChwMSwg
cDIpOgo+ID4gKyAgICBpZiBhZGRfaWZfbm90X3ByZXNlbnQocDFbMF0ubGluZSwgcDJbMF0ubGlu
ZSk6Cj4gPiArICAgICAgIGNvY2NpbGliLnJlcG9ydC5wcmludF9yZXBvcnQocDJbMF0sCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkVSUk9SOiBtaXNzaW5nIG9mX25v
ZGVfcHV0OyBhY3F1aXJlZCBhIG5vZGUgcG9pbnRlciB3aXRoIHJlZmNvdW50IGluY3JlbWVudGVk
IG9uIGxpbmUgIgo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICsgcDFb
MF0ubGluZQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICsgIiwgYnV0
IHdpdGhvdXQgYSBjb3JyZXNwb25kaW5nIG9iamVjdCByZWxlYXNlIHdpdGhpbiB0aGlzIGZ1bmN0
aW9uLiIpCj4gPiArCj4gPiArZGVmIGRpc3BsYXlfb3JnKHAxLCBwMik6Cj4gPiArICAgIGNvY2Np
LnByaW50X21haW4oImFjcXVpcmVkIGEgbm9kZSBwb2ludGVyIHdpdGggcmVmY291bnQgaW5jcmVt
ZW50ZWQiLCBwMSkKPiA+ICsgICAgY29jY2kucHJpbnRfc2VjcygibmVlZGVkIG9mX25vZGVfcHV0
IiwgcDIpCj4gCj4gQ2FuIGl0IGJlIGhlbHBmdWwgdG8gc3BlY2lmeSBTbVBMIGRlcGVuZGVuY2ll
cyBmb3IgdGhlc2UgZnVuY3Rpb25zCj4gYWNjb3JkaW5nIHRvIHRoZSBhcHBsaWVkIG9wZXJhdGlv
biBtb2RlPwo+IAo+IAo+ID4gK3ggPSBAcDFcKG9mX2ZpbmRfYWxsX25vZGVzXHwKPiAKPiBJIHdv
dWxkIGZpbmQgdGhpcyBTbVBMIGRpc2p1bmN0aW9uIGVhc2llciB0byByZWFkIHdpdGhvdXQgdGhl
IHVzYWdlCj4gb2YgZXh0cmEgYmFja3NsYXNoZXMuCj4gCj4gK3ggPQo+ICsob2Zf4oCmCj4gK3xv
Zl/igKYKPiArKUBwMSguLi4pOwo+IAo+IAo+IFdoaWNoIHNvcnQgY3JpdGVyaWEgd2VyZSBhcHBs
aWVkIGZvciB0aGUgZ2VuZXJhdGlvbiBvZiB0aGUgc2hvd24KPiBmdW5jdGlvbiBuYW1lIGxpc3Q/
CgpBcyBqdWxpYSBwb2ludGVkIG91dCwgeW91ciBjdXJyZW50IHdyaXRpbmcgaXMgbm90IGNvbXBp
bGVkLgoKPiA+ICtpZiAoeCA9PSBOVUxMIHx8IC4uLikgUwo+ID4gKy4uLiB3aGVuICE9IGUgPSAo
VCl4Cj4gPiArICAgIHdoZW4gIT0gdHJ1ZSB4ID09IE5VTEwKPiAKPiBJIHdvbmRlciBpZiB0aGlz
IGNvZGUgZXhjbHVzaW9uIHNwZWNpZmljYXRpb24gaXMgcmVhbGx5IHJlcXVpcmVkCj4gYWZ0ZXIg
YSBudWxsIHBvaW50ZXIgd2FzIGNoZWNrZWQgYmVmb3JlLgoKVGhhbmtzLgpPdXIgcHJldmlvdXMg
dmVyc2lvbiB1c2VkIHRoZSAid2hlbiBhbnkiIGNsYXVzZSwgc28gd2UgbmVlZAoid2hlbiAhPSB0
cnVlIHggPT0gTlVMTCIuIFdlIGNhbiBkZWxldGUgdGhpcyBjb2RlIGV4Y2x1c2lvbgpzcGVjaWZp
Y2F0aW9uICBmb3IgdGhpcyB2ZXJzaW9uLiAKV2Ugd2lsbCBmaXggaXQgbGF0ZXIuCgo+ID4gK3wK
PiA+ICtyZXR1cm4geDsKPiA+ICt8Cj4gPiArcmV0dXJuIG9mX2Z3bm9kZV9oYW5kbGUoeCk7Cj4g
Cj4gQ2FuIGEgbmVzdGVkIFNtUEwgZGlzanVuY3Rpb24gYmUgaGVscGZ1bCBhdCBzdWNoIHBsYWNl
cz8KPiAKPiArfHJldHVybgo+ICsoeAo+ICt8b2ZfZndub2RlX2hhbmRsZSh4KQo+ICspOwoKV2Ug
YXJlIG1vcmUgaW4gYWdyZWVtZW50IHdpdGgganVsaWEncyBjb21tZW50czoKVGhlIG9yaWdpbmFs
IGNvZGUgaXMgbXVjaCBtb3JlIHJlYWRhYmxlLiAgVGhlIGludGVybmFsIHJlcHJlc2VudGF0aW9u
IHdpbGwgYmUgdGhlIHNhbWUuCgo+ID4gKyAgICB3aGVuICE9IHY0bDJfYXN5bmNfbm90aWZpZXJf
YWRkX2Z3bm9kZV9zdWJkZXYoPC4uLnguLi4+KQo+IAo+IFdvdWxkIHRoZSBzcGVjaWZpY2F0aW9u
IHZhcmlhbnQg4oCcPCsuLi4geCAuLi4rPuKAnSBiZSByZWxldmFudAo+IGZvciB0aGUgcGFyYW1l
dGVyIHNlbGVjdGlvbj8KClRoYW5rcy4gCldlIHVzZSA8Li4uIHggLi4uPiBpbnN0ZWFkIG9mIDwr
Li4uIHggLi4uKz4gaGVyZSB0byBlbGltaW5hdGUgdGhlIGZvbGxvd2luZyBmYWxzZSBwb3NpdGl2
ZXM6CgouL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcWNvbS9jYW1zcy9jYW1zcy5jOjUwNDoxLTc6
IEVSUk9SOiBtaXNzaW5nIG9mX25vZGVfcHV0OyBhY3F1aXJlZCBhIG5vZGUgcG9pbnRlciB3aXRo
IHJlZmNvdW50IGluY3JlbWVudGVkIG9uIGxpbmUgNDc5LCBidXQgd2l0aG91dCBhIGNvcnJlc3Bv
bmRpbmcgb2JqZWN0IHJlbGVhc2Ugd2l0aGluIHRoaXMgZnVuY3Rpb24uCgo0NjUgc3RhdGljIGlu
dCBjYW1zc19vZl9wYXJzZV9wb3J0cyhzdHJ1Y3QgY2Ftc3MgKmNhbXNzKQo0NjYgewouLi4KNDc5
ICAgICAgICAgICAgICAgICByZW1vdGUgPSBvZl9ncmFwaF9nZXRfcmVtb3RlX3BvcnRfcGFyZW50
KG5vZGUpOwouLi4KNDg2ICAgICAgICAgICAgICAgICBhc2QgPSB2NGwyX2FzeW5jX25vdGlmaWVy
X2FkZF9md25vZGVfc3ViZGV2KAo0ODcgICAgICAgICAgICAgICAgICAgICAgICAgJmNhbXNzLT5u
b3RpZmllciwgb2ZfZndub2RlX2hhbmRsZShyZW1vdGUpLCAgICAgICAgICAgICAgLS0tPiB2NGwy
X2FzeW5jX25vdGlmaWVyX2FkZF9md25vZGVfc3ViZGV2IHdpbGwgcGFzcyByZW1vdGUgdG8gY2Ft
c3MtPm5vdGlmaWVyLgo0ODggICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKCpjc2QpKTsK
Li4uCjUwNCAgICAgICAgIHJldHVybiBudW1fc3ViZGV2czsKCi0tClJlZ2FyZHMsCldlbg==


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

