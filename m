Return-Path: <SRS0=sy63=5N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E04C43331
	for <cocci@archiver.kernel.org>; Sat, 28 Mar 2020 16:00:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96F0206DB
	for <cocci@archiver.kernel.org>; Sat, 28 Mar 2020 16:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="kgdgW2T6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96F0206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02SG0SQu008095;
	Sat, 28 Mar 2020 17:00:28 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 10ED57812;
	Sat, 28 Mar 2020 17:00:28 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1B8B566CB
 for <cocci@systeme.lip6.fr>; Sat, 28 Mar 2020 17:00:26 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02SG0PS2029421
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 28 Mar 2020 17:00:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1585411224;
 bh=RhEzvcR/PA2wjljKeiXNx1KK1BPtva8VC/ok3730Ut8=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=kgdgW2T6h9xqBZDq8qCtkN6Ot9ABzZWT8opoW5/aAw1eTkure75Cv7xNNemqOn+VT
 CEki2YsPoydYgu1kNqsI5lqdYaT7abe9CSHz/DJYzQQAXKIL4YvhX0wu0MPv3HCL9F
 JoR2dKoeOxDlDGhzP3+V67g6sL4jAyzcVBjLgBlo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.150.134]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MN43c-1jBcAa2x9E-006cGN; Sat, 28
 Mar 2020 17:00:24 +0100
To: George McCollister <george.mccollister@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d3ea3700-7dc2-b6d6-e284-e9620bece6dd@web.de>
Date: Sat, 28 Mar 2020 17:00:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:azYUxPSIGxoop791E4yzQT+e32g0ftREfvCaEZQNrJaCpChe94U
 0uuoPhnvbmYQEsZRH4p/Jz6sGE4yDt8pwBbwa3wHX07iqYDdkkYENh+GkG6osQATgAmhTL2
 z0T+olm5DBQeBGGe9Kzwrr5Kn8QjDzcQGTwkWHp8ZiK9xxtRr377y2rKqI/5yIAmM4RflrS
 BqbLPTebVGy8Pzl4Ggudw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UT4K/F4UDAE=:2xoEqOAEOJpSspFd50I0p0
 0URQ5wq3j+kVpcNPlPPLSxctmiB356DIzNmSWYBERBTxYJ4d5vXqlpScWbx6/puEyndyFdjsp
 fOM94yeynBX9fEbeuPq1AcbnJPVE5z/BiM+5BIK9actJFzqTS1gIiR+JXon1scCFMdz+p4dWs
 EZqLpMr5KjAh4W398ccPQWqtzCvUp1d6qFTMfPM80GkDRaHO/7woGMFMts/+90BJx10tpbc2l
 zzr6KJjvqsxekaEoh/EahIKmO4BlzEtGfyXTtzIE/zdkAMJS9g9tUQNDkLMnu2Wvy9n5o8OxU
 bxNggLf7z3eWOHefThx67lAMGfFWVLwBwijgCTfSZMhRuNKwCrXs97Puam4ybYf+Y6Pnw3JvY
 hbghHb4b4r8HeI40xBDyYc/jPi0EY50dKWx8Uysh2voIERpleCpD8XwfWAtgMmgGdIo+M843/
 x9pV47M2ggAAqvS/34NEUy1E8gCe6K/qCYMcsmJHWKTpvluPAvlvp1GaSy389j4QsZ5wF7Rov
 BPfBqtBkQ+6iLaJYfw6Bl4WZsiwuuflfz4jet35pL41NXgDXkx0pdQssr2ZjyLfeuZ++cRcmC
 NiAvW9TepJ7oIqCSPewNxj49Ec9Jj8gTuGEJdSeLA+Q0rmX72O7llNwulxLJNkIh397ghj38H
 GHiMd0PMS/PaF1NiNhE7dZtWHVfi5BnWhQ37yDBM6ftx3rXVp1809Nrx5hpLCzjh5mVxPgK35
 +YOMGtkhxw++oDKV97fPJnc0M2xp0CarguvPmtwWXb3ZFFVipwHBNIN7QuSwhlbz9DR2G/reL
 Lp9ervwBZLAiSu5oylC9DbSpN97iygftBwF9sjZoJXTTkSJDNmMYTYnI/SsB7BpirE0VaHrUB
 2puu8o99Od5n/TdCrKZFAKXxOc81kwBPUQGa+Mb+EXQCo8B1iGVteELLZHpGG3nMV6Xd1Ed6m
 GalLDXbbMAq0V6Xoj8yyQ1yo84HvbsG/jBqcqtSdZVwNsK/NvIYz+XWRZZyN5VMqnWlpqBIbK
 sDGaLn+BoOphcmzHR7JvSHFxLg3l1GOUj+LtRWdo1pdJBUgz/WuBWWB13ox/AfNMQ4k8H2Qxl
 SXOmjnfbVm/TynCx4jIzk01FnzLVQ+D766qSfPuF9q7bmZGYNmd/94vZomKp6wdLJo8cx1v4a
 GSXjUrSSayn+C8bQR0w0sL9gSyrqFwPTlhL4s9m72oyLroZAcq3ypE1ohMi2sgcO9DchNiSLi
 MiH1WAzL5CUuqFkq3
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 28 Mar 2020 17:00:28 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 28 Mar 2020 17:00:25 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Using SmPL script to switch to formatted log/print
 function
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

> I have this all working with the following script with the caveat that
> running it on moderately complicated source files makes it never
> finish (after an hour or so the spatch process crashes with a stack
> overflow error).

Do you find any information interesting from a previous bug report?
https://github.com/coccinelle/coccinelle/issues/30


> Any suggestions on changes to my script that would make this work on
> lengthy source files would be greatly appreciated!

Additional adjustments can be considered for transformation approaches.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
