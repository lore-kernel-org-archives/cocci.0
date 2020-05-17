Return-Path: <SRS0=PP4e=67=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E51AC433E0
	for <cocci@archiver.kernel.org>; Sun, 17 May 2020 08:15:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBAD82065F
	for <cocci@archiver.kernel.org>; Sun, 17 May 2020 08:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Jk7yGXsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAD82065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04H8FdHe025893;
	Sun, 17 May 2020 10:15:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2D7AB7740;
	Sun, 17 May 2020 10:15:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EE9083DC8
 for <cocci@systeme.lip6.fr>; Sun, 17 May 2020 10:15:37 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04H8Fabd008090
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 17 May 2020 10:15:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589703336;
 bh=jHp04UI2zFngre2of8XEeuxezocK5KSKYzs024sdUt0=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=Jk7yGXsTjGxAo/p9JDzfF8f+4qrtydJ61DeS8f1cbH9T861qwM61kfkreOkh484bW
 wuZpp3Q3PYv1laFdPB9C9YCpLdwR8qvKigebI5IlXfWRj7JkvIngJdmZ46Xx9qEuSS
 B3amquf7R+loxgYqeY0Vj2ebAOQ7pvFKy3AMEC0I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.172.144]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqqTb-1jEJtx0Jgv-00msgV for
 <cocci@systeme.lip6.fr>; Sun, 17 May 2020 10:15:36 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <64e05245-c387-b50c-bb6f-9609d0b0aad8@web.de>
Date: Sun, 17 May 2020 10:15:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:8vIwsxRr2tiybt5mK9MNFFTBUCRWp+qVR1MqUslwBRW2KAzti4O
 ej8pFuEcVtZZUmfaqvOk5yN7anvmuLoOIZW/aWawuoCa7VzSNdi2HXO7vv7cHYmohUYhGXH
 Tzf2BlXQJcg05LFABfmxgwHSCIlXvmKgKmReIpL+6TcsfGlqtOgLR22fkgPWSVmCo1rr9CL
 dEJNQ/m+t9ZZcqhrNuVQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0YOR+U8ovMA=:N0tnWxgxkJ+JGsY/ctyEvj
 GmTYyh+8Hz0Mq+rzjH55sWVssiaYHNGaPFCNtFHnkbbC6w+8H9i7sVLIrsf9BhJr398kRmmI0
 hBpafpKBn3hUXIIx92t3HGdk0rKCGO35vfZ+Nuy+h5wjvf1nw5XE8HTrJKjFax5vwW9Mo4B4u
 hvFlVleJAkqqnGZX1DVdr/Wz+gB+t/vQ/Qj5oGoL66Iy4/YHlC4UwBlUU9PiaJ7GSnuNiQhsv
 508TzrfwPm4IXHwKoeJ3XMQ2kA1oeMFCljrE8OvnJN7SOb6w2kKfX6I53WobZvgeeF8I+3l6R
 uqmNATRxJKKSQhK1GD2dtZv5Eiu/6J/SdcYKGZyAD5aXoewHuq4qb5k2Z/t7bgJcVfVzhCAdh
 XHOVNs5nhKzA4dh34MHWq1QWH468K3GvgRAbPtnKS5FxvGEN1LSrLlbIIqoBfaqNcDFdxQbRe
 V50eQkqiuojhdpWCzTKCENNoWk19fodihAoW5OuskqVhJpPRr5jGowxjlrQ3Sm6NrWj+KRhkm
 fovwpM79ICsFHRFqTWKneyP6Wd5K79H/t0vV31nRA2IUFGWjpDmdqsgkovNahMf1GI0r+nIpV
 731OumJ4ZsbtpLd9tfR+E8xVkFYm4CYft+Lcpj60m1h9P/leGD/aUmQe+EOUI9DUWzKOAyAt5
 35JjNB0S1B31BeUHU/ktzZntu1GstThCmj2CfPMfAv5neIQPegThCdR9190aw9IdeM+V2368Z
 xvzzZIrypf/ZXk/hQKdUtwSumeSysSjgAYXSoE9H9f9S6r1uYHgoOhIzfY7S2fweHxfVC0xq8
 1fNg2uOpwNrXmYZDRxO52N4Ngy/V2JiNEnRiaWbT48uN+ujJ04g6HrZ+xA+E85tx7Z/ZCTFuj
 Ux5GAGknfNkm1AyHOfRHOT4jlB6GYO8EBN0VjZv3msQsMmye/xG4xd7YYhc1CdIfIi6AvptWo
 g0/NHfAn7dQjk02eHBGRqlGCMDItxcqaW45LsE+SqUTTKE8g7XEU1AxWHFGPhYQPxMeUMTA+F
 KnaYIvqqtpy4ZsSUgAGWmYUcD8FiDgaLdJrhWAvQ/CgkvjIV4hR01M1dUgNSXjp+mk8HSM0LV
 paxwk9H2pp7iUDeVnsKtKMPnmo8uT5Ea9Sp7oVaTlKP3Gc2dhrexfAnZMS6vl9d5DNBoN5SEZ
 Aa7pkFVtqLrMYBddvP+XlUuW///o/+HIQirlHuhXvLFAb2uOyijEE4DV4jCtpel24ntUn9nwX
 a3Gy9P3f48y7IX/BH
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 17 May 2020 10:15:39 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 17 May 2020 10:15:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] =?utf-8?q?Support_for_multi-line_=E2=80=9Cwhen_code?=
 =?utf-8?b?4oCdIGJ5IFNtUEw/?=
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

