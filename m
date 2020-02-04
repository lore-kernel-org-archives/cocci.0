Return-Path: <SRS0=4B11=3Y=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33874C2D0B1
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 12:18:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE9920730
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 12:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="pUlTijUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE9920730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 014CISHU020262;
	Tue, 4 Feb 2020 13:18:28 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C2C2377EC;
	Tue,  4 Feb 2020 13:18:28 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9612C77E8
 for <cocci@systeme.lip6.fr>; Tue,  4 Feb 2020 13:18:27 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 014CIRJ9024969
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 4 Feb 2020 13:18:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1580818705;
 bh=DvNirAzbHa8Hfek4zFZesLeClCVRxQ9FuD3V6h62gY8=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=pUlTijUcZF+yEy0wfOMvr2Z0+DQCgSorUiKsFY0AiAH2RWywPkvy82VcOa+Jgsjw7
 vpWvCTO7JXAuBphA4rp55Lm3BlRTgpb7MqCurbEgtQctEM7pAF3+o8eKgK68Q4xEAM
 wEktC2SQhqEER52lcGc4uX146MjzIXW51DTZqx0g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.133.16]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lym5H-1jdz1y2QRL-016BwM; Tue, 04
 Feb 2020 13:18:25 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <72729ef6-f8df-942f-57aa-4b3fac75a20d@web.de>
 <alpine.DEB.2.21.2002032151520.3356@hadrien>
 <b318a372-2f31-f57f-4684-62ac2b82bff3@web.de>
 <alpine.DEB.2.21.2002032226260.3356@hadrien>
 <f0ccaf84-1b37-4936-3a7a-d5c11e3ef1c3@web.de>
 <alpine.DEB.2.21.2002040913290.3236@hadrien>
 <04e7cc2d-8c7a-8d8c-b9f0-55cd7adaaa85@web.de>
 <alpine.DEB.2.21.2002041200210.3456@hadrien>
 <349ae8e3-2630-dce7-d1d6-1221059df948@web.de>
 <alpine.DEB.2.21.2002041306490.3456@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <34b26b94-5d0c-8767-e35f-68762dbca0dd@web.de>
Date: Tue, 4 Feb 2020 13:18:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2002041306490.3456@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:eqcsP3JniybzFpc0M5LvRcVAt5MmHdJ7c63VrgRpI1Wwd/aPMW6
 AeHlujbVWZKu6h4+9eBAxFV1zV64tFZfJlP5SQ7nQNri3zXyaDNkE6j/MeaIc5x31wtvHO0
 n/14MhacAivunkMOEQYMNXtQ3Y6JAAfzj3CzxbfF2uvW8HCu39ssAFirj+6hYCphbNNaCng
 i15ODrN5+HqgeVfLrcjug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U+92nOJr4Ks=:xNg68zVn2oY0JvF5aKfbCk
 lnyCJn9Vp9j5LdArs0iKi169eqZVpahEEfXlx1pyKN1sVcpITm8JHImyna1yfG5tyuda1XnI0
 mMSF45PMv02pyuMwIIRLnSv/NXy7K7o+T6lgCLIE5FIls9zNffZgiTzpkrBBSvsgJIEWV0y4x
 JWfu8wBReAlAMVMPAFdiXa2R+qmr4KKamZ+ezeM1sk24aL+L+j2oNQ5UAkpyMkqSEA7OoZHdE
 lb0h8zEcWKjHH4HZtBRYWQsiB0gbWRWrOwwsgsNG6DPfhHKEH/vAO2qsMLOZKDjmt7U5ziQws
 gfofERA+YlSbtIIcXw0zEEET3ecZyHZwfAHBCWnUO3NQSUGzygpfPi2GwG8mAHsWCFihPVvJI
 8oqVSrzfPWqKpCY+pwbr8k7ciksWjqwjl2ykOF89fm5GtCZLmGlh8PIcyG8TgBf2Gv6u0v2S6
 0WMWtaK15JpXyaW3bRXNpT15HZl4SYK/ZBJBlUIa88+uoNN/sOyL0FAxVMwV6MQbMTqR8YbZL
 5ei/6Cfn9pjh99ucRbPtdVTZ/CVzP+s2OR01jx1g/qhuqoc1P9QtWvwOhcv2w3edjlM7RLcKI
 iBWVliuKAsLuHIb91UgKD/Py/2ZD8ZgBWM8a2VFi+kGO6MVkP+eNGzO5AtQ3tito4YEYd7YJE
 aAX03fVWSAhgOxz4mnPCMH9ZMS8xz+yDwEQ7GKr9Rg4R1QRPLTUgNH0Hb8U0cCGk8l73Y+M8j
 8E5hp1hwg7KM+ppM0AZAVA45AriqZg5whqKg1/z03sW5tYk0lCffZTScO0z/KvnG0Sz17EC3b
 X7Zw0zdni+ei3Z6+tyFejVuiei8ZBYTSS8bOle0HuL2j6H1R+O4Rts0F63iE+dVEzSncqlRHA
 ma3XPsN/WExFzUH+fdBvoVkC+5d81SDv8yVQwkoYaSmUqcv9GztlN8swrllff3l2Tg1UWv6jf
 a0D/2ub6iEsUw3hpFL6w4TnbIUpPcVnO6KJKMrbweRGAlgDJvrjguQokxHAPyEkyrsjQlAKoS
 IU1L3G9QQ05jGUFVP9sBZL+q5fZUCjh5Ww5GcninwYYABoTcTM9oC7/zbMSA54LVsSjwKMhd2
 LsT+n8Ato4pPpxTizT4B2dS1yIXf+6DuRmAww2S5+nQYVsaNiNgAfNPJoHHRoo/cy1xe1+1W8
 vh6AiSseUO+VjnRSKhEhRR9QlFGdEGXoIBUAHyHauxLLnEyQECFFA464HE7TSX0mqhpwC5jmW
 j6XXwkB1OSETdzJ0C
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 13:18:29 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 13:18:27 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Wellington Wallace <wellingtonwallace@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci]
 =?utf-8?q?Replacing_usages_of_=E2=80=9Cauto=E2=80=9D_with?=
 =?utf-8?q?_SmPL=3F?=
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

> You're not actually showing a need.

I disagree. - Our needs are just different.


> Ie you don't have a real piece of software in which this transformation is actually needed.

Under which circumstances will the clarification of related components
become more attractive?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
