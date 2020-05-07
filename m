Return-Path: <SRS0=Oul2=6V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E689BC38A24
	for <cocci@archiver.kernel.org>; Thu,  7 May 2020 16:00:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F68720659
	for <cocci@archiver.kernel.org>; Thu,  7 May 2020 16:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ggtaaFZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F68720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 047G0hSH008598;
	Thu, 7 May 2020 18:00:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E3F30775A;
	Thu,  7 May 2020 18:00:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 839EE3E68
 for <cocci@systeme.lip6.fr>; Thu,  7 May 2020 18:00:40 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 047G0dGg029965
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 7 May 2020 18:00:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588867239;
 bh=qlpY6bM+OS1BmnQ5m6GPXUEKtUlB/PKBvoa42CD/bho=;
 h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
 b=ggtaaFZUyM4Cikn8Wy/PC2a27B2qbnWJpJggmUPQLxWjrRXh0uCJhUjyk/8QxCbZe
 x1UEL6QPzliVIl2qevub1ZJeY+ilq23GzgtJhMTxgYIXuOBvLsNQrmyRK3lkO8x63o
 GT5Oy8A80HKdNbVsIhSk/eXNEnFdH9FBNcumgKbI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.29.220]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRTvU-1jhla31wZE-00Sdyc; Thu, 07
 May 2020 18:00:39 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <60964864-2009-f78e-fd51-307cea4692cc@web.de>
