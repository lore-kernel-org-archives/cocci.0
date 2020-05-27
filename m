Return-Path: <SRS0=ca6b=7J=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFBAC433DF
	for <cocci@archiver.kernel.org>; Wed, 27 May 2020 18:45:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91ABC207E8
	for <cocci@archiver.kernel.org>; Wed, 27 May 2020 18:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="MM2fWHAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91ABC207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04RIjPML020080;
	Wed, 27 May 2020 20:45:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 53ED63E1D;
	Wed, 27 May 2020 20:45:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D92753C89
 for <cocci@systeme.lip6.fr>; Wed, 27 May 2020 20:45:20 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04RIjIYN003418
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 27 May 2020 20:45:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590605111;
 bh=Dwiv4seL8ee3C/JloOJp8AqoZ3iVO2A78wPGNVrFh6Q=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=MM2fWHAR3Kha899mJdTt3UE4stnKaxhUfxD3+5ECVoj3+QAgfezDTrabzyGcxuho1
 e7x/+RFeon0lpSG3fs8BUw3ktFfXpoX+B0uV9KMGlxd6fjZId+9Z1BGpvl1AZ3B3AS
 hhhDPhl3pMQ3mhN2s9L+AhFRaSnRwnqgGh9G3SJI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.185.253]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcxtU-1jDRix2jfE-00i9OS; Wed, 27
 May 2020 20:45:11 +0200
To: Dejin Zheng <zhengdejin5@gmail.com>, kernel-janitors@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5dad9b19-ceb5-1606-9f62-7626e5677971@web.de>
Date: Wed, 27 May 2020 20:45:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:2mj89pThrO5GlS0CuVGiU9ZLPcTx8lPGvbGv8BYFG1BSUlD3T48
 6UxnmAH94iiqCfJgLpFqv9ZXEPz+X7s/E0ry0T/NLYq6TT1hGK4lT3zGnS9ytwUdzTPLan2
 IIokIi748DcsofVx0uoAIxyxQY3y56Ba+N7erEXQ59gbK3Ly60xLL7KMgJmumcDGP2npA4g
 zuiMsEpyVtCeSBKBFr3GA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:43Ak3plJJvE=:qbo1+TuYzsjw3ssPkjMjWE
 G5ri/P32z6g8UxQ0Nn6aBdRlQZEmgfWXykldoUDLCLfck/80fLHgs/ku/++b8JFioV2//zkb6
 fp5YbzJlaSOkJ7igXrGz0GEbClz2wo9j6ai2hCUsKSjegVJPe2+SjqlWOIc/mx30/sec21OSL
 nDoMnsL2TDgwGT1W3hlePv3sRDPzHu6L3mhdERBn2HK8n4y9+OjpqtNPOdknBpG7UrX8sKCSx
 ZmhwNGYnpFOgU3VHR+Bhp71Z8kMMOUmrDvxXqlGukkL1q7C13NPA/j3bwSwd4/avEeV0EWZjh
 S6vHKgFcs0ZQCbY4IXf6xvztCcgsRuHoCa5L9o1tC6Mt3w5CWBxiwJ4FEj/5vAd1F11KHhdT6
 +W5SMdniYdpmnl2etH8WO/a8yXdkfAASBFdKzoE4UqSTpWBNKMq6xLBS88BeRfYM8J81C829T
 +rSCm36sBQtQNkNxVelwHDZSMSa2f+Y2y1zJcf1/bM/rDwMFZu//inkksgTmX4hU8LIDTuR+O
 TqVAaCIb/f6e7kPR01Z2BPMNSCEIP3zYcFWB0AGgdnXSTwsZVbHPPWown6SMHMaHzdx8g9WBR
 aCII5GmjInO946ukSGPW7iK9r1+R52fwC0uHyquJtGbCWnmOfEvtbRvRdi5j5C9gU36088pUO
 llWtTwOVI3aOY2rBnFcLOAE8iFvzv02QQ3TPfwegrJRwZt9kfhPmP+iz18CldzQwtwP+xw+Nm
 dCARGoZ7YRgynJqaMok7UyJIPIkmY1I+sZiojbBqNimLhSi4SB/aR9kMgkvM22zQYBxaZoyKN
 frFgjUiksQ4g9keCpEzot9eMRq5zHXHfk0aZ+4/sR0xgdX04btYcdyLjFQWgB1N5KR8v58fD8
 lPnJZV8UFcUo1giftKQiofnRJ5i78grntwkTk6aGsqFdckR1VHeLBPkN2UvtJDsIbwSz2rEhR
 y5P/e3xLNfBXjRF9Y1tK902Y+DQqVXszxXwOAG3GNPpVJJgkNscJewpFqTBKw4D08PdmAz2dW
 dazxLNUfzwTzsJLbBWk3wOHC0qmwYEmCTRlXXOuh8h74jhgZWPMGMH7rZ/X7fbr5Zxb5I+zuz
 T5EIT9gdZob8bGA3mIPQgXEwWXct31yng+79Eosj98D/obP9MedAweIKdjMCZjnPkhBJX3fkL
 CuDAlioEl72JLhZFT8HZeoMr7ZK/traZPbrTmGXMeB/PBqJKCSMVcGXd8hckY1gdBK3Q8Q7j5
 MW7osp6pF5VfzQH5O
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 27 May 2020 20:45:26 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 27 May 2020 20:45:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH v3 1/2] drivers: provide
	devm_platform_request_irq()
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

