Return-Path: <SRS0=gowI=T5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6EDC28CC0
	for <cocci@archiver.kernel.org>; Wed, 29 May 2019 15:08:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3462323B7E
	for <cocci@archiver.kernel.org>; Wed, 29 May 2019 15:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cTLaQvgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3462323B7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4TF7nRG013869;
	Wed, 29 May 2019 17:07:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7BC0C7762;
	Wed, 29 May 2019 17:07:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EC5957756
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 17:07:47 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4TF7lX6023886
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 17:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1559142466;
 bh=+PaclLXcKfWutVSM5Aa6B8/GejpGO5ewkWZv01vX3SI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=cTLaQvgCoYvfm+449YOUbPB+twBjb9Iiyz3d3szMZjtZnxLs40cpyAf0gWORwcryW
 WV8bUBeHj8iYehD+zYCGGnjXSNi1bKfZfO/xp8XnX0+KoikCe+kRYSy35hDrSCu71Y
 4eayZSgT6WUr0iukITUC65I6Edw59wKINVL7sKj0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([78.48.118.255]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSrll-1h4onE3261-00RnG9; Wed, 29
 May 2019 17:07:45 +0200
To: Timur Tabi <timur@kernel.org>
References: <CAOZdJXVuNYEkFOiUWYq0GbqRUfuTNV35FGt7EViSSq6AqAY2-A@mail.gmail.com>
 <88a6a825-9691-33bf-150c-4b5b096475d9@web.de>
 <f0bf87c4-7ac9-e599-4243-5b5b0fee6ad1@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4979e961-16b2-f722-b4bc-736a947efc18@web.de>
Date: Wed, 29 May 2019 17:07:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f0bf87c4-7ac9-e599-4243-5b5b0fee6ad1@kernel.org>
Content-Language: en-US
X-Provags-ID: V03:K1:Yvfmywhox+6ELaCKvd5ZttIyU+yxvXS35nD3+ZUkA1s7kECvzcT
 YBt6Huuw4NJ2B5HhCtH3xYCKvKSJFsQi4BCiFYoMdDDhztXbi68PT5GehaZTqm4PQUPueYZ
 xIyiN6geTDsSxcn+6nP00qMQavSI3mmyMDfZxfhnrRG6ZYxVndy8GXZi8UubLZvCUKn1yub
 IQy19c4ZehyAwGzoaYFiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LWWuRu4uD/E=:n4cCNtUPdNQpj0tSfPiaTd
 i49X0KSKfCZOxspxzo2ezHqKLMe7UljhCX02/aKtzyLVNRigrS7N+/7fUpVuv/Xm88xKDBfHX
 Au3nxoxUtkj0ZyWFnLYbFP1xiHafIeWlAY8Dj0vV8i4npEocfExOsKqs3x46OVz9W+6d0HjLx
 KSg81rC0t9j0Siky2RQQcrzfv6eRwYHJkKURhuVtpH/oDTKSkb4vh7e0NMv6IS8Ux7kmiOhqa
 kBeZAtHq4SU2SDka2n8z8ZWRB6SecI+0AspqUs1MiZMjrTaYR/Dqyq/cVzBy5/T2DaTcMin6T
 qi+e4FuGNN/K6bi6wRoQ2NM4cwl13AabkrBCnfByAr9IRdnJDt+QCw3KqwTdlsKlS09YEB2Wl
 L6x9vg6bAeDG2QoTaPwhtLDdhWp/gPuJSuWrdDyBO3wXNIIQ4ii1+3o0NQKHARHewTmmziMFj
 dF4MPO64hMD6iHIJSrBTXxbOxzmiUEiv9xIxbkgPm7nCnzTmy5eRqGBzz41QnQ5xoFq17B/Ok
 7tQsozbmBK1GhGSYzH+C5NEO9NlmtalCpRQOUeH7EV553EVyr5gmWcFKjSchAt6qFtqGfUPEl
 BEID5wfvgePjGDZ83zRX5m7y4O0P3Spk0rYD102DNDnMJAj+MYMnKevhqe7Cmum5NWhOQtplB
 v1fOIsyt00Z594bs/HXHjsOnjiS1JT3mPsCjhaZ+LPfGck1ummwcayuDdOiIxChik+ead3l9E
 CE2MAKVZVdRWnEAQ/48139gtJNtV9skPaWkTodj6PvRsMz7mSGWHUMWLVCvfS2sqnow8u0LgR
 kMr7EFs8Tq1NGCeuYaA8KRZ/4XPrq7TDR8/4C/l/SNxRC78kQefbI30AjZmW7pmshfKnI1Wx7
 o6HWxnc/ttiqRNQz8sv9A74o60RnYsbvx0zO98jvgYW8/0+rGzDoM99Aii2oTGOVyJQ08KOUi
 AxqIb3lW6EQv2v8M0tz18Uu9lgpK9MPObD3fkC/CN6BMucYYarTE1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 29 May 2019 17:07:49 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 29 May 2019 17:07:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Controlling where braces are located?
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

PiDigKYgQnV0IGl0IHdvdWxkIGJlIG5pY2UgaWYgSSBjb3VsZCBjb250cm9sIHNvbWUgY29tbW9u
bHktdXNlZCBvcHRpb25zLCDigKYKClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4KCgo+IEkgZG9u
J3QgaGF2ZSBhbnl0aGluZyB0byBjb250cmlidXRlIG90aGVyIHRoYW4gIkkgbmVlZCB0aGlzIGZl
YXR1cmUiLgoKV2lsbCBhbnkgcHJvZ3JhbW1lcnMgYXBwZWFyIHdobyB3b3VsZCBiZSB3aWxsaW5n
IHRvIGNvbnRyaWJ1dGUKbW9yZSBzaWduaWZpY2FudCBkZXZlbG9wbWVudCByZXNvdXJjZXM/CgpS
ZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5
c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
