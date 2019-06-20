Return-Path: <SRS0=bY14=UT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12CEC43613
	for <cocci@archiver.kernel.org>; Thu, 20 Jun 2019 17:31:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37A42064B
	for <cocci@archiver.kernel.org>; Thu, 20 Jun 2019 17:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="CX69ecUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37A42064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5KHVdqi001830;
	Thu, 20 Jun 2019 19:31:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E0AE97781;
	Thu, 20 Jun 2019 19:31:38 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B55A57778
 for <cocci@systeme.lip6.fr>; Thu, 20 Jun 2019 19:31:37 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5KHVYhJ015459;
 Thu, 20 Jun 2019 19:31:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1561051860;
 bh=6ABCqgrNckGfVod4g9nc/CDSQ2u7KfwMvXsjxDVsW30=;
 h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
 b=CX69ecUjPnw98oDiByjF3qiqCoEzQF2Ef/WLv/fNgCBQAFZGfUOProFX6YP1no0dR
 ygp5NyuEAbsf/IEKcoqWuRzsfSq54x2ij9Fi922LrMB8ZF/lNGmQEatYFfTmSHn9+5
 O/vCtDTSE70KcUCGNjCrD5OijWYY4of2tJxT59bs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.128.109]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUEoU-1i3pDy1Z3a-00R3Y2; Thu, 20
 Jun 2019 19:31:00 +0200
To: kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
Date: Thu, 20 Jun 2019 19:30:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:vFxa6NtbOwXDi9mrX1xEx5OTYjttZSWjmZO5m1ggnwUeVy6wgxl
 PxePf3+FKdpeV421gsigNFcSUAdLU4bYE0StXPbWzgN1xn7lBHkVX3aK39y37ULkh2aDTsx
 gerFcvcTp9OWZf+oz9t/70jDbU2nvDCpvYymEjh0c7saJ2TLFu/H4MwFa8t14uYgxqu1LgK
 5RBcGI+dCUEIym+m6qbCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7SZlVwwQ3oo=:EmlzmEkN1ccmaUVQgaAL5g
 nYR3/mavvQzq8rAEs2Y7ltsYUDNXatKZdiEAfjTi/aiD7o2cmq8NSBSIf1IkZVkoJ0h186RgQ
 /CRo3GdUa2Db+Fr0BIGzvM55dvQ76yexEtt5UFK+avDdVALcP99Vafca8d0WgjaG8++BYaCJi
 aHLvagxMit+XyBhNyhMVNt3YXJXoptE+PuU+WWYe177En2P2B1prPSYEGhTPduWZamuwKop6n
 pb+dOVJobfQeTnwRUtgwKj1KzDqp9HR/egrcAlb1j4/N5Fndy1y4IM6wTRKsyxM6RLByT7kDA
 S0NWrL2MEKvURIDQ1JNY2G+Tf2DDrWrtlCKRAxpPIXq+kOgjqFRQfyU4dg6MWhc+T39BERvq8
 alKBjt++3/BszKTFGcAVM9qZ6qj5gTSBLPUkFySi2MVuZAs/vSkX6B3FCJFMKWD2ltSxPUydM
 Z7np5TaBKHf7jSPNB3MW2XpyswSKGJpa6f8rUXVX8lLk7VM2bEtmymo0YgWmtK0iTI7sX1rHp
 RcJoarzDurTw7MudN9PI5iVsKvDJun2254xj0jlPNHLZhFUoj1A22zH0OSCOeIkYwBYcGGNi1
 dePzOVRIxenuXJ0TwGO8xnb2X4d7cjbhymrL2QrCDVizT49KP+ish00ITYL/T0qG6NPmMlt0V
 H1AZaFbaqvbnYnNHhmlNLisdnMGUE2VtOYcLDUGnx/zrlImMHuWUoFn92s9LXjVsGzK+gmAB0
 OTSAhN2BSpc1FkwSmU287DrmjYTJ/v3y6w9qP9gBAg/EsYXRuYKIEdWhkJQ+Vv1Jbo7qty/vT
 fO9xfXy+zmnHARF6FU6pSEyJ/1nJ7+j9rr4VBiHGeWzNya2CiJljOKdWOwrat9ZPBmvqg9tkZ
 Ggt3Z7axqAjnzNixTRl7vX+/3bFnjquvNmKX2diM2wgLBDJGgKiq/LmGeOssjZVdsEH14TfBn
 7bMC1woixJNLjsNvLevW0SqW0+xsKX7x31PKhAEA6i2wUGAA71zjU
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 20 Jun 2019 19:31:40 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 20 Jun 2019 19:31:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [Cocci] [PATCH] Coccinelle: Add a SmPL script for the
 reconsideration of redundant dev_err() calls
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

RnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0PgpEYXRl
OiBUaHUsIDIwIEp1biAyMDE5IDE5OjEyOjUzICswMjAwCgpUaGUgZnVuY3Rpb24g4oCcZGV2bV9p
b3JlbWFwX3Jlc291cmNl4oCdIGNvbnRhaW5zIGFwcHJvcHJpYXRlIGVycm9yIHJlcG9ydGluZy4K
VGh1cyBpdCBjYW4gYmUgcXVlc3Rpb25hYmxlIHRvIHByZXNlbnQgYW5vdGhlciBlcnJvciBtZXNz
YWdlCmF0IG90aGVyIHBsYWNlcy4KClByb3ZpZGUgZGVzaWduIG9wdGlvbnMgZm9yIHRoZSBhZGp1
c3RtZW50IG9mIGFmZmVjdGVkIHNvdXJjZSBjb2RlCmJ5IHRoZSBtZWFucyBvZiB0aGUgc2VtYW50
aWMgcGF0Y2ggbGFuZ3VhZ2UgKENvY2NpbmVsbGUgc29mdHdhcmUpLgoKU2lnbmVkLW9mZi1ieTog
TWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0PgotLS0KIC4uLi9j
b2NjaW5lbGxlL21pc2MvcmVkdW5kYW50X2Rldl9lcnIuY29jY2kgICB8IDUzICsrKysrKysrKysr
KysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAx
MDA2NDQgc2NyaXB0cy9jb2NjaW5lbGxlL21pc2MvcmVkdW5kYW50X2Rldl9lcnIuY29jY2kKCmRp
ZmYgLS1naXQgYS9zY3JpcHRzL2NvY2NpbmVsbGUvbWlzYy9yZWR1bmRhbnRfZGV2X2Vyci5jb2Nj
aSBiL3NjcmlwdHMvY29jY2luZWxsZS9taXNjL3JlZHVuZGFudF9kZXZfZXJyLmNvY2NpCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uYWViMjI4MjgwMjc2Ci0tLSAvZGV2
L251bGwKKysrIGIvc2NyaXB0cy9jb2NjaW5lbGxlL21pc2MvcmVkdW5kYW50X2Rldl9lcnIuY29j
Y2kKQEAgLTAsMCArMSw1MyBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAK
Ky8vLyBSZWNvbnNpZGVyIGEgZnVuY3Rpb24gY2FsbCBmb3IgcmVkdW5kYW50IGVycm9yIHJlcG9y
dGluZy4KKy8vCisvLyBLZXl3b3JkczogZGV2X2VyciByZWR1bmRhbnQgZGV2aWNlIGVycm9yIG1l
c3NhZ2VzCisvLyBDb25maWRlbmNlOiBNZWRpdW0KKwordmlydHVhbCBwYXRjaAordmlydHVhbCBj
b250ZXh0Cit2aXJ0dWFsIG9yZwordmlydHVhbCByZXBvcnQKKworQGRpc3BsYXkgZGVwZW5kcyBv
biBjb250ZXh0QAorZXhwcmVzc2lvbiBlOworQEAKKyBlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNl
KC4uLik7CisgaWYgKElTX0VSUihlKSkKKyB7CisqICAgZGV2X2VyciguLi4pOworICAgIHJldHVy
biAoLi4uKTsKKyB9CisKK0BkZWxldGlvbiBkZXBlbmRzIG9uIHBhdGNoQAorZXhwcmVzc2lvbiBl
OworQEAKKyBlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKC4uLik7CisgaWYgKElTX0VSUihlKSkK
Ky17CistICAgZGV2X2VyciguLi4pOworICAgIHJldHVybiAoLi4uKTsKKy19CisKK0BvciBkZXBl
bmRzIG9uIG9yZyB8fCByZXBvcnRACitleHByZXNzaW9uIGU7Citwb3NpdGlvbiBwOworQEAKKyBl
ID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKC4uLik7CisgaWYgKElTX0VSUihlKSkKKyB7CisgICAg
ZGV2X2VyckBwKC4uLik7CisgICAgcmV0dXJuICguLi4pOworIH0KKworQHNjcmlwdDpweXRob24g
dG9fZG8gZGVwZW5kcyBvbiBvcmdACitwIDw8IG9yLnA7CitAQAorY29jY2lsaWIub3JnLnByaW50
X3RvZG8ocFswXSwKKyAgICAgICAgICAgICAgICAgICAgICAgICJXQVJOSU5HOiBBbiBlcnJvciBt
ZXNzYWdlIGlzIHByb2JhYmx5IG5vdCBuZWVkZWQgaGVyZSBiZWNhdXNlIHRoZSBwcmV2aW91c2x5
IGNhbGxlZCBmdW5jdGlvbiBjb250YWlucyBhcHByb3ByaWF0ZSBlcnJvciByZXBvcnRpbmcuIikK
KworQHNjcmlwdDpweXRob24gcmVwb3J0aW5nIGRlcGVuZHMgb24gcmVwb3J0QAorcCA8PCBvci5w
OworQEAKK2NvY2NpbGliLnJlcG9ydC5wcmludF9yZXBvcnQocFswXSwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIldBUk5JTkc6IEFuIGVycm9yIG1lc3NhZ2UgaXMgcHJvYmFibHkgbm90
IG5lZWRlZCBoZXJlIGJlY2F1c2UgdGhlIHByZXZpb3VzbHkgY2FsbGVkIGZ1bmN0aW9uIGNvbnRh
aW5zIGFwcHJvcHJpYXRlIGVycm9yIHJlcG9ydGluZy4iKQotLQoyLjIyLjAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApD
b2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0
aW5mby9jb2NjaQo=
