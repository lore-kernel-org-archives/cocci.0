Return-Path: <SRS0=pTva=3Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B30C35247
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2020 18:30:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E17C20674
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2020 18:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Ee42IAd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E17C20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 015IUUJ6016229;
	Wed, 5 Feb 2020 19:30:30 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1B13E772B;
	Wed,  5 Feb 2020 19:30:30 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D4B707718
 for <cocci@systeme.lip6.fr>; Wed,  5 Feb 2020 19:30:28 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 015IUSuf004400
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 5 Feb 2020 19:30:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1580927426;
 bh=5EM1sV6yCVOotoMQd6EnOST3o5DIgO+zaR/J6VCaR58=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=Ee42IAd5ahy/PNPH13ej1aMH7Rk2MqseEAFwWs86gScdtN8dYA5YiIjojDJH/mFxu
 6MbqR6Z+WmOSZfCUYE1PUMxT6Bcd2iYDZBLvdf6kqT9r/MTVwSHRlrmOAe7UflDN5e
 ZtB53gnILuCfq4U1giKymBph3qVrJ2angk7Am/9A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.89.156]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJkxE-1j0VuA1XV6-001BLY; Wed, 05
 Feb 2020 19:30:26 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <702596c2-84bf-13ca-b014-8784bbb98808@web.de>
Date: Wed, 5 Feb 2020 19:30:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:vUGNcOw8zunGNMLCvbUGePYnTI3q/aWe2xZGKAyojARg01F78iv
 OE2BlSOffcdDBvXa2INnvszeYUNBkX0ow4oduijWClLuUW4M2DpeOs2ePc17tvl5YGzG3yD
 Ko+R/HBNWkQjN0YVf4B7TNxytOedrMNx7aOVNtkwmqs5UIp1y+F7rMoF6854oh8SQk/V2KY
 m4sAjijrY4LcsSqu8UiBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IaPmQGXMDNo=:6Q8PGRAFoP0vDy9FUid2UJ
 b3hlTK0iMExGv2gRKRDE+pq9R9+Di6+d69PnoVKSS2L88sQrFNOrkgEI3YXYuR2K4W2wgd147
 WcoJQ2OyuvPGCh5Hqgzdq0ZEeT1j8iaDnxTogmNbhWGZfcvFRPqUTXDKLZFGIkZfMo61yXKHK
 E+ONeM1693mzm3K/uWkKA0TR/Yito8yMVsRP83QN5mBP88jLF8rnJpDypYc7vtMobqAVK6dJI
 B9rL9KR3haGxbHctyv9qqQisOGbAnFcfpXfzq7rNGRoMtviadkj4jJUBLdKL+uDU3XgFoUImt
 YsZvdOO8n1uPbYFsbENP25idJq2s7QOfFc+63M1uknyGtH8rgbSPc6R7xjkfPjh+MBBWKVzfp
 rx2DxEqwI+wOuq4Mhd4OfYF2IQD/uQIe9/ysT/Uo6AAtTN3HpJGuhFzUmydgskxU93pjCc48i
 oKdkDvc9hYd25NcaTLdBAYfYlXdhn9r0rWcvI717YQU+q+XZ7WZsaGrkjV+PwpFR3OvtnhErN
 ts10T7V/9F9Ly4hRL0L60pRqlzgQbplK2RcM4XhJrUkDRI+L4oJ4UiI321zYY6seSRjTSaOH9
 cLKVE11V/WnQO27wOvRaQ1K5gabFV9y9o1/Y/FfMYzufKrzmC2lEIwkgruesdNVNdSvYAbKcA
 F7DhgYGSGf3KP1Yu0LCLtJRPTTIx64eS/41KjwD6tqAXoyt6VuGiIs/WZW8oYDEyvHJxemCiG
 vg2eI2zaCj79hPowLNefHgnyW4dVaoHYdV/6eBwYw6OITQsK4KRZtgdZrrd1pwLGO6mjst1W+
 BXMIC/ihmQLcp23htJpRynZy4QVM1Qpzife3Zm2LztvnNmqb2/QrNoET7PJt2JfKZrfmOsAOa
 8Fb8qhb7XqOgh7Fkq7LKFmLVChn8DmJbxfj/GbQ8GuLx7T7ufCFRus8mak0uYt+4vYGbK8A/k
 YQs8q+I3mGnvzSBsWJ/fPaO+lqERVy7QJmWr4gZui8iV7bu3+ounbiRLcOFV16VBHoRGhyHLm
 RI+G73PTZAiiOJN/ATIyE5f+wzAnm5ynwRHBeZ1/ROIZCGPNu0NojmVDfb4lu7hINemq/EwFY
 q4Vyzj1hQ3kKPkcDkXBdWYmqJmyDIm6N6ucphviLsbmbLOKuDCOGE1eIGsQvQNcAG40hEc3J/
 TSxI/Em7gd54RlyreRfn0s2NhLm/drnEmmOD0X5bfOpoHSeHOCNMyJwKQlvrvl+C6nEIpP0He
 kqckB+KBFmSA2tFbu
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Feb 2020 19:30:30 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 05 Feb 2020 19:30:28 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH 0/2] Align the C AST and Cocci AST for pointers
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

PiBUaGlzIHNlcmllcyBpcyB0byBhZGRyZXNzIHRoZSB0eXBlIG1hdGNoaW5nIHByb2JsZW0gaW4g
Q29jY2luZWxsZS4KCkhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdGhlIHdvcmRpbmcg4oCcVGhpcyBz
ZXJpZXMgYWRkcmVzc2VzIGEgdHlwZSBtYXRjaGluZyBwcm9ibGVtCmluIHRoZSBDb2NjaW5lbGxl
IHNvZnR3YXJlLuKAnT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5s
aXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
