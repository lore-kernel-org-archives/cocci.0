Return-Path: <SRS0=zMkO=7T=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1E1C433DF
	for <cocci@archiver.kernel.org>; Sat,  6 Jun 2020 09:50:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4CD207C4
	for <cocci@archiver.kernel.org>; Sat,  6 Jun 2020 09:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="EQtDsVer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4CD207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0569oKUd021451;
	Sat, 6 Jun 2020 11:50:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8BE8E5D47;
	Sat,  6 Jun 2020 11:50:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 228783BAB
 for <cocci@systeme.lip6.fr>; Sat,  6 Jun 2020 11:50:19 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0569oIod000638
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 6 Jun 2020 11:50:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591437013;
 bh=3LqlvV+Gapao20MIRlAzijB/5ojzr5ylrz8mioMZtrU=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=EQtDsVero0V265FxvmJBqoAndXwM4fa5QV62WCKRAu1JnpxJb95vqaWtEa5Rj3kSB
 o8hqHjw0bFwenhyMcCZks6g7VkD1Qzeib+9ZS95JoKbz/ZeN8uJX77IcrIGwhtnA4I
 a8kN2lLLTwhABwwPipD/MLmwGF/TBPZciXQVnOrc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.40.239]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LshGz-1ix4tI2dM9-012JzC; Sat, 06
 Jun 2020 11:50:13 +0200
To: Julia Lawall <julia.lawall@inria.fr>, Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
References: <99ed463c-b7ba-0400-7cf7-5bcc1992baef@web.de>
 <alpine.DEB.2.21.2006060944320.2578@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cfb8a321-1f6e-8d0f-65c4-e7f73a1b111d@web.de>
Date: Sat, 6 Jun 2020 11:50:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006060944320.2578@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:Yx1m5ehjjoSp/+6A1QTCsqbBQy0z/uoG3Ml7FVL0miEjbD1hh3U
 Kn9UbxYLYJq/IBpK8c4C5mf3vdkX4xE4OP7cHEe/AulBY8RS/ww1Y3MeOnkuvYGzG2/1kVm
 tRYNXSpf238Kn4jPkQ4gdDiEqykgHx9i1EZtSAXIWtyDC4TxATP6iJ0sBePHsM6xp8d+3tw
 Ew8L/7X0ma5+uIvoaEp8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P3ONMvsHjCU=:zsYbI4HJMmtc6yHOc4e/X0
 P2jXLfp83Al7ELS4n36iuiqihzD6LFkBGpltp6P59byNq1wkQgwFT5gtDbttPIn/n4aVWVfEr
 jqQJZu66sZ+LZNLofjhmEzcg2PAeLv5yt0fzaLJrH2JU0hUOfSGMcxrZwCnAVFubLwfinYaaG
 UXXn1ZZH89GtkQ6R4Os7REcZV1hZKoLdTl1hzJJV/IY1HZPQ4pnKdVbKc6Hf1wlHT/kCMAiW7
 yWieQK8S6Rgp9mSUdaB2J1sNa437ba9OxsrMchR27y4BKZeUkIwndtvl4u+BjdxZtxtHYlntM
 vKeVslXhweYY4V0RwUep9cIbOLkLnfowbr9kRbK5q8z4NBxh9pbarThsdFiZD2C5K5ThvlTLE
 LsElmf9Po6Vi24GvkzKR6YzeAMFSOPsAhm11S07HORSCuf8wCZaOD7mnghAB8zozU7wyFqxHh
 rnoCmAkgukTEAwqVreyWOdavnUFDxATLuEIjjOK2NMmuMJpHyzuLlPI+KmIwWRD1HAY7ooGXT
 rLkr1dkxZ2jROstohPsx2Fzc+f8x2HuEthUyqvfLWacOJkif2ZKGGH11hVZqgRnk9G+Yn++sS
 bzk67V1CQTS12mWhW91yE0XZQsDTxRAimQ42ZkZRUUKS94lGDtwoZWLTywhAlVFBwt5/xMbFm
 swWxpB0KlIyy1zH+x5QjRkl7RaDrrNrMweGP1SgdAFLc/7yF8LkKG0JUAk6L5tpJW66IExGmf
 JtNCN5+Kki3q23P+onbz/rXtnG2g78BzBMbW2RfZf4RZYPDxRSX+otlQz060kWMiVLHCEr/sf
 fksQ3kN5zvrB+sYZikJAKxfqNPJg+C8Hw7Ik/XQtB1FY2gPDZ1g8EQpfBo+mMcr9iNDmXO/M6
 pjEFvG4MRsrix4YyupoqcfyI8ZvY66edzE7hZhocSKJVgJL2w5xlHDXAkrjUcXTsvWFFuQ9oP
 BkBUhvkEKR1+4oxV8m+LxpQDEanm05DKkcWtzqdtUVQM61FLHQNGc5NVEIR7wvLnIsZzPOewO
 PL1Tm1JmLLFqStkSWsZMSSdU5djEes0v2XSURa1sPtcofzF5Gwg9qSR8fVwp69hybr0i21XMt
 dN5vSXagJEuLEQXwaQFwWvq85o+xoHkIYyh9HASzYk7NIqcqExEVa/3ADf9ACCnPkNX5Q22Tx
 t7eRjJ/K7d54Ox6kKq2D4lT9HTp0TQqrZECcF/XuCLnVpvEMTCovRQBDYNB+KJiklCw/Ld5AT
 95wbzcIzPJssT3FGs
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jun 2020 11:50:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jun 2020 11:50:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] coccinelle: api: add kvfree script
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

>>> +    E = \(kmalloc@kok\|kzalloc@kok\|krealloc@kok\|kcalloc@kok\|kmalloc_node@kok\|kzalloc_node@kok\|kmalloc_array@kok\|kmalloc_array_node@kok\|kcalloc_node@kok\)(...)
>>
>> I would prefer an other coding style here.
>>
>> * Items for such SmPL disjunctions can be specified also on multiple lines.
>>
>> * The semantic patch language supports further means to handle function name lists
>>   in more convenient ways.
>>   Would you like to work with customised constraints?
>
> Please don't follow this advice.

I suggest to reconsider such feedback.

Do the previous comments contain helpful information?


> Coccinelle is not able to optimize its search process

The software contains some limitations which might be changeable.


> according to the information in constraints.

Will related solution ideas become more interesting?


> It will needlessly parse many files.

Such an effect would be undesirable.

* Would you like to clarify other software development options any more?

* How will design goals evolve?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
