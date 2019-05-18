Return-Path: <SRS0=92ax=TU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBB1C04AAC
	for <cocci@archiver.kernel.org>; Mon, 20 May 2019 12:59:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D3320856
	for <cocci@archiver.kernel.org>; Mon, 20 May 2019 12:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="lfdhQmHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D3320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4KCwovU002636;
	Mon, 20 May 2019 14:58:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E59F27741;
	Mon, 20 May 2019 14:58:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 23CA3768D
 for <cocci@systeme.lip6.fr>; Mon, 20 May 2019 14:58:47 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4KCwkJC024979
 for <cocci@systeme.lip6.fr>; Mon, 20 May 2019 14:58:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558357126;
 bh=BOFSm0zAlRJwIlFt0sFLNq72xZrQ0LNetA5bti57zhk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=lfdhQmHQyy1gLFmTidPlfKEjm6eTelk/qtH53LZSDsUEuTwJ54Do3UcsvfW9zCa+b
 puOHLWCVLXNjjIw1tOctaJSisy7csITSVozd6hzCF3WxCac/ZQddg4H8zvM4tuhtu9
 G6hm8AiTC1g7lQSt6+JicEXOVsJsfRc/hXOlO8wE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.133.109.122]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M0hcE-1gfGIB3xKY-00urtQ; Sat, 18
 May 2019 16:43:30 +0200
To: Wen Yang <wen.yang99@zte.com.cn>, Coccinelle <cocci@systeme.lip6.fr>,
        linux-doc@vger.kernel.org
References: <201905171432571474636@zte.com.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6790f1f5-284e-74b2-8b32-6245ba8e5fc2@web.de>
Date: Sat, 18 May 2019 16:43:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905171432571474636@zte.com.cn>
Content-Language: en-US
X-Provags-ID: V03:K1:hvZ/9QgwUIDXJWUUrMezwZYBwbd1Nm3yksCH5XmzfG7bNew7SM1
 /j/P/WXnkI+pic0HXWYVbiRuyEo6hNXgU+FMZVMRmmSHwN86W83ePwZhpzKXO8MgWdguWEF
 yUJzGvFtcODVwWzorWW4yDvy3dkH14O5siecH+7oHAqph62+CUM9IijCIJ/k16Y4+57VEv/
 ryqu/JVGahCyJtRuNr1yQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fjqAeqqGByY=:t+QSnqZa9D+Add/6E0WVoV
 sCbnjefE+9Tv3D+aeOehG8A6axrA5fHn6nIgmXXHWG8vk2YqyzVjM72j1VmDSNsSjxtX+S6LV
 MrNLpfmUV3KABjAxsDn7XZzcW1x9kc7mEaYTe2YO3RmjNFYwhVs/IYB2/EVjoOi2fzvGYHzJM
 nNVnTaKRHpJOIPDoamp3Dg2htbMhONp5fhnFR4V60iYJgliSNBZ1XwTln9u2FbzpOFQFG4Uel
 LJ8pLfimHxkqT7dy8VR58aKRnvB9l9ZZud31imo9Twd2SHmkAfmheOke3vCUmop6dhJHlFS4u
 WDBbuyuiJ5zEkHkBhgYpIIVuwerzip0D+tdMc06lFcF2eav6MjwXleYzUKmbdxbCTpIIZUQCc
 VauaOROa1uj4u/H2YdZ4zUvzvGzvvbhlXZmi8SRDlgF1+S5iF+YAqwt3o0djvN1W5PXSD41NQ
 ZUq3siituiZ0Z8RQ3T2m5AMkESeKm1XgS3yzwnjnE8kE7DXE0QGgg16auReNQcPaqyNvSDUL6
 gWCA/+IwiWtLcAJmo5lSmLvtep0bXqHT6G4oB/U5odasmvWXvXRCjMWG/IdXpkfu0M9246f3Q
 pSPsBmNLlNK2X1kRpa9VNdYo6tlmv46IXQpO1sGCF6zDAZYccFWnJGbPgRHHrKYs5XxwKqGuA
 3vsdoGgKBvU3vC7a9qHewg3bgMbAZLR7Mu4jSDn6kl1t0ly5zihD8wpdHQyTI2JBs8/tplGWK
 LSjf7xkHXPaUAzkkW6tbrCC8Hk8YnNd/JfPj73wkfSviETJni1dL5cbkS9hUE91akMNHPQG1N
 gs+Wxr73WEDV0sttft3p/pfKWUZMGABg9GenxcNJ/bJ7HsrtqudPHf8PCf4rvtg2A9Ba0kWSw
 i4md4jJ0bLo94Y3mlNjkNVSm+iOSsocTkqpwBmXfyR4THxrTTxJlSSBfr4nw0txjRfN/C/FMA
 fdoEQkajN5DtQII2m9tK/AWGF3ZI4Vn9pxW7+slPoen701X+cxUBe
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 20 May 2019 14:58:50 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 20 May 2019 14:58:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] Coccinelle: semantic patch for missing of_node_put
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

