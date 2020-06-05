Return-Path: <SRS0=TTUf=7S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED692C433E0
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 05:50:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CDE207D5
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 05:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="CFpgAeyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CDE207D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0555olRh019652;
	Fri, 5 Jun 2020 07:50:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1973D7567;
	Fri,  5 Jun 2020 07:50:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 219813F9A
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 07:50:45 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0555oWj8020362
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 07:50:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591336229;
 bh=lsm65JLszt/5VTbNbKQ1p4373DDZCkH2wXE+5O+35nM=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=CFpgAeyEmpFHTqcPOUs/gV0CHxtcYjGyy/NFppK2td1QG1fWjkuQUn3aT50us+64o
 wqfaw9uNWMW4bPWOo8srCAnxfOERK1vLq+oK2rAYD2v7/HhPJzjWbW51tEbXd+9cH+
 /En6qo4oclub1060LUvQgQpjVh5TdE4ce/8IsnQ8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.102.114]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MA5tp-1jnQtg0RBJ-00BNQC; Fri, 05
 Jun 2020 07:50:29 +0200
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Julia Lawall <julia.lawall@inria.fr>, Coccinelle <cocci@systeme.lip6.fr>
Message-ID: <27351b7d-cead-1c83-4ff1-5a94df9adec5@web.de>
Date: Fri, 5 Jun 2020 07:50:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:btMBFr/5/lv39TIzw+1z99bDokrXr+hhPqbCNLa3YhZ7EpJEInH
 hcACWTsgT/0HJ5PyWETXxEqhD2pHzULoPIttUT44MmEisEyCjsShuZXp7pvVI0w7XcolNa/
 mi4bxRHObU2IT9OZooEo4687RR5AQ7IO5dxsujlHErvVwhk6S29lKinOImBDooBtL20t4jp
 OQS6WcHJtvlGL5mqZyzdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G41polTFVPU=:/4IeMRAJjpErLMRJSM/JRh
 W46vlriBELwWZkiwWyYOyqNt/nLZrKbeFr1ZIZGUnetb+/Gur+HBM1FFzhSkYGSX0KpPexTph
 +//WiAH3oQv9IUYK33xJxGHcDGqK32ROyC6wz9z5G0/qKVZe4o/U7QkIaySjYmeKn6jL+mCOX
 5Lim4rNHqstykjHYzmcujspbIR/YZMl97PAtI4K6p2nChhXLRKFFUxOkk+QNRrYD7u5yKxGPU
 TE2DLoPgl9QHBnSrXchvjQ1EgSGiTlaDwiN7S4dEa0fxnI/wVvpxbxe0vj7w8nunqC/Ugr9+4
 n7eUp8OhVHagjC4zuebYbFdGud6szkt+KENht9sT4YKcbQ2gkPHrovJSpai9m408FCzAvAXpt
 /WE6Xi57UKsxCpAuZqDrhInHtLe0Mu/4tspMZcZVmH1a+sMnhju1IWWAbGh9b5/Z5BhG3WiVq
 BzVOG6WaAZJFv6x1lGhf87shuPZBLn9iQIWKrrwFCnOxb9PXuW153phqH+Fu1YrigKB/9gu2S
 vL+YJuefGAYlG/b8EEb6r/VInIZBXubIacgJ2mCSZPDOFumEFP1LZZN41eeYRc1rXduOrXENa
 EmIpLbZEPKFrslKbJQOYLQuVzjCgFP0tA+zem/y2ml9wwHBFDraXQW9jSP6vpGxfe6aHpMnjV
 swbklQE+Tn3g1BNAEjYUX20oQb+U3bcGzMCYXuCZbs4P79wRprvb7p7ne2V3NTQ7bIvlFMw7r
 7oyJi6g3wPVvB4kn9eBiA8vYFFvMER8r8VweCeeiNXQO/FSZyBmRl1xID5jHTyHpd9VJ++KzH
 93kufq0lnCbK/Kf2VrBVw9ZttAmxzW/ruXwvZOO+TBsl9ZLswI9Wfb6/rCfKYXxXn3oPsYYMV
 HPBFbVVn6cfGsIuuAN+/Z3Elc57wutcNlMjkwFU0MUk2IilsGrK6oziH+bjZw8Kk2vHhwrBUz
 +dEfhg56r3O1HKxFT0tSHaqZKMUuAGQcoz8d4LEq36ejkrQgAOcSMBvuIIp3Z/45UBx5pLTDY
 JOCYvleJNaR+IeZrQRcQY99GYPS1b+HmTISIJgTfwsy6Oh0T0deE4TB32GY18raXoEwlQmj9F
 pMgs6C2f44JiTgkebspH91ASPRBakVs50/MK7wHWVxLS/AsNUFbKZJTLDnu6kSga4xhU+hQDl
 YMky23jrHZdIMSq5qOmPWicH/cftzaeOeP/OJ/ghnBG7IgnsEmJUJfJ7I2U4bgl1Q/3ov7gPB
 akaZ12gt1wKRfNVoT
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 07:50:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 07:50:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2] coccinelle: api: add kzfree script
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

> On the other hand, do you really require E to be a pointer?
> If you do that, it will have to find the type of E.

I suggest to reconsider this information.


> If E refers to a structure field, then the type might not be available
> in the current function, and you may need command line argments like
> --all-includes or --recursive-includes.

Will the software documentation need corresponding extensions for
the safe application of the semantic patch language?

Will the used data structure access operator like arrow or dot
influence the interpretation of the software situation?


> Is avoiding transforming the case where E is not verified
> to be a pointer a concern?

I would find it desirable to express constraints for pointer data types
according to the applied programming interfaces.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
