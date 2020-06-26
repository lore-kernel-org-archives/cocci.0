Return-Path: <SRS0=6oUL=AH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD87C433DF
	for <cocci@archiver.kernel.org>; Fri, 26 Jun 2020 18:18:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BECF206DD
	for <cocci@archiver.kernel.org>; Fri, 26 Jun 2020 18:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="N2ZLAC0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BECF206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05QIIU9a020510;
	Fri, 26 Jun 2020 20:18:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 86F7F7773;
	Fri, 26 Jun 2020 20:18:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 389E23D0F
 for <cocci@systeme.lip6.fr>; Fri, 26 Jun 2020 19:35:38 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05QHZbi4000728
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 26 Jun 2020 19:35:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1593192937;
 bh=HOSzFuH926l8R3dW59G0EzqfimCL0uMBQIat+xqUhD4=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=N2ZLAC0H2Hiuqto5eIeYHpWJ/4KuN8npNdx5b52SRcFKX88E1YZOHvlA5WcsYhdNf
 xha+ag75XzIQELTArbHx5gkLC6N/qspy6u5f0S5KPXZnCVMhheZVxmXlpaw6/u3B9Z
 MUS4k5uhE5YC51VRw/nRMLPRQZ4dRkK61rQpPkxQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.71.143]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3m9J-1jobHO0m9L-000sNq for
 <cocci@systeme.lip6.fr>; Fri, 26 Jun 2020 19:35:37 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9725bf1f-06ea-63f3-2322-ffcce21cb218@web.de>
