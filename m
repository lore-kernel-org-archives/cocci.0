Return-Path: <SRS0=PnfW=3F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D76EC33CB1
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 11:37:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073C020730
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 11:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHQli6cr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073C020730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GBanqg010371;
	Thu, 16 Jan 2020 12:36:49 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CE90A77F5;
	Thu, 16 Jan 2020 12:36:49 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A0AA777E5
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 12:36:47 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GBagbj027655
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 12:36:42 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id k3so9771609pgc.3
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 03:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=eQRtO2wkjYCGFOmpMMH6bMmS+AdmojAUYypFQRrfub0=;
 b=qHQli6crr3V62Kxs+XudI9Qk/1uYi6hkBdVnfMK2oQFjagHU70j6KPR/l/u/Dt4WFg
 ifTP8dyAbsZBv+Z9PAUw84TEZ2TpE9D/tIlmD///JOpZyucRBQXKCUslK4ZCHVskrvYg
 r/2PyZIxZwghPtSkoWQtxUiG8MZg1mEvzTCkW2PXHTVT4Jcmo3VlRWY6C03QFK8hBZ42
 UPajuhgZyKHEHaCzLWKP9PmdDOAkFmJ3JrQrK+theD2KNwr+LATooa787kUNOR5AaEJf
 JAr0OKcSI7S/I+tuZTsoWxlpfvJowYXuZc1RpeMftENGG0bbazE61/p4M70HLvws3/H6
 JMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=eQRtO2wkjYCGFOmpMMH6bMmS+AdmojAUYypFQRrfub0=;
 b=t+BDP3ao9adNOjgP/T9Q5lKmsQgKayO8Df/5L0g/lZVVXFi17/UwzAwn84OySD2Zqk
 sc6hEoYQecswVlTCXrJv2G572EVpxGXzCA29ILef4qTvTh81MM8Pd3cYcUE2n6zOSAc0
 /Y7Jl0r4Wu5Nk4c7V/QErZ3tbk/DmpNnIyiCzkEgFI+OFc/Pu4nEg7t/PKfwr0q/pLJv
 n3QBN17eyTZabAP9feZpynHeWK1yslVaMSlaHfxFumssvM304QaHx1WGQAPWSzaoOLEw
 I2Y6dpE7jKjrsRSmL2sneUQKL0S4O5pdQiJeSCn6XpLujNPKqTt3AsbLLwoAJVpaUUCv
 KDDg==
X-Gm-Message-State: APjAAAXgMo9p76gF7qT8yM4mZ5W0GCNTWjor7VHX/1CBNqwc2RDPenQU
 iaambrFRM61DqhVjSfr/pzc=
X-Google-Smtp-Source: APXvYqx7CVHMtJW7WUx5mKy6gViOP1xHfDAmrWMqJB7l0mQrs3d4qbQHZFIsWR5L9vrJZv4x62WpFA==
X-Received: by 2002:aa7:946c:: with SMTP id t12mr37074241pfq.137.1579174602089; 
 Thu, 16 Jan 2020 03:36:42 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:1677:7d6f:b2c8:b07a:d4f3:9a2c])
 by smtp.gmail.com with ESMTPSA id r20sm23979875pgu.89.2020.01.16.03.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 03:36:41 -0800 (PST)
Message-ID: <b737551d2790d5dd5a5f30590aa1996e75552f8d.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
Date: Thu, 16 Jan 2020 17:06:36 +0530
In-Reply-To: <d2507ff6b1b9e89503f4171da6fbc80b3382d4ce.camel@gmail.com>
References: <1090dc9b-9556-f6ab-23dc-f7d0a8176220@web.de>
 <61e7b9f2d132e6bc9feb13ae8fc4636cd934f0b2.camel@gmail.com>
 <alpine.DEB.2.21.2001161158440.3888@hadrien>
 <d2507ff6b1b9e89503f4171da6fbc80b3382d4ce.camel@gmail.com>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jan 2020 12:36:50 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 16 Jan 2020 12:36:42 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
        Markus Elfring <Markus.Elfring@web.de>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH] parsing_c: Add space for tokens after *
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

