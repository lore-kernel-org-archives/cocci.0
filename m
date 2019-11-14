Return-Path: <SRS0=zifB=ZG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D029C432C3
	for <cocci@archiver.kernel.org>; Thu, 14 Nov 2019 16:23:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE34A206DA
	for <cocci@archiver.kernel.org>; Thu, 14 Nov 2019 16:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="VYkgbKFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE34A206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAEGNIkZ025245;
	Thu, 14 Nov 2019 17:23:18 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F17EF77DB;
	Thu, 14 Nov 2019 17:23:17 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 765E477D4
 for <cocci@systeme.lip6.fr>; Thu, 14 Nov 2019 17:23:16 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAEGNFNM021414;
 Thu, 14 Nov 2019 17:23:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573748594;
 bh=coLkyaqV5QAks4EHnnC+fDEsbCOAAW2Q6/lDsJim8kI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=VYkgbKFRYziS3MpTmEQ4BbovvQXBc5MzhH6XUVcWSZXOC/g+P9P1SA7x2/olrOzUz
 VlN5QrHjS/ndjsL11aChgiCN7nMlz7JKXXZLkAbpLMAqmzCnn6pp5m8e/qDKJD6ml8
 FnGFOkiAeIoTJgbbno5PcFOaXqSiYecXxToZVwEk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.120.12]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MOSAP-1iYI2J2vgL-005trK; Thu, 14
 Nov 2019 17:23:14 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <94469840-64e2-8189-db8f-c25b7efde2fa@web.de>
 <alpine.DEB.2.21.1911140732420.2239@hadrien>
 <02066756-1db4-937f-9159-64bddcb4fd37@web.de>
 <alpine.DEB.2.21.1911140802040.2239@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dfd7ccb4-53c9-5427-d19a-56b7401939e4@web.de>
Date: Thu, 14 Nov 2019 17:23:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911140802040.2239@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:JWnY8flGwnkp14vYFWUcOTH3i3l1+aNzqVG77FXYszTv92PxLPv
 DxfBw9RqR+JbBoscVFLf2RgwZ6vtKc8hN00uEKGmF7lWaMXm5QywOGnxMgK2dkSv4I17ghq
 ibikDWaaYlHr2dDQWNacdyuOClSJr37zZ4vIDK3U+At8fhiNh23T0fLQM4J9gKMftwCm1CE
 5zX1P6bqq1JEENxOcikEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S32QrW7UBmI=:zKs4DLoKav0c5sIWfZM12A
 oUun4Ufsc4mir7IC36HJNW91WjteRWYNgzbVlUu7gJdKLuHgfvpd3gbWJnRsgm4IDumXDW+3N
 OYLjz1UrIGyZ4/LhEY7yNE4mKabl9eQgIgUzMrgv8HoZSw/u5FOye8Hojrm+yX2mOUSI1wevP
 LQ5FUvlY2fvxJY19PfBwZRxQriCC7R5yaox0EZhsfijUxM+FQi+ztfF3DWwSezVx7wcDwe3R2
 qKfUombOiO/A941SqSKK5yBFZoJa/pid3Ph08RTjwPoJ8roo2MnGrkGtnQPDlJlkgdbjs+4J1
 Okvr/aoI5KTzn8UAPgZwJwgHWxSJXz2N5NOEn6junQmqXgFxs7WFW68IDqXlLFWakFNzlY/8h
 /t6RJ2LZ7WRibTlpt4vGh4XFwiYCmc8tdLMrLHPO0UEbQCuyi5AGc8Fv6z9UNEHrULGldIMqH
 dlGmw/YclkPAsxindG8pI/ELACajn7rDqs8RhX4k6dYmEe7QhRyZgF5R9+Q/tObhA0XVWsi1I
 uZs88Dxydl3caTumpdQb47OWzNfav65ROcwjjVhZjzBj+I3CQbi5aY9sxSVUILENYH2WGHuTH
 ZOON08puOz6gz0xVv/E3KRiEV4OLDSu/iFCrldcQPs+9LyFHZsGyrGTJgZteboDstbuXdLwzF
 VoRPGzavPsfI0OLc/nar7UuUhKDpMEINX8StQF+PSptN+SleG7j+Zu3L09KiAbjDWjUjuNseD
 hxv65dEnQXVMdnRvdm1ERZiMUpjSLNes5MBMKu/qSqMybsfikfTBkoTS7664qxJDU7FUPCakD
 3xzKk6KkmBw+lk5BIFOMHOdwEPhKMXc46lD6cVjmvcwgpv0TZmw4PsHaAh05jv2b1PFKcI17x
 f5MxGJQan8K8hoUw5tXTImFEaRxX4y8bce2K1BUPINJyY5V8yWg1+xDlT1UBy7I/SQqEXsc/v
 E7J7V3S22unMQGYR0Ts4KKS9+8FpTeN/wbR+qO+z1xedI4eXOXCrkd/r7lwk10gS/P5hAjzSw
 xN21qVdmtp7HeDdlbPkUrSlyr9AhnAY0yCmkCNas/Uqb8vgUNHgmpjfPI7sOrpTyxulkCUjMO
 y7PT+Mbun7oT12y41VNbNEfvmfcu0gYc4CMeyaLC6oEIFd6kC5yLzUSLqA1KTb5HX0R+5dtba
 YtxwDKyhDFgy1J27peI6Y/+nyMv+Q25D4udWV/C5r2cXJEliCV9PHGPDjq7tyZk7ykYSRTML6
 RNht19n/WHUqubIyMm0pFkOVfWcxXUSZCK35pAMAB4ZxviDfkd1s/JLGgolk=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 14 Nov 2019 17:23:18 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 14 Nov 2019 17:23:15 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Using a metavariable type for function calls?
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

Pj4gQEAKPj4gbXlfZnVuY3Rpb24gZ2V0X2NvbnRlbnQ7Cj4+IEBACj4+IC1vbGRfc3R1ZmYKPj4g
K2dldF9jb250ZW50CgpUaGlzIGNhbiBiZSBhbm90aGVyIHF1ZXN0aW9uYWJsZSBpZGVhIGFyb3Vu
ZCBzb2Z0d2FyZSBleHRlbnNpb25zIGZvcgp0aGUgZnVuY3Rpb25zIOKAnG1ha2Vf4oCm4oCdIGJ5
IHRoZSBtb2R1bGUg4oCcQ29jY2lsaWLigJ0uCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNv
Y2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3Rp
bmZvL2NvY2NpCg==
