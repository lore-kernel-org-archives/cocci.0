Return-Path: <SRS0=LIJV=BY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65087C433E1
	for <cocci@archiver.kernel.org>; Fri, 14 Aug 2020 08:50:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB75620639
	for <cocci@archiver.kernel.org>; Fri, 14 Aug 2020 08:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB75620639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07E8oecS029853;
	Fri, 14 Aug 2020 10:50:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E7E997780;
	Fri, 14 Aug 2020 10:50:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D79123C97
 for <cocci@systeme.lip6.fr>; Fri, 14 Aug 2020 10:50:37 +0200 (CEST)
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07E8obVV013216
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 14 Aug 2020 10:50:37 +0200 (CEST)
Received: by mail-lj1-f196.google.com with SMTP id v12so9119656ljc.10
 for <cocci@systeme.lip6.fr>; Fri, 14 Aug 2020 01:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:to:cc:references:from:autocrypt:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=EU/l2DgNP5Q3Y33a0vaqppa+eSULahmyXd3lqONrVV8=;
 b=IrNdM9OaUXKGjXvsOBmM94wtGU7qAR5DpP+ZUfTjI07lnjduGRlgQRivyTMF9rPuYq
 3NE1F8gZAUOn1EOh9P7jBkXt9poRDAHXlHBPSfkMvcpZ8fiheqKMv9ZMUQslEPnl9x59
 2s7csYXxAv5F+V5Iwti7xEmjQMuRnYHH5/sLYsrhJ2H4qSjBei1i5dG+1XSTYsfFkUdk
 aASTlSaxUcyADB5di1uDAUFISptSwZbBKvAlTenCvH64JIwuNVIeje0udYC4l4un55H7
 u0Rqkd78g3I5xt17Hc4c1CdJHKfowQ2HebWy9ZKv4A44PCVecV9Dhz9Gkat1xqnpRc1h
 JEDA==
X-Gm-Message-State: AOAM530DAIn9Cn3T64B+4M+IXD+xQAoSxJf3nF5N01V/Z0cAmChZXzBd
 0lgQvnIwiWSNHGMObS7e8ak=
X-Google-Smtp-Source: ABdhPJwSJpFN7geKb23Bu8pumvCmyLFkpxeYjv3mvRyo5OCsnyKTFvV5E3A/G4MROsjszQcv/645pg==
X-Received: by 2002:a2e:9913:: with SMTP id v19mr844004lji.292.1597395036694; 
 Fri, 14 Aug 2020 01:50:36 -0700 (PDT)