PiBJdCB3aWxsIGNhbGwgZGV2bV9yZXF1ZXN0X2lycSgpIGFmdGVyIHBsYXRmb3JtX2dldF9pcnEo
KSBmdW5jdGlvbgo+IGluIG1hbnkgZHJpdmVycywgc29tZXRpbWVzLCBpdCBpcyBub3QgcmlnaHQg
Zm9yIHRoZSBlcnJvciBoYW5kbGluZwo+IG9mIHRoZXNlIHR3byBmdW5jdGlvbnMgaW4gc29tZSBk
cml2ZXJzLiBzbyBwcm92aWRlIHRoaXMgZnVuY3Rpb24KPiB0byBzaW1wbGlmeSB0aGUgZHJpdmVy
LgoKSSByZWNvbW1lbmQgdG8gaW1wcm92ZSBhbHNvIHRoaXMgY2hhbmdlIGRlc2NyaXB0aW9uLgpI
b3cgZG8geW91IHRoaW5rIGFib3V0IGEgd29yZGluZyB2YXJpYW50IGxpa2UgdGhlIGZvbGxvd2lu
Zz8KCiAgIFRoZSBmdW5jdGlvbiDigJxkZXZtX3JlcXVlc3RfaXJx4oCdIGlzIGNhbGxlZCBhZnRl
ciB0aGUKICAgZnVuY3Rpb24g4oCccGxhdGZvcm1fZ2V0X2lyceKAnSBpbiBtYW55IGRyaXZlcnMu
CiAgIFRoZSBleGNlcHRpb24gaGFuZGxpbmcgaXMgaW5jb21wbGV0ZSB0aGVyZSBzb21ldGltZXMu
CiAgIFRodXMgYWRkIGEgY29ycmVzcG9uZGluZyB3cmFwcGVyIGZ1bmN0aW9uIGZvciB0aGUgc2lt
cGxpZmljYXRpb24KICAgb2YgdGhlIGRyaXZlcnMuCgoKV2lsbCBhIGNvbXBhbmlvbiBzY3JpcHQg
Zm9yIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZSAoQ29jY2luZWxsZSBzb2Z0d2FyZSkKYmVj
b21lIGhlbHBmdWwgZm9yIGZ1cnRoZXIgc3VwcG9ydCBvZiBjb2xsYXRlcmFsIGV2b2x1dGlvbj8K
ClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8v
c3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
