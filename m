Return-Path: <SRS0=oEM1=56=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90770C2BA19
	for <cocci@archiver.kernel.org>; Tue, 14 Apr 2020 18:01:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF1420767
	for <cocci@archiver.kernel.org>; Tue, 14 Apr 2020 18:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ftEYrlV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF1420767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03EI0vb4003226;
	Tue, 14 Apr 2020 20:00:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 459B83DC8;
	Tue, 14 Apr 2020 20:00:57 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8C9393B93
 for <cocci@systeme.lip6.fr>; Tue, 14 Apr 2020 20:00:56 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03EI0tUS010923
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 14 Apr 2020 20:00:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586887255;
 bh=qcGgHxI6aRq0ih2mILVqQrSy3weBp7ErRhV0qTh52tk=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=ftEYrlV+fQ4LbQBzJmafKaZK/8mft2XswL9j4aA0TVeJMCpxW1dceXo64HU1Lyi6y
 +8MUS/qgL/ltSkZ0Gh8v7cTLg/W1c4h2Qwxmmv6g160FVcekLzgzTf68+NWpnejsHg
 63Hzsd/TcYgeM0MmjxITAe0XKO7YTwf5ghuTSH5U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.66.171]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcPWs-1ixIaf2PDi-00jrUk for
 <cocci@systeme.lip6.fr>; Tue, 14 Apr 2020 20:00:55 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <aade48e6-7a4e-f2fc-5cbc-082423287420@web.de>
Date: Tue, 14 Apr 2020 20:00:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:t4yfLIPPrpsUHkDN6rbqe2Qntej9feZvgFo1knReKT5ydYALO1k
 kmjmgwiedTILockzy26JqE5rkv1fElK1ItqxtEh2MAR4F/AomFcu/WT7s9ilMthLUE4NBY6
 vada899tj7U69VyWNUtLZTMUiCnmIk+B3O2wBfjIKbyUv8PiLKYtc1yHOqkFNzQcwQWjg+6
 6Ey36sa/RlPX86AyxlBUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lb0ZtKi8H6k=:sv/vwGbJTvg7pHQ0fgUYRF
 cuXHKqZfFvE/YnMCZHNcMMZov3DJ8MfjdtOeqZPvsJ+G2mhMoYwvDDWR+YNEMs8tLkNK4HNGs
 dOpOUhJ5hS5gNLKFJ/oXwZbf6D0sCPraTPfcsCjDaJypzFNLGdGkeNPp/b154z3n0AoRteVtV
 cBuUEKPDS0mq2947CIMmXJSoNHOJbT+7XzXBloIjee/PvrFjysZpaKFE7Vu00a4tB12OtTwAm
 VT+fOoK0RHfJGMIRVFc1V81zM1JemYSFhu5TaOae92FsBlbN8hDR3VasVxleWVwaIgHW8WlD6
 Agn73+g63StMBjg+RigXnPxjMChAoxAnttYtUHYvqyni9/r32Y02UaHN4d3LsdOiUETIKFWmK
 PjAqHemyM3EaG2ERNkp5qjOCtYndS4HKq0Laf+a1zKWunM45OL1ATSg7d3L4c7EAAzWpTuAmd
 9ccVYnvEOzGS39HwpgYqZ+I2QJWwKHJok1obOgzSinDSxaKzhoFKddQtO0IgEMxNObVsOgZnj
 E6ljxwWVnucsNwotbd6YHflzKBACRNr7VFOc7/Z4dAejxVZEUPx8H1MrE+lBSAF/MbbPDwM+p
 1DnAvPiNJoTP2i1bcSK/wAPUJgKGIQZo3Zl4wEqPfQetyEPR0mj88Sm2DMcapYIXr2DyC8/2l
 smDmMrBAaw9ByYVUn0z9avIiy8+o12c62Y213b7TcxCk9MAhltw7XJz3IIAkfsd1FM476CAfU
 G8gYr5l/kndhRZcyaqsWtrT8n83qHceG+btX4KYG3N/lk2itqyqQV+yJjVaoIMPjXnhlmhX+o
 uDGSyeT/gM8alFBCMMy3Iwb5CGnAO2g8rMgBMkJCp45dJCJU7wkNofL4LP/RIW2zGeJPuBN7m
 6KRTy9Sg2wK+StEdujXV+/2F5fnRc9rLz8PZjtSh6GaeD3qcpZf9N8qBeEZ43qO5eGF/Ngayi
 I+GSANmG0iZfQyKXW+srF/BQdkUM7p1bmWpazrMILzsKBL2fU80uFAbp77etkEmpi7etwrdA2
 FBzPJ0WULxZyVsm1ztmEau7WipEi5/xEK/pMi2P/sD3LAdneqgtPAftGnVQx8GPLTmXC9rJNJ
 EdwafL56+QhXTaGE/zw6O5FgzGl3RaHNjh9qZWrmHlvbuE9KDRoobX3e30Lz3OcUJIP6tCwuL
 CEzW9Hh1Tlf+GnP1Mtwlw70PpFgdDBOxD4+ZbnD75XMb/KGQd/3mDOBA/pq/PhEp07GztvBre
 LCHChTY5xFIsV1F59
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 14 Apr 2020 20:00:57 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 14 Apr 2020 20:00:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Querying symbol tables in SmPL scripts?
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

Hello,

The semantic patch language supports to search for various identifiers
in source files. It is often hoped then that a found identifier fits to
a known application context.
But it can happen with generic source code analysis approaches that
a desirable confidence level can not easily be achieved.
Thus I would be looking for additional means to reduce uncertainty about
a software situation considerably. I imagine that a corresponding possibility
would be the use of symbol tables. Such tables provide some information for
known symbols.

How do you think about to take such data structures into account a bit more?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
