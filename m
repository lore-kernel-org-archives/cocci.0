Return-Path: <SRS0=17+G=QX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC87DC43381
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 08:09:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D64B222D7
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 08:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D64B222D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1G89J6t009606
          ; Sat, 16 Feb 2019 09:09:19 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2413776FA;
	Sat, 16 Feb 2019 09:09:19 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 263F676F4
 for <cocci@systeme.lip6.fr>; Sat, 16 Feb 2019 09:09:17 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1G89GYm029875
 for <cocci@systeme.lip6.fr>; Sat, 16 Feb 2019 09:09:16 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.58,375,1544482800"; d="scan'208";a="296375171"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2019 09:09:15 +0100
Date: Sat, 16 Feb 2019 09:09:14 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: wen.yang99@zte.com.cn
In-Reply-To: <201902161529041506841@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1902160908150.3212@hadrien>
References: 1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn,
 b2f195e8-c3a3-f876-a075-317bb33496c6@web.de
 <201902161529041506841@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-938833334-1550304555=:3212"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 16 Feb 2019 09:09:19 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 16 Feb 2019 09:09:16 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, kernel-janitors@vger.kernel.org,
        michal.lkml@markovi.net, yellowriver2010@hotmail.com,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cheng.shengyu@zte.com.cn, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [v5] Coccinelle: semantic code search for missing
	put_device()
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-938833334-1550304555=:3212
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 16 Feb 2019, wen.yang99@zte.com.cn wrote:

> >>> Does the first SmPL when specification include the case that a call
> >>> of the function “put_device” can occur within a branch of an if statement?
> >>
> >> It does include that,
> >
> >Thanks for this acknowledgement.
> >
> >So it seems that you find my interpretation of this bit of SmPL code appropriate.
> >
> >> but there is another execution path where the put device is not present.
> >
> >It is tried to find such cases.
> >
> >> But given the test in the if in the when code,
> >> on that execution path id is NULL, an so there is no need to put it.
> >
> >I would like to point out that the function “put_device” belongs also to
> >the category of functions which tolerate the passing of null pointers.
> >https://elixir.bootlin.com/linux/v5.0-rc6/source/drivers/base/core.c#L2053
> >https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/core.c?id=cb5b020a8d38f77209d0472a0fea755299a8ec78#n2053
> >
> >Have we got still different software development opinions about the need
> >for an extra pointer check in the “second” SmPL when specification?
>
> Thanks to Julia and Markus.
> We will modify the the if in the when code like this:
>
> @@ -22,7 +22,7 @@ if (id == NULL || ...) { ... return ...; }
>  ... when != put_device(&id->dev)
>      when != platform_device_put(id)
>      when != of_dev_put(id)
> -    when != if (id) { ... put_device(&id->dev) ... }
> +    when != if (...) { ... put_device(&id->dev) ... }

This looks ok.  You can check the old version and the new version and see
if there is any differencein the set of reports.

julia
--8323329-938833334-1550304555=:3212
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-938833334-1550304555=:3212--
