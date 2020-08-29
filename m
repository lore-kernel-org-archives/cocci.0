Return-Path: <SRS0=mjN0=CH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5E4C433E2
	for <cocci@archiver.kernel.org>; Sat, 29 Aug 2020 12:47:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22D22076D
	for <cocci@archiver.kernel.org>; Sat, 29 Aug 2020 12:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="RqRAl82I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22D22076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07TCknOp014762;
	Sat, 29 Aug 2020 14:46:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F14F5777D;
	Sat, 29 Aug 2020 14:46:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1340D3F6C
 for <cocci@systeme.lip6.fr>; Sat, 29 Aug 2020 14:28:20 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07TCSJc3027249
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 29 Aug 2020 14:28:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598704098;
 bh=oia0Nyl8NjpQk8j5i/Mm4u0YkoGHtuwZOAhrlOJqHcA=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=RqRAl82Ixg5fnMHim6cn/kJ7XCy7bm0ROXA7dnf2tK78J/C4mTxpA2THe0iKdju/T
 TWsBhB9LZE9e555MIfMXsD2KzamI+wil9Ap5r+flvKwAEY2Y9jl740Np3Ar5+tGaLF
 jlk0sOnWmww4qJAhN3xDYtLhgg4DWLNTkbzEFeUU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.31.245]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSWzU-1k4Ghy0odg-00RXBf; Sat, 29
 Aug 2020 14:28:18 +0200
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Denis Efremov <efremov@linux.com>, Coccinelle <cocci@systeme.lip6.fr>
Message-ID: <b131add2-f494-d129-f83f-ef2c6de7a849@web.de>
Date: Sat, 29 Aug 2020 14:28:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:pvT4YcAKFr0owpooKCj5YgprAeYUSbmD4wVsbV9B4T3gOOqdcJZ
 mS4Lh0jWk11ipoM76ZLV0Olzd7odIW6ul33a//SICoIUs8/SgYef29dMURXpLUf9oHQey/J
 W0sO3Bc85DNcawgJVOm7d0a7d/Qx+AqDuj+bTKeBOrT/cB0/45NDgM7ah0cAYLIbRR5u/G+
 whdsAyp9nHNyRMEJEGChg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Veo/DYLsiGs=:G3ooA5N2jOrhd6B77nihR4
 GeCF0xnnfQpsmCmS/jsUzLHYMTCfu/4Ec04drJc4Z5agHT1W4tRJVjGbdXPm488U1OcWP9crN
 FREb/QMRCaWYj7O6A6jZAd9KXvojL1UViWPJpUD4DISTU9o/5u6tzkHg2xsF/O84YWI2anMVw
 VEO9GBDdoo5l+LqznusXFWAiiKr7Q6UYN6siOFvhvtAmV1ZqBQ0BtJ2C/qfP2+6Eu0DZz61GK
 kG8TJAfI7rjNxXo2zVcZffWTHSxkna0aiRpqzoDIBUWN8sU62HWAhBLGRv6fCIOHgzTA4vgju
 xeVyjbgkprGYW87JlqvF6VFwLg9oiTG7CGf/ozzRovqkho1Tg7r2KeqJtBZEDjrJn/J7qrKz4
 Z9LkKj84JH2Arkg3J8c6vvm9qgXKK57L9iJRRrMHer8U+IfzBFY5QOucHHKrhQfchDGvvbH/Z
 fUK0gvYblWzCgJI/P9uhYYBz36XKef66LQEIwsDSqVOWrkWC8G9LhfqC23KQTE1G1jUp2fBhe
 RgABm+wKPQ7gK6kXFWVb8NJJ2Ye5CN8wtsgVese5rQQ282rFIGUz7+RlpvPepJowS29A0Pzj3
 rO/jBd5Q3eFWNQETf/S0DNqcdw3+D2pVR+PpMzfaw/3WcgSknx2VPVfwimrGD+UD3syTm8Cv+
 fsjbQl4qASSIg3/eBV+pK2MUEbjoaNKGRsaZRdx0QE8Jiz0LbLtxHRLj3WsyksIVMH1PRMMwX
 1ftVo0ohU9+5Bx6G36ryKp+EZx9kHIm+ImEBSnBhH04oRzx64X8pn1cDPk5PLTpI1lSdtrGSd
 pKaXjydZn8ZuNL85WNWx0i83oszt/cwxNbVyJ8ajZcAnf2+OowIE2UH03Zjixs1ZMYmaQJ+R3
 7uDQEBsCeYB7ddU+2mbTfumBsKQL230JDvAhr2iKp5bxkfJu/HCgLNXrY+LyL6RyJ6YpzBtks
 VI9CIPUJEabLrKQadk0mmkNLxlSZKV7JIb3hocDX/86Yijhm7MYMOVQp2eUWPMq54QOP3Ot4r
 bQUSFUY0fbERqKwBv3Lcf6p1THNEeBsb/WiYIgPKz8QXUduavNAawnseMlmMF1Pj9XRT6ZtFL
 uf6NSX6Kz/QRUlY4PNrUM2iTs/g4h4kebH70EGMK2bRwjxF9ZW6HOL0AjHG38a0/IkdCul2IE
 4uqcC5JTtZKVImXqORqvFX+NzVmHQVpDjHg86aYGsF7OAcE0nojG14A/0gyUd8XH36JWnfH0D
 kKh8/mfZ13YBY2O8ZjZJoW8wGmUpl87U2Ic8uFA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 29 Aug 2020 14:46:49 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 29 Aug 2020 14:28:19 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 29 Aug 2020 14:46:47 +0200
