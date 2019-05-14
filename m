Return-Path: <SRS0=Nzf/=TO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F51C04AB4
	for <cocci@archiver.kernel.org>; Tue, 14 May 2019 09:19:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9E920843
	for <cocci@archiver.kernel.org>; Tue, 14 May 2019 09:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9E920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x4E9JCFG021399
          ; Tue, 14 May 2019 11:19:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C9A2B7748;
	Tue, 14 May 2019 11:19:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AD3657743
 for <cocci@systeme.lip6.fr>; Tue, 14 May 2019 11:19:10 +0200 (CEST)
Received: from mxct.zte.com.cn (out1.zte.com.cn [202.103.147.172])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x4E9J6mO010148
 for <cocci@systeme.lip6.fr>; Tue, 14 May 2019 11:19:09 +0200 (CEST)
X-pt: isis.lip6.fr
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id 965892EACBBEFB849BE0;
 Tue, 14 May 2019 17:19:05 +0800 (CST)
Received: from kjyxapp03.zte.com.cn ([10.30.12.202])
 by mse-fl2.zte.com.cn with SMTP id x4E9Iw6A012633;
 Tue, 14 May 2019 17:18:58 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp06[null]) by mapi (Zmail) with MAPI id mid14;
 Tue, 14 May 2019 17:18:58 +0800 (CST)
Date: Tue, 14 May 2019 17:18:58 +0800 (CST)
X-Zmail-TransId: 2b085cda88028a014b98
X-Mailer: Zmail v1.0
Message-ID: <201905141718583344787@zte.com.cn>
In-Reply-To: <b13fa7ea-5721-0c67-d7d6-9e245c0ea007@web.de>
References: 1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn,
 b13fa7ea-5721-0c67-d7d6-9e245c0ea007@web.de
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn x4E9Iw6A012633
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 14 May 2019 11:19:13 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 14 May 2019 11:19:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?=5B4/5=5D_Coccinelle=3A_put=5Fdevice=3A_Extend_?=
	=?utf-8?q?when_constraints_for_twoSmPL_ellipses?=
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

PiBTdWJqZWN0OiBSZTogWzQvNV0gQ29jY2luZWxsZTogcHV0X2RldmljZTogRXh0ZW5kIHdoZW4g
Y29uc3RyYWludHMgZm9yIHR3b1NtUEwgZWxsaXBzZXMKPiA+PiBDYW4geW91IGFncmVlIHRvIGFu
eSBpbmZvcm1hdGlvbiB3aGljaCBJIHByZXNlbnRlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2U/Cj4g
Cj4gRG8geW91IGZpbmQgdGhpcyBkZXNjcmlwdGlvbiBpbmFwcHJvcHJpYXRlPwo+IAo+IAo+ID4+
PiBZb3UgZG9uJ3QgbmVlZCBzbyBtYW55IHR5cGUgbWV0YXZhcmlhYmxlcy4KPiA+Pgo+ID4+IEl0
IHNlZW1zIHRoYXQgdGhlIENvY2NpbmVsbGUgc29mdHdhcmUgY2FuIGNvcGUgYWxzbyB3aXRoIG15
IFNtUEwgY29kZSBhZGRpdGlvbi4KPiA+PiBZb3UgbWlnaHQgZmVlbCB1bmNvbWZvcnRhYmxlIHdp
dGggdGhlIHN1Z2dlc3RlZCBjaGFuZ2VzIGZvciBhIHdoaWxlLgo+ID4KPiA+IEl0J3MgdWdseS4g
IE11Y2ggbW9yZSB1Z2x5IHRoYW4gbXNnID0KPiAKPiBUaGUgY2xhcmlmaWNhdGlvbiBvZiB0aGlz
IGNoYW5nZSByZWx1Y3RhbmNlIG1pZ2h0IGJlY29tZSBtb3JlIGludGVyZXN0aW5nLgo+IEkgZ290
IGNvbnZpbmNlZCB0aGF0IHRoZXJlIGlzIGEgbmVlZCBmb3IgZnVydGhlciBzb2Z0d2FyZSB1cGRh
dGVzLgo+IAo+IAo+ID4+ICogQ2FuIGl0IGJlY29tZSByZXF1aXJlZCB0byBpZGVudGlmeSBpbnZv
bHZlZCBzb3VyY2UgY29kZSBwbGFjZWhvbGRlcnMKPiA+PiAgIGJ5IGV4dHJhIG1ldGF2YXJpYWJs
ZXM/Cj4gPgo+ID4gSSBkb24ndCB1bmRlcnN0YW5kIHRoZSBxdWVzdGlvbi4KPiAKPiBXZW4gWWFu
ZyB3YXMgcGxhbm5pbmcgYSBjb3JyZXNwb25kaW5nIG1vZGlmaWNhdGlvbiBzaW5jZSAyMDE5LTAy
LTE5Lgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2NvY2NpLzIwMTkwMjE5MTAxNDE1NjY4MDI5
OUB6dGUuY29tLmNuLwo+IGh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL3BpcGVybWFpbC9jb2NjaS8y
MDE5LUZlYnJ1YXJ5LzAwNTYyMC5odG1sCj4gCkhpIE1hcmt1cywKSSBkaWQgYW5vdGhlciBleHBl
cmltZW50IGF0IHRoYXQgdGltZSBhbmQgZm91bmQgdGhhdCB0aGlzIG1vZGlmaWNhdGlvbiB3aWxs
CnJlZHVjZSB0aGUgZmFsc2UgcG9zaXRpdmUgcmF0ZSwgYnV0IGl0IG1heSBhbHNvIHJlZHVjZSB0
aGUgcmVjYWxsIHJhdGUuCgpDb3VsZCB3ZSB1c2UgaXQgdG8gZmluZCBvdXQgYXMgbWFueSBidWdz
IGFzIHBvc3NpYmxlIGluIHRoZSBjdXJyZW50IGtlcm5lbAphbmQgdGhlbiBtb2RpZnkgaXQ/Cgpo
dHRwczovL3N5c3RlbWUubGlwNi5mci9waXBlcm1haWwvY29jY2kvMjAxOS1GZWJydWFyeS8wMDU2
MjYuaHRtbAoKVGhhbmtzLgoKLS0KUmVnYXJkcywKV2VuCgo+IAo+IEkgZ290IGludG8gdGhlIGRl
dmVsb3BtZW50IG1vb2QgdG8gY29udHJpYnV0ZSBhbm90aGVyIGNvbmNyZXRlIHVwZGF0ZSBzdWdn
ZXN0aW9uCj4gZm9yIGFuIG9wZW4gaXNzdWUgaW4gYWZmZWN0ZWQgc2NyaXB0cyBmb3IgdGhlIHNl
bWFudGljIHBhdGNoIGxhbmd1YWdlLgo+IERvIHlvdSByZWNvZ25pc2UgdGhlIG5lZWQgZm9yIHRo
ZSBleHRlbnNpb24gb2YgZXhjbHVzaW9uIHNwZWNpZmljYXRpb25zIGhlcmU/Cj4=


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

