Return-Path: <SRS0=QaTm=YN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAC7CA9EAD
	for <cocci@archiver.kernel.org>; Sun, 20 Oct 2019 05:44:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5152222D1
	for <cocci@archiver.kernel.org>; Sun, 20 Oct 2019 05:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1tP4sHwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5152222D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9K5i3CA019445;
	Sun, 20 Oct 2019 07:44:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0A1F677C5;
	Sun, 20 Oct 2019 07:44:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DFC937792
 for <cocci@systeme.lip6.fr>; Sat, 19 Oct 2019 16:30:03 +0200 (CEST)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:242] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9JEU12Z021453
 for <cocci@systeme.lip6.fr>; Sat, 19 Oct 2019 16:30:01 +0200 (CEST)
Received: by mail-oi1-x242.google.com with SMTP id k9so7591980oib.7
 for <cocci@systeme.lip6.fr>; Sat, 19 Oct 2019 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ghDSQm39Jlx5gmXnVANSIgsOJIuDnV4Wo+ABz1BaRQU=;
 b=1tP4sHwYNnpUfkWS3qnr2mj9w0eS2pve2ZqGcA7RzVnVzMz+noVDjBSoCquw3GTUSk
 f++M1+Rc6MGqcbC/TbG/SmndF5rQSjKZTrOEuHH9ie83u+6B1tSC005RK6D1DxL2ZlTh
 Xllcir1nEKTJ7o0C8pxtRmkgEUBu9uehNb45RopqUyZIfHkcbzhZ9BGJiD8F8x7R1eBZ
 FZwAgKrK8ZE1SNh4s3+j78KnVFNduRwTearMxrg3K2DGSzMocmiDQicDO/JE+c+fa5jV
 /G6KTl3E1eIIPgv0if1LsVYBbc6ru8l7X979qo6qXHCDcLrtYbAYwp6XQ0LZYec+SXHg
 B43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ghDSQm39Jlx5gmXnVANSIgsOJIuDnV4Wo+ABz1BaRQU=;
 b=Peellg8aKm9qdIm7f6JoX2Afu4qx88hmlIBUnxhGmBpyI26q8C8aq2n1Fk2kEV14WM
 uwBZt2uEYwgC6vSQSLvPQxuGJP4c0gEOjMz9SbB5Gr6dC+gzgIUerhwpTv7PB/Ctc7wY
 jFVjZxibxOc1F6KbLUAljV2O0OhqyzGEuMGcp4+repI06XnmWZJlP+AUY4Q05HdGUuxz
 rPlWMtOsPdJNcixDQ0qxP5Qfyu7d+pVlElNMUNfInlnb1j71sEYvwJA8JXo7crREhAZg
 8aUCGHjcrSY+mdrXqlz2WoB2nrgtxaiI3MVEzHvOrbA6m9LV6yAA+Vg2OIBL0vcAFapl
 s/JQ==
X-Gm-Message-State: APjAAAX97I7QRjIr7L0uMbLnL7wfIlFyB9FHuPulw+ar2adq5rx6ScVG
 YegK/gmYAhf7bfbur72V7wfSX1i0idHHt8UeGj9MWg==
X-Google-Smtp-Source: APXvYqy7kFGbeJUVk96O4myEcxmRrSHyTc66p9xYDDub/LBqYgX2CKrxiG35GXcyGwr8n6C75UtxLrayLoJT/v4Zxsk=
X-Received: by 2002:a54:4e83:: with SMTP id c3mr12411782oiy.170.1571495400968; 
 Sat, 19 Oct 2019 07:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191017142237.9734-1-alexandre.belloni@bootlin.com>
 <81269cd6-e26d-b8aa-cf17-3a2285851564@web.de>
 <20191019120941.GL3125@piout.net>
In-Reply-To: <20191019120941.GL3125@piout.net>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Sat, 19 Oct 2019 16:29:49 +0200
Message-ID: <CAMpxmJVEXubtBhQs5wH00wvK=yp8nr0cZ04x9t8eCTLVU=O1JA@mail.gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 20 Oct 2019 07:44:03 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 19 Oct 2019 16:30:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Sun, 20 Oct 2019 07:44:00 +0200
Cc: Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH] coccinelle: api/devm_platform_ioremap_resource:
 remove useless script
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