Date: Fri, 26 Jun 2020 19:35:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:sbXUuGPLBUx75fiHW9HcYTxGLl91JqvSS1LVVyZzrE5f72xaR88
 xmFVGN95ysfTn7o2SsFHfiNBjwBAJLVB+V53XaLdrSr5yNowXB1terQwqlVeD0pThI70rH0
 anxXvRV5SsJ6gAEyD8hcM9V6z0CXpUcIQKY10447SgwYZ8hGbZOgk5xTqQ0Z/lIZPl7r+It
 Qo7h1CvZt4FHTovr5QWbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dIAiVfirRio=:Ff4xNqNKEiSYcytomaak+d
 XuZL44bzPz0j+ikzClJR2bbSbnZ7ZClBiSLWcW0yQf2BOcHoqlGfdKDqs+laZFfbA4F2jRpTG
 jVDd5Jo1SwrlsrjXw317NBDvYrjS1uRvbidASTO6wXiQ7sCPtwDJw7SNXISgZNDBN1k0wip8G
 YtlSY2kJjc+2JUNP1gmxeHJyFCZdYEBtm8xZ6iXleyBppSyP/HDG582il5U40RufMWrsiJvip
 P3ny+hoY65O5Wo/0sIOYp97tibMaOglcLQvM/oVQSx8QQkxdWpsphLjeZI2U9I6FujC9LHn4i
 HcMNZ3wjCy4SlWRBaVRPNIgHx0xvxIkaHdDZ4lD5clss3AJcZ9q/0mLRA1dZfaAUMPbVNgVXo
 5NisYcpBp0O8yhWXMoKcjr3DIU0ThlW06mM9CC2luA20aQaEr8aiArLzITSiM4IsGVRXK3mAo
 ET7EOrf4DspTKjsR8m+OhLFHtAMSTouoyf3ngq3LiqynvsogC0QsK/wSgXHtqe7Rw47jJ6Ng7
 RMHwo9GcWGAQGbjLvPLhlAYM2t2qDDq6yWV800MHeSm6dPbJuZU+ryFrrbhjQ0JRXtvZA8jxM
 81mgMOTYJqdcScHjWAxB269U2RyA/X6jUORLhhr1KRxiiJgHqR+ikIAePW3B5POW3tslDAlK2
 Bj7OYj0wkz9/kHexhfOkcPRhSqBrphIOA7AzTEfjiWxeehMWTsf4HTHilhBQ63oQTQws5bDwJ
 ov7BoR7kW6Bqla4KPb/IMMIwCOW5DZiGgMOb08bTbW8edxLU/qok6tY0PRJ/1i2pwhPyOuFU0
 BFtQqMQO+ZyTPhqrFJcBTMzDDkL/ZHE9gFZn61KeOmCfILQv1Exk1RRZAEVmlJgdLosSuRtRp
 iHh6N8Ub9sgxF3SrUCC/M7tRMPiCNmA6vqkWdLIc8aSEiHpcOG3bUdaYqAkgyTLv08gllonof
 GzLJxmQwLi2z9fdcdkOKHAtjReRTwosCuDXuBWKBR94AfUAB9iI7dHOtH9A01RdB8H+a1bGP8
 PY9fAS0GIIVa5O59SCWhy3C/2A8lg45ph0pJPuuWTlHP3Fw1HB8LPzuCjHJlYaY1IDe8eny5m
 RXUG3tMbYLiQcz/Spvv/+tmFFUol/cyWuFLFeVtk8e2jX9CUyj3oJSQTYHum0d1xrS4wN8x63
 oIotaJgR7geEXibxDCFc3GNmo93yC6NfpEEMa+vYM4HadXiVbuaDv4hTpDPMUGN69iQY3Rc/A
 V8g6zs8KqPpQz6rUu
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 26 Jun 2020 20:18:30 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 26 Jun 2020 19:35:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Fri, 26 Jun 2020 20:18:29 +0200
Subject: [Cocci] Checking the parsing for a nested SmPL disjunction
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgYW5vdGhlciBzbWFsbCBzY3JpcHQgdmFyaWFudCBvdXQgZm9y
IHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZQooYWNjb3JkaW5nIHRvIHRoZSBzb2Z0d2FyZSBj
b21iaW5hdGlvbiDigJxDb2NjaW5lbGxlIDEuMC44LTAwMTMxLWc2NzViOTY3MOKAnSkuCgpAZGlz
cGxheUAKdHlwZSB0MSwgdDI7CmV4cHJlc3Npb24gYWN0aW9uOwppZGVudGlmaWVyIHJlc291cmNl
LCB5OwpzdGF0ZW1lbnQgaXMsIGVzOwpAQAogdDEqIHJlc291cmNlOwogPCsuLi4gd2hlbiBhbnkK
KHQyIHkgPSA8Ky4uLgooICAgICAgIHNpemVvZigqKHJlc291cmNlKSkKfAoqICAgICAgICoocmVz
b3VyY2UpCikgICAgICAgLi4uKz4KfAoqYWN0aW9uKC4uLiwgcmVzb3VyY2UsIC4uLikKKQogLi4u
Kz4KCgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2luZWxsZS9qYW5pdG9yPiBzcGF0Y2gg
LS1wYXJzZS1jb2NjaSBzaG93X3Byb2JsZW1hdGljX2Rpc2p1bmN0aW9uLTIwMjAwNjI2LmNvY2Np
CuKApgptaW51czogcGFyc2UgZXJyb3I6CiAgRmlsZSAic2hvd19wcm9ibGVtYXRpY19kaXNqdW5j
dGlvbi0yMDIwMDYyNi5jb2NjaSIsIGxpbmUgMTQsIGNvbHVtbiAwLCBjaGFycG9zID0gMTk2CiAg
YXJvdW5kID0gJ3wnLAogIHdob2xlIGNvbnRlbnQgPSB8CgoKTWF5IEkgZXhwZWN0IHRoYXQgc3Vj
aCBTbVBMIGRpc2p1bmN0aW9ucyBzaG91bGQgYWxzbyB3b3JrPwoKUmVnYXJkcywKTWFya3VzCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxp
bmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFp
bG1hbi9saXN0aW5mby9jb2NjaQo=
