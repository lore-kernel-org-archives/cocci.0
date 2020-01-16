Return-Path: <SRS0=PnfW=3F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB062C33CB1
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 11:32:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F192073A
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 11:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eexOSCt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F192073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GBWEA4004280;
	Thu, 16 Jan 2020 12:32:14 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 30C5877F5;
	Thu, 16 Jan 2020 12:32:14 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 20F0B77E5
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 12:32:12 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:543])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GBW7fO008026
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 12:32:07 +0100 (CET)
Received: by mail-pg1-x543.google.com with SMTP id r11so9768736pgf.1
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 03:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=iaxBDvzpV7RekMebeObpP+RPfeiR5JhvqOUni8sm2Js=;
 b=eexOSCt/LAAGlpa6zMRWxi6bECOTFEe41d6VvUip171W9yjEARrQ9CyB5fxwz7sp5H
 3pjeUOZOo4JhwtWIABeRMyVWi9Sm53AeXmf4N2Nnuc/kZIgYzfGDH0xD9BReprPJ1Rcw
 +bEgMdcowyP+QKd9UFW3G6SD1vRjtBggvg1SnnIM5fFPiuQbuAPauEj2SbocFPDJmL3G
 0H1N07Y51muDVQxzSW710NA5Vi/EOTq/CIgjfyRa1z5vYbUcdbCP2OrAqQ8DWHs8rrQl
 1aFmkjHeSvOPV8cDQREVgHqAkubgoTUI/6mMAO2SNcv9bzYqqd1o375X7a7kUvS3kd6m
 oSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=iaxBDvzpV7RekMebeObpP+RPfeiR5JhvqOUni8sm2Js=;
 b=dAD8e3+Y31a9BmoXPtBGIo53gwjttFJMFHTG46p+i8oUj5uoOJGU2Ynalwliym9F5O
 +c27pHGwV052JId9RygQywdPKYiA3XIM1a4AQMTPRDZHBtA1Aa4bkzleJdQqJsy1YGjQ
 fc3ljHI6O/dXrjnvx/yIZ3Dpai8Q239ZpCjGe2j+13PTxHw8myVyMFPN+K9eTI6Sf+y0
 /cztxTM5BRr8zlU+BUADxAazAkMLz8eZ04jfnXCUElUbItoqQO+hr9XoTVvJAExfg5Jy
 mZCGP5VrCsuD1O/QzEEzrk0rqirv1YtQmf1L9YWDJ/1Q99i9PI5TJ6HeXax9hwCjyzeb
 8jjw==
X-Gm-Message-State: APjAAAUJ8ilRfXQksjd8yhwdohyoz9CsnfHgJllotmaHVgBij8kOFcEk
 xHMLRmS3JLUAe3anjfBZmNA=
X-Google-Smtp-Source: APXvYqyRMegpiA2s71CG2BdIqHQlK9z4keoV9SPcdWHTSB558xLNDkM+3F/kY0ighwb3W3T64dCtwg==
X-Received: by 2002:a63:4c4f:: with SMTP id m15mr38556217pgl.346.1579174326423; 
 Thu, 16 Jan 2020 03:32:06 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:1677:7d6f:b2c8:b07a:d4f3:9a2c])
 by smtp.gmail.com with ESMTPSA id x11sm24425005pfn.53.2020.01.16.03.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 03:32:05 -0800 (PST)
Message-ID: <d2507ff6b1b9e89503f4171da6fbc80b3382d4ce.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Thu, 16 Jan 2020 17:01:59 +0530
In-Reply-To: <alpine.DEB.2.21.2001161158440.3888@hadrien>
References: <1090dc9b-9556-f6ab-23dc-f7d0a8176220@web.de>
 <61e7b9f2d132e6bc9feb13ae8fc4636cd934f0b2.camel@gmail.com>
 <alpine.DEB.2.21.2001161158440.3888@hadrien>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jan 2020 12:32:14 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 16 Jan 2020 12:32:07 +0100 (CET)
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