c29iLiwgMTkgcGHFuiAyMDE5IG8gMTQ6MDkgQWxleGFuZHJlIEJlbGxvbmkKPGFsZXhhbmRyZS5i
ZWxsb25pQGJvb3RsaW4uY29tPiBuYXBpc2HFgihhKToKPgo+IE9uIDE5LzEwLzIwMTkgMTE6MDA6
NDcrMDIwMCwgTWFya3VzIEVsZnJpbmcgd3JvdGU6Cj4gPiA+IFdoaWxlIGl0IGlzIHVzZWZ1bCBm
b3IgbmV3IGRyaXZlcnMgdG8gdXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSwKPiA+
Cj4gPiBUaGlzIGlzIG5pY2UuCj4gPgo+ID4KPiA+ID4gdGhpcyBzY3JpcHQgaXMgY3VycmVudGx5
IHVzZWQgdG8gc3BhbSBtYWludGFpbmVycywKPiA+Cj4gPiBUaGlzIHZpZXcgaXMgdW5mb3J0dW5h
dGUuCj4gPgo+ID4gRG8gd2Ugc3R1bWJsZSBvbiBhIHRhcmdldCBjb25mbGljdCBhZ2Fpbj8KPiA+
Cj4gPgo+ID4gPiBvZnRlbiB1cGRhdGluZyB2ZXJ5IG9sZCBkcml2ZXJzLgo+ID4KPiA+IFRoaXMg
Y2FuIGFsc28gaGFwcGVuLgo+ID4KPiA+Cj4gPiA+IFRoZSBuZXQgYmVuZWZpdCBpcyB0aGUgcmVt
b3ZhbCBvZiAyIGxpbmVzIG9mIGNvZGUgaW4gdGhlIGRyaXZlcgo+ID4KPiA+IEFkZGl0aW9uYWwg
ZWZmZWN0cyBjYW4gYmUgcmVjb25zaWRlcmVkLCBjYW4ndCB0aGV5Pwo+ID4KPgo+IFdoYXQgYXJl
IHRoZSBhZGRpdGlvbmFsIGVmZmVjdHM/IFdoYXQgaXMgdGhlIGVuZCBnb2FsIG9mIGNvbnZlcnRp
bmcgYWxsCj4gdGhlIGV4aXN0aW5nIGRyaXZlcnMgdG8gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jl
c291cmNlPyBUaGUgZXhpc3RpbmcKPiBjb2RlIGlzIGN1cnJlbnRseSBhbHdheXMgY29ycmVjdCBh
bmQgaXQgaXMgZGlmZmljdWx0IHRvIHNlZSBob3cgdGhpcwo+IHdvdWxkIGxlYWQgdG8gYW55IGJ1
ZyBhdm9pZGFuY2UgaW4gdGhlIGxvbmcgdGVybS4KPgo+ID4gPiBidXQgdGhlIHJldmlldyBsb2Fk
IGZvciB0aGUgbWFpbnRhaW5lcnMgaXMgaHVnZS4KPiA+Cj4gPiBEb2VzIGNvbGxhdGVyYWwgZXZv
bHV0aW9uIHRyaWdnZXIgYSByZW1hcmthYmxlIGFtb3VudCBvZiBjaGFuZ2VzIG9jY2FzaW9uYWxs
eT8KPiA+Cj4KPiBUaGlzIGlzIG5vdCBhbiBldm9sdXRpb24sIGl0IGlzIHVubmVjZXNzYXJ5IGNo
dXJuLiBUaG9zZSBwYXRjaGVzIGhhdmUgbm8KPiBiZW5lZml0IGFuZCBlYXQgdXAgdmVyeSB2YWx1
YWJsZSByZXZpZXdlciB0aW1lLgo+Cj4gPgo+ID4gSG93IHdpbGwgc3VjaCBmZWVkYmFjayBpbmZs
dWVuY2UgdGhlIGRldmVsb3BtZW50IGFuZCBpbnRlZ3JhdGlvbiBvZgo+ID4gZnVydGhlciBzY3Jp
cHRzIGZvciB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UgKENvY2NpbmVsbGUgc29mdHdhcmUp
Pwo+ID4KPgo+IFRoZXJlIGFyZSBhIGZldyBvdGhlciBzY3JpcHRzIHRoYXQgaGF2ZSBubyBhZGRl
ZCB2YWx1ZSB3aGVuIGFwcGxpZWQgdG8KPiBleGlzdGluZyBjb2RlLCBsaWtlIHB0cl9yZXQuY29j
Y2kuCj4KPiAtLQo+IEFsZXhhbmRyZSBCZWxsb25pLCBCb290bGluCj4gRW1iZWRkZWQgTGludXgg
YW5kIEtlcm5lbCBlbmdpbmVlcmluZwo+IGh0dHBzOi8vYm9vdGxpbi5jb20KCkhpIEFsZXhhbmRy
ZSwKCk1hcmt1cyBoYXMgYmVlbiBibGFjay1saXN0ZWQgYnkgc2V2ZXJhbCBjb3JlIG1haW50YWlu
ZXJzIGFscmVhZHksIEkKdGhpbmsgeW91J3JlIHdhc3RpbmcgeW91ciB0aW1lIGFyZ3VpbmcuIFdS
VCB0aGUgcGF0Y2g6IHdoZW4KaW50cm9kdWNpbmcgdGhpcyB3cmFwcGVyLCBJIGRlZmluaXRlbHkg
ZGlkbid0IGV4cGVjdCBwZW9wbGUgdG8gc2VuZApodW5kcmVkcyBvZiBvZnRlbiB3cm9uZyBwYXRj
aGVzIGJhc2VkIG9uIGNvY2NpbmVsbGUgcmVwb3J0cywgc28gSQpndWVzcyByZW1vdmluZyB0aGUg
c2NyaXB0IGlzIGNvcnJlY3QuCgpCYXJ0Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIK
aHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
