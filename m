Return-Path: <SRS0=6akS=O3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A80C43387
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 17:12:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349F421873
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 17:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349F421873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIHCM4C026861
          ; Tue, 18 Dec 2018 18:12:22 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 32015740A;
	Tue, 18 Dec 2018 18:12:22 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 96C8F3A55
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 18:12:20 +0100 (CET)
Received: from mail.sysmocom.de (mail.sysmocom.de
 [IPv6:2a01:4f8:191:444c:0:0:2:4] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIHCJ4P018215
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 18:12:19 +0100 (CET)
X-pt: isis.lip6.fr
Received: from public-mail (mail.sysmocom.de [144.76.43.93])
 by mail.sysmocom.de (Postfix) with ESMTP id BC6084B8D56
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 17:12:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([144.76.43.93])
 by public-mail (mail.sysmocom.de [144.76.43.93]) (amavisd-new, port 10024)
 with ESMTP id daW8jo9q_WJo; Tue, 18 Dec 2018 17:12:19 +0000 (UTC)
Received: from [10.9.1.140] (ds9.sysmocom.de [90.187.64.137])
 by mail.sysmocom.de (Postfix) with ESMTPSA id E124D4B8D44
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 17:12:18 +0000 (UTC)
To: cocci@systeme.lip6.fr
References: <0c0bf80c-56bd-6560-12b8-97a4b1b89963@sysmocom.de>
 <alpine.DEB.2.21.1812130724080.2458@hadrien>
 <346d748c-c073-7567-5547-23ec8a47c9b6@sysmocom.de>
 <alpine.DEB.2.21.1812132057380.2465@hadrien>
 <28194663-42c4-83b6-4a21-545408fd7e12@sysmocom.de>
 <alpine.DEB.2.20.1812181716490.2886@hadrien>
 <372cf517-11cb-3021-fc5b-219b26022493@sysmocom.de>
 <alpine.DEB.2.20.1812181749390.2886@hadrien>
From: Max <msuraev@sysmocom.de>
Message-ID: <f70c399f-4158-0457-9d0a-0300fcbe7ea7@sysmocom.de>
Date: Tue, 18 Dec 2018 18:12:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1812181749390.2886@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 18:12:22 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 18 Dec 2018 18:12:19 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: Re: [Cocci] struct replacement
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

U28sIGlmIEkgZG9uJ3QgaGF2ZSBhbnkgdHlwZWRlZiBpbiB0aGUgY29kZSBhbmQgSSBqdXN0IHdh
bnQgdG8gcmVwbGFjZSAKdGhlIG5hbWUgb2YgdGhlIGZpZWxkIG9mIGEgc3RydWN0PwoKZm9yIGV4
YW1wbGUgdG8gbW9kaWZ5IHRoaXMgZnVuY3Rpb246CgpmKCkgewoKc3RydWN0IG15X3N0cnVjdCAq
bTsKCnN0cnVjdCBteV9zdHJ1Y3QgeDsKCi4uLgoKbS0+bGVuID0gMTA7IC8vIHRoaXMgc2hvdWxk
IGJlY29tZSBtLT5sZW5ndGggPSAxMDsKCi4uLgoKZmlsbCh4LmJ1Zik7IC8vIHRoaXMgc2hvdWxk
IGJlY29tZSBmaWxsKHguYWRkcik7Cgp9CgpJJ20gdHJ5aW5nIHRvIHVzZQoKQEAKaWRlbnRpZmll
ciBhOwpAQApzdHJ1Y3QgbXlfc3RydWN0IGEuCi0gbGVuCisgbGVuZ3RoCgpXaGljaCBnaXZlcyBz
eW50YXggZXJyb3IuIEkgbmVlZCBzb21laG93IHRvIHRlbGwgc3BhdGNoIHRoYXQgImlkZW50aWZp
ZXIgCmEiIGhhcyB0eXBlICJzdHJ1Y3QgbXlfc3RydWN0IiBidXQgInR5cGUgc3RydWN0IG9zbW9f
Z3NuX2FkZHJlc3M7IiBzZWVtcyAKdG8gYmUgaW52YWxpZCBzeW50YXguCgoxOC4xMi4xOCAxNzo1
NCwgSnVsaWEgTGF3YWxsINC/0LjRiNC10YI6Cj4KPiBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCB5
b3UgYXJlIHRyeWluZyB0byBkbyBoZXJlLiAgdHlwZWRlZiBuZXdfYWRkcmVzczsKPiBpcyBmaW5k
IGZvciBpbmRpY2F0aW5nIHRoYXQgbmV3X2FkZHJlc3MgaXMgYSB0eXBlZGVmLiAgSWUgeW91IGhh
dmUKPiBzb21ld2hlcmUgc2FpZDoKPgo+IHR5cGVkZWYgLi4uIG5ld19hZGRyZXNzOwo+Cj4gbmV3
X2FkZHJlc3MgYTsgd2lsbCB0aGVuIG1hdGNoIGEgZGVjbGFyYXRpb24gd2hlcmUgdGhlIHR5cGUg
b2YgdGhlCj4gZGVjbGFyZWQgdmFyaWFibGUgaXMgbmV3X2FkZHJlc3MuICBCdXQgSSBkb24ndCB1
bmRlcnN0YW5kIC0gYS5sZW47Lgo+IEZpcnN0LCB0aGlzIGlzIG9ubHkgZ29pbmcgdG8gbWF0Y2gg
YSBzdGF0ZW1lbnQgdGhhdCBjb21lcyByaWdodCBhZnRlciB0aGUKPiB2YXJpYWJsZSBkZWNsYXJh
dGlvbi4gIFNlY29uZCwgYS5sZW47IGlzIGEgdmVyeSBzdHJhbmdlIHN0YXRlbWVudCwgYmVjYXVz
ZQo+IGl0IGRvZXNuJ3QgZG8gYW55dGhpbmcuCj4KPiBNYXliZSB5b3Ugd2FudDoKPgo+IEBACj4g
dHlwZWRlZiBuZXdfYWRkcmVzczsKPiBuZXdfYWRkcmVzcyBhOwo+IEBACj4gLSBhLmxlbgo+ICsg
YS5sZW5ndGgKPgo+IFRoYXQgaXMsIGEgc2hvdWxkIGJlIGEgbWV0YXZhcmlhYmxlIHJlcHJlc2Vu
dGluZyBhbiBleHByZXNzaW9uIG9mIHRoZQo+IGdpdmVuIHR5cGUsIGFuZCB0aGVuIHlvdSB3YW50
IHRvIHJlcGxhY2UgYSBsZW4gZmllbGQgYnkgbGVuZ3RoLgo+Cj4gWW91IGNvdWxkIGFsc28gd3Jp
dGUgdGhlIGNoYW5nZSBhczoKPgo+IGEuCj4gLWxlbgo+ICtsZW5ndGgKPgo+IGp1bGlhCgotLSAK
LSBNYXggU3VyYWV2IDxtc3VyYWV2QHN5c21vY29tLmRlPiAgICAgICBodHRwOi8vd3d3LnN5c21v
Y29tLmRlLwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQoqIHN5c21vY29tIC0gc3lzdGVtcyBmb3IgbW9iaWxlIGNv
bW11bmljYXRpb25zIEdtYkgKKiBBbHQtTW9hYml0IDkzCiogMTA1NTkgQmVybGluLCBHZXJtYW55
CiogU2l0eiAvIFJlZ2lzdGVyZWQgb2ZmaWNlOiBCZXJsaW4sIEhSQiAxMzQxNTggQgoqIEdlc2No
YWVmdHNmdWVocmVyIC8gTWFuYWdpbmcgRGlyZWN0b3JzOiBIYXJhbGQgV2VsdGUKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlz
dApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9s
aXN0aW5mby9jb2NjaQo=
