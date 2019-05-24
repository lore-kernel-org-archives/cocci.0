Return-Path: <SRS0=ZWNV=TY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAA1C072B5
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 06:09:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1303B2175B
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 06:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="qLb9IA/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1303B2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4O69WN6021042;
	Fri, 24 May 2019 08:09:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3C7A77752;
	Fri, 24 May 2019 08:09:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 113C77747
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 08:09:31 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4O69UXN022717;
 Fri, 24 May 2019 08:09:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558678169;
 bh=LGKTIdOlpYLmqNlwuTePDD0N6JhspfaUirJe9u2HVNM=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=qLb9IA/qMiWM3f4X6y+PAthSvwI/MSa2yZdcxoWK7w5Mr/Rm0deDgmA2JKLTl0dgX
 wgYdRMfMT/YhzVkSVAhQI2uITh9kG/4NiZVdnwo0rBZz2y/dgfCCHBGwuZO1C/PSUQ
 BOWVaMehQXCmavFDs/WUW8YdJcGws7r9X6eEPz0s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([78.48.148.166]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbhFJ-1hB9dF3aNx-00J2ks; Fri, 24
 May 2019 08:09:28 +0200
To: Julia Lawall <julia.lawall@lip6.fr>,
        Thierry Martinez <Thierry.Martinez@inria.fr>
References: <alpine.DEB.2.21.1905222114490.2618@hadrien>
 <81b409c6-5986-5961-5edf-843c6737d88c@web.de>
 <alpine.DEB.2.20.1905231500230.3573@hadrien>
 <3a79c8f5-9483-397a-eb98-adeb40634fe8@web.de>
 <alpine.DEB.2.20.1905231659010.3573@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <215d5cf7-b44c-8924-d049-e2a6e579f138@web.de>
Date: Fri, 24 May 2019 08:09:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905231659010.3573@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:deqjKaULbwJTHVgL+Opf3uEJ6gQNVkoGNGul8IjCoKnlXsyWKK5
 2mKPeKXU/PXeZ2vepBJvkcVahnFj6xhLP0wWPC07x12GKGqvoowA8WtQtY2EeHOr/NT/Snp
 nVPef9Eal7CZJKup7ZPSWF/4D3q4ZfgTwK1eO9QV9+c+rmqqxVxlrDqdT/XCqO+0mW6OPcX
 K5ybLVzmSq33hbHnb5+oQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WOrp4o2HRiI=:hy65q4yTuoNAyLyQHPagsX
 fGb8rOy9+BDr4nBEA7uUVl9ojWIQ9MY4K+zzkRpyq1RxdJaSEQOqj3Fn3/71FJ+JU51TmBHbC
 8R/TVK7Oi/He4s/H0YJmlfZJcTrUk17zQ0ss81EzZZse77tldtDcVfWOidcRGJ+jVstkvwvxV
 ObIlL6HzRYD7Ejd4iDo3XgjDAXDbnTKyMChLbhDYfsph8yZz6PpS/L5TbIU+SslxsPNTxdih/
 mk2XG77HbQMVzFwgVZ5Uggioc2nXVGQY20iiMPTPdIljA5VlnmlM2EZqy5xOxAweZE9JuZ1SL
 kPYxQGzcoWBYHvR00MYwvdL3HhKAH08kIY+G8Xe+9gfBcyLHE2ma96asZsIpyeetlHGGz8085
 s1CziwtjKo64adADFE9BDWJUq63UdbMpvXfLzg6i+FvJppj1lUNfesnW60uJlOR3L58fG9KzT
 2ont5mydT133tiH7biCR1dp8RKyMyNKtLT6tzmW93064aBZdAtQY28MhPESbaRKysl8I59Zb1
 TL73S5Bby/Yy4ro8tIZvUogL3ZwsJPDpQDSR7buS0ODcFNGSXst8s1FJdKEBxZR5V6lw1SXq7
 w52YCKFRDVve19oVZr78WO2ye8XJC2nufkVYi4vMxfrAWy8Tgat/tFX3v2aoAaIOdok3TSGVf
 vbDjEN76ZZPZOQ9wvp7u73ztVHyJytyvAWiOq+LINc6uUL3EkQ2qjgHXrmA5tw7Hf5NbC7oxk
 bxaR8nsfl9FZ/rUWbBKqKr0FrdgSXaLrbLG1c1SYDvG2/TIF2lmsp6dDfc3kB4hvzsQy8elIP
 mpwjNZ+nXEk9zYvFKC16+Wkt3v4mpficPPvIGpC1+OqTvsO5IKR/ahLxfdNuk+2sVfO3SAMaC
 2enonzuf8P7YXox3hULw/EWp+s7x2/CGH7an3SlXRGc+ZmpN4pcRErejzAY1Ja0XDf+aDCRyI
 IlgTuzLCVX19J5PjUNyiVoKe9I188YQq3b2VpRupuqNlmCT3qHVR5
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 08:09:32 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 08:09:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Checking configuration challenges around OCaml usage
	for SmPL
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

> You can do whatever you want in the ocaml code.

How will the following software situation be resolved?

elfring@Sonne:~/Projekte/Coccinelle/20160205> COCCINELLE_HOME=$(pwd) /usr/local/bin/opam config exec --switch 4.07.1 ./spatch demos/comments.cocci demos/comments.c
init_defs_builtins: /home/elfring/Projekte/Coccinelle/20160205/standard.h
Using native version of ocamlc/ocamlopt/ocamldep
ocamlc.opt -c /tmp/ocaml_cocci_bbc38d.cmo -g -I /home/elfring/Projekte/Coccinelle/20160205/ocaml  -I /usr/lib64/ocaml /tmp/ocaml_cocci_bbc38d.ml
File "/tmp/ocaml_cocci_bbc38d.ml", line 1:
Error: /usr/lib64/ocaml/list.cmi
is not a compiled interface for this version of OCaml.
It seems to be for an older version of OCaml.
Fatal error: exception Coccinelle_modules.Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_bbc38d.ml")


Can the dependency on the system compiler version be avoided here?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