Date: Thu, 7 May 2020 18:00:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:DQr+g0UFfSow5zo0HUgS3rlmK95ytUQmHLrokRwH72o66b2fumc
 gG97y/RTijVYGs4HW7ERLTNCD/Y0Bj3z0qWBsza5E06AFpKlowS1hCqWGSL2+YDWtg6OBi4
 yQJId25uUrbMZ4sNCS2DodP9lhy+8Arw0NuufOijZBuEsxUmzPChPEINeZsnut/34iuOkJX
 qKw5QrOMh+8mN7pXos0dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ueIOlqWYXGM=:rWdoCOrK4Qj8uCAHDpZpdY
 ty/7UymqnKqvpyLmRkNnYBw5Gtasdi2OhwVVF3C/RPr9vov/y7t6jpxzLc/U3q4SeeCFrmzdQ
 g6rWx1COk0c1AX2hJIQXvLh2UND1/XZovittPMwjHR1OiRhaOm07eyp2czPLaPv6cRQod7Bw+
 9LMSeFo0oF+V/JuOSWH5KgnTFtv59o0syPldcJub1YDG2601VQ6p8+O4rU5Y2K8yf2W4dhECz
 /EcVeSmSPA/CoaEuTQIww0ibWyyxN3HJB0IWWP08DZUCa02w++qQoitPKVupC7xgNtsl/8ebf
 DcS5heeqPYjxYFiNC5SrnVWU5lapkeSMR+e3SE0J3sWhj58/LI1t8F5HWJI+J4fQhLh49K+MT
 UwvysKEu4BI9sMsPXejRC/tZ2szw7XxaVq2HXID5N+Kro8hpJ7gfV8eS2Kkly/jY4pw2Ef54J
 QVKwrATByuq6gpAZrmb5mLWTj0W6bDkTOLNmePuQhNdxjIOo3IJYhqbD0Ghe6KiGvtYaXAigL
 3TRxh2xY4yxBbs1/qzCJZmjnZPpmqFjCapPEz1kKBKCD1QcW+Isjo4c+So3hiX8cGn74rrWZF
 8ISLwVbw/EYE9toV/OX+pQHdC213jY2KcSTTHq6BT2R7G3jNLiOkexFOGy5M95IF9cwN03xd4
 mfZWO+7vCoOEW4YS7xCw8gehS72KROlgKm01c69M2RIwUXRd1WLmydcsJhL/YO4ksUhfWHW14
 hHPh+5MB5tJZkZOH6xpi0LNLXpb4v7dvvQqXvpZ8r/ve6Bh+5x588MsHo4sK3/b2QYYuWEQdO
 ZIxrslCfp8sFk1l7jYhGZwM6UvElID0wVDvcXsGrai4V5j9ySGpfIzKy6cb7YFyAlX5LaEDTF
 ccb9ysJD2kuEgk1GGDLZmySUO1x9D3aBEj7IerZ0mOIr3WW/Fj8CBkGOTFhcQ9aXdVHY6BUoN
 wV0A+1qu4kOTIta+nYdbOzQfzdLr69/RIIYYWDZXhtgUqVajeDU1XSAHp6thOqiGqAdWL91KS
 41aOY4XUk0yTXB8e9HpWcJVJKuHmDXLNXvvvkNsmpaohIECd2LNhJDxcKhGP8TbRcFYuKdZ8l
 BdLDXm3NpnHmrpo/dxYc8AlalkvhYtwoABQzBGz3lXgxfjJWa4Bnlpypc9lScA+uct9cf3HUv
 imEjk35acwJxWfJhxNT64dmAHh3fiH9yp6qabXeSJwHMvRZFxM6z/vGl829KYDaKNgbjKXXZu
 gFZDfke3Jl3DEZAvo
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 07 May 2020 18:00:43 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 07 May 2020 18:00:39 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Subject: [Cocci] =?utf-8?q?Checking_an_application_of_the_SmPL_construct_?=
 =?utf-8?b?4oCcPCsuLi4g4oCmIC4uLis+4oCd?=
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgZnVydGhlciBzY3JpcHQgdmFyaWFudHMgb3V0IGZvciB0aGUg
c2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UKKGFjY29yZGluZyB0byB0aGUgc29mdHdhcmUgY29tYmlu
YXRpb24g4oCcQ29jY2luZWxsZSAxLjAuOC0wMDA4Ny1nN2NmMmMyM2XigJ0pLgoKU291cmNlIGNv
ZGUgZXhhbXBsZToKLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQovLyBk
ZWxldGVkIHBhcnQKc3RhdGljIGludCBzY2EzMDAwX3JlYWRfZGF0YShzdHJ1Y3Qgc2NhMzAwMF9z
dGF0ZSAqc3QsCgkJCSAgICAgdTggcmVnX2FkZHJlc3NfaGlnaCwKCQkJICAgICB1OCAqcngsCgkJ
CSAgICAgaW50IGxlbikKewoJaW50IHJldDsKCXN0cnVjdCBzcGlfdHJhbnNmZXIgeGZlclsyXSA9
IHsKCQl7CgkJCS5sZW4gPSAxLAoJCQkudHhfYnVmID0gc3QtPnR4LAoJCX0sIHsKCQkJLmxlbiA9
IGxlbiwKCQkJLnJ4X2J1ZiA9IHJ4LAoJCX0KCX07Ci8vIGRlbGV0ZWQgcGFydAoJcmV0ID0gc3Bp
X3N5bmNfdHJhbnNmZXIoc3QtPnVzLCB4ZmVyLCBBUlJBWV9TSVpFKHhmZXIpKTsKCWlmIChyZXQp
IHsKCQlkZXZfZXJyKGdldF9kZXZpY2UoJnN0LT51cy0+ZGV2KSwgInByb2JsZW0gcmVhZGluZyBy
ZWdpc3RlciIpOwoJCXJldHVybiByZXQ7Cgl9CgoJcmV0dXJuIDA7Cn0KLy8gZGVsZXRlZCBwYXJ0
CgoKU2VlIGFsc286Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMjM2
NzQzLwpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1paW8vMjAyMDA1MDYwMzUyMDYuMTky
MTczLTEtY2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnIvCgoKVGhlIGZvbGxvd2luZyBzZWFy
Y2ggYXBwcm9hY2ggcG9pbnRzIGEgcXVlc3Rpb25hYmxlIHNvdXJjZSBjb2RlIHBsYWNlIG91dAph
cyBleHBlY3RlZC4KCkBkaXNwbGF5QApAQAooZGV2X2Vycgp8ZGV2X2luZm8KKSAgICAgICAoCiog
ICAgICAgIGdldF9kZXZpY2UoLi4uKSwKICAgICAgICAgLi4uCiAgICAgICAgKQoKCmVsZnJpbmdA
U29ubmU6fi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL2phbml0b3I+IHNwYXRjaCBzaG93X2dldF9kZXZp
Y2VfYXNfbWVzc2FnZV9wYXJhbWV0ZXIyLmNvY2NpIC4uL1Byb2JlL3NjYTMwMDAtZXhjZXJwdC0y
MDIwMDUwNS5jCuKApgpAQCAtMTgsNyArMTgsNiBAQCBzdGF0aWMgaW50IHNjYTMwMDBfcmVhZF9k
YXRhKHN0cnVjdCBzY2EzCiAvLyBkZWxldGVkIHBhcnQKIAlyZXQgPSBzcGlfc3luY190cmFuc2Zl
cihzdC0+dXMsIHhmZXIsIEFSUkFZX1NJWkUoeGZlcikpOwogCWlmIChyZXQpIHsKLQkJZGV2X2Vy
cihnZXRfZGV2aWNlKCZzdC0+dXMtPmRldiksICJwcm9ibGVtIHJlYWRpbmcgcmVnaXN0ZXIiKTsK
IAkJcmV0dXJuIHJldDsKIAl9CgoKQnV0IEkgZG8gbm90IGdldCB0aGUgc2FtZSBvdXRwdXQgZm9y
IHRoZSBmb2xsb3dpbmcgU21QTCBzY3JpcHQuCgpAZGlzcGxheUAKQEAKKGRldl9lcnIKfGRldl9p
bmZvCikgICAgICAgKAoqICAgICAgICA8Ky4uLiBnZXRfZGV2aWNlKC4uLikgLi4uKz4KICAgICAg
ICApCgoKSXMgc3VjaCBhIHRlc3QgcmVzdWx0IHdvcnRoIGZvciBmdXJ0aGVyIHNvZnR3YXJlIGRl
dmVsb3BtZW50IGNvbnNpZGVyYXRpb25zPwpEb2VzIHRoZSBhcHBsaWNhdGlvbiBvZiB0aGUgU21Q
TCBuZXN0IGNvbnN0cnVjdCBuZWVkIGFueSBtb3JlIGNsYXJpZmljYXRpb24/Cmh0dHBzOi8vZ2l0
aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvaXNzdWVzLzExNAoKUmVnYXJkcywKTWFya3Vz
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1h
aWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIv
bWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
