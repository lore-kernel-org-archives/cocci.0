Return-Path: <SRS0=LZrr=U6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3C5C0650E
	for <cocci@archiver.kernel.org>; Mon,  1 Jul 2019 08:12:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2527F20B7C
	for <cocci@archiver.kernel.org>; Mon,  1 Jul 2019 08:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ovRJxmU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2527F20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x618Br9A002435;
	Mon, 1 Jul 2019 10:11:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D4F3476B2;
	Mon,  1 Jul 2019 10:11:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6C7D26DAB
 for <cocci@systeme.lip6.fr>; Mon,  1 Jul 2019 10:11:52 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x618BjUx026576;
 Mon, 1 Jul 2019 10:11:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1561968678;
 bh=wgDX1wYEOylYk18m/X9V91bM17D7/7B0grmKP0RH4RI=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=ovRJxmU+zGLSVqRgCM3+qCQy5/0fC90h4XIA711H2x6bLkaAVqXfiphbQnGotqq/t
 S4fX4MtkxCp19497Uy1LXQV1tzPtlxgvt9AVUmV1BcZq72qsVwifMzcTMX9EqHMrv3
 Sa9Rpy0KBepky9TOcHJcZC6fqlNhln+4bjILn7vo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.131.202]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwYs7-1ic5t30wL1-018OKI; Mon, 01
 Jul 2019 10:11:18 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2744a3fc-9e67-8113-1dd9-43669e06386a@web.de>