Cc: Michal Marek <michal.lkml@markovi.net>, Kees Cook <keescook@chromium.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [Cocci] [RFC PATCH] coccinelle: api: add flex_array_size.cocci
	script
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

> Suggest flex_array_size() wrapper to compute the size of a
> flexible array member in a structure. The macro additionally
> checks for integer overflows.

Can the following script variant for the semantic patch language help
to clarify any software development ideas and remaining open issues?


virtual context, patch, report, org

@decl_flex@
identifier name, array, size;
type TA, TS;
@@
 struct name {
 ...
 TS size;
 ...
(TA array[];
|TA array[ \( 0 \| 1 \) ];
)
 };

@ptr_flex@
identifier decl_flex.name, instance;
@@
 struct name *instance;

@struct_flex@
identifier decl_flex.name, instance;
@@
 struct name instance;

@ptr_flex_size depends on !patch@
identifier decl_flex.array, decl_flex.size, ptr_flex.instance;
type decl_flex.TA;
position p;
@@
*instance->size *@p \( sizeof(TA) \| sizeof(*instance->array) \)

@depends on patch exists@
identifier decl_flex.array, decl_flex.size, ptr_flex.instance;
type decl_flex.TA;
@@
(
-sizeof(TA)
|
-sizeof(*instance->array)
)
- *
+flex_array_size(instance, array,
 instance->size
+)

@struct_flex_size depends on !patch@
identifier decl_flex.array, decl_flex.size, struct_flex.instance;
type decl_flex.TA;
position p;
@@
*instance->size *@p \( sizeof(TA) \| sizeof(*instance->array) \)

@depends on patch exists@
identifier decl_flex.array, decl_flex.size, struct_flex.instance;
type decl_flex.TA;
@@
(
-sizeof(TA)
|
-sizeof(*instance->array)
)
- *
+flex_array_size(instance, array,
 instance->size
+)

@func_arg_flex_size depends on !patch@
identifier decl_flex.name, decl_flex.array, decl_flex.size, func, instance;
type decl_flex.TA;
position p;
@@
 func(..., struct name *instance, ...) {
 ... when any
*instance->size *@p \( sizeof(TA) \| sizeof(*instance->array) \)
 ...
 }

@depends on patch exists@
identifier decl_flex.name, decl_flex.array, decl_flex.size, func, instance;
type decl_flex.TA;
@@
 func(..., struct name *instance, ...) {
 ... when any
(
-sizeof(TA)
|
-sizeof(*instance->array)
)
- *
+flex_array_size(instance, array,
 instance->size
+)
 ...
 }

@script:python depends on report@
p << ptr_flex_size.p;
@@
coccilib.report.print_report(p[0], "WARNING opportunity for flex_array_size")

@script:python depends on org@
p << ptr_flex_size.p;
@@
coccilib.org.print_todo(p[0], "WARNING opportunity for flex_array_size")

@script:python depends on report@
p << struct_flex_size.p;
@@
coccilib.report.print_report(p[0], "WARNING opportunity for flex_array_size")

@script:python depends on org@
p << struct_flex_size.p;
@@
coccilib.org.print_todo(p[0], "WARNING opportunity for flex_array_size")

@script:python depends on report@
p << func_arg_flex_size.p;
@@
coccilib.report.print_report(p[0], "WARNING opportunity for flex_array_size")

@script:python depends on org@
p << func_arg_flex_size.p;
@@
coccilib.org.print_todo(p[0], "WARNING opportunity for flex_array_size")


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
