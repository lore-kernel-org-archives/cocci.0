Return-Path: <SRS0=lxNs=I6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA8FC433B4
	for <cocci@archiver.kernel.org>; Thu,  1 Apr 2021 17:22:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088CA613D6
	for <cocci@archiver.kernel.org>; Thu,  1 Apr 2021 17:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088CA613D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 131HMfYa022955;
	Thu, 1 Apr 2021 19:22:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E000E77D5;
	Thu,  1 Apr 2021 19:22:40 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2F6C374DE
 for <cocci@systeme.lip6.fr>; Thu,  1 Apr 2021 19:06:58 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 131H6v0g019384
 for <cocci@systeme.lip6.fr>; Thu, 1 Apr 2021 19:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1617296813;
 bh=XYf7n2m1vMaq18YPl46NJXOEKKTpWrcyKL6V4x87rIk=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=skfzINvU/jtXNV1CVhKQ0ZP9zkD94PF4aYxc0SGDEw+UcBv9MSMXNrrgGhGmtXqg6
 dqz/8Zub/UxihOW+TXGqwy28rdjwsXLvh4VuAMM84ZZRQD5wBzmu/VPwvnd9rWNjBB
 L5sx0NvDgGxap6Zzd8LXmIApRbKtHmAiHqqdLEis=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.30.68]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQt6E-1l39KF1L4g-00UGiv; Thu, 01
 Apr 2021 19:06:53 +0200
To: Michael Walle <michael@walle.cc>
References: <acfc6d2f0a7ea90f451de6d1185a0383@walle.cc>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <0120175b-d322-3841-54c4-3699e1570343@web.de>
Date: Thu, 1 Apr 2021 19:06:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <acfc6d2f0a7ea90f451de6d1185a0383@walle.cc>
Content-Language: en-GB
X-Provags-ID: V03:K1:i/+i7bj32akT8Y/E/gRHNl7NJRwLIGAxrL13cQ2CWpt8QtsAR0J
 mQ4QhALETj+bq0GpksSWbKMbOttF8/gosWwbZqAcww9IsOc0NyScWjkmFJmaHbpe+IvMFF5
 9V8FKIEFmyB8tUr7hoQuDm+GnAAtG0WN2C+vg0iizZwQsdrF8oP3dLI8qtOJqywJFLbCoWg
 B7a5n1uVjtmugxknqvoMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QCN8g8Li7RI=:zpkbIk3klPoozeOvGoeF1C
 +33Im4Nu2+N+aqH3W/YFiGTqxx5erT4kfMuMS28G8vS+8Gu+kpvv966tsMLZsOwV5n3ly7PQw
 blNluwlw44/dRPvCzOv3K3LIwTxhi8MhpHcMKyu9aJkqkapmycNfKZKuRejPfwwCAZNMZKr05
 YbXHy1iVSMOx/Hw5iTeQeZ1yGrCeFulmf0Tr0E5yYEuox+y97XPUbLnOhUZ8ABI2p4XOEML4F
 W7ZHHmnd++2Fa0fHsxoKdibDU5TkhNXUOOJpujvPMqWNez+Dxs0TMG6CMmXOOkgzxUKxa6JMD
 kKuJgQbVgblbm6iuvSmyFbKJQwRPpL5dKZLq7G7oHuO5D2eGzbD0lcou4qDCTqLI2wEiXyY9V
 CPork0uMaqfG+cIoWCd4l0O8noI5MkT1480FaL/eZcKVlke9wQuX9Zgi/N5iJF8rci+VCH99V
 nQUujWLaJSamYZt2Ldr1Fk/nedWYTui3iZ/mXqeFkY6K3a/Zm6mc2DqTOwul0axU4fxelgo5k
 rvuQW9sb2sPsXw37n05ExyFtVkTURIQ2NmRDmILiRP83oHHFSkptmpnPq1svs02/Mhu72vDaJ
 3wUSgLJzLXoGWbkSDvNsoP5IbZ2xXwLogvjEI+LQL4MJ7NXE06/TcUBYRGZBOuJZGwk9YRDnK
 uY1f2/+t6seYb7CLuaFs+P/PDspWzogGm69bow9EHUfZo7vYzTsR0z1KR53TRiqqMXX5iSb5v
 Tm+I7JPg7AmdKHh23Ewu29a3XEdURkBW/WC95iroZYt2wmCdNAjz6+tZ0JqlBlAcNfMUEI1N9
 G8nTu0gbrRaD2XMIPnQlBQ1f9Td/+c96oFRE6u2l9uQCT71kXGaZdEsI59R4lWFD/KKn8ed5z
 4Se2rKSZUN9ZFk/L3R3jS5K1sDIYudmsjfqhOh+F+DBXxXuG/cDoF7lET48wBvIA+mivZPwAN
 SxHgqqeQZ9E/oHisN6Jfmnm65EyQ/QUZITIMMDz2YhHfaqIFSuakBZvFeYnaawdOab89VKanR
 sW9r5pkQjOGdosE6ym67uxRBAXzneQ7FVJmFZ5nhDdwmTFTUO2MX3uQ0Cifh2axaQtXfyKBOi
 vnfdXBm/RwQpsp0ldlPA7+LvrQP9h3PBEDgby1L66do2YsATmrx/Ynwj7fKcSFmW2ySsTvSit
 w6lXVP/UQaOCjujqFRYiBuPc+wqc9VYA4olq7xxhbBlqcpi1/HwgssaiLifg/yTJHWbY8=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 01 Apr 2021 19:22:41 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 01 Apr 2021 19:06:57 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 01 Apr 2021 19:22:38 +0200
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] changing of_get_mac_address() to pass a buffer
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

PiAgICBtYWMgPSBvZl9nZXRfbWFjX2FkZHJlc3MobnApOwo+ICAgIGlmICghSVNfRVJSKG1hYykp
Cj4gICAgICBldGhlcl9hZGRyX2NvcHkobmRldi0+ZGV2X2FkZHIsIG1hYyk7Cj4KPiBUaGlzIHdv
dWxkIG5lZWQgdG8gYmUgY2hhbmdlZCB0bzoKPgo+ICAgIG9mX2dldF9tYWNfYWRkcmVzcyhucCwg
bmRldi0+ZGV2X2FkZHIpOwoKQ2FuIHN1Y2ggYSBmdW5jdGlvbiBjYWxsIHZhcmlhbnQgZmFpbD8K
CkhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdGFrZSBhbnkgc3BlY2lhbCByZXR1cm4gdmFsdWVzIGlu
dG8gYWNjb3VudD8KCgo+IE1heWJlICh3ZWxsIEknbSBzdXJlKSB0aGVyZSBpcyBzb21ldGhpbmcg
dG8gaW1wcm92ZSBoZXJlLgoKSSBzdWdnZXN0IG9uY2UgbW9yZSB0byBncm91cCBhbm90aGVyIGJp
dCBvZiBTbVBMIGNvZGUgbGlrZSDigJwrIHJldF90YmQgPSDigKbigJ0KYnkgdXNpbmcgbmVzdGVk
IFNtUEwgZGlzanVuY3Rpb25zIHNvIHRoYXQgZHVwbGljYXRlIHNwZWNpZmljYXRpb25zIGNhbiBi
ZSByZWR1Y2VkLgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYu
ZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
