Return-Path: <SRS0=+m3J=5B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C40C0044D
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 19:10:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ADB420658
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 19:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Dn8u2Y8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADB420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GJAOR0015224;
	Mon, 16 Mar 2020 20:10:24 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 23ADF781A;
	Mon, 16 Mar 2020 20:10:24 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CB3EB7809
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 20:10:22 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GJAKrQ000641
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 20:10:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1584385819;
 bh=QWOKlTJzaIyuhBzRefTA+ofGDXWDIOCyt+HxcJouxp4=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=Dn8u2Y8l5FkszkLqdA1Rvc7t1sPC1GkjS+XQdFKKsJC40HqY6GmMY74sWzLZmmggj
 yahT87JsNF+iuse8xrQLfPrYsbKIGgL/ixA/dQmV6mcMCXOVBSlSwgFOK0XnUMliB4
 wFgktEEGP/QiDV/YHAy9aegBfSF0ODlG/IvN1A1A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.93.189]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHY1o-1jAbjy40Xk-003KC0; Mon, 16
 Mar 2020 20:10:19 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <08714c77-6626-ecaf-a73e-ce864fff8de9@web.de>
Date: Mon, 16 Mar 2020 20:10:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:1elipqCBR7vKpeOIYCgw3cc/AmD0sokJKE8QGtUkwYAabzb6KTp
 jgFQy3P/WG/fFdynShPvVe3KarSd71vgwqE+XX7dNT2USKnaVhXhpZeHXXg58Jz6Q9f/Oy7
 yBV8l2Z5VlInO2dw8z/OKOoa3dY0UBNXKt2UaG59aAG/qpYKF+OJ6IOxhift98QQhH1o+I9
 Y0l4bO2RoRMuO2zYmO2bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wzau1aL/VYo=:xa9XzFdiEI4u0Hb7QFsU7A
 n9+p/P3oK1KT8Xcb5yJdDX0IRG0Jicq6YK00cBc3n8MFepg2O59XVdMEz62NER4AOJO/v5Cv0
 S+feVld9fcOQETgJWm9fUkUagvgvIb82NlW58Z4Ha8hKo2ODmJEsklAr4BE16zwMlqu1k39Ah
 s3r5TfIo6HzW2OTyEHHEwiEERaimTX7w3ulCfQy23fcTtox/en01f8WZJRwLVnoyqzmorFvWT
 oy3f1DOigYdtSiB+enis00yDPGxHo/sONmRLlbeDWu/mfnCNBBBs5mz/11S0IkSmpIiUGTaln
 2UEsbOERHizr4rV5LIBdVpPv5ykm6/0nd1wgAlvx0hrsgvm7It1uIhZFnekROd5p+IYuh0cr6
 525p24g27iDzrTYn2Uv4LjETeW4UzbK99gtbHmE23eAonxb1NiRH19OVqsd6u+UNLkYeIyhoC
 vqU9z4B1yyhAPZnB3x8PJasUI6v7zi3KND6jwrhj8A7/ePn15EcYz69fSUmOjslzsuxjuhyCV
 wkeRcuVDSy4OKbMqDVRXn1RGY+z4ScfAeRcLqFucbnfHgH552xfEOLYjrPeWbqL0gl2pYDAx8
 yiHqsj3HcD7q9oqIBWFaOc44WNTGIMzo4CKAKmgFP5NsfqyHk4djAYLNoeXe3+1YNUqbyk2TA
 d0Kxy3WnVOLYu782kTnEZoMAJBXypZR1hMlVUcVKrCJwbOQvZwk3eln5a/TEJqZzC96DL172l
 BrtTi4Ct4rfHKLHHpnHiZG09ZW2qB250Rp/yuDN7tn+Tyq0E+8clm0cFE56wAIeLH/fXgz8UL
 TpKtBx1SB3H3dCdv3nwGZLLbaA7GpFCVaqaCgyeRFC1YVz7IhMKNUy+7lxw4qemyzpXdXYUP7
 NaP0TU1CddOBtw06cjuKq099PfqR8DTnE+IDsmRVdxon7yuBXY8aEuHqF9jMhkXp0VbS5s2GH
 B0j4FPTIf38tHzlsW/DZC9zllHIYvmJPpGoaSlVhD08lObpirLOLnV5E2MKxqncA1npk7qgg3
 EqSctkgqlAa+UZrR7in8pzb8X6Kg6tm+A0vU7R+rXIZTYYSJ/H+MgTTKNisghmtQjrcYAWpdX
 cQHQp+x97DZJe6trxreU6l9kdHxVFBDvc4Wonf52vQr9efkXYsL0YBfEI58EhVnW2X58nv4l9
 dq+83/cln08/A4s2eYRRld/bGsvM5RvTRG3ORgJQW/A+sEVYBA59gkPZwH1jZm4uJq/KOShMc
 jgJMCK5GVpaw+1dj7
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 20:10:24 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 20:10:20 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH 05/26] parsing_cocci: visitor_ast0: Add cases
 for ParenType/FunctionType
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

PiBUaGUgb3JkZXIgb2YgdGhlIHRlcm1zIGluIFBhcmVuVHlwZSByZXF1aXJlIGltcGxlbWVudGlu
ZyBhIHNwZWNpYWwKPiBjYXNlIGZvciBQYXJlblR5cGUuIFRoaXMgY2FzZSBoYW5kbGVzIG9ubHkg
dGhlIGZvbGxvd2luZzoK4oCmCgpJdCBzZWVtcyB0aGF0IHRoaXMgY2hhbmdlIGRlc2NyaXB0aW9u
IHdhcyByZXBlYXRlZCBpbiBvdGhlciB1cGRhdGUgc3RlcHMuCkRvZXMgdGhpcyBkZXRhaWwgaW5k
aWNhdGUgYSBuZWVkIHRvIHJlY29uc2lkZXIgdGhlIHBhdGNoIGdyYW51bGFyaXR5PwoKUmVnYXJk
cywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1l
LmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
