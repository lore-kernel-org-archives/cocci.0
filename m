Return-Path: <SRS0=/zSI=Z4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C1BC43603
	for <cocci@archiver.kernel.org>; Fri,  6 Dec 2019 19:20:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C3A2464E
	for <cocci@archiver.kernel.org>; Fri,  6 Dec 2019 19:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ZdHEIkjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C3A2464E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB6JKTlv011352;
	Fri, 6 Dec 2019 20:20:29 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8B4C577D9;
	Fri,  6 Dec 2019 20:20:29 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 940D677D8
 for <cocci@systeme.lip6.fr>; Fri,  6 Dec 2019 20:20:27 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB6JKRr1013214
 for <cocci@systeme.lip6.fr>; Fri, 6 Dec 2019 20:20:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1575660026;
 bh=/mIquFLjCLzjncLIYsYr9PN9EQX2me02doKl/v6DLDA=;
 h=X-UI-Sender-Class:To:References:Subject:From:Cc:Date:In-Reply-To;
 b=ZdHEIkjM5BW2tF7doYDR3VXXBBAtPHnGsKwNtSwoZIzF9Gg0tqFU9XuIZWptIsrX6
 4mVDOl9cC4Po4l1KcPBr4eGjVJOJIDeSswaA1t8tuaPMphosT780JhmiX9Pr394fmo
 kvKNVlxWSxRHLYR0y1kQEsBM/xVu9kRJt/0JnAuM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.146.60]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MKrLo-1idJ9N40LA-0002OY; Fri, 06
 Dec 2019 20:20:26 +0100
To: stracelabs@gmail.com
References: <CABvP5W2+fUip+jEAO-G+ZyUPJhx5iCHcTRxkiYsiok_a3zTuRw@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f23fcf2f-c0be-ac86-ca7e-398ad2d7996f@web.de>
Date: Fri, 6 Dec 2019 20:20:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABvP5W2+fUip+jEAO-G+ZyUPJhx5iCHcTRxkiYsiok_a3zTuRw@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:FO/co/cFDTeYV1DC9GeEbYT9rFlysewpXzwn1Jub89H90fSZtIj
 pEsMs/HCOJ9eXhsznFVSxC/NcKOQD27TA7Kv0yIpdq2okvsXemupq8ijnpIl1AsMIlbyDWd
 TW5xakcj2qCYcPoIF9SBX5Y+KlNcDW6j2ch3uoDGticM84Sknv2BYwMjEqKkJ+mNJIJegp2
 187IzUgWtG8WoOa+h/6CQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PeJDsJqzPLU=:p7FFsLyoGsEAPDGBzDotVR
 bASvzbXn5A7FA7eizLdhEyIpDchtUqRxDa4yKCqWoMlHh7jaqgrYYfJoAdLikKLnZ9k4Z+GHn
 72DeC1QN1iLsLMtUkrKesnfsZXW7XUaUHf4jlAHpXkw7oxZ0n7w+4JBPPBuQZE9RQTy3eE+s5
 10q7no/rbs/gFDWaynCEBZzLo0lVnndsHRd6zqG3NrBbEa0W/TEZUZrVcu4ke+xX8/XRFybHh
 +gxLf9Yl0b0x8n8yNlmCo+lTBfUi9kU64rcYwQnJiWzqPV0yc3MeBtBqrNXvzIgwybmfOjmEt
 STTt5Zp+zYexVNgLGw4VxhwHCEwPq1v1Guix6R47EjLSbEVVpKW2jT/7p0oioXNC2Y2KD7B+S
 LQKF/DDoAGVgmAVnYSVSp1w2kraYXlbjKkKG93nkOfOGljQY54BPZAKPV+m3OiEQbSAPjATVe
 IRW1lh5+CVa+9zbrgjhwGBuP28gtiFv7lFGpYxkqwrLtYy/ZZiUUFY4dTluMkzwiKtOahdLPm
 d6hma6yyFOn48eS7gdNdbrXcpRaoA7Uk+fbJyphADJ5fOBu/i1/RYPKUSgtLjhUyoqhHg7EJW
 4On2MLg484+zt8WbvxyqvSvRB/E+0oQ+oW8HKg99Dgu1ugpDShtanDrkwK2J8zxhO0ABO0y6m
 m8BO3yIgD1brBcfOAi1WE8OCuGxQsJK/zeBo1U7/aw6J2ICHBZyfuqfwIkToHcfr1w7v9itjm
 E1Po8DrtFffv98Clro8MqKaLLHlB+bUtDo+2EUT2l2AiG1+FdXkpWg+3nMGK37Kw/hNljOA6A
 i1qPNbsgOAKAuJCVu01B7L6MRNd6mJ8i0ye1deyRDZKN4LKY5n5j5OLFKTrtPg4s1N3GmDyTR
 WSGUIx2Ey2lck6gSRKfLzfcTNz8DOrwWgmAnpiofMsXU1npEUdeMsvO5WWlLCdO3/mQMTFat7
 e7EIclzjrw3fXZ3sS2tgNniTwUR70CfYafVWcnD9xVVJlJKUXQJoIuFCe9p1yqtAqq/aPsn0+
 umDth3Kkdr60T3Wurr49/PH1X4iT1eLpl+ehBsBzU3wapgbfwniAOXlkcd2RcS6cQSB53T0U9
 xuUeeRK8NAoF+LyYEtFm4WtEyE99yP7+eVX3jvOBXEsTj0AjpxfWlvr02cKtu3Wr50aeusE9I
 Q0hAA7Uo5WmnTbQ1jbV0qtKJn8qmATTZTxGLCZ+HpiHgioddpplSh/fhTi5AQKjfkWce2eS1y
 KfrATfGaRWef/cTXcRXGki5CdU4XGqxI1ulm3yNTD0eGg5nX+FgMBmrvaN88=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 06 Dec 2019 20:20:30 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 06 Dec 2019 20:20:27 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Changing format string usage with SmPL?
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

> Unfortunately, it doesn't work.

A bit more information would be nice for the explanation of the failure reason.

I assume that you are still looking for better support of format strings
with several conversion parameters.


> But, I am working on some solutions using Python.

I am curious how corresponding approaches will evolve further.


> But, Is it possible to rename/handle the *expression list?*

Renaming can not be performed for the list. Data processing can become more
interesting for the managed elements, can't it?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
