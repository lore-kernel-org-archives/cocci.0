Return-Path: <SRS0=mKsa=TZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DDEC07542
	for <cocci@archiver.kernel.org>; Sat, 25 May 2019 13:57:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE252168B
	for <cocci@archiver.kernel.org>; Sat, 25 May 2019 13:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Hv+JQVQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE252168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4PDuuMc028433;
	Sat, 25 May 2019 15:56:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B41F57752;
	Sat, 25 May 2019 15:56:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C6EC0774C
 for <cocci@systeme.lip6.fr>; Sat, 25 May 2019 15:56:54 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4PDurOA010487;
 Sat, 25 May 2019 15:56:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558792613;
 bh=q0rk0UV9xkrF9NZe9aMrDQipOYbE725hRDQVl5CHAII=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Hv+JQVQVHcaLAfsGzCPEKdc9UhbfQeVKCWpiG2N13dfH8/1KKyl8DzH1uR5Kzayir
 DJHGPi0QKZ5Obf7l9Upheom93OaW7cHcql3JjGkfXVJhEBAFtv8OP0YCfy9d6/wHni
 Ss7WBQeralNPLHl83MXLQmVfSh0A+ISCTi9U5UI4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([93.131.6.10]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lx7Mz-1gWyOS0pLN-016eSU; Sat, 25
 May 2019 15:56:53 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1905222114490.2618@hadrien>
 <81b409c6-5986-5961-5edf-843c6737d88c@web.de>
 <alpine.DEB.2.20.1905231500230.3573@hadrien>
 <b5c322d3-3162-953f-a985-53abc5064482@web.de>
 <0782D580-3DD6-4419-B5E1-C04215FB2E3B@lip6.fr>
 <bcc5a120-dc66-7511-a401-e14c322dd67b@web.de>
 <4FE72A81-9D85-4786-898C-A84E2AC5B520@lip6.fr>
 <14711fc9-6071-3f3b-9f99-1b0f56c2b4d6@web.de>
 <alpine.DEB.2.21.1905251538500.2799@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <702ec59d-63e5-f9cb-111f-2be2f93edc0f@web.de>
Date: Sat, 25 May 2019 15:56:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905251538500.2799@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:yzxTh24jET9DatxQnaLaQ1ytJ5U+ATgg0pM99+Nv2wKokekxEHY
 jSMhQv+OQOSzdDq8yyER2kuVQCf74gvUKlcFTbRL24B0y0Fdyz+n1AfHTYKwIZN04ykJ3V2
 28svzqaMPaxvwczMErHD25KTwGv7rIjSz34X/08FA6LeSZcGX5aZfT1B8HvrNqyuiUqCet6
 9EClKfq7VRNqFKvCAc48g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FcYvFZ68Z1Y=:R4sxmvZ69eQFqcvfBLADQp
 at20qnrsmT/PYaz7RgZNG4a75ZE0tEN0tctragm3MlF4aSt+SBZT11GP7jpF9CQYD7Red/bwS
 ihgiISmgS/pXXQHW7NOvHNc4QGKk/K7PNvfp3JSGUhype3HKzJJgndPhTLL2nOouOzXopNTiz
 YMZi1Q9ytu2EByIOnIraAGA+87pPg9g5BWzUUasSRj74MQKPWmgbDdYGC1zwadQ8fM/8I6271
 HvRFQRT3e7u82ush9EZYLw9/+DHrCzSBobMvYp3ieB9ESuRzxM9jHFY9OrdMr7MHgeUJTnrX6
 3zh06xk2u9bb9xqM91Lc5jkP0OT97PCOWTGIsLsO2O2L635DHFKRC4lG7aOenhPsvZPq5GB5x
 iqNZaND0I+cHp/7iwbFExKntmiyIuM+7zR4A/VEJLmg1Kj5804IEVTFBN31VpY3rj/SbG7Jet
 VgOP+5XSa+mufTaRSefnr9Evrx465V+AWG90HjG+leFiXWB+3LI9LQrRKhBnGmcx6ulQl/NH7
 RWSsezBGoD8Qw6ggqPQOC23qjjRUB581qs7r2403YkLCee0sxC8GKqOZ68ruiWQlO0szbcdlr
 uBQHAr6jK6nVXCMSOTcECqVfvbHur8UFlxuMxziwPzXIY2hZD2B4sMclxl5wTs9O/8ppWBv1k
 Z9LUf9DibBcuh/sBzSsNbZ5WYHtqp9548YN25zXNQa9cESfWBJYca2A/zWTo1mmBeqM2jZEj3
 CvfBmF/lP7ecTGHJrOcuKWl14B1jZIUSdaKBtK9yUsCI//QiQpLdM3G9uXp5/9wNX8AV/2j2e
 DdCig8nVEjutTyPeKoP2FxNjvoqM9/xv/W4+ajofpA2SO364fNAGMIf3g8vK2/Es27neB2KcP
 iMWEe74+tE32qap/tRIN1eDc/c+/H+KTiAnmkGffs7ot1nFO4Lct10gBHgiEn4ULTIYYxRYCv
 YmYD/e+nhfjzcignnIjT85wUEC6VH+ACR5/SNdd8lzIxgyh0zsI8m
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 25 May 2019 15:56:57 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 25 May 2019 15:56:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] accessing comments
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

>> How does your software decide which comment should be treated
>> as simple text before or after an item?
>
> It takes all of the comments before (up to the preceding non comment
> token if any) within and after (up to the following non comment token
> if any).

I find that this information can be confusing.
Will the desired text relationships become clearer?


> I'm not sure what happens at the end of a function.

Interesting special case.


> I suspect that the end of a function is the end.  The comments that
> are before the start of the next function are not considered to be after
> the function that precedes them.

Will such details become relevant also for the SmPL manual?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
