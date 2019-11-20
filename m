Return-Path: <SRS0=d8Qa=ZM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BC6C432C0
	for <cocci@archiver.kernel.org>; Wed, 20 Nov 2019 20:32:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520DF20872
	for <cocci@archiver.kernel.org>; Wed, 20 Nov 2019 20:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520DF20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAKKVpPr002230;
	Wed, 20 Nov 2019 21:31:51 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B69DF77CE;
	Wed, 20 Nov 2019 21:31:51 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A63F877C9
 for <cocci@systeme.lip6.fr>; Wed, 20 Nov 2019 21:31:49 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAKKVnHm009640
 for <cocci@systeme.lip6.fr>; Wed, 20 Nov 2019 21:31:49 +0100 (CET)
Received: from [192.168.1.155] ([95.118.64.133]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MPGNn-1iCO7a0RrR-00PaoC for <cocci@systeme.lip6.fr>; Wed, 20 Nov 2019
 20:51:07 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <66e7cfc9-e1c9-2b89-5d22-c6f6910aad1b@metux.net>
Date: Wed, 20 Nov 2019 20:50:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Language: tl
X-Provags-ID: V03:K1:aQdq7MGWJPx/37GCKlD8cSQP+B3BjMIJ6oreIw96+MGvKe22DGV
 90YRi+nt91oWrrt4ZImS38c1D9ZJi53shfuk3w+exg4zvoq2bW5nGKd2H/ClUtpIHeocN9z
 Iyvx4UpAf7iSqQk2gEdRt01IxG3f4CbJK8oPYoJhVbJJOdxH9kr8NNQnyG2tWWG+ceO0W/K
 c36Rh+HjGZVOHZ3ozhNeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DY9L53/b7kg=:38m/XqRIy9rsQ7hmQDQQja
 d45r/F3uaUllq3Nfh4xHfCnUpmojGjk9zSdZa5KeMTK9OueIcNHn5y8hiAQeV27p2Mrdj7MzX
 h0LeqTLFrSsVIMBcuib9MHbOlySTCtokxKARhhj5hqIJi/yAkNi5Pxy+VE5/HM/hIGosxFuUF
 T3WIzKvpGljpHt52FVEqJbz9BlzS/x2RkaGAOvmg8imOuxFcPHULUC16g8TsN/VaqySnNmF/9
 Ot1LUuyxnJXf1wP9ic2YrdV5aIXIv6ZtKTMEq1C2xaz28ekqsZToAluSZTrg5mcJZTIPYaNgE
 cDICfnsBiIkEjFqBMQO1ADwUw51JM8lM0CWVHuEQlnfbzFDxjRcUjiZSTce7wmOzCoR8L5ZLg
 TrGXzhJ2xdNxZ3fl9bGB235wtcgvrSkvoPcHHxn9BIPAV2wJ/RB1HVFhME6RqIg9Gg6D/OhB3
 1A91XWevv4NFHxkLiq3u5pdu7QnAqbpRMoxSuGFNESzsoaM1ztXGiHdGrTMnpEGGNWDc7x567
 8+MSSOm8WxE0Zu3z+lb9B1f3nsKviIloKRq1zdkgikdsjsjP9NLbdgd/zqqAOjoejJbn9J4qt
 7q0FBzAnsyMn6sSpa5hFSLRnYcfN0xRol+SqLt0RyKDV6r6MkTvMfxPyaAhtTlzUqzOPZ2KN3
 B7N8SGwROu0wHNk00/11yr33F98NKUqhyIofJxA1tKxMuimvpqn8vOTDHzqYJsvNLc1vzQI73
 qxRxGsVGkoILqkB60kgMYGeNWuzmwYir3mJAb9cJmTV7U9RhbclCe4feRcuRebG8DNuOgzy89
 byEZ70smpT08/ihBg9VL/SwAHpyGJ8uPG8pY2/X2zzVbkZOsQsUMovotXz/5b79C7aO71sXLp
 0wvx9NSWjGDf+5j+TDAw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 20 Nov 2019 21:31:52 +0100 (CET)
X-Greylist: Delayed for 00:40:42 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Wed, 20 Nov 2019 21:31:49 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] field access scoping / check who accesses certain struct
	members ?
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

Hi folks,


is there a way to scan for code lines that access certain struct
members ?

Rationale:

In the kernel, we have lots of struct fields (eg. in struct device)
which are supposed to be only accessed by certain subsystems.
I'd like to add some checks for that by scanning for all sites that
access certain struct members and filter out those files that are
allowed to do so. This should print out all sites which do those
unallowed direct access w/o going through the appropriate helpers.


--mtx

---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
