Return-Path: <SRS0=hTpQ=YH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BEEECE58E
	for <cocci@archiver.kernel.org>; Mon, 14 Oct 2019 15:33:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408FA20873
	for <cocci@archiver.kernel.org>; Mon, 14 Oct 2019 15:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="MopiDIWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408FA20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9EFXPST015199;
	Mon, 14 Oct 2019 17:33:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3E0C877B2;
	Mon, 14 Oct 2019 17:33:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A00977792
 for <cocci@systeme.lip6.fr>; Mon, 14 Oct 2019 17:33:22 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9EFXJul022186
 for <cocci@systeme.lip6.fr>; Mon, 14 Oct 2019 17:33:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571067195;
 bh=5WEhnwwuvsaVMTgtiLIqsrXzrdmADNjGbDqt0CrKlpA=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=MopiDIWr6XmNID1gH8cWM//DdlQ+YZQ7+Qgo7u/g26lJxaBKSspY4uIHL9OIX7JIC
 QnxcemaDOCxa4DhVZ7t1HA53hyznwUkPS6QU9Wo6sHH6OxQ1wJcAe8Ho0Z4O3f+/cu
 /xytg+PUSSImvR0vXjhIdMq6J7HfgquSs6kDIa2s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.26.106]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfHhK-1iiqcT03gY-00OsdE; Mon, 14
 Oct 2019 17:33:15 +0200
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
References: <56e7bd73-5b50-ddeb-9a56-62daf93eb015@suse.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <56102ab5-b633-7e14-1fd3-3f43fb0770b9@web.de>
Date: Mon, 14 Oct 2019 17:33:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <56e7bd73-5b50-ddeb-9a56-62daf93eb015@suse.com>
Content-Language: en-US
X-Provags-ID: V03:K1:/3L4bFNmgIt6ZcwIt/N1A9f0L750ZHhUEdhmoWD03Mg0L9W9q1N
 XG013v86QPno6gg9JcIgLAPYGQgPzrUGA6OrKds6ImCb5vChHTn3rGrTUP1sz2Uivl/gErX
 9gcG/bng4nwOid7edlk2D1j3GmmcBqVREzqRqB9nBcXWIJ3Dc5Nx76BbxSCdIs9ObDP5LIf
 i4gyviFHGGxOr9B8E4ZrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pgMgf2mk0zk=:4+lq85YQObBDqyqXTjlRD0
 5QQ92hKSJwurENlkNAd7OfMm5Xmd37JjyBEODNVdvow7HJbt1nM4CQUK2E9o+a36uM+NNwFMO
 xiSB3FBJxyNj5jm9/Wb8cZEx4VrT3V4T4wGRlhgbOWdFySmZV1SBDphF0yXfHHqArHD6hnH9s
 EFubFmIBHXWH3J7vkTXpBU6qzkIo3T2fIP9gL7xZgVJWDFlLGlcBqj10cpUti3iHOv8wMK+y6
 LemrUVKS12/2t2xY7cVbYmkWEuQ8kJVAWE9OgDtRTGGNywcRZKBNDnew/mdvFAh3prLhmAVX3
 v+ZqZQKH4J+5j+rhrUFptImmtHIFwejMm7DXqjEebTzu4VnPfhsEDqCFvd4SYBUlyRK72Us7j
 JCsj11Z3+rrUfxMHjr7NgD4BfcFSx69Y28VmAmn5L7EHTbEa/09RlZ8pQh8ILA7bwQc3L7WpG
 0O9lMMiSf+jcq75QltrdKJ9+9ol5rp2i2J27edRMA8ilpwHGjftMpOcJpi7ACMSDecdx1YUN8
 Nd5h4LXGsS8ywrPlfx+/l1RZZ5vKS0lL8doZO0/DnW2Mlg5abd6dCHquQ/NHticXAH1xQgvYc
 FoPVfaSxuwTIgEMlogvm1lc0pB69otytZTbLpkDFJKCRRFAwRkXB09x73NOpTGa6gMVy89GaS
 CVDV93qIQBRtZWpoehbvMONRQ+7q0jjRAw+ecQPwqD54519R2lZoRh769EzupKP9PEKoWbH69
 gDVc/iGiCcL3Q4Kua20MkgiUmbWwBhuMXUZItuHkIvH75YxKvWIfDqPuecX4XnuwiThaI2ZP9
 4HK25QXZZFDeutFYOVSBJK0IISkKTbM5r9f7G0cpv5J6gABq+1jgVji+vliYhIjDCUXkXZWEg
 9oV6TpU3rOifB51K9+onkqh0Pl/d2bOlk+yTDY/IfGyEhaJopLUjBoiG/Bh/OTLFLIMS2MVGo
 1bbfSj+NLx2oUXfEBwVi/lHxBu2jomsh432vFBkyeJSVdGLgXAbsMn6/fnoQyJGc6luycxCzW
 tgFPt0CrUJlC6hfPdv+/Wg93rDOPr3pBFy7hbQ8ERYZnBpPcAMrK94OLbRl9mURJjfEUbEV+P
 HoIwElEbUpWb7T+6k1VBFF3733pm9oDgYQ40c4W6zEgwnunKw+lWtkrWt2rOH35gJJjqLA4UO
 tVyFqNCe+wGzU6qnHG11vRz4ODrAm0Vr8Okr13p2APpvi6R7qFwPUC7q6Y69GqHfUFd5lo6kP
 9kqm4DlxS1EhWNE2KmGa8csIgm4gwvpz4iqZUeqAlj1Muwk8D4+eKLdEKKiM=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 14 Oct 2019 17:33:25 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 14 Oct 2019 17:33:19 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] macro parameters and expressions?
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

> This works nearly always as expected, but not in some macros.

Do you find any information from previous bug reports
also helpful for the clarification of your use case?

Examples:
* Fix search for parameterised macros with SmPL
  https://github.com/coccinelle/coccinelle/issues/94

* Complete support for construction of #define directives
  https://github.com/coccinelle/coccinelle/issues/139

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
