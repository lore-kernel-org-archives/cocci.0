Return-Path: <SRS0=6WN1=S2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB61C10F11
	for <cocci@archiver.kernel.org>; Wed, 24 Apr 2019 12:11:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121D7218B0
	for <cocci@archiver.kernel.org>; Wed, 24 Apr 2019 12:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/A114LK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121D7218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3OCB0hQ007969
          ; Wed, 24 Apr 2019 14:11:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id ECC4A772D;
	Wed, 24 Apr 2019 14:10:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0B1307725
 for <cocci@systeme.lip6.fr>; Wed, 24 Apr 2019 14:10:59 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:341] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3OCAvdg000221
 for <cocci@systeme.lip6.fr>; Wed, 24 Apr 2019 14:10:57 +0200 (CEST)
X-pt: isis.lip6.fr
Received: by mail-ot1-x341.google.com with SMTP id j10so15914074otq.0
 for <cocci@systeme.lip6.fr>; Wed, 24 Apr 2019 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=SzKmlb9b1N2SNJJEPUo40yAd/0yp8n0Ean2I0iX9oXI=;
 b=T/A114LK6NatrxVXQvXFLml3dgcmyxBeO69DwpbUN1kDAQJJDuSw3/ZBw8Dr1xE7G8
 kVj3gH1LNFpxNfXT1XYH/bfMq+up1+S0ClAOrzSRIALVQPCIwFtGz2/4ZCN6ZU6G1J+2
 4GFyinO+NdUHjwNlH+61zwvTxCoFAa57KhqGzX5d+HNQLJvRX4kcxtp0Unt1xhVJVdJG
 UpAjvvyrzZbTSAcc7b8XtrwSQwEN/sSKwN7VwNIq7SVP2Dlue/uL+3I5ScwOgsCbdgMg
 4y0lzb6PplPw+r5Mfe50CD/6bi6ux/oMnAmttHB9okPT+EvSmNqhhr99IoO/d0SHos16
 yrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=SzKmlb9b1N2SNJJEPUo40yAd/0yp8n0Ean2I0iX9oXI=;
 b=STAe1emmzESyBTKiLVy+FU4ry2gL1Pl27g5HIl+VNL9/x4m3sDFkpSkPt59Y2+IRPO
 AsvEnJer3tIQ04BJOTogLrECzHJyvVtagMgRMy30BiuaLJA0/6hqSccgMm5RPyE6qFUQ
 axSpxSG9y/Y/RwIF4zp8MsA5gIaqvzWkoOAU8K6nup1uhheB7qNqWcogLwdvd94WMZ3z
 eXDa7Yv57Bhj2GYr8ljMtWsfRLPSFdGuTc5hhXyusqooMnioBX/7Hmd+QYtGwfp6eQXa
 c30R/alZYfstIu3Wyw5SRN/Y8YajIAoUbN/T4FoTBjj+4hMJPYKF0LDTyCrCkooviRBF
 JaWQ==
X-Gm-Message-State: APjAAAVPHhDxnP4uVHUPQtOCa9B2+HfjsrODCzRpg85ya6B67x+7dtdQ
 m6t4Tnh5xuwmmf2yviXT/FHPVWxxrx7BKdp1WY4=
X-Google-Smtp-Source: APXvYqyTNvXjFoagqwGYlO7sXYRzQYDGlKrv3raxcrK4C6dMC+aRfL0P0+pWqigYuq3Km2v94nNE5QfYWuVeZG0/WA4=
X-Received: by 2002:a9d:5e90:: with SMTP id f16mr18704569otl.86.1556107857164; 
 Wed, 24 Apr 2019 05:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAAGQS2vWgFjbU9t9QXKgDefp1TcOnMoDwPFE0kMpU_203JXEag@mail.gmail.com>
 <79e7d754-f02f-d449-4090-0036274f70b5@web.de>
In-Reply-To: <79e7d754-f02f-d449-4090-0036274f70b5@web.de>
From: Evan Zhao <tacingiht@gmail.com>
Date: Wed, 24 Apr 2019 20:10:46 +0800
Message-ID: <CAAGQS2ujUte9tX4Ai66auP8sy4zkryqEXZkbioy8+hKMvUgmMA@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, Coccinelle <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 24 Apr 2019 14:11:00 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 24 Apr 2019 14:10:57 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: Re: [Cocci] Addition of do-while support for SmPL
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

