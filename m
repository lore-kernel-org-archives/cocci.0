Return-Path: <SRS0=3aZu=7I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD3FC433DF
	for <cocci@archiver.kernel.org>; Tue, 26 May 2020 06:01:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8112071A
	for <cocci@archiver.kernel.org>; Tue, 26 May 2020 06:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gg7C6xfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8112071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04Q616FL021697;
	Tue, 26 May 2020 08:01:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id ECD867783;
	Tue, 26 May 2020 08:01:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 550C23E8A
 for <cocci@systeme.lip6.fr>; Tue, 26 May 2020 08:01:04 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04Q613CO008586
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 26 May 2020 08:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590472863;
 bh=64Jq0dyMdab0hqJshP0lJT915OFqWX9HqoVDeQaJNEE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=gg7C6xfjPXKj56VOR0dcsXzXg4FKkqkRGIZ43ImCZuKQXJcGNzz33eYsmsi1GNuwp
 fuUiTaaoBDiEp5KQ+wgqs5kSvknFJGWcRhaBzKR4YP+j1QwDQqCz+Er3GhoYTavIh1
 wra8gt2naoEAMEWIY9nx0ZwwBfULgNRBbzPJywuc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.141.233]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJCWU-1jbp123p9e-002nN2; Tue, 26
 May 2020 08:01:03 +0200
To: Thomas Adam <thomas@xteddy.org>
References: <24b3f013-21e4-99e8-5366-cfc944077cc2@web.de>
 <CAOhcEPY8r2fjJmJP4A6ZzFdhTGJB=RYVcVt8k6KV9EaMzc_oSQ@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6e21d3ff-0c5f-dc63-1058-e73aab052bda@web.de>
Date: Tue, 26 May 2020 08:00:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAOhcEPY8r2fjJmJP4A6ZzFdhTGJB=RYVcVt8k6KV9EaMzc_oSQ@mail.gmail.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:DnXrZ+P+Z2pwk3px/Pb6KUv5UakV5mwcBrqhgXHWxWmXG1y8d1V
 ZI0wjJ5qLKQgJyqhI7cj7hEx1STTk9I5b4VFrMIT6QSjl3zuQegpy7XBjErIqGaGTzVBM2H
 MKw8yChxtAbxaTKLDV6o2D/kp6PlKwsQCdH0Ap0F1wmkP+kN3mn9RklnHBIlAajiyto0hAe
 78wruAr+keT0+QTcyjYgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:up7R729li1Q=:pTAUj6ITdBNJMpgQKC3C8h
 RwL9aUMkspSPO4rfl0MI0Vzs+6u7QiwbY/rZs9mV7IJVFta34uNAFm0bwH+0WlZYWA8Olj4A+
 nHbMvDYBpUVlMSqP0myzYOWITXR3lzl9ZpQARKshdtCdz/75lGDDbRGhfCOnKNgieBhWjrwsl
 54+MQQkrlZrENnURasZGwB4t1gX0aNxSKwSvrr8IJl/DOUzdxk27Bxs46UUfBWMy+OAL6bZM7
 o0tUqsIYjm7xxOX1FZxz1Mgn/nmYrYvkiFemlmlO7T99s9ve2wvfqvVcaB9fK78TO+hhgFAlQ
 fORf76Ptj1hbu9HlfNAyXALTt9Iuj0twZbiPA5ln90ZBicko90Yn902u82E3MgdqdWK5T54gw
 gUJshFIJKtFEjHa+Wr7qF25XeredJKY/E8ZkB5CklcrPkJ+Jc+ytJsDtqMxk8h9/r/Vc3vK8Y
 8qhzvuJi4YzpWXagFb3aCLsFujpIoEEDQJ8fgK73f9P3YNuBx2lGNF4QFNY9OQITJnRwc/ZSJ
 50OWNjLMLxoGA1E6gHZa4r3vmMKuY8sBDY+ZPx1dNNKCwzrsHI6ZCkE92QgSlAPXXNLuLJM0z
 3PLv9Au5Yz/3SXZb504JjsDGUMaCcZ2GPIQLtP07+rxlgQVVg1zZbJv+NtX03XwNQOKoOrOp8
 t2z2EphkTJriSLftSZ2fAqZi2S7K/BKaHPmvc4kVwkKkwdOGdyr/yAkkat4d8QwcgdmRppbku
 jDmuZFGy7s4W8hy5/iSZBe6gcPSNVcY5enrqGe3qXhYPje8YW9AJ7YwRJUqFSA9+3vY14+g4r
 m0i+maDrUwE28c/DTZtQWSWA5lgv2QPXFmosl9fskOsCeICa5VWkLpiTOsUTKiGkoK3Je8BEB
 70YVMA6HYYsdQADhkSl8DFhZq9NmMvlZgkCF8PYF5wmqGd3xVqzm0xd+oW0b3pywTS4cQFE6m
 /zEyWDB1aQeVuEVF8k6egKbTxdFbxo8mJGc4GVxCK4/jYE3RAgp5Kv1wnOjax+FGoVXo33mkk
 6JI/yRWq+ojE8nYub+vxEqcu1225rvIll+vIgrSrdQEsEih7JLWGwaiCcDwiP+1zaP6aBdkrs
 WWdziMts2kZcUMYCKiVvrGncitt9o40zGqvndYlXKPq9zV1rGaKi+DILDLAQoLoCsTZ0IKVRG
 RH4Gz4GcQDMtuen7hDNe3bKDLEl2mjW6O7wNXnmQh2jw42xgSX02DwDNb6visz7a09dz/S/9M
 z4qehcHGTmhgcaiL1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 26 May 2020 08:01:06 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 26 May 2020 08:01:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Using SmPL scripts to mangle function arguments
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

