Return-Path: <SRS0=Tsgg=UD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5983AC282CE
	for <cocci@archiver.kernel.org>; Tue,  4 Jun 2019 05:50:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607C524E86
	for <cocci@archiver.kernel.org>; Tue,  4 Jun 2019 05:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607C524E86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x545oET4003527;
	Tue, 4 Jun 2019 07:50:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C871F7760;
	Tue,  4 Jun 2019 07:50:14 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D12FB7759
 for <cocci@systeme.lip6.fr>; Tue,  4 Jun 2019 07:50:13 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x545oACt029323
 for <cocci@systeme.lip6.fr>; Tue, 4 Jun 2019 07:50:12 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id B26A91CB19BEF45E791F;
 Tue,  4 Jun 2019 13:50:07 +0800 (CST)
Received: from kjyxapp02.zte.com.cn ([10.30.12.201])
 by mse-fl2.zte.com.cn with SMTP id x545o0mQ099993;
 Tue, 4 Jun 2019 13:50:00 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp02[null]) by mapi (Zmail) with MAPI id mid14;
 Tue, 4 Jun 2019 13:50:00 +0800 (CST)
Date: Tue, 4 Jun 2019 13:50:00 +0800 (CST)
X-Zmail-TransId: 2b045cf60688281e7dac
X-Mailer: Zmail v1.0
Message-ID: <201906041350002807147@zte.com.cn>
In-Reply-To: <fa3b24ba-1c57-3115-6a01-ee98fd702087@web.de>
References: 201905171432571474636@zte.com.cn,
 fa3b24ba-1c57-3115-6a01-ee98fd702087@web.de
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <Markus.Elfring@web.de>
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn x545o0mQ099993
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Jun 2019 07:50:16 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Jun 2019 07:50:12 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: michal.lkml@markovi.net, nicolas.palix@imag.fr, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci]
	=?utf-8?q?Coccinelle=3A_semantic_patch_for_missing_of=5Fn?=
	=?utf-8?q?ode=5Fput?=
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