T24gVHVlLCBBcHIgMjMsIDIwMTkgYXQgMTI6MjggQU0gTWFya3VzIEVsZnJpbmcgPE1hcmt1cy5F
bGZyaW5nQHdlYi5kZT4gd3JvdGU6Cj4KPiA+IEkgd291bGQgbGlrZSB0byBzaG93IHlvdSBteSBl
ZmZvcnRzIG9uIGFkZGluZyB0aGUgbWlzc2luZyBkb3doaWxlIGxvb3AgaW4gU21QTC4KPgo+IERv
IHlvdSByZWZlciB0byB0aGUgZnVuY3Rpb25hbGl0eSDigJxkbyDigKYgd2hpbGUo4oCmKSBsb29w
4oCdIGhlcmU/Cj4KPiBUaGFua3MgZm9yIHlvdXIgaW50ZXJlc3QgaW4gc29mdHdhcmUgZXh0ZW5z
aW9ucyBhY2NvcmRpbmcgdG8gdGhpcyB0b3BpYy4KPiBodHRwczovL3N5c3RlbWUubGlwNi5mci9w
aXBlcm1haWwvY29jY2kvMjAxNS1NYXkvMDAyMDMwLmh0bWwKPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9jb2NjaS81NTU4QUUyOS42MDYwNDA3QHVzZXJzLnNvdXJjZWZvcmdlLm5ldC8KPgoKTXkg
cGF0Y2ggdHJpZXMgdG8gZml4IHRoaXMgaXNzdWUsIEkgd2FzIGluc3BpcmVkIGJ5IGFub3RoZXIg
ZGlzY3VzcyBpbgp0aGUga2VybmVsIG1haWxpbmcgbGlzdC4KCj4KPiA+IEkgdGhpbmsgaXQncyBy
dXN0aWMgYW5kIEkgY291bGQgdXNlIHlvdXIgcHJvZmVzc2lvbmFsIHN1Z2dlc3Rpb25zCj4KPiAq
IEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgcHJvdmlkaW5nIGEgbW9yZSByZWFzb25hYmxlIGRlc2Ny
aXB0aW9uIGFsc28KPiAgIGluIHRoZSBwYXRjaCBmaWxlPwo+Cj4gKiBJIHdvdWxkIHByZWZlciB5
b3VyIHJlYWwgbmFtZSBpbiB0aGUgc2lnbmF0dXJlLgo+ICAgU2VlIGFsc286Cj4gICBodHRwczov
L2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2Jsb2IvODQ4Zjg1ZTI1NjUxNjMzMGMw
NmY1ZmQ4ZGM3ODJiODU0ZWQ5YWEwMy9yZWFkbWUudHh0I0w5MAo+CgpZZXMsIHRoYW5rcywgSSB3
aWxsIGZpeCB0aGVtIGxhdGVyLgoKPgo+ID4gdG8gcmVmaW5lIHRoZSBjb2RlIGFuZCBjb21wbGV0
ZSB0aGUgdGVzdCBzZXQuCj4KPiAqIFdvdWxkIHlvdSBsaWtlIHRvIGFkZCBhIGRpcmVjdG9yeSBm
b3IgeW91ciB0ZXN0IGNvbGxlY3Rpb24/CgpIdW0sIHRoZXJlIGFyZSBvdmVyIDEwMDAgZmlsZXMg
aW4gdGVzdHMvLCBpdCdzIHRlZGlvdXMgdG8gc2Nyb2xsCnRocm91Z2ggYWxsIG9mIHRoZW0uCgo+
Cj4gKiBXaWxsIGxpbmUgYnJlYWtzIGJlIG5lZWRlZCBhdCB0aGUgZW5kIG9mIHRleHQgc291cmNl
IGZpbGVzPwo+CgpJIGRvbid0IGdldCB0aGlzLCBkbyB5b3UgbWVhbiA4MCBjaGFycyBsaW1pdGF0
aW9uPwoKVGh4IQpZaW1pbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8v
c3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
