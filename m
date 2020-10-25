Return-Path: <SRS0=peAA=EA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BC4C55178
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 18:08:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C3D21D41
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 18:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="huO8svaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C3D21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09PI7Zf6025713;
	Sun, 25 Oct 2020 19:07:35 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DC8BF5C18;
	Sun, 25 Oct 2020 19:07:34 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 95BF95C16
 for <cocci@systeme.lip6.fr>; Sun, 25 Oct 2020 19:01:57 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09PI1ukG028728;
 Sun, 25 Oct 2020 19:01:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603648916;
 bh=iqy4o6YfquIxaB0+GMWusviUzCJIjs+m9L0EE9RRdug=;
 h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
 b=huO8svaTSInhHsm731/pmRbQl/cmTnSB875pCz89G1MMD1vym4RAL5u86j7CMsp6s
 jl31yu0dpz9cgebP7v/tNRvllS564zft+YGnfyPYw/+fdmFhh8ZSBJHU2DAN43VsjG
 KslACaDhCX21WzyprC7NudN2jV+43HcL/G+XMaqo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.86.219]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ljrdd-1jzKGY42RN-00bpsa; Sun, 25
 Oct 2020 19:01:56 +0100
To: Coccinelle <cocci@systeme.lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <0d1575b0-ab37-663e-2464-278fd76280b5@web.de>
Date: Sun, 25 Oct 2020 19:01:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:5VxykiUR45zIuPWW+EEzbaysBrmfDYz204zJI224TkiJboNzrFo
 Stx5f9nmWQ/EMyTshSclfQ2QmfwdUS80di8PdBZWzKzmuPERxQiZRUnjyN6zpcC1rO/ZIWl
 EOyCIU1zRhHSy8ShQr7V0znXpZcx9wjpsEiD+9bYjopidm51ySiuUI+3GKPF2pK6fjPdEMV
 oLGT2q3ECyRBeC/RfmoUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A4ztN/ZqAbk=:X8T4FNlacD/cttMTMWsVAk
 4pC3OFxPgTnh3hElw+jkiN7ivLW6Ol/8tAIPzpQ7CsvUaEwobYvGmCtI70Ce+1nUNB0KdZr92
 LWnyQstY4jJIJThs+0r+rL5b5lV4z5PRQQhLvUNv34LD2QSJpjMr3c4UQQejr4YZ0jcfTpy2C
 309SrsW2FMIeBh0VDy2Bo6WH6RdsNLP2dY3nmxkra5USMTIYkVsdr6c0CTFz/+DByfaDqtN28
 43fx9jnYw4f3Ngw2WqQqVBDP8QuVC9LzggrTzFsor7dI2uCtnXBU6bYqudbyWdPTgwDlX07bB
 GargWAKcMZqlGhDd5WAzdvCyMr05bLi8e3ZBPfQyHc9o9MiI75HpLvZN0AXiMl6XrgFT1yQCT
 e7cMv/Mm5rRvxWS3D+YRAZ+ZVHr2jE1NERl7PJzkf5Bh9IZcuvNUZvjygy0jsVkSiQ//oQoxh
 KJ0BJRbZAKHpk3NbtBphEc5d6k9EAX49zfrLQNYc62otsn4nhNF+d6tNTCLb6X1ZCyE34sZZ9
 +J8A3RCELvbmkTjaPOwFRh9aabgghjbjRTTKDzyY2ednxI9PJoREWsZdg8L0Tichk88VIfVQc
 mEmJMxht5wghpBT4IbGrFnPvTWWEZ3iiVZH58cuGkC9IlGQr7ktsQphhf3/3GdBN2PcEfybEh
 xRE3/24tnNrjvKQfXojdTfc+t3O1Gz9XnF8gC8vZc/vgpUVUFPDPgdXiwhOqqKQr4pBD+fybH
 wvnQQF0TTz53GWeJTd8W9VVltp4TKNc3QZhDdtDbE5NNHoxzNrp6IdMcgluhNkv5xvPqrlzoc
 XimpEBu8kqem4NbwkFLBOJVQQ6LxZ7GXs7GI2Ao0g8j7exae3yjr1LR1jWjXOvag57vYE4BgJ
 +Z5LiQX9Vd009C82Guzg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Oct 2020 19:07:35 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Oct 2020 19:01:57 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 25 Oct 2020 19:07:33 +0100
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Cocci] =?utf-8?q?=5BPATCH=5D_Coccinelle=3A_null=3A_Optimise_disj?=
 =?utf-8?b?dW5jdGlvbnMgaW4gU21QTCBzY3JpcHQg4oCcZW5vLmNvY2Np4oCd?=
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
OiBTdW4sIDI1IE9jdCAyMDIwIDE4OjU0OjM2ICswMTAwCgpBIGRpc2p1bmN0aW9uIGlzIGFwcGxp
ZWQgYnkgdGhpcyBzY3JpcHQgZm9yIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZS4KVGhpcyBj
b25zdHJ1Y3QgdXNlcyBzaG9ydC1jaXJjdWl0IGV2YWx1YXRpb24uIEl0IGhhcyBnb3QgdGhlIGNv
bnNlcXVlbmNlCnRoYXQgdGhlIGxhc3QgZWxlbWVudCBvZiB0aGUgc3BlY2lmaWVkIGNvbmRpdGlv
biB3aWxsIG9ubHkgYmUgY2hlY2tlZAppZiBhbGwgcHJldmlvdXMgcGFydHMgZGlkIG5vdCBtYXRj
aC4gU3VjaCBhIHRlY2huaWNhbCBkZXRhaWwgbGVhZHMgdG8KYSByZWNvbW1lbmRlZCBvcmRlcmlu
ZyBvZiBjb25kaXRpb24gcGFydHMgaWYgeW91IHdvdWxkIGxpa2UgdG8gY2FyZSBmb3IKb3B0aW1h
bCBydW4gdGltZSBjaGFyYWN0ZXJpc3RpY3Mgb2YgU21QTCBjb2RlLgoKQW4gdXNhZ2UgaW5jaWRl
bmNlIHdhcyBkZXRlcm1pbmVkIGZvciB0aGUgc3BlY2lmaWVkIGlkZW50aWZpZXJzIGluIHNvdXJj
ZQpmaWxlcyBmcm9tIHRoZSBzb2Z0d2FyZSDigJxMaW51eCBuZXh0LTIwMjAxMDIz4oCdIGJ5IGFu
b3RoZXIgU21QTCBzY3JpcHQuCgpTZWUgYWxzbzoKRGV0ZXJtaW5hdGlvbiBvZiBhbiB1c2FnZSBz
dGF0aXN0aWMgZm9yIG1lbW9yeSBhbGxvY2F0aW9uIGNhbGxzCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2NvY2NpLzI3NzQ2MDEudTkxc0lGTnkxRUBzb25uZS8KClRoaXMgYW5hbHlzaXMgcmVzdWx0
IGluZGljYXRlcyBhIGNsZWFyIHJhbmtpbmcgZm9yIHN1Y2ggZnVuY3Rpb24gY2FsbHMuClRodXMg
cmVvcmRlciB0aGUgU21QTCBkaXNqdW5jdGlvbiBpdGVtcyBhY2NvcmRpbmcgdG8gdGhlaXIgdXNh
Z2UgaW5jaWRlbmNlLgoKU2lnbmVkLW9mZi1ieTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNl
cnMuc291cmNlZm9yZ2UubmV0PgotLS0KIHNjcmlwdHMvY29jY2luZWxsZS9udWxsL2Vuby5jb2Nj
aSB8IDE1ICsrKysrKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc2NyaXB0cy9jb2NjaW5lbGxlL251bGwvZW5v
LmNvY2NpIGIvc2NyaXB0cy9jb2NjaW5lbGxlL251bGwvZW5vLmNvY2NpCmluZGV4IDgxNTg0ZmY4
Nzk1Ni4uOTY5Y2FiNTExNmE5IDEwMDY0NAotLS0gYS9zY3JpcHRzL2NvY2NpbmVsbGUvbnVsbC9l
bm8uY29jY2kKKysrIGIvc2NyaXB0cy9jb2NjaW5lbGxlL251bGwvZW5vLmNvY2NpCkBAIC0xNyw4
ICsxNywxNiBAQCB2aXJ0dWFsIHJlcG9ydAogQGRlcGVuZHMgb24gcGF0Y2hACiBleHByZXNzaW9u
IHgsRTsKIEBACi0KLXggPSBcKGttYWxsb2NcfGt6YWxsb2NcfGtjYWxsb2NcfGttZW1fY2FjaGVf
YWxsb2NcfGttZW1fY2FjaGVfemFsbG9jXHxrbWVtX2NhY2hlX2FsbG9jX25vZGVcfGttYWxsb2Nf
bm9kZVx8a3phbGxvY19ub2RlXCkoLi4uKQorIHggPQorKGt6YWxsb2MKK3xrbWFsbG9jCit8a2Nh
bGxvYworfGttZW1fY2FjaGVfYWxsb2MKK3xrbWVtX2NhY2hlX3phbGxvYworfGt6YWxsb2Nfbm9k
ZQorfGttYWxsb2Nfbm9kZQorfGttZW1fY2FjaGVfYWxsb2Nfbm9kZQorKSguLi4pCiAuLi4gd2hl
biAhPSB4ID0gRQogLSBJU19FUlIoeCkKICsgIXgKQEAgLTI3LDggKzM1LDcgQEAgeCA9IFwoa21h
bGxvY1x8a3phbGxvY1x8a2NhbGxvY1x8a21lbV9jYWNoZV9hbGxvY1x8a21lbV9jYWNoZV96YWxs
b2NcfGttZW1fY2FjaGUKIGV4cHJlc3Npb24geCxFOwogcG9zaXRpb24gcDEscDI7CiBAQAotCi0q
eCA9IFwoa21hbGxvY0BwMVx8a3phbGxvY0BwMVx8a2NhbGxvY0BwMVx8a21lbV9jYWNoZV9hbGxv
Y0BwMVx8a21lbV9jYWNoZV96YWxsb2NAcDFcfGttZW1fY2FjaGVfYWxsb2Nfbm9kZUBwMVx8a21h
bGxvY19ub2RlQHAxXHxremFsbG9jX25vZGVAcDFcKSguLi4pCisqeCA9IFwoa3phbGxvY0BwMVx8
a21hbGxvY0BwMVx8a2NhbGxvY0BwMVx8a21lbV9jYWNoZV9hbGxvY0BwMVx8a21lbV9jYWNoZV96
YWxsb2NAcDFcfGt6YWxsb2Nfbm9kZUBwMVx8a21hbGxvY19ub2RlQHAxXHxrbWVtX2NhY2hlX2Fs
bG9jX25vZGVAcDFcKSguLi4pCiAuLi4gd2hlbiAhPSB4ID0gRQogKiBJU19FUlJAcDIoeCkKCi0t
CjIuMjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
Q29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUu
bGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
