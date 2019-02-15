Return-Path: <SRS0=7OsK=QW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E8BC43381
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 13:16:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83482218AC
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 13:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dDsQjdCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83482218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1FDFlXN009093
          ; Fri, 15 Feb 2019 14:15:47 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2575C76FA;
	Fri, 15 Feb 2019 14:15:47 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1371776F7
 for <cocci@systeme.lip6.fr>; Fri, 15 Feb 2019 14:15:45 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1FDFhPe023884
 ; Fri, 15 Feb 2019 14:15:43 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1550236531;
 bh=xqkyQ+YhG5IqJCO4gSCu7q1tZ2UIAef868u8p1HzH04=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=dDsQjdCt55z37szTlXstGMmrKUB5hkYt7NVWyFZP+jiBB9Iclfrbwc6a52yjwtDcC
 AGAKLa0bjFtgVvTpuzDq3T4gL5sUUO1Wss+XENjlcNQleDg/1lHeFkne/0ERPaRWip
 W9duPp/h3ZXIIQySIM59btnRPRM7VLQDHHYAszdU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.88.109]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lvk56-1h8oAB0Mhw-017X9n; Fri, 15
 Feb 2019 14:15:31 +0100
To: Julia Lawall <julia.lawall@lip6.fr>, Wen Yang <wen.yang99@zte.com.cn>
References: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn>
 <94e4b3e6-87a4-aea2-dfef-44d308f0fb4f@web.de>
 <alpine.DEB.2.20.1902151400440.3617@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a35e9d4a-1166-c794-732e-3e7ec0063c77@web.de>
Date: Fri, 15 Feb 2019 14:15:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1902151400440.3617@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:Esi0larYL4GME7EMUpqfWayflZrM9B9Kdmqq0fUcDQG4gav0fDS
 U9Zcm5hM5uVlGqldg3Ofq2beQujym5k75sKfj8VGmys7WzCWtVT9JegAytfE/LBaxaPAlBk
 EXPfsxSJQWRUoMWDqVSFJzBDjv09BbVsQfufqVV5PSI0q8xLl41LjYCX2/p7cvR5JuM9sI+
 aEIwA6pOLENWbg7Am0dcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sFvCHeveDVQ=:wpzg85xMtWAdToon0XaHZt
 xfjS1l+W/1a/DCEuYfmffF5ZhQQriVKgwFpMRmX/lda4MlIweUXyonfGkk/vL/Ti80Qc+H5Ky
 6vb1E87Th6T1EjV9LSTz6gPoqdeCkm8QSNRF7p2nqqZqxA1AVkvkEOiKB+AWDVf8bBdK/HKgP
 ayeMW0/G2/zj7WkXgYPgP+e8cVTnTDdPh7Mng71OlTR7hivp4Bax+L1179rWzqNq0Q3rr8Ixl
 M/uOxhU7/Y2MVkMTPuauBd4u/p9PKnAypeXhZss+Wu6a9W6lhZ+QPXb+OjKpSoJT0BGvICFQb
 t66bClnqI7qXTEEjtt2SZctDsIONa5OyMyB46eHrglj8qfZxU4CGsXNEUIzQU8/bUqIuAfLlL
 EtnxvEwaHdJAJxvlEKcLCdnzF8nNl1XhH3iLd5rkRR/cAsGjcWd19HAZPPkOxNRFKT7RXXv0P
 6e31yyTNqNVe8uEGV2uyN+suEaQgyDXpGiVJ+lm0aYCYTm/AcP/AMLg3ILqfgy31K6SyD3Gwz
 YPWb/iUwhDdhBI1AIm0DL/ANIZb3XwzjWN5X2sZDz0ZzEmHbjFItutWrL+ekQUZ8M8ead3FEP
 Mx5BTeyqyIvy4ZuKIB62b/yvDaOWP8lgscYZbtgtFmj7AvYvKrGCrMPL+IwT4eixyMhvree31
 FLcIX4Ne7en2jgZSD9IUApCIPvgbD1DtZtFuiChn0rQsHz929sSy+Ojm3pxNd/9oU7Vxjj3Yo
 KiUd1SdpB3r89bqJjluBXqmCAsxq31tV/9WphyCkRoQeSDrCUEp9UFoZFe2Y8hi2yxDL67KQ+
 XWybAmS1Ye7sN+p26oc/P8BJQ6lQciJbESS+wRGr7jsPxR1tFqwTJJz+Jrlsf0EJGXXlj/wBo
 UNukSj3+1k21440bHr29TDGlyy+Z2UodBXKxYTs9aH1zURKrQXwRmGxJhQX75xAmjeXQpCRw0
 cn7SJPycL9g==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 15 Feb 2019 14:15:47 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 15 Feb 2019 14:15:43 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, kernel-janitors@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [v5] Coccinelle: semantic code search for missing
	put_device()
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

