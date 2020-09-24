Return-Path: <SRS0=fIkn=DB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214C1C4363D
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 14:25:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151DC22208
	for <cocci@archiver.kernel.org>; Thu, 24 Sep 2020 14:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="oDJBn35Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151DC22208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OEOgGx019777;
	Thu, 24 Sep 2020 16:24:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3BF18778D;
	Thu, 24 Sep 2020 16:24:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 415134452
 for <cocci@systeme.lip6.fr>; Thu, 24 Sep 2020 16:10:28 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08OEAR98018753;
 Thu, 24 Sep 2020 16:10:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1600956627;
 bh=9vIUpH64YdE8+29+4QOwcDTCZS9vfAQrdCDMTSbuQkM=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=oDJBn35Yi7MNZew2zGMzcN6nNuGAoMC9o9SXDIgJryggSj4TMVw9xz3icNBTijTx6
 osn3K15f743oVg/E3FY8sdLt+K+LzpThmzU87BxKXmVpgEH42RKz5GqpFTASdiExUo
 p3F8RIHIKuwXlylqXiSIHtXpjsU8zKnNZqUeNbAM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.48.46]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Md16Y-1k4TIW3DTW-00ICZ8; Thu, 24
 Sep 2020 16:10:26 +0200
To: Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <67ad40bd-c0c0-8c5c-54b2-c750cfeefd44@web.de>
Date: Thu, 24 Sep 2020 16:10:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:sCUsc49cA+RY8DceRR5ozj2m7Og8j1XXa5erumW0IqT1meq4NyZ
 bpO6i8Ibp+RkJzMJH4KKe27SNH3FKh9xlafU+nVXmi+3Lts1htnzH6H96PbsCmwZwr6V3wQ
 uBwTLdycF+SUO5oZqgAHc9yvzvxt7g8r9hn2RS8hQI/ObbMMCx02lTpkoBlO9qXZuEiUqaB
 NLQD5LNKPmTZqoOY+a1XQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6MqS9KBUXbk=:/wkJTlDElFJu3kXtHjKz4+
 ewMaK1mQgViR1zClz5woFPNb5FMaZZNOsepjVirpOaikHY2IJVddhfK7E21Q0bZJF8DcGEhqp
 n/dtSsaHobJwKqchsTPThytRlnJGY7FlOFEc6zW6doTyy/tGP7x2Qsxh2taU9qDdVHEaRkOoj
 Q45buR9/34yxW3dlDvvarUQASZvqZRmW3zHjJl7Tm1Bsn9yd9LFpEOUB4x7gZfzp4zRk3u2b7
 1watrF78IRdD8dpQWOXU2jgSVYL1Al/LWIiWuNggZGlMT0fVmcDaGh9LPMKMnIcBkUYlU8x96
 F9EEUGExxnQh6NBjsef72YJZ/zrr4okgGZBavYI4ewX+Q2yH8eZXynuI9bVbRIqCT9B3y9yft
 +We5JaJefJgt4LHi2BAgoMjas2EqraxwpEjj0bryUs1qAmit6li4zwaMVtfDxse/+vnPUBFDB
 34nmu3aU+dgL0nw+eWeOokFrs2HPUyl2+JvGf7tVIULNnwCaoM4WL6a5SSHalAqK5WR0ZdNjT
 LeJu3mLwUp/jiYmtXMMxvtMCljwnK2xxLz9tlp9tglCu3hRpYmKzVDTfEBvI1U0TcKUERVsTv
 swIJxCQf54l+Y/p00770BMla+C7etGS068y4VelDMZM1+GNJFaO2nXFJmgmP9yXznGB9G4UQk
 ebFakdfdx1/QffEIOU97pU/uIvVGowdNP/mytidkDw6kKfpMrnDOPJlGSQ7Y1vd3veIPxgVNd
 i+6Rukslfa8A26CzGcDgjNh02v8dUgNg1xS4DuZ0qvq+DMfkLCtxfq7HsXYvT3PIc5yCCTLBG
 gFfaFxv3uEOzK7utAwYmjobWp2zan5xha36+jizxe7WM1i4UI3kNmHYHW1U+b/O196p5D9ruC
 vN8nQcLQZBGM3A15hCKM0D0/Yzsd+rJhnciUOmZ2O5tl+p1HSadjXaDQbZN/f+eAdEkeQ94lJ
 MY+gFtGyYfQJzrOdT6Fm/COeoGevYIgNo3O9fTYx+HI5+VIo16QJDVm712GUUbf+gWN6xbqZi
 B8T0+yNQoOiQe7AHPHZ+HQad8x3d5PGGxKV3LvnJD4b20KQUgKpRJXCKyXa0nP2WOGG+SC3Y6
 KmPNtJmJxuf7BTL4ZuSPSamj47+SZiN+JhAZd+sSH/1B9Elip5uFsmmRYoKr6WA8NkUbCRMw7
 H1AEvVgrjiBZzu+GfCbLMT4Psb0v7dvowoE5c7WKWLec6nxQK3M+QsUWKkrK2IglPMI/2jny2
 DmTmxfJtbnG5+cA+ZOCFcoSImqI+9aTXJE/LBmA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Sep 2020 16:24:42 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 24 Sep 2020 16:10:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 24 Sep 2020 16:24:40 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [Cocci] [PATCH] coccinelle: iterators: Add for_each_child.cocci
	script
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

> +@ruletwo depends on patch && !context && !org && !report@

How do you think about to combine code from two SmPL rules
by using another SmPL disjunction like the following?

@addition_rule depends on patch && !context && !org && !report@
local idexpression r.n;
expression e,e1;
expression list [r.n1] es;
iterator r.i,i1,i2;
statement S,S2;
@@
(
 i(es,n,...) {
 ...
(of_node_put(n);
|e = n
|return n;
|i1(...,n,...) S
|
+of_node_put(n);
?return ...;
)
 ... when any
 }
|
 i(es,n,...) {
 ...
(of_node_put(n);
|e = n
|i1(...,n,...) S
|
+of_node_put(n);
?break;
)
 ... when any
 }
 ... when != n
     when strict
(n = e1;
|
?i2(...,n,...) S2
)
)


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
