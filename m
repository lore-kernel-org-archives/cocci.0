Return-Path: <SRS0=jUR0=B7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F6BC433DF
	for <cocci@archiver.kernel.org>; Fri, 21 Aug 2020 13:52:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FFD20656
	for <cocci@archiver.kernel.org>; Fri, 21 Aug 2020 13:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="H0ji8iPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FFD20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07LDphnh000529;
	Fri, 21 Aug 2020 15:51:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 52D377814;
	Fri, 21 Aug 2020 15:51:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EAAD64173
 for <cocci@systeme.lip6.fr>; Fri, 21 Aug 2020 07:55:27 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07L5tQJA012372
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 21 Aug 2020 07:55:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1597989321;
 bh=JiR+0y3QCudFVMb9PUuGC0+fatUIEiM5rQyStU3wH7c=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=H0ji8iPLYMTFYK/89A7HpErl8QUyGcDoHgUQrIR6rY92R8Fkl9UxbW1+hr0/qMEs6
 xjACdKVYDAhqckmnzMGIIwYFVKjcvSpoECZBkFZH+S5vaI839aG5rAdrUqL9yCscn9
 VmJpSjZUWdvh3Xncg8Ki64bYcpeTQzw0G0JOXl/M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.12.183]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LbJ4A-1kWlG71UPi-00ky3c; Fri, 21
 Aug 2020 07:55:21 +0200
To: Joe Perches <joe@perches.com>, Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a66c5072-84ef-fec2-7bad-38bc30f583fd@web.de>
Date: Fri, 21 Aug 2020 07:55:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:uowgHclhQHXFU29yD2Gcfvqa5OcVcTn8/CEji+HR7KpFNIcG0sm
 P+TdSvxO8b+0SPWVmeIKlCvci0al/514tgP4i2N/0BrQSCJiYlxhKySuDq26wkrlCGKu+9g
 2QzmZX47KEsh7T85UBC0XDOWlEnwT0MI1RosPd2O+YhhKKhSEjFRt/Uk1Y1pNvQF1fQVRoN
 5tiOn1kFB51A4Db4ffmtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aYi7/axBWis=:xblCSrMuXFMd40NvNf+zpY
 n3+5jvSPrrrxCoGyDKzyYhapTkYqCq3xahsWQSLYdAukPr3s84ppQk3cDu9oofUG4IdvADO/u
 1hcKV93TJ69tEHnui0qO2l519/BQKxCPOeM87VAfPMiRkibTNJsVJMGr91AwyzPykth/Qdtml
 0+uv4KMmjuYbf6KnWfzi2QB5Q34TM7Q+sKjFDQ696EQ/dWPwrBrE4YZH0qdVJD3WpvJjjjtHs
 3Q731iESsAvk9uyWKU9jCWRDhAHBAH4kbm3T8isRthUtGa49OOQ8QCMQZJswdw97Rf24EWmHC
 D2DSf66mBe33vjd2GmEb4s2+x2RLGnRR9gGYRLSMa5uRvXdqnsvAD1TNfybDswIZQDht3B8ZR
 xDXPX72tIiNbUDqHtGKEYmfhjz2IlqHGsDiav+F+cI+nd8u7xA66JPM1rdBIlobMSDTYsDSlp
 zzzerAgTaWGvE0/7wOUaSlfqvNVcGHEKfWfQbvOK9V6l6y19agsOaZNnxlCXJv2w6i9yjyzHG
 ZB+vCQL5y/Q48iS8W9ev3VuWHFu/2Qnv275+AjtVe/sPw2Vq2Xncbc2Mn3R0/gQXvo6EJ7JM6
 qYSOoT2ygzClUk33QA9fzVOXPgHx3SgOLEh4FT1rJ9++BK0VBBey2LWATbFdvAQ87FWDNuT7/
 R/xEw8jyIVx2g/qSeqJ6ipy0KCe1KfrU9Bum+/ppycu6hRyP6LGULbrOpAzctAOcd6ENeGiF+
 6dNj/yto7whfTliMRORAW1JtbprXgfw03xsglQ4ufaOY+VR8RnCE23YG5K++ud9Qlpy1ecUWi
 FkYZ0r0H4+MhwcZrf2Y2bShd/9lw83M4lHZETzbaZPARd6+tSyio8T02To9DxOA7nZ06B6BAf
 c4vtwjoQh7Jb9QUiQFdufZR8lQIISux+3kf2JPGDnV/Bpd05RDNHuSZgjrbuQxT0aeIAULjVv
 NyrV3DV+yIQGisS4bIpOllGquyixqhZEqVFARMTh1HN6vpz7dx1+BbSfk5KxkChrOTSAQKOE5
 1E7BHG6M1X3bgWbyYviBHFO2ZbLhpimJSclBABsQdrbu1TQiRWTm+jyQSv7Zw/eJc6GHLAaNP
 w5Ogp0BUJMLo/yNHMth4EiOuf0/d+uZwciawsTAe4qwLpqcvj3amuXMExOK/EbjxwCyrkR7+b
 ubdFR1YiU7+fxuEWo0bRF1667Q86AOWW5KDgSRU7ROvF5x3ar/tTOwqqbMmcgu6EAa3LjDxRV
 IQwGLc0BQilPLjCnGClhyoJ8tBxFkSAAZHMKNcA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 21 Aug 2020 15:51:43 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 21 Aug 2020 07:55:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Fri, 21 Aug 2020 15:51:41 +0200
