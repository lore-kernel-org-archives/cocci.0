Return-Path: <SRS0=bkjO=YR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F6CCA9EAF
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2019 08:02:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A841420684
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2019 08:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A841420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9O82QDP027238;
	Thu, 24 Oct 2019 10:02:26 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 72BD977BB;
	Thu, 24 Oct 2019 10:02:26 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4C91877B9
 for <cocci@systeme.lip6.fr>; Thu, 24 Oct 2019 10:02:25 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9O82Mjv010509
 for <cocci@systeme.lip6.fr>; Thu, 24 Oct 2019 10:02:23 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id 071F76CF13F3753A2844;
 Thu, 24 Oct 2019 16:02:22 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
 by mse-fl2.zte.com.cn with SMTP id x9O827Gk019207;
 Thu, 24 Oct 2019 16:02:07 +0800 (GMT-8)
 (envelope-from zhong.shiqi@zte.com.cn)
Received: from mapi (xaxapp01[null]) by mapi (Zmail) with MAPI id mid32;
 Thu, 24 Oct 2019 16:02:06 +0800 (CST)
Date: Thu, 24 Oct 2019 16:02:06 +0800 (CST)
X-Zmail-TransId: 2af95db15a7ef3bcc893
X-Mailer: Zmail v1.0
Message-ID: <201910241602064396894@zte.com.cn>
In-Reply-To: <alpine.DEB.2.21.1910240816040.2771@hadrien>
References: 1571897060-32374-1-git-send-email-zhong.shiqi@zte.com.cn,
 alpine.DEB.2.21.1910240816040.2771@hadrien
Mime-Version: 1.0
From: <zhong.shiqi@zte.com.cn>
To: <julia.lawall@lip6.fr>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn x9O827Gk019207
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Oct 2019 10:02:26 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 24 Oct 2019 10:02:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        cheng.shengyu@zte.com.cn, cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?=5BPATCH_v2=5D_coccicheck=3Asupport_=24COCCI_be?=
	=?utf-8?q?ing_defined_as_adirectory?=
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

PiBPbiBUaHUsIDI0IE9jdCAyMDE5LCB6aG9uZ3NoaXFpIHdyb3RlOgo+Cj4gPiBQdXQgYSBtb2Rp
ZmljYXRpb24gaW4gc2NyaXB0cy9jb2NjaWNoZWNrIHdoaWNoIHN1cHBvcnRzIHVzZXJzIGluCj4g
PiBjb25maWd1cmluZyBDT0NDSSBwYXJhbWV0ZXIgYXMgYSBkaXJlY3RvcnkgdG8gdHJhdmVyc2Ug
ZmlsZXMgaW4KPiA+IGRpcmVjdG9yeSB3aG9zZSBuZXh0IGxldmVsIGRpcmVjdG9yeSBjb250YWlu
cyBydWxlIGZpbGVzIHdpdGggU3VmZml4IG9mCj4gPiBjb2NjaS4KPgo+IFdoaWxlIEkgdGhvdWdo
dCB0aGUgb3JpZ2luYWwgd2FzIGZpbmUsIGlmIHdlIGFyZSBnb2luZyB0byBzdHJpdmUgZm9yCj4g
cGVyZmVjdGlvbiwgdGhlcmUgYXJlIHNvbWUgdGhpbmdzIHRoYXQgY291bGQgYmUgY2hhbmdlZC4g
IEZpcnN0IHRoZXJlCj4gc2hvdWxkIGJlIGEgc3BhY2UgaW4gdGhlIHN1YmplY3QgbGluZSBhZnRl
ciB0aGUgOgo+Cj4gU2Vjb25kIHRoZSBjb21taXQgbG9nIGNvdWxkIGJlIG1vcmUgY29uY2lzZSBh
czoKPgo+IEFsbG93IGRlZmluaW5nIENPQ0NJIGFzIGEgZGlyZWN0b3J5IHRoYXQgY29udGFpbnMg
LmNvY2NpIGZpbGVzLgo+Cj4gSW4gZ2VuZXJhbCwgYXQgbGVhc3QgaW4gc2ltcGxlIGNhc2VzLCBp
dCBpcyBub3QgbmVjZXNzYXJ5IHRvIG1lbnRpb24gdGhlCj4gbmFtZSBvZiB0aGUgZmlsZSB5b3Ug
YXJlIG1vZGlmeWluZyBpbiB0aGUgY29taXQgbG9nLCBiZWNhdXNlIG9uZSBjYW4gc2VlCj4gdGhh
dCBqdXN0IGJlbG93IGZyb20gbG9va2luZyBhdCB0aGUgZGlmZnN0YXQgYW5kIHRoZSBwYXRjaC4K
Pgo+IHRoYW5rcywKPiBqdWxpYQo+CgpUaGFuayB5b3UsaXQgaXMgdmVyeSBnb29kIGZvciBtZQoK
QmVzdCBSZWdhcmRzLAp6aG9uZy5zaGlxaQoKPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiB6aG9uZ3No
aXFpIDx6aG9uZy5zaGlxaUB6dGUuY29tLmNuPgo+ID4gLS0tCj4gPiBDaGFuZ2VzIGluIHYyOgo+
ID4gICAgICAgICAxLmZpeCBwYXRjaCBzdWJqZWN0IGFjY29yZGluZyB0byB0aGUgcmVwbHkgYnkg
TWFya3VzCj4gPiAgICAgICAgIDxNYXJrdXMuRWxmcmluZ0B3ZWIuZGU+Cj4gPiAgICAgICAgIDIu
Y2hhbmdlIGRlc2NyaXB0aW9uIGluIOKAnGltcGVyYXRpdmUgbW9vZOKAnQo+ID4KPiA+ICBzY3Jp
cHRzL2NvY2NpY2hlY2sgfCA0ICsrKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL3NjcmlwdHMvY29jY2ljaGVjayBiL3NjcmlwdHMvY29j
Y2ljaGVjawo+ID4gaW5kZXggZTA0ZDMyOC4uYTFjNDE5NyAxMDA3NTUKPiA+IC0tLSBhL3Njcmlw
dHMvY29jY2ljaGVjawo+ID4gKysrIGIvc2NyaXB0cy9jb2NjaWNoZWNrCj4gPiBAQCAtMjU3LDYg
KzI1NywxMCBAQCBpZiBbICIkQ09DQ0kiID0gIiIgXSA7IHRoZW4KPiA+ICAgICAgZm9yIGYgaW4g
YGZpbmQgJHNyY3RyZWUvc2NyaXB0cy9jb2NjaW5lbGxlLyAtbmFtZSAnKi5jb2NjaScgLXR5cGUg
ZiB8IHNvcnRgOyBkbwo+ID4gICAgICBjb2NjaW5lbGxlICRmCj4gPiAgICAgIGRvbmUKPiA+ICtl
bGlmIFsgLWQgIiRDT0NDSSIgXSA7IHRoZW4KPiA+ICsgICAgZm9yIGYgaW4gYGZpbmQgJENPQ0NJ
LyAtbmFtZSAnKi5jb2NjaScgLXR5cGUgZiB8IHNvcnRgOyBkbwo+ID4gKyAgICBjb2NjaW5lbGxl
ICRmCj4gPiArICAgIGRvbmUKPiA+ICBlbHNlCj4gPiAgICAgIGNvY2NpbmVsbGUgJENPQ0NJCj4g
PiAgZmkKPiA+IC0tCj4gPiAyLjkuNQo+ID4KPiA+


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