PiA+IDIsIEEgZ2VuZXJhbCBtZXRob2QuCj4gPiBXZSBhbHNvIHRyeSB0byBnZXQgdGhlIGxpc3Qg
b2YgZnVuY3Rpb25zIHRvIGNvbnNpZGVyIGJ5IHdyaXRpbmcgYSBTbVBMLAo+ID4gYnV0IHRoaXMg
bWV0aG9kIGlzIG5vdCBmZWFzaWJsZSBhdCBwcmVzZW50LCBiZWNhdXNlIGl0IGlzIG5vdCBlYXN5
IHRvIHBhcnNlIHRoZSBjb21tZW50Cj4gPiBoZWFkZXIgaW5mb3JtYXRpb24gb2YgdGhlc2UgZnVu
Y3Rpb25zLgo+IAo+IFRoZSBzaXR1YXRpb24gd2FzIGltcHJvdmVkIG9uY2UgbW9yZSBhbHNvIGZv
ciB0aGUgQ29jY2luZWxsZSBzb2Z0d2FyZS4KPiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIGRl
dmVsb3AgYW55IG1vcmUgdmFyaWFudHMgYmFzZWQgb24gaW5mb3JtYXRpb24KPiBmcm9tIGEgc2Ny
aXB0IChsaWtlIHRoZSBmb2xsb3dpbmcpIGZvciB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2U/
Cj4gCj4gQGluaXRpYWxpemU6cHl0aG9uQAo+IEBACj4gaW1wb3J0IHJlLCBzeXMKPiBmaWx0ZXIg
PSByZS5jb21waWxlKCIgd2hlbiBkb25lIikKPiAKPiBAZmluZEAKPiBjb21tZW50cyBjOwo+IGlk
ZW50aWZpZXIgeDsKPiB0eXBlIHQ7Cj4gQEAKPiB0QGMgeCguLi4pCj4geyAuLi4gfQo+IAo+IEBz
Y3JpcHQ6cHl0aG9uIHNlbGVjdGlvbkAKPiBpbnB1dCA8PCBmaW5kLmM7Cj4gQEAKPiBpZiBmaWx0
ZXIuc2VhcmNoKGlucHV0WzBdLmJlZm9yZSwgMik6Cj4gc3lzLnN0ZGVyci53cml0ZShpbnB1dFsw
XS5iZWZvcmUgKyAiXG49PT09PVxuIikKPiBlbHNlOgo+IGNvY2NpLmluY2x1ZGVfbWF0Y2goRmFs
c2UpCj4gCj4gQGRpc3BsYXlACj4gaWRlbnRpZmllciBmaW5kLng7Cj4gdHlwZSBmaW5kLnQ7Cj4g
QEAKPiAqdCB4KC4uLikKPiB7IC4uLiB9Cj4gCj4gCj4gRG9lcyBzdWNoIGEgc291cmNlIGNvZGUg
YW5hbHlzaXMgYXBwcm9hY2ggaW5kaWNhdGUgYW55IGRldGFpbHMKPiB3aGljaCBzaG91bGQgYmUg
aW1wcm92ZWQgZm9yIHRoZSBhZmZlY3RlZCBzb2Z0d2FyZSBkb2N1bWVudGF0aW9uPwpUaGFuayB5
b3UgZm9yIHlvdXIgZXhhbXBsZS4KV2UgY3VycmVudGx5IHVzZSB0aGUgZm9sbG93aW5nIE9jYW1s
IHNjcmlwdCB0byBhdXRvbWF0aWNhbGx5CmNvbGxlY3QgZnVuY3Rpb25zIHRoYXQgbmVlZCB0byBi
ZSBjb25zaWRlcmVkLgoKQGluaXRpYWxpemU6b2NhbWxACkBACgpsZXQgcmVsZXZhbnRfc3RyID0g
InVzZSBvZl9ub2RlX3B1dCgpIG9uIGl0IHdoZW4gZG9uZSIKCmxldCBjb250YWlucyBzMSBzMiA9
CiAgICBsZXQgcmUgPSBTdHIucmVnZXhwX3N0cmluZyBzMgogICAgaW4KICAgICAgICB0cnkgaWdu
b3JlIChTdHIuc2VhcmNoX2ZvcndhcmQgcmUgczEgMCk7IHRydWUKICAgICAgICB3aXRoIE5vdF9m
b3VuZCAtPiBmYWxzZQoKbGV0IHJlbGV2YW50X2Z1bmN0aW9ucyA9IHJlZiBbXQoKbGV0IGFkZF9m
dW5jdGlvbiBmIGMgPSAKICAgIGlmIG5vdCAoTGlzdC5tZW0gZiAhcmVsZXZhbnRfZnVuY3Rpb25z
KQogICAgdGhlbiAKICAgICAgYmVnaW4KICAgICAgICBsZXQgcyA9IFN0cmluZy5jb25jYXQgIiAi
CiAgICAgICAgICAoCiAgICAgICAgICAgIChMaXN0Lm1hcCBTdHJpbmcubG93ZXJjYXNlX2FzY2lp
CgkgICAgIChMaXN0LmZpbHRlcgoJICAgICAgIChmdW5jdGlvbiB4IC0+CgkgICAgICAgICBTdHIu
c3RyaW5nX21hdGNoCgkgICAgICAgICAoU3RyLnJlZ2V4cCAiW2EtekEtWl9cXChcXCldWy1hLXpB
LVowLTlfXFwoXFwpXSokIikKCSAgICAgICB4IDApIChTdHIuc3BsaXQgKFN0ci5yZWdleHAgIlsg
LjtcdFxuXSsiKSBjKSkpKSBpbgogICAgICAgICAgICAgUHJpbnRmLnByaW50ZiAiY29tbWVudHM6
ICVzXG4iIHM7CiAgICAgICAgICAgICBpZiBjb250YWlucyBzIHJlbGV2YW50X3N0cgogICAgICAg
ICAgICAgdGhlbiAKICAgICAgICAgICAgICAgUHJpbnRmLnByaW50ZiAiRm91bmQgcmVsZXZhbnQg
ZnVuY3Rpb246ICVzXG4iIGY7CiAgICAgICAgICAgICAgIHJlbGV2YW50X2Z1bmN0aW9ucyA6PSBm
IDo6ICFyZWxldmFudF9mdW5jdGlvbnM7CiAgICAgIGVuZAoKQHJACmlkZW50aWZpZXIgZm47CmNv
bW1lbnRzIGM7CnR5cGUgVCA9IHN0cnVjdCBkZXZpY2Vfbm9kZSAqOwpAQAoKVEBjIGZuKC4uLikg
ewouLi4KfQoKQHNjcmlwdDpvY2FtbEAKZiA8PCByLmZuOwpjIDw8IHIuYzsKQEAKCmxldCAoY2Is
Y20sY2EpID0gTGlzdC5oZCBjIGluCmxldCBjID0gU3RyaW5nLmNvbmNhdCAiICIgY2IgaW4KYWRk
X2Z1bmN0aW9uIGYgYwoKLS0KUmVnYXJkcywKV2Vu


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

