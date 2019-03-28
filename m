Return-Path: <SRS0=Pg7l=R7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C98C43381
	for <cocci@archiver.kernel.org>; Thu, 28 Mar 2019 13:10:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A11F2173C
	for <cocci@archiver.kernel.org>; Thu, 28 Mar 2019 13:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LM483Zxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A11F2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2SDA1sW019786
          ; Thu, 28 Mar 2019 14:10:01 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2E198771A;
	Thu, 28 Mar 2019 14:10:01 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 78ED87719
 for <cocci@systeme.lip6.fr>; Thu, 28 Mar 2019 14:09:58 +0100 (CET)
Received: from shiva.jussieu.fr (shiva.jussieu.fr [134.157.0.129])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2SD9uMa003679
 for <cocci@systeme.lip6.fr>; Thu, 28 Mar 2019 14:09:56 +0100 (CET)
X-pt: isis.lip6.fr
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 by shiva.jussieu.fr (8.15.2/jtpda-5.4) with ESMTP id x2SD9KoE001666
 for <cocci@systeme.lip6.fr>; Thu, 28 Mar 2019 14:09:48 +0100 (CET)
X-Ids: 164
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id x2SD8fDj005577
 for <cocci@systeme.lip6.fr>; Thu, 28 Mar 2019 22:08:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2SD8fDj005577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1553778522;
 bh=nNDy7x/HQuHXlxZ1crpYzQdxixf+oAWzGu1wozRJaz4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=LM483ZxfzDx0TGjAmkP4ofZlwCDUYO5s2K+c3zm3alPiVlaHmrMlrHR3oeTE/sMcn
 C5z4uf+1iGfcSNvXpp08yo9V7nhdeqCWizlE20ZGq919HPbu97iUrNLpK/6g+NOz7g
 fFCLV/3323w+F1LSnZzb9Rr4Y64VjgycrXv31eluifA9vBxwhL+IbluwXedvPjcm1i
 zBakQTiRO+YF73Ynz496lirycJYU1Cmmba2SnfVbMYQ4AMh5YM04lrrblsf2Cvy5yF
 AbE9ZnWuUb/lx3dCNuRL/b7dw443f6agPMjbjXY2cPyeGCjw9oC25JNcqmzwVUg2Ks
 sOinS2y/O41Fw==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id w13so12060771vsc.4
 for <cocci@systeme.lip6.fr>; Thu, 28 Mar 2019 06:08:42 -0700 (PDT)
X-Gm-Message-State: APjAAAVOsEyli38KZq8sJRjkvWn2JDzawlK+x0++ZRrCKjWdXTVGq+/c
 +gWEwQLN6X3xxqJZ1Q3M31Nzr2BvFmHZw/o4UVg=
X-Google-Smtp-Source: APXvYqze54vyOIYL0L88wXMtvls5ZGOxFoeXcW2Oah/RPdLLeaRx2zD55fkwLOrlLseCRO00m6VQTWEOSlE5xj5V3As=
X-Received: by 2002:a67:f105:: with SMTP id n5mr26171042vsk.181.1553778521498; 
 Thu, 28 Mar 2019 06:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <179bbdd1-3fcb-bba5-52b3-7f96973c7650@web.de>
 <alpine.DEB.2.21.1903232104030.5660@hadrien>
 <20190326084512.GC32590@kadam> <alpine.DEB.2.20.1903261037320.5021@hadrien>
 <20190326101103.GH32613@kadam> <alpine.DEB.2.20.1903261115300.5021@hadrien>
In-Reply-To: <alpine.DEB.2.20.1903261115300.5021@hadrien>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 28 Mar 2019 22:08:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9gKvEX9520Sd50vrS7Gug1JQCMx_TJO_KPQjhjPORXw@mail.gmail.com>
Message-ID: <CAK7LNAT9gKvEX9520Sd50vrS7Gug1JQCMx_TJO_KPQjhjPORXw@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Miltered: at jchkmail2.reseau.jussieu.fr with ID 5C9CC780.001 by Joe's
 j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 5C9CC780.001 from
 conssluserg-03.nifty.com/conssluserg-03.nifty.com/210.131.2.82/conssluserg-03.nifty.com/<yamada.masahiro@socionext.com>
X-Scores-Stats: 5C9CC780.001 B=0.50000 L=0.14513 G=0.14513 Disagree Winner=PH
X-j-chkmail-Score: MSGID : 5C9CC780.001 on shiva.jussieu.fr : j-chkmail score
 : X : R=. U=. O=. B=0.145 -> S=0.145
X-j-chkmail-Status: Ham
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 Mar 2019 14:10:02 +0100 (CET)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 28 Mar 2019 14:09:56 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        kernel-janitors@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cocci@systeme.lip6.fr, Markus Elfring <Markus.Elfring@web.de>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Cocci] [PATCH] coccinelle: put_device: reduce false positives
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

