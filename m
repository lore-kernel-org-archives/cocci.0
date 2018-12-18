Return-Path: <SRS0=6akS=O3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53060C43387
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 18:13:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD3521873
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 18:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD3521873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIID7f0013952
          ; Tue, 18 Dec 2018 19:13:07 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C1379740A;
	Tue, 18 Dec 2018 19:13:07 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6ED193A55
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 19:13:06 +0100 (CET)
Received: from mail.sysmocom.de (mail.sysmocom.de [144.76.43.93])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIID5gK015441
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 19:13:05 +0100 (CET)
X-pt: isis.lip6.fr
Received: from public-mail (mail.sysmocom.de [144.76.43.93])
 by mail.sysmocom.de (Postfix) with ESMTP id AA1D84B9FC7
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 18:13:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([144.76.43.93])
 by public-mail (mail.sysmocom.de [144.76.43.93]) (amavisd-new, port 10024)
 with ESMTP id qaHzksm9vzVr; Tue, 18 Dec 2018 18:13:04 +0000 (UTC)
Received: from [10.9.1.140] (ds9.sysmocom.de [90.187.64.137])
 by mail.sysmocom.de (Postfix) with ESMTPSA id C83174B9FA1
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 18:13:04 +0000 (UTC)
To: cocci@systeme.lip6.fr
References: <0c0bf80c-56bd-6560-12b8-97a4b1b89963@sysmocom.de>
 <alpine.DEB.2.21.1812130724080.2458@hadrien>
 <346d748c-c073-7567-5547-23ec8a47c9b6@sysmocom.de>
 <alpine.DEB.2.21.1812132057380.2465@hadrien>
 <28194663-42c4-83b6-4a21-545408fd7e12@sysmocom.de>
 <alpine.DEB.2.20.1812181716490.2886@hadrien>
 <372cf517-11cb-3021-fc5b-219b26022493@sysmocom.de>
 <alpine.DEB.2.20.1812181749390.2886@hadrien>
 <f70c399f-4158-0457-9d0a-0300fcbe7ea7@sysmocom.de>
 <alpine.DEB.2.20.1812181816000.2886@hadrien>
From: Max <msuraev@sysmocom.de>
Message-ID: <e1edb962-5877-04ab-0148-c2194c804a53@sysmocom.de>
Date: Tue, 18 Dec 2018 19:13:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1812181816000.2886@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 19:13:08 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 19:13:05 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
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

UmlnaHQhCgpTcGF0Y2ggaXMgc21hcnQgZW5vdWdoIHRvIHJlY29nbml6ZSB0aGF0ICJzdHJ1Y3Qg
c210aCIgaXMgYSB0eXBlIGRlZmluaXRpb24uCgpUaGFuayB5b3UsIHdvcmtzIGV2ZW4gYmV0dGVy
IHRoYW4gSSd2ZSBleHBlY3RlZCBub3cgOikKCjE4LjEyLjE4IDE4OjE4LCBKdWxpYSBMYXdhbGwg
0L/QuNGI0LXRgjoKPgo+IFlvdSBnaXZlIGluZm9ybWF0aW9uIGFib3V0IG1ldGF2YXJpYWJsZXMg
aW4gYmV0d2VuIHRoZSBmaXJzdCB0d28gQEAuICBOb3QKPiBkb3duIGluIHRoZSBjb2RlIG1hdGNo
aW5nIHBhcnQuCj4KPiBIZXJlIHlvdSB3YW50IHN0cnVjdCBteV9zdHJ1Y3QgYTsgaW4gdGhlIG1l
dGF2YXJpYWJsZSBsaXN0LCBhbmQgdGhlbiB0aGUKPiBzYW1lIHBhdHRlcm4gYXMgYmVmb3JlIGFm
dGVyIHRoZSBzZWNvbmQgQEAuCj4KPiBZb3UgY2FuIGFsc28gZG8KPgo+IEBACj4ge25ld19hZGRy
ZXNzLHN0cnVjdCBteV9zdHJ1Y3R9IGE7Cj4gQEAKPgo+IGEuCj4gLSBsZW4KPiArIGxlbmd0aAo+
Cj4ganVsaWEKPgotLSAKLSBNYXggU3VyYWV2IDxtc3VyYWV2QHN5c21vY29tLmRlPiAgICAgICBo
dHRwOi8vd3d3LnN5c21vY29tLmRlLwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoqIHN5c21vY29tIC0gc3lzdGVt
cyBmb3IgbW9iaWxlIGNvbW11bmljYXRpb25zIEdtYkgKKiBBbHQtTW9hYml0IDkzCiogMTA1NTkg
QmVybGluLCBHZXJtYW55CiogU2l0eiAvIFJlZ2lzdGVyZWQgb2ZmaWNlOiBCZXJsaW4sIEhSQiAx
MzQxNTggQgoqIEdlc2NoYWVmdHNmdWVocmVyIC8gTWFuYWdpbmcgRGlyZWN0b3JzOiBIYXJhbGQg
V2VsdGUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNv
Y2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxp
cDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
