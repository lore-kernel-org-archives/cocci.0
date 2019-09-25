Return-Path: <SRS0=ojky=XU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18CDC432C1
	for <cocci@archiver.kernel.org>; Wed, 25 Sep 2019 11:00:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB9321D79
	for <cocci@archiver.kernel.org>; Wed, 25 Sep 2019 11:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="fPIRsfSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB9321D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8PB0POK012904;
	Wed, 25 Sep 2019 13:00:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EFB11779A;
	Wed, 25 Sep 2019 13:00:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C3E7F76D9
 for <cocci@systeme.lip6.fr>; Wed, 25 Sep 2019 13:00:22 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8PB0MFQ000964;
 Wed, 25 Sep 2019 13:00:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569409222;
 bh=W9VxrkDHHF9xRWtOkHCNca5uBlQkiLmxRLxp4ss1fAY=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=fPIRsfSP6OrfZ40X5gFiN76W4O0f09endIa1Fmz6zmTRH3Smy34+cpyZ02f+dLDw4
 6xSiy0UK1CAl/pJ4HT219dAKfZ8SqiA5i2WFuUWagF+P1eLS/bgq9RoA2m+UEDodlN
 4QWu5lwcaUc8QH5wdzhp140WULfJjoRoqNU/oU1w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.110.103]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0ML8X7-1iCo3507Bx-000Jpy; Wed, 25
 Sep 2019 13:00:22 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
 <c4437d9b-8795-fdfa-7914-fc30ead14cf7@web.de>
 <alpine.DEB.2.21.1909241729310.2282@hadrien>
 <f41b8e72-9a79-e65a-a652-8a257d5fac71@web.de>
 <alpine.DEB.2.21.1909242215440.2589@hadrien>
 <b22031b2-2382-e629-a11a-09be7fc8e9c3@web.de>
 <alpine.DEB.2.21.1909242249150.2589@hadrien>
 <425463ce-d244-c86b-8a05-19b6511f25ba@web.de>
 <alpine.DEB.2.21.1909250822040.2482@hadrien>
 <362dc557-b90d-e3df-e56f-f7ef283b6f01@web.de>
 <alpine.DEB.2.21.1909250837140.2482@hadrien>
 <8f5e6fc3-e2ac-3098-9724-0958a869e92e@web.de>
 <alpine.DEB.2.21.1909250854190.2482@hadrien>
 <77eb7949-b16b-ee07-be24-5dadccb25cb9@web.de>
 <alpine.DEB.2.21.1909251138120.2654@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e8ab1163-3b50-c808-ed5f-ac8ab9b869a2@web.de>
Date: Wed, 25 Sep 2019 13:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909251138120.2654@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:cTW+bwk4V54uEUOsC9KcueiHpLvoLfdSZGs8tvGy2lcZpbANZAc
 1vQa/T5VxzKBDayWXdffoNx2NMx5jyLAcQf1/1pvcXVYfgSC8zrvG3XrF7OxRxkSW42Qa13
 8F9g+vSBLZyPoCPpExZIKEqY68lWBcPVhKOGB/C3BE/0BJu+Za8WGJD0py67GX08maLqw8t
 XgY5A8r6GWnCIN9ewmJFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+DjLtlJj9kA=:Xn/GQ8SY6ZU2PwP6xzX5Bc
 zl8ZAP18/q4peTMX6Ngba+C17pL8S6A1qWkGlon0W8Witq7zxTgDM7s2EvVvQJQ+5D/BXIk90
 xcduQhgE86/fXjuez8e7SzASZQif5oSa/eSS/C8T91igI5T8V+0ZaLapcGLNziHGLMxXaxae5
 KH9eS7uUeKzfKxd6oWycfex0AFPUKEUsP2V1s3vTUI2mhY8S6PK0R7Iqkb9rA74eInUY5JKZM
 KbRlTwAGW5SZwntt/vQmf18SlnTpauoVJ8igxzKbAUpi8FeWBPfV4WDmj3fPO+mmIBCp1slIp
 mLHBQuFa/VOJ2Q5+sw0hOnQpqNA/RQcN6q7KcUGRinz+hfew4RCuE61+tIT640kBlLKR7/A3B
 yaUys1RZCW/ORUgIJp+Pw55HoF4ifFnZRD2qntJr/x8H/qT6yW0AoE7EjiLnYUz2/mjGvL3VM
 F7YjTeIBDiXzsLLCnlJo9YfaA+pfoO+kMt7A+DNk/hbeIEp0AtWPOW25T/Pa8yJkHPxYaPU5L
 mIFRX8tgVpH7FI4jzNZwAEsZ15UEQWCO7hloh4p57k+ELCxxB/KRdMvJiFIqIbaR55mfT3OvF
 XuzgExb5LIoQBmJ4CCUq9pFePyw3RemJVEDOBrcYjjvasjGEr2JocNg6QE9m/YjQrALh59Vwn
 1xV4fuFaQeo7jtZo8K2JqsOHWL0tE7sdJwUVTMzY+PnqVDfbsTD6NhYU0PiR8SsE6jDWmEtyj
 3tL3ZZhlgP/++MrE+nV9riH2pZU57pIiAXoiklmh1a7EiHd91DU7iVEo17ktgr41UAJtb+XTU
 UYP60BP8jIGqExfr59paGpnNXHrKh4BTFppDA+SQ9RHr5Td6xJbvZ3yA+z2JFI15zOTH4pGma
 3iIiORejY1F/U0IekLEUyjxv1QGJAdOcktpkVkO7aYSTW1dU91TazPrliGirf40Kq+tQnhOh/
 wzsp/Jd0ZBGMEQkIQ8sLp7uJRo306h9/PkwtHlXRW9U++GGb0B8a5M/9XCgnwoXAkFRgOa4kY
 8sr5UaiFBb226UTUiYdDyDrKDpcUUhK9WRldfoCV/mohNcwRbiCwYdZ/8ID2KAyFySwI12/pG
 iC7+z/kuOPyxuAU2kiNSWKqgzAuB0NfAEU8VWCpi+3PsG8oH6NpoK4xrZ+E856fbzr+FllttB
 401ZY7JC4sM4IWyusKFF5jkJWOI4WAqzMcOY70YrQvDWYzB6soewVTQdOU+LIoAW02/vXa20k
 phfy+eUr82D4mSbj7SPC1uYeYeOzHoTE/PN/x5u+1S2EGUWg/TBfXnAvRy6M=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 25 Sep 2019 13:00:25 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 25 Sep 2019 13:00:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reducing source code around return statements with SmPL?
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

>>> I think you could use ( & ) to do what you want without this functionality.
>>
>> I wonder how the usage of SmPL conjunctions can help more for the discussed use case.
>
> So try it and find out.

I have got doubts about the applicability in this case.


> No need to waste my time reading about the fact that you wonder about it.

Would any other contributors help to improve the situation a bit more?

SmPL conjunctions do not trigger the deletion of questionable source code.
One shown SmPL rule depends on the check (by a SmPL when constraint)
that a local variable is not used any more after source code places were adjusted.

How is the status for the support of SmPL disjunctions in a mentioned test combination?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
