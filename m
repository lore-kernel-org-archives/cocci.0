Return-Path: <SRS0=jkZ/=X4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4C7C10F14
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 08:18:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A8620815
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 08:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="SNFtkkZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A8620815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x938I85k007410;
	Thu, 3 Oct 2019 10:18:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4801077A9;
	Thu,  3 Oct 2019 10:18:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BB65844D7
 for <cocci@systeme.lip6.fr>; Thu,  3 Oct 2019 10:18:06 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x938I5e6013724
 for <cocci@systeme.lip6.fr>; Thu, 3 Oct 2019 10:18:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570090684;
 bh=k70eDlArL9IudwPLPck85l5PBg6EcwtdKe3MrjkYyoY=;
 h=X-UI-Sender-Class:To:References:Subject:From:Cc:Date:In-Reply-To;
 b=SNFtkkZCT8gqEGg14odHVAnFR/PgwbnJJ8+6Ko0q8/Rjw0MhpNacrS70gDz8DGihJ
 Q3jf6jrPsUhw/VaOSgiiEYmT3Q37rxZiOqb5F5qCvinwCCeEXBmP3NIKuPnaJBUuhK
 ODu7838ttPAnXPsfpJEV6I66vuRVLmznpQ7sDGGE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.81.27]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MMW2M-1iDBwo198I-008Mhx; Thu, 03
 Oct 2019 10:18:04 +0200
To: Michael Stefaniuc <mstefani@mykolab.com>
References: <c0801ee0-c227-5d9d-50ff-3ad872621808@mykolab.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c9a64f4a-30fd-7c99-bd29-edbda0b30337@web.de>
Date: Thu, 3 Oct 2019 10:17:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c0801ee0-c227-5d9d-50ff-3ad872621808@mykolab.com>
Content-Language: en-US
X-Provags-ID: V03:K1:5ZYAgxNPWnv52qQBYr7ejHPXhpJdDpNETp4j5N8fAkXW9LHAIOO
 epArwCHkcL+nxa41s7epSUjtKTbfslnnjszV1WkJBxRGxfoRDVXJkDhCUm72xiflhUhx+O6
 tpjcbmCqa8i41fdamzJLEv9mWVoQsE4E248OdNpu/vvDYJH/6SaPbD5T96Eat495rzxltaH
 77XyxphTD+qiQZJis8XKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U1eL+iBaoGc=:CLumAQ/w/SC3YQfTlWyMU7
 iDSQvqgiEPPhfPxCf6g9mark5ylPawgl4kczTh9B1uGmHZUiGKuB3Z3AuaJzVaZZ14Bm8Bkka
 lw6cpmyDG/L4uXEJmFvnv1MxtHwFYqcKDbuHpwrDcz5NgwgpxicTf0+Q5lY1D5Ory24MNf/Mp
 LGIDPsPz4K+qmY/4/MGx0ucq0NcFuV0nPOsIYbxLu8FdFXEFvyUeksthry1WnnAMcKQgl+k1X
 A8FZyD96Msyz87d2OuSADIKvqHw/814R7kRhbBh1n8Y3/MKOPiT8z6cYswjiNxOYWhqmXD1da
 BWsEzOBoNPpC7mrQDhOFbnTs+lPEFdmBu5+3oNSriMT1SxMQnuglCapqyz+V5spL0Uc8JY3tv
 O1vpXwhR/iTn/HgFAzZ1YVFhqCRRBV4HSqzo3tLpGdM3X8RGF+ZcoKR+ZQHlx146Q5SkkeKoo
 8N9hyBJK7FdLRHPgG7dvjd+/d29gtB8eC3VhQ799gi/+Mq2FeYLDKGMj1AjPjfdwG6yChbY/x
 TDOjCBPQp0JLFAdbIjmAbIS2/JnSI1JNNl3ED63V3YoNEGtOcwx32DBfhJ3YN8oa9sP08FfYB
 WASuYNC/KiR3KG/ffv7QW1CvprNsaQMh4haeGWNpSa3WIUR8l5telB1yr0+gX9KdiOKs/ilxm
 OAui7141UvZ568U/47ELQveiYw5u4VIl0UVS0afHnFNdDpIg2CU9FQHNs38sQxcczAED/oKQ7
 UquTr73BYLmKJx9EA2INcm6U8ZlLp6Le7Yq5P4hdNfO4qD4PeCnTkFULy7N6wLYUuOGAPCe1c
 q+SAbNdggpo0cVgUXWdjfn2w/yo4CX1xDGiyTnWfidGvbiWUBfgzwIFCr5Xkbz0BGAxJU9LBo
 cGhuiP6u3kerU6GlBSUlh6ubfTcyC1q1Nf1el+3Lg3Mec48eodre3OvbTr5c+50o5XgiTQMsI
 IYraFXnK//2er0xSLLyqULMY5c7pHnVGpsDIsszzfGpJkENHFNejVyLux40LV4nw2YiA5A+CC
 ffKLu9mSr5s/kNlfjXpya9CvD+dsLu4Ad5Ll1PFGR2t5yFGjz6prR+jeBTQpIXLAc8IRkSgoz
 n7+OEeWNc9zxJMulEiko2Qeo64u4klu/juWU2FQiyvvhdonzFTL987a/FMc6nOt9W3bzXgMOa
 8R6Xd9GuiMZgHiBJMYIRACF6OgVJFOLcEvttWJB1ZLtwsRsx3ELCNazlVMk6Sx47/4PL7kYKZ
 f9QG3akC2FQeYtvB8u3cYOwD2AH/RiBd618wvkZlteMX+hA+6sklw2UfKUC8=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 03 Oct 2019 10:18:08 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 03 Oct 2019 10:18:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Missing support in SmPL for wide char character
 constants and string literals
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

PiBBIHRlc3QgY2FzZSBpcyBhdHRhY2hlZCBhcyBhIHBhdGNoIGZvciB0aGUgY29jY2luZWxsZSB0
ZXN0cy4KCiogQ2FuIHRoZSBzcGVjaWZpY2F0aW9uIOKAnCNpbmNsdWRlIDx3Y2hhci5oPuKAnSBi
ZWNvbWUgcmVsZXZhbnQgZm9yCiAgeW91ciBzb3VyY2UgY29kZSBleGFtcGxlPwogIGh0dHBzOi8v
ZW4uY3BwcmVmZXJlbmNlLmNvbS93L2Mvc3RyaW5nL211bHRpYnl0ZSNUeXBlcwoKKiBBcmUgeW91
IGxvb2tpbmcgZm9yIGJldHRlciBzdXBwb3J0IG9mIGN1cnJlbnQgcHJvZ3JhbW1pbmcgbGFuZ3Vh
Z2UgdmVyc2lvbnM/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlw
Ni5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
