Return-Path: <SRS0=v8/u=UF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB78C04AB5
	for <cocci@archiver.kernel.org>; Thu,  6 Jun 2019 09:15:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03722083E
	for <cocci@archiver.kernel.org>; Thu,  6 Jun 2019 09:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="YbXZVOlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03722083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x569FZ2O005612;
	Thu, 6 Jun 2019 11:15:35 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3C9A27760;
	Thu,  6 Jun 2019 11:15:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7A602775C
 for <cocci@systeme.lip6.fr>; Thu,  6 Jun 2019 11:15:33 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x569FXoY025674
 for <cocci@systeme.lip6.fr>; Thu, 6 Jun 2019 11:15:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1559812532;
 bh=orUWLYeS1eprqCTQwz4FEqsVShnnovsv64tUxEXQW8I=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=YbXZVOlX4nN2PObPCYEzcISU1qO1MFCMYPYjZfulOUFBOmyYEx1Ub86ePBfXCSRln
 soMRliFj+72vWtvrMcfdZc/AF6Ls6X8n3gtOzsT4KpRdPOGSdeaqxCWCZlu5WIseso
 4ZODwGRKRFPI7gBnIw9Xi8UW7ByoOTQD6GNsMjX8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([93.131.14.146]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtoGb-1gaQIj2NN7-011DKB; Thu, 06
 Jun 2019 11:15:32 +0200
To: Enrico Weigelt <lkml@metux.net>
References: <69c34970-8b6d-a2a3-2e8b-0b6560f78505@metux.net>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6ebd6ec8-bcd0-3dac-8992-a6c8d9a14939@web.de>
Date: Thu, 6 Jun 2019 11:15:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <69c34970-8b6d-a2a3-2e8b-0b6560f78505@metux.net>
Content-Language: en-GB
X-Provags-ID: V03:K1:+lONvSXJjHoFTfLVPD+kl4zHqqW9yX9aywAaOH1yS/i7W8TIwWf
 //SmJs8njA2uoza/o9NytbuWxLFtS9yCY3Ysso2G1QqqbUHldoh6jbVP17vWNEF0BhwAzjY
 1fDDepCLmjvuruHFKh6H1lB/5bde/3cPQayY/Yn2551mHftABAeYLwMN2hoWrUtap4Fx90e
 9IqfRVq6L/BNFSqJMxrsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tZTY3S0gaGw=:PnnRKNceQydC3TNCzqbzMA
 Kpia21vm9m1zktN9PKBo22YEDXlh2Kyog8WITXOkc3SmxjVlR8blqED9P4XPb+vDTYgOcFvUE
 /jBO2kGLGHcAd/3FwSVSBRr0rx3HUvFnSvixwrmHjTEt+71jXqJO0+4I40rUus2C5MVC3PMNs
 +iO4dQA0yKg5a8zCIfnRE6jpGH36eIT2PH8PWf4rldZNhsgxchhjVNmEibcYQsK41r0QwY9pY
 vTdRIVNk+FKIjKroGJtYIPPu2JDCbfYTj/ic45CM8ftQzHBEU0XMoV2/IxmyfBX8942Crph9g
 X8ndQD+jXQctTIRyHni+FlUQRKaCHo4LFSl1VMKshl+5Fy2mrFSSJBW8v95jnvo3cNl3WkXsy
 c5tTIgxEKQQ+cHmBFfQKqoQIg+CPYkdyw+vSJvlY+zW1nl6Rw4EBIKKfAXqXbT6BLn+13SmbP
 7QzXMUhLMDcBvZNGqZ4yYfh2S8fjhJ8w80byuw8xqlesQdp8RmmYDR0n6r+BAVWhzzB7+xTQY
 hdJ01JwljKD0XxZAiTrGc4HOBR+VfZE0M3CgvavS2OtKrJ9z+Z2uIkc5oawnmPTIipidX0wPD
 PAjpTIKgtCu/2JGnsNbpNf3tkUmQOWrvO91IzkX7L8LBUw6eNOc80u/RbQUtQqUtpqzBc4cj1
 gz26vGTP+Ca6NFrAkUNix+1/Rl30z8XHf90k+vNBPsr2snW1+cistu5WVx64ITycYUNRWC0lv
 3qj+7VSieetdATAesK9s0ynaGQ0D7qpvjaMC4lwXNMZz+0kU4mg8iTDD1onFydK1UxjJeKrdX
 QRNtl2Thbl7wsehHwvxJ8vEIeKDAcXLTbLaJPKjFN9V6VuDElC7pnUIaDy+ZUcsU86FqA3eBG
 tJs17UlxjT6EkZwk5LTKnSvBn9Y9s+qUpIwC0eVBrx1UZAU7zWWfrWPME5PSSHZPGs7O5SF7E
 FcccoWdd1T4gxJr75kWtAjM4aSIbN5k59TaQtchCUQpzoSjGAjEL5hotLyHsSnHAo87GNoQTS
 8g==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 06 Jun 2019 11:15:35 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 06 Jun 2019 11:15:33 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to replace obsolete #ifdef's?
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

> It seems that spatch currently just doesn't understand preprocessor
> directives at all,

I find this view only partly appropriate.
There is preprocessor functionality supported by the semantic patch language.

Example:
https://github.com/coccinelle/coccinelle/blob/cad4c0705f9e37f501531e133d3a47bc56ed0ce2/docs/manual/cocci_syntax.tex#L1125


> just treats them as literal strings.

See also:
https://github.com/coccinelle/coccinelle/blob/cad4c0705f9e37f501531e133d3a47bc56ed0ce2/docs/manual/cocci_syntax.tex#L1765

Additional development attention and further resources can considerably
help to improve the discussed situation also for the Coccinelle software,
can't they?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
