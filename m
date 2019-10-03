Return-Path: <SRS0=jkZ/=X4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02150C10F14
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 09:16:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4671E2133F
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 09:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="YQYAgt73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4671E2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x939GZpW028269;
	Thu, 3 Oct 2019 11:16:35 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AADAF77A9;
	Thu,  3 Oct 2019 11:16:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 91A8144D7
 for <cocci@systeme.lip6.fr>; Thu,  3 Oct 2019 11:16:33 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x939GWeq004404;
 Thu, 3 Oct 2019 11:16:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570094189;
 bh=dyDx3dQOarAjd0PKhRkDKcTfEVm0p3+zSMIx1o6e3mM=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=YQYAgt73O7FklEsLhU/4KzeF/mDHxs1IFTWPsUrFvBBtILRR4yiizNvBkqsTDp///
 H25OdA8J/SK/VZuGNS8Xs8Wfp/8CwI6wU8z/fwRUJpMINrOSpwpfIRMBj/YFs8MP4f
 bXswrEgjiKXyCuQ2dP1TyX6DntljNgN2I56iYPwU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.81.27]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MZlR4-1iZGDr0VFm-00LXHi; Thu, 03
 Oct 2019 11:16:29 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1910030745320.2638@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <11d359b7-118f-a93b-f83c-89cdee546bdd@web.de>
Date: Thu, 3 Oct 2019 11:16:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910030745320.2638@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:rML2ypdyqBYB122qokKJLpJm2eoBwqOJ8EZriwhbDfPqS2rXi9B
 ghXZPP+PgicvOpSOqngOfxGlHJkzKgtAzpUBkoue//ltRAeLNjqzy6uAsiiF5Qe2WsnX/2d
 EvV4PIVIdtaxWWhvvNHjdxmaYz47A8UhRRY9l4qvhZIj+dbn/wKtUIXWA6JT8TQY7klBO2u
 ZsBKg1QQoL7jyyAtC807Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ko7T/eMfRU=:hBxztTGHe2bC8nt1JZiH3a
 EeQ6PqYpClisqiJEITodtTJctbMWQIX3rlsRuDNzlb0xq0RdvsZUvBg438kX4Rrb73McQGVON
 gdmLZ7obWTbDu8cXOd3/tnpYIOegI+QJKkWj90BLt8LvJuTU2ROF2mXosyBJMNMYxv33mV5zJ
 jjRmhQYEfBV1jZo0RB/Ir7BOS2qumb/9iJFxhn2cL0sWK/oAelr89eN7bMCmiiP1ppVFf1GF1
 X65B4hcEYGL8opjP2XSV5m38i+aN+G09OOBT6t4rEYRoXi89OZp65LzolODFCZSc5Z/J0tj22
 NtCa7RJb0wU9Rl3YpxSFFZWkplkftKixGIs//L5UA2ECGl/8Cr+ZRB9op6W8K4c9WrAGBymcc
 NeJfKhNEyQ3O76rjyZsPKt7+8olcCjrsy0DW65JR17FJBUwihMAaAldZ7SX6+SYTK3ndYCBWi
 5SMGGwnIwQdIdc9iCj9RHyea55L43k6qJGLsoj7AGXAMzDiSiLiSbg22xeIVls61kJp3xk3sT
 56UNMdJGecOeL4tt7fn+VCK8pwunJsKjgGbumcfdhCi2lzw8sd+wchK+MJYuJIvOKsNYrBA0s
 yDLUnut7ZdySdbYdY6lIIirAyb0CtF3wi2zqMFLn1gTwLdi34sfb8R36921mkUoOjZr3I3iC6
 mkLdupNCVto8WH9k7chZWF4NQVjMc20mG1qRtcjhxohhp2sJmFIai1LpHu0Ez74eyYJzioi/C
 XRHkost92wUNtV0OIv7LgFgxTGkARVFHJ0r57iB8l4DnkGUI79teHsWw4zzO80lUFxszb7h+h
 WLkv1VQ3yAh8FsgC9zywO35wR5vSbsEVAVSTW6NuNWKtdkNV8FMz+5L16btSSmc3mOzlFkGmJ
 HvKn/ADMoXiZh+g4RUKPcOOou0q9UfT3ZT8QjLrCIxYQMmRt+lUD2EP6SGTJ7jgUcDCSkZqU+
 1mj3hSvXUqxtkJCowf4FeQ1gBAX33zJ3J0Xf3c9Ba3ED4EUFFnwTh2gSRctsylOVXbHu95ied
 6XXA0EzvtyHKouphwQw6lXl0H9qCWP10UBAJiyGjoiSM054nSZEj1Iqx467cG2mWGt7Jya6d/
 h9T+5yBH5KeSz6D5wWkMiuXfqayOWPuM2s/D9raPUE/5gP7+Xuu7pJPFaKSJzTpKAm+poyDiX
 XWYboVaBKM/YWlBLBHrYEzeUqSim9XqvFMOdWgzSip3aJCQO4dTK38yJRDbyJnpPqs/67RkFq
 Vliw9CxyF8toS4pA+gSNZY99uW9JlDlOw40tEcC5JrchGJUpH0nQoCaC21Ng=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 03 Oct 2019 11:16:36 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 03 Oct 2019 11:16:33 +0200 (CEST)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

> > SmPL doesn't support the character constants of the form:
> > u'c', U'c', L'c'
> >
> > nor the string literals of the form:
> > u8"", u"", U"", L""
>
> What is the type of these things?

I suggest to take another look at known information sources.
https://en.cppreference.com/w/c/language/arithmetic_types#Character_types
https://en.cppreference.com/w/c/language/character_constant
https://en.cppreference.com/w/c/language/string_literal


How should literal prefixes be handled by the semantic patch language?

Will any additional metavariable types become helpful for this use case?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