Date: Mon, 1 Jul 2019 10:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:wfhsPM9QVsFV9655wDRYnl6JcqLrm+bTduMbCFrWPgjeIszwlj5
 6cQ7tYKnCVBe5d/7X3gqWwSoJjR+N8TgyuU6JDkqDw7RRulp2MO4QV2VCersbve6Q9yknG4
 zNv/llKZ70DNezmuS+YiDcb6ldkyl4lVej0AFpMDAwKPAtT7SDpFY88aVNXmOfEG88plWRb
 d64rxkDp/zarEqF1kib6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VJ9EqWNcCfE=:xcrWN+c5Q1lkXIi+blKidM
 7emyeKe8pUAJAg9juycx57x1X7C55esQopZ/Mw5uH+MEFQOzH4mfjpTwIwSl/QtWmdH5hx22J
 lX85S40KZu6CfOU6GJ8mV4QyL2MuQY8y7aOArOxuYVwMebk7n6CWCu04/jwK5VTD+x83upLG4
 D+avZBX8FfjjKZ4bqQ/Vpk1IO2uPVgcMJ9YA1jA9VBkgVxO9jIQ0XbX8sWSpnkIUsFaTSBbsP
 Q55T8ZbCmBi5jmJ15QeSCZdHSKK3O68TuHue4okh6VO39LbloNn09wQcsw09BvsM9OiYL/8CH
 hERPuQadlkr6pnN8jRDraK1a5y3cWuea4FEc1hhoTXP9MxmFQR2cOCbFjqp17uUIuVSuq7gA3
 bAnOc6lKTN0o5tvpxTRjIi+1354Y8bGSqiz8bLtZoCLFeBjAkIGH5YZliSnkUKM/xl1GQoLax
 vzqtl9K3eUI65cM9P8B2VLj6+quJdiWYorTrqd8616+fZVlHe2m27jJz1U1ufkO9sKdxNAVso
 ApvNW7NJqJpbcqCzuSjs0oob9wYl1fVtNf99bIPKR3Iom1oBFGdXMdDOG200Tc2SwHwRSwWAr
 2DTja7Si+kmOPoQ7EMMd5KBeIrLXfsgNVa6YbdOt1KaLL3tHGj0IvxnkqjjHOOAU7i0qK6Io6
 a43D+UHDgYUk0WiuILzVOyTkPIIqeLugqHxMk+50sxHlqIUO+2myDsQUQBd1qpdFRmO9DWL+F
 zHfkyJLrU7R+rLNj7kDIPYjkCjdGhIuuFsxQ+T1dOEbOZDMsVeEriKTC9YNr9G9T5XPZASYTP
 l0VxHDKS8emXk3+EQzreCOITyIXsBGnIxmAvfsj+yfyojaRgiM40ZN0lOPOqbX8SnS2GjhWU5
 cRG5M9Sx0OLvhm/XkCQvWVCMMEeCla7FipRAR30yW6c+l4q7mb0djp9XWxPSy2G17X30Pdteb
 7O4+chsq6fuorkqNnrCQEjJHS+Zjnnp7M0oy2k9KH0FDV2w2QusovSTB535c/mFsZaRo36HvX
 0rHQAWHbXmjK6XN0nJGIkVS5ZJ0EnD8bN6id10jka6jmysh3HIIgQe6aAptFFGV2ixQ5UPMEL
 zFQdvrLTMXsyDMSPAm7eQWcsRoan4ItHQTI
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 01 Jul 2019 10:12:06 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 01 Jul 2019 10:11:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [Cocci] [PATCH v2] Coccinelle: Add a SmPL script for the
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
OiBNb24sIDEgSnVsIDIwMTkgMTA6MDA6MzkgKzAyMDAKClRoZSBmdW5jdGlvbiDigJxkZXZtX2lv
cmVtYXBfcmVzb3VyY2XigJ0gY29udGFpbnMgYXBwcm9wcmlhdGUgZXJyb3IgcmVwb3J0aW5nLgpU
aHVzIGl0IGNhbiBiZSBxdWVzdGlvbmFibGUgdG8gcHJlc2VudCBhbm90aGVyIGVycm9yIG1lc3Nh
Z2UKYXQgb3RoZXIgcGxhY2VzLgoKUHJvdmlkZSBkZXNpZ24gb3B0aW9ucyBmb3IgdGhlIGFkanVz
dG1lbnQgb2YgYWZmZWN0ZWQgc291cmNlIGNvZGUKYnkgdGhlIG1lYW5zIG9mIHRoZSBzZW1hbnRp
YyBwYXRjaCBsYW5ndWFnZSAoQ29jY2luZWxsZSBzb2Z0d2FyZSkuCgpTaWduZWQtb2ZmLWJ5OiBN
YXJrdXMgRWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+Ci0tLQoKdjI6ClN1
Z2dlc3Rpb25zIGZyb20gSnVsaWEgTGF3YWxsIHdlcmUgaW50ZWdyYXRlZC4KCiogQXBwbGljYXRp
b24gb2YgdGhlIFNtUEwgY29uc3RydWN0IOKAnDwrLi4uIOKApiAuLi4rPuKAnQoqIFJlcGxhY2Vt
ZW50IG9mIGEgcmV0dXJuIHNwZWNpZmljYXRpb24gYnkgYSBzdGF0ZW1lbnQgbWV0YXZhcmlhYmxl
LgoqIERpZmZlcmVudCBjb2Rpbmcgc3R5bGUgZm9yIGEgYnJhbmNoIG9mIGEgU21QTCBkaXNqdW5j
dGlvbi4KKiBVc2FnZSBvZiBhIHNwZWNpZmljIGZ1bmN0aW9uIG5hbWUgaW4gdHdvIG1lc3NhZ2Vz
LgoKIC4uLi9jb2NjaW5lbGxlL21pc2MvcmVkdW5kYW50X2Rldl9lcnIuY29jY2kgICB8IDYyICsr
KysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspCiBjcmVh
dGUgbW9kZSAxMDA2NDQgc2NyaXB0cy9jb2NjaW5lbGxlL21pc2MvcmVkdW5kYW50X2Rldl9lcnIu
Y29jY2kKCmRpZmYgLS1naXQgYS9zY3JpcHRzL2NvY2NpbmVsbGUvbWlzYy9yZWR1bmRhbnRfZGV2
X2Vyci5jb2NjaSBiL3NjcmlwdHMvY29jY2luZWxsZS9taXNjL3JlZHVuZGFudF9kZXZfZXJyLmNv
Y2NpCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uNzk5OGRlZmIwNGYz
Ci0tLSAvZGV2L251bGwKKysrIGIvc2NyaXB0cy9jb2NjaW5lbGxlL21pc2MvcmVkdW5kYW50X2Rl
dl9lcnIuY29jY2kKQEAgLTAsMCArMSw2MiBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAKKy8vLyBSZWNvbnNpZGVyIGEgZnVuY3Rpb24gY2FsbCBmb3IgcmVkdW5kYW50IGVy
cm9yIHJlcG9ydGluZy4KKy8vCisvLyBLZXl3b3JkczogZGV2X2VyciByZWR1bmRhbnQgZGV2aWNl
IGVycm9yIG1lc3NhZ2VzCisvLyBDb25maWRlbmNlOiBNZWRpdW0KKwordmlydHVhbCBwYXRjaAor
dmlydHVhbCBjb250ZXh0Cit2aXJ0dWFsIG9yZwordmlydHVhbCByZXBvcnQKKworQGRpc3BsYXkg
ZGVwZW5kcyBvbiBjb250ZXh0QAorZXhwcmVzc2lvbiBlOworQEAKKyBlID0gZGV2bV9pb3JlbWFw
X3Jlc291cmNlKC4uLik7CisgaWYgKElTX0VSUihlKSkKKyB7CisgPCsuLi4KKyogICBkZXZfZXJy
KC4uLik7CisgLi4uKz4KKyB9CisKK0BkZWxldGlvbiBkZXBlbmRzIG9uIHBhdGNoQAorZXhwcmVz
c2lvbiBlOworc3RhdGVtZW50IHM7CitAQAorIGUgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoLi4u
KTsKKyBpZiAoSVNfRVJSKGUpKQorKAorLXsKKy0gICBkZXZfZXJyKC4uLik7CisgICAgcworLX0K
K3wKKyB7CisgPCsuLi4KKy0gICBkZXZfZXJyKC4uLik7CisgLi4uKz4KKyB9CispCisKK0BvciBk
ZXBlbmRzIG9uIG9yZyB8fCByZXBvcnRACitleHByZXNzaW9uIGU7Citwb3NpdGlvbiBwOworQEAK
KyBlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKC4uLik7CisgaWYgKElTX0VSUihlKSkKKyB7Cisg
PCsuLi4gZGV2X2VyckBwKC4uLik7IC4uLis+CisgfQorCitAc2NyaXB0OnB5dGhvbiB0b19kbyBk
ZXBlbmRzIG9uIG9yZ0AKK3AgPDwgb3IucDsKK0BACitjb2NjaWxpYi5vcmcucHJpbnRfdG9kbyhw
WzBdLAorICAgICAgICAgICAgICAgICAgICAgICAgIldBUk5JTkc6IEFuIGVycm9yIG1lc3NhZ2Ug
aXMgcHJvYmFibHkgbm90IG5lZWRlZCBoZXJlIGJlY2F1c2UgdGhlIGRldm1faW9yZW1hcF9yZXNv
dXJjZSgpIGZ1bmN0aW9uIGNvbnRhaW5zIGFwcHJvcHJpYXRlIGVycm9yIHJlcG9ydGluZy4iKQor
CitAc2NyaXB0OnB5dGhvbiByZXBvcnRpbmcgZGVwZW5kcyBvbiByZXBvcnRACitwIDw8IG9yLnA7
CitAQAorY29jY2lsaWIucmVwb3J0LnByaW50X3JlcG9ydChwWzBdLAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiV0FSTklORzogQW4gZXJyb3IgbWVzc2FnZSBpcyBwcm9iYWJseSBub3Qg
bmVlZGVkIGhlcmUgYmVjYXVzZSB0aGUgZGV2bV9pb3JlbWFwX3Jlc291cmNlKCkgZnVuY3Rpb24g
Y29udGFpbnMgYXBwcm9wcmlhdGUgZXJyb3IgcmVwb3J0aW5nLiIpCi0tCjIuMjIuMAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBs
aXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFu
L2xpc3RpbmZvL2NvY2NpCg==