Cc: Giuseppe Scrivano <gscrivan@redhat.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
        Andy Whitcroft <apw@shadowen.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolon
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

PiA+IEFkZCBhbiBpbXBlcmZlY3QgdGVzdCB0byBkZXRlY3QgdGhlc2UgY29tbWEgdXNlcy4KPiA+
Cj4gPiBObyBmYWxzZSBwb3NpdGl2ZXMgd2VyZSBmb3VuZCBpbiB0ZXN0aW5nLCBidXQgbWFueSB0
eXBlcyBvZiBmYWxzZSBuZWdhdGl2ZXMKPiA+IGFyZSBwb3NzaWJsZS4KPiA+Cj4gPiBlLmcuOgo+
ID4gCWZvbyA9IGJhcigpICsgMSwJLyogY29tbWEgdXNlLCBidXQgbm90IGRpcmVjdCBhc3NpZ25t
ZW50ICovCj4gPiAJYmFyID0gYmF6KCk7Cj4KPiBIaS4KPgo+IEkgcmVjZW50bHkgYWRkZWQgYSB0
ZXN0IGZvciB0aGlzIGNvbmRpdGlvbiB0byBsaW51eCdzIGNoZWNrcGF0Y2guCj4KPiBBIHNpbWls
YXIgY29jY2luZWxsZSBzY3JpcHQgbWlnaHQgYmU6CgpJIGZpbmQgaXQgaW50ZXJlc3RpbmcgdGhh
dCB5b3UgcHJlc2VudCBhbm90aGVyIHRyYW5zZm9ybWF0aW9uIGFwcHJvYWNoCmZvciB0aGUgc2Vt
YW50aWMgcGF0Y2ggbGFuZ3VhZ2UuCgoKPiAkIGNhdCBjb21tYS5jb2NjaQo+IEBACj4gZXhwcmVz
c2lvbiBlMTsKPiBleHByZXNzaW9uIGUyOwo+IEBACj4KPiAJZTEKPiAtCSwKPiArCTsKPiAJZTI7
CgpTdWNoIGEgdGlueSBTbVBMIHNjcmlwdCBsb29rcyBzbyBzaW1wbGUuCgoKPiBUaGlzIHdvcmtz
IHJlYXNvbmFibHkgd2VsbCBidXQgaXQgaGFzIHNldmVyYWwgZmFsc2UgcG9zaXRpdmVzCj4gZm9y
IGRlY2xhcmF0aW9ucyBsaWtlOgoKV291bGQgeW91IGxpa2UgdG8gZmlsdGVyIHRoZSB1c2FnZSBv
ZiBjb2RlIGxpa2Ug4oCcTElTVF9IRUFEKGxpc3Qp4oCdIG91dD8KCgpBcmUgdGhlcmUgYW55IG1v
cmUgc29mdHdhcmUgZGV2ZWxvcG1lbnQgY2hhbGxlbmdlcyB0byBjb25zaWRlcgpmb3Igc3BlY2lh
bCBhc3NpZ25tZW50IHN0YXRlbWVudHM/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2Np
QHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZv
L2NvY2NpCg==
