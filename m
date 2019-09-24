Return-Path: <SRS0=hgwh=XT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190D7C432C1
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 20:55:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE0C207FD
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 20:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="UDG3PR/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE0C207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OKtA8o014092;
	Tue, 24 Sep 2019 22:55:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BE91777AB;
	Tue, 24 Sep 2019 22:55:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 93E24779E
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 22:55:09 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OKt8SV015581;
 Tue, 24 Sep 2019 22:55:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569358508;
 bh=cmqag9GiVfX8vJozw1to6XfoHuPR1COVTIvjPluUtlE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=UDG3PR/CPSf0i0boXnLeq1+wf2SHS6Z8xt0zikGW1BUxnRyQd+O7GBxwe6ZqpjXGT
 X5bVqZBLDS8nktCLekEff9d9iKK5c6r+/7nsE2L0ebTauCbo0WHYNldnOsnSlvybkm
 dTPsF4D7wBOGuma1Y5Q1MN54NAPtnaG7UhEdFWZQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.71.162]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MhDkj-1iZEDN0UvB-00MP4n; Tue, 24
 Sep 2019 22:55:08 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
 <c4437d9b-8795-fdfa-7914-fc30ead14cf7@web.de>
 <alpine.DEB.2.21.1909241729310.2282@hadrien>
 <f41b8e72-9a79-e65a-a652-8a257d5fac71@web.de>
 <alpine.DEB.2.21.1909242215440.2589@hadrien>
 <b22031b2-2382-e629-a11a-09be7fc8e9c3@web.de>
 <alpine.DEB.2.21.1909242249150.2589@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f4f105d7-6cd9-882e-a3e9-3debf6857dcb@web.de>
Date: Tue, 24 Sep 2019 22:55:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909242249150.2589@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:/5XBymZuOF9hmzUs+lTSInm4VwcIkFVTyJidKjOoh8T5wUOxrcX
 UUQ18eHJjTEEy3w8fQp4vWq9TUtd8y6yZF9CFtjZ24rrY9j0xVs9leU7Vejm9MR2JnI6a6X
 2FVny1+SR5CEohDztwEL0R8RmwkiwkjRoPwaxvS98Kd2nZH/K0ZseRE25zI76bxFQYlk5FT
 MT1gjK/KHLcMgVM17XMWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OUhnsYcGeMk=:I9jokrORGV9Ks5mVIg27Fb
 kcLr7v414yUTID0ynfXrRkHNSiJ197c6nabuZN2GR+QJaCsbq36TOP6lLyjQWph8Fs4rEphvm
 3HLPCzYjOowrDGrjtdbB71U6IJ3LzN2UKTVwxeLgvyJ7Oex37vKNLEpU4f0mJ+Dv3UEHKnPGK
 MQW8Uc/FWsAzqhwlnfgz2eSTiyve7uF7eKXZrfgohyLnCODNCxc6/7xbcW+nMQlzdnRQbkVnL
 3M3iNxDq+GNWcZmpaNmZ7NAjAw3E/OiJSAXPYbJwifBRFDf0E2g/RhkoPG0JWS2KY9PnToWAF
 o2St9RY6H6EcyJKII+bN82EkxZXu8kt5t3ysfc1fhubYB8zB8sPmvspW5K6BoRdKiSImcA5wM
 pSiDvWXs7WmunTPmr4Aj8jZUNBKwc6fsVtSCjNh3zWkxFRmz1BYTChlrN4dCIhZlargNkMiyn
 XiSWg1zwYKw7HOyAFxRhTYG2Pig9cA3Pq3a2D+clsn3z0KWvKINsVxShFnAKHLWPOIJz8Ss4U
 N3Jbn6tbu2BDt3f6tnKkZJEA+ETUxhe+DURzY2E5ve9k7/xt7oJxhgcedxqtGWmVA7MG1TH+w
 NrY8qW2mY9HAsP4Gd0HULBf9aaUdBmNaaioVtiR0E0tjC6whTrrwvoFNuneBjNxEQp8rzAE1X
 tr9LHyQFSXgndp5xAvoTjXHV+NPeSGamGSD1T+7c5wRQzvhOKZXptEOgizyBR3EmblqyNoFQO
 K/+lPS/W7x11DH82c1ZNmtvHvHS5s7zjal/w9TGnz/lsi8yw2utgfsYmVmhewU5St5ouyEuGB
 dhApotQqLk7oNJPITO8kSt0ya256PpTduD3cRBlYE0caEpn7WcKsT5lirJ4o4jhF6cJ8VMNdm
 3zBocI3Vso5ixhCtK2LfKtTkMM/VqVlgS9jh0OkEoHVlADVvjw5M9NW/ZBsJcklYaxQy6sa1k
 5aLhR7t7cQQ3uMOYIQZiGX+pN5HAt/BhZc9NE5/vE3PoiDcSBTqhquGwovfNYea1ifUi0yfkA
 c5hZOEcItMLUCRbph8YVyzUHpxZXQE0sHB6oSbmNS7bGnaoynJi8nn4FDmtt7Q1y8P0GzMAi5
 9sNG0vA0NQJbhhniEWl7vDmMYVtHnut9crcpZIFAg4IbdgiCJEs9B1rhvhfh1LoAE6P6edJVk
 +nlhI5e96Ld47STXz5q6ykXuMCNkps+08d+/JkgsRJ4YBpsBf+2suv2mU6tw8JeOEpYXmRkI8
 75+Jqniv8Qqj7CGVFMaJ4zy/MJz29N4+JIqDjFk8xzxiex0dmSD2DoUgSkq8=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 22:55:10 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 22:55:08 +0200 (CEST)
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

> What is causing the previous uses to be removed?

Thanks for your reminder.

Now I see that I need to repeat the deletion specification from
other SmPL script variants.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