T24gVGh1LCAyMDIwLTAxLTE2IGF0IDExOjU5ICswMTAwLCBKdWxpYSBMYXdhbGwgd3JvdGU6Cj4g
Cj4gT24gVGh1LCAxNiBKYW4gMjAyMCwgSmFza2FyYW4gU2luZ2ggd3JvdGU6Cj4gCj4gPiBPbiBU
aHUsIDIwMjAtMDEtMTYgYXQgMTE6NDAgKzAxMDAsIE1hcmt1cyBFbGZyaW5nIHdyb3RlOgo+ID4g
PiA+IEluIGNlcnRhaW4gY2FzZXMsIHRoZXJlIGlzIG5vIHNwYWNlIGFkZGVkIGFmdGVyIHRoZSBQ
b2ludGVyCj4gPiA+ID4gdHlwZS4KPiA+ID4gCj4gPiA+IFdpbGwgc3VjaCBhIHByZXR0eS1wcmlu
dGluZyBkZXRhaWwgbWF0dGVyIGFsc28gZm9yIHRoZQo+ID4gPiBjbGFyaWZpY2F0aW9uCj4gPiA+
IG9mCj4gPiA+IGEgdG9waWMgbGlrZSDigJxNYWtlIGNoYW5nZSBpbmZsdWVuY2UgY29uZmlndXJh
YmxlIGZvciBjb2Rpbmcgc3R5bGUKPiA+ID4gcnVsZXPigJ0/Cj4gPiA+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvaXNzdWVzLzM3Cj4gPiA+IAo+ID4gCj4gPiBOb3Qg
c3VyZSB3aGF0IHlvdSBtZWFuLiBJZiB5b3UgbWVhbiB0byBzYXkgdGhhdCB0aGUgcmVzdWx0IHNo
b3VsZAo+ID4gY29uZm9ybSB0byB0aGUgTGludXggY29kaW5nIHN0eWxlIChpLmUuIHRoZSByZXN1
bHQgc2hvdWxkIGJlICJjb25zdAo+ID4gY2hhciAqIGNvbnN0ICogeSIgd2l0aCBzcGFjZXMgZXQg
YWwgaW50YWN0KSwgdGhhdCBzZWVtcyBsaWtlCj4gPiBzb21ldGhpbmcKPiA+IGZvciBhIGRpZmZl
cmVudCBwYXRjaCwgcmlnaHQ/IFdoZXRoZXIgeW91IHdhbnQgQ29jY2luZWxsZSB0bwo+ID4gY29u
Zm9ybSB0bwo+ID4gTGludXggY29kaW5nIHN0eWxlIG9yIG5vdCwgdGhlIHNwYWNlIHNob3VsZCBi
ZSBhZGRlZCBlaXRoZXIgd2F5Lgo+IAo+IFRoZSBvcHRpb24gLS1zbXBsLXNwYWNpbmcgc2hvdWxk
IGFkZHJlc3MgdGhpcyBpc3N1ZSwgYnkgcHJlc2Vydmlnbgo+IHRoZQo+IHNwYWNpbmcgaWxsdXN0
cmF0ZWQgaW4gdGhlIHNlbWFudGljIHBhdGNoLiAgSSBkb24ndCBrbm93IGlmIGl0IGRvZXMKPiB0
aGF0Cj4gaW4gdGhpcyBjYXNlLgo+IAoKSG0sIGNhbid0IHNheSB0aGF0IGl0IGRvZXMuIEhlcmUn
cyB3aGF0IEkgZ2V0IHdpdGggLS1zbXBsLXNwYWNpbmcgb24KY2FzZSBodHRwczovL3d3dy5tYWls
LWFyY2hpdmUuY29tL2NvY2NpQHN5c3RlbWUubGlwNi5mci9tc2cwNjY5Ni5odG1sCgpiZWZvcmU6
Cgogdm9pZCBtYWluKCkgewotCWNvbnN0IGNoYXIgKiBjb25zdCAqIHg7CisJY29uc3QgY2hhciAq
Y29uc3QqeSAgOwogfQoKYWZ0ZXI6Cgogdm9pZCBtYWluKCkgewotCWNvbnN0IGNoYXIgKiBjb25z
dCAqIHg7CisJY29uc3QgY2hhciAqY29uc3QgKnkgIDsKIH0KCkNoZWVycywKSmFza2FyYW4uCgo+
IGp1bGlhCj4gCj4gPiBDaGVlcnMsCj4gPiBKYXNrYXJhbi4KPiA+IAo+ID4gPiBSZWdhcmRzLAo+
ID4gPiBNYXJrdXMKPiA+IAo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiA+IENvY2NpIG1haWxpbmcgbGlzdAo+ID4gQ29jY2lAc3lzdGVtZS5saXA2
LmZyCj4gPiBodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWls
aW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21h
aWxtYW4vbGlzdGluZm8vY29jY2kK