Pj4+ICtpZCA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGVAcDEoeCkK4oCmCj4+PiAraWYgKGlkID09
IE5VTEwgfHwgLi4uKSB7IC4uLiByZXR1cm4gLi4uOyB9Cj4+PiArLi4uIHdoZW4gIT0gcHV0X2Rl
dmljZSgmaWQtPmRldikKPj4g4oCmCj4+PiArICAgIHdoZW4gIT0gaWYgKGlkKSB7IC4uLiBwdXRf
ZGV2aWNlKCZpZC0+ZGV2KSAuLi4gfQo+PiDigKYKPj4KPj4gSSB3b3VsZCBpbnRlcnByZXQgdGhp
cyBTbVBMIGNvZGUgaW4gdGhlIHdheSB0aGF0IHRoZSBpZiBzdGF0ZW1lbnQKPj4gZm9yIHRoZSBw
b2ludGVyIGNoZWNrIGlzIOKAnG9wdGlvbmFs4oCdIGluIHRoaXMgbGluZS4KPj4gSXMgaXQgYW4g
ZXh0cmEgYW5kIHJlZHVuZGFudCBTbVBMIHNwZWNpZmljYXRpb24gd2hlbiB0aGUgcmVmZXJlbmNl
Cj4+IHJlbGVhc2UgZnVuY3Rpb24gY291bGQgZXZlbnR1YWxseSBiZSBmb3VuZCBqdXN0IGFueXdo
ZXJlIHdpdGhpbgo+PiBhbiBpbXBsZW1lbnRhdGlvbj8KPgo+IFRoZSBwcm9wb3NlZCB3aGVuIGNv
ZGUgaXMgY29ycmVjdC4KCkkgYWdyZWUgdGhhdCB0aGlzIFNtUEwgY29kZSBjYW4gd29yayBpbiB0
aGUgd2F5IGl0IHdhcyBkZXNpZ25lZC4KCgo+IEl0IGlzIG5vdCByZWR1bmRhbnQsIGJlY2F1c2Ug
aXQgY2hlY2tzIGZvciBhIHBhcnRpY3VsYXIgY29udHJvbC1mbG93IHBhdHRlcm4uCgpJdCB0b29r
IGFub3RoZXIgbW9tZW50IHVudGlsIEkgZGFyZWQgdG8gZXhwcmVzcyBhIGRpZmZlcmVudCBzb2Z0
d2FyZQpkZXZlbG9wbWVudCBvcGluaW9uIGFsc28gb24gdGhpcyBpbXBsZW1lbnRhdGlvbiBkZXRh
aWwuCgpEb2VzIHRoZSBmaXJzdCBTbVBMIHdoZW4gc3BlY2lmaWNhdGlvbiBpbmNsdWRlIHRoZSBj
YXNlIHRoYXQgYSBjYWxsCm9mIHRoZSBmdW5jdGlvbiDigJxwdXRfZGV2aWNl4oCdIGNhbiBvY2N1
ciB3aXRoaW4gYSBicmFuY2ggb2YgYW4gaWYgc3RhdGVtZW50PwoKUmVnYXJkcywKTWFya3VzCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxp
bmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFp
bG1hbi9saXN0aW5mby9jb2NjaQo=
