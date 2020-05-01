Return-Path: <SRS0=tAXx=6P=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9721EC47254
	for <cocci@archiver.kernel.org>; Fri,  1 May 2020 05:15:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCFAD20731
	for <cocci@archiver.kernel.org>; Fri,  1 May 2020 05:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="MxXlByP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFAD20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0415Ff6e029478;
	Fri, 1 May 2020 07:15:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 064AB757C;
	Fri,  1 May 2020 07:15:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AF2223DC8
 for <cocci@systeme.lip6.fr>; Fri,  1 May 2020 07:15:38 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0415Fc3p016343
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 1 May 2020 07:15:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588310137;
 bh=oy0z+8oc27saqRVDq8g5Hkr6eR3lt3IctAELcG/5aMs=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=MxXlByP4MHUwSKk5stl6g5OZUe5GmCu51rGWgEyBbCYhJSie4lMhls6vTR84s3sUY
 dQIGDeGB+0zovIA+TuFppYQUBw2D8/nY+dQFPVOjiubVxlBfiIWpfgwwbcIFnf+4C3
 glFK0wSSDuaBxYXqOFktblzzfAydsQ908LFvZdH4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.136.146]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MW9ra-1jera708M6-00XbVq; Fri, 01
 May 2020 07:15:37 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <3069d2ed-475d-d36f-526e-4b7a685577cb@web.de>
 <alpine.DEB.2.21.2004301913110.13683@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <69ddcc1f-77d2-a1cd-8b2d-e64daa13d00a@web.de>
Date: Fri, 1 May 2020 07:15:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004301913110.13683@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:aOk6LFgfxGwCNNNRtTfSJynlW+DH523oZ3xosRsIqK8kMnY6vYe
 9yKzrTp/f6fFT8phudFDTjcUUYGoWsLo9vZl/Ono1fd4NcDHlRj7j2JnLIy5QYiTPY27Gb4
 V/uV6vQUlb9n6IyQ/21PqnUozIQokBApBQUEHrTfFbaMOQULz+/Vw7iFgnIGolH/deokaJ3
 1qXA8q1ok/ZKH9VcLx1GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8DFFJ+k1tfg=:EcBITmtkHXCBheyclQTMHh
 TRxrKIt8qGyDDodaO+peuINGJOqw88yZGMYMBZydgprKUCx4g/r7qe82JklBAcA06xrWVtQ/A
 grCNuCVJsdxYL8wnTgZJFKuNdBo+GzP5tg0ZIi+orO4hJLuZBXxMv6m7hFvj/3tZcapimGspE
 8Mc31nNThPCCgHDL3HVYnIaTHg8RA7OJCptck6Zmckp93gQ01gN1oaKpG0ED44PjKhMei5m1H
 z0xfIwn8mk9lhyf8ugHKxTUxyJhWcIUG6A2mXCt0G1qidb4dwzCSquJhHdkIgOhmeBv1WBK4K
 65eHrhGMemz5Y34cj3PwiWY1xmcymHHyFZDUo7AboV4TKmR2Q2QYV81D9ShXai0K6o/GKU2Hl
 vmMcbapCObSEZ7b7blHd0C19azGcZTflef0oPXE0Ck2iT4oMlkhQaro6pFkFaKHHraZEyiMec
 hIK0H6CmM4DBHlmz+2bH+Wugxl4jRj6Nwf5U1EfqN0CGRZlRvP1dc2f8TWzOD4aLhPz+8N+cK
 omUx1EdPMlxC6tIaYasB8B2mEEeDcW57wuAdcSBigZr7t8vu8PREwd0IZgBZiqDq3d4+5AQ0F
 ch0v2nZaHG1DGsjUZ67liE8/Ox2EhMK0FvQtNDPSTX/hxlOtiLH+Qd/mNL9/DR0pX83lg0tw5
 /SfqKYT58LpVu6PS+Y5E3K6SYhsneT6GffO79dxnI5MfxrTr0C18NG4eczbTKIzmcH+T7Y32Y
 8fOtoHEqMlsqGAtihnV6f+2HDx1ksZ2mYMtWA+KHoCHeRTmBFRMgCSOM/GD+eURr0Ai40br0T
 qKOugBaUNox4M38FtZ+UB0xlk0swf7j2/Vuxhve0/y6T8zmjPCYGHIJzYVHgf6IQvEGQSMjgb
 flYcrTwe0PXg6aOlc9j5aMsg1TVICUBN1t3d5kIDxyMtyb1MfxDC5m75oMt60L7c5Swsi0ldI
 iKPeOOx678D6vVZw7MAwvyYj1EJnj+am2i2SxRecqgKFRSWULimKrMXg7yQoB4CHyFwNrYR0n
 0oBBHXfBFGl3gi7ieBY4XvHFN3WTVpHdodvgfEi+SQJMQ3Z4GdzRaA+vUxmie3nn4Ba0HW7x6
 AoOjNOWyfRCG7YpN5sz6Vtbc4W34G694yJCT81BKvNLkyzOwMsmLF3pYe715t5bL7M4TO7Nei
 m49V2SypVXgZSETCtVf6zFFCLVcUMzvB61tjSFSGeweTH5Ag+HdJJE8R6TQ6C4dx6OKG/U+/k
 QuklXUor7cVXRyjnJ
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 01 May 2020 07:15:41 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 01 May 2020 07:15:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking SmPL data processing for enumerations
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

Pj4gQGRpc3BsYXlACj4+IGludCBpOwo+PiBAQAo+PiAgcmV0dXJuCj4+ICogICAgICAgLWkKPj4g
IDsK4oCmCj4+IFdoeSBhcmUgc291cmNlIGNvZGUgcGxhY2VzIHByZXNlbnRlZCB3aGljaCBkbyBu
b3QgY29udGFpbiBhIGtleSB3b3JkCj4+IEkgd2FzIGxvb2tpbmcgZm9yIHRoaXMgdGVzdCBhcHBy
b2FjaD8KPgo+IEkgZG9uJ3Qga25vdy4gIFdpdGggLS1kZWJ1ZyB5b3UgY2FuIHNlZSB0aGF0IHRo
ZXJlIGFyZSBvbmx5IHR3byBtYXRjaGVzLgo+IFNvIG1heWJlIGl0IGlzIGEgcHJldHR5IHByaW50
aW5nIHByb2JsZW0uCgpDYW4gYW5vdGhlciB0aW55IHNvdXJjZSBmaWxlIGV4YW1wbGUgaGVscCBo
ZXJlIGZvciBmdXJ0aGVyIGNsYXJpZmljYXRpb24/CgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUv
Q29jY2luZWxsZS9qYW5pdG9yPiBzcGF0Y2ggc2hvd19yZXR1cm5zX29mX25lZ2F0aXZlX2ludGVn
ZXJzMi5jb2NjaSAuLi9Qcm9iZS9lbnVtLXRlc3QxLmMK4oCmCkBAIC0xLDUgKzEsMyBAQAogaW50
IG15X3Rlc3Qodm9pZCkKIHsKLWVudW0geyB4IH0gZTsKLXJldHVybiAtMTsKIH0KCgpIb3cgY2Fu
IHN1Y2ggYSBzb2Z0d2FyZSBzaXR1YXRpb24gYmUgaW1wcm92ZWQ/CgpSZWdhcmRzLApNYXJrdXMK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFp
bGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9t
YWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