T24gVGh1LCAyMDIwLTAxLTE2IGF0IDE3OjAxICswNTMwLCBKYXNrYXJhbiBTaW5naCB3cm90ZToK
PiBPbiBUaHUsIDIwMjAtMDEtMTYgYXQgMTE6NTkgKzAxMDAsIEp1bGlhIExhd2FsbCB3cm90ZToK
PiA+IE9uIFRodSwgMTYgSmFuIDIwMjAsIEphc2thcmFuIFNpbmdoIHdyb3RlOgo+ID4gCj4gPiA+
IE9uIFRodSwgMjAyMC0wMS0xNiBhdCAxMTo0MCArMDEwMCwgTWFya3VzIEVsZnJpbmcgd3JvdGU6
Cj4gPiA+ID4gPiBJbiBjZXJ0YWluIGNhc2VzLCB0aGVyZSBpcyBubyBzcGFjZSBhZGRlZCBhZnRl
ciB0aGUgUG9pbnRlcgo+ID4gPiA+ID4gdHlwZS4KPiA+ID4gPiAKPiA+ID4gPiBXaWxsIHN1Y2gg
YSBwcmV0dHktcHJpbnRpbmcgZGV0YWlsIG1hdHRlciBhbHNvIGZvciB0aGUKPiA+ID4gPiBjbGFy
aWZpY2F0aW9uCj4gPiA+ID4gb2YKPiA+ID4gPiBhIHRvcGljIGxpa2Ug4oCcTWFrZSBjaGFuZ2Ug
aW5mbHVlbmNlIGNvbmZpZ3VyYWJsZSBmb3IgY29kaW5nCj4gPiA+ID4gc3R5bGUKPiA+ID4gPiBy
dWxlc+KAnT8KPiA+ID4gPiBodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxl
L2lzc3Vlcy8zNwo+ID4gPiA+IAo+ID4gPiAKPiA+ID4gTm90IHN1cmUgd2hhdCB5b3UgbWVhbi4g
SWYgeW91IG1lYW4gdG8gc2F5IHRoYXQgdGhlIHJlc3VsdCBzaG91bGQKPiA+ID4gY29uZm9ybSB0
byB0aGUgTGludXggY29kaW5nIHN0eWxlIChpLmUuIHRoZSByZXN1bHQgc2hvdWxkIGJlCj4gPiA+
ICJjb25zdAo+ID4gPiBjaGFyICogY29uc3QgKiB5IiB3aXRoIHNwYWNlcyBldCBhbCBpbnRhY3Qp
LCB0aGF0IHNlZW1zIGxpa2UKPiA+ID4gc29tZXRoaW5nCj4gPiA+IGZvciBhIGRpZmZlcmVudCBw
YXRjaCwgcmlnaHQ/IFdoZXRoZXIgeW91IHdhbnQgQ29jY2luZWxsZSB0bwo+ID4gPiBjb25mb3Jt
IHRvCj4gPiA+IExpbnV4IGNvZGluZyBzdHlsZSBvciBub3QsIHRoZSBzcGFjZSBzaG91bGQgYmUg
YWRkZWQgZWl0aGVyIHdheS4KPiA+IAo+ID4gVGhlIG9wdGlvbiAtLXNtcGwtc3BhY2luZyBzaG91
bGQgYWRkcmVzcyB0aGlzIGlzc3VlLCBieSBwcmVzZXJ2aWduCj4gPiB0aGUKPiA+IHNwYWNpbmcg
aWxsdXN0cmF0ZWQgaW4gdGhlIHNlbWFudGljIHBhdGNoLiAgSSBkb24ndCBrbm93IGlmIGl0IGRv
ZXMKPiA+IHRoYXQKPiA+IGluIHRoaXMgY2FzZS4KPiA+IAo+IAo+IEhtLCBjYW4ndCBzYXkgdGhh
dCBpdCBkb2VzLiBIZXJlJ3Mgd2hhdCBJIGdldCB3aXRoIC0tc21wbC1zcGFjaW5nIG9uCj4gY2Fz
ZSBodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29tL2NvY2NpQHN5c3RlbWUubGlwNi5mci9tc2cw
NjY5Ni5odG1sCj4gCgpXaG9vcHMsIGluY29ycmVjdCBsaW5rCmh0dHBzOi8vd3d3Lm1haWwtYXJj
aGl2ZS5jb20vY29jY2lAc3lzdGVtZS5saXA2LmZyL21zZzA2Njk1Lmh0bWwKCkNoZWVycywKSmFz
a2FyYW4uCgo+IGJlZm9yZToKPiAKPiAgdm9pZCBtYWluKCkgewo+IC0JY29uc3QgY2hhciAqIGNv
bnN0ICogeDsKPiArCWNvbnN0IGNoYXIgKmNvbnN0KnkgIDsKPiAgfQo+IAo+IGFmdGVyOgo+IAo+
ICB2b2lkIG1haW4oKSB7Cj4gLQljb25zdCBjaGFyICogY29uc3QgKiB4Owo+ICsJY29uc3QgY2hh
ciAqY29uc3QgKnkgIDsKPiAgfQo+IAo+IENoZWVycywKPiBKYXNrYXJhbi4KPiAKPiA+IGp1bGlh
Cj4gPiAKPiA+ID4gQ2hlZXJzLAo+ID4gPiBKYXNrYXJhbi4KPiA+ID4gCj4gPiA+ID4gUmVnYXJk
cywKPiA+ID4gPiBNYXJrdXMKPiA+ID4gCj4gPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4gPiA+IENvY2NpIG1haWxpbmcgbGlzdAo+ID4gPiBDb2Nj
aUBzeXN0ZW1lLmxpcDYuZnIKPiA+ID4gaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9s
aXN0aW5mby9jb2NjaQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5
c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