PiBmdW5jX29sZChfX2Z1bmNfXywgICIlczogaGVsbG86ICVkLCAlZCIsIG15dmFyLCB4LCB5KTsK
Pgo+IEknbSBoYXZpbmcgdHJvdWJsZSBleHByZXNzaW5nIG15IHNtUEwgdG8gdW5kZXJzdGFuZCB0
aGUgZWxsaXBzZXMgY29ycmVjdGx5LgoKVGhpcyBjYW4gYmUgdXN1YWwuCgoKPiBIZXJlJ3Mgd2hh
dCBJIGhhdmUgc28gZmFyOgo+Cj4gQEAKPiBleHByZXNzaW9uIEwsIEY7Cj4gQEAKPgo+IC0gZnVu
Y19vbGQoTCwgRiwgLi4uKTsKPiArIGZ1bmNfb2xkKF9fZnVuY18sIC4uLik7Cj4KPiAuLi4gYnV0
IGhlcmUsIHRoaW5ncyBmYWxsIGFwYXJ0Ogo+Cj4gaW5pdF9kZWZzX2J1aWx0aW5zOiAvdXNyL2Jp
bi8uLi9saWIvY29jY2luZWxsZS9zdGFuZGFyZC5oCj4gRmlsZSAiY29udHJpYi9jb2NjaW5lbGxl
L3JlbW92ZV9kZWJ1Zy5jb2NjaSIsIGxpbmUgNiwgY29sdW1uIDIxLCBjaGFycG9zID0gNjgKPiAg
IGFyb3VuZCA9ICcuLi4nLAo+ICAgd2hvbGUgY29udGVudCA9ICsgZnVuY19vbGQoX19mdW5jX18s
IC4uLik7Cj4KPiBBbnkgaWRlYXMgb24gd2hhdCBJJ20gZG9pbmcgd3Jvbmc/CgpZZXMuCgpJIGhv
cGUgYWxzbyB0aGF0IHNvbWUgZXJyb3IgbWVzc2FnZXMgZnJvbSB0aGUgQ29jY2luZWxsZSBzb2Z0
d2FyZSBjYW4gYmVjb21lCm1vcmUgaGVscGZ1bC4KCgo+IElmIHRoZXJlJ3MgYXBwcm9wcmlhdGUg
ZG9jdW1lbnRhdGlvbiBvbiB0aGlzLCBwbGVhc2UgZmVlbCBmcmVlIHRvIHBvaW50IG1lIHRvd2Fy
ZCBpdC4KCkhvdyBkbyB5b3UgZmluZCB0aGUgYXZhaWxhYmxlIGRlc2NyaXB0aW9ucyBpbiB0aGUg
c2VjdGlvbiDigJw0LjEgIEJhc2ljIGRvdHPigJ0/Cmh0dHA6Ly9jb2NjaW5lbGxlLmxpcDYuZnIv
ZG9jcy9tYWluX2dyYW1tYXIwMDQuaHRtbCNzZWM2CgoKPiBJIGZlZWwgYXMgdGhvdWdoIEknbSBt
aXNzaW5nIHNvbWV0aGluZyBvYnZpb3VzIGhlcmUsIHNvIHRoYW5rcyBmb3IgeW91ciB0aW1lCj4g
YW5kIGZvciBhbnkgaGVscCB5b3UgY2FuIGdpdmUuCgpUaGUgU21QTCBlbGxpcHNpcyByZWZlcnMg
dG8gdmFyaWFibGUgYW5kIHVua25vd24gc291cmNlIGNvZGUuCllvdSB0cmllZCBhIHNpbXBsZSBj
aGFuZ2Ugc3BlY2lmaWNhdGlvbiBvdXQgd2hpY2ggZXhwcmVzc2VzIHRoYXQgYSBzcGVjaWZpYwpm
dW5jdGlvbiBjYWxsIHNob3VsZCBiZSBhZGp1c3RlZCBpbiB0aGUgc2FtZSBsaW5lLgpCdXQgaG93
IGNhbiBhbnl0aGluZyBiZSByZWFkZGVkIHdoZW4gdGhlIGNvbnRlbnQgaXMgdW5rbm93bj8KCkkg
c3VnZ2VzdCB0byBpbmNyZWFzZSB0aGUgcHJlY2lzaW9uIGZvciB0aGUga25vd24gY2hhbmdlIGFz
cGVjdHMgbGlrZSB0aGUgZm9sbG93aW5nLgoKQHJlcGxhY2VtZW50QApleHByZXNzaW9uIEwsIEY7
CkBACi1mdW5jX29sZAorY3VycmVudF9mdW5jCiAgICAgICAgICgKLSAgICAgICAgIEwsIEYKKyAg
ICAgICAgIF9fZnVuY19fCiAgICAgICAgICAsIC4uLgogICAgICAgICApCgoKUmVnYXJkcywKTWFy
a3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2Np
IG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYu
ZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