T24gVHVlLCBNYXIgMjYsIDIwMTkgYXQgNzoxNiBQTSBKdWxpYSBMYXdhbGwgPGp1bGlhLmxhd2Fs
bEBsaXA2LmZyPiB3cm90ZToKPgo+Cj4KPiBPbiBUdWUsIDI2IE1hciAyMDE5LCBEYW4gQ2FycGVu
dGVyIHdyb3RlOgo+Cj4gPiBPbiBUdWUsIE1hciAyNiwgMjAxOSBhdCAxMDozODo0M0FNICswMTAw
LCBKdWxpYSBMYXdhbGwgd3JvdGU6Cj4gPiA+Cj4gPiA+Cj4gPiA+IE9uIFR1ZSwgMjYgTWFyIDIw
MTksIERhbiBDYXJwZW50ZXIgd3JvdGU6Cj4gPiA+Cj4gPiA+ID4gT24gU2F0LCBNYXIgMjMsIDIw
MTkgYXQgMDk6MDY6NTRQTSArMDEwMCwgSnVsaWEgTGF3YWxsIHdyb3RlOgo+ID4gPiA+ID4KPiA+
ID4gPiA+Cj4gPiA+ID4gPiBPbiBTYXQsIDIzIE1hciAyMDE5LCBNYXJrdXMgRWxmcmluZyB3cm90
ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gRG9uJ3QgY29tcGxhaW4gYWJvdXQgYSByZXR1cm4g
d2hlbiB0aGlzIGZ1bmN0aW9uIHJldHVybnMgIiZwZGV2LT5kZXYiLgo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiBXb3VsZCB0aGlzIGluZm9ybWF0aW9uIHF1YWxpZnkgdG8gYWRkIHRoZSB0YWcg4oCc
Rml4ZXPigJ0gdG8gdGhlIGNvbW1pdCBtZXNzYWdlPwo+ID4gPiA+ID4KPiA+ID4gPiA+IEZpeGVz
IHRhZ3MgcmVsYXRlIHRvIHN0YWJsZSBrZXJuZWxzLCBzbyB0aGF0IG9uZSBjYW4gc2VlIHdoaWNo
IHN0YWJsZQo+ID4gPiA+ID4ga2VybmVscyBhIHBhcnRpY3VsYXIgcGF0Y2ggc2hvdWxkIGJlIHBy
b3BhZ2F0ZWQgdG8uICBUaGVyZSBpcyBubyBuZWVkIHRvCj4gPiA+ID4gPiBwcm9wYWdhdGUgcGF0
Y2hlcyBvbiBzZW1hbnRpYyBwYXRjaGVzIHRvIHN0YWJsZSBrZXJuZWxzLiAgUGVvcGxlIHdobyBy
dW4KPiA+ID4gPiA+IHN0YWJsZSBrZXJuZWxzIGFyZSBpbnRlcmVzdGVkIGluIHRoZWlyIGJlaGF2
aW9yLCBub3QgdGhlIGJ1ZyBmaW5kaW5nCj4gPiA+ID4gPiBydWxlcyB0aGF0IHRoZXkgY29udGFp
bi4KPiA+ID4gPgo+ID4gPiA+IFRoZSBGaXhlcyB0YWcgaXMgbm90IGp1c3QgYWJvdXQgc3RhYmxl
Li4uICBGb3IgZXhhbXBsZSwgd2UgdXNlIHRoZW0gZm9yCj4gPiA+ID4gc3RhdGlzdGljcyB0byBz
ZWUgaG93IHF1aWNrbHkgYnVncyBnZXQgZml4ZWQgZXRjLgo+ID4gPgo+ID4gPiBPSy4gIEJ1dCBz
dGlsbCBkbyB3ZSBuZWVkIGZpeGVzIHRhZ3MgZm9yIGJ1ZyBmaW5kaW5nIHJ1bGVzPyAgUGVyaGFw
cyBpZgo+ID4gPiB0aGUgcHJldmlvdXMgdmVyc2lvbiB3YXMgcmVhbGx5IGJyb2tlbiwgYW5kIGl0
IHdvdWxkIGJlIHJlYWxseSB1bmRlc2lyYWJsZQo+ID4gPiB0byB1c2UgaXQuCj4gPgo+ID4gSXQn
cyBub3Qgd29ydGggcmVzZW5kaW5nIGEgcGF0Y2ggZm9yIHRoYXQsIGJ1dCBJIHByb2JhYmx5IHdv
dWxkIHVzZSB0aGUKPiA+IGZpeGVzIHRhZy4gIEl0IGRlcGVuZHMgb24geW91ciBkZWZpbml0aW9u
IG9mICJidWciIHJlYWxseS4uLiAgSSB0ZWxsCj4gPiBwZW9wbGUgbm90IHRvIHVzZSBGaXhlcyBm
b3Igc3BlbGxpbmcgbWlzdGFrZXMgYW5kIHVudXNlZCB2YXJpYWJsZXMuICBCdXQKPiA+IEkgZG8g
dXNlIHRoZSBGaXhlcyB0YWcgZm9yIHRoaW5ncyBsaWtlICJhbiBvZmYgYnkgb25lIGluIGEgc2Fu
aXR5IGNoZWNrCj4gPiB3aGljaCBkb2Vzbid0IGFmZmVjdCBydW4gdGltZSBiZWNhdXNlIHRoZSBp
bmRleCBpcyBhbHdheXMgY29ycmVjdCIuCj4KPiBPSywgdGhhbmtzLgo+Cj4ganVsaWEKCkkgYWRk
ZWQgRml4ZXM6IHRhZywKYW5kIGFwcGxpZWQgdG8gbGludXgta2J1aWxkL2ZpeGVzLgoKVGhhbmtz
LgoKLS0gCkJlc3QgUmVnYXJkcwpNYXNhaGlybyBZYW1hZGEKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3Rl
bWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2Np
Cg==