PiAkIHNwYXRjaCAtLXRva2Vucy1jIGRyaXZlcnMvb2YvYmFzZS5jICAyPiYxICB8IGdyZXAgIlRh
ZzMgIiB8IGdyZXAgIm9mX25vZGVfcHV0KCkgb24gaXQgd2hlbiBkb25lLiIgfCBhd2sgLUYgIiAt
ICIgJ3twcmludCAkMX0nIHwgZ3JlcCAgLW8gIm9mX1tbOnByaW50Ol1dKiIKClRoaXMgY29tbWFu
ZCBleGFtcGxlIHBvaW50cyBzb21lIGRldGFpbHMgb3V0IGZvciBmdXJ0aGVyIHNvZnR3YXJlIGRl
dmVsb3BtZW50IGNvbnNpZGVyYXRpb25zLgoKMS4gSSBmaW5kIGl0IHF1ZXN0aW9uYWJsZSB0aGF0
IHJlbGV2YW50IGRhdGEgYXJlIHByb3ZpZGVkIGJ5IHRoZSBvdXRwdXQgY2hhbm5lbAogICDigJxz
dGRlcnLigJ0gc28gZmFyLgogICBodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5l
bGxlL2Jsb2IvNjZhMTExOGUwNGE2YWFmMWFjZGFlODk2MjMzMTNjOGUwNTE1OGE4ZC9kb2NzL21h
bnVhbC9zcGF0Y2hfb3B0aW9ucy50ZXgjTDE2NQoKMi4gVGhlIE9DYW1sIGNvZGUg4oCcIlRhZyIg
XiBzdHJpbmdfb2ZfaW50IHQgXuKAnSBvY2N1cnMgaW4gdGhyZWUgc291cmNlIGZpbGVzLgogICAq
IEl0IGlzIGNvbW1lbnRlZCBvdXQgaW4gb25lIGZpbGUuCiAgICAgaHR0cHM6Ly9naXRodWIuY29t
L2NvY2NpbmVsbGUvY29jY2luZWxsZS9ibG9iLzc2MWNmNmExZmJiZjMxNzM4OTZmZjYxZjBlYTdl
NGE4M2E1YjJhNTcvY29tbW9ucy9jb21tb24ubWwjTDMwNQoKICAgKiBUaGVzZSBwbGFjZXMgcmVm
ZXIgdG8gdGhlIHNvdXJjZSBmaWxlIOKAnGR1bXBlci5tbCAxLjLigJ0gYnkgUmljaGFyZCBXLiBN
LiBKb25lcy4KICAgICBUaHVzIGl0IHNlZW1zIHRoYXQgdGhpcyBjb2RlIGlzIHJlbGV2YW50IGF0
IHRoZSBtb21lbnQuCiAgICAgaHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxs
ZS9ibG9iLzE3NWRlMTZiYzdlNTM1YjZhODlhNjJiODFhNjczYjBkMGNkNzA3NWMvY29tbW9ucy9v
Y2FtbGV4dHJhL2R1bXBlci5tbCNMMQoKMy4gSG93IHdpbGwgdGhlIHNvZnR3YXJlIGRvY3VtZW50
YXRpb24gZXZvbHZlIGhlcmU/Cgo0LiBTYWZlIGRhdGEgcHJvY2Vzc2luZyBjYW4gYmUgcGVyZm9y
bWVkIG9ubHkgaWYgdGhlIGludm9sdmVkIHN0cnVjdHVyZXMKICAgd2lsbCByZW1haW4gY2xlYXIg
Zm9yIGEgd2hpbGUuCiAgIElzIHRoZSBzaXR1YXRpb24gcGFydGx5IHVuY2xlYXI/CgogICBTaG91
bGQgdGhlIGluZm9ybWF0aW9uIGFmdGVyIHdoaWNoIGZ1bmN0aW9uIGNhbGxzIHRoZSBmdW5jdGlv
biDigJxvZl9ub2RlX3B1dOKAnQogICBzaG91bGQgYmUgY2FsbGVkIGJlIGRldGVybWluZWQgZnJv
bSBhbnkgb3RoZXIgZG9jdW1lbnRhdGlvbiBmb3JtYXQ/Cgo1LiBBIHByb2dyYW1taW5nIGxhbmd1
YWdlIGxpa2Ug4oCcYXdr4oCdIGhhcyBnb3QgdGhlIHBvdGVudGlhbCB0byBleHRyYWN0IHVzZWZ1
bCBkYXRhCiAgIChhbHNvIHdpdGhvdXQgY2FsbGluZyB0aGUgdG9vbCDigJxncmVw4oCdIGFkZGl0
aW9uYWxseSkuCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5m
cgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
