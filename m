Return-Path: <SRS0=b124=YZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB893CA9ECF
	for <cocci@archiver.kernel.org>; Fri,  1 Nov 2019 16:12:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E39820656
	for <cocci@archiver.kernel.org>; Fri,  1 Nov 2019 16:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dDnutPPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E39820656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA1GCOHP015365;
	Fri, 1 Nov 2019 17:12:24 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3762561B4;
	Fri,  1 Nov 2019 17:12:24 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4C9D0454C
 for <cocci@systeme.lip6.fr>; Fri,  1 Nov 2019 17:12:22 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA1GCLxt029066;
 Fri, 1 Nov 2019 17:12:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572624741;
 bh=mfyt3fwWQHFKK00eZKX7mGe6iNJI2TGmS5sUIIVplns=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=dDnutPPCgFjl1zVB1GP76Mba2rXfcdGEM8IwRHdmo8cJ2W4uyhhOen/vjbsX9IT3Z
 /9/qyLnnj0iI1zciraGGIo9eOXE7SzSkVeFAafOnCSY8RAEqrxmznkvGwGKc0vfaFV
 PBotvFbsZ5cjPWkMjMh6GI/kctcLFWa7DLM3dt9c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.35.66]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LzK61-1hw8NY1DJh-014VaV; Fri, 01
 Nov 2019 17:12:21 +0100
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@lip6.fr>
References: <708207db-69d7-8962-e507-cd705142d0c4@web.de>
 <226b4ce7-8284-ed03-a478-98e3e532cb15@web.de>
 <08618116-cd93-fedb-f90e-64c17b319794@web.de>
 <alpine.DEB.2.21.1911011037250.2883@hadrien>
 <2f83ab36-33f7-f49b-8ed7-e8aae44b40e6@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fb5224ad-fc1f-e6bb-ae9e-58c5850cc4ec@web.de>
Date: Fri, 1 Nov 2019 17:12:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <2f83ab36-33f7-f49b-8ed7-e8aae44b40e6@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:SjO18X2hc7e6rBCvbIjX+TzXRMrs5m5A+lqIr80pNX2BGc4jEyn
 Iqa1sfmz3ht8IDEwcAXyQMuxL17VQhNkbiJl31YFhwckZaDwn1CR5nmPKk7nUUQ2Et1E+cZ
 5HNoJvK4k0o2xdo4lZieYd4e+91fbp0W8eXyHg2pPLqBckkh5abPsFykRgwc6+ZzCXMJ7g9
 5FceDO0kkXtgHVMNrhLQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hxkMOuUxlPQ=:DUkirXyttbVTJ3nCpmt2J6
 8WAw/RVyCaHP33up/GEiQUDCdWqUXBGgESWE3o5u6oUQ4g04zWWXK9lwDFYNXk1tjONkDNmMh
 MtJPcRMaLYLnlLp91qbu5aF5Xl4zwLMt0Outbdrvx4N35gLRNSKWY8EwtN81ZmoJZzX21/weo
 1YpSq2NphDQP6h5TCtILQWiUM4Bb9N66df0XMbupZY76i/ZMvtuEEo8N9A5JXfrZqiKlfvHcq
 w5hkSb4aa5/yus1kql9XZXBkbT+pPWD7Ik7xOZirXyx3JGSIHlVheVMJ88tOimVC9o4PN1Jsf
 NnmPiUhMUMMJW2wbp6AvJKmaRJdxM920oaqXNiC7VwoOvvluZR9kxH1vnLzN7q11pr2equlbX
 N+Q/u0VmgQ6eyd0jayhCRqhoxsOcKwuCZGgOfV+hYD4aYI4c32mxvzZVT5n105383ozUdIAWd
 X+WMnvAxvPseXFMBC+8Rn8JWjp6dyoFDb2MlxmIhu5ICKFcDv2ogFWIGHJstpSct5+2to0skZ
 3qnNWQBmsv0z8+m+3JKCEfetQaDsgulqahBakf7H+7OQduD3cV3VTciuhcCXp3jfwLYFpYoyS
 E9RMhEZ7mjP8BY3QfEdg222NJ651dC/QNUEibbCyxVU7oHRtBOhtgaZX27vT+I+3Wpw21jELI
 wZb2Y8iqbPDOPo+Hp+uNPSaIjOaf1s1nt/ZLr2mPOPsM/ghis0CGQP89EUN1nBl5knWvJmN9/
 fqTJAmJokAus+/NE55HLbe7wEZMHTf+9hK+FKOxvhF/TW92rkdWiHg0ValnVoL30isPs7Li5y
 C/ekIHT1yh0fFs9uwAgtk5IepmH2hubJ20kWzzDsPX9ZfSH1oOWklzNXtmWcPG5YR4v4d7kQ1
 C/f/uulRR+hmRuEGVk3+pxZtzGB/amewVTbQlQEazqt5nw+NiZ8kBK45MkiDf1Of4qounvQDC
 WdTJ68zB/+894gSFi3C00PRpvXdw2AAQ0ZkIIEriL5fk8f9pFWL6Iek2Fscblz4qG9/rl/vHy
 dP7SO4XPbBaCrk+mtZV8fcYSH1DmwztfwdCR+o05dLkLFpS6OtkuvEOGnBWTbH0Ml/maXHUFo
 RDzPAAUkBnhzhpGsDtsXpsZIF5vrEg4N/nAAuZkOfP9JEm3CZkgMdOzospIOtPNiNxU2BFbnl
 gRO4l2lRrmc+8XQlvI4tfzuwLM7U8OZKgw5nQs90awZuHCfPg9QAdLOHl2qplnXHqoMTyU7Nf
 gqkUKRekvx1hwO7poQvfyq5v9zeyWwE2tta2THrtR8wVYYfWnYFUkej/AP/w=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 01 Nov 2019 17:12:24 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 01 Nov 2019 17:12:21 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking code layout for adding jump targets with SmPL
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

PiBJIGd1ZXNzIHRoYXQgYW5vdGhlciBzbWFsbCB0ZXN0IGFwcHJvYWNoIHdpbGwgdHJpZ2dlciBm
dXJ0aGVyIGRldmVsb3BtZW50IGNvbnNpZGVyYXRpb25zLgoKQHJlcGxhY2VtZW50QApAQAogaWYg
KC4uLikKLXsKK2luZm86CitwdXRzKCJzdXJwcmlzZSIpOwotfQoKCuKApgplbGZyaW5nQFNvbm5l
On4vUHJvamVrdGUvQ29jY2luZWxsZS9Qcm9iZT4gc3BhdGNoIGVtcHR5X2NvbXBvdW5kX3N0YXRl
bWVudF9mb3JfaWYxLmMgcmVwbGFjZV9lbXB0eV9jb21wb3VuZF9zdGF0ZW1lbnRfZm9yX2lmNS5j
b2NjaQrigKYKQEAgLTEsNSArMSw1IEBACiB2b2lkIHgodm9pZCkKIHsKLWlmICgxKSB7Ci19Citw
dXRzKCJzdXJwcmlzZSIpOworaWYgKDEpIGluZm86CiB9CgoKQ2FuIHN1Y2ggYSB0ZXN0IHJlc3Vs
dCBiZSBjb25mdXNpbmc/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUu
bGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
