Return-Path: <SRS0=onlg=DE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABF2C4346E
	for <cocci@archiver.kernel.org>; Sun, 27 Sep 2020 13:25:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3E9207F7
	for <cocci@archiver.kernel.org>; Sun, 27 Sep 2020 13:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hoXywVjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3E9207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08RDPYJu001552;
	Sun, 27 Sep 2020 15:25:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0986F5F8F;
	Sun, 27 Sep 2020 15:25:34 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AA0A84316
 for <cocci@systeme.lip6.fr>; Sun, 27 Sep 2020 15:21:38 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08RDLc0J015158
 for <cocci@systeme.lip6.fr>; Sun, 27 Sep 2020 15:21:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1601212897;
 bh=mCidSruVyTI6/vglJiSCAVUUoRlxn8hWIdtkfxPEW3w=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=hoXywVjsI0vdKWEH5cBaU/aGLKtJHaTf7hKgxpUQh/7jZ6qeiMLDk6uiXx5HiFceu
 rUHBaXbmchbEDKkk3oWxSTqTrPYoE6ZJj0Cs3EabignpfjDHOsthJ4rxd7yjFSGGap
 0vQm1V0UI1aNMfvCCqt3zkC0paD20OTs6PW9bwRE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.138.181]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LqDUa-1krATh3EtU-00dps6 for
 <cocci@systeme.lip6.fr>; Sun, 27 Sep 2020 15:21:37 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1aee7040-5189-120f-e587-87a99c64cc82@web.de>
Date: Sun, 27 Sep 2020 15:21:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:Vlf1Opz9FvlJCeMYlPcHb2nzEXCJuXNJbMOCn/OGOmLuylsVN+3
 fAknGVfTDcHeBJ/CZdWbZZCOQba4P4moOxek5g7WH5L9/Zh8+Onlppazx+miLeULviGTbPc
 YVkGtf4GeD8HNLBr6c0LymeuEoPRomwsV1l34R0DA75yl7Kmz5UO4GhumzY1LwfGx89nSO1
 BeSSpHcL2oGaqzVF95FGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pmx/chcDjvA=:TeaNAylyo7LIP4Y960ilje
 8Aaulwxb5XAFnNzNJ/vZjNvrIPaMm7Gek4PQSkiqk/DA10+lGu1tt9Moriua7JRXzANZwhXLh
 3HZEQ1OZbcNXYGbXZfrMIaUU+puHKEtgbzJrSKs0utL3KGUP8ahAoQNsCKZqFk4JppN35MwX8
 Bgg/jarViRIuEGlnKB5Vfl7anCmSp0Yjrl8D3owfYpS10Z/8NOKOq47itO6UAfp9AbdJibydd
 /p3CgaJSxph0OiUnUAC8gnAMIpSfrdoEkyFvWO84lKpTGxlo6YZpjoZlYC5pvbKiudDA2KHx9
 /Gjub2xYce3cC8GGkdPnnECU0kbe9wzNMO+Up8LauI2rNlSrFgL3xQWvaVtLbZ7H1eANeo4BR
 Ay/y2O2oRhBS1sg+oPXHSpK1j5dtSgwtaosv7w10HBH6WcNToWxp31g2D1qAy7v5s8p+Cj0ih
 k81bAYJwuBGL86AijVkOpofrsFmHJPP5nS5hwdhoVsNCjjpELZjAXt1x76mvttxiYgbWr+U8v
 E4giJqIdZdH6RZUHkhYpxtP0mV+tw4t59RyfAmZ0prILOuEUSL6R+ZfDSE1QOJhNrvYFUzZyp
 dbQKj1+umUoJRmlEG9rccXSgAkQrkWzs7SfWkBJ3wMDCScCW/1FTBjTfPTXJHLqaQ0wL5yxuC
 d7YsCrVddcQBTL9mMDoTAbdkY+WA05oIWDn4a6FaUavHaqMatNlrQgdTSi1IJEn1EJ7XnuW+k
 Zk9YSTmCgiQU2OjTRdtQRF2pvU3ui17AIYp2g2FR7OT2P0GRnwJCrs+EgNg9tk7v85R6RMnav
 Y6LckgtUtv2eKwa7hPaWIDvpCHoqNYGKpYbLX17FGdTuhtn1AEd8uhsMRAmhB3EywxQnpCWSI
 Alt9cmsiU3IPm9rm3/LRrmyRGKJsQCBrsAbf/Gu9VMPcNWiG6qa2Ij7IBi9aQCFesd47D5nuU
 QyvH5OdzzfEAdM953xBizXApn8u+xPsFXo3UhFTxkBnVVYfa9IzTBxAlKMxTWVxAvPj1yip10
 uz4Sp56Jfq1djVMZakYudxi60iHj/H3CDos3cAPXC1yj0iIog/Dnjzj/PUfYbPPA74nEGTgHD
 qF7E+Hmb1t90lh9XqJf6VWXHhcmoY7nsd0WaIeSR62UFDBhEy0MoLp6cwnow32neNVLC2NwPp
 ev6FDfNr12TFUrc9l72c56T8W20b000jH4U7hChJre0N72ln81upcV/YQdoB3CqEm8ZrbdNQK
 k/9Kbs+vG62WuTX4J0nekVBi+oGU3riuYF2tMrw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 27 Sep 2020 15:25:34 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 27 Sep 2020 15:21:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 27 Sep 2020 15:25:32 +0200
Subject: [Cocci] Explanation for kinds of SmPL rules
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

SGVsbG8sCgpUaGUgbWFudWFsIGZvciB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UgbWVudGlv
bnMgdGhlIGdyYW1tYXIgaXRlbSDigJxydWxla2luZOKAnS4KaHR0cHM6Ly9naXRodWIuY29tL2Nv
Y2NpbmVsbGUvY29jY2luZWxsZS9ibG9iLzczMGRiYjAzNDU1OWIzZTU0OWVjMGIyOTczY2QwNDAw
YTNmYTA3MmYvZG9jcy9tYW51YWwvY29jY2lfc3ludGF4LnRleCNMMTE2CgpJIHdvdWxkIGFwcHJl
Y2lhdGUgZnVydGhlciBpbmZvcm1hdGlvbiBmb3IgdGhlIHNhZmUgYXBwbGljYXRpb24gb2Ygc3Vj
aCBhIHRlY2huaWNhbCBkZXRhaWwuCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5
c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2Nv
Y2NpCg==
