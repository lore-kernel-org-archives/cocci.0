Return-Path: <SRS0=rX/m=6U=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AF1C28CBC
	for <cocci@archiver.kernel.org>; Wed,  6 May 2020 12:24:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884CF206DB
	for <cocci@archiver.kernel.org>; Wed,  6 May 2020 12:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Xk2USH60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884CF206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 046COhEh011355;
	Wed, 6 May 2020 14:24:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0FC45775A;
	Wed,  6 May 2020 14:24:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E7D857559
 for <cocci@systeme.lip6.fr>; Wed,  6 May 2020 14:24:41 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 046COfxs005339
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 6 May 2020 14:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588767880;
 bh=1GxgfpBfjVK1Dv0vUoJxxNgCVPuk2MnAiiPgObYijvc=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Xk2USH605+cx70BPIpuI+K2HI0GpFucvzocTD58QRBETcOa9bRXHh4De4suDTJ6lt
 xo58z1Qm/BiiPX/GJwQAnjjI1beri+w0+DCeUk9p/k0oJRi0k6d81A1wj+CA85h/xA
 0XSsBFcw8uEkI8XSLLLj1i9O89iSQcB/uhQkkDGg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.162.166]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUncu-1je2tg0yVA-00YCDo; Wed, 06
 May 2020 14:24:40 +0200
To: Paul Chaignon <paul@cilium.io>
References: <b6c5ae24-f24c-a0d5-796a-8e9cbd17a7d6@web.de>
 <20200429190733.GA5695@Mem> <72cb854f-912b-4c34-a526-be7b584e8fd8@web.de>
 <20200505095911.GA7247@Mem> <78195706-c910-5c3b-5887-da94c244b61c@web.de>
 <20200506120107.GA3242@Mem>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <367e1ceb-d784-96f5-0c48-8aa5f9deb0f6@web.de>
Date: Wed, 6 May 2020 14:24:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506120107.GA3242@Mem>
Content-Language: en-GB
X-Provags-ID: V03:K1:gpHxF7ascnwz0WLuTd3rl01KOTdVnQfoAL2JVjhJqfEBk15rij0
 Jwa1Lmm4BLPN2kVHMKJbFOABicRHkTGr3ppzeCSUNydPI3Gl8eSfeqa8mkLGbIBFQlvgVpg
 K536mw8iG5rWdeN+d68BHPBRzn0c4zLDVWmoBcCgC7cCqQZUOTGqKZDAheszM2AAt1RY75O
 gRMoy9PVib0dTNZMoDBEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q1e4pD4y+Zc=:cOp1FMeTXKRTVPweyPe+XS
 1mEkqNWEc+7E+nuu3tpwI6hVHR2D99lQbVGU3Iupk/Spxn2UwKK9LuXF8hGb3VpXTl2Nn0vP9
 wQL731Ume0h1eBdXQIXT+z8IRPFvLHufvK641OoVlREe9r8YtMjuCP94Y8clF5ZCrIwS/gCeh
 +zDtoPd6m2BQr+5zhBFYq8OflFhZCvM//Ml32Dts/EtaJcBZwH4M9KV/hHHBmcNGEobQvNmiy
 8xAICSQZf+9wght7LSK/BPheaEafUk9/HhoCuL/LNxOukaLU5QLMJMr2QJVttEf2VPc6SjDIy
 mgs1uDxfzZfsbvkuW0MOHBLu6qem99m1BTxOukLbZYZ2/xl09SHOxu6cFxvYuN/Nbq7avdjQT
 d4xmxhWEBsOUurL1S0i+BB7qZewcORcQGy7t4RmhQsnvAgVFtbKCZ0P3amhatUjB3SVm/xAS3
 g2GztiSZVo1ZO0JEdLA/DChMdNrG2veUXPhGH6c61wN06yUO9W/XPKpeWW1cB0VMTW8f6OBrB
 5BBFh0vivLPKXHmTOBnC3/RWDg6U40bJzlpa00uQQ8wgsAVFfOQoz7U9DPXM3njven8ilhQ/k
 qj8r9TRdMqm1eQ3litV82DVJvAayGXHbA6fZs2DAvz6sN1d88j9vFRQpWXDZgImDQ949siB0c
 szCZG+OpgtSG7bDC5tVfHD7EYNb9/DTQ82ghed0XnbTYnCNGxsoXASlEzZFAt3//K4JtzGwaO
 mCycIvRYPwirFiEVrKvXsM0Rpz8aILLvsRlmyJxj7niZLDvaeQlUOotXpV9xUVaakovuV7TrA
 AmjGbDmnvyA+zomc9gzyMiCwD0ZkxokTpuMwBD7n22qy7aLalolHxbe9euzFKJmvvgel4CuFA
 x/n9ViLxXyHVNuX5wvJdLddGymdiWBes33amf1VwSW9A1jWp15Hm6GkJovrYv1zjtAqPKwsQ5
 8geECf6afAQBrtbrKn53eNRIiicGo+CjEZ6nmibNoKvLvwEYC9+UlsyJ50xNrJHmW5d38VM6B
 gdYMADuIAObhAZx1hXvYzQD51rM4epjL4npVz0mN4n2N7elSVJldVb89YKbJis7X/D0T6WKb0
 m5Xs/cVWxkUfakx/68RpX7ApDzc4S9gIEA2vOwAqcJkT8AAxm2vYxjrIbvrfMHBJm7Pvon8jr
 eXaMUGIRGwHmgsJnbbv0YztHTsU/yfayRVJZYnuJWBZoOaE8EBm5g82SP6imE/UhPnd7GMbLY
 5tLz73GHss6+7bXrq
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 06 May 2020 14:24:43 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 06 May 2020 14:24:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Exit with non-zero status
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

> We're only planning to add Coccinelle rules in the future.

I am curious how software extensions will evolve further in this area.


> If we need more complex post-processing,

I imagine that the selection of nicer data structures can occasionally
become more interesting.


> we'll likely implement it in GitHub Actions and

Do you feel more comfortable with this interface at the moment?


> not directly in Coccinelle scripts.

Can they help any more also for your data processing needs?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
