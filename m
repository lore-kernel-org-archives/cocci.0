Return-Path: <SRS0=8+TR=VJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0291C742BA
	for <cocci@archiver.kernel.org>; Fri, 12 Jul 2019 11:58:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4818F20863
	for <cocci@archiver.kernel.org>; Fri, 12 Jul 2019 11:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4818F20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6CBwbvA005420;
	Fri, 12 Jul 2019 13:58:37 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 66FF7777E;
	Fri, 12 Jul 2019 13:58:37 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3EA057772
 for <cocci@systeme.lip6.fr>; Fri, 12 Jul 2019 13:58:36 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6CBwZuE008307
 for <cocci@systeme.lip6.fr>; Fri, 12 Jul 2019 13:58:35 +0200 (CEST)
Received: from [192.168.1.110] ([77.9.38.202]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MIMOy-1hiZFD2G04-00EP0N; Fri, 12 Jul 2019 12:52:15 +0200
To: LKML <linux-kernel@vger.kernel.org>, Coccinelle <cocci@systeme.lip6.fr>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <732996cf-5813-22a3-ee69-d8dc353845f4@metux.net>
Date: Fri, 12 Jul 2019 12:52:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:eDjw4wbraMlZJSs59JKpHBRDvOW73+W+qNBXn/MmPDlHhA1v+j9
 tjILmbKLmWRiQdCzg80YeQlx+jxAFL1hkHjWMifC8LHnYpwMAf12pC2aGg3nzmkkZXo9nbz
 zCsioxAngGrJJEGag1O6k1rDmb8I4c/qLgpYNI+sKOEoUrJ5OdlAMg8kju/KZ0m1oMvOUMG
 hc8L3HHQudYfhwfn4DO2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iYB8MX6iSk4=:rjWV5IHXQU4vhRVfcuhnnc
 aFPLWA3aYLzqWYbdTus9vpOJnLAntB1T5OezmzQc+sV/gRZImeHLOxHBgxoyaGFEV65zzhScs
 TJchCkcxvu+nJi7Lj3e5l3DAp/QBgFDy5xu7HoDIG3TW1znChod/fVbAi309GNfeUeG1d1Zvp
 lLDN1rbos+/30J4MFIvit6Q2KctX7uFQyVT/C0JH2OkQSQTXHtKiipwrkyVGYpVsvbSB3itzy
 N/Tm5V5WxC6OURrzPN47UP8555IIoBpmIinfBWB7jfuxcdPgCmBPMLKIdJJMM4ECV3o1xgXY/
 QJF6sPE1EgF1NNC1bDkJjxaqEvkXni8pWcFLp2VSEiekk7LR/yuPvNUOIfHPbbUNOWjvfmbon
 5PTAOpjfPoQoHet0xeTJQvgT0SkL+fJb6nRt1hi3D+p9bb1w94PTdX74fZsRupRfBOTnGQevw
 KAANXq6tf4AbiBhXr9zQZoaSwxyOZqyyl7V5jHAEO/hJ9fs1AMpbxk/mNtBR+5BTB5a1SdZX5
 EUWz/Aub9ldv5cmMzryiOuHKGE9ejyCQcgqZEjg4gRaqj3JAQ1OG3Z1vBP/4Za5SKmR/DxAxh
 3Y1dI9hGAvl0bS6htDLSdtyZb7wndmXqFjpSN/oNcT9oyxsNFictJJRHl2X5uA+iVz/cJBu1J
 cT6NZh9tbVIYEVpq4zsQxswLQw9NwFKRJy8VY85xilYRuY2dPn7Xvbot3SHEaUnleO7rDFnZ8
 2zhRRtJ4+K3LGmgfqnMaYFniCRYLHlvNvutQnGNA0TPY6iyM4LEhjVNrNS0=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 12 Jul 2019 13:58:37 +0200 (CEST)
X-Greylist: Delayed for 00:53:44 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Fri, 12 Jul 2019 13:58:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] NULL pointer constraints vs. compiler checks
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

Hello folks,


we recently have lots of patches for either adding missing NULL checks,
removing unneeded ones, etc. It seems that's an non-trivial terrain,
so I'm thinking about potential compiler support.

Does anybody know whether gcc has some way for not-null constraints ?


thx
--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
