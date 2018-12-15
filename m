Return-Path: <SRS0=7lyY=OY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B4FC43387
	for <cocci@archiver.kernel.org>; Sat, 15 Dec 2018 10:56:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9779206C2
	for <cocci@archiver.kernel.org>; Sat, 15 Dec 2018 10:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BTdHtFKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9779206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBFAu2UG003725
          ; Sat, 15 Dec 2018 11:56:02 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6F57276D8;
	Sat, 15 Dec 2018 11:56:02 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7DA9176D5
 for <cocci@systeme.lip6.fr>; Sat, 15 Dec 2018 11:55:59 +0100 (CET)
Received: from condef-09.nifty.com (condef-09.nifty.com [202.248.20.74])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBFAtv8x004063
 for <cocci@systeme.lip6.fr>; Sat, 15 Dec 2018 11:55:57 +0100 (CET)
X-pt: isis.lip6.fr
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-09.nifty.com
 with ESMTP id wBFAawxX013255
 for <cocci@systeme.lip6.fr>; Sat, 15 Dec 2018 19:36:59 +0900
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id wBFAZnIX030698
 for <cocci@systeme.lip6.fr>; Sat, 15 Dec 2018 19:35:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wBFAZnIX030698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544870150;
 bh=Se/CygLed0b2Rxr7lrdKfHP0lbTuOWGTz+r/5tfczSk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=BTdHtFKHbZDfS+0Vxz17cs9QibrWyDT6zcIFnJnC9xGoqhxvijBbfsRQu3o8YUFI+
 5oReNW3P3xrC6RSde6a1w9j2iMWd73qdnThmV3eETKos9CPQ091MuYFh2BL29sO6jt
 zxcbk8mqmVfqpoxhzeyvT/j4SRjvrcg+dLpBtFp87xyahJEAX8CGL3EkxViwAbU5RU
 WHZ2Rcqk1JkWWU/sxKlEoUHDWJDoJ1UTENMBsBw8yNFkzqw1KhPTVplRTQjncoKw+7
 U6mOwHwt4tqFEmvBzA68T3+qPDchPT7xmdBwaJr4iBcQh77jHb4ZQPStS9U6xfToUa
 rivW74Rak8YIQ==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id t17so4917932vsc.8
 for <cocci@systeme.lip6.fr>; Sat, 15 Dec 2018 02:35:50 -0800 (PST)
X-Gm-Message-State: AA+aEWbzIbSotGCJQ0+sCLcaCW0YGaFXh9shHwlBWDivacfulHEiV/hr
 ExLnZoLIZ78GnrfV3OmqnjLEUAND4r/zwoLLBIg=
X-Google-Smtp-Source: AFSGD/UC+0s17aXtlgTP8bcHD2yOCmBmOGkUsoIU+GV9RLM5+f/gTn+cnkwh7s4c1BczcCkuQfoiKp2qeIJ9euBx/xo=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr2887640vsm.181.1544870148984; 
 Sat, 15 Dec 2018 02:35:48 -0800 (PST)
MIME-Version: 1.0
References: <1544615757-19356-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1544615757-19356-1-git-send-email-Julia.Lawall@lip6.fr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 15 Dec 2018 19:35:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvXCMMqqKo_+HupOhABaYZZ5yuZ9Dq+EycjytMdOk-Zw@mail.gmail.com>
Message-ID: <CAK7LNATvXCMMqqKo_+HupOhABaYZZ5yuZ9Dq+EycjytMdOk-Zw@mail.gmail.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 15 Dec 2018 11:56:03 +0100 (CET)
X-Greylist: Delayed for 00:12:06 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sat, 15 Dec 2018 11:55:58 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 0/2] scripts: coccinelle: Improve boolinit
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

On Wed, Dec 12, 2018 at 9:34 PM Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>
> Reduce the scope of the rule and improve the warning messages.
>
> julia (2):
>   scripts: coccinelle: only suggest true/false in files that already use
>     them
>   scripts: coccinelle: Correct warning message


Applied to linux-kbuild. Thanks!


>  scripts/coccinelle/misc/boolinit.cocci | 43 +++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
>
> --
> 1.9.1
>


-- 
Best Regards
Masahiro Yamada
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
