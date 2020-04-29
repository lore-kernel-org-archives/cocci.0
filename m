Return-Path: <SRS0=9rx2=6N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389B6C83004
	for <cocci@archiver.kernel.org>; Wed, 29 Apr 2020 18:40:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0392072A
	for <cocci@archiver.kernel.org>; Wed, 29 Apr 2020 18:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="T0qsAJHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0392072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03TIeF91007167;
	Wed, 29 Apr 2020 20:40:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6C9677816;
	Wed, 29 Apr 2020 20:40:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B95E27807
 for <cocci@systeme.lip6.fr>; Wed, 29 Apr 2020 20:40:13 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03TIeCen006785
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 29 Apr 2020 20:40:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588185611;
 bh=ISmx1RHbezc7/EnHda583aNkdXy3mPKv4ko/xypXc4o=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=T0qsAJHAxn14xGMmCnzlKKOjvTvsTmxLqRjN0PWFTNJB5ytdhCjS0g20iBbCG6Fzx
 0nXZ7Wn0uaQecAhhxErVvc6Y2gdqZWIo9aaf3cZH253Qn/p/KK5peqomLY3eCR865e
 eaD6vmdtr3Qhyv2zzjwotDM8VawUyMR1T2vFVwgU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.72.72]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xaT-1j7zAW1Spn-014uxl; Wed, 29
 Apr 2020 20:40:11 +0200
To: Paul Chaignon <paul@cilium.io>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b6c5ae24-f24c-a0d5-796a-8e9cbd17a7d6@web.de>
Date: Wed, 29 Apr 2020 20:40:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:1NnimORaO72atKA2P4WEPCOSzqdQ2dDuIJH94X5NcjL0zbCQRvX
 5idEd8PPh9u7QbdytY0pjRNVSo5cpXae1RgYpto5rLz7NjFUH+80z4fA9HduAYKJy5/oqGn
 8hDnxblEEF1nuh4K4IyLJNtOme3E9PaTztBF0nhBXTaPPpKcvBkm+aL+69yOwU+VUGvFmqu
 +CeoDMY+6qwG4AAQ2bxvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5zBXhcgOsC0=:VbSQg7xEGOCgZLijuy0FiS
 HI+Gv5Jjkfgx5v5P5Sg1CWYphJ7pPdKYv4+Gj/iCmiHIYxPxV+n1aiErNvGcY1c3AcHJKt1CQ
 RFUOmDXVMCzn2BUyW/37FoTZ5yNVmypnRZveCoEfT8cVQ7DMErc3yynwAmvUk0p6fcI97/7fx
 b3dSt5D0oXyQXsmyQ7fPK1TLGNvBqBIfMtozYYOwenfHsQ2rAFOLL0GH6PuW4NJd4x+yV4hcy
 BmyS21cu07cpBHT6jSbDnyEBFjHhSYPOnDWZlIJhUHVSeYtd+yYuCRGgC8/DvYTr88h/RC8Sp
 hASdOAo+PkR1nu5nw+qAAarVvXITAWTaRwFdWaxBoaxezPmyJwe9F5DeQRy6d+FOp5h9Myp4n
 7yf5b6RyDA7akVu12Wn15gEVU+UxDQje6zZKDxzydM9oFyfbJb3QAxqsfutlnEc/5DcAoo3SI
 qOEryewP6Z8SkRrUatAawcL/FLy7q7VSF9m0AwCK5P5um9q7GzPtr2oNYYuLVvFiKTAQLhtFv
 f8i4tzks/zk8bwm1QhRH4nJ3gU+VE/6JfXA4WYzi8JctbWcVMxdGnCAyD2RtTK5kQpnunP847
 T1TRz3l1T9xwT1UKNCZwaU14fRjL7QoESQVQoOrCZD7DwA1lP2U+ngOfPq73+cdY4153UxzNV
 OskxVU+AXyyUnM27cnAoQ5WGwcTcx4JhXHHgTNivLnFUbfrj5MljjW41qGV6C1w1pSxKbUcBU
 xXj7J7K8SPNl7MG1CxqvYtMYK/He1qgOAD8RmzfL3H7xTD0ulG2ef0VDpWBp9sHYbuhMpAczh
 LfD7a7PQOGuqyJh0uVFATfTMUGhMu86B4wIJK+7Q48FmmAPJ1o906yxNOrrSkV+CDefAr6kSG
 q9gabXvf8ar7jNoCGHQ02P5LH1u8pRldmUVS8cQlSme0ixMJh0W495VaJB0DhLRmAOqFnW4m3
 OUkRWlpC2aXhCiNWGWHcisoCWYq+F7nFJZRffjoX0SQrefgwe/V7ql6IX1HLamrg5N4vuYjGv
 RvLsGxx5ZqL1wpj6D6N8hZANOmNXn7v3HH6sgFX5fVeWMpBhSOlomyfu2PcflcKeCQf6MWG5H
 aEB9SBxpE8tcTl1Azg7LgxxO1o8OnyLpsj95k8ncaBBjwsw1gVotmaNay/gTzYfD/AiNyUKTH
 eSDDKK5StZis3fQbpNPweqkzLrU0wbLnEf8IbXK/iEz8x5K0LH7Xf2yUGOB4DQOGbupn0opJg
 cgdbD46FDi42mp1yn
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 29 Apr 2020 20:40:16 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 29 Apr 2020 20:40:12 +0200 (CEST)
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

> I am trying to exit spatch with a non-zero exit status when required
> changes have been found.

I got used to the interpretation that a zero exit status
should indicate a successful execution of the program.


>   @finalize:python@
>   @@
>   exit(cnt)
>
> where cnt is incremented by another Python rule everytime a required
> change is found.

I suggest to handle the desired search result counter
by an other data processing interface.
How would you like to treat program execution failures otherwise?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
