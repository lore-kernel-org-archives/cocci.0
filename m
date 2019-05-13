Return-Path: <SRS0=7Hyx=TN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59DEC04AB1
	for <cocci@archiver.kernel.org>; Mon, 13 May 2019 11:49:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224A62085A
	for <cocci@archiver.kernel.org>; Mon, 13 May 2019 11:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="jh+XZyFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224A62085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x4DBmjqE027991
          ; Mon, 13 May 2019 13:48:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EC58D7751;
	Mon, 13 May 2019 13:48:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 91F10773E
 for <cocci@systeme.lip6.fr>; Mon, 13 May 2019 13:48:43 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x4DBmgd8007155
 ; Mon, 13 May 2019 13:48:42 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1557748108;
 bh=/TUElLrp3qrIx5JkytwpMcAYLDzBJ3PVW+f5ZLjI6K0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=jh+XZyFxumy8eAkEuUtuyATchttP5zK6RXIXxLbfQMHjW+eoNMg9vXsKIi6bemdmu
 BVmKTIfZNaS3KbhiHJZKrYcPIg9FqgTelQoe7zDohBuaBo8m3uxKepMEUprSVqJdQ2
 RGYXCZwv2w5SWMxNSXfbwFLR5IWYfM7SFxSMqM6E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.147.80]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lmu2K-1glZMe0d00-00h5Hd; Mon, 13
 May 2019 13:48:28 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
 <6b62ecb5-ab88-22d9-eee2-db4f58b6d2ae@web.de>
 <alpine.DEB.2.20.1905131132250.3616@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1c36d747-ac2d-0187-ddb7-d1a2bb18ddaf@web.de>
Date: Mon, 13 May 2019 13:48:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905131132250.3616@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:vSD67XGLgO+wivvtQxYLJVjr5fDaGu4rQaYeeRbFWeKx73QerqH
 +nUwLtDpGu5tE/xoP+ab63IFIowbBOSEqzGm6pYBMYrKjoQmXtPVVeWSVB+X7fm1E97vUn3
 d51mtP6PvhKG+TF9gj5Rf0iU9veOFrXUmpZvRexncHmWvwvCT0FpJ00AK9vrkQAayveMDPZ
 wimE+kbpNXptT68Xd9iig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9S4V4NW/RuU=:Z/pFMfGOLqCCScvJ/wIans
 d8W0MTx/p7ChuI1kki+rfRcxEbt4aHU7Nz//T0OGjKxQu3ZgNVrjRN/JLkNNxBESxe3ey9/ZR
 B0JQ4Nb5CrBrxz9idxvmVH3qjdMpturnkyuHvfjzS7L2pIahaxNKe+XPV1M1GB5+OfGEL8Hll
 7lkyegG52YP7qcUHFwdeA5D8YVb9hAJ3ZtLjZFI/6mSC8mGARIwhbhXWSOo+otkl5lkV4Bdba
 00kzXLACkAV8X46/P94KMhu1yks0FGVuSPyWB8eQkgKSVSV9DTeDsof5aww8nKzBFUFATT0N6
 kUr3j/Fi1D3DvLYtM5aYZw2C6/Gv2l3nmkHrK080uw5m/UAM/3y3VkKl6PpjRl3z4E2ntGzKP
 OpylmMfSxQB9YNHolzSARiwFFm+tMHXgz7CuW7g7iqz7xuKjUjzeZqwKmtelueQPM4kfbOJZA
 sBdT9ihAIw3A3tog/AXWvTOHjQSntf5ii6mrc80/JNM1Z/V8p7Ug8DDTd/WCcNeMiiPIjQOi8
 bWk4F58jZDU+nROQP6ieUwXNCwV1LfN46VD58J8qD7ADgTZd7rZCZ6DwWq8/aUdnVjnPgijGT
 F4m7yBcVmFMciuGQ4dqFIne0/avzAOueHjjQ+hdU2YcOMFJK/pXVWXF9D+3JQVE3I0AKjyQVx
 Ts2nAzx3nIdVRKSdWByneF81Na2u2VHMUOruLhghJRH8ETvJJFG3nL+FH2e9kRXBc3gLliqTU
 yef9MxvRhqoyDMpGFQnvUB0Q/FyASQj2Y7T4jbwB6wkm/x8c+0Ghk9Ai9J0LcdZQ55mnMtVdo
 7jokXcSHh6tOIIHA9aZRRfnoSINkFEyXX6la59+JHZubSaX+UQQUDOl7op0JXrCIBR4kglIbW
 Yvm2VgtqdVNXAjZ2h5dkz1wisddrCiZDhXDw9D7qoj0kkx9OSr9uKHIebnG7pr2MYuTWb9OII
 wMNi7HHhH0A==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 13 May 2019 13:48:45 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 13 May 2019 13:48:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [3/5] Coccinelle: put_device: Merge four SmPL when
 constraints into one
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

>> An assignment target was repeated in four SmPL when constraints.
>> Combine the exclusion specifications into disjunctions for the semantic
>> patch language so that this target is referenced only once there.
>
> NACK.

I find this rejection questionable.


> This exceeds 80 characters

The line became 105 characters long.
14 space characters can eventually be omitted.


> and provides no readability benefit.

I try to stress SmPL functionality in this use case.


>> +++ b/scripts/coccinelle/free/put_device.cocci
>> @@ -23,10 +23,7 @@ if (id == NULL || ...) { ... return ...; }
>>      when != platform_device_put(id)
>>      when != of_dev_put(id)
>>      when != if (id) { ... put_device(&id->dev) ... }
>> -    when != e1 = (T)id
>> -    when != e1 = (T)(&id->dev)
>> -    when != e1 = get_device(&id->dev)
>> -    when != e1 = (T1)platform_get_drvdata(id)
>> +    when != e1 = \( (T) \( id \| (&id->dev) \) \| get_device(&id->dev) \| (T1)platform_get_drvdata(id) \)

How do you think about to extend the Coccinelle software in the way
that such a detailed constraint can be specified on separate lines
(without duplicated SmPL code)?

How long will it take to reconsider corresponding software limitations?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
