Return-Path: <SRS0=xIcw=42=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDFDC10F27
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2020 09:56:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9DF20674
	for <cocci@archiver.kernel.org>; Mon,  9 Mar 2020 09:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XgfyadQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9DF20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0299tiDd026946;
	Mon, 9 Mar 2020 10:55:44 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4B7C377F4;
	Mon,  9 Mar 2020 10:55:44 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2886D5800
 for <cocci@systeme.lip6.fr>; Mon,  9 Mar 2020 10:55:42 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0299tfdT018817
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 9 Mar 2020 10:55:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1583747739;
 bh=9HkwsyYAo+uhW9VTvOfvCo7InfzCpF08ymbgLI+R6f8=;
 h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
 b=XgfyadQ3iSsUQiLR0Kg87/9Eeyhri3aHCoVMc/SqoLnuhdw6+gxOFR6skTePM8D1K
 M44+a/G+jWYtZ0IEZucpL+Z14xVeTKMs2/3Ba3JCtpiV7Ft80Kirbc+MZ6c2KhDd5m
 Ugdjm2JrMdDuiDnDdCD+53ShEgJrpjXFTZE7bYcg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.147.116]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZRnx-1iv6OM30pB-00LGHy; Mon, 09
 Mar 2020 10:55:39 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c638ac63-f66b-37cc-5c58-2a902c79120e@web.de>
Date: Mon, 9 Mar 2020 10:55:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:lEbfMQ9J3CZs/TZKCtHb7y6drrRNTZGeLeBnYY2yVnMSUAKT10U
 0b25LmTNXuuCbP9++wfg01e6UD30B6nON98cQglz/Vj82ntrWgvrvbmjY0rqCw+fe2N9TSX
 cOhgQFBHvAxN1vgcQ9b9eEK5Ta+dt7dbOn4BGAZASn4X1Xa2qNyXagiPy0Q7r0RQYOabtGP
 Lfu1g/+WCE7MKT1xIauzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P9ZMobFSkMo=:GnZHcO71qXlnur5m+O+8zz
 5PJiV3q5jqKsJUhu/Mxy1BtgpUGcJWIqblwGoLm+Jf6VTKG5KFpzJF3QKxY8ncyhHIQvHkqzb
 8Kar3GC1kovQnPpFw96bukSNkXayUfVgRqzfjFUO6n102VyP32DJv3FO7wfkwndvcu5TYM8Yl
 ppub/pfYhl9hkBAr0qUV/MxyC03oiEjEh8mdq78slpOyKagCPryyRa1FzG7MV5ImKDPAaPxsi
 eaNscJxQov8gXFgvdCWitLbCOvd7p/rjZKIfciNDvg2jMW2DlOeRvfjksOmW+MZkFRybYS+bV
 Oqkg+RXKxVdYli5YQQlduywi3I/RAPQ1fuEVVBLiqoTOqY2xd9t0byFmsT7+3hh+gQj3lJz8I
 MF05jiupvG6yUVkj5exkIfAVPDGzyMsdKESI/VIKhCZsTbuuEsjIn4zEq2g7AjsQs5xLP+y3H
 uHgM+gP+vQmt4Dvl2symUIIvzYUmJO9d9pBiCT9D7ibl+b9ykKN2D/FgsjgYMPhbHozJr1URk
 K0/YVB829s7WsngrhOgxy4B7dcY1YPlVx1Y9j/JmBtFexGYJ6pwmBH/F5bafwIYVFCy7QkQg3
 w4RGTFz+iieN8GsWro/fibUhkcfQtbA++rkEHwvsngmQpstjvdRSlvQ51VidYrouDzSkM6tbq
 ELbuRiatz+p2a51BYQIt4GUvruFOk/6MhMOVyULeGCIN4HLb17m/pP/7VarUPPFBEyVtC9inm
 sY7UZ4CpC+KW746R9/nPOuMbN1f/o7taybDWAaiN4fKCANWSyid4c1XDHGRGmVOfMyKNtBuPH
 c5NUI6/7yK8pM2PTrVRCNZzRu9TP61PT6xrV58yKlAItv5s2mCJz50AmWZfYJE3eWgGoGHcpt
 k6JHiHFbAQQV6VLcnoSf1VzxIdNcgI0aabTqVjicRL5q2PFjPs4LcOM4s60qb6zlpV9xvh02H
 Zyu74nw9BJjonPJBMuMis5FnVg0GN7zmMqPtzPchkFKho3sAiEmEWQJlwQEahJ5F25etUMEEM
 cgiI2wQ64YbrSEJ4m6ZC4Myjke6qvt+bJKOhRvxazQAf1uEQciV4v23rI2aCQ9/I6Llcd7FF0
 ymZ+r9esBrUahvppavCO6z8V4O/cjB5YQoGBOmxovSmFgvqx5K3GebuNI95yVigWBSdARivac
 bcR19y1PBFXAmoq7+N7IDaLsGwVaLdHQ7PoJpBwPD0XxBZD2N0rHXpobYX04cMauZIasOUEpd
 QAjmR+xEPrHBVd//4
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 09 Mar 2020 10:55:45 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 09 Mar 2020 10:55:41 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH 00/13] cocci: Align the C AST and SmPL AST for
 enum
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

PiBUaGUgQyBBU1QgYW5kIFNtUEwgQVNUIGRpZmZlcnMgd2l0aCByZXNwZWN0IHRvIHRoZSBlbnVt
IHR5cGUuCgpJIHN1Z2dlc3QgdG8gY29uc2lkZXIgd29yZGluZyB2YXJpYW50cy4KCuKAnFRoZSDi
gKYgYW5kIOKApiBkaWZmZXIg4oCmLuKAnQoKCj4gY29sbGF0ZXJhbCBldm9sdXRpb25zIGNhdXNl
ZCBieSBjaGFuZ2VkIGluIHRoZSBTbVBMIHZpc2l0b3JzIGFyZQoK4oCc4oCmIGJ5IGNoYW5nZXMg
aW4g4oCm4oCdCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5m
cgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