Received: from [10.68.32.147] (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.gmail.com with ESMTPSA id z18sm1635838lja.55.2020.08.14.01.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 01:50:36 -0700 (PDT)
To: Markus Elfring <Markus.Elfring@web.de>,
        Julia Lawall <julia.lawall@inria.fr>
References: <ed9a8046-4c21-e849-f68b-9e08991b701d@web.de>
From: Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Message-ID: <8e76e81f-970b-b1f7-840d-10506dc3311a@linux.com>
Date: Fri, 14 Aug 2020 11:50:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ed9a8046-4c21-e849-f68b-9e08991b701d@web.de>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Aug 2020 10:50:40 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 14 Aug 2020 10:50:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: api: add sprintf() support to
 device_attr_show
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
Reply-To: efremov@linux.com
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

SGksCgpNYXJrdXMsIEkgdGhpbmsgdGhhdCBDQ2luZyBuZXcgcGVvcGxlIGFuZCBzcGFtIHRoZW0g
d2l0aCBtYWlscyB0aGV5CmFyZSBvYnZpb3VzbHkgbm90IGludGVyZXN0ZWQgaW4gZG9lc24ndCBi
cmluZyBhbiBhZGRpdGlvbmFsIHZhbHVlIHRvCnRoZSBkaXNjdXNzaW9uLiBsaW51eC1rZXJuZWwg
YW5kIGNvY2NpIG1haWxpbmcgbGlzdHMgYXJlIGVub3VnaAppbiBteSBvcGluaW9uLiBUaGlzIGFs
c28gd2lsbCBhbGxvdyB1cyB0byBrZWVwICJ0aHJlYWRlZCIgbWFpbApvcmRlci4KCk9uIDgvMTQv
MjAgMTE6MzAgQU0sIE1hcmt1cyBFbGZyaW5nIHdyb3RlOgo+PiBJbnRlcmVzdGluZyBlbm91Z2gg
dGhhdCB3aXRoIHRoaXMgcGF0Y2ggY29jY2luZWxsZSBzdGFydHMgdG8gc2tpcAo+PiBwYXRjaCBn
ZW5lcmF0aW9uIGluIHNvbWUgY2FzZXMuIEZvciBleGFtcGxlLCBpdCBza2lwcyBwYXRjaCBmb3IK
Pj4gZHJpdmVycy9iYXNlL2NvcmUuYyBUaGlzIGlzIGFuIHVuZXhwZWN0ZWQgcmVzdWx0IGZvciBt
ZS4KPiAKPiBXb3VsZCB5b3UgbGlrZSB0byBwb2ludCBxdWVzdGlvbmFibGUgZGlmZmVyZW5jZXMg
Zm9yIHN1Y2ggcGF0Y2ggaHVua3Mgb3V0PwoKV2l0aG91dCB0aGlzIHBhdGNoIHRoZSBzY3JpcHQg
Z2VuZXJhdGVzOgokIHNwYXRjaCAtRCBwYXRjaCAtLW5vLWluY2x1ZGVzIC0taW5jbHVkZS1oZWFk
ZXJzIC0tY29jY2ktZmlsZSBzY3JpcHRzL2NvY2NpbmVsbGUvYXBpL2RldmljZV9hdHRyX3Nob3cu
Y29jY2kgZHJpdmVycy9iYXNlL2NvcmUuYwotLS0gZHJpdmVycy9iYXNlL2NvcmUuYworKysgL3Rt
cC9jb2NjaS1vdXRwdXQtNjM1MTAtMmYxN2ZmLWNvcmUuYwpAQCAtMTcxMyw3ICsxNzEzLDcgQEAg
c3NpemVfdCBkZXZpY2Vfc2hvd191bG9uZyhzdHJ1Y3QgZGV2aWNlCmNoYXIgKmJ1ZikKewpzdHJ1
Y3QgZGV2X2V4dF9hdHRyaWJ1dGUgKmVhID0gdG9fZXh0X2F0dHIoYXR0cik7Ci0gICAgICAgcmV0
dXJuIHNucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLCAiJWx4XG4iLCAqKHVuc2lnbmVkIGxvbmcgKiko
ZWEtPnZhcikpOworICAgICAgIHJldHVybiBzY25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIlbHhc
biIsICoodW5zaWduZWQgbG9uZyAqKShlYS0+dmFyKSk7Cn0KRVhQT1JUX1NZTUJPTF9HUEwoZGV2
aWNlX3Nob3dfdWxvbmcpOwoKQEAgLTE3NDMsNyArMTc0Myw3IEBAIHNzaXplX3QgZGV2aWNlX3No
b3dfaW50KHN0cnVjdCBkZXZpY2UgKmQKewpzdHJ1Y3QgZGV2X2V4dF9hdHRyaWJ1dGUgKmVhID0g
dG9fZXh0X2F0dHIoYXR0cik7CgotICAgICAgIHJldHVybiBzbnByaW50ZihidWYsIFBBR0VfU0la
RSwgIiVkXG4iLCAqKGludCAqKShlYS0+dmFyKSk7CisgICAgICAgcmV0dXJuIHNjbnByaW50Zihi
dWYsIFBBR0VfU0laRSwgIiVkXG4iLCAqKGludCAqKShlYS0+dmFyKSk7Cn0KRVhQT1JUX1NZTUJP
TF9HUEwoZGV2aWNlX3Nob3dfaW50KTsKCkBAIC0xNzY0LDcgKzE3NjQsNyBAQCBzc2l6ZV90IGRl
dmljZV9zaG93X2Jvb2woc3RydWN0IGRldmljZSAqCnsKc3RydWN0IGRldl9leHRfYXR0cmlidXRl
ICplYSA9IHRvX2V4dF9hdHRyKGF0dHIpOwoKLSAgICAgICByZXR1cm4gc25wcmludGYoYnVmLCBQ
QUdFX1NJWkUsICIlZFxuIiwgKihib29sICopKGVhLT52YXIpKTsKKyAgICAgICByZXR1cm4gc2Nu
cHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLCAiJWRcbiIsICooYm9vbCAqKShlYS0+dmFyKSk7Cn0KRVhQ
T1JUX1NZTUJPTF9HUEwoZGV2aWNlX3Nob3dfYm9vbCk7CgpXaXRoIHRoaXMgcGF0Y2ggaXQgZ2Vu
ZXJhdGVzIG5vdGhpbmcuIEkgd291bGQgZXhwZWN0IHNwYXRjaCB0byBnZW5lcmF0ZQphIGRpZmZl
cmVudCBwYXRjaCB3aXRoIHNwcmludGYgaW5zdGVhZCBvZiBzY25wcmludGYsIGJlY2F1c2UgSSB0
aGluayAKLi4uIGlzIGVub3VnaCB0byBtYXRjaCAiKihpbnQgKikoZWEtPnZhcikiLiBFdmVuIGlm
IGl0IGNhbid0IG1hdGNoIHNwcmludGYKcGF0dGVybiBpdCBzaG91bGQgZmFsbGJhY2sgdG8gc2Nu
cHJpbnRmIHBhdHRlcm4uCgo+IFlvdSBwcm9wb3NlIHRvIHVzZSBhIG5lc3RlZCBTbVBMIGRpc2p1
bmN0aW9uIGZvciBkZXNpcmVkIGFkanVzdG1lbnRzLgo+IEkgc3VnZ2VzdCB0byBzdGFydCBhIGNv
cnJlc3BvbmRpbmcgY2FzZSBkaXN0aW5jdGlvbiBiZWhpbmQKPiB0aGUga2V5IHdvcmQg4oCccmV0
dXJu4oCdIGluc3RlYWQgb2YgcmVwZWF0aW5nIGl0IHRocmVlIHRpbWVzLgoKSXQgZG9lc24ndCB3
b3JrLgoKVGhhbmtzLApEZW5pcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBz
Oi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