SGVsbG8sCgpUaGUgbWFudWFsIGZvciB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UgcHJvdmlk
ZXMgdGhlIGZvbGxvd2luZyBpbmZvcm1hdGlvbi4KaHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVs
bGUvY29jY2luZWxsZS9ibG9iLzdjZjJjMjNlNjQwNjZkNTI0OWE2NGEzMTZjYzUzNDc4MzFmN2E2
M2YvZG9jcy9tYW51YWwvY29jY2lfc3ludGF4LnRleCNMMTEyMgoK4oCmCiAgIHdoZW4gOjo9IHdo
ZW4gIT0gd2hlbl9jb2RlCuKApgogICB3aGVuX2NvZGUgOjo9IE9QVERPVFNFUShkZWNsX3N0bXQr
LCB3aGVuKQogICAgICAgICAgICAgICB8IE9QVERPVFNFUShleHByLCB3aGVuKQrigKYKICAgT1BU
RE9UU0VRKGdyYW1tYXJfZHMsIHdoZW5fZHMpIDo6PQogICAgICAgIFsuLi4gKHdoZW5fZHMpKl0g
Z3JhbW1hcl9kcyAoLi4uICh3aGVuX2RzKSogZ3JhbW1hcl9kcykqIFsuLi4gKHdoZW5fZHMpKl0K
4oCmCgoKVGhlIHBvc3NpYmxlIGNvbnRlbnQgaXMgbm90IGV4cGxhaW5lZCBmb3IgdGhlIGl0ZW0g
4oCcZ3JhbW1hcl9kc+KAnSBzbyBmYXIuCkV4YW1wbGVzIHNob3cgdGhhdCBzb3VyY2UgY29kZSBt
YXkgYmUgc3BlY2lmaWVkIHRoZXJlIHdoaWNoIHNob3VsZCBwcm9iYWJseQpiZSBleGNsdWRlZCBm
cm9tIGEgdGV4dCBmcmFnbWVudC4KaHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2lu
ZWxsZS9ibG9iL2VkMWViOGUwNmY4MDA3MzlkMzk5MjE1OGQzNjk0NWMwYzRjNmYwYzcvZG9jcy9t
YW51YWwvZXhhbXBsZXMudGV4I0wzMjgKCkl0IGlzIHN1cHBvcnRlZCB0byBzcGVjaWZ5IHRoZSBT
bVBMIGtleSB3b3JkIOKAnHdoZW7igJ0gb24gc2VwYXJhdGUgbGluZXMuCkkgZ290IHRoZSBpbXBy
ZXNzaW9uIHRoYXQg4oCcZ3JhbW1hcl9kc+KAnSBjb2RlIG5lZWRzIHRvIGJlIHNwZWNpZmllZCBv
bmx5CmluIHRoZSBzYW1lIGxpbmUgc28gZmFyLiAoQSBsaW5lIGJyZWFrIGlzIHRyZWF0ZWQgYXMg
dGhlIGZpbmFsIGRlbGltaXRlcgpmb3IgdGhpcyB1c2UgY2FzZS4pCkRhdGEgcHJvY2Vzc2luZyBj
YW4gd29yayBhbHNvIHdpdGggbG9uZyBsaW5lcy4KCiogSSBpbWFnaW5lIHRoYXQgZGV2ZWxvcGVy
cyAoYW5kIHJldmlld2VycykgZm9yIHNlbWFudGljIHBhdGNoIGNvZGUKICB3b3VsZCBvY2Nhc2lv
bmFsbHkgcHJlZmVyIHRvIHVzZSBtdWx0aS1saW5lIHRleHQgYXQgc3VjaCBwbGFjZXMuCgoqIEkg
aW1hZ2luZSBhbHNvIHRoYXQgaXQgY2FuIGJlIGhlbHBmdWwgdGhlbiB0byBlbmNsb3NlIHRoZSDi
gJx3aGVuX2NvZGXigJ0KICBieSBzcGVjaWZpYyBkZWxpbWl0ZXJzIHNvIHRoYXQgdGhlIHNlcGFy
YXRpb24gb2YgdGV4dCBwYXJ0cyB3b3VsZCBiZQogIGNsZWFyZXIgYW5kIGhvcGVmdWxseSBzYWZl
ci4KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBz
Oi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
